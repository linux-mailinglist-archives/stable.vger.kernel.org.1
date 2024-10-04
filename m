Return-Path: <stable+bounces-80902-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89122990C8D
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB1351C22632
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 18:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7632E1F941C;
	Fri,  4 Oct 2024 18:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUBOxwhZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CFB1F9414;
	Fri,  4 Oct 2024 18:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066210; cv=none; b=pr1dJFlX2+NqrtnDn1xaGc4FOQQlWHMkbtR1sWdIcKVgYKVjPnRV+kAb+UXAkFo1LZ6kWDlgj1dfoIjH4lkl+CbifMjz0ghh6IuUc4N0P2dBXShSGSx3vl8nF0mJqO0VbHczaYcJx/JGlpEoT1uL30qwaKFvbmF7y6hnDC28zQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066210; c=relaxed/simple;
	bh=oB/xfsbQWtP1t80oPNfDpypV217aBFCJCfzVqiYBLxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hejt0clzE1ASjWHU+UtpRp3DfaV1JuuoqLnOTbFtRObr3jpKko7oRbXqsdHAtZMMei8RHGJQFbWQwoLCBUhfnjJQdmQJEAwVfraiq8ystpWGz4ZYcq2q/GMQ2q35BvZgQkNuctfYsLY81aQFvE1RgfJHK6fN9AK6EyHY+urxQJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUBOxwhZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C87C4CEC6;
	Fri,  4 Oct 2024 18:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066210;
	bh=oB/xfsbQWtP1t80oPNfDpypV217aBFCJCfzVqiYBLxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MUBOxwhZGw9nIX6gmBKe6u6QTpqjV047W74Ox1YR/CAxHJBMC7pUlKk7djUWcTndS
	 jXX4T/IJqtrSbIjq7VgNQSN8ARyDX3eoqjvppHBNL9rCaqSReqJcapgCkAKwYk/Jh6
	 8TCffIrfRcMM8MPm0dsxydiz9LZBJWq27Z2RWlWBe4f5rdHSwkublSD9emLb8pGBoq
	 wvJNZSmLywEyoDOAOw3irR+d3ImFQaGZQwxIfG0WmWS4ANttPiBL9pxcb4fPnjNSJu
	 vC7OQuZYlaIIdzubN2ucLAcFrt3aZYSnrxD8xQ8p8Hs/6l5tOYchN+niFqlQyu4Dge
	 a0uKQq31/uRBw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Peter Hurley <peter@hurleysoftware.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	tony.lindgren@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	l.sanfilippo@kunbus.com,
	pcc@google.com,
	linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 46/70] serial: protect uart_port_dtr_rts() in uart_shutdown() too
Date: Fri,  4 Oct 2024 14:20:44 -0400
Message-ID: <20241004182200.3670903-46-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182200.3670903-1-sashal@kernel.org>
References: <20241004182200.3670903-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.13
Content-Transfer-Encoding: 8bit

From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>

[ Upstream commit 602babaa84d627923713acaf5f7e9a4369e77473 ]

Commit af224ca2df29 (serial: core: Prevent unsafe uart port access, part
3) added few uport == NULL checks. It added one to uart_shutdown(), so
the commit assumes, uport can be NULL in there. But right after that
protection, there is an unprotected "uart_port_dtr_rts(uport, false);"
call. That is invoked only if HUPCL is set, so I assume that is the
reason why we do not see lots of these reports.

Or it cannot be NULL at this point at all for some reason :P.

Until the above is investigated, stay on the safe side and move this
dereference to the if too.

I got this inconsistency from Coverity under CID 1585130. Thanks.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/r/20240805102046.307511-3-jirislaby@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/serial_core.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 9967444eae10c..dcd04db0e3eee 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -407,14 +407,16 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
 		/*
 		 * Turn off DTR and RTS early.
 		 */
-		if (uport && uart_console(uport) && tty) {
-			uport->cons->cflag = tty->termios.c_cflag;
-			uport->cons->ispeed = tty->termios.c_ispeed;
-			uport->cons->ospeed = tty->termios.c_ospeed;
-		}
+		if (uport) {
+			if (uart_console(uport) && tty) {
+				uport->cons->cflag = tty->termios.c_cflag;
+				uport->cons->ispeed = tty->termios.c_ispeed;
+				uport->cons->ospeed = tty->termios.c_ospeed;
+			}
 
-		if (!tty || C_HUPCL(tty))
-			uart_port_dtr_rts(uport, false);
+			if (!tty || C_HUPCL(tty))
+				uart_port_dtr_rts(uport, false);
+		}
 
 		uart_port_shutdown(port);
 	}
-- 
2.43.0


