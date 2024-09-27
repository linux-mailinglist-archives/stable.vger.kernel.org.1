Return-Path: <stable+bounces-77853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 756BA987CC3
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 03:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A0981F22A40
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 01:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7D6165F02;
	Fri, 27 Sep 2024 01:55:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF85314A60D
	for <stable@vger.kernel.org>; Fri, 27 Sep 2024 01:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727402157; cv=none; b=FwX5kGc2F65k62TtfT3jql0znQ/oZkg38pJaOcZ3KrwZYyJ7WqzaxMG3hFQxO722QBg18bAv9lbF1dUKhvLGp5jnObmGDxkO25mUKnGVcRZ9cqWqzl0iHUpNYwb+3QvfD6UlCbuzaEG9kWBFmle5jdqyteIM1JGj25OXkR7jcW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727402157; c=relaxed/simple;
	bh=WEKM0tZRZyMJ4M2yhKVLV3egv5nh5cKgSsXJM8WYyro=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=q7ruOI96v1D0y1N7KfZQF9wovf6E653LynSU11NZaJAQEaKDNhQdUbmCaFdQNc93XJ3we1Jxi+g45AP7BHRS0pcfe3I7knim7RxUze1lIMXjtrkGFCj4OS4n9unBMhTOa4Iq1Crag7sGCsZpQApZxHf4RRyW3Mc9uUk2VN1LKoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid:Yeas9t1727402078t874t41467
Received: from 73E00E8BC808433CB9DB281092DFBE6B (duanqiangwen@net-swift.com [60.186.242.192])
X-QQ-SSF:00400000000000F0FI4000000000000
From: duanqiangwen@net-swift.com
X-BIZMAIL-ID: 15219018867057488817
To: "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
	<stable@vger.kernel.org>
Cc: <patches@lists.linux.dev>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Sasha Levin'" <sashal@kernel.org>
References: <20240430103058.010791820@linuxfoundation.org> <20240430103059.311606449@linuxfoundation.org>
In-Reply-To: <20240430103059.311606449@linuxfoundation.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIDYuNiAwNDQvMTg2XSBuZXQ6IGxpYnd4OiBmaQ==?=
	=?gb2312?B?eCBhbGxvYyBtc2l4IHZlY3RvcnMgZmFpbGVk?=
Date: Fri, 27 Sep 2024 09:54:37 +0800
Message-ID: <029801db1080$35d213e0$a1763ba0$@net-swift.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQFOC2zPFGIL1BJCPg2TAnlAJkwjuwHfHi+Qs3XvmwA=
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:net-swift.com:qybglogicsvrgz:qybglogicsvrgz7a-0

> -----=D3=CA=BC=FE=D4=AD=BC=FE-----
> =B7=A2=BC=FE=C8=CB: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> =B7=A2=CB=CD=CA=B1=BC=E4: 2024=C4=EA4=D4=C230=C8=D5 18:38
> =CA=D5=BC=FE=C8=CB: stable@vger.kernel.org
> =B3=AD=CB=CD: Greg Kroah-Hartman <gregkh@linuxfoundation.org>;
> patches@lists.linux.dev; Duanqiang Wen <duanqiangwen@net-swift.com>;
> David S. Miller <davem@davemloft.net>; Sasha Levin <sashal@kernel.org>
> =D6=F7=CC=E2: [PATCH 6.6 044/186] net: libwx: fix alloc msix vectors =
failed
>=20
> 6.6-stable review patch.  If anyone has any objections, please let me
know.
>=20
> ------------------
>=20
> From: Duanqiang Wen <duanqiangwen@net-swift.com>
>=20
> [ Upstream commit 69197dfc64007b5292cc960581548f41ccd44828 ]
>=20
> driver needs queue msix vectors and one misc irq vector, but only =
queue
vectors
> need irq affinity.
> when num_online_cpus is less than chip max msix vectors, driver will
acquire
> (num_online_cpus + 1) vecotrs, and call pci_alloc_irq_vectors_affinity
functions
> with affinity params without setting pre_vectors or post_vectors, it =
will
cause
> return error code -ENOSPC.
> Misc irq vector is vector 0, driver need to set affinity params
.pre_vectors =3D 1.
>=20
> Fixes: 3f703186113f ("net: libwx: Add irq flow functions")
> Signed-off-by: Duanqiang Wen <duanqiangwen@net-swift.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_lib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> index e078f4071dc23..be434c833c69c 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> @@ -1585,7 +1585,7 @@ static void wx_set_num_queues(struct wx *wx)
>   */
>  static int wx_acquire_msix_vectors(struct wx *wx)  {
> -	struct irq_affinity affd =3D {0, };
> +	struct irq_affinity affd =3D { .pre_vectors =3D 1 };
>  	int nvecs, i;
>=20
>  	nvecs =3D min_t(int, num_online_cpus(), wx->mac.max_msix_vectors);
> --
> 2.43.0
>=20
>=20
This patch in kernel-6.6 and kernel 6.7 will cause problems. In =
kernel-6.6
and kernel 6.7,
Wangxun txgbe & ngbe driver adjust misc irq to vector 0 not yet.  How to
revert it in=20
kernel-6.6 and kernel-6.7 stable?
>=20


