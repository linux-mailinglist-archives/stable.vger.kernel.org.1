Return-Path: <stable+bounces-124328-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3637DA5F9BF
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 16:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43A5819C1849
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 15:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC9C268FEE;
	Thu, 13 Mar 2025 15:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="iq8kjZZ8"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9401268FCE;
	Thu, 13 Mar 2025 15:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741879524; cv=none; b=fUGT1xuNRyxE3F6uclNJYuEBpPpo7Azv50rMpxsDzvAuARaIZRgl668rwG9svx3KTwzv4W8KEqcFZ6IpFallgOI4Q/pIzEwmOiQ4i4CvyxtO0+EHD6bnA4KHawcQ6y6mX8rShGsZRyzUkEpNE1Ohtv3wu0mkp4oePXXvDzK3/nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741879524; c=relaxed/simple;
	bh=sErwnx8pcuQQ1tldCxoUyU7bZmGR2ORwpdFakspaE5k=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=ku6b/xTg+SlMY/n0dlSdoKZgtWubICeU8vAnahvvqeXueB1YcQ2UeafMX1/SrbYNFtcjfIvTp4G9ttCcTiPHgAYmWxa334xt2wnfFCmey+K1hzoqrGeE6NtM7eeX9vlH89J1Kvikm3ZLXMX25B91SyCUST8Txj0n7zM0H82LQx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=iq8kjZZ8; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741879518; x=1742484318; i=markus.elfring@web.de;
	bh=sErwnx8pcuQQ1tldCxoUyU7bZmGR2ORwpdFakspaE5k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=iq8kjZZ8ZTlUv5GhCL+PN2vHTPl714hme9UJfTKqYPCCjJzgKKQeopr3wQPykwrf
	 0yKVj/Trzg7NevDx4VBNdF9i217UFiMBnzkR4aOeWux7Ubp5W54hGclfg8P8zA5BX
	 4ryogbU++dMHGT/KsPxWgf8w39tAR9EjD8txIUKRp3dSZKujd1CxnAJOsLlWjE4Vv
	 E5I2fZ2ygoQiLwUSjh5oY+s2an+Qw9CDww2+fsyiOMSQAjNFUehwVi2VBnv4qbMU0
	 Snt2Pt1t/DVo9ExgcD0KBnIyyluvLox/g8FVcks91uaTyAqQ2PcDt5jhDiIcMX0UG
	 OPqXAvRLptfoYbz/Lg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.2]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N6sBv-1t97GT28Wl-015YRH; Thu, 13
 Mar 2025 16:25:18 +0100
Message-ID: <484f85e6-4650-4301-907d-6ba08dfd4e1b@web.de>
Date: Thu, 13 Mar 2025 16:25:13 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: vulab@iscas.ac.cn, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Jack Xiao <Jack.Xiao@amd.com>, Kenneth Feng <kenneth.feng@amd.com>,
 Likun Gao <Likun.Gao@amd.com>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?=
 <marek.olsak@amd.com>, Simona Vetter <simona@ffwll.ch>,
 Sunil Khatri <sunil.khatri@amd.com>, Xinhui Pan <Xinhui.Pan@amd.com>
