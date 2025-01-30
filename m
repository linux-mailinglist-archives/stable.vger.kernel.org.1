Return-Path: <stable+bounces-111277-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27303A22CC1
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 12:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3381B3A173B
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 11:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6561E25FA;
	Thu, 30 Jan 2025 11:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4CuLfp8"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84191E47A8;
	Thu, 30 Jan 2025 11:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738238305; cv=none; b=WuySB1t62aXDHT8WVGNURhaO6tCQT4YLrxxLVr+kFGgWml6u/uEmXIBSqtXE3FQMuHqXKI4yEN6Tln9FVU02Ywr8FI13Pwo8KuTwch6srXZ6Hts/jmfRc1lFX7Txu5/TNV9OXmcfag23hTs70v7dVc1CumPHzU3gG1lLzLFSKDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738238305; c=relaxed/simple;
	bh=dw9mWJfz5RHeEOoXoFMS7WosrEiyRRUdoFondemh4Q4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a1u+75n93DKY3InA5vtxUOFGCjr1WplhDXhOMlB4clvlliUY7okZoxivwfbeH6O40Nnaoz7aMa9DLORXoqIoyyDRTJ5S0LYs5eadx/XNIKxaKbMvGpdp4C8Ui9GXWsydbX6RTy9qWRA2mGirYa0hZoJVp5XILmYek86c7LXFXSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4CuLfp8; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2161eb95317so10792535ad.1;
        Thu, 30 Jan 2025 03:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738238303; x=1738843103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2w6OTPsFPGpSaOGgiAS9qj/h8GAvjDmGxLB+WH8IBk0=;
        b=A4CuLfp8QFlmQEFLWJKmLKfIFawxOWapNsHHmsvCMAnK9fVhJ8WU31mEcdSYxb4fAq
         l+vam0UDQpiYlGvdG2JMy8w+S48ONJ7wZMSoRLWE756Df0jhrI45Av1W2MMs/JGj0Uo/
         x7xPwzXEu4VWQHDtQUAmDHrcqiJq8b3JnGoBeF+uaAFvuwDcogCef+OgERGt71JmJa80
         C9pRJEAjbMe8u2O0gvkkdrfyQLYlxl/I78+i11Y4mxrOES5w9JaoMGXd5FdYCS+FrUNA
         jbz8mSOaa93MD0SlGYnDbh8bTNP1Xu/4YB6Y9d76h5K2kFE5wVjcXERVErSORCxy0Wta
         c2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738238303; x=1738843103;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2w6OTPsFPGpSaOGgiAS9qj/h8GAvjDmGxLB+WH8IBk0=;
        b=WijUBe59LzcnDhTsYsl2efvgWb37h6AM2OPypyv/MFDLM0g/qGZ0nhNDkfTugcAnmb
         WlgJqBycPMAiBjAaJemKbRQIuoA67qKqPCVUTAnPp3MDKybqCnJorks8f2WRTbD8emwn
         l7IdVulMj81S0DwsX9F6V+PJ2JGy/mSF0hexkcA6sVoGeg+wHG386rWpkblaLONhIkwk
         4B/H6VGHjRBCl5Fm3CViOn/UWtvf6YfzRFnBH39m18FwJD1bK75meylOG/5vOzr6ujCz
         Sv/9wKktEdRNPNwJAK5o0VqzRHxekPGre459Ck2DqnOTnu1+vxBWbIT9eHRhWSjUTcBi
         JWaw==
X-Forwarded-Encrypted: i=1; AJvYcCVQIGbBk1tmYduD2DyHtIadFbdolAuH2SlPlhcN02YL2rxbF1y7B1dYw/qzGUyd7AY4RP/y8TY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGCiQtp7pXuXZwQ5Bs6vKbJ8+1Ca+WYbTs6TC+KXftgYu/khuT
	wA0MiPACLTC99r4zT8mfdHKyo6ioA9CJC0N3WpOgrFD8f4AMAeSH
