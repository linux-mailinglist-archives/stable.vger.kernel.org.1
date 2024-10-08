Return-Path: <stable+bounces-81511-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70189993E52
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 07:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F0BE1C23420
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 05:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2F113B5B6;
	Tue,  8 Oct 2024 05:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OwVw1E4H"
X-Original-To: stable@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFD213AD39
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 05:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728365244; cv=none; b=iqfaVuLBU9Vn4UFN2XdlGfa1xGGN4b/dqk0r6K93eom8ZmHuHlYKrXDk756jbmqUo8vby6tttQ0Ldptw37kRY+tWmyVUc1gS77X9UXySKcDD522RbabK6sQoV9NcFR74c5y2Ha1/xQea9zMYk4YFEJJs4u3kZVPBuVHUfeNs+40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728365244; c=relaxed/simple;
	bh=EskIgQGaVYik1TOykQFgqhRsyF7puT+stjiJ7ZctOK8=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=BNOzdQLAlD7BxONd9mk3nwnDDri+c0so1cdMq/2X4syovDrUecSdodMDx3IDiiWDqoXlaQMHVusP/GuhF5wWtP2dfL1lJYLZ+sJzFAUuRY22nPBam5+7G2hJP8aGWvw5JCrEKmNFLZJCEkIVCbuT4YYzgiGieZBuGhLKXchW1qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=OwVw1E4H; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20241008052713epoutp03796b013c92eb425209943ef5995c8190~8YwXmpmxx0139901399epoutp03g
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 05:27:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20241008052713epoutp03796b013c92eb425209943ef5995c8190~8YwXmpmxx0139901399epoutp03g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1728365234;
	bh=vslstNqi5KSw2l1/1ZABEhouzxk6y+4NfK2kokOZB3M=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=OwVw1E4HgbhiD6S0d26cZvd+7VfDqCcKxlBtqLI1Ea5W4sEHGkyiqMnRJJzDzEOgZ
	 dCpsw1gLdRIWDf74qpEcnBd+TGFVrs/gdNh2DCejl+gdq0o7tmdlTUGfXPxgHEjouL
	 T3pI4PKFWGmOpq4+oV2KykEU6cahiXVDl3i612TE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20241008052713epcas1p48b8b42c8681b47f56b9b6e7a5d758b57~8YwW6lDkB1383713837epcas1p4q;
	Tue,  8 Oct 2024 05:27:13 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.240]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4XN4Jx16N5z4x9QC; Tue,  8 Oct
	2024 05:27:13 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
	epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	CE.DD.09951.0B2C4076; Tue,  8 Oct 2024 14:27:12 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20241008052712epcas1p14c4979986493bd49ee33851111c24b3b~8YwWU3Yi11698416984epcas1p1C;
	Tue,  8 Oct 2024 05:27:12 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241008052712epsmtrp2ca9c02c10fe632ec1dc75d80349ff99b~8YwWTuptp3171731717epsmtrp2H;
	Tue,  8 Oct 2024 05:27:12 +0000 (GMT)
