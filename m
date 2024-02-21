Return-Path: <stable+bounces-22034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0216085D9CD
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9245D1F2361C
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 13:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAC178B7C;
	Wed, 21 Feb 2024 13:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KbrF4OvH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A2253816;
	Wed, 21 Feb 2024 13:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708521746; cv=none; b=PXTBNOBv3plGFSsAISet9NA8VN0A5M5zvJiUNRCWioFZWKTv+zBLHYwzOE+Ym+itubom0ICpxh/AYkCMuf9kmD3QwX0z2tkrt5SYAw9eCYmV9QYpJgp9Yy7khjEYosTXyA0imEk4Ve16AIZDHQk2VagD+vfvvD5JsSyL4j4fG6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708521746; c=relaxed/simple;
	bh=XYK1/oOTHMlLyMp8ocu40SQ4xn1rYKSVyUhlmLaFbbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U7T8MFVtAQFBvB8/r5qytEVTHtAXcEa8WV2kCVwrMu50u9tP3hCtk79701ogjJs2oXvpW9bakr4KrosfmOOdLXBLyuicMewf1PXzESAQl8wlT1eHfj7oBEOVrNNTABxp15tXw8ESXFlWE+UbZQedDTn5/dH4MdyEbUvVJTnuJv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KbrF4OvH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BCCBC433C7;
	Wed, 21 Feb 2024 13:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708521746;
	bh=XYK1/oOTHMlLyMp8ocu40SQ4xn1rYKSVyUhlmLaFbbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KbrF4OvHWp9ky6rpXTDqjlENRgaRHOo0jxTUFR3vJk6n9bXUdqVDLAzciMIcuCwUz
	 OiMTUdMg8mHTDU2Ms957dKWXswgBQXfzBYO1Z4bxqvZCJx+TD46WCn8fCpYa5PYQ3l
	 /2mP9dyI1ugUug8QlZItP7Zf20PAJ5RiLh4YQB1c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Basilio <daniel.basilio@corigine.com>,
	Louis Peens <louis.peens@corigine.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 194/202] nfp: use correct macro for LengthSelect in BAR config
Date: Wed, 21 Feb 2024 14:08:15 +0100
Message-ID: <20240221125938.056072485@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221125931.742034354@linuxfoundation.org>
References: <20240221125931.742034354@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Basilio <daniel.basilio@corigine.com>

commit b3d4f7f2288901ed2392695919b3c0e24c1b4084 upstream.

The 1st and 2nd expansion BAR configuration registers are configured,
when the driver starts up, in variables 'barcfg_msix_general' and
'barcfg_msix_xpb', respectively. The 'LengthSelect' field is ORed in
from bit 0, which is incorrect. The 'LengthSelect' field should
start from bit 27.

This has largely gone un-noticed because
NFP_PCIE_BAR_PCIE2CPP_LengthSelect_32BIT happens to be 0.

Fixes: 4cb584e0ee7d ("nfp: add CPP access core")
Cc: stable@vger.kernel.org # 4.11+
Signed-off-by: Daniel Basilio <daniel.basilio@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c
+++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c
@@ -571,11 +571,13 @@ static int enable_bars(struct nfp6000_pc
 	const u32 barcfg_msix_general =
 		NFP_PCIE_BAR_PCIE2CPP_MapType(
 			NFP_PCIE_BAR_PCIE2CPP_MapType_GENERAL) |
-		NFP_PCIE_BAR_PCIE2CPP_LengthSelect_32BIT;
+		NFP_PCIE_BAR_PCIE2CPP_LengthSelect(
+			NFP_PCIE_BAR_PCIE2CPP_LengthSelect_32BIT);
 	const u32 barcfg_msix_xpb =
 		NFP_PCIE_BAR_PCIE2CPP_MapType(
 			NFP_PCIE_BAR_PCIE2CPP_MapType_BULK) |
-		NFP_PCIE_BAR_PCIE2CPP_LengthSelect_32BIT |
+		NFP_PCIE_BAR_PCIE2CPP_LengthSelect(
+			NFP_PCIE_BAR_PCIE2CPP_LengthSelect_32BIT) |
 		NFP_PCIE_BAR_PCIE2CPP_Target_BaseAddress(
 			NFP_CPP_TARGET_ISLAND_XPB);
 	const u32 barcfg_explicit[4] = {



