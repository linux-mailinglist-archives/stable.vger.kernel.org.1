Return-Path: <stable+bounces-114283-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D451CA2CA62
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 18:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FE8A3A85BE
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 17:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FA7199EAD;
	Fri,  7 Feb 2025 17:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9NUuIfS"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802601957E2
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 17:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738949840; cv=none; b=tx78CKNQtoM6xpDrePL/oSgXMPrCybyt9kIhCjWAUE/t1hCPhQLrbOVpemMXmcPibs/S/h5zlq1FkByBGV2r7VpAyjUwjspTkeMsuaMeGK2En3B61PydAlWFxQ+ulJpHRTkyvbczLxEZsYCwKrxOG8K1fXwXN4vk+yuv2uRH46w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738949840; c=relaxed/simple;
	bh=eMOPtaGTTF73jOz66IE1aHP4ylpY98vlzG32UlXyyCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oK9QEPd+RYzF/kXmlbJgm6QoPfB+TaNq4F9RiH2p9g0wXWybXlR1lHHxXZXruIHr8JSEetnRH+5pAMbW7bveTyHdL9Ihlzd4ktFxRb8ZnzIJe+X0nq+24Pb1RDYrhszCtkXxJT64HsXn9ryPbHCSUJyd9je53dXZFCgRPsHSg3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9NUuIfS; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2163dc5155fso49402715ad.0
        for <stable@vger.kernel.org>; Fri, 07 Feb 2025 09:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738949838; x=1739554638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YHzgZFWfFK3rzbQD5oxFJnqutaN+R2cFzcShXzAN8QE=;
        b=F9NUuIfSyQwMXcVxQc0aphbLw2wSNcvet8UxKzFhMgwwzyH0dP+n63cO16Jr/M7Nxp
         DoKWB6UnlBzvQuWZPQWH/p0jg0HbhbD0xYY63JeOlP7L7LfqwBG2t1ZyjDyZhEjbjd68
         p1iThaHV8kaqqiN8zDA9nGufB8/WraYyqC++r4COH2EpC5YeYVrPJtThHDbjrtsyjgwF
         8MWV0z6JP0DWLTcACT2tSBSp0zOG1DvSg0yd7YRQ+SKPrauVss72MNM3qtGCnij96POW
         Ufpw9AndL/fRB5Jy7gN6PI36yvs3ibyBeRi4wp7nYHvFVfG7q0gCufFZ0SsnMjgAWmX/
         eYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738949838; x=1739554638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YHzgZFWfFK3rzbQD5oxFJnqutaN+R2cFzcShXzAN8QE=;
        b=slfzfdzTkHd5LB2Fv5I7I4dQUzxKO5nZMI6d66JF2Aop+zX1LkBbGdD4JNYIyZlekz
         C8frmOfUAdriKuGEwwOMelLdV67XYvSg4HJNBJcnOhYKAyYT7mkK26eN1YJo3uEqgpI/
         HULNo2AiFUD/XGl6rqJm6ZrTofkx8qIWcLSCjtnBA5mXEoHqor89hZr/VjAIOiMHRHoF
         IL/7WzAABW46t6NJ4n6/2sg1Nqh4SPyu9X6fLItivan+qQ43P8e3Drc81OL6CEa2Y6QE
         U/mDW7+VE4XVMLHYFtLHTIggqawLHx/G49HGRtmF+mu8nZn+OYsWN1xc2KFfSmA/x4F6
         Rmfw==
X-Gm-Message-State: AOJu0YxF6l9OVw2UeCngUIfc3qMJ1+HAcWhgDj0F30s3lqGnBH3c1V3o
	60YndAMZggV1/StQkoqZ8e/SRTr3o70Z/gXQqUMTrQPIAJtbLAiBKmfRPkAVhg==
