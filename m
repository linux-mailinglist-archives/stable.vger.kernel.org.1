Return-Path: <stable+bounces-30816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F818892DC
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 08:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C4461F2F7F2
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 07:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E14A1C1399;
	Mon, 25 Mar 2024 00:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMaRRFjl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C531317D245;
	Sun, 24 Mar 2024 23:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323833; cv=none; b=oJJE8azvRuR3SX6ecQPUSDKvgtSC6VSPZdZLHgB+UenOUiVE84BGLg+bwzymYM9j0qsI0CFzqAW16ers3ZWYFFetJ8ajJ/gxN38VzPfYxcSAMFXT33Ld4G8NDSHkq+Bfmfs35YsKZjhJ4iHuhAnSXCdBgp5F5tDHKbvNeV0nUEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323833; c=relaxed/simple;
	bh=efOCXq90+FiYF3jVmbxC+XB+McMxSo9NkmUFKknDLCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CdTr9YyjQGpjSi/xw5i36L0q9B9ccFeXD3OFDn9MPDCrBhKgt+fCxzvwNIZJUUAOGSb32xwBjfrfe4/jA/6rMGX/4uE4jO/6mQITcp1nqqFgIoOKMf5ryP86YE3o9669Lfpzdh2BouPCdwhnQUgF54oF+dor3C0xIYVwWLo1t/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMaRRFjl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED40C433F1;
	Sun, 24 Mar 2024 23:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323833;
	bh=efOCXq90+FiYF3jVmbxC+XB+McMxSo9NkmUFKknDLCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TMaRRFjl18xt4jev16Rz653rirXwzBAOm3No1bWQz/xzzdUpJ2kPQaZLsJ9sUCz8X
	 6jkS15c1HPJto82blIaXL2Au+USU8rZG8Zb/Rm9gwTPLr+Zewd2BYFIph5H04VN6mH
	 kq8wi5mC7szZ86Ry9oB4NfYc3th6lGblo/fKY9LaOglHILFguk2b6UZBHM6Rqw9yO/
	 USG3fBlqo0YqYxa7XKp9vDKWl53TlYLH6hiSoIS1wWLPxujVAfUPV/wQwgLFNjroqU
	 SggxpoUiWl7AvjvIuChPJN+ZdC46k163QgXAMakwREwa33fdWTGFQboR7j9e2s8l/J
	 4p4KblG7O7DfA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Sam Protsenko <semen.protsenko@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 212/238] tty: serial: samsung: fix tx_empty() to return TIOCSER_TEMT
Date: Sun, 24 Mar 2024 19:40:00 -0400
Message-ID: <20240324234027.1354210-213-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Tudor Ambarus <tudor.ambarus@linaro.org>

[ Upstream commit 314c2b399288f0058a8c5b6683292cbde5f1531b ]

The core expects for tx_empty() either TIOCSER_TEMT when the tx is
empty or 0 otherwise. s3c24xx_serial_txempty_nofifo() might return
0x4, and at least uart_get_lsr_info() tries to clear exactly
TIOCSER_TEMT (BIT(1)). Fix tx_empty() to return TIOCSER_TEMT.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Link: https://lore.kernel.org/r/20240119104526.1221243-2-tudor.ambarus@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/samsung_tty.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index fa5b1321d9b15..5388eb7fa0f47 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -922,11 +922,10 @@ static unsigned int s3c24xx_serial_tx_empty(struct uart_port *port)
 		if ((ufstat & info->tx_fifomask) != 0 ||
 		    (ufstat & info->tx_fifofull))
 			return 0;
-
-		return 1;
+		return TIOCSER_TEMT;
 	}
 
-	return s3c24xx_serial_txempty_nofifo(port);
+	return s3c24xx_serial_txempty_nofifo(port) ? TIOCSER_TEMT : 0;
 }
 
 /* no modem control lines */
-- 
2.43.0


