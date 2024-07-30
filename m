Return-Path: <stable+bounces-63967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC064941B7D
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D63C11C20CEA
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12A018990A;
	Tue, 30 Jul 2024 16:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tFds1hXQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A1D18991C;
	Tue, 30 Jul 2024 16:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722358537; cv=none; b=nihk3tMH6JZGA4XFkOv6dWgX23ndERGZvnNQaxMsNikgMCHB4B9gReSbKlpRmqZwCDYKBYU33m9FD2n4oo7tLzeVkwlHrInR3ZDn+k+mkMc9jL358zvvPEt0IPgPS//tdQz10q+t1z7GjiLi64orkJIg6iUZ/pK3p36YAEogCsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722358537; c=relaxed/simple;
	bh=XAiL/HuwbQnMXYRICHwtncm23io/xiL/LseeBx80zxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FfZ3+7+5EwGGdTPbS7oME+Nqom3c6j0VHdm0Pp6VFo+9KGFuf1k7S3wxjbkiWgSeQo6zYy8yDPekasWqak2ouTGIQVUMzjMTbIN4BWwL3yuGYzcpjtZwiiLK+TNfv8LTuAh8bCw3DJU+ZVhIQFoZjYWPtmtzWPymqhzGXgPCWkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tFds1hXQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4833C32782;
	Tue, 30 Jul 2024 16:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722358537;
	bh=XAiL/HuwbQnMXYRICHwtncm23io/xiL/LseeBx80zxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tFds1hXQqsuR7hmgMpUeTL2/iCj9k/CsevkM8KZ9y6I8eo8GCmf59SwAaWoCzjeDb
	 MHTh+E1wbkHH7NmbeN0i/w9dn2Fr1jxZLVBYEz9VUNNgro0H+O5bGxk94FALTN/CyO
	 ZEn+hd43S3Xc/2tBiA9tGA25LSfCvDMIt8shZTKU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 399/440] um: time-travel: fix signal blocking race/hang
Date: Tue, 30 Jul 2024 17:50:32 +0200
Message-ID: <20240730151631.386573917@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151615.753688326@linuxfoundation.org>
References: <20240730151615.753688326@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 2cf3a3c4b84def5406b830452b1cb8bbfffe0ebe ]

When signals are hard-blocked in order to do time-travel
socket processing, we set signals_blocked and then handle
SIGIO signals by setting the SIGIO bit in signals_pending.
When unblocking, we first set signals_blocked to 0, and
then handle all pending signals. We have to set it first,
so that we can again properly block/unblock inside the
unblock, if the time-travel handlers need to be processed.

Unfortunately, this is racy. We can get into this situation:

// signals_pending = SIGIO_MASK

