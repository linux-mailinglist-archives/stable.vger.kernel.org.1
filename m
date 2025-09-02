Return-Path: <stable+bounces-176938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9321EB3F68A
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 09:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DAC93A779D
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 07:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FCE2E6CB8;
	Tue,  2 Sep 2025 07:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndJJnZDP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B442D2E6CC8;
	Tue,  2 Sep 2025 07:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756797726; cv=none; b=pvLoa5KA7w1GYAvUS67aoSzD9kVpglIpjzFdhnnRk4SskG2zfBdFPWkmKpmWORAY+98nPeJ0qlzADCExqRB6tkjEVcPl44l7+bjvGkkE4PNvw8B1m7PCxaQV+nyFrojoSydNPfAuYdd0xB4XllZHfzhtx8a3GwpBR1ijnlNIxqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756797726; c=relaxed/simple;
	bh=SsIJLDv/4sRh3/0LK17vV+ebKylayu87l45y7PpVxg0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j3xd11eC9l66zeqhTz+A3Ka3GD1Wvt0Y8njjjAiXvI9Trd06ArBpFAKuO5/n/Em8WPs674BDQE140ZrQxqwAjAidE389T6ME/1GmEn1ERmIRx+tr7xdhNwB9KwWi4Z+njSbPwjy5NpEM2WUfBnUu5JehyeFEPOM92QiHx7fGU1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndJJnZDP; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-772301f8ae2so2709811b3a.0;
        Tue, 02 Sep 2025 00:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756797724; x=1757402524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yw3ri99gw13iWXBHvxxwi8geR8Fc/9352q/ntmyST8w=;
        b=ndJJnZDP0S2yKdLJYV6a25mofXBZ4VDszjcoCfZSN1yiUPXgjTwrfgHlUPEJCI6UHy
         RXW7QoA4pjrzWDQa1A55q/MPzRIG2607krpgvwCZGrb62S6MDjs4fQ2Rf8Wy93od+z3G
         5SwgtoqUFHruDsSDjmvmiVMkoPwNiuyu4gkfH8U3kw62EsiOt77XzcvnoCEeBQz0WIPt
         pvJ24YiIBkMtPGYYxDoa/i/rHin8u1XOuijbKdOiLNeve6dEYRaW4qy8qSe2BI30j0st
         C6ojGYkAc+9Pk3BD+NrVOE5F92b8f8t5FD3Lncz+h/9xb+AKrpGC4ZaD2MjAZMD66g64
         pyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756797724; x=1757402524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yw3ri99gw13iWXBHvxxwi8geR8Fc/9352q/ntmyST8w=;
        b=FYl4cycNQcTctpiDPhHYcVHDyeRXTcrV1ouj5Auwfc03tjRWT8gbxATbd/6gBEFFBl
         nfb9bvTL4P1BM2QWKtYH0WHrNYgFspZgOiJUrfjl+cCf47f3U52GxPFmn/dzfN41px6x
         lYnDLanXExX4k5Eyl2GgoOkEYGClbBSlP7q/nwGJ9s3ZtRpSzdcl2ijaZ+Eyv+86ZYrH
         VCWbM3F2EcFAe6J2MjlGGC4LJn47ESg7N3qAytX5Y0L/O1RxKk7sMbN9jJBfOjZToXGU
         FXi9Jxs138Nfjrh9Pk2ak0+IbEu4IZIDWx7h4IzllhgKDL8EEmO5jO+9Nvnmf61KbXcQ
         7vTg==
X-Forwarded-Encrypted: i=1; AJvYcCX+w5EX3nTOL8GYYtwLvVTXGfUlKZzhUcMdCzwffUP3BqpvlEbsq8zXNUVEmWYCSSAfCFOLJAesZKOBM4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfNElRlqdqeDofOsmKIoZPRhRI9CdjD9XwJPzjHHUNfAH1nD9P
	6Hiz5TM6Fi4TKiVyczNReVD+PLmM+3AA+fT8UmUzdLKTFbc98rUrrfDs
