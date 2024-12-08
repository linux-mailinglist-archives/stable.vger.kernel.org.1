Return-Path: <stable+bounces-100074-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE02B9E85F2
	for <lists+stable@lfdr.de>; Sun,  8 Dec 2024 16:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA6C9163D86
	for <lists+stable@lfdr.de>; Sun,  8 Dec 2024 15:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CB3156861;
	Sun,  8 Dec 2024 15:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="E/Kid56y"
X-Original-To: stable@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C2A15575F
	for <stable@vger.kernel.org>; Sun,  8 Dec 2024 15:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733671726; cv=none; b=c1+NKpm1bjQ8Tj1l5MQ3K1m1yooFFKY3e/+uYGlgeuamwS40oLnvelsKp16p8t1lcn+E2pogzMRS9zRXFH5FHtYacKyQ+O9ToDuPIH6o2CjrBmpKJVYlO8tvhitnh2Gh/AySpPTZi3YQ7M6hPmxdvuxpkMGAf1Wr7smvDj89tuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733671726; c=relaxed/simple;
	bh=eqaHJaJtdEALeICfQsxu0/49lbIYZiSJuFshPwgvAas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=aFR0vpWxaxm/DlK+BdbY91VaoxSWVr1xQ5Ht/jrWS5E3DmOpOc+RdrQRBXQZ+pgYIcM0CFFkPlzJL+tDzsvCOZGV8wx44U8hbQx/2eU/wqDJcCdQ1UHZODcPx4T8mVMMwfEsk2QT0IZcro7BhtkwhpX++sahR/pjV/bMcu4peMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=E/Kid56y; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20241208152840epoutp0410be08f315f69c8e284fd720a670368a~PPT6BSO5T1260512605epoutp04f
	for <stable@vger.kernel.org>; Sun,  8 Dec 2024 15:28:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20241208152840epoutp0410be08f315f69c8e284fd720a670368a~PPT6BSO5T1260512605epoutp04f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733671720;
	bh=cxPQJm/PlbH2oCbROnF9YnCFq0CJs9o6xvvNy4xLq9o=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=E/Kid56yxNqKoKaqs0YQRcO08EHEOtytaZGgt7oc3ZLnDelFTY4OodqO0gjgmS1FZ
	 ekuX/QO0Veyf2I3AhxTRmTOO8libSdymAMOa0Z1/L5UdEzYpUMW3zvYC1MAc4VuGq/
	 59yV4GibrtKj7MtY+mgEDBGSkQ3d8Jm/nncqAX/M=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20241208152838epcas5p1746be708a6bf55ac4627a0ae15949136~PPT4Z14dh2168421684epcas5p1a;
	Sun,  8 Dec 2024 15:28:38 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Y5pmj2lJyz4x9Pv; Sun,  8 Dec
	2024 15:28:37 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	95.3C.20052.52BB5576; Mon,  9 Dec 2024 00:28:37 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20241208152836epcas5p44d01d9b815398293040823beb813144e~PPT2Ouww81629316293epcas5p4A;
	Sun,  8 Dec 2024 15:28:36 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241208152836epsmtrp148b8a379d74d723679b7fd1b73bd440b~PPT2NZg8H1210012100epsmtrp1N;
	Sun,  8 Dec 2024 15:28:36 +0000 (GMT)
X-AuditID: b6c32a49-3d20270000004e54-76-6755bb252048
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	29.FB.18729.32BB5576; Mon,  9 Dec 2024 00:28:35 +0900 (KST)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241208152833epsmtip1e71cd432c3627c320268e29a90ef38e2~PPTzopKK71392813928epsmtip1c;
	Sun,  8 Dec 2024 15:28:33 +0000 (GMT)
Message-ID: <5d4e59f0-76a7-43bf-8a96-9aa4f9e2a9ac@samsung.com>
Date: Sun, 8 Dec 2024 20:58:32 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: f_midi: Fixing wMaxPacketSize exceeded
 issue during MIDI bind retries
To: Faraz Ata <faraz.ata@samsung.com>, gregkh@linuxfoundation.org,
	quic_jjohnson@quicinc.com, kees@kernel.org, abdul.rahim@myyahoo.com,
	m.grzeschik@pengutronix.de, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jh0801.jung@samsung.com, dh10.jung@samsung.com, naushad@samsung.com,
	akash.m5@samsung.com, rc93.raju@samsung.com, taehyun.cho@samsung.com,
	hongpooh.kim@samsung.com, eomji.oh@samsung.com, shijie.cai@samsung.com,
	alim.akhtar@samsung.com, stable@vger.kernel.org
