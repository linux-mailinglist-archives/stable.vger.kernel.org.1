Return-Path: <stable+bounces-114994-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E368A31D75
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 05:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF50C167047
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 04:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331E81DA612;
	Wed, 12 Feb 2025 04:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="O6oysXQN"
X-Original-To: stable@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1124427182D
	for <stable@vger.kernel.org>; Wed, 12 Feb 2025 04:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739334106; cv=none; b=EFmQ5Xv5FmysAlGVdBXdm32FZNSqpO0H4MDM10o7zgManlBXeL3tB3WlVu/deqAIxvpwKP3O3+tldT753N9n0bO+dkya3F1G2xLLgYk/JHo2qz509iWcNOWx3lkt8CPl3rb5qSFUKqqWWtSAKvpLjiKV6CCSlyy0mKetVggrs+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739334106; c=relaxed/simple;
	bh=eo6PBdCr14uE9pfKzSCRPQ102ptVp6Zjh/uM4XP6ChE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:In-Reply-To:
	 Content-Type:References; b=Q3hGGs/elPwtgoUUUmIIm/X33FuzWJs77UH6kX2E2q0HMZOdHiUFYq0pt5HTGu020ahEo+m7CDjhRr0sQhUTOoumWdMP/XgcWT5Uaawx8ICl9Y5a3Q6Fr3cHNXq5i2bMCV69jxSRxfDLPI77YqJjcWAGDE18Nqh1Afpe81ewrio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=O6oysXQN; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250212042139epoutp04d55eb9d228f72a2e2b21eb5ccee47569~jWyYGImnm0576205762epoutp04G
	for <stable@vger.kernel.org>; Wed, 12 Feb 2025 04:21:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250212042139epoutp04d55eb9d228f72a2e2b21eb5ccee47569~jWyYGImnm0576205762epoutp04G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739334100;
	bh=2ef025k2n8A8UFPx3LLjsC9w7TNZWzKu4qwlKCsaUu4=;
	h=Date:Subject:To:From:In-Reply-To:References:From;
	b=O6oysXQNkBKTKNc+iGM+p+AZQ6FUoqTdLSwQyjeEK+xk6eqmC1W40gZblDuAE5rsF
	 fvPweziKKLcrvxbcndiUe4zZ3VziGg+LteZEKc6c0i59sPmhgn5b+a3WiVToL4dmvO
	 +fMk8G+s7C5hp8SCEpR8ITFOpTaY8e+uapcLwPJg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20250212042139epcas5p181ebf028f1f49d7ae727df2ae2ff9866~jWyX5cvMu0536705367epcas5p19
	for <stable@vger.kernel.org>; Wed, 12 Feb 2025 04:21:39 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Yt4rf1dQXz4x9Q2 for
	<stable@vger.kernel.org>; Wed, 12 Feb 2025 04:21:38 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	69.66.19710.0D12CA76; Wed, 12 Feb 2025 13:21:36 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250212042135epcas5p2010a408a557678bf38414efdfeca7d42~jWyUVHMBz1617716177epcas5p2G
	for <stable@vger.kernel.org>; Wed, 12 Feb 2025 04:21:35 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250212042135epsmtrp2c3405483e90454e75ab13dbb99c3c3dd~jWyUUNe4x2699226992epsmtrp20
	for <stable@vger.kernel.org>; Wed, 12 Feb 2025 04:21:35 +0000 (GMT)
X-AuditID: b6c32a44-363dc70000004cfe-1b-67ac21d07f90
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	54.58.18949.FC12CA76; Wed, 12 Feb 2025 13:21:35 +0900 (KST)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250212042135epsmtip27ac398f741ebd0f663b20b64dfcd6fcb~jWyT5Dqh80750307503epsmtip25
	for <stable@vger.kernel.org>; Wed, 12 Feb 2025 04:21:35 +0000 (GMT)
