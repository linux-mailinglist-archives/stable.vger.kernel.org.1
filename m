Return-Path: <stable+bounces-80830-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D560990BCA
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BB95B2A8EB
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 18:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695081E0DCE;
	Fri,  4 Oct 2024 18:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+GyUMTh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF4D1E0DAF;
	Fri,  4 Oct 2024 18:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066003; cv=none; b=eB0kumfKhM9HHkbLgg1RAD8KURlUmTeTZzI+Fb8zHUURK66AkYKmUal7DNMVvYnI3Q0Iy3G5NXOra8MZx4L2Z6h/++xnR4mVP4vRxTDvAnOP6Fipp76enPUAfJ9GjTnW5wQuWG2HDV/0Xsp24aFn8wyrpzkbVgGRn3LoNJySKv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066003; c=relaxed/simple;
	bh=OIdMz7HONHnDTTdnBElA5S8YW2qimUiMR6+XE75vAow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ldnTzR7V31YaKHukzSCzh4vLYvPcv4S0EMTe3KEUIrYON6rQSimKYTPOshq0c3Kt7aHz56p617/OwfHM7tRgx4SXk1KRXqLklzSGDfRSaV/i0ElAMVb8/5p0AcyMAAY6yeKjrvA9VIYWLjenIPdRTdr2w7LOcx5vkVTz6RzwRV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+GyUMTh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D220C4CECC;
	Fri,  4 Oct 2024 18:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066002;
	bh=OIdMz7HONHnDTTdnBElA5S8YW2qimUiMR6+XE75vAow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l+GyUMThBDPXcJ41NcQF1ItuB42QTxw5AJGU1IdZ7P4boRBXuNWJApL8dcHIjOKLI
	 1njnR57ripS+xKaDQNOVTpJUAtH1sdDa1DVPrw44qfP38+rMqdoSFycHotYy+SyKqP
	 x9KTNO04oBlkd1oIUYIc87uWLKOncfBcknOarXQhSvbKHjTg6gzEq3hQ2lv+a3xjE0
	 asW8281h9VLEItrvTaVYqkHCg4jZ/fPYQ5F5FMznriwm+vGcj9HGlb7q3rDbrH89ui
	 P8OYREudI5bNo3BT/20YEEYC//+HJv0EZr+ORR2r4sspkrrCuRSjxwcU/ybjIxImp1
	 dKEak9GyDDc/Q==
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
Subject: [PATCH AUTOSEL 6.11 50/76] serial: protect uart_port_dtr_rts() in uart_shutdown() too
Date: Fri,  4 Oct 2024 14:17:07 -0400
Message-ID: <20241004181828.3669209-50-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004181828.3669209-1-sashal@kernel.org>
References: <20241004181828.3669209-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.2
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
index 5bea3af46abce..9763fc5dcc80c 100644
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


