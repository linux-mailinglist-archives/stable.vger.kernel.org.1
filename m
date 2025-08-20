Return-Path: <stable+bounces-171904-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EDCB2DEDF
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 16:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5E5C1623CB
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 14:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D782C2627EC;
	Wed, 20 Aug 2025 14:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kCL6/5SB"
X-Original-To: stable@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0C421FF24
	for <stable@vger.kernel.org>; Wed, 20 Aug 2025 14:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755699119; cv=none; b=YQzSrHhhbQiPSxBYyMf6sNRFZXi5E9lyvC1KiBmoHeyZAHJh6y5WJCgp6yQwlp5yU9vfW7Z4ESZCt1KmxHBFHwy/xSUMzzXq+A0WsBD6065Ke5W7PzJceZ0FHWgKhbb1zPIglI5Wo9UvaG7/Oqb9R9mSXsF7ON3VFTG52emBkH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755699119; c=relaxed/simple;
	bh=A0bjcUD0zB0qBiMVKyb2pDMRnUNVoMBmzkf8RYM1j+A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type:
	 References; b=GWskrBR9HSVp4+e3+fsA9dKGuO9zCJEN8PxnX1fYuyQNiYFjsGk7YPUPKUL0VH8qHvYwgPOc4iPLKq0Ydh6ntzedCpZpiqWfyj9iZzyO4AbGwW5ias3sHTe3GDrK/CfJrOODc8rDGflDzVJLe0m+zJoiqSbpMyEscMEKcXHZ8sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=kCL6/5SB; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250820141148epoutp015647bc73f932471f00b891b243f1a92b~dfwmCSlhv1104611046epoutp01D
	for <stable@vger.kernel.org>; Wed, 20 Aug 2025 14:11:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250820141148epoutp015647bc73f932471f00b891b243f1a92b~dfwmCSlhv1104611046epoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755699108;
	bh=lWYpE7WQ5VJ51tlj/LIwlhdcWLO4fPqirbxJNiB1kj4=;
	h=Date:From:Subject:To:Cc:References:From;
	b=kCL6/5SBh6e42228Qu2u2JYU+NekffrloCxj4f/WgnX5kLnVMy8X6eMoPFNQpia8I
	 HXtfqH2akry4fYHEufxt+KHCvAIMWL2Ge5MJB9P26KIswugVRRGwpMAFgafPjLz/TC
	 xA54vXkFjwVT0ezgsq2XQ3OBCgPZpBF9lbsgr1Rk=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250820141147epcas5p186b7a3faf14accac60b325ca2d6fdc3d~dfwleaUGu0910809108epcas5p1V;
	Wed, 20 Aug 2025 14:11:47 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.93]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4c6T0M1wHYz2SSKX; Wed, 20 Aug
	2025 14:11:47 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250820141146epcas5p1a87653e56e5a9e6ce844330a94e76eea~dfwkMzI-x0546205462epcas5p1o;
	Wed, 20 Aug 2025 14:11:46 +0000 (GMT)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250820141146epsmtip2970c12299647f6b049da0791f1f33d52~dfwjrHArp1750917509epsmtip2z;
	Wed, 20 Aug 2025 14:11:45 +0000 (GMT)
Message-ID: <8c68604b-2775-4d70-a0d6-18ecb979c797@samsung.com>
Date: Wed, 20 Aug 2025 19:41:44 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
Subject: [PATCH stable 5.10] usb: dwc3: Remove DWC3 locking during gadget
 suspend/resume
To: stable@vger.kernel.org
Cc: "akash.m5@samsung.com" <akash.m5@samsung.com>, "thiagu.r@samsung.com"
	<thiagu.r@samsung.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250820141146epcas5p1a87653e56e5a9e6ce844330a94e76eea
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250820141146epcas5p1a87653e56e5a9e6ce844330a94e76eea
References: <CGME20250820141146epcas5p1a87653e56e5a9e6ce844330a94e76eea@epcas5p1.samsung.com>

Dear stable team,


Patch : usb: dwc3: Remove DWC3 locking during gadget suspend/resume

Commit id:5265397f94424eaea596026fd34dc7acf474dcec

This patch fixes a critical bug in the dwc3 driver that was introduced 
by commit 
(https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/usb/dwc3/gadget.c?h=v5.10.240&id=90e2820c6c30db2427d020d344dfca7de813bd24 
<https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/usb/dwc3/gadget.c?h=v5.10.240&id=90e2820c6c30db2427d020d344dfca7de813bd24>) 
in the 5.10 kernel series.

The bug causes the below kernel crash (Added usleep in atomic context as 
part of above patch) under dwc3 suspend/resume scenarios.

35.829644] [6: kworker/6:1: 68] BUG: scheduling while atomic: 
kworker/6:1/68/0x00000002

[ 35.829946] [6: kworker/6:1: 68] CPU: 6 PID: 68 Comm: kworker/6:1 
Tainted: G C E 5.10.236-android13-4 #1

[ 35.830010] [6: kworker/6:1: 68] Call trace:

[ 35.830024] [6: kworker/6:1: 68] dump_backtrace.cfi_jt+0x0/0x8

[ 35.830034] [6: kworker/6:1: 68] show_stack+0x1c/0x2c

[ 35.830044] [6: kworker/6:1: 68] dump_stack_lvl+0xd8/0x134

[ 35.830053] [6: kworker/6:1: 68] __schedule_bug+0x80/0xbc

[ 35.830062] [6: kworker/6:1: 68] __schedule+0x55c/0x7e8

[ 35.830068] [6: kworker/6:1: 68] schedule+0x80/0x100

[ 35.830077] [6: kworker/6:1: 68] schedule_hrtimeout_range_clock+0xa8/0x11c

[ 35.830083] [6: kworker/6:1: 68] usleep_range+0x68/0xa4

[ 35.830093] [6: kworker/6:1: 68] dwc3_gadget_run_stop+0x170/0x448

[ 35.830099] [6: kworker/6:1: 68] dwc3_gadget_resume+0x4c/0xdc

[ 35.830108] [6: kworker/6:1: 68] dwc3_resume_common+0x6c/0x23c

[ 35.830115] [6: kworker/6:1: 68] dwc3_runtime_resume+0x40/0xcc

[ 35.830123] [6: kworker/6:1: 68] pm_generic_runtime_resume+0x48/0x88

[ 35.830131] [6: kworker/6:1: 68] __rpm_callback+0x94/0x420

The patch(5265397f9442) for this fix was originally merged in the below 
commit:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/usb/dwc3?h=next-20250820&id=5265397f94424eaea596026fd34dc7acf474dcec 
<https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/usb/dwc3?h=next-20250820&id=5265397f94424eaea596026fd34dc7acf474dcec>

  Please apply this patch to the stable 5.10 kernel to prevent this BUG.

Additionally the below patch also required to avoid dead lock that 
introduced by the abovepatch (5265397f9442) in 5.10 stable kernel.

Patch:usb: dwc3: core: remove lock of otg mode during gadget 
suspend/resume to avoid deadlock

Commit id:7838de15bb700c2898a7d741db9b1f3cbc86c136

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/usb/dwc3?h=next-20250820&id=7838de15bb700c2898a7d741db9b1f3cbc86c136 
<https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/usb/dwc3?h=next-20250820&id=7838de15bb700c2898a7d741db9b1f3cbc86c136>

Thanks,

Selva



