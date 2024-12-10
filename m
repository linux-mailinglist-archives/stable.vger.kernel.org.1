Return-Path: <stable+bounces-100430-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 933E59EB22B
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 14:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BD1E161E73
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 13:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C9B1E515;
	Tue, 10 Dec 2024 13:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qN1MKIUV"
X-Original-To: stable@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE6519D897
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 13:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733838542; cv=none; b=n+jTRRSNNcgyLXykSN/MJD5cvE1A+/Ykf/rEyn6+0+ZpvuOLVzDskUz8K5PSTsmf399ROo1f5WATMjqM6qQDUZ2zRGKqS1Cdr08w9Q2isRep0/Wm+VPyxtaXlPAXnaHyMmHp4JDCZ1MJYOAYyNLLAhnjRB2liKg1UX2VYFYSKks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733838542; c=relaxed/simple;
	bh=kFLaa7OZkIiEewnmLkzqPLDzF9A+FNVIy0qIEKqjUrU=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=h72CbPjTMPjR2ZhZOOh19LeCfgSAqC+D+LiCLw85mvZ8N3H8Cc+f6GKFq56P7fFkuKw2DrfnwLQ9Dfb9+hqZkEL9h94QiHqnojY08O+jEhFOX4iI1JRrZGGqZpHU7Xlo4mm4CYBdfr9OumBMg9HPNLD1C6MsvMlMKhWYbM94rwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=qN1MKIUV; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20241210134857euoutp018d174879903b2f05b932ea2ed6e39b83~P1PaUFo6k3088430884euoutp01-
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 13:48:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20241210134857euoutp018d174879903b2f05b932ea2ed6e39b83~P1PaUFo6k3088430884euoutp01-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733838537;
	bh=kFLaa7OZkIiEewnmLkzqPLDzF9A+FNVIy0qIEKqjUrU=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=qN1MKIUVZ/wFN00fVRoadcfJ7O4CJg8PbjerWwEM2d6kLdJlb3/B0ML/59I+mZDYK
	 jcCg6oSmoXgmCNeecMRwZ1KrWb33ZPyB7i06Y2ew18aosNGvVqhMIXDM/V1M3O7/Lu
	 5cuS6j7oRO126vRJl2PoG0LDDLg7ArE31MZvsd5U=