X-Gm-Gg: ASbGncvgw7B559VUq5SywgNcjR5sRdUk90rpDCWtsutHqXac3jbCfoFFvzm58jwu4TV
	do53ZSNpvW6ZPUgyqpcW0yoYqpkKkbeq/bTE3xmFSONtrxbnhXJr/9QUbYBKtmVPD64FXZB5C0L
	Ovnarxx5VgUoHJKBxMmsHGGSni1I+AcHmRA2504DafHjbbv01CgtkBEh6RuwcIW5tg9LGR51TUe
	kc6zYX6hA18tcpJhO8ONfMhKAnDgLG05GKT6IMcEY+LVmEP2xTr55PiCB+9imvqf2YOHLaWAAXp
	T7dgd9GdK/1BA/kGuXG6apY+d5hoqXPj
X-Google-Smtp-Source: AGHT+IGhuVVwXrQe7tZEXJ86vBfLY0CnN9I05ut3eUk3SQToXVXo6vgb6+vHGda+DlperjDoysk+zA==
X-Received: by 2002:a17:902:ef49:b0:21f:14c1:d58e with SMTP id d9443c01a7336-21f4e1cbe22mr69680145ad.1.1738949838090;
        Fri, 07 Feb 2025 09:37:18 -0800 (PST)
Received: from kotori-linux-laptop.lan ([116.232.67.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3683dbaasm33134055ad.144.2025.02.07.09.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 09:37:17 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: stable@vger.kernel.org
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Tomita Moeko <tomitamoeko@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Subject: [PATCH 6.1 5.15 5.10 5.4 3/3] parport_pc: add support for ASIX AX99100
Date: Sat,  8 Feb 2025 01:36:59 +0800
Message-ID: <20250207173659.579555-4-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250207173659.579555-1-tomitamoeko@gmail.com>
References: <20250207173659.579555-1-tomitamoeko@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 16aae4c64600a6319a6f10dbff833fa198bf9599 ]

The PCI function 2 on ASIX AX99100 PCIe to Multi I/O Controller can be
configured as a single-port parallel port controller. The subvendor id
is 0x2000 when configured as parallel port. It supports IEEE-1284 EPP /
ECP with its ECR on BAR1.

Signed-off-by: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Link: https://lore.kernel.org/r/20230724083933.3173513-5-jiaqing.zhao@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 drivers/parport/parport_pc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
index 4605758d3214..2e921ddbe748 100644
--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -2612,6 +2612,7 @@ enum parport_pc_pci_cards {
 	netmos_9815,
 	netmos_9901,
 	netmos_9865,
+	asix_ax99100,
 	quatech_sppxp100,
 	wch_ch382l,
 	brainboxes_uc146,
@@ -2678,6 +2679,7 @@ static struct parport_pc_pci {
 	/* netmos_9815 */		{ 2, { { 0, 1 }, { 2, 3 }, } },
 	/* netmos_9901 */               { 1, { { 0, -1 }, } },
 	/* netmos_9865 */               { 1, { { 0, -1 }, } },
+	/* asix_ax99100 */		{ 1, { { 0, 1 }, } },
 	/* quatech_sppxp100 */		{ 1, { { 0, 1 }, } },
 	/* wch_ch382l */		{ 1, { { 2, -1 }, } },
 	/* brainboxes_uc146 */	{ 1, { { 3, -1 }, } },
@@ -2770,6 +2772,9 @@ static const struct pci_device_id parport_pc_pci_tbl[] = {
 	  0xA000, 0x1000, 0, 0, netmos_9865 },
 	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9865,
 	  0xA000, 0x2000, 0, 0, netmos_9865 },
+	/* ASIX AX99100 PCIe to Multi I/O Controller */
+	{ PCI_VENDOR_ID_ASIX, PCI_DEVICE_ID_ASIX_AX99100,
+	  0xA000, 0x2000, 0, 0, asix_ax99100 },
 	/* Quatech SPPXP-100 Parallel port PCI ExpressCard */
 	{ PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_SPPXP_100,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, quatech_sppxp100 },
-- 
2.47.2


