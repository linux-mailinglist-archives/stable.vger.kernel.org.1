Return-Path: <stable+bounces-108427-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C311A0B7AC
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 14:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82C89165426
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 13:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93209230D2B;
	Mon, 13 Jan 2025 13:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="tidfsf09"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-ztdg10011201.me.com (pv50p00im-ztdg10011201.me.com [17.58.6.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F9022A4F4
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 13:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736773626; cv=none; b=Ns1eCrfU1Q/ATETNhAOlILfWWROjdooxfTyDZ5wWJUSr+IzFYDNksfxDYt6xGNo92r4/+r6aGYDjkI9VkASgAMEQQGJhk4X0+UEjHGNsgl2qcliquEIA6GMYKr2tdKHMN+xEEu7p2v6gv5SK+bZxyXnaA4EbXXOU/uoFfuh27q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736773626; c=relaxed/simple;
	bh=vmkYl0MfndY9C/wzg8RrVEbRyrF2nuSAKLy9qNGUXKQ=;
	h=Content-Type:From:Mime-Version:Subject:Message-Id:Date:Cc:To; b=AhAd6Fs3Lxd5G+abtDyjthGpL8KTRWb4SMalVzDAbytrAG0KQC4/pG//C63f7IxUmKtL7PbqMdyUnRdFmYiTya/tfrGk0RTjrBPKPsw7wpKfVm9tOdMmHOjPxY3ey2X+8XkoZXQMwtPdOw7Wrs7cWsdXU2W/zRfrfjyRel2SRRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=tidfsf09; arc=none smtp.client-ip=17.58.6.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1736773624;
	bh=/VferRrDdpdfgDvmdmWN4ynbARe4+9nSWpj4+iwm8mE=;
	h=Content-Type:From:Mime-Version:Subject:Message-Id:Date:To:
	 x-icloud-hme;
	b=tidfsf09IXU7qyaHO70tkz8ejUnvErGVjF0gINXEyBSIdNryh4LWbemP8oVLpbx8o
	 0Dt3Pnjiw5soxNI09iUTXv2RfLXcdgG1gkfIC5BEKUWjmSWElIcc3+NX/t+kudJiA8
	 FQASD03DVH5Ve+tFCbqobg9sdbR4dkWMqJxCh7qLp3pBN3LUrgcR66pBkD6cLvqb9y
	 F9TEAzcONJz7Jebcq2TwhrO7ZGAFpYe1AzqRYMctFRHX6r8Ng4L0Az6rMyXt3wqtIT
	 zpWjD35HNWZJ3tsqeA1zdjQxQ2JLcKqNXsxK2aCLGwTqDeGAafhYNMDCuJySWT/NXQ
	 inB/q8TooaoMg==
Received: from smtpclient.apple (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011201.me.com (Postfix) with ESMTPSA id 60D7768043C;
	Mon, 13 Jan 2025 13:06:57 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: =?utf-8?B?5r2Y5L+K5Lit?= <a1134123566@icloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3] usb: gadget: ncm: Avoid dropping datagrams of properly parsed NTBs
Message-Id: <4C771A46-5372-488E-B31F-67262CDB95D6@icloud.com>
Date: Mon, 13 Jan 2025 21:06:42 +0800
Cc: quic_kriskura@quicinc.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 quic_jackp@quicinc.com, quic_ppratap@quicinc.com, quic_wcheng@quicinc.com,
 stable@vger.kernel.org
To: =?utf-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
X-Mailer: iPhone Mail (22C161)
X-Proofpoint-ORIG-GUID: eCJBSQzVJomJyczsNROsasEWdAyYivYt
X-Proofpoint-GUID: eCJBSQzVJomJyczsNROsasEWdAyYivYt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-13_04,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 clxscore=1011 mlxlogscore=860 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2501130110

=EF=BB=BFHi Maciej,

On 2025/1/13 1:49, Maciej =C5=BBenczykowski Wrote:
> (a) I think this looks like a bug on the sending Win10 side, rather
> than a parsing bug in Linux,
> with there being no ZLP, and no short (<512) frame, there's simply no
> way for the receiver to split at the right spot.
>=20
> Indeed, fixing this on the Linux/parsing side seems non-trivial...
> I guess we could try to treat the connection as simply a serial
> connection (ie. ignore frame boundaries), but then we might have
> issues with other senders...
>=20
> I guess the most likely 'correct' hack/fix would be to hold on to the
> extra 'N*512' bytes (it doesn't even have to be 1, though likely the N
> is odd), if it starts with a NTH header...
Make sence, it seems we only need to save the rest data beside
dwBlockLength for next unwrap if a hack is acceptable, otherwise I may
need to check if a custom host driver for Windows10 user feasible.

I didn't look carefully into the 1byte and padding stuff with Windows11
host yet, I will take a look then.

> (b) I notice the '512' not '1024', I think this implies a USB2
> connection instead of USB3
> -- could you try replicating this with a USB3 capable data cable (and
> USB3 ports), this should result in 1024 block size instead of 512.
>=20
> I'm wondering if the win10 stack is avoiding generating N*1024, but
> then hitting N*512 with odd N...
Yes, I am using USB2.0 connection to better capture the crime scene.

Normally the OUT transfer on USB3.0 SuperSpeed connection comes with a bunch=

of 1024B Data Pakcet along with a Short Packet less than 1024B in the end fr=
om
the Lecroy trace.

It's also reproducible on USB3.0 SuperSpeed connection using dwc3 controller=
,
but it will cost more time and make it difficult to capture the online data
(limited tracer HW buffer), I can try using software tracing or custom logs
later:

[  5]  26.00-27.00  sec   183 MBytes  1.54 Gbits/sec
[  5]  27.00-28.00  sec   182 MBytes  1.53 Gbits/sec
[  206.123935] configfs.gadget.2: Wrong NDP SIGN
[  206.129785] configfs.gadget.2: Wrong NTH SIGN, skblen 12208
[  206.136802] HEAD:0000000004f66a88: 80 06 bc f9 c0 a8 24 66 c0 a8 24 65 f7=
 24 14 51 aa 1a 30 d5 01 f8 01 26 50 10 20 14 27 3d 00 00
[  5]  28.00-29.00  sec   128 MBytes  1.07 Gbits/sec
[  5]  29.00-30.00  sec   191 MBytes  1.61 Gbits/sec
>=20
> Presumably '512' would be '64' with USB1.0/1.1, but I guess finding a
> USB1.x port/host to test against is likely to be near impossible...
>=20
> I'll try to see if I can find the source of the bug in the Win
> driver's sources (though based on it being Win10 only, may need to
> search history)
> It's great if you can analyze from the host driver.

I didn't know if the NCM driver open-sourced on github by M$ is the correspo=
nd
version. They said that only Win 11 officially support NCM in the issue on g=
ithub
yet they do have a built-in driver in Win10 and 2004 tag there in the repo.