Content-Language: en-US
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
In-Reply-To: <20241208151314.1625-1-faraz.ata@samsung.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0wTdxzA87vrtQdZ2a3Q8ROTQTqI8m61LYcBFXWswqZNjEvGXLqzXFrS
	Z3rF10R5CBmIOKqRh8CAsVfZIDCGgDjXuslEp9mYSlCeojKBWbFzsqGs5bqN/z7f9+v3w1HB
	CDcEzzJaaYuR0ou4/pzOC5GrYyPO7tSI88/wyYpTbRg5c92OkWN1nVzydv0phOz/rAEhbww2
	8MiCj1u5pK33Gw45PP6UQ7bMXsPIgZ4aLtn4aSFKdhT9ipBzPyxiZF7HMEbai2s45MCf3ShZ
	3zYBSJtDuDFQ0W4v5irO137JU1yc6uMpjj8TK8p7DynKOuxA8bj9FSUvQ5ekpalM2hJGG9Wm
	zCyjJlmUvkO1WSWTiyWxkkQyQRRmpAx0smjLG8rY1Cy9ZxJR2B5Kn+1RKSmGEcWvT7KYsq10
	mNbEWJNFtDlTb5aa4xjKwGQbNXFG2rpOIhavkXkc39Npr45c45gHiX3uK/dALrjPLwE4Dgkp
	/K4vsQT44wLiLIDltgUOK8x5hNYFjBWeAHi07aLH4rcUMVkw4DOcA/DWzRbUaxAQswDWPonz
	Mp9YDzsbryJe5hDh8NxCM8rqX4KXqiaXEgmJUDg6VMnzciCRBf+oKAHepEHEOIBz87moV0CJ
	UgSWuhyY1wslguHQ5EeIt3EuIYH3fkzyqv2IdbCluIDLuoTCM7M1S7GQcOPQ0TaEsG1vgfmF
	Q1yWA+GDvg4eyyHwt+NFPlbDXpvbx1rotDtRljfA5vormLcuSkTC1p54tlYAPPb3JMLukQ8/
	KBKw3hGwP2/AV2klHGm6gbGsgDOuC771HgNw6nkD90MQVr1sL9XLpqxeNk71/5XrAccOVtBm
	xqChGZlZYqT3/ndwtcnQDpYeetTWLjA85opzAgQHTgBxVBTEx9N3agT8TGr/AdpiUlmy9TTj
	BDLPgcrREKHa5PkpRqtKIk0US+VyuTRxrVwiCuZPF9ZmCggNZaV1NG2mLf/GIbhfSC6yvUwv
	UM5Gfzupiw53b92svNSkQiNX7S1gHKf55ZtOTFsOxRoXsJGexrW/UGmld48a8l6u++Tk9GuV
	8TN1TkytjX60ySUMCH+h7FXZbH13yh13moOXczjhxB1TwU/SnEcbsu8OWPMWSx6spPNV8qmf
	g3bFPDzdOT9uFafPd5RJX0w9IFMOWt0pmsua1xfH3u/7vVKli9F1P+2aWHBJ9z07+W5VkWtH
	jt/DPV1f5B3BM2KCj9xOm9j4Nv+rFfqbb4Jduw+Gf/958Wjoeb+3vjasGrwMou4rR6oON/N1
	qaCizvbOXxJ0aPvB5wlZEZqM/pTdt+b2Xx9dE0wH+WMB89vKmoSdj0UcRktJolALQ/0Decwd
	eHEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsWy7bCSnK7K7tB0g5UBFtOnbWS1eHN1FavF
	g3nb2CzuLJjGZHFq+UImi2s3FrJbNC9ez2Yxac9WFou7D3+wWKx7e57V4vKuOWwWi5a1Mlts
	abvCZPHp6H9Wi8Ytd1ktVnXOYbG4/H0ns8WCjY8YLSYdFHUQ9ti0qpPNY//cNewex14cZ/fo
	/2vgMXFPnUffllWMHp83yQWwR3HZpKTmZJalFunbJXBlnLt3nqXghkDFlzPPGBsYn/N2MXJy
	SAiYSDxpvszaxcjFISSwm1Hi8vRuNoiEtMTrWV2MELawxMp/z9khil4zSjw/2s8KkuAVsJPY
	tugcE4jNIqAisffPamaIuKDEyZlPWEBsUQF5ifu3ZrCD2MICmRL3Ts1kAxkkIvCQUeLh81tg
	U5kFepgkrq95zAaxopdR4ta6uWCjmAXEJW49mQ+0goODTcBQ4tkJG5Awp4CVxLrOZjaIEjOJ
	rq0QpzIDbdv+dg7zBEahWUgOmYVk0iwkLbOQtCxgZFnFKJlaUJybnltsWGCYl1quV5yYW1ya
	l66XnJ+7iREcv1qaOxi3r/qgd4iRiYPxEKMEB7OSCC+Hd2i6EG9KYmVValF+fFFpTmrxIUZp
	DhYlcV7xF70pQgLpiSWp2ampBalFMFkmDk6pBqZZQbvn7/2/6fG+X2afjry7zaM6/4ti8tpv
	n3MCj2VHRrpz9Hl0mz9+22L0/f9Oxi0NUmkbbxhVrVxbdufN+cjzcnO8Q36d5d38oeXS3dNt
	GrfLWSIO9NUVJ7duvDw/W7vyl/FUnuYZ130kgkzW9v7ZqyesKehVqJ2/anlF9BcB6Yzkiu78
	l11fwxgT5ZyurZ6wr+Z8TeGEnVuX81jxxPQF3F6qbVb7fZ9p1J01a+T89zTN/eAryb5WKObi
	o5j2UGa1/ZVmV30iEkzr5kcplzy1q2Nh27yIczVTxIaHR545ThbLZfrI/cdI2ENU+vmzSz/+
	e/Pun6b/z/6fjMOEnwkTm/d4T9XavWxz4bx7DH+VWIozEg21mIuKEwENB9SiTgMAAA==
