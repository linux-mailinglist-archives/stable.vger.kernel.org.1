Return-Path: <stable+bounces-116531-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BBFA37BCA
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 08:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0DA77A2518
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 07:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA24C193425;
	Mon, 17 Feb 2025 07:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OujwgcgJ"
X-Original-To: stable@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9595F183098
	for <stable@vger.kernel.org>; Mon, 17 Feb 2025 07:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739775788; cv=none; b=QQb3s83CuD7P2fW+cI/6I3moxYyGyR4MCJ+47F/u9VhY/JvHTYL8nfBnwW0zm2ht0HIqMjfE6gCs4fRop8r8b6IQ+c8OXMJFzGZIhjqlVSEyeszsyUeQHoFu+0bgoFzIw3jfJvRvBbKihUmGvlR+fu+puARU8Wr7PMSX+JmV8/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739775788; c=relaxed/simple;
	bh=I4lEzRs8HaSxRTcYMtIiIHlNRjL2s8WF7AH/tHfWmV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=LzqyjaDO84wWwsTCuQ2Lm+gBSyjweuuzmheDnb0e8ZJ9GdlXW6KhhMkGwRfdEEFuTUgDI66vtrnmE2QxER1GzMHQVL6wnR0VG6Xdgf2I0l1cfcqA2bVltkHQrOpCOsXNePFkGfLhtE5gutA5SJ5UjzUkYNgzI6O/qnhD3iwNK8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=OujwgcgJ; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250217070304epoutp025083c823abe89a87e639842c55bf2e69~k7NutBJhn0955009550epoutp02O
	for <stable@vger.kernel.org>; Mon, 17 Feb 2025 07:03:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250217070304epoutp025083c823abe89a87e639842c55bf2e69~k7NutBJhn0955009550epoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739775784;
	bh=IcdTsF592wys3NuB9zAJMtMjdRMai5MPVdBZ+r76j1Y=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=OujwgcgJn22zsXLzH554wkeMP7lz42mV+A6AfXnQci0Ows+UJa0Xu/heGx7mGZs+P
	 yKwYlqTI9FcM1f3sjvZpHTlDO5/S9VzbU2KncymkTHnpKYoEFuqJUwlhpwDEi08hEh
	 adVYR0e5yUQ0up4Tuhm3s650PQOjGUSFeSP2eHR4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20250217070303epcas5p4058a8462b30780bdb2133a3c6a56b75f~k7NuEguY00604406044epcas5p4H;
	Mon, 17 Feb 2025 07:03:03 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4YxDBb4G3Sz4x9QH; Mon, 17 Feb
	2025 07:03:03 +0000 (GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250217065002epcas5p4e223a794dc8151ec3234eac68c6e60ba~k7CWLpeQQ2915729157epcas5p48;
	Mon, 17 Feb 2025 06:50:02 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250217065002epsmtrp1f8f4370f80ebf35f6144154f8fa3f0b5~k7CWKimJc2260922609epsmtrp1j;
	Mon, 17 Feb 2025 06:50:02 +0000 (GMT)
X-AuditID: b6c32a2a-bca3124000004a05-ce-67b2dc199438
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	08.DB.18949.91CD2B76; Mon, 17 Feb 2025 15:50:01 +0900 (KST)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250217064959epsmtip178990626cda7c2b2fce40cb5e9ac6f73~k7CTujbzv3238732387epsmtip1B;
	Mon, 17 Feb 2025 06:49:59 +0000 (GMT)
Message-ID: <1997287019.61739775783590.JavaMail.epsvc@epcpadp2new>
Date: Mon, 17 Feb 2025 12:19:51 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] usb: xhci: Fix unassigned variable 'bcdUSB' in
 xhci_create_usb3x_bos_desc()
To: Greg KH <gregkh@linuxfoundation.org>
Cc: mathias.nyman@intel.com, WeitaoWang-oc@zhaoxin.com,
	Thinh.Nguyen@synopsys.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, jh0801.jung@samsung.com,
	dh10.jung@samsung.com, naushad@samsung.com, akash.m5@samsung.com,
	h10.kim@samsung.com, eomji.oh@samsung.com, alim.akhtar@samsung.com,
	thiagu.r@samsung.com, muhammed.ali@samsung.com, pritam.sutar@samsung.com,
	cpgs@samsung.com, stable@vger.kernel.org