X-Gm-Gg: ASbGncs3z7HnR9kMazlPVEsoyTdx/KXnQIpDfC5vJ+Bt+mUdItYnpxg/A7SepvQLyB2
	PF6oI6/+HlMlNeutdwfurSSn3jqaCV/OFnneu1meQctJGoLGXfn+w9azFTH01wbC9ZPM6rfA/pq
	FNRG9FDhgod/UMqrcQh3IwcM4S9VOlwvVxe8XCya8haabSHZYodAWiuedSxRMDSdctYTX9PPaad
	FTOXOqfswP4zJvdfCM7S+U2F6jvPDURHL4D/idVEQZHHhtduiHhA230h9UsobMU5XxmYx0YgxYe
	IiIYgzSwL53V9JNM8cM=
X-Google-Smtp-Source: AGHT+IF/eEi0987fyq8jRUhEMVYkTWZcUeQXxaO8i1qm+iIcm7RjohCGlHu/ogj9EaOLfGFULEkvqg==
X-Received: by 2002:a17:902:f606:b0:215:97a3:5ec5 with SMTP id d9443c01a7336-21dd7d81020mr122579535ad.22.1738238302455;
        Thu, 30 Jan 2025 03:58:22 -0800 (PST)
Received: from ubuntuxuelab.. ([58.246.183.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de3302a50sm12078905ad.188.2025.01.30.03.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 03:58:22 -0800 (PST)
From: Haoyu Li <lihaoyu499@gmail.com>
To: Fei Li <fei1.li@intel.com>,
	Shuo Liu <shuo.a.liu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Zhi Wang <zhi.a.wang@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	chenyuan0y@gmail.com,
	Haoyu Li <lihaoyu499@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drivers: virt: acrn: hsm: Use kzalloc to avoid info leak in pmcmd_ioctl
Date: Thu, 30 Jan 2025 19:58:11 +0800
Message-Id: <20250130115811.92424-1-lihaoyu499@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the "pmcmd_ioctl" function, three memory objects allocated by
kmalloc are initialized by "hcall_get_cpu_state", which are then
copied to user space. The initializer is indeed implemented in
"acrn_hypercall2" (arch/x86/include/asm/acrn.h). There is a risk of
information leakage due to uninitialized bytes.

Fixes: 3d679d5aec64 ("virt: acrn: Introduce interfaces to query C-states and P-states allowed by hypervisor")
Signed-off-by: Haoyu Li <lihaoyu499@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/virt/acrn/hsm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c
index c24036c4e51e..e4e196abdaac 100644
--- a/drivers/virt/acrn/hsm.c
+++ b/drivers/virt/acrn/hsm.c
@@ -49,7 +49,7 @@ static int pmcmd_ioctl(u64 cmd, void __user *uptr)
 	switch (cmd & PMCMD_TYPE_MASK) {
 	case ACRN_PMCMD_GET_PX_CNT:
 	case ACRN_PMCMD_GET_CX_CNT:
-		pm_info = kmalloc(sizeof(u64), GFP_KERNEL);
+		pm_info = kzalloc(sizeof(u64), GFP_KERNEL);
 		if (!pm_info)
 			return -ENOMEM;
 
@@ -64,7 +64,7 @@ static int pmcmd_ioctl(u64 cmd, void __user *uptr)
 		kfree(pm_info);
 		break;
 	case ACRN_PMCMD_GET_PX_DATA:
-		px_data = kmalloc(sizeof(*px_data), GFP_KERNEL);
+		px_data = kzalloc(sizeof(*px_data), GFP_KERNEL);
 		if (!px_data)
 			return -ENOMEM;
 
@@ -79,7 +79,7 @@ static int pmcmd_ioctl(u64 cmd, void __user *uptr)
 		kfree(px_data);
 		break;
 	case ACRN_PMCMD_GET_CX_DATA:
-		cx_data = kmalloc(sizeof(*cx_data), GFP_KERNEL);
+		cx_data = kzalloc(sizeof(*cx_data), GFP_KERNEL);
 		if (!cx_data)
 			return -ENOMEM;
 
-- 
2.34.1


