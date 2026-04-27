Return-Path: <stable+bounces-241299-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAsvCcdQ72kEAAEAu9opvQ
	(envelope-from <stable+bounces-241299-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 14:04:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 486EB4723B3
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 14:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1153A301DC31
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 11:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D55399039;
	Mon, 27 Apr 2026 11:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=smoch@web.de header.b="qgLSnrBO"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665BC2F39B4;
	Mon, 27 Apr 2026 11:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777291131; cv=none; b=kHIe9FQy7mnb2zUhDQDBxPufiW+wGuRtFhQKetrFaacbjaUgjAZMJkjVH98IS25ozUYQ0ghMoQ+a6rBFt6RU7giGX9Gq37Fpc3EWWS3YgcGrL+dvocPaCy9EOVbmJCFjHcz20YvO2eZZ0X+LV8ijVav+5LlCCRJykjgd+xK5w6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777291131; c=relaxed/simple;
	bh=sT7p1AOR4NHSCnt8HRgZeft4GbIzFKYA9NxPB4WqXM8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m2dMBnVBSNzW2TMEimtpMjV8zr40Vmurwngg22WKXzHfNTBQjukBZ6Ns2pP9cOTnLHe3YR4K0UzGALE/6ciFNqgMZnHgbNl0yub4JOK4+WwP1Hdw7wZRXKV4DAWqsOLCPEwn5Qf2OqoO+VjDyp4BaUSEM5kGfuf2a+fvO1K1RXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=smoch@web.de header.b=qgLSnrBO; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1777291095; x=1777895895; i=smoch@web.de;
	bh=2KhQ2G6x2J8Q5WZNMz2VfLJf1mtdAD7QrMdDraBgb4Q=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qgLSnrBOud8WRCG8cYHih31yCxXrl3T7678GqJc5ngwJPL2i2HCrQpnMv2wdJOc1
	 nZK4kRaGyhFEzmTk12KpLMA+tbQ1iLD/YF13jTSg8sxedrYX3zdHGCkrhZBaJRdXw
	 ZowW5sQBFvf4CDtWxijY+ZVtuVR1gNTIA+8ezna/9o4q0frq1W0gOb6oY1G2+hRO5
	 bVfWC5+Uyw0WpYEs0w/6hz3qd9nZg2E6G9smLbI/rXWzof3mQYDCl2DLQ3CQSo6cz
	 mCFWzWG61EYkoxpJsRqCMC3M50LcdkSAcE6Sezxdax215Wi9SGrtS+4BwGzYULgXa
	 IdYyXbitrs3kOxGOSw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MECGX-1w7Bb80ngr-00FReF; Mon, 27
 Apr 2026 13:58:15 +0200
From: Soeren Moch <smoch@web.de>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: Soeren Moch <smoch@web.de>,
	stable@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Fabio Estevam <festevam@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: imx6: Keep Root Port MSI capability also for i.MX6Q
Date: Mon, 27 Apr 2026 13:58:04 +0200
Message-ID: <20260427115804.134231-1-smoch@web.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:N2MpFZIlfk3KyZHhfVQqO31PNrFqNAiZ5+xuJ+1cNABwhjlgbny
 EgBHSjNosX9kh08YvdEEWuacI2c5fyXe9V0/kVgq3+0Q+Qx+hhfKxOwnmGOq4toyLxVq0C+
 eqw//AKE+TZof9iqKd7BPzCyAzbdzu6+lDvVatUNqWg3CzVqjTqqcZJHCV62HeZK4+xP5Te
 TCIAPI8PCpBOJ7OrA0xEA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PaQqfRxTQgo=;3YyMQwVtLJHEbSUtr9bb85v9t6b
 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
 xnvl9ce3N/352BQ==
X-Rspamd-Queue-Id: 486EB4723B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241299-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[web.de,vger.kernel.org,kernel.org,pengutronix.de,google.com,nxp.com,gmail.com,lists.infradead.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[web.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smoch@web.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[web.de:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:email,linux.dev:email,nxp.com:email]

Also on the NXP i.MX6Q chipset MSIs from the endpoints won't be received b=
y
the iMSI-RX MSI controller if the Root Port MSI capability is disabled.

Even though the Root Port MSIs won't be received by the iMSI-RX controller
due to design, this chipset has some weird hardware bug that prevents
the endpoint MSIs from reaching when the Root Port MSI capability is
disabled.

Hence, always keep the Root Port MSI capability for this chipset.

Note that by keeping Root Port MSI capability, Root Port MSIs such as AER,
PME and others won't be received by default. So users need to use
workarounds such as passing 'pcie_pme=3Dnomsi' cmdline param.

Fixes: 3a4e8302e72f ("PCI: imx6: Keep Root Port MSI capability with iMSI-R=
X to work around hardware bug")
Cc: <stable@vger.kernel.org> # 7.0.x
Signed-off-by: Soeren Moch <smoch@web.de>
=2D--
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: imx@lists.linux.dev
Cc: linux-kernel@vger.kernel.org

Tested on a tbs2910 board [1]
[1] arch/arm/boot/dts/nxp/imx/imx6q-tbs2910.dts
=2D--
 drivers/pci/controller/dwc/pci-imx6.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controlle=
r/dwc/pci-imx6.c
index 6d6a1688e7eb..3d461bdef967 100644
=2D-- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1865,7 +1865,8 @@ static const struct imx_pcie_drvdata drvdata[] =3D {
 		.flags =3D IMX_PCIE_FLAG_IMX_PHY |
 			 IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND |
 			 IMX_PCIE_FLAG_BROKEN_SUSPEND |
-			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
+			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND |
+			 IMX_PCIE_FLAG_KEEP_MSI_CAP,
 		.dbi_length =3D 0x200,
 		.gpr =3D "fsl,imx6q-iomuxc-gpr",
 		.ltssm_off =3D IOMUXC_GPR12,
=2D-=20
2.43.0


