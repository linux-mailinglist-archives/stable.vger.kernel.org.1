Return-Path: <stable+bounces-100426-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F9C9EB1C9
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 14:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C713916884B
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 13:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E18B1A3AB8;
	Tue, 10 Dec 2024 13:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HAh6EAnW"
X-Original-To: stable@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC7E1A0B15
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 13:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733837024; cv=none; b=IY39ymulD6RNy6CxmXrMZeLBa44HP2gD2rV3eOpZkoePqtpJujdTfNWvKKG0zIpSuyeW9cAXTFGSBsALhXqKhXWe+17K4hrjYM3zd/i8n59ksjE87gGlZxsL9nyAaBdR/s+GVbcmgrd8ZrRxFV48cAGoMO546BPXHZR0fDR1G54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733837024; c=relaxed/simple;
	bh=5/mYYEGaPq7g4Q26hYo6HhiFLL95zEFMeagpEFCWO7M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=RTPKycY8ZKLGDNuUkUNeUQ0A3VNbInXeaH/maFyK9Jkiky27ATZrv0/gw1e5t/QrFyrfDiyBUG7vpNzBLdbbemk0az3w8/idqRRapvXQRL3MV0mFTViF7xtUeptct432MWUWwJ54Q+4Oi2gGreoZPHI2MobUp8+q02QEfe+qYIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=HAh6EAnW; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20241210132339euoutp014302d316bdbbcb72ca90202cf6995034~P05VZ98mR0406304063euoutp01P
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 13:23:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20241210132339euoutp014302d316bdbbcb72ca90202cf6995034~P05VZ98mR0406304063euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733837020;
	bh=5/mYYEGaPq7g4Q26hYo6HhiFLL95zEFMeagpEFCWO7M=;
	h=From:To:Subject:Date:References:From;
	b=HAh6EAnWBbwkCYaNkPtmDYN3T5qJz2QhJi/J4cO5WBKSFnIlWqSJDsOywbboRrmJi
	 2Gw+118fgL/DDeXGPKPq0g7nZ1vqVkdOITl0oB7r5Svswb1ZD+xrIt40QB7cchprJm
	 c6us4ax8YJgKhjla2cl4xN3M5R3Ey5AqW8hhBlNU=
