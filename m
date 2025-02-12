Return-Path: <stable+bounces-114995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4829DA31D76
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 05:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE3601675B8
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 04:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130381DA612;
	Wed, 12 Feb 2025 04:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Rs1BINtZ"
X-Original-To: stable@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327F627182D
	for <stable@vger.kernel.org>; Wed, 12 Feb 2025 04:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739334217; cv=none; b=iR1CZIZCifIx/khIsSK3Wk9tzKNOnsJGEKPPjukRhCjKT5wKGxVtt+iY3iKsnmgJbPlCS/LZllzBtXqaYrLTYwdSqNXoCOUgeEyb2Q+phtRa+h+oFj0TNH5juFIlBBgdMZzJr2hXXzgyhzWRLY8DYx/7grDZDZ5/6J1ykS1RrFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739334217; c=relaxed/simple;
	bh=u3zgKya5Arz65pUkiwW7z7EyCWEd6Qya9YSt+bhAQrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:In-Reply-To:
	 Content-Type:References; b=EnF7Y52I7bfTXFbwMVVA8UOC+aBs9fkiQp61yZuGouLRFwXJO1pBgG3HDh0pDtb01HR0gW4pT3FHwmESlgG8KDF1eJsvLyPSxnRoR3YUsZTtKYEDrCDqbzKnSu5Z8L8XKxfzJGCfgcKvCHhdF9b4NMCBS4kHwDH14Io+EU5VCEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Rs1BINtZ; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250212042332epoutp0482e36fb30dd7ef6fc35446444727458d~jW0AyXupT0779207792epoutp04x
	for <stable@vger.kernel.org>; Wed, 12 Feb 2025 04:23:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250212042332epoutp0482e36fb30dd7ef6fc35446444727458d~jW0AyXupT0779207792epoutp04x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739334212;
	bh=CQwnRF7S/IMSu7D6EypZq4vpUbKhFraYaFkzFx2AFyQ=;
	h=Date:Subject:To:From:In-Reply-To:References:From;
	b=Rs1BINtZCX81q3R2pfwzylp6EW8aGoxCBxgWEUNiTSW33EuIvJGJzuoO/UZG36pyy
	 SNoCYJusz0NtPSJgRDBw8lRDrFS25OT0NivcgL2FtFZB08stO+w0TnOzaBH8ueTluC
	 7biwPCfRLnVPqXucLt20kxinN1msaYBChhrWRy8w=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20250212042332epcas5p431a509a65336d06d7b77cb808e07f3f2~jW0AoV_LL1159811598epcas5p4w
	for <stable@vger.kernel.org>; Wed, 12 Feb 2025 04:23:32 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Yt4tp5QGXz4x9Pw for
	<stable@vger.kernel.org>; Wed, 12 Feb 2025 04:23:30 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	89.03.29212.2422CA76; Wed, 12 Feb 2025 13:23:30 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250212042330epcas5p41d822741529c537759e311eb8179f79f~jWz_0V6r-1159811598epcas5p4m
	for <stable@vger.kernel.org>; Wed, 12 Feb 2025 04:23:30 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250212042330epsmtrp2072397db9f12ca5e04d2b51e75bddbfb~jWz_z1rT92828628286epsmtrp2M
	for <stable@vger.kernel.org>; Wed, 12 Feb 2025 04:23:30 +0000 (GMT)
X-AuditID: b6c32a50-7ebff7000000721c-8e-67ac2242625e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	2D.46.33707.2422CA76; Wed, 12 Feb 2025 13:23:30 +0900 (KST)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250212042329epsmtip13dd57c776d67c46baf77469d774bdfb1~jWz_as7FK0065300653epsmtip10
	for <stable@vger.kernel.org>; Wed, 12 Feb 2025 04:23:29 +0000 (GMT)
