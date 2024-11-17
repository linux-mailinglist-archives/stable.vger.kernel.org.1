Return-Path: <stable+bounces-93749-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A889D072A
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 01:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF47EB21A73
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 00:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996451DE2A7;
	Mon, 18 Nov 2024 00:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="k+i+XGSU"
X-Original-To: stable@vger.kernel.org
Received: from sonic314-14.consmr.mail.bf2.yahoo.com (sonic314-14.consmr.mail.bf2.yahoo.com [74.6.132.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94832309A7
	for <stable@vger.kernel.org>; Sun, 17 Nov 2024 23:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.132.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731888000; cv=none; b=gg5W29tFP0FwVQrIHXnZeMjcqzZSCQKL2ptkUly8SgNtKGMxSrhqHQpDFtNIKvLS+wUJ0Hj6WOQgEydgixpyCVvFpDDqbAkhE3NioRDNI8qweYHY2DBW9RGDktFnc6hqdxIHoG8LIWWAt1ixL+c1leC9523co4nguIm+np893cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731888000; c=relaxed/simple;
	bh=IvWoevXXpmOe+XQTPhPlMfQe/45LyI5ZKS9WsLqakXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D4bkFVLc3FOWmCKkc3UN/u/eXQPRbP2DffVRtOpq65vR6CoLcvtf6ix3Md4hqqCHoOMnOq6fpKVd0ayHV3j54Eh6TG5If4eCsOo2s5RW4kWt9EcBcDL7sLeMZpx168jzTI4wIWA5vJ8hhDAE7W8sXQuuEu2MLqN5sr5kAmHhBL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=k+i+XGSU; arc=none smtp.client-ip=74.6.132.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1731887997; bh=r8BNRTgQmSesSBBIr5W5/aasZKD6i/fztbdUkMyjEmU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=k+i+XGSU54GiiAJbhD1mtZg/75LVKThGuQ+K6xs5VZqhSdSY53aDytuKSG6njLJuRSuNFvz2TWQTX66vx3kA8TCQciA97M+hspeskMMuaGuU0DC2gZ7LssCShGWMmOj5yX4vPHh5jqs/1RvPwEmajtRrMgc0h0xDdqEqILkuCv9FOxE+lAa+KxORldGlkJ29p9Nm/jcofJe1mdoF+4hOgHO7dXWvDTs6oWWfppJdKOWPCjykzlD05djH0ZAGM3ugo37Feb4D06PGkgYg2vWX+zqlDk23Bkot6a5S76n1ygQZyAGHaaWM3ZZHgglxi/dq4F6zvlEO0EEPSrx1dtqrtg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1731887997; bh=GdPm5LVKv8DuHl80pEwMhIEU57j/yevaoUu+CnmmweI=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=JIwXOTvlhGOpIsF2r71eVXkTolB9Ja1cGBPIf3ukM/xODqveJL1RAejt4W6lqMI6l1AjlF9ss4ecEm4qDA5G9NwCwLXQF7ClZOQTAX+T9F7iVLfvhVtp13L0U21nnPJTETJUib/WwzRbTQSPCjEhXc8GikX4yjPbKrEXhGauv0tE94a51EpJvWclAi0ZL01iIRcdhHS2P6LLY70EIHfeQAR3gZze/6+5/qaotbSZAzh5N6Moz/6w2rf9TLcTuLJkO2DF8XAkAT6+DPnAEztC3+6g/3EzcTVBgwPu4wba9cMUaCl6uEzrrly01m0SlZOrRL1pyRgT5gI4/uQeOfx/LA==
X-YMail-OSG: hSuOfGYVM1ndgg6dhVnOSlwA6.KzLWBotjpHSjuk1xPOH0OKWKseqjxc3MBDm4S
 TuhHzojq1j9YqqQYU_6XmDUxN9PXPs.w_ecyibL4RWm_Wh0gv_3M1glQhe7Z_JaRyGYkq94MSvbK
 uKFeMCfDU8_mUweJpOeBjWSsVgD73g75a8U30JH1Q3jpyqh1EZuM80CJ8GyLH1JSbyIvJorHX8ek
 6_1ghnYtwr6TarJCNbtp0lxHU6_w2OTiDCD1.Fm.ZcAYkbFuiGwAlrGIfir9MsHdPDkFh.BXXd9l
 iLeJlgJqO7gJoy6dhQzBrPiyh1Dq.wil0Sa1N0mkHMfRi40suDBzje9F4UWKyPGQGs8rpNoS3QZi
 7ylU8EcPMOuRoqi3jGe1Q6_0KuqsqnBb2zFjqiPzLhsQn.sYg33VPzfJ4xv6kcknA09.Nmd9dFxG
 gxMecgiRBH7O8rrhNM4XEgpRQIcXABgQImMd4Cf4ALbhJS_robsa9E6yIWuGN00Hipm4RN4c_zGM
 1DBNzlfTYqZ.8C7DdDrcklcu9QfkqVqsXm00nLsOnCYZlJ8YWnVuFLtcqvxSIabGdKfX3JMBHSM5
 wRaPxQNW53l_at3qcRu2ehCZo0WJ2HlGGjXzGk5vdtL_lO_A13xa3ZWchHUxxePyegaK3pM9oh3Z
 eLdHzhZquY1p6.04rHAlh5uoYZkNtOi6Z5c4SI9ga0jbTcxDYJmYg5c2gXSvaXrfBJ4dBjl46bH6
 9VgkA9SsRpZh9WM_mLkhu8ptofihES3Jgvj26muaLCuJ8Kuto6xnSOV3wgIYhRo2_j.YH6YToySc
 6SMHAbqYTFtryg4A7Wc8YZrJJKvPYGqb89s1XmGFGjVeBfbhtGELJRoI7PrXlv_vgpI1nYhhg9kb
 DyVlv0eR8l2eimcYF5RDzKfNPFN0DytAecB3sPKOW3saZYF3HFantMrBt4cz5e89Fw7Poc8Zq2Nc
 .uo0OL7EtOl1P9Ni_jmttlME9DUepogxcfd0X4H3Jb4gqmssZm.vuGGEAvvN1sB0QZM1B3sMIzg7
 JGyl4aUZ2.80YQwW8dpDf59BxbM_eT054HC1zgKbXe7e4PviQinhIiNUA84BuZLal.wXwkDOqo8L
 0Heodkss9z9zN8RIlS9n8A2wytZ6vVWyBj9Z9hpNoMPIjnVINNEQo5dlxb3dU8BlNCrCCbCIhFGP
 g1HxXYCilCFkHFSiWRoDrbuWKJp8ujsQfv7t82BurXJ4yh_DV2Anh0yYdRUZbnOs4kNF0.CyQdEi
 v28qc3ZNl9dbX7cQeCmVtSjvA3NNySTk1HxkzITO7MUh8blx5vF3DCLCocuLYmNRI29EBjsTuNXs
 YJNbMMkcr_7NdR1mmTHi1U9.MasVb74HHZ5eGWzt1KRwaBErOQmSxHmqFNkI7YOwedpW56qTUyNS
 QI7FZmnB5SEql9rruxR0TRD1Kcdoe5NNC7XZsV.dXyQIut7KxCf3bYXAAXxEORyEm7rScfIC.xvQ
 eX9P0omJV8RJD0U..x8OAUrFaVx4HKBE8wfgvvXNPH7mDvF5eExjqjn.HFGYQwHW1TRyC1I1pkYc
 b4FR1t3GmGT_YBEkeKz__TK6jcsXIQH64IJZliLw0bSwkDQBfo0NFezQ4138MuifuSWHYjStFkXf
 JPQjbiuhtCkzzVe7eSwtfu9Guxd8a0jryZtMXo3s6h74aqUCKSK_KfmujwnrsawMbcsfgaJzaKf6
 LxpsU.TmUyo7H0JBbFC6T2NjY.DrfOxwRmT6j6ZW3b0ceI6XrTLsaC5zdgGMuC62QXsGeJQ0NcDC
 s0YqTVOUJkHgmS1cLs2LM7ymwUeY3DCWcl7t1O4EpFsFlScsBW9OVrm6rfdHZ4jizK6hODgTcBag
 IAWVziHyTFeaZdDsrlO5.oDBXgm1S8dAY2JEJYiPjs1bE24Wr8GYURy44JVLqA371MMZyj_I9FsM
 lAGD8BInO9escmlsBtoM9b0DNOCgK_3nTOcVN5uxIpzIXaqyvEkx10XtDAz02qqaKOVJ0FKgLMPA
 8xbPo6woI64XVGwgcebu.zO0f2t51WU1M_k7aHrmjS4J1_g6utr6YTj3rPTWwuTibCCA97_SqnWH
 x7ypaRyx9dfHO8QCoRrBvDx8tcWq1GmJ9uLftNI_diNMnb4jxe2TKzk7lwldKWknkpELA0zGGWCT
 rX4.f3HXLa4pAOE5wUaXJnb9wJC4CO7ft0BSLvNF57vxfdCJPcintJiw9haKO5zU7KjB3XRV.cOn
 a09nwGVVI6h.EcelZy0U4gBaVxvEbAeNvJJ4JlUILX36qM56t7hmZqymFA2Q4sn_drAO2RmWln9K
 cYFgLzC.QaA--
X-Sonic-MF: <dullfire@yahoo.com>
X-Sonic-ID: 70525826-f25d-4d3f-9322-0992ef71de14
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.bf2.yahoo.com with HTTP; Sun, 17 Nov 2024 23:59:57 +0000
Received: by hermes--production-ne1-bfc75c9cd-n46s2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c49c6779fa1a016527bc8d82f3fd465e;
          Sun, 17 Nov 2024 23:49:47 +0000 (UTC)
From: dullfire@yahoo.com
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mostafa Saleh <smostafa@google.com>,
	Marc Zyngier <maz@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: Jonathan Currier <dullfire@yahoo.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] PCI/MSI: Add MSIX option to write to ENTRY_DATA before any reads
Date: Sun, 17 Nov 2024 17:48:42 -0600
Message-ID: <20241117234843.19236-2-dullfire@yahoo.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241117234843.19236-1-dullfire@yahoo.com>
References: <20241117234843.19236-1-dullfire@yahoo.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Currier <dullfire@yahoo.com>

Commit 7d5ec3d36123 ("PCI/MSI: Mask all unused MSI-X entries")
introduces a readl() from ENTRY_VECTOR_CTRL before the writel() to
ENTRY_DATA. This is correct, however some hardware, like the Sun Neptune
chips, the niu module, will cause an error and/or fatal trap if any MSIX
table entry is read before the corresponding ENTRY_DATA field is written
to. This patch adds an optional early writel() in msix_prepare_msi_desc().

Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Currier <dullfire@yahoo.com>
---
 drivers/pci/msi/msi.c | 2 ++
 include/linux/pci.h   | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 3a45879d85db..50d87fb5e37f 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -611,6 +611,8 @@ void msix_prepare_msi_desc(struct pci_dev *dev, struct msi_desc *desc)
 	if (desc->pci.msi_attrib.can_mask) {
 		void __iomem *addr = pci_msix_desc_addr(desc);
 
+		if (dev->dev_flags & PCI_DEV_FLAGS_MSIX_TOUCH_ENTRY_DATA_FIRST)
+			writel(0, addr + PCI_MSIX_ENTRY_DATA);
 		desc->pci.msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
 	}
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 37d97bef060f..b8b95b58d522 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -245,6 +245,8 @@ enum pci_dev_flags {
 	PCI_DEV_FLAGS_NO_RELAXED_ORDERING = (__force pci_dev_flags_t) (1 << 11),
 	/* Device does honor MSI masking despite saying otherwise */
 	PCI_DEV_FLAGS_HAS_MSI_MASKING = (__force pci_dev_flags_t) (1 << 12),
+	/* Device requires write to PCI_MSIX_ENTRY_DATA before any MSIX reads */
+	PCI_DEV_FLAGS_MSIX_TOUCH_ENTRY_DATA_FIRST = (__force pci_dev_flags_t) (1 << 13),
 };
 
 enum pci_irq_reroute_variant {
-- 
2.45.2


