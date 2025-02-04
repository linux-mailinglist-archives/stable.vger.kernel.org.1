Return-Path: <stable+bounces-112155-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 153D5A273D1
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 15:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82E017A1641
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 14:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56539213249;
	Tue,  4 Feb 2025 13:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nq+o1xBN"
X-Original-To: stable@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC43121322B
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 13:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738677402; cv=none; b=mXQ45Y1zQMKqu0BFOb6bSJ0Nud/QRyHeHh5Zdyr47viTzCxineuP/NMqvoiw+TfYfxVvz71pB7Z7qMeILtDrMphmNXEQZL1OHBJtcxZ67iOpXjjX103pHro/iJX8hH8tHDnGhFkBD/2UyURkFzP3XesuIuwx5zm/BI61MzJfKPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738677402; c=relaxed/simple;
	bh=MA05jaFSLZfUedsFN65m6VbXQIjYAu102gxjryuOpUY=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=b2QgVq49zAw8Iq5pmsoqgM4qK9J5H1Hr2ywB+RDBCxuZKxAgbaQ+DsX8voNJrVS4cURFG2b+fR7DBap286n7c1Cmorom16oZediGJuPCry23Hiovr+ULgJmvIVXQU4klKbeFj820tSVv+/aP56isPTwcsuCDmKHtwvux1Qi8yDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=nq+o1xBN; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250204135631epoutp04ff549f8bc5815d05b3a97fcdc9519b72~hBeAvRYDC0738107381epoutp04V
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 13:56:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250204135631epoutp04ff549f8bc5815d05b3a97fcdc9519b72~hBeAvRYDC0738107381epoutp04V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1738677391;
	bh=vzeBvSxuLukopUf6enF/gSvN1gMI6DZKQm8HjnQpzrc=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=nq+o1xBNalg8aGvQbuJRB1CK7QdJQOQqaiu0rUoj2VyRqPCZrAlFP9K6g3yKPUGYE
	 awY0BD+2t30zK8wContXHaLKOgyjT8r3r4BQ4mB7/OUks0h4tVBo9b6PijZFasSagD
	 lBsscWBVm54fy8cHyV62YerCnrfIedB+rkndW23Q=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20250204135630epcas5p1e25e570b0224871f7b08586f3d356d8f~hBeABjTLG2007020070epcas5p1n;
	Tue,  4 Feb 2025 13:56:30 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4YnPzc6cKdz4x9Pp; Tue,  4 Feb
	2025 13:56:28 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D4.DE.20052.C8C12A76; Tue,  4 Feb 2025 22:56:28 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250204135628epcas5p1d9a702b1f790f493b229d796de0be232~hBd9sKJus2007020070epcas5p1k;
	Tue,  4 Feb 2025 13:56:28 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250204135628epsmtrp2915142de6ed6ccd079105e5b0ec24a48~hBd9rOd0B1868618686epsmtrp2Y;
	Tue,  4 Feb 2025 13:56:28 +0000 (GMT)