Content-Language: en-US
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
In-Reply-To: <2025021402-cruelty-dumpster-57cc@gregkh>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsWy7bCSnK7knU3pBvf6bCzeXF3FavFg3jY2
	i5eHNC3uLJjGZHFq+UImi+bF69ks/t6+yGpx9+EPFovLu+awWSxa1sps0bxpCqvF+RddrBaf
	jv5ntXh2bwWbxYKNjxgtVjQDZVctOMBu8ejnXCYHIY/Fe14yeeyfu4bdo2/LKkaPLfs/M3p8
	3iTn8evWLZYAtigum5TUnMyy1CJ9uwSujL87t7IUzBeouHVqNnMDYw9vFyMnh4SAicSdgztZ
	uhi5OIQEdjNKHD88mQUiIS3xelYXI4QtLLHy33N2iKLXjBItazaygSR4Bewkbp/cDlbEIqAq
	carjAgtEXFDi5MwnYLaogLzE/Vsz2EFsYYFMiUU/boLZIgIaEi+P3gKrYRZYySyxtLsMxBYS
	+MQocWiCO0RcXOLWk/lMXYwcHGwChhLPTtiAhDkFzCR2vnrHCFFiJtG1tQvKlpdo3jqbeQKj
	0CwkV8xCMmkWkpZZSFoWMLKsYpRMLSjOTc8tNiwwykst1ytOzC0uzUvXS87P3cQIjlUtrR2M
	e1Z90DvEyMTBeIhRgoNZSYT3UNeGdCHelMTKqtSi/Pii0pzU4kOM0hwsSuK83173pggJpCeW
	pGanphakFsFkmTg4pRqYlhSXPhFjfM6mo2brdrDV6uPk7ZbyXYJWsxepW2spP/f6c2V56Ke8
	JX/Ti522zJ8u05rqWvRzvcrhjMB1c36dYY5oePn0/5agRIu7SgVz5zUx+rsutIq6NNtYMYJt
	g3tuleOm4+qrPoVaaFRUyawJ+sfzz2mb36nZr/OZjk08enypXx7jldLQKZt+fdO8aOB1/VKh
	n2xP7YzFP7MCPf5Z3GywOiV3JDr25WKmTa8kry39UXo1k6N450RnuX8fNC2OMe/kO/ZEZeqz
	Lp2Z86+7q3Ln/+C8c90iOPz4j9114ru9D82S3ZfybaOvsOa3vynNPY5bj5yYzLhb4uSHiSLJ
	bb4JR0u1Dv69ucKl3GBVqRJLcUaioRZzUXEiAEa15nJEAwAA
X-CMS-MailID: 20250217065002epcas5p4e223a794dc8151ec3234eac68c6e60ba
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20250213042240epcas5p3c1ac4f97ebf36054abdccc962329273d
References: <20250213042130.858-1-selvarasu.g@samsung.com>
	<CGME20250213042240epcas5p3c1ac4f97ebf36054abdccc962329273d@epcas5p3.samsung.com>
	<158453976.61739422383216.JavaMail.epsvc@epcpadp2new>
	<2025021402-cruelty-dumpster-57cc@gregkh>


On 2/14/2025 1:35 PM, Greg KH wrote:
> On Thu, Feb 13, 2025 at 09:51:26AM +0530, Selvarasu Ganesan wrote:
>> Fix the following smatch error:
>> drivers/usb/host/xhci-hub.c:71 xhci_create_usb3x_bos_desc() error: unassigned variable 'bcdUSB'
> That really doesn't say what is happening here at all.  Please provide a
> lot more information as the response from a tool could, or could not, be
> a real issue, how are we supposed to know?
>
> And "unassigned" really isn't the bug that is being fixed here, please
> describe it better.
>
> Same for patch 2 of the series.
>
> Also, your 0/2 email was not threaded with these patches, something odd
> happened in your email setup, you might want to look into that.
>
> thanks,
>
> greg k-h
>

Hi Greg,

I understand your concern about whether the response from the tool could 
be a real issue or not. However, please check the provided code, I 
believe there is an issue worth considering.
In both conditions of the code snippet, the logical check is not valid 
because the 'bcdUSB' variable has not been assigned any value initially. 
Therefore, we believe that the tool is correctly identifying this problem.

If you do not consider it an issue, we can ignore this commit.


Please find the relevant portion of the code below:

========================================================================
u16                             bcdUSB;
...
...
/* Create the descriptor for port with the highest revision */
for (i = 0; i < xhci->num_port_caps; i++) {
     ..
     ..
*  if (i == 0 || bcdUSB < rev) { *
         bcdUSB = rev;
         port_cap = &xhci->port_caps[i];
     }
}
..
..
*if (bcdUSB >= 0x0310) {* //*Logically invalid to check bcdUSB without 
assigning a valuewhere above **xhci->num_port_caps become NULL*.
     if (port_cap->psi_count) {

         u8 num_sym_ssa = 0;

=======================================================================


yeah some issue in ouremail setup. We will fix it.