Message-ID: <f2e93cd0-b3a0-47d9-8252-88423cf71898@samsung.com>
Date: Wed, 12 Feb 2025 09:53:28 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] usb: xhci: Fix unassigned variable 'bcdUSB' in
 xhci_create_usb3x_bos_desc()
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Language: en-US
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
In-Reply-To: <20250211092400.734-3-selvarasu.g@samsung.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLKsWRmVeSWpSXmKPExsWy7bCmhq6T0pp0g7kn1SwWbHzE6MDo8XmT
	XABjVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtBQ
	JYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BSYFecWJucWleul5eaomVoYGBkSlQ
	YUJ2Rtufr0wFfZwVnbvWMjYw7mXvYuTkkBAwkdj/s5mpi5GLQ0hgD6PEt/+/2CGcfiaJR6/f
	scE5s78sZ4Vpad87CcwWEtjJKLFjUh1EUReTxNsZxxlBErwCdhLPV9wHs1kEVCVuTVrIDhEX
	lDg58wkLiC0qIC9x/9YMsLiwQJrErl2nwYaKCJhK3Ji+BcxmFhCXuPVkPtB9HBxsAoYSz07Y
	gIQ5BawlpuxbwARRIi+x/e0cZpAbJATWsUtcePGPGeJQF4m++7dYIGxhiVfHt0D9LCXx+d1e
	Ngg7WWLPpC9Q8QyJQ6sOQfXaS6xecIYVZC+zgKbE+l36ELv4JHp/PwE7R0KAV6KjTQiiWlXi
	VONlqInSEveWXIMGlYfEp6NvWCHBs59R4v+F4+wTGOVnIYXELCRfzkLyziyEzQsYWVYxSqUW
	FOempyabFhjq5qWWwyM5OT93EyM4nWkF7GBcveGv3iFGJg7GQ4wSHMxKIrwmC1ekC/GmJFZW
	pRblxxeV5qQWH2I0BcbJRGYp0eR8YELNK4k3NLE0MDEzMzOxNDYzVBLnbd7Zki4kkJ5Ykpqd
	mlqQWgTTx8TBKdXAVCPIJ+qWJ/xJJjxK9HDZljObtSJ5uOyiFKbbG5jOLr/cyqEa6932Ruzd
	pI4Iy/p/+z13nFmx6JXMxzYdvtmxZotfXKgxCzwYtJb5U/Ky66f78y4sP3iCZdm0hD0HNwSK
	Sut5TA3bX8fznL3gnJC9cF4u6wXXNyoF3nv8nRNO3+qs2PLGxnH/zCvxVtM2no21uscbt739
	HOu3nVFsXwPFAvS/X8pQKovjtzgbk/F4R6X6+eK8r16xD91Offu2ldv39fZJIVvUWgwPMTsn
	ZJQv75G/6r/K9pxP8BOJF3e5ot6sNfxuF5F4+2vgllX9abmCdmaqSQK5qzYLnGG7suJ3tQmf
	G/9Ez2WFc1lmOZ1QYinOSDTUYi4qTgQAhJIEE/ADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCLMWRmVeSWpSXmKPExsWy7bCSnK6T0pp0g+ZT3BYLNj5idGD0+LxJ
	LoAxissmJTUnsyy1SN8ugSuj7c9XpoI+zorOXWsZGxj3sncxcnJICJhItO+dxApiCwlsZ5TY
	MikMIi4t8XpWFyOELSyx8t9zoHouoJoOJomTDXfAErwCdhLPV9wHs1kEVCVuTVrIDhEXlDg5
	8wkLiC0qIC9x/9YMsLiwQJrErl2nwZaJCJhK3Ji+hRVi6H5GiatTVoElmAXEJW49mc/UxcjB
	wSZgKPHshA1ImFPAWmLKvgVMECVmEl1bIY5jBpq//e0c5gmMgrOQrJ6FZNIsJC2zkLQsYGRZ
	xSiaWlCcm56bXGCoV5yYW1yal66XnJ+7iREcsFpBOxiXrf+rd4iRiYPxEKMEB7OSCK/JwhXp
	QrwpiZVVqUX58UWlOanFhxilOViUxHmVczpThATSE0tSs1NTC1KLYLJMHJxSDUxSjqrOXizG
	ulPLDrFds1+3pD/w261U1inmLL57JHgm5kf+P+DGcje7Vzfa21rSJGv9yrVv+m0+pMyaFScz
	7dzax1+DROJ+LFBdH/lJ7kZsnsnC3fXxIjf/KPVvfJIm5+88W8Ez6ExiU/QK3rlXPc+cTH06
	OejUnNiUl1vXnd7++roIe+PtM5z3Ftw78EQn8nSsD88/+Sf9Zx3vu9zMNNwRHaup3tfivttz
	Q+E5ueOp97b2HD8zUceMO45b12HNp0nTeY11+JTmxmUJvz7L1GfQKvjA+cLi/xISsy7dPKF0
	cyPzKsX9rhcmm9bd6dpddVlE4df9tW3tASrM/badrEs0hc4oRrcfeXDGkFHc5pcSS3FGoqEW
	c1FxIgAqIYVBxwIAAA==
X-CMS-MailID: 20250212042330epcas5p41d822741529c537759e311eb8179f79f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250211092458epcas5p1a00969c88bb6db8d885b3b11c37c9cfa
References: <20250211092400.734-1-selvarasu.g@samsung.com>
	<CGME20250211092458epcas5p1a00969c88bb6db8d885b3b11c37c9cfa@epcas5p1.samsung.com>
	<20250211092400.734-3-selvarasu.g@samsung.com>


On 2/11/2025 2:53 PM, Selvarasu Ganesan wrote:
> Fix the following smatch error:
> drivers/usb/host/xhci-hub.c:71 xhci_create_usb3x_bos_desc() error: unassigned variable 'bcdUSB'
>
> Fixes: eb02aaf21f29 ("usb: xhci: Rewrite xhci_create_usb3_bos_desc()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
> ---
>   drivers/usb/host/xhci-hub.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
> index 9693464c0520..5715a8bdda7f 100644
> --- a/drivers/usb/host/xhci-hub.c
> +++ b/drivers/usb/host/xhci-hub.c
> @@ -39,7 +39,7 @@ static int xhci_create_usb3x_bos_desc(struct xhci_hcd *xhci, char *buf,
>   	struct usb_ss_cap_descriptor	*ss_cap;
>   	struct usb_ssp_cap_descriptor	*ssp_cap;
>   	struct xhci_port_cap		*port_cap = NULL;
> -	u16				bcdUSB;
> +	u16				bcdUSB = 0;
>   	u32				reg;
>   	u32				min_rate = 0;
>   	u8				min_ssid;


Hello Maintainers,

Please ignore this changes as its duplicate of 
https://lore.kernel.org/lkml/1931444790.41739322783086.JavaMail.epsvc@epcpadp2new/


Thanks,

Selva


