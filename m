Return-Path: <stable+bounces-80966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E61990D54
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 21:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 204951F2298E
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F5D20899F;
	Fri,  4 Oct 2024 18:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lm69bqRO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61B7208996;
	Fri,  4 Oct 2024 18:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066376; cv=none; b=knWbx3AGIvf0fMC/aYzJnC+H3ktgt38D9420zcD98UFNCpmtATx6dZq9z4YP+kLvuAy2hmue+fudu4b4Z0xRu0V8OC52an/8w5U7Vf/j8SVlHluel3FMoIGbnYjO2Hih6tyjsLDaKppurDUQ+1GtrZDjuXxr28dQfcA74/CJJVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066376; c=relaxed/simple;
	bh=NJGnrY2RZc9Cv8MR8oKVCHBB63DJZbvM1YsLKGc3Ky8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JVT54Xvq868DnI1WMo9ChnaMKNEJusKJU4IMFMdIMmTo77AY9ALsengR4rJXd/+v8ez1dbLwFw3H5dCWzsFg8ZVmQ4y/hZ83TxH4s6YqiUK2Ue4kWzJ0u3bsYwLrvqv8sVmFDBhsD6Z3CR4NWCBu3eRaYjHsg2s805hgxGs06i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lm69bqRO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 860FCC4CECC;
	Fri,  4 Oct 2024 18:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066375;
	bh=NJGnrY2RZc9Cv8MR8oKVCHBB63DJZbvM1YsLKGc3Ky8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lm69bqROadMUNOYc9pNroxlSkJrwLN7ri5NuozjNXo0wBUUzVRlAIrs393UC1+WcA
	 Chh5qncFWfZt0Uj5Tt2n2BbeqXkXjN9ZJcenQRDMzxgghyCCSC3Oo98DZCdWer1JDD
	 +zu4/704ddlWXhb3QxbN7yEJr4E7TV5pwcKSyoE+mlWm+lgqfSu1bNfCUa+hVDaMuZ
	 0A56fQ1hYx7qHjaCoDgSsIQyP0ktdtvQ2mNVDfuXgP6viM/gZ/6wMTjaVAvZq1btNP
	 ZCFi5T15YkEOfCcXxTp96bNmpnJWd7aoMdWl92xW2OZxWVJEESu5B1PvWHzZQuXpot
	 Y8yCUBXDIIGUQ==
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
Subject: [PATCH AUTOSEL 6.6 40/58] serial: protect uart_port_dtr_rts() in uart_shutdown() too
Date: Fri,  4 Oct 2024 14:24:13 -0400
Message-ID: <20241004182503.3672477-40-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182503.3672477-1-sashal@kernel.org>
References: <20241004182503.3672477-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.54
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
index ed8798fdf522a..d7c59d690a74d 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -374,14 +374,16 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
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