X-CMS-MailID: 20241208152836epcas5p44d01d9b815398293040823beb813144e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241208151349epcas5p1a94ca45020318f54885072d4987160b3
References: <CGME20241208151349epcas5p1a94ca45020318f54885072d4987160b3@epcas5p1.samsung.com>
	<20241208151314.1625-1-faraz.ata@samsung.com>

Hello Maintainers,

Please ignore this commit as this duplicate copy of 
https://lore.kernel.org/linux-usb/20241208152322.1653-1-selvarasu.g@samsung.com/ 


Thanks,

Selva


On 12/8/2024 8:43 PM, Faraz Ata wrote:
> From: Selvarasu Ganesan <selvarasu.g@samsung.com>
>
> The current implementation sets the wMaxPacketSize of bulk in/out
> endpoints to 1024 bytes at the end of the f_midi_bind function. However,
> in cases where there is a failure in the first midi bind attempt,
> consider rebinding. This scenario may encounter an f_midi_bind issue due
> to the previous bind setting the bulk endpoint's wMaxPacketSize to 1024
> bytes, which exceeds the ep->maxpacket_limit where configured TX/RX
> FIFO's maxpacket size of 512 bytes for IN/OUT endpoints in support HS
> speed only.
> This commit addresses this issue by resetting the wMaxPacketSize before
> endpoint claim
>
> Fixes: 46decc82ffd5 ("usb: gadget: unconditionally allocate hs/ss descriptor in bind operation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
> ---
>   drivers/usb/gadget/function/f_midi.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/drivers/usb/gadget/function/f_midi.c b/drivers/usb/gadget/function/f_midi.c
> index 837fcdfa3840..5caa0e4eb07e 100644
> --- a/drivers/usb/gadget/function/f_midi.c
> +++ b/drivers/usb/gadget/function/f_midi.c
> @@ -907,6 +907,15 @@ static int f_midi_bind(struct usb_configuration *c, struct usb_function *f)
>   
>   	status = -ENODEV;
>   
> +	/*
> +	 * Reset wMaxPacketSize with maximum packet size of FS bulk transfer before
> +	 * endpoint claim. This ensures that the wMaxPacketSize does not exceed the
> +	 * limit during bind retries where configured TX/RX FIFO's maxpacket size
> +	 * of 512 bytes for IN/OUT endpoints in support HS speed only.
> +	 */
> +	bulk_in_desc.wMaxPacketSize = cpu_to_le16(64);
> +	bulk_out_desc.wMaxPacketSize = cpu_to_le16(64);
> +
>   	/* allocate instance-specific endpoints */
>   	midi->in_ep = usb_ep_autoconfig(cdev->gadget, &bulk_in_desc);
>   	if (!midi->in_ep)

