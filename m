Return-Path: <stable+bounces-165657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B17B17145
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 14:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34C004E1F24
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 12:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D3F2C15BE;
	Thu, 31 Jul 2025 12:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=open-e.com header.i=artur.piechocki@open-e.com header.b="B3zbBdcU"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C57D2C158B
	for <stable@vger.kernel.org>; Thu, 31 Jul 2025 12:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753965003; cv=none; b=e/PMjsudh9igZ74K9sY9/FpmKVW0ZjYFNpGvSParGRH59ExbjX5lEwtP41K2/+AOHSonZ6p3/qZd/97b0pMZysTi25lmhPxxb1xJQ3cM0kXb7jHY7A8HH/c1iLQHa8Rz3yhiIljd/koeE6XYsdH7EyQ+w4UV+wogbgIEggtIxDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753965003; c=relaxed/simple;
	bh=L8d/TgfaemUz00R0wLDmWJx06bp9OFZCE3k9bJVgyr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DB/zgyxmwFTt7gPtdHhsf/1t3FkcfWeV+34CuqxHUAz0u+OVxHzq1b00DvLR4UkGryHBsJiFFH6pgYAE8kAX1tXuoD1bXPZmjt7l+TKdE20YKcErkw+eWI/wtbpP4hKk9/9B8S2B4MHR2ZnhmH0M2SWeQkWOWeE7lSZM/O2el4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=open-e.com; spf=pass smtp.mailfrom=open-e.com; dkim=pass (2048-bit key) header.d=open-e.com header.i=artur.piechocki@open-e.com header.b=B3zbBdcU; arc=none smtp.client-ip=217.72.192.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=open-e.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-e.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=open-e.com;
	s=s1-ionos; t=1753964995; x=1754569795;
	i=artur.piechocki@open-e.com;
	bh=M9BXKtvY5DWPgIo4RHN98DZ3dEdRGdWC+qZAUcM5y6c=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=B3zbBdcUFi1bb5ybCQmCY6Cidlvp2LSFB/ImTKdpaaR8uwG2UInjCEoZQh20g0PJ
	 m0Yzdq/auNZ4n1sKB1OTWhEBfAnibQtnu6pNmjU1rUuYc8cK+ERh/a9pwDj4XAmox
	 0guXY7zJex4lqdH/oW7rNYUzkXp540FVxJmc9hogWVco/ZCVPvZx5IufeCwJbLpCT
	 brd+uicWXYzRpH+l6nzsEpxLTCYAsBq9V29THq/tGOjqhd1SRUVfvC+FemLGlsOWe
	 V+7L9AYvVYvUV1To770Avtb0rk/aZECh18A3j0/SD82ChHfEjavwBerxB9gJbNfaz
	 2x/ute67dHaM3Qu3/Q==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from rato-hp ([193.25.251.95]) by mrelayeu.kundenserver.de (mreue106
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MtOX2-1uOI8q3q8c-0120SK; Thu, 31
 Jul 2025 14:29:55 +0200
From: Artur Piechocki <artur.piechocki@open-e.com>
To: artur.piechocki@open-e.com
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>,
	stable@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH] PCI: vmd: Assign VMD IRQ domain before enumeration
