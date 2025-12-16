Return-Path: <stable+bounces-202371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB12CC320D
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 14:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 915B030542E3
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 13:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EB8343D64;
	Tue, 16 Dec 2025 12:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RgZqdHZ6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19C0344044;
	Tue, 16 Dec 2025 12:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765887679; cv=none; b=dbjR/lPJFc/Ixi9abxaXwx+WSbB8Wrl09a5xQkku95M1rBG9uJUNgvR5Kz/OEMrrXiFscyzbK2/4q5U8D+ghSlflwDiFIWE0i0/HiPRztTDPf9Q1lr/2AVtaO6/k7btoXV0ScpUaEqtOuxMQ9z67aOCKC2USJNw6vmiitrECMMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765887679; c=relaxed/simple;
	bh=hciRxpFMjI+Y2jv8FsDC59SnjJEa7x84AvbCGFhvLJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jZpJHcoS+EGP4r8rDzMMdlxbIBElfeLnQrxd+7jw07JkkRJR3lr9vO5MALPErMZqZZgC0QNo3nXzCBRmlcbQ5Urrb7cj99/aA2JZeX8f4dGMvrsrJ+ZqxTbtVtcTTRRT2YkZGcAbPijOZlG+a3UtiJaiNptliBycmmFieCVpX8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RgZqdHZ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C03C4CEF1;
	Tue, 16 Dec 2025 12:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765887679;
	bh=hciRxpFMjI+Y2jv8FsDC59SnjJEa7x84AvbCGFhvLJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RgZqdHZ6inHFG9UDX7f5Vm4fNXEQIgdaOTA0Hylt7DBFqOl/LBhVl8IvSlRpGjd72
	 5wd3N4Na529XXBEjOz5qbC8Fm2VmEVDBK9Qm45HpBLbAMnqnNAKZ5Tx6bSy6ydkTtq
	 jVv+UMbg/vQSUTgDGySSxgJkoofqP+sUYBWTHrIU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 304/614] arm64: dts: imx95-tqma9596sa: fix TPM5 pinctrl node name
Date: Tue, 16 Dec 2025 12:11:11 +0100
Message-ID: <20251216111412.383322518@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216111401.280873349@linuxfoundation.org>
References: <20251216111401.280873349@linuxfoundation.org>
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

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

[ Upstream commit 046cb64923e8c05a8fb656baffcd8c3fc67fb688 ]

tpm4grp will be overwritten. Fix node name

Fixes: 91d1ff322c47 ("arm64: dt: imx95: Add TQMa95xxSA")
Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi b/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi
index 180124cc5bce1..c3bb61ea67961 100644
--- a/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi
@@ -617,7 +617,7 @@ pinctrl_tpm4: tpm4grp {
 		fsl,pins = <IMX95_PAD_GPIO_IO05__TPM4_CH0			0x51e>;
 	};
 
-	pinctrl_tpm5: tpm4grp {
+	pinctrl_tpm5: tpm5grp {
 		fsl,pins = <IMX95_PAD_GPIO_IO06__TPM5_CH0			0x51e>;
 	};
 
-- 
2.51.0




