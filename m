Return-Path: <stable+bounces-105299-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA71C9F7BD7
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 13:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9017318872F6
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 12:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A515D224AE2;
	Thu, 19 Dec 2024 12:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="guORhkVa"
X-Original-To: stable@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C96224AEF
	for <stable@vger.kernel.org>; Thu, 19 Dec 2024 12:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734612782; cv=none; b=F3vfmpVn3F/EVh3hTUHj9BTrm1cxsTkhqDSMYAGppeIBgYwKzBBXtVOdzpttklsUyk3QEp4BgVgI+BttNaKQSe2ip3KTKRZbz58SutK8VFev+PMk6w+cVYzYdA919B0s1l1vFS3Atf7gVtKXC0NyV/9YlALwyM5zbxSe4bffEGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734612782; c=relaxed/simple;
	bh=B97Llbf0YREjqIyQt5vPG9mxDBeer5PpFc5dHxjfnIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=oMOLAtLH+SeObj+NCqhTsctONzSHiHDvvsaDcJDvjvmj9gVjKVGUBAUPvmOhe7n5Oe+10FvYTnRHMhT3IYUnci+kspnddxtwFkYvLeZehqKAIyPZQHedHKJxswCrycVlo2eP0vwfxWhGoiXEIMN0+UBh6wB2FK5iHfJqx2KI/jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=guORhkVa; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20241219125251epoutp04c037ceb5283c50c2da93f569e486ffe2~SlSAHTjh20798507985epoutp04K
	for <stable@vger.kernel.org>; Thu, 19 Dec 2024 12:52:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20241219125251epoutp04c037ceb5283c50c2da93f569e486ffe2~SlSAHTjh20798507985epoutp04K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1734612771;
	bh=sKFhPF8oggiXR9rwfVQ+SiG0Bh6p6hc1OP+VypPhxH0=;
	h=From:To:Cc:Subject:Date:References:From;
	b=guORhkVa/iUGpuyz3HhKqlVtYXbJeCp5GTiva2UnlEZ1U8MyucjS6L7TZGAgueJaQ
	 8IBOGgVRCsUsqVvoPR8F/WhbjHtfu2UjD3UI/zK22C9GTzdiRGfpl3T9L3mJXk7v9N
	 GJcJFswBvfBOdJpqupC4Cg+F8Bu0Ai3lBV+94W7w=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20241219125250epcas5p1a75755930a7962bc29049e9e0bb5c190~SlR-N-SV01606816068epcas5p17;
	Thu, 19 Dec 2024 12:52:50 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4YDVns0Ql1z4x9Pv; Thu, 19 Dec
	2024 12:52:49 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	FD.B9.19710.02714676; Thu, 19 Dec 2024 21:52:48 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20241219125248epcas5p3887188e4df29b7b580cce9cfe6fed79f~SlR9YqXDB1112611126epcas5p38;
	Thu, 19 Dec 2024 12:52:48 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241219125248epsmtrp13e551a8fb58ff228bdded55e244e8fcf~SlR9XikME1714617146epsmtrp1U;
	Thu, 19 Dec 2024 12:52:48 +0000 (GMT)