Date: Thu, 31 Jul 2025 14:29:41 +0200
Message-ID: <20250731122941.23458-1-artur.piechocki@open-e.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:N0OK+COuhMSaZwjfMAOBeO4HLi+7hzXbWxe9J6Q+D9ZAO8IZmvy
 +lkqpJCWBzKHRAA08a/y0htmUvsXt4i1HzY0YX8htC051CHyZKQC1skdMZpUDJi4RnBYd+q
 aDJPSjsTZblwIIqhfc0lOrMqqL014t27qLjXoP4/yca5FCUJ0BmzM3/2AGsYlcjry7n/0Tn
 g30Hg3BamYsvDezL6S3fA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pJWPNorlLdk=;sl70FvV4quHCMyx69mLhwrJTtyr
 yPJQmITqs5OjSaHZF8hsb85RqvJ2UwffomxAiiLJkPAFhgE1THxgxlKBRNs/iCfe2ztnGABRD
 eSsdSAuPTL9dZdzYD2qek2Hn8BGBKUQlVo3cJAx80inHPaq7Ob+xOfuT34FzSfggboc8zBS3Y
 j3oz51qEgn/+CXDP2PYR5Y5RT8CMDsOqNrWX6dTFIdjvfIwXDGFK4wm5CpeVnRZXn8upB56jI
 kLeubRk46sj0RNnD0MqP09J8ux2g1FiiiQi01I/PtpT4kAGxmTTC8778KniZqOV9GycSB3lon
 y0rJFS1rQpxboQJXgKWFwpy9E/Zq2Gmg/8Z4itEv2EXLCbLUP521sRHpKLT156Q/McxIFZob4
 PavHk02xCHYikVGUcvCU9lTjtw/BeUDLLVgcY/AT8f7+UGegJpqPR05WOuUhufpweKiPfMDIc
 nkGitxXfmuNPy0F8KJGYYyO8vmCSSmglrETtiIX9zzolKKCNCfoaB8//QYm24H9MYoHT/jP9+
 b+7v90ZVPrrtntlC7r9mO7OtNWGduc1Fw5M4Mb5oF8wk/iVbrrTIujbANDd3bDRgibGG24OP4
 3Y9eohXMnOhdxSpkX/v9sbZ+zAktyXEeW23yX8b4xsY9/PHhymmWDvazr4f3UlUA+02aC8i5y
 kO+upWI6v+Eu3NrgPyWq1M0e/dkw84ctGbaoFJr7gFMSmqKeMFLhMgwx+tG8Fw9U7SpHWSaJh
 Eyy05IrLZ1orK044hERJzpK2SP5YgU4ExrVwW0zz4B5gThOBMhgkYXL/vb9AV8Bl+JUUDGNif
 vPHSSIvHuo7fqS4O9AMAG4GAuQbTrQmQ4wUvUbMtTb4D+AfoOLkReav5P7mwZ8OSUdHBfZWQe
 UrDqqStNM/xGjAhPCz6gSqYKdFEFaz9Ncvv4O6qT+2LjO1CHtee3tBxXwyXBJdq63UH0TMlPx
 Llp9bQiLAKr2XWYg1dShkK8HoKS2b9VBWV1Zxisn1dgceHYL2WsPLSrWvSlOswRLhPjlB4kEY
 Vy/enJL51GpKeOzFAzxdB+vYL5Tbyagnh4hVbCcfbflMhIO31hknf5Ymvapx7KLFc1QiezA37
 2Y7JHD3e/ajoBaJEgbVOpd6Y5Jvmafg+xiN6bPjl36XfzqXwif1u8qxHv4j7AKfy/wFOr0MAz
 WtzgLGeXfXVxbxHp8hSD6J745qEq5axeeoYQC/ilCD5c971aUt7Tp50k9rST/9MWsDdvoCfV/
 ULIEIQcrbvbaBpVzuafpNid/ygDSSgyHSW74O8YDjBsWRZ4kyOsLNtiJ96zJqnCqUORNSUL1/
 Xg55C/PpJKS2STZ0GAx/Xp/17zpiXLvXDAJQRvCT6cpyXqFhFGLUdF60UQmxivYteE/Fa6sjf
 LgS+7vswIKD8gECk8O+zrkwrt9Ir0sN2W5M2HFd1kBYX7YfpDPpi0Z+mhOU58h3kQbPNsAJNy
 LImyWQvDsftjRfyIeMfVwXrWh+8dZGC320B5LnLr7g78DrmV4lnZ2LYdSwJHZHbazJj5csNKo
 /YqTk9mUHagPG2gQ7J+rCGg4fozWlIczYrcMeQXDZM9tFNRg45MmCzCYba49mA==

From: Nirmal Patel <nirmal.patel@linux.intel.com>

During the boot process all the PCI devices are assigned default PCI-MSI
IRQ domain including VMD endpoint devices. If interrupt-remapping is
enabled by IOMMU, the PCI devices except VMD get new INTEL-IR-MSI IRQ
domain. And VMD is supposed to create and assign a separate VMD-MSI IRQ
domain for its child devices in order to support MSI-X remapping
capabilities.

Now when MSI-X remapping in VMD is disabled in order to improve
performance, VMD skips VMD-MSI IRQ domain assignment process to its
child devices. Thus the devices behind VMD get default PCI-MSI IRQ
domain instead of INTEL-IR-MSI IRQ domain when VMD creates root bus and
configures child devices.

As a result host OS fails to boot and DMAR errors were observed when
interrupt remapping was enabled on Intel Icelake CPUs. For instance:

  DMAR: DRHD: handling fault status reg 2
  DMAR: [INTR-REMAP] Request device [0xe2:0x00.0] fault index 0xa00 [fault=
 reason 0x25] Blocked a compatibility format interrupt request

To fix this issue, dev_msi_info struct in dev struct maintains correct
value of IRQ domain. VMD will use this information to assign proper IRQ
domain to its child devices when it doesn't create a separate IRQ domain.

Link: https://lore.kernel.org/r/20220511095707.25403-2-nirmal.patel@linux.=
intel.com
Cc: stable@vger.kernel.org
Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Artur Piechocki <artur.piechocki@open-e.com>
=2D--
 drivers/pci/controller/vmd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index eb05cceab964..5015adc04d19 100644
=2D-- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -853,6 +853,9 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsi=
gned long features)
 	vmd_attach_resources(vmd);
 	if (vmd->irq_domain)
 		dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
+	else
+		dev_set_msi_domain(&vmd->bus->dev,
+				   dev_get_msi_domain(&vmd->dev->dev));
=20
 	vmd_acpi_begin();
=20
=2D-=20
2.50.1