X-Gm-Gg: ASbGncsoQIj8yIuR/qUX/JffX90Le7xl3Ehv5oP4m2aexCvgkrEiZtblzUgfYRky/UE
	g9z3konLRsYyXGEjY9CCuookD3R7nSorh2vkdiThezmnGZH5wlTFnb7HDKzxDr8IsO5r/NWAwjA
	7ISXctDf7BmUBpFRxwg8cBCydcgBs+RL54AWqxZDTirIWee0I9DgAbWeP+rYvT1RPXTk5JFosau
	+JqrLdiYcSnA0Fun/sV89KbSC0Lkr9IY9JN+AyofDxxINhRWycXbkoxR8727CHFF5K6FiZv5QCt
	ABU5Q1ZBzmXN5GA/pZTBG2p2Ri+iBwWX1ppX0S0/Go5gFVXi6vhbwp0WQ3lXRRc2G8/qdbmVquQ
	VjJY88l5atORYzYAUaegbhg+WkIl+2u+kvo71o64DvIEuv+70jVgO+lablrUE3kPRdCpQCAtcqw
	fA5mOssvw5zr15DXWQxLLSP52Q97518W4v9z/1DoBxdT4R0z3gcx2qmC8=
X-Google-Smtp-Source: AGHT+IFIaIH+HxoYGYo/EjS/CtIV0f/Ka2pgKDvXIF0gxHvnrn1RBnv+9myDrkVeBAH/CAPmc+gggQ==
X-Received: by 2002:a05:6a00:1a87:b0:772:114c:bcbb with SMTP id d2e1a72fcca58-7723e1f1804mr15229229b3a.4.1756797723879;
        Tue, 02 Sep 2025 00:22:03 -0700 (PDT)
Received: from vickymqlin-1vvu545oca.codev-2.svc.cluster.local ([14.22.11.165])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7722a4e1d4fsm12399630b3a.73.2025.09.02.00.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 00:22:03 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Miaoqian Lin <linmq006@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paul Mackerras <paulus@ozlabs.org>,
	Olof Johansson <olof@lixom.net>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] pasemi: fix PCI device reference leaks in pas_setup_mce_regs
Date: Tue,  2 Sep 2025 15:21:54 +0800
Message-Id: <20250902072156.2389727-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix reference leaks where PCI device references
obtained via pci_get_device() were not being released:

1. The while loop that iterates through 0xa00a devices was not
   releasing the final device reference when the loop terminates.

2. Single device lookups for 0xa001 and 0xa009 devices were not
   releasing their references after use.

Add missing pci_dev_put() calls to ensure all device references
are properly released.

Fixes: cd7834167ffb ("[POWERPC] pasemi: Print more information at machine check")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/powerpc/platforms/pasemi/setup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
index d03b41336901..dafbee3afd86 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -169,6 +169,8 @@ static int __init pas_setup_mce_regs(void)
 		dev = pci_get_device(PCI_VENDOR_ID_PASEMI, 0xa00a, dev);
 		reg++;
 	}
+	/* Release the last device reference from the while loop */
+	pci_dev_put(dev);
 
 	dev = pci_get_device(PCI_VENDOR_ID_PASEMI, 0xa001, NULL);
 	if (dev && reg+4 < MAX_MCE_REGS) {
@@ -185,6 +187,7 @@ static int __init pas_setup_mce_regs(void)
 		mce_regs[reg].addr = pasemi_pci_getcfgaddr(dev, 0xc1c);
 		reg++;
 	}
+	pci_dev_put(dev);
 
 	dev = pci_get_device(PCI_VENDOR_ID_PASEMI, 0xa009, NULL);
 	if (dev && reg+2 < MAX_MCE_REGS) {
@@ -195,6 +198,7 @@ static int __init pas_setup_mce_regs(void)
 		mce_regs[reg].addr = pasemi_pci_getcfgaddr(dev, 0x214);
 		reg++;
 	}
+	pci_dev_put(dev);
 
 	num_mce_regs = reg;
 
-- 
2.35.1