References: <20250312063106.772-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] drm/amdgpu/gfx12: correct cleanup of 'me' field with
 gfx_v12_0_me_fini()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250312063106.772-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Fwl6wYppUeZIESJ07QfG7R+RHS+ivvTGz91GRCqjvA9QR2nYSaz
 /276/2ni6oKiwwvhaJE+6C6O4AeztAJTEzhau6+vmGZW/5u6EmkjPtUkOKQTJ77xtIFU59C
 +dnOP2SEa8uRBDiqSff4vu1Psxnv4RnCcZLVR3lbD/M2epv4Ei7hgaIE+ybcXH1RjxI9wRU
 0UlKR4agNoPVi54Os4A6A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PqiBbeSmioQ=;QfebTrW7ygkj+TSSpvMgnbRpo6s
 08hCEpGEBzMWciTp7Ediy/EfNxNJ+WCvi37FaDUSykSIXTBQR27ybZh8L4jCHqGQqQ/ujDGJN
 ZlUzAzb1lvlTOtQ/y/y1WwBHTSJi75jPT90oVe4YsOVGAVAmpYF8nmaBWuW7IO9q1pxQXGRCv
 0Zszpn07z07jwePHZ66d5c9or5bz+rJKy7a0nmgREpUjNm8WT8rmi4qBvo/m33TuISwpKVYbO
 8sj/lktMvrqVXQRJ9PD2xwmkWBWDO8Y3UYHlzw2nwCjiFo98L1K7cBxP+FutrR1yPfiNQHc4y
 Hdqf6LLmMw8hwgNl7DjIaWpZgswQnyNt6oPf9T+kJaep6PKV5/8LR6Fe0NoWP22KAlanj7XEy
 Xy7+hdelz2opzPnimSfsPikABze4Xhpk1Ind7U29tWfxSW1kMmYWANDFltq6Jn6fmHM8MY06b
 tZ5pC//nQd4i+GNvkL4KeLqvoPXVf3OJRuxMCCeD1z09oXwFOgtDbhH+8D9u3exWMqo0reGCZ
 sV+uaNTXZorUOHfkVJehtYevFyl7qTpvfnew10maKpEtDcjU5Lxmzz37OdCs4KelKQ7Yg+ARI
 /FmYcjt0rZaOLesD1uddU+Ek7xtMGXp6d+xJqBtLgMWjFCrbNNWdY8tLwU2wNW6L4anzkSzuD
 U/XXC4FUtmseFWwv/fCsgwXO/tcarZb3wznrqkvnlTV+GPDTGBZ0KkGskRI/Lwf4PwB6WepHL
 MlKcDCZ/MUuib+WgNx5WLB0eOI+euIyisJ6jXpv3awGW7QgE4Efs7s5HOJX6xOFsC+p1B7/ua
 dZs93pnG0kqsz0W5pCucPu1pfa78seRSpahs8UwUBr4+fp8qZuDuVaT+za1MJiWueOqXTYqcM
 jzxe7L1Uspyd++YzyBWzR3YV0SWVkXE3E8gvjnpaaNBMJYPo4YJxy3Ze6vd26XHEXX1k7MTrD
 Buab5bKidyDKFCqJ3WwXXPE+yoXP5Xj+3HF5PPTtFDVgOoSuFlSyw+o0Cbs+pwosqjbYyVKNe
 kxMF3O1OdNj721mKBur0+8eP8qXS33j1/4K2lcnnyV1vPgYs1T77BM65DwW+mzXIptBSLoOEh
 8rKkbX5dPt6kqDCOSevjr1NXJqui/mRwQU87uH530Eb5gaeapFcUkhHsO0WEwoP1ZNYYtgd+o
 tLgujMk6/WMaNczDwOf6T4GEyFwNYFrBI4GIfxo6jq1Wg5PIjsnJ0HG8Z5kFlS7XD5AbfxCyW
 lYtuNSHTkNbr6SrIkRZXvsMi80IazpnzV+aoBiLKcdanuEZGJKbDr9jcGWKeOAdOCY0V+ws+z
 JykisRMjj8kY8hh/khhjRu4fONeBnJ4E9FIJf1l159wiAxVNp8yMN7EJrVBCJtabbv/wdJnbo
 a4trkTqrDf5MvhTZkih97VQFD6ZshD5S6zbcgMigJBtZVo+dAogjMIKesL4UZQCaY324qlofw
 2FphBIrwBN46kw527VD/chFzQHw2ycSOB1iap4sw9SO1CqpBW

=E2=80=A6
> can only release 'pfp' field of 'gfx'. The release function of 'me' fiel=
d
> should be gfx_v12_0_me_fini().

Do you care for an imperative wording in such a change description?
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/process/submitting-patches.rst?h=3Dv6.14-rc6#n94

Regards,
Markus