unblock_signals_hard()
   signals_blocked = 0;
   if (signals_pending && signals_enabled) {
     block_signals();
     unblock_signals()
       ...
       sig_handler_common(SIGIO, NULL, NULL);
         sigio_handler()
           ...
           sigio_reg_handler()
             irq_do_timetravel_handler()
               reg->timetravel_handler() ==
               vu_req_interrupt_comm_handler()
                 vu_req_read_message()
                   vhost_user_recv_req()
                     vhost_user_recv()
                       vhost_user_recv_header()
                         // reads 12 bytes header of
                         // 20 bytes message
<-- receive SIGIO here <--
sig_handler()
   int enabled = signals_enabled; // 1
   if ((signals_blocked || !enabled) && (sig == SIGIO)) {
     if (!signals_blocked && time_travel_mode == TT_MODE_EXTERNAL)
       sigio_run_timetravel_handlers()
         _sigio_handler()
           sigio_reg_handler()
             ... as above ...
               vhost_user_recv_header()
                 // reads 8 bytes that were message payload
                 // as if it were header - but aborts since
                 // it then gets -EAGAIN
...
--> end signal handler -->
                       // continue in vhost_user_recv()
                       // full_read() for 8 bytes payload busy loops
                       // entire process hangs here

Conceptually, to fix this, we need to ensure that the
signal handler cannot run while we hard-unblock signals.
The thing that makes this more complex is that we can be
doing hard-block/unblock while unblocking. Introduce a
new signals_blocked_pending variable that we can keep at
non-zero as long as pending signals are being processed,
then we only need to ensure it's decremented safely and
the signal handler will only increment it if it's already
non-zero (or signals_blocked is set, of course.)

Note also that only the outermost call to hard-unblock is
allowed to decrement signals_blocked_pending, since it
could otherwise reach zero in an inner call, and leave
the same race happening if the timetravel_handler loops,
but that's basically required of it.

Fixes: d6b399a0e02a ("um: time-travel/signals: fix ndelay() in interrupt")
Link: https://patch.msgid.link/20240703110144.28034-2-johannes@sipsolutions.net
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/os-Linux/signal.c | 118 +++++++++++++++++++++++++++++++-------
 1 file changed, 98 insertions(+), 20 deletions(-)

diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 24a403a70a020..850d21e6473ee 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -8,6 +8,7 @@
 
 #include <stdlib.h>
 #include <stdarg.h>
+#include <stdbool.h>
 #include <errno.h>
 #include <signal.h>
 #include <string.h>
@@ -65,9 +66,7 @@ static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
 
 int signals_enabled;
 #ifdef UML_CONFIG_UML_TIME_TRAVEL_SUPPORT
-static int signals_blocked;
-#else
-#define signals_blocked 0
+static int signals_blocked, signals_blocked_pending;
 #endif
 static unsigned int signals_pending;
 static unsigned int signals_active = 0;
@@ -76,14 +75,27 @@ void sig_handler(int sig, struct siginfo *si, mcontext_t *mc)
 {
 	int enabled = signals_enabled;
 
-	if ((signals_blocked || !enabled) && (sig == SIGIO)) {
+#ifdef UML_CONFIG_UML_TIME_TRAVEL_SUPPORT
+	if ((signals_blocked ||
+	     __atomic_load_n(&signals_blocked_pending, __ATOMIC_SEQ_CST)) &&
+	    (sig == SIGIO)) {
+		/* increment so unblock will do another round */
+		__atomic_add_fetch(&signals_blocked_pending, 1,
+				   __ATOMIC_SEQ_CST);
+		return;
+	}
+#endif
+
+	if (!enabled && (sig == SIGIO)) {
 		/*
 		 * In TT_MODE_EXTERNAL, need to still call time-travel
-		 * handlers unless signals are also blocked for the
-		 * external time message processing. This will mark
-		 * signals_pending by itself (only if necessary.)
+		 * handlers. This will mark signals_pending by itself
+		 * (only if necessary.)
+		 * Note we won't get here if signals are hard-blocked
+		 * (which is handled above), in that case the hard-
+		 * unblock will handle things.
 		 */
-		if (!signals_blocked && time_travel_mode == TT_MODE_EXTERNAL)
+		if (time_travel_mode == TT_MODE_EXTERNAL)
 			sigio_run_timetravel_handlers();
 		else
 			signals_pending |= SIGIO_MASK;
@@ -380,33 +392,99 @@ int um_set_signals_trace(int enable)
 #ifdef UML_CONFIG_UML_TIME_TRAVEL_SUPPORT
 void mark_sigio_pending(void)
 {
+	/*
+	 * It would seem that this should be atomic so
+	 * it isn't a read-modify-write with a signal
+	 * that could happen in the middle, losing the
+	 * value set by the signal.
+	 *
+	 * However, this function is only called when in
+	 * time-travel=ext simulation mode, in which case
+	 * the only signal ever pending is SIGIO, which
+	 * is blocked while this can be called, and the
+	 * timer signal (SIGALRM) cannot happen.
+	 */
 	signals_pending |= SIGIO_MASK;
 }
 
 void block_signals_hard(void)
 {
-	if (signals_blocked)
-		return;
-	signals_blocked = 1;
+	signals_blocked++;
 	barrier();
 }
 
 void unblock_signals_hard(void)
 {
+	static bool unblocking;
+
 	if (!signals_blocked)
+		panic("unblocking signals while not blocked");
+
+	if (--signals_blocked)
 		return;
-	/* Must be set to 0 before we check the pending bits etc. */
-	signals_blocked = 0;
+	/*
+	 * Must be set to 0 before we check pending so the
+	 * SIGIO handler will run as normal unless we're still
+	 * going to process signals_blocked_pending.
+	 */
 	barrier();
 
-	if (signals_pending && signals_enabled) {
-		/* this is a bit inefficient, but that's not really important */
-		block_signals();
-		unblock_signals();
-	} else if (signals_pending & SIGIO_MASK) {
-		/* we need to run time-travel handlers even if not enabled */
-		sigio_run_timetravel_handlers();
+	/*
+	 * Note that block_signals_hard()/unblock_signals_hard() can be called
+	 * within the unblock_signals()/sigio_run_timetravel_handlers() below.
+	 * This would still be prone to race conditions since it's actually a
+	 * call _within_ e.g. vu_req_read_message(), where we observed this
+	 * issue, which loops. Thus, if the inner call handles the recorded
+	 * pending signals, we can get out of the inner call with the real
+	 * signal hander no longer blocked, and still have a race. Thus don't
+	 * handle unblocking in the inner call, if it happens, but only in
+	 * the outermost call - 'unblocking' serves as an ownership for the
+	 * signals_blocked_pending decrement.
+	 */
+	if (unblocking)
+		return;
+	unblocking = true;
+
+	while (__atomic_load_n(&signals_blocked_pending, __ATOMIC_SEQ_CST)) {
+		if (signals_enabled) {
+			/* signals are enabled so we can touch this */
+			signals_pending |= SIGIO_MASK;
+			/*
+			 * this is a bit inefficient, but that's
+			 * not really important
+			 */
+			block_signals();
+			unblock_signals();
+		} else {
+			/*
+			 * we need to run time-travel handlers even
+			 * if not enabled
+			 */
+			sigio_run_timetravel_handlers();
+		}
+
+		/*
+		 * The decrement of signals_blocked_pending must be atomic so
+		 * that the signal handler will either happen before or after
+		 * the decrement, not during a read-modify-write:
+		 *  - If it happens before, it can increment it and we'll
+		 *    decrement it and do another round in the loop.
+		 *  - If it happens after it'll see 0 for both signals_blocked
+		 *    and signals_blocked_pending and thus run the handler as
+		 *    usual (subject to signals_enabled, but that's unrelated.)
+		 *
+		 * Note that a call to unblock_signals_hard() within the calls
+		 * to unblock_signals() or sigio_run_timetravel_handlers() above
+		 * will do nothing due to the 'unblocking' state, so this cannot
+		 * underflow as the only one decrementing will be the outermost
+		 * one.
+		 */
+		if (__atomic_sub_fetch(&signals_blocked_pending, 1,
+				       __ATOMIC_SEQ_CST) < 0)
+			panic("signals_blocked_pending underflow");
 	}
+
+	unblocking = false;
 }
 #endif
 
-- 
2.43.0