X-AuditID: b6c32a49-3fffd70000004e54-f1-67a21c8c05e6
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	EF.E0.18949.C8C12A76; Tue,  4 Feb 2025 22:56:28 +0900 (KST)
Received: from INBRO002756 (unknown [107.122.3.168]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250204135625epsmtip1901feabdd5d886cfab64aee2b4f762d1~hBd65p09d1515215152epsmtip1R;
	Tue,  4 Feb 2025 13:56:25 +0000 (GMT)
From: "Alim Akhtar" <alim.akhtar@samsung.com>
To: "'Selvarasu Ganesan'" <selvarasu.g@samsung.com>,
	<gregkh@linuxfoundation.org>, <m.grzeschik@pengutronix.de>,
	<kees@kernel.org>, <abdul.rahim@myyahoo.com>, <quic_jjohnson@quicinc.com>,
	<quic_linyyuan@quicinc.com>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Cc: <thiagu.r@samsung.com>, <jh0801.jung@samsung.com>,
	<dh10.jung@samsung.com>, <naushad@samsung.com>, <akash.m5@samsung.com>,
	<rc93.raju@samsung.com>, <taehyun.cho@samsung.com>,
	<hongpooh.kim@samsung.com>, <eomji.oh@samsung.com>,
	<shijie.cai@samsung.com>, <stable@vger.kernel.org>
In-Reply-To: <20250118060134.927-1-selvarasu.g@samsung.com>
Subject: RE: [PATCH v2] usb: gadget: f_midi: Fixing wMaxPacketSize exceeded
 issue during MIDI bind retries
Date: Tue, 4 Feb 2025 19:26:21 +0530
Message-ID: <079801db770c$9610fc10$c232f430$@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKAq9PyrC3Jr3SNnCEbU5tom0LBzwIRS5/Xsdw2SkA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKJsWRmVeSWpSXmKPExsWy7bCmhm6PzKJ0g7939C2mT9vIavHm6ipW
	izsLpjFZnFq+kMmiefF6NotJe7ayWNx9+IPFYt3b86wWl3fNYbNYtKyV2WJL2xUmi09H/7Na
	NG65y2qx7vomRotVnXNYLI4s/8hkcfn7TmaLBRsfMVpMOihqsaK5ldlBxGPTqk42j/1z17B7
	HHtxnN2j/6+Bx8Q9dR59W1YxenzeJBfAHpVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCo
	a2hpYa6kkJeYm2qr5OIToOuWmQP0jpJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWn
	wKRArzgxt7g0L10vL7XEytDAwMgUqDAhO+PPgyNsBetEKxZs6GdrYPwm2MXIySEhYCLxYtV+
	1i5GLg4hgd2MEjcmbmOGcD4xSjxtuwyV+cYoMXHubmaYlrYfL6Gq9jJKbDnbywThvARqudnK
	AlLFJqArsWNxGxtIQkRgDpPEszmLwWYxCyxkkvj1aTk7SBWngLXE/TfNjCC2sECORNOEw2A2
	i4CKxP1Zn1hBbF4BS4nOfT0sELagxMmZT8BsZgFtiWULX0PdpCDx8+kysHoRASuJNdcbmSBq
	xCVeHj3CDrJYQuA/h8TBg3+hGlwkjj5YxQphC0u8Or6FHcKWkvj8bi8bhF0tsX7DPBYIu4NR
	onF7DYRtL7Hz0U2gOAfQAk2J9bv0IXbxSfT+fsIEEpYQ4JXoaBOCqFaVaH53FWqKtMTE7m6o
	rR4Sx7d0sUxgVJyF5LNZSD6bheSDWQjLFjCyrGKUTC0ozk1PLTYtMMxLLYdHeXJ+7iZGcHrX
	8tzBePfBB71DjEwcjIcYJTiYlUR4T29fkC7Em5JYWZValB9fVJqTWnyI0RQY3BOZpUST84EZ
	Jq8k3tDE0sDEzMzMxNLYzFBJnLd5Z0u6kEB6YklqdmpqQWoRTB8TB6dUA1OFwjnhWdM7BdZu
	i9zMM6e26KfkhKlzfv3sXKrUu3Jbhs7jZu/nyxTFtyYm/RF8/MWYb7LYQwexG1+0r3n/OzXx
	4VEjkXan9zvSVhxnbWeIn7P2v8KJ4tbOw1NS7GovBiSUMPaE3c1aer3R6Tl7QcOvRwpbgwIL
	7py3nd2vzxO2czuHaGqc+KeeqcdYVMxE7zKs4TVx+Vder/bma5qWW4rsL8u2KWWTlm2UUZjR
	tS1GVnVpyKWss/OKXjTZGpzt32cffvRtf+Li/8u2dFcvPW4t7DLH1mlGXNXG5QkR7h2xay8n
	1Ah/3LRwp/yWGqdtu6I3JR43CHZVn36kZMbbyJpnH5oEpaZ8vHUk41+W/30lluKMREMt5qLi
	RAAQUSOOeAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsWy7bCSnG6PzKJ0g0VP2SymT9vIavHm6ipW
	izsLpjFZnFq+kMmiefF6NotJe7ayWNx9+IPFYt3b86wWl3fNYbNYtKyV2WJL2xUmi09H/7Na
	NG65y2qx7vomRotVnXNYLI4s/8hkcfn7TmaLBRsfMVpMOihqsaK5ldlBxGPTqk42j/1z17B7
	HHtxnN2j/6+Bx8Q9dR59W1YxenzeJBfAHsVlk5Kak1mWWqRvl8CVsXrnKsaC3yIVJ79PZW9g
	3CnYxcjJISFgItH24yUziC0ksJtR4tu0JIi4tMT1jRPYIWxhiZX/ngPZXEA1zxklVm2/CZZg
	E9CV2LG4jQ0kISKwhEnieWMnM4jDLLCWSWLb3aXMEC09jBL7bt4Aa+EUsJa4/6aZEcQWFsiS
	uDF/HROIzSKgInF/1idWEJtXwFKic18PC4QtKHFy5hMwm1lAW6L3YSsjjL1s4WtmiPsUJH4+
	XQbWKyJgJbHmeiMTRI24xMujR9gnMArPQjJqFpJRs5CMmoWkZQEjyypGydSC4tz03GLDAqO8
	1HK94sTc4tK8dL3k/NxNjOAY19Lawbhn1Qe9Q4xMHIyHGCU4mJVEeE9vX5AuxJuSWFmVWpQf
	X1Sak1p8iFGag0VJnPfb694UIYH0xJLU7NTUgtQimCwTB6dUA9PavgvHima0hc/7e4+rbq9d
	f1GpWszRNTOnPl+8cfPbXef8qpWmv5uQcElH/HU5r8/pjEnLDAsbj0ce6bNYVX898uCH+Og7
	rkE2wmE5hVHK3ztM9z5UYN17+tJf1suljVrO8rmFs2Iz2nXe//ywqKT9qImz0h5lc1stlykx
	h0rdb76IuRvaPbl1v/++elfjz67cfDbXT2RwLe6WqnO98LPoZH9jlct0JelTwgXiuTr8sXba
	c+S2f7+VsNRdXMduXVDtm9/n5XP1PL6GMGe7bHjGZTSvRNN3z6JyGRuVpRYX//H/PikhrJnG
	O6F96cTLC1fWeq/4zlaYs+nLzAnyW4s+nZ71uDAvaPvrtYbKLkosxRmJhlrMRcWJACadUN5g
	AwAA
X-CMS-MailID: 20250204135628epcas5p1d9a702b1f790f493b229d796de0be232
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250118060207epcas5p3913957a1c5ec9b029f1d4953f6b29751
References: <CGME20250118060207epcas5p3913957a1c5ec9b029f1d4953f6b29751@epcas5p3.samsung.com>
	<20250118060134.927-1-selvarasu.g@samsung.com>

Hello Selvarasu,

> -----Original Message-----
> From: Selvarasu Ganesan <selvarasu.g=40samsung.com>
> Sent: Saturday, January 18, 2025 11:32 AM
> To: gregkh=40linuxfoundation.org; m.grzeschik=40pengutronix.de;
> kees=40kernel.org; abdul.rahim=40myyahoo.com; quic_jjohnson=40quicinc.com=
;
> quic_linyyuan=40quicinc.com; linux-usb=40vger.kernel.org; linux-
> kernel=40vger.kernel.org
> Cc: alim.akhtar=40samsung.com; thiagu.r=40samsung.com;
> jh0801.jung=40samsung.com; dh10.jung=40samsung.com;
> naushad=40samsung.com; akash.m5=40samsung.com;
> rc93.raju=40samsung.com; taehyun.cho=40samsung.com;
> hongpooh.kim=40samsung.com; eomji.oh=40samsung.com;
> shijie.cai=40samsung.com; Selvarasu Ganesan <selvarasu.g=40samsung.com>;
> stable=40vger.kernel.org
> Subject: =5BPATCH v2=5D usb: gadget: f_midi: Fixing wMaxPacketSize exceed=
ed
> issue during MIDI bind retries
>=20
> The current implementation sets the wMaxPacketSize of bulk in/out
> endpoints to 1024 bytes at the end of the f_midi_bind function. However, =
in
> cases where there is a failure in the first midi bind attempt, consider
> rebinding. This scenario may encounter an f_midi_bind issue due to the
> previous bind setting the bulk endpoint's wMaxPacketSize to 1024 bytes,
> which exceeds the ep->maxpacket_limit where configured dwc3 TX/RX
> FIFO's maxpacket size of 512 bytes for IN/OUT endpoints in support HS
> speed only.
>=20
> Here the term =22rebind=22 in this context refers to attempting to bind t=
he MIDI
> function a second time in certain scenarios. The situations where rebindi=
ng is
> considered include:
>=20
>  * When there is a failure in the first UDC write attempt, which may be
>    caused by other functions bind along with MIDI.
>  * Runtime composition change : Example : MIDI,ADB to MIDI. Or MIDI to
>    MIDI,ADB.
>=20
> This commit addresses this issue by resetting the wMaxPacketSize before
> endpoint claim. And here there is no need to reset all values in the usb
> endpoint descriptor structure, as all members except wMaxPacketSize and
> bEndpointAddress have predefined values.
>=20
> This ensures that restores the endpoint to its expected configuration, an=
d
> preventing conflicts with value of ep->maxpacket_limit. It also aligns wi=
th the
> approach used in other function drivers, which treat endpoint descriptors=
 as
> if they were full speed before endpoint claim.
>=20
> Fixes: 46decc82ffd5 (=22usb: gadget: unconditionally allocate hs/ss descr=
iptor in
> bind operation=22)
> Cc: stable=40vger.kernel.org
> Signed-off-by: Selvarasu Ganesan <selvarasu.g=40samsung.com>
> ---
Reviewed-by: Alim Akhtar <alim.akhtar=40samsung.com>

=5BSnip=5D
> 2.17.1



