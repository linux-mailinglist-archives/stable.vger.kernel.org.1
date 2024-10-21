Return-Path: <stable+bounces-87227-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC9F9A63DB
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 12:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9623A284768
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 10:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32051E9097;
	Mon, 21 Oct 2024 10:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZEiKLKoJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFBF1E570A;
	Mon, 21 Oct 2024 10:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729506974; cv=none; b=jZZCUCfBC0j+5WrASgyNAEfCkWKBqf2QvsY3n8YjbHgjQiQUMbN94XZDUB6asle3x4hBQAw6093RhA77xbxMas2zHiO/FvdcZJsxA0qG9ZvhG7UxICNBF0y/VwYfiVqbtj0noe1w6ah+YuIFzzz9S2kbe2S9AKzYfTLQ09/kJOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729506974; c=relaxed/simple;
	bh=nSTy/DFOizvExdmzTBqftLrU453T8fDzyFXk0fZ6Ky4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RV7/PRVZSNcgCX+A9eSacGYAfwreMWSav3lBW6xlWU3ySK6DZXUxJoag06h7hgbpydz20U/WqnNgVyoQdCsINtKCNj6iKvIqdfbPhf0bPQU9sIcNKFXd8+3ewf/KESPN9uLF7M8H6L7lrHJlnip/Y7ZtSfs/2PHgBNGMMan0X+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZEiKLKoJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2C5C4CEC7;
	Mon, 21 Oct 2024 10:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729506974;
	bh=nSTy/DFOizvExdmzTBqftLrU453T8fDzyFXk0fZ6Ky4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZEiKLKoJeTtC8/x0AoVxGNxp+RBbvQBHuUCGABB0QpujvlVyEkIOPM/aV+F3ewbsy
	 8CA5lsJ5TZcjdi22mXs1EJ0FcGiTt9df9JKe2jDAhdc9OUZD56Vd/90m/TJTO5xjIh
	 PitPLcRmE2o2K3s760pc5cLhVbMb3cQRtbuLmLEY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s@web.codeaurora.org,
	=20Bence?= <csokas.bence@prolan.hu>, Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6 047/124] net: fec: Remove duplicated code
Date: Mon, 21 Oct 2024 12:24:11 +0200
Message-ID: <20241021102258.548728332@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241021102256.706334758@linuxfoundation.org>
References: <20241021102256.706334758@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Csókás, Bence <csokas.bence@prolan.hu>

commit 713ebaed68d88121cbaf5e74104e2290a9ea74bd upstream.

`fec_ptp_pps_perout()` reimplements logic already
in `fec_ptp_read()`. Replace with function call.

Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/20240812094713.2883476-2-csokas.bence@prolan.hu
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/freescale/fec_ptp.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -235,13 +235,7 @@ static int fec_ptp_pps_perout(struct fec
 	timecounter_read(&fep->tc);
 
 	/* Get the current ptp hardware time counter */
-	temp_val = readl(fep->hwp + FEC_ATIME_CTRL);
-	temp_val |= FEC_T_CTRL_CAPTURE;
-	writel(temp_val, fep->hwp + FEC_ATIME_CTRL);
-	if (fep->quirks & FEC_QUIRK_BUG_CAPTURE)
-		udelay(1);
-
-	ptp_hc = readl(fep->hwp + FEC_ATIME);
+	ptp_hc = fec_ptp_read(&fep->cc);
 
 	/* Convert the ptp local counter to 1588 timestamp */
 	curr_time = timecounter_cyc2time(&fep->tc, ptp_hc);