X-AuditID: b6c32a38-3d6c2a80000026df-33-6704c2b0ab00
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	08.41.18937.0B2C4076; Tue,  8 Oct 2024 14:27:12 +0900 (KST)
Received: from sh8267baek02 (unknown [10.253.99.49]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20241008052712epsmtip27d956e3b55b3b6754dd345c90ece5fb1~8YwV-Qxxx0978809788epsmtip2c;
	Tue,  8 Oct 2024 05:27:12 +0000 (GMT)
From: "Seunghwan Baek" <sh8267.baek@samsung.com>
To: "'Bart Van Assche'" <bvanassche@acm.org>,
	<linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
	<martin.petersen@oracle.com>, <James.Bottomley@HansenPartnership.com>,
	<avri.altman@wdc.com>, <alim.akhtar@samsung.com>
Cc: <grant.jung@samsung.com>, <jt77.jang@samsung.com>,
	<junwoo80.lee@samsung.com>, <dh0421.hwang@samsung.com>,
	<jangsub.yi@samsung.com>, <sh043.lee@samsung.com>, <cw9316.lee@samsung.com>,
	<wkon.kim@samsung.com>, <stable@vger.kernel.org>, <kwmad.kim@samsung.com>,
	<sh425.lee@samsung.com>, <hy50.seo@samsung.com>, <kwangwon.min@samsung.com>,
	<h10.kim@samsung.com>
In-Reply-To: 
Subject: RE: [PATCH v1 1/1] ufs: core: set SDEV_OFFLINE when ufs shutdown.
Date: Tue, 8 Oct 2024 14:27:12 +0900
Message-ID: <017801db1942$ba6a5bb0$2f3f1310$@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQITd6wvsWq6bg+5ypABxh1kBxxfMwHy7pIVAtyJc3gCDAIdKwI4d05OAHuLQEuxqsQ7wIAUVLcA
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAJsWRmVeSWpSXmKPExsWy7bCmru7GQyzpBrODLR7M28Zm8fLnVTaL
	aR9+MlvMONXGarHv2kl2i19/17Nb/L19kdVi9eIHLBYb+zksOrZOZrLY8fwMu8Wuv81MFltv
	7GSxuLnlKIvF5V1z2Cy6r+9gs1h+/B+TRdOffSwWS/+9ZbFYsPERo8XmS99YHEQ9Ll/x9pg2
	6RSbx8ent1g8+rasYvT4vEnOo/1AN1MAW1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGh
	rqGlhbmSQl5ibqqtkotPgK5bZg7QO0oKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpSc
	ArMCveLE3OLSvHS9vNQSK0MDAyNToMKE7Ix1jTIFz7kqpqz7ydbAeJWji5GTQ0LAROLX+ybm
	LkYuDiGBHYwSR399Z4NwPjFKrF3YxQzn3P50gxWmZXHvP6iqnYwSp+d/ZIdwXjJKzJ1+EKyK
	TcBAovnHQbCECEhix5brLCAOs8BnJomLNyYCDebg4BTglZjwzxqkQVjAS+LHthNMIDaLgIpE
	799/jCAlvAKWEjdXy4KEeQUEJU7OfMICYjMLyEtsfzuHGeIiBYmfT5eB7RURiJJo+PiQCaJG
	RGJ2ZxvYCxICzZwSf892QL3gItF5uxuqWVji1fEt7BC2lMTnd3vZIOxiiYUbJ7FANLcwSlxf
	/ocRImEv0dzazAZyHLOApsT6XfoQy/gk3n3tYQUJSwC91dEmBFGtKnFqw1aoTmmJ680NUCd4
	SGxct595AqPiLCSvzULy2iwkL8xCWLaAkWUVo1hqQXFuemqxYYEJPLaT83M3MYKTupbFDsa5
	bz/oHWJk4mA8xCjBwawkwhuxhjFdiDclsbIqtSg/vqg0J7X4EKMpMKwnMkuJJucD80peSbyh
	iaWBiZmRiYWxpbGZkjjvmStlqUIC6YklqdmpqQWpRTB9TBycUg1MZYd5/r/tlAr4fslzbYJv
	gp+ZwUPL2nceH8981TQ6kRN6f3mdnJNBdfHZfVEachwHP7ZMWdxUER16SNe1zP6UeUKi82aG
	qZnb9uetiX8cm3om3XLnhlamCWpVT5VX8MuLS9xYdevJpRsmP/edVSiq1Lxueq1WMOVXzBZL
	FiHpX83qubrODjMF2ktYF+eJz1a1j/n0cFfehkPHOXlYfb5/mm68M7mIPZnliHDVxqAvD5ce
	27/mjol+/LTNazj4Ep/fCTKTmbJQQvPPvRcRj2WPJ0rZ203Y8NMy6PrX7EKdL557wqunXnp2
	R/fkpb9OBsEFa4oanPUnJ5yct8LVYNfpd2yPk3gWrpy2ZFHRpCVvlViKMxINtZiLihMBdzpM
	LHMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsWy7bCSvO6GQyzpBvtmS1s8mLeNzeLlz6ts
	FtM+/GS2mHGqjdVi37WT7Ba//q5nt/h7+yKrxerFD1gsNvZzWHRsncxkseP5GXaLXX+bmSy2
	3tjJYnFzy1EWi8u75rBZdF/fwWax/Pg/JoumP/tYLJb+e8tisWDjI0aLzZe+sTiIely+4u0x
	bdIpNo+PT2+xePRtWcXo8XmTnEf7gW6mALYoLpuU1JzMstQifbsErox1jTIFz7kqpqz7ydbA
	eJWji5GTQ0LARGJx7z+2LkYuDiGB7YwS/3/OYoJISEs8PvCSsYuRA8gWljh8uBii5jmjxPOH
	C9lBatgEDCSafxxkB0mICLxnlDj+Zx2YwyzQzCzR/3ku1NhTTBLTTi5iARnFKcArMeGfNUi3
	sICXxI9tJ8C2sQioSPT+/Qe2jVfAUuLmalmQMK+AoMTJmU9YQGxmAW2JpzefQtnyEtvfzmGG
	OFRB4ufTZawgtohAlETDx4dMEDUiErM725gnMArPQjJqFpJRs5CMmoWkZQEjyypG0dSC4tz0
	3OQCQ73ixNzi0rx0veT83E2M4LjWCtrBuGz9X71DjEwcjIcYJTiYlUR4I9YwpgvxpiRWVqUW
	5ccXleakFh9ilOZgURLnVc7pTBESSE8sSc1OTS1ILYLJMnFwSjUwWe9bWPvO8W2/3LvbeXHF
	6XFbOzKuG28vWn/q22TT9bGlkk/eRqROf6+i/rItN+BbU82UcE91dbM3nhUOq3jyYv1e8X41
	a41x4936WbC0MmBxSGj+l8Qgq7zbeTvO/57Ar1tlzKf35m8c66RU0ek/n1gJswcflfSMbn22
	NyFli5PY0aNnrs1+sE3DQ5Bpved+t/Q/2y8++eZ1++UfXq1ViQGigUyvF21bM//S3501XRnx
	bAoNJhcytq71vL5k3kr5jPBFu5pv/Vw/1WdabNl5jimp76w35t3f0fZ4f8MvVhmGifaT2852
	X4k+c+r5oQXZRucs36/cJXJ76vGFDS66lZHZ9WH/poTm3pOoerdjoxJLcUaioRZzUXEiADX4
	Cg1aAwAA
X-CMS-MailID: 20241008052712epcas1p14c4979986493bd49ee33851111c24b3b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240829093921epcas1p35d28696b0f79e2ae39d8e3690f088e64
References: <20240829093913.6282-1-sh8267.baek@samsung.com>
	<CGME20240829093921epcas1p35d28696b0f79e2ae39d8e3690f088e64@epcas1p3.samsung.com>
	<20240829093913.6282-2-sh8267.baek@samsung.com>
	<fa8a4c1a-e583-496b-a0a2-bd86f86af508@acm.org>
	<003201db0e27$df93f250$9ebbd6f0$@samsung.com>
	<1845f326-e9eb-4351-9ed1-fce373c82cb0@acm.org> 

> > On 9/23/24 7:17 PM, Seunghwan Baek wrote:> That's because SSU (Start
> > Stop
> > Unit) command must be sent during
> > > shutdown process. If SDEV_OFFLINE is set for wlun, SSU command
> > > cannot be sent because it is rejected by the scsi layer. Therefore,
> > > we consider to set SDEV_QUIESCE for wlun, and set SDEV_OFFLINE for
> > > other lus.
> > Right. Since ufshcd_wl_shutdown() is expected to stop all DMA related
> > to the UFS host, shouldn't there be a scsi_device_quiesce(sdev) call
> > after the __ufshcd_wl_suspend(hba, UFS_SHUTDOWN_PM) call?
> >
> > Thanks,
> >
> > Bart.
> 
> Yes. __ufshcd_wl_suspend(hba, UFS_SHUTDOWN_PM) should be called after
> scsi_device_quiesce(sdev). Generally, the SSU command is the last command
> before UFS power off. Therefore, if __ufshcd_wl_suspend is performed
> before scsi_device_quiesce, other commands may be performed after the SSU
> command and UFS may not guarantee the operation of the SSU command, which
> may cause other problems. This order must be guaranteed.
> 
> And with SDEV_QUIESCE, deadlock issue cannot be avoided due to requeue.
> We need to return the i/o error with SDEV_OFFLINE to avoid the mentioned
> deadlock problem.

(+ more CC added.)
Dear All.

Could you please update for this patch?
If you have any opinions about this patch, share and comment it.

Thanks.
BRs.


