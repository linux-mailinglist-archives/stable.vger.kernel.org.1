Return-Path: <stable+bounces-226638-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OE2hLp+MuWnkJwIAu9opvQ
	(envelope-from <stable+bounces-226638-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:17:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6357A2AF40A
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 490263073045
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C343F7863;
	Tue, 17 Mar 2026 17:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rk5ZEgsq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87482373C18;
	Tue, 17 Mar 2026 17:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767582; cv=none; b=ml7AeLGpG0QAjp9TFFLwX4ZCbATWpC/aa/LCysn1MLYRvYR+1po1kZJMRLiYVU9QuRpYdLAMtmB+yM3VB+Oe1MO++okGP2rbJMpZdLCjbyGBbLAbIoBw3Jj3snwIV4/z2sbHtpbs2bLo2c5zSMnXNBs2lUK6B8YlZ719zlHA3Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767582; c=relaxed/simple;
	bh=Xp99AVQPzQARQJ3v/8yguMdpcg5i8JXvd8YHgnwnTk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nddc9KG8nrpDTiZehJsWZrFQRUXFerBuRYtLHQAPVLU5ag0qL32LkQqbPdS0NGoGEYlaebdLCp3tLXTTJLYovbsAZsQFg054pT0+KgBO6SiA5VNFD1uDffo071Ewj+aBVUNXsMfCbVLYWyUDwpf4bGSx4stbcxylaLx6JBzPq50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rk5ZEgsq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70AC0C4CEF7;
	Tue, 17 Mar 2026 17:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773767582;
	bh=Xp99AVQPzQARQJ3v/8yguMdpcg5i8JXvd8YHgnwnTk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rk5ZEgsqmhYSAJskCNakjogv5cUmdAoNfhaM4E8BwVGzWnmU/VsfCh0ctw8RuwSKV
	 Y5cVz5QsWgU/LfGpAJdQ5tbiytUAQHj3a1YwA5WC6uNq2mkD99h9d0VNggXsAWM0Ch
	 5KRPrLpl5G2eOBPUu5sGhIPRvtW3FSXJsFXct2Uo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	syzbot+c8287e65a57a89e7fb72@syzkaller.appspotmail.com,
	Alice Ryhl <aliceryhl@google.com>,
	Gary Guo <gary@garyguo.net>,
	Andreas Hindborg <a.hindborg@kernel.org>
Subject: [PATCH 6.18 117/333] rust_binder: call set_notification_done() without proc lock
Date: Tue, 17 Mar 2026 17:32:26 +0100
Message-ID: <20260317163003.705987488@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-226638-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,c8287e65a57a89e7fb72];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,appspotmail.com:email,garyguo.net:email]
X-Rspamd-Queue-Id: 6357A2AF40A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alice Ryhl <aliceryhl@google.com>

commit 2e303f0febb65a434040774b793ba8356698802b upstream.

Consider the following sequence of events on a death listener:
1. The remote process dies and sends a BR_DEAD_BINDER message.
2. The local process invokes the BC_CLEAR_DEATH_NOTIFICATION command.
3. The local process then invokes the BC_DEAD_BINDER_DONE.
Then, the kernel will reply to the BC_DEAD_BINDER_DONE command with a
BR_CLEAR_DEATH_NOTIFICATION_DONE reply using push_work_if_looper().

However, this can result in a deadlock if the current thread is not a
looper. This is because dead_binder_done() still holds the proc lock
during set_notification_done(), which called push_work_if_looper().
Normally, push_work_if_looper() takes the thread lock, which is fine to
take under the proc lock. But if the current thread is not a looper,
then it falls back to delivering the reply to the process work queue,
which involves taking the proc lock. Since the proc lock is already
held, this is a deadlock.

Fix this by releasing the proc lock during set_notification_done(). It
was not intentional that it was held during that function to begin with.

I don't think this ever happens in Android because BC_DEAD_BINDER_DONE
is only invoked in response to BR_DEAD_BINDER messages, and the kernel
always delivers BR_DEAD_BINDER to a looper. So there's no scenario where
Android userspace will call BC_DEAD_BINDER_DONE on a non-looper thread.

Cc: stable <stable@kernel.org>
Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
Reported-by: syzbot+c8287e65a57a89e7fb72@syzkaller.appspotmail.com
Tested-by: syzbot+c8287e65a57a89e7fb72@syzkaller.appspotmail.com
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Link: https://patch.msgid.link/20260224-binder-dead-binder-done-proc-lock-v1-1-bbe1b8a6e74a@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/android/binder/process.rs |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/android/binder/process.rs
+++ b/drivers/android/binder/process.rs
@@ -1259,7 +1259,8 @@ impl Process {
     }
 
     pub(crate) fn dead_binder_done(&self, cookie: u64, thread: &Thread) {
-        if let Some(death) = self.inner.lock().pull_delivered_death(cookie) {
+        let death = self.inner.lock().pull_delivered_death(cookie);
+        if let Some(death) = death {
             death.set_notification_done(thread);
         }
     }