X-AuditID: b6c32a44-363dc70000004cfe-fd-6764172032b0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	B3.87.33707.02714676; Thu, 19 Dec 2024 21:52:48 +0900 (KST)
Received: from INBRO002811.samsungds.net (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241219125245epsmtip1d6bc9c94517ed39a0b607421663d72eb~SlR6nhplK0310303103epsmtip14;
	Thu, 19 Dec 2024 12:52:45 +0000 (GMT)
From: Akash M <akash.m5@samsung.com>
To: gregkh@linuxfoundation.org, paul@crapouillou.net, Chris.Wulff@biamp.com,
	tudor.ambarus@linaro.org, m.grzeschik@pengutronix.de,
	viro@zeniv.linux.org.uk, quic_jjohnson@quicinc.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jh0801.jung@samsung.com, dh10.jung@samsung.com, naushad@samsung.com,
	akash.m5@samsung.com, rc93.raju@samsung.com, taehyun.cho@samsung.com,
	hongpooh.kim@samsung.com, eomji.oh@samsung.com, shijie.cai@samsung.com,
	alim.akhtar@samsung.com, selvarasu.g@samsung.com, stable@vger.kernel.org
Subject: [PATCH] usb: gadget: f_fs: Remove WARN_ON in functionfs_bind
Date: Thu, 19 Dec 2024 18:22:19 +0530
Message-ID: <20241219125221.1679-1-akash.m5@samsung.com>
X-Mailer: git-send-email 2.46.0.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNJsWRmVeSWpSXmKPExsWy7bCmlq6CeEq6QdMNa4s3V1exWjyYt43N
	YubH20wWdxZMY7I4tXwhk0Xz4vVsFpP2bGWxuPvwB4vF5V1z2CwWLWtlttjSdoXJ4tPR/6wW
	/YsvsVg0brnLarGqcw6LxZHlH5ksLn/fyWyxYOMjRotJB0UtPt2Kszj/9zirg6jHw+4L7B6r
	L7Wzedy5tofNY//cNewe/X8NPCbuqfPo27KK0ePzJjmPTU/eMgVwRmXbZKQmpqQWKaTmJeen
	ZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gA9p6RQlphTChQKSCwuVtK3synK
	Ly1JVcjILy6xVUotSMkpMCnQK07MLS7NS9fLSy2xMjQwMDIFKkzIzrj+oJG5YJ94xbQz21gb
	GN8IdjFyckgImEisXHOcpYuRi0NIYDejxNr7txkhnE+MEhNXLWeGc35O6WOBabm9/yU7RGIn
	o8SZa8+YIJzvjBIXF11nA6liE1CRuL17DytIQkTgC6PE4x8/wBxmgaVMEsfezWEGqRIWcJXY
	0tYFZHNwsAioStza5Q8S5hWwkDi/bwMjxDpNibV79zBBxAUlTs58AnYGs4C8RPPW2WD3SQic
	4ZBYd/gkE8gcCQEXie7JOhC9whKvjm9hh7ClJF72t0HZPhIrdq1lhShPkfg9tRoibC+xesEZ
	sDAz0Nr1u/QhNvFJ9P5+AjWcV6KjTQiiWlXiVONlNghbWuLekmtQAz0kZp8pBAkLCcRK/Dy/
	gGUCo9wsJOfPQnL+LIRdCxiZVzFKphYU56anJpsWGOallsOjMjk/dxMjOFVruexgvDH/n94h
	RiYOxkOMEhzMSiK8bpqJ6UK8KYmVValF+fFFpTmpxYcYTYFBOpFZSjQ5H5gt8kriDU0sDUzM
	zMxMLI3NDJXEeV+3zk0REkhPLEnNTk0tSC2C6WPi4JRqYFqR8vHy3EkWvKqifol583rnl2mu
	nhVhp36iyEjmekzKdw51xlzTvlMhF/LM9A68nX9bb/e0rfv0q1jKpX0/O542Zdwo/ETzgW75
	Spsj1icS3wbmlOTK1bbVXFIReaCk4LZFM0Bmi88CPV9ppzSRaQVnfuhM7i+cqdihZvS3ULWg
	LX3V1/q8yWwmHxas3Dq1d8HOxN8ZXfo+bev72zNs8jZ5/+lJPxqdHMP73n39rp9ORxYoVIse
	4e5YZCkhUcHVftdR68LJQv1XpgoJs57rP7v71eFe36s4hqdd/y8fCs9kb1655c3/BROvqwS2
	TVnNuKbqB1d76fZob+3oDw4n9gQ779ZtYb0mN/Hf428LlViKMxINtZiLihMBEThArV4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpikeLIzCtJLcpLzFFi42LZdlhJTldBPCXdYP1Rfos3V1exWjyYt43N
	YubH20wWdxZMY7I4tXwhk0Xz4vVsFpP2bGWxuPvwB4vF5V1z2CwWLWtlttjSdoXJ4tPR/6wW
	/YsvsVg0brnLarGqcw6LxZHlH5ksLn/fyWyxYOMjRotJB0UtPt2Kszj/9zirg6jHw+4L7B6r
	L7Wzedy5tofNY//cNewe/X8NPCbuqfPo27KK0ePzJjmPTU/eMgVwRnHZpKTmZJalFunbJXBl
	XH/QyFywT7xi2pltrA2MbwS7GDk5JARMJG7vf8nexcjFISSwnVHi26spjBAJaYnXs7qgbGGJ
	lf+eQxV9ZZSYvbiDCSTBJqAicXv3HlaQhIjAP0aJRZ0fmEAcZoGtTBK3n65lAakSFnCV2NLW
	xdzFyMHBIqAqcWuXP0iYV8BC4vy+DVAbNCXW7t3DBBEXlDg58wlYK7OAvETz1tnMExj5ZiFJ
	zUKSWsDItIpRNLWgODc9N7nAUK84Mbe4NC9dLzk/dxMjOJq0gnYwLlv/V+8QIxMH4yFGCQ5m
	JRFeN83EdCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8yjmdKUIC6YklqdmpqQWpRTBZJg5OqQYm
	aWvOJcea7Z0fPvBZVXJdulJBRW1DJZPd39pVJX+8n99u13rdsvrVY+dMw0dXn1UssRKf0227
	cUuqr7sh6+Rzz3nzz0ieySuUKzu7JMUk9ZVNSfAJ/ldlix4ELvU4xPzZ572F2/yMYzUvG7ZL
	7mZ/+dn6fKvH0q5PnQ8ePZONEzhfGnJfKe78/pALVw4lJt/9vzVUqnaf6gEx356mbvmYkz7K
	ZWcOVTfcXHZy0oHdhtvmJV9oYu0X//nMKnGeyFGZLbHrvaUadnjZT1t1RFRxQei6RkMhLrnT
	r1TVA31fVzppMJ617W5R27jDSeFwX1nhuhX1wdoeO/dJBflx21w9tNPrmU3Uz7urjthcveiu
	xFKckWioxVxUnAgAn7qIoBUDAAA=
X-CMS-MailID: 20241219125248epcas5p3887188e4df29b7b580cce9cfe6fed79f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241219125248epcas5p3887188e4df29b7b580cce9cfe6fed79f
References: <CGME20241219125248epcas5p3887188e4df29b7b580cce9cfe6fed79f@epcas5p3.samsung.com>

This commit addresses an issue related to below kernel panic where
panic_on_warn is enabled. It is caused by the unnecessary use of WARN_ON
in functionsfs_bind, which easily leads to the following scenarios.

1.adb_write in adbd               2. UDC write via configfs
  =================	             =====================

->usb_ffs_open_thread()           ->UDC write
 ->open_functionfs()               ->configfs_write_iter()
  ->adb_open()                      ->gadget_dev_desc_UDC_store()
   ->adb_write()                     ->usb_gadget_register_driver_owner
                                      ->driver_register()
->StartMonitor()                       ->bus_add_driver()
 ->adb_read()                           ->gadget_bind_driver()
<times-out without BIND event>           ->configfs_composite_bind()
                                          ->usb_add_function()
->open_functionfs()                        ->ffs_func_bind()
 ->adb_open()                               ->functionfs_bind()
                                       <ffs->state !=FFS_ACTIVE>

The adb_open, adb_read, and adb_write operations are invoked from the
daemon, but trying to bind the function is a process that is invoked by
UDC write through configfs, which opens up the possibility of a race
condition between the two paths. In this race scenario, the kernel panic
occurs due to the WARN_ON from functionfs_bind when panic_on_warn is
enabled. This commit fixes the kernel panic by removing the unnecessary
WARN_ON.

Kernel panic - not syncing: kernel: panic_on_warn set ...
[   14.542395] Call trace:
[   14.542464]  ffs_func_bind+0x1c8/0x14a8
[   14.542468]  usb_add_function+0xcc/0x1f0
[   14.542473]  configfs_composite_bind+0x468/0x588
[   14.542478]  gadget_bind_driver+0x108/0x27c
[   14.542483]  really_probe+0x190/0x374
[   14.542488]  __driver_probe_device+0xa0/0x12c
[   14.542492]  driver_probe_device+0x3c/0x220
[   14.542498]  __driver_attach+0x11c/0x1fc
[   14.542502]  bus_for_each_dev+0x104/0x160
[   14.542506]  driver_attach+0x24/0x34
[   14.542510]  bus_add_driver+0x154/0x270
[   14.542514]  driver_register+0x68/0x104
[   14.542518]  usb_gadget_register_driver_owner+0x48/0xf4
[   14.542523]  gadget_dev_desc_UDC_store+0xf8/0x144
[   14.542526]  configfs_write_iter+0xf0/0x138

Fixes: ddf8abd25994 ("USB: f_fs: the FunctionFS driver")
Cc: stable@vger.kernel.org
Signed-off-by: Akash M <akash.m5@samsung.com>

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 2920f8000bbd..92c883440e02 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -2285,7 +2285,7 @@ static int functionfs_bind(struct ffs_data *ffs, struct usb_composite_dev *cdev)
 	struct usb_gadget_strings **lang;
 	int first_id;
 
-	if (WARN_ON(ffs->state != FFS_ACTIVE
+	if ((ffs->state != FFS_ACTIVE
 		 || test_and_set_bit(FFS_FL_BOUND, &ffs->flags)))
 		return -EBADFD;
 
-- 
2.17.1


