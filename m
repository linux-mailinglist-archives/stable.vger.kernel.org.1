Return-Path: <stable+bounces-114886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FE8A30832
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 11:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D1183A14F1
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 10:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43EF1F3FE5;
	Tue, 11 Feb 2025 10:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JteXxFBf"
X-Original-To: stable@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D30B1F4171
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 10:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739268907; cv=none; b=ak9WeMiMxTCNFc4ddlt+L87aGpOTytjM0bI/NuXgB1GVGG8troGvKZM/moyPV7SzeRwyfGPOoo1UAGdvXTKWZQmYY62c73GSIxj2s1m1znK4W1rAwYLYm1eLzaFTi8QUodrIew5OqOAZUVBfCRfIFL0ayW0lmvz4OQ6NnVsbUgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739268907; c=relaxed/simple;
	bh=+C96UP0QRfYDESgtwQi/x7lVhO/8MtE4PRXHDqVSHDs=;
	h=Mime-Version:Subject:From:To:CC:Message-ID:Date:Content-Type:
	 References; b=WJjCJavRbWaMqesq8gCR1niiB0V+dezmN0oww9fSKEARZnUl0VaD19Zjck9gHT0U2FM9NzQfuWIWdGU7R5+9qqsosfn0qCIb9hp1QZTQDLg+HxtjhYXrpMfAnS/VzG79Ufy/qGiOCTH3J0SvPN/qIPZ9jUG7gI0+3L1+ROrdJys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=JteXxFBf; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250211101503epoutp024cfbc3a570b996cf5fad8727005f13c1~jH9o_P_Tl2939329393epoutp02t
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 10:15:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250211101503epoutp024cfbc3a570b996cf5fad8727005f13c1~jH9o_P_Tl2939329393epoutp02t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739268903;
	bh=+C96UP0QRfYDESgtwQi/x7lVhO/8MtE4PRXHDqVSHDs=;
	h=Subject:Reply-To:From:To:CC:Date:References:From;
	b=JteXxFBflGsKYe384luaIDCQoV6M/BC4DO34hxQECn4fqU40qdeHyUAqfQcwxqebM
	 xUqDwKA0+k++EzMKZ/q2eZ6/EsIW+t7f+f+K9h/OrhI1Gioq6YuwLkVa2lVLdt/FOX
	 z4yla37sMai6Mve4cKVyoW1d0YqJoWnTwSE/g47M=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20250211101502epcas5p4d71ddd73c52f1bc78fe7e3c9d534d650~jH9oUHowL2637626376epcas5p4z;
	Tue, 11 Feb 2025 10:15:02 +0000 (GMT)
Received: from epcpadp1new (unknown [182.195.40.141]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Ysckt3zLCz4x9Q3; Tue, 11 Feb
	2025 10:15:02 +0000 (GMT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH] usb: xhci: Initialize unassigned variables to fix
 possible errors
Reply-To: selvarasu.g@samsung.com
Sender: Selvarasu G <selvarasu.g@samsung.com>
From: Selvarasu G <selvarasu.g@samsung.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
	"WeitaoWang-oc@zhaoxin.com" <WeitaoWang-oc@zhaoxin.com>,
	"Thinh.Nguyen@synopsys.com" <Thinh.Nguyen@synopsys.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, JaeHun Jung
	<jh0801.jung@samsung.com>, JUNG Daehwan <dh10.jung@samsung.com>, NAUSHAD
	KOLLIKKARA <naushad@samsung.com>, Akash M <akash.m5@samsung.com>, Hyunsoon
	Kim <h10.kim@samsung.com>, OH Eomji <eomji.oh@samsung.com>, ALIM AKHTAR
	<alim.akhtar@samsung.com>, Thiagu Ramalingam <thiagu.r@samsung.com>,
	Muhammed Ali K P <muhammed.ali@samsung.com>, Pritam Manohar Sutar
	<pritam.sutar@samsung.com>, CPGS <cpgs@samsung.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <1296674576.21739268902551.JavaMail.epsvc@epcpadp1new>
Date: Tue, 11 Feb 2025 17:37:13 +0900
X-CMS-MailID: 20250211083713epcms5p719a589a7a973e0c81fca9c9c506f9d85
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20250210131144epcas5p4a0599050f5973b495db0371021c21e27
References: <CGME20250210131144epcas5p4a0599050f5973b495db0371021c21e27@epcms5p7>

On 2/11/2025 11:28 AM, Greg KH wrote:
> On Mon, Feb 10, 2025 at 06:41:23PM +0530, Selvarasu Ganesan wrote:
>> Fix the following smatch errors:
>>
>> drivers/usb/host/xhci-mem.c:2060 xhci_add_in_port() error: unassigned variable 'tmp_minor_revision'
>> drivers/usb/host/xhci-hub.c:71 xhci_create_usb3x_bos_desc() error: unassigned variable 'bcdUSB'
>>
>> Fixes: d9b0328d0b8b ("xhci: Show ZHAOXIN xHCI root hub speed correctly")
>> Fixes: eb02aaf21f29 ("usb: xhci: Rewrite xhci_create_usb3_bos_desc()")
> This should be two different changes, right?
>
> Please break it up and send as a patch series.
>
> thanks,
>
> greg k-h


Hi Greg,

Thanks for your comments. Sure i will send as a patch series.

Thanks,
Selva

