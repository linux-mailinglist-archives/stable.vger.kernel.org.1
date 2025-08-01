Return-Path: <stable+bounces-165729-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E9EB1807C
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 12:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4450DA84084
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 10:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49F4233D88;
	Fri,  1 Aug 2025 10:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=open-e.com header.i=artur.piechocki@open-e.com header.b="0/1aES9Z"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE46B220F25
	for <stable@vger.kernel.org>; Fri,  1 Aug 2025 10:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754045923; cv=none; b=cjWqWzBbg+/tAuC1zB2yOzHZh7LygcxejKmSMDCPqTcaTkmJVTl5yY0J8cXLqhjxKCyuLChLxI6WMsGE7qfoJrOS5+AApg2Zf+z9LiRC9CdcTngOhG+ke48sgsvKSQQ0gvwgdgJARSlCaNryC3v+0DzZ6xxtsKmN0sESvI8OVAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754045923; c=relaxed/simple;
	bh=pn28ph/m1tlQFiTkPNfMpW0rRzCXNwm/PnH7SS/uh20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Eg34jGjMj3bUtVY1cTPBkg/fIq1Eu4UJsVKGRVWAPuLB8fQDT+LiyqJX5o6wdqsUhqe2UeCTpmSSFWgAKhoyg/GxUpdpcMGcsFWJYLm+M1xiJvJCDtUUf9yOBR/PSgwGJZXtdzgxOJu1vUYePVO84IBto+AtNFIEYczROmj9t5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=open-e.com; spf=pass smtp.mailfrom=open-e.com; dkim=pass (2048-bit key) header.d=open-e.com header.i=artur.piechocki@open-e.com header.b=0/1aES9Z; arc=none smtp.client-ip=212.227.126.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=open-e.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-e.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=open-e.com;
	s=s1-ionos; t=1754045917; x=1754650717;
	i=artur.piechocki@open-e.com;
	bh=sSZGaY1Evf4mE8DhvEFZPkjYp6XzmEuWaDq4QPP4tU4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=0/1aES9ZO67bzIIRc7UE5S+D5QKJRPWvET1OebISJ/rKMRUMQb8EEJcItH3pF3+u
	 IWoIv96nNX3L1X0k5POfa/9K4oiEvtPYq8btyOBpde8nEBa8eK1tvn5qRJyfiJIyq
	 l6MbtfS+kZhUaAXWbFkF3v3bZS5Xh6gB+T8OquqnUOk5myuDTZ9RiqndEu2OUn9I5
	 ik/27I2LtaLdp6m7HTaHbbwg7zEgONHT2GF0wnqoHahp8bDJw8MdjQS3zCXgr8+Ea
	 TBpxvHmFa6DYFi8s2bWB0Z/uNPJgWkmGgKpQ3Z9C6wM3gV3ABhhm03YDhkCgAvWEf
	 jjhlHjOVU/GDeV0LFw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from rato-hp ([193.25.251.95]) by mrelayeu.kundenserver.de (mreue009
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MMoXE-1uyMNk3nN6-00W6nW; Fri, 01
 Aug 2025 12:58:37 +0200
From: Artur Piechocki <artur.piechocki@open-e.com>
To: stable@vger.kernel.org
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Artur Piechocki <artur.piechocki@open-e.com>
Subject: [PATCH 5.15.y] PCI: vmd: Assign VMD IRQ domain before enumeration
Date: Fri,  1 Aug 2025 12:58:12 +0200
Message-ID: <20250801105812.25362-1-artur.piechocki@open-e.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JCqi1zKAxWiAPwqI2QxXiZ+GfezzsXDibPvplYN5L6g3fLGWm/G
 /dG+1Y8YAD/YvKvWcj+7lexsg5+2ovj0xmZms3eMDXozB92wKOSZvGzoXl5DocPGGoDTyYg
 44S/+oCoAaUe6Vdt4llqcCm6TfUraRbXPQx2cby+jpY8Cmo4FGl5tSndLy4/JWE2hxPFxhG
 KATltKUbCneHPg7u2BgIg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tXDGUeos89Y=;iYbuoJ+mTxKAFhTJwu1l5Jdr+Tn
 44g9bu8RL+2jqM1d2P7OqDq5DoSFJXDQe8tQa39wTmnpWcOsgzZZs1+etUJVA382xCtqOboLS
 1BUxWuQMuu2GKexuE5j90YBCyVYc6N8Sw2IywyEHAEZiZA3cr2Ui/GvTa7wwh5WK9pIpBacot
 9PVinUIv+X9jsXDJdRL9Ly/sxTIJrkuGlcrR/i/vif83bYuigUnget41OaLs/xGzH4byeRqPD
 SQydQU3Uno2yWFTm0Pk2yynU/6SnJ23r4uI2UyUhOGqHgp7lKXAxf4oETz5x7O9ao6FankWqt
 wDJQO1PpRY1FdjiE9s38KbfcAmKVufx6a1shwEdyXFRMEYXoPG5ufbtd/WoSXNcCTHCKXdENa
 KfmhjoWxNFthNJjTPKG7NlaStIAWWPQw9RXGiwc9SDbt5wwPkmxf4i3p0+g+UAATJLrDEdz+O
 9G9KEdGmTekb4MhI1mjlv38JrOq72G5tyW11tKA5IF9jtOgi83+tPGmfcpL9p0zIAUI/T4yv1
 NpooXTt9VpYR0FuNckI0khJkKONqutRvKaiFbLRPEDefre4TuvAMmsobTGu9Jqgs+aW5CuD0e
 1v6jiR6J1sU6w3vJ5Q6WPAobZYAhND+D3qcxOYgZm/9Oho9bHFtXKv3IRcBNCITTKP2qn02Jx
 uQL9k5TZ9XZZI+CVzKRSsARY2+ComrvmkZXw18AzXVuOzd1+CRpzWhfCLuwNFsu3o+3ENT/3U
 s9dLW0B4EobjYpkn/GogUb/z5g+T6/CvFyVF/JeBzt4yi5D8cWMm4kh0V/AON/Lb84tVXbOhI
 WSBGnjGYWOBBxp1yzafCaBw+euPZ5kGeC8FPVOmn6FBbDlDUMWRbFm2lMGwx4vZcUbprLygjH
 8Vj3zC9lvG6Fvbe1rQGDGKOefKiAalBb2C4byJtbfEZHwJBZIxX+NQu83LKmu3QetL7VrBGt7
 vrS+1HLcnuYL8X8vM/qsnOPH4Anr9lkXQxCMoKFL/c56wUqEgKqkLByEU+anzEztkwI4vXCWD
 igRB+sHkt0kxsb9MZrCy+Oh1vFJkhhwz5XGTMpEHj8hbgrg1PjAuHtqus9epCCiaI7TtlVgCY
 AazqoUF1q/qXmNDT/d++lcKLYKEOffCrclqjNjiDVsOrtNJc8tZR7L3oAE6qQfVG0tjGw0OqR
 gPC2KP8GUDP1c+nJSR1Eo1AySutgijIH9VECNPbeSV92hxY2q9X+VIJTM8aGH9oGL4xLmHvaX
 QO4nBA5SdIOYNnvDwb/JdyjV8ew9ZW/If//dkuZUWeUzAfCcZXXxCR0pcY/JKUvV0+8VyIhzw
 Mca/7GzL2jFKlljsYuENozgEA/RbdR2NNelICLB4stadDAu2ZXukm4ZL8eji14gA5ZmEyHWYA
 tmU28yg4BfQT2vJaLdbutx80JWBk0lzF4feNVkEEjplZkoCRmcHS9cWEH50Y+bpAblp+Og7+8
 V1HGNMgEQf9oghx22DAqMLItZDHwNOsm4N+ixMSlhw/W4gA9O4YEx/Ndp/qonvaFo2LGeNaH9
 UxF1FDszICM5LJvijaUi+bvvLe5aZDOo9hyugfuPPXR4/EKxJGQu5vCHWh2HUw==

From: Nirmal Patel <nirmal.patel@linux.intel.com>

[ Upstream commit 886e67100b904cb1b106ed1dfa8a60696aff519a ]

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
Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
(cherry picked from commit 886e67100b904cb1b106ed1dfa8a60696aff519a)

[ This patch has already been backported to the Ubuntu 5.15 kernel
  and fixes boot issues on Intel platforms with VMD rev 04,
  confirmed on version 5.15.189. ]

Signed-off-by: Artur Piechocki <artur.piechocki@open-e.com>
=2D--
 drivers/pci/controller/vmd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 846590706a38..d0d18e9c6968 100644
=2D-- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -799,6 +799,9 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsi=
gned long features)
 	vmd_attach_resources(vmd);
 	if (vmd->irq_domain)
 		dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
+	else
+		dev_set_msi_domain(&vmd->bus->dev,
+				   dev_get_msi_domain(&vmd->dev->dev));
=20
 	WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
 			       "domain"), "Can't create symlink to domain\n");
=2D-=20
2.50.1