Received: from eusmges1new.samsung.com (unknown [182.198.248.175]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20241210132338eucas1p1abdb4e862feb1750746c6ab174ac8156~P05UX9ZOm0057700577eucas1p1E
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 13:23:38 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id C1.82.20821.AD048576; Tue, 10
	Dec 2024 13:23:38 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20241210132338eucas1p2228b89f17ab46f90075c07806765a5aa~P05TprMbI1579115791eucas1p27
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 13:23:38 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241210132338eusmtrp2226908ee0c08f5d3fa4f7ab1985d7ed7~P05TpAF7-2707027070eusmtrp2D
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 13:23:38 +0000 (GMT)
X-AuditID: cbfec7f2-b11c470000005155-6d-675840daa934
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 8A.6C.19654.9D048576; Tue, 10
	Dec 2024 13:23:37 +0000 (GMT)
Received: from SSEG2206XE (unknown [106.210.110.5]) by eusmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20241210132337eusmtip19cb9e3f3b6de665e70898c706d4f93c6~P05TZU__Y1215712157eusmtip1r
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 13:23:37 +0000 (GMT)
From: "Bilge Aydin" <b.aydin@samsung.com>
To: <stable@vger.kernel.org>
Subject: [APS-24624] Missing patch in K5.15 against kernel panic
Date: Tue, 10 Dec 2024 14:23:35 +0100
Message-ID: <0bd701db4b06$b7cbdf00$27639d00$@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdtLBpRQyuaFUyd5R4SRivXyj0oE0w==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCKsWRmVeSWpSXmKPExsWy7djPc7q3HCLSDR58M7RYsPERowOjx+dN
	cgGMUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUBD
	lRTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqmlKTkFhgV6xYm5xaV56Xp5qSVWhgYGRqZA
	hQnZGc//L2UsaJSs+LL+KVsD4xXxLkZODgkBE4lvHV8Zuxi5OIQEVjBKXLy6lQXCmcgksXn/
	BTaQKiGBCUwSXYcKuxg5wDo27RWFqFnOKPHqwjpWCKeVSWL51YnsIA1sApoSl67sZgGxRQRk
	JKa37mUCsYUFHCR6jv9jBLFZBFQlNmybAVbPK2ApcWbDFTYIW1Di5MwnYL3MAtoSyxa+ZoY4
	VUHi59NlrBAz9SRWXmxjg6gRl3h59Ag7yBESAl/ZJdZ+7GWHaHCRmPLnGiOELSzx6vgWqLiM
	xP+d85kg7GyJudNOQ9UUSEzYdowFwraWmHLhESPIx8xAz6zfpQ8RdpQ4sWc7EyQg+CRuvBWE
	OIFPYtK26cwQYV6JjjYhiGpFicMPrkEtEpe4tgjG9pBo/buXfQKj4iwkD89C8vAsJI/NQrhh
	ASPLKkbx1NLi3PTUYsO81HJ4XCfn525iBCa30/+Of9rBOPfVR71DjEwcjIcYJTiYlUR4ObxD
	04V4UxIrq1KL8uOLSnNSiw8xmgLjYCKzlGhyPjC95pXEG5oZmBqamJqYmxmaGCuJ86qmyKcK
	CaQnlqRmp6YWpBbB9DFxcEo1MOX//eoowCAYev/cIg+JExYaXy20DKcEVDTlHz9VoTnloYtQ
	4iunjyZf/d8dOeTc6yr5x+ntIvt1r2YbPDt6qTl5w+Krlurz8+Y+771cvmhORhDbeyZ5I5e2
	r9nFrzzNb5oEFxjvV2bjXMr9aopa4e2FzwI4n3u7uAdaC22+l73YklPhLWuH0f6PfRcur9j9
	fNI39tK4fM11MfsKl/H0fqhMln1nohaQc7P1UKzL54PGEZ0tbu9f8h548kpMsKGb5RGPfOAH
	JY66W2u/rdj6RVtpe+X/z5UpZhZFTpvKG1XeSpnpeQq4Gm5Tv1h/KE9QJ23RZisOBZ4SMdnd
	T2QNdfdyHlnbNeXHV7HJy5kylFiKMxINtZiLihMBbQ/R3/cDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsVy+t/xu7o3HSLSDS6121gs2PiI0YHR4/Mm
	uQDGKD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2M
	H8t6WArOiFQcXPyKsYFxg2AXIweHhICJxKa9ol2MXBxCAksZJS7862KCiItLNPUZdTFyApnC
	En+udbFB1DQzSXz6t5ANJMEmoClx6cpuFhBbREBGYnrrXiYQW1jAQaLn+D9GEJtFQFViw7YZ
	7CA2r4ClxJkNV9ggbEGJkzOfgPUyC2hL9D5sZYSxly18zQyxWEHi59NlrBDz9SRWXmxjg6gR
	l3h59Aj7BEaBWUhGzUIyahaSUbOQtCxgZFnFKJJaWpybnltspFecmFtcmpeul5yfu4kRGNzb
	jv3csoNx5auPeocYmTgYDzFKcDArifByeIemC/GmJFZWpRblxxeV5qQWH2I0BfptIrOUaHI+
	ML7ySuINzQxMDU3MLA1MLc2MlcR52a6cTxMSSE8sSc1OTS1ILYLpY+LglGpg0rmwZ4bbOwsx
	qX0b5oZx3OzYoLbnGa+mDvvL41fsmm6L/Ofi0etP1pzXN+Wo1EH2ly3WV3qTf2nKdsn26vxo
	PurRfqFqS3Ltg7heGYn0bVPiip7FTd9UMq8k8qvuAfH+zIPamxlWa2yWrOGI+s1638Ovbf/l
	HXkX9i1znNj2xkH8w7nT3+PshLUm539nnMqutq6Bx3Of0rwtUwwX+bL0Fd/YwODyOPfGrTu/
	Elao20x9Jmxc9Sr+wc9Znf926ZwMnzTxoKpcYkXFk4z0G1fZlc3rryRN0t4X9F/W0qvlpnFA
	TezcI2XVHyw/TtzboVj1zmh7irrqV4X/sW/+L9kc1aIoOu1b7LV5OodtpESqlViKMxINtZiL
	ihMB099DK/cCAAA=
X-CMS-MailID: 20241210132338eucas1p2228b89f17ab46f90075c07806765a5aa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241210132338eucas1p2228b89f17ab46f90075c07806765a5aa
X-EPHeader: CA
CMS-TYPE: 201P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241210132338eucas1p2228b89f17ab46f90075c07806765a5aa
References: <CGME20241210132338eucas1p2228b89f17ab46f90075c07806765a5aa@eucas1p2.samsung.com>

Dear Linux community,

I am leading a project at Samsung where we utilized your kernel 5.15 in our=
 system. Recently we faced an important kernel panic issue whose fix must b=
e following patch:
https://lore.kernel.org/all/1946ef9f774851732eed78760a78ec40dbc6d178.166759=
1503.git.robin.murphy=40arm.com/

The problem for us is that this patch must be available from kernel 6.1 onw=
ards.=20
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drive=
rs/iommu/iommu.c?h=3Dv6.1.119=20
Clear to us is that it is not integrated into K5.15 yet: https://git.kernel=
.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/iommu/iommu.c?h=
=3Dv5.15.173=20

On the other side we can see that this patch was already applied to Android=
 Common Kernel android13-5.15 =EF=83=A0=20https://android-review.googlesour=
ce.com/q/I51dbcdc5dc536b0e69c6187b2d7ac6a2031a305b.=20In=20particular,=20we=
=20can=20see=20the=20same=20implementation=20in=20the=20recent=20ACK=20rele=
ase=20https://android.googlesource.com/kernel/common/+/refs/tags/android13-=
5.15-2024-11_r2/drivers/iommu/iommu.c=20=20given=20on=20https://source.andr=
oid.com/docs/core/architecture/kernel/gki-android13-5_15-release-builds=20=
=0D=0A=0D=0ADo=20you=20have=20any=20plan=20to=20adjust=20your=20implementat=
ion=20in=20drivers/iommu/iommu.c=20in=20K5.15=20as=20present=20in=20K6.1?=
=20If=20not,=20since=20the=20issue=20in=20our=20project=20is=20very=20criti=
cal=20for=20us,=20may=20I=20ask=20you=20kindly=20to=20trigger=20the=20sync=
=20of=20K5.15=20and=20K6.1=20soon?=0D=0A=0D=0AI=20would=20appreciate=20high=
ly=20your=20response=20and=20any=20support.=0D=0A=0D=0A=0D=0AKind=20regards=
=20/=20Mit=20freundlichen=20Gr=C3=BC=C3=9Fen=0D=0A=0D=0A-Confidential-=0D=
=0ABilge=20Aydin=0D=0AProject=20Manager=0D=0APhone::=20+49-89-45578-1055=20=
=C2=B7=20Mobile::=20+49-160-8855875=20=C2=B7=20Email:=20b.aydin=40samsung.c=
om=20=0D=0ASamsung=20Semiconductor=20Europe=20GmbH=0D=0AEinsteinstrasse=201=
74,=2081677=20M=C3=BCnchen,=20Deutschland=0D=0AJurisdiction=20and=20registe=
red=20Munich=20/=20Germany,=20HRB=20Nr.=20253778=0D=0AManaging=20Director:=
=20Dermot=20Ryan=0D=0A=0D=0Awww.samsung.com/semiconductor/solutions/automot=
ive=0D=0A=0D=0A=0D=0A=0D=0A=0D=0AThis=20communication=20(including=20any=20=
attachments)=20contains=20information=20which=20may=20be=20confidential=20a=
nd/or=20privileged.=20It=20is=20for=20the=20exclusive=20use=20of=20the=20in=
tended=20recipient(s)=20so,=20if=20you=20have=20received=20this=20communica=
tion=20in=20error,=20please=20do=20not=20distribute,=20copy=20or=20use=20th=
is=20communication=20or=20its=20contents=20but=20notify=20the=20sender=20im=
mediately=20and=20then=20destroy=20any=20copies=20of=20it.=20Due=20to=20the=
=20nature=20of=20the=20Internet,=20the=20sender=20is=20unable=20to=20ensure=
=20the=20integrity=20of=20this=20message.=20Any=20views=20expressed=20in=20=
this=20communication=20are=20those=20of=20the=20individual=20sender,=20exce=
pt=20where=20the=20sender=20specifically=20states=20them=20to=20be=20the=20=
views=20of=20the=20company=20the=20sender=20works=20for.=0D=0A=0D=0A=20=0D=
=0A=0D=0A=0D=0A=0D=0A