Received: from eusmges1new.samsung.com (unknown [182.198.248.176]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20241210134855eucas1p1bb1cae1cc7df3100fe2dce34f5fd6484~P1PY0lkwq1432214322eucas1p1g;
	Tue, 10 Dec 2024 13:48:55 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 42.08.20821.7C648576; Tue, 10
	Dec 2024 13:48:55 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20241210134854eucas1p2013320e1391bb52afd77847baff2c628~P1PYPzSxH2947729477eucas1p2H;
	Tue, 10 Dec 2024 13:48:54 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241210134854eusmtrp23fbf79d56283eb968e2423e89114fbc3~P1PYPUjZv0934909349eusmtrp23;
	Tue, 10 Dec 2024 13:48:54 +0000 (GMT)
X-AuditID: cbfec7f2-b09c370000005155-0c-675846c722a5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 20.C0.19654.6C648576; Tue, 10
	Dec 2024 13:48:54 +0000 (GMT)
Received: from SSEG2206XE (unknown [106.210.110.5]) by eusmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20241210134854eusmtip2b188679c78e5e1503ca43fb85c316df3~P1PX_x_Jr1812518125eusmtip2s;
	Tue, 10 Dec 2024 13:48:54 +0000 (GMT)
From: "Bilge Aydin" <b.aydin@samsung.com>
To: "'Greg KH'" <gregkh@linuxfoundation.org>
Cc: <stable@vger.kernel.org>
In-Reply-To: <2024121044-coronary-slacker-cf53@gregkh>
Subject: RE: [APS-24624] Missing patch in K5.15 against kernel panic
Date: Tue, 10 Dec 2024 14:48:52 +0100
Message-ID: <0be801db4b0a$3fda7840$bf8f68c0$@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQCy1ZEYHgYzrfPKOGKjn+JO/smJDQDiwl2jAXD/5821HciBcA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPKsWRmVeSWpSXmKPExsWy7djP87rH3SLSDWYt5LBoXryezWLBxkeM
	Dkwe++euYff4vEkugCkq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfV
	VsnFJ0DXLTMHaLySQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptTQlp8CwQK84Mbe4NC9d
	Ly+1xMrQwMDIFKgwITtj2xuOgoXyFRf/3WdpYPwl3cXIySEhYCJxb8Evti5GLg4hgRWMEmfm
	PWCHcL4wSrw7vpgJwvnMKPH72FJ2mJYv/5tZIRLLGSXmrL0B1fKCUaL70lEmkCo2AU2JS1d2
	s4DYIgI6Eh1nToDZzAIyEgdXPAOzOQXMJL42/WYDsYUFXCQ6Jt9nBrFZBFQlTk5awwpi8wpY
	StzfuoAJwhaUODnzCdQcbYllC18zQ1ykIPHz6TJWiF1OEouaelghasQlXh49AnachMBSDomb
	L1dANbhIrNowhQ3CFpZ4dXwL1GsyEv93zmeCsLMl5k47zQhhF0hM2HaMBcK2lphy4RFQnANo
	gabE+l36EGFHiRN7tjOBhCUE+CRuvBWEOIFPYtK26cwQYV6JjjYhiGpFicMPrjFNYFSeheSx
	WUgem4XkgVkIuxYwsqxiFE8tLc5NTy02zEsth0d2cn7uJkZgyjv97/inHYxzX33UO8TIxMF4
	iFGCg1lJhJfDOzRdiDclsbIqtSg/vqg0J7X4EKMpMKwnMkuJJucDk25eSbyhmYGpoYmpibmZ
	oYmxkjivaop8qpBAemJJanZqakFqEUwfEwenVAOTgbSE6p3lXmrCxaLaPzcZzfU/4mVSdfft
	p5MX98rbW7wp/bhFRD80wJIv+sVT+48p7vOe9Rk9OXBZ4I7T74fudtdM+fL40uOUPk250nnT
	/Jy4cJKZs6TVArdjvXMixbceufS09OLZqL1afNmfyu/zHv2ar/xL48h93vUv+oKYgk9sYl7c
	WTjlmYQ+d4vOckc9tcRjnhZe+6tzLnyNcVa2dK3azL9NTHOq5oX6Qxx7J9vNfCGgocZQ+nSR
	ic/q06+bTpnem/Eo14ylP/MGQ8zhV03dykuYW67aFH1ew/Tn2OvTksevH5zZtmP345SHzheV
	Hz27XHPrW9AckcLP72/qTNP8f0FH833RxLssQo1BSizFGYmGWsxFxYkALaCSWQIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsVy+t/xe7rH3CLSDV5v17VoXryezWLBxkeM
	Dkwe++euYff4vEkugClKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYl
	NSezLLVI3y5BL2PO3jtsBROkK77MPc7SwDhTrIuRk0NCwETiy/9m1i5GLg4hgaWMEv9XXwNy
	OIAS4hJNfUYQNcISf651sUHUPGOUWNrRwgiSYBPQlLh0ZTcLiC0ioCPRceYEmM0sICNxcMUz
	FoiGrYwSdy4vYgNJcAqYSXxt+g1mCwu4SHRMvs8MYrMIqEqcnLSGFcTmFbCUuL91AROELShx
	cuYTqKHaEr0PWxlh7GULXzNDXKcg8fPpMlaII5wkFjX1sELUiEu8PHqEfQKj8Cwko2YhGTUL
	yahZSFoWMLKsYhRJLS3OTc8tNtIrTswtLs1L10vOz93ECIyebcd+btnBuPLVR71DjEwcjIcY
	JTiYlUR4ObxD04V4UxIrq1KL8uOLSnNSiw8xmgL9NpFZSjQ5Hxi/eSXxhmYGpoYmZpYGppZm
	xkrivGxXzqcJCaQnlqRmp6YWpBbB9DFxcEo1MOUE6dwIXzHVbNando+nM3w2Rj77FjJ51Z6J
	a9Wblt00seV1U/zWpxQa3TQtda78PK+L30VizNUES/4GPuQIjJskXZn+O8ZkpkzqtO1y6Unb
	Zsce3T/p/Z2PZZcFp6QJvvKawGT+JndZQM3H9YszKj4kufC+cWk8doojv/bfOuUw2wvJRlzn
	2BKiRN/o+9xa47r2/K51pf/ncu4K1PjZtmjqE9W8T1msFjzRYXPFhAQmbot/73slkr/xtnq0
	jVmstsR5pk/ht4wPlb0vmaYy7VpPrlPM+cZ0NemMrn/BAYlZ2jccny58nL3mxrVUF+Eml8e7
	M3r9A3xYPpmf/8R+/oT7UU5lVt09LyYxnfu9X4mlOCPRUIu5qDgRAFEXD/8nAwAA
X-CMS-MailID: 20241210134854eucas1p2013320e1391bb52afd77847baff2c628
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241210132338eucas1p2228b89f17ab46f90075c07806765a5aa
X-EPHeader: CA
CMS-TYPE: 201P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241210132338eucas1p2228b89f17ab46f90075c07806765a5aa
References: <CGME20241210132338eucas1p2228b89f17ab46f90075c07806765a5aa@eucas1p2.samsung.com>
	<0bd701db4b06$b7cbdf00$27639d00$@samsung.com>
	<2024121044-coronary-slacker-cf53@gregkh>

Hello Greg,

Thank you very much for your prompt reply.

=22So why do you feel it is required in 5.15.y?=22
--> We have faced the issue in our K5.15 based platform. Our technical team=
 has made an investigation and found your given patch. Afterwards we verifi=
ed it by running a stress test. The result was positive and we did not face=
 the kernel panic again.

Since we are not OS experts, we fully respect Linux community's decisions. =
That's why we do not see ourselves in that high position to give any guidan=
ce and share any patch with you. During our investigation, we only recogniz=
ed that the given patch was already integrated into the Android common kern=
el. Outgoing from that, I just want to share the indication with you.

Would it be possible for you to start an internal communication within the =
Linux community for the synchronization of the K5.15 and K6.1 mainlines exp=
licitly for iommu driver?


Best regards
Bilge




-----Original Message-----
From: Greg KH <gregkh=40linuxfoundation.org>=20
Sent: Tuesday, December 10, 2024 2:33 PM
To: Bilge Aydin <b.aydin=40samsung.com>
Cc: stable=40vger.kernel.org
Subject: Re: =5BAPS-24624=5D Missing patch in K5.15 against kernel panic

On Tue, Dec 10, 2024 at 02:23:35PM +0100, Bilge Aydin wrote:
> Dear Linux community,
>=20
> I am leading a project at Samsung where we utilized your kernel 5.15 in o=
ur system. Recently we faced an important kernel panic issue whose fix must=
 be following patch:
> https://lore.kernel.org/all/1946ef9f774851732eed78760a78ec40dbc6d178.1
> 667591503.git.robin.murphy=40arm.com/
>=20
> The problem for us is that this patch must be available from kernel 6.1 o=
nwards.=20
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/
> drivers/iommu/iommu.c?h=3Dv6.1.119 Clear to us is that it is not=20
> integrated into K5.15 yet:=20
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/
> drivers/iommu/iommu.c?h=3Dv5.15.173
>=20
> On the other side we can see that this patch was already applied to=20
> Android Common Kernel android13-5.15 =EF=83=A0=20=0D=0A>=20https://androi=
d-review.googlesource.com/q/I51dbcdc5dc536b0e69c6187b2d7=0D=0A>=20ac6a2031a=
305b.=20In=20particular,=20we=20can=20see=20the=20same=20implementation=20i=
n=20=0D=0A>=20the=20recent=20ACK=20release=20=0D=0A>=20https://android.goog=
lesource.com/kernel/common/+/refs/tags/android13-5=0D=0A>=20.15-2024-11_r2/=
drivers/iommu/iommu.c=20=20given=20on=20=0D=0A>=20https://source.android.co=
m/docs/core/architecture/kernel/gki-android13=0D=0A>=20-5_15-release-builds=
=0D=0A>=20=0D=0A>=20Do=20you=20have=20any=20plan=20to=20adjust=20your=20imp=
lementation=20in=20drivers/iommu/iommu.c=20in=20K5.15=20as=20present=20in=
=20K6.1?=20If=20not,=20since=20the=20issue=20in=20our=20project=20is=20very=
=20critical=20for=20us,=20may=20I=20ask=20you=20kindly=20to=20trigger=20the=
=20sync=20of=20K5.15=20and=20K6.1=20soon?=0D=0A=0D=0AIf=20you=20wish=20for=
=20a=20commit=20to=20be=20backported=20to=20the=20stable=20kernels,=20just=
=20ask=20us,=20and=20better=20yet,=20provide=20a=20working=20patch=20to=20d=
o=20so.=0D=0A=0D=0AThe=20reason=20we=20did=20NOT=20backport=20this=20specif=
ic=20commit=20is=20that=20it=20is=20marked=20as=20a=20fix=20for=20a=20commi=
t=20that=20shows=20up=20in=20the=206.1=20release,=20so=20why=20would=20it=
=20be=20applicable=20to=205.15.y=20at=20all?=20=20So=20why=20do=20you=20fee=
l=20it=20is=20required=20in=205.15.y?=20=20(Note,=20we=20have=20no=20idea=
=20why=20it's=20in=20an=20Android=20kernel=20tree,=20perhaps=20they=20have=
=20the=20offending=20commit=20in=20there=20as=20well=20so=20the=20backport=
=20is=20required?=20=20Have=20you=20checked?)=0D=0A=0D=0AIf=20you=20need=20=
or=20want=20it=20applied=20to=20older=20kernels,=20please=20send=20us=20a=
=20working=20patch=20and=20we=20will=20be=20glad=20to=20take=20it.=0D=0A=0D=
=0Athanks,=0D=0A=0D=0Agreg=20k-h=0D=0A=0D=0A

