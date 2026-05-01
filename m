Return-Path: <stable+bounces-242248-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFnSEIZv9GmKBQIAu9opvQ
	(envelope-from <stable+bounces-242248-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 11:16:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A45724AB3AB
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 11:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4722C3019141
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 09:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A523803E3;
	Fri,  1 May 2026 09:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hd8kzN+b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4413037FF65
	for <stable@vger.kernel.org>; Fri,  1 May 2026 09:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777626994; cv=none; b=QMY1/hs1ZfmkX9u+Lsm0IxxI3mPYxt3/2wm989uFsD6rErfdF5499PowEJ7mW01dzhCCxBUFDcIcDT/fJTaZ7zaePh7b0+bO+ADtR647RJDx/OKVXdXnyokyDRHaZmzEiwXqtqwzg+SDvbuspuTR/OKBieXQ0NOybSzIH8Y8PzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777626994; c=relaxed/simple;
	bh=49HKBn5I18pTC4rE/J6ItuGG2p14ap5zYkq6ylATXYc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TuJQL/qN4w1NVmYs+LNYTaKybXtvazlxOjj1XoIPEzenhKdvq/wGIR8Db50k1zifYlYngHIhLQeJbjprOmzGfo8Z8QtLzuZvdqsqEsm35ro4G4VR25tyLOn8DJK9Py0yhgOkSHTLzTfBFCr9RLpXNT/Vgty9El+C//JliG6jAig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Hd8kzN+b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5E9C2BCB4;
	Fri,  1 May 2026 09:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777626993;
	bh=49HKBn5I18pTC4rE/J6ItuGG2p14ap5zYkq6ylATXYc=;
	h=Subject:To:Cc:From:Date:From;
	b=Hd8kzN+b0Q34ufbYHPgvO1M8ACDvFGHZLMlExomVmDQtx4Xti86VxfOu+p/jRJAae
	 7fWc9bq4rLyRD2VSreO4WnERSDUZlm8+QDrBogM6XLFlH+az0R54OQtYrbx7bjVaXY
	 a6YIr1K7WiRTU2dvyPnKtTGd1xwjwr5bJGsoZAL0=
Subject: FAILED: patch "[PATCH] phy: qcom: m31-eusb2: clear PLL_EN during init" failed to apply to 6.18-stable tree
To: elson.serrao@oss.qualcomm.com,konrad.dybcio@oss.qualcomm.com,vkoul@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 01 May 2026 11:16:31 +0200
Message-ID: <2026050131-exfoliate-garter-519b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A45724AB3AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242248-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email,qualcomm.com:email]


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 520a98bdf7ae0130e22d8adced3d69a2e211b41f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050131-exfoliate-garter-519b@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 520a98bdf7ae0130e22d8adced3d69a2e211b41f Mon Sep 17 00:00:00 2001
From: Elson Serrao <elson.serrao@oss.qualcomm.com>
Date: Tue, 17 Feb 2026 12:11:30 -0800
Subject: [PATCH] phy: qcom: m31-eusb2: clear PLL_EN during init

The driver currently sets bit 0 of USB_PHY_CFG1 (PLL_EN) during PHY
initialization. According to the M31 EUSB2 PHY hardware documentation,
this bit is intended only for test/debug scenarios and does not control
mission mode operation. Keeping PLL_EN asserted causes the PHY to draw
additional current during USB bus suspend. Clearing this bit results in
lower suspend power consumption without affecting normal operation.

Update the driver to leave PLL_EN cleared as recommended by the hardware
documentation.

Fixes: 9c8504861cc4 ("phy: qcom: Add M31 based eUSB2 PHY driver")
Cc: stable@vger.kernel.org
Signed-off-by: Elson Serrao <elson.serrao@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Link: https://patch.msgid.link/20260217201130.2804550-1-elson.serrao@oss.qualcomm.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>

diff --git a/drivers/phy/qualcomm/phy-qcom-m31-eusb2.c b/drivers/phy/qualcomm/phy-qcom-m31-eusb2.c
index 95cd3175926d..68f1ba8fec4a 100644
--- a/drivers/phy/qualcomm/phy-qcom-m31-eusb2.c
+++ b/drivers/phy/qualcomm/phy-qcom-m31-eusb2.c
@@ -83,7 +83,7 @@ static const struct m31_phy_tbl_entry m31_eusb2_setup_tbl[] = {
 	M31_EUSB_PHY_INIT_CFG(USB_PHY_CFG0, UTMI_PHY_CMN_CTRL_OVERRIDE_EN, 1),
 	M31_EUSB_PHY_INIT_CFG(USB_PHY_UTMI_CTRL5, POR, 1),
 	M31_EUSB_PHY_INIT_CFG(USB_PHY_HS_PHY_CTRL_COMMON0, PHY_ENABLE, 1),
-	M31_EUSB_PHY_INIT_CFG(USB_PHY_CFG1, PLL_EN, 1),
+	M31_EUSB_PHY_INIT_CFG(USB_PHY_CFG1, PLL_EN, 0),
 	M31_EUSB_PHY_INIT_CFG(USB_PHY_FSEL_SEL, FSEL_SEL, 1),
 };
 