Message-ID: <3e84cb46-e2fe-4c72-9fd0-d49314b3e78e@samsung.com>
Date: Wed, 12 Feb 2025 09:51:34 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] usb: xhci: Fix unassigned variable
 'tmp_minor_revision' in xhci_add_in_port()
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Language: en-US
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
In-Reply-To: <20250211092400.734-2-selvarasu.g@samsung.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNKsWRmVeSWpSXmKPExsWy7bCmhu4FxTXpBhcPcFss2PiI0YHR4/Mm
	uQDGqGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKCh
	SgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCkwK94sTc4tK8dL281BIrQwMDI1Og
	woTsjLWnbjAX3OSsWHBfsYFxMkcXIyeHhICJxJt1h5i7GLk4hAR2M0p8ubWDFcLpZ5K4tOEy
	C4QzmUliyoy3bDAtMyb/Y4NI7GWUOHdhEzuE08UkceXzGRaQKl4BO4nfx56wgtgsAqoS8952
	MkPEBSVOznwCViMqIC9x/9YMdhBbWCBD4krTXjBbRMBU4sb0LWC9zALiEreezGfqYuTgYBMw
	lHh2wgbE5BSwllg03xWiQl5i+9s5YC9ICGxjlzjY/I8Z4lAXiWd3F7BD2MISr45vgbKlJD6/
	2wv1TLLEnklfoOIZEodWHYLqtZdYveAMK8guZgFNifW79CF28Un0/n4Cdo2EAK9ER5sQRLWq
	xKnGy1ATpSXuLbnGCmF7SFyf1Q0Nw/2MEjNuHmGcwCg/CykgZiF5chaSd2YhbF7AyLKKUTK1
	oDg3PTXZtMAwL7UcHsXJ+bmbGMGpTMtlB+ON+f/0DjEycTAeYpTgYFYS4TVZuCJdiDclsbIq
	tSg/vqg0J7X4EKMpMEYmMkuJJucDk2leSbyhiaWBiZmZmYmlsZmhkjhv886WdCGB9MSS1OzU
	1ILUIpg+Jg5OqQYms1WlT1L/HEz32HpX6qxCXFLWnamBYi++fF7LuqDhZcP1bmany3ls1Ttv
	+F6V6GcT7Q171nnnSk6rjpmu7+PtTDfWzi1xfM3R8fafwMqrNz8uMQuc8MFlm0K67cVN2gfr
	9iT8y3/YlVF21SSC2zv0y4mCXvdKSzWd9ZvL2zbyevVmtN4yEmL2FJXKfva1bkNpF8PBRdXf
	eA+o7Zs4+XSPCU/SjaNT4u8ZPnktprfzte0e1d1xrbELVBnvsnw792VSZVVL2RzPx7+Dyx7m
	ty3vYNk51196QUVWXenirWKhJ9XCv5tfu8H35c+WD9aPNGMC2pIn8+fVLji7ok2j4EphwqHp
	Lzw7rm0smvv31MIyJZbijERDLeai4kQA5f7UmO4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOLMWRmVeSWpSXmKPExsWy7bCSvO55xTXpBku361ss2PiI0YHR4/Mm
	uQDGKC6blNSczLLUIn27BK6MtaduMBfc5KxYcF+xgXEyRxcjJ4eEgInEjMn/2LoYuTiEBHYz
	Spz83MIOkZCWeD2rixHCFpZY+e85O0RRB5PE1zUdYAleATuJ38eesILYLAKqEvPedjJDxAUl
	Ts58wgJiiwrIS9y/NQNsqLBAhsSVpr1gtoiAqcSN6VtYIYbuZ5TofnyCDSTBLCAucevJfKYu
	Rg4ONgFDiWcnbEBMTgFriUXzXSEqzCS6tkLcxgw0fvvbOcwTGAVnIdk8C8mgWUhaZiFpWcDI
	sopRMrWgODc9t9iwwCgvtVyvODG3uDQvXS85P3cTIzhstbR2MO5Z9UHvECMTB+MhRgkOZiUR
	XpOFK9KFeFMSK6tSi/Lji0pzUosPMUpzsCiJ83573ZsiJJCeWJKanZpakFoEk2Xi4JRqYNqZ
	cjG5keFNT1hNj3vfke9Vt//c7t6btDPP/wOf+tUmsd/9Jiv+a9t/1ddmYEhSnrtse3Ps3Te9
	7ibzHk31XfhZ8+fb+fn+Fvzz7x8+ybtd68+vo781qzpkzdf9Vuq3vRx5YFVcWXi9X6YWs8SF
	NKcpTNdSGX4YBbFMeHIwYuGj8mN15gdr/kpVvNCeuvNd7tsLF4OtjzP7aYlpT07/ssuu9siC
	jgcPLV6tMjHdz2hWYWJw7VrPqqMySfxzNM2W/W3KfSAa9dF3t8bhALEdS1cWuMls2GtvsW8+
	B3vNqkPnZ+zreFa/5QpX6n57pjsyqZIWT1grpyTEvN79YSXTJTb59zviurTaksNiXss/mKHE
	UpyRaKjFXFScCABaSTjCygIAAA==
X-CMS-MailID: 20250212042135epcas5p2010a408a557678bf38414efdfeca7d42
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250211092453epcas5p17c1ddadb1294b8b3effd594418e752fc
References: <20250211092400.734-1-selvarasu.g@samsung.com>
	<CGME20250211092453epcas5p17c1ddadb1294b8b3effd594418e752fc@epcas5p1.samsung.com>
	<20250211092400.734-2-selvarasu.g@samsung.com>


On 2/11/2025 2:53 PM, Selvarasu Ganesan wrote:
> Fix the following smatch error:
> drivers/usb/host/xhci-mem.c:2060 xhci_add_in_port() error: unassigned variable 'tmp_minor_revision'
>
> Fixes: d9b0328d0b8b ("xhci: Show ZHAOXIN xHCI root hub speed correctly")
> Cc: stable@vger.kernel.org
> Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
> ---
>   drivers/usb/host/xhci-mem.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
> index 92703efda1f7..8665893df894 100644
> --- a/drivers/usb/host/xhci-mem.c
> +++ b/drivers/usb/host/xhci-mem.c
> @@ -1980,7 +1980,7 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
>   {
>   	u32 temp, port_offset, port_count;
>   	int i;
> -	u8 major_revision, minor_revision, tmp_minor_revision;
> +	u8 major_revision, minor_revision, tmp_minor_revision = 0;
>   	struct xhci_hub *rhub;
>   	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
>   	struct xhci_port_cap *port_cap;

Hello Maintainers,

Please ignore this changes as its duplicate of 
https://lore.kernel.org/all/1296674576.21739322782868.JavaMail.epsvc@epcpadp2new/


Thanks,

Selva


