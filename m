Return-Path: <stable+bounces-77854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D12987CD0
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 04:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89D12284AED
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 02:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C85B2233A;
	Fri, 27 Sep 2024 02:03:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD24290F
	for <stable@vger.kernel.org>; Fri, 27 Sep 2024 02:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727402589; cv=none; b=jc6rEHOLmxiwKlfc24+mpBK7/B7KpQaibzNLWvQy3koWz0Wjrq39Borf0xTjFL7I29uzGt9n/zfqi7dufIxuKVtBrgqVzPQZhh6L4TmOIozaVyGju1KI2H4D7L+9V93o+V8w6PSuDq/CBQAWpA12kGqIJAFcOGxR946oL6pcCi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727402589; c=relaxed/simple;
	bh=BQL9qCrHsiPnNdbKuAwt41xVjbgBh1gg81qaeNqjQX4=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=i7p/rCvUfjG9fiM/OBUYzgIAPLQP60DsD4xbsvwWm9GT/dOcPhB/bXKr9ZLQByxCb3QW1dPNYg60EQY8jkMYoMpP7/u1mjyQV5rpGEcvK68SOn1ma/KHW3mQEf8UJphHdjBcmYzTL6XblpAUBpWX2YLP1v5dHVRSWM+naA3KB0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid:Yeas3t1727402535t087t34301
Received: from 73E00E8BC808433CB9DB281092DFBE6B (duanqiangwen@net-swift.com [60.186.242.192])
X-QQ-SSF:00400000000000F0FI4000000000000
From: duanqiangwen@net-swift.com
X-BIZMAIL-ID: 14199240526905965873
To: "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
	<stable@vger.kernel.org>
Cc: <patches@lists.linux.dev>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Sasha Levin'" <sashal@kernel.org>
References: <20240430103058.010791820@linuxfoundation.org> <20240430103059.311606449@linuxfoundation.org>
In-Reply-To: <20240430103059.311606449@linuxfoundation.org>
Subject: RE: [PATCH 6.6 044/186] net: libwx: fix alloc msix vectors failed
Date: Fri, 27 Sep 2024 10:02:14 +0800
Message-ID: <000201db1081$45ae0660$d10a1320$@net-swift.com>
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
Thread-Index: AQFOC2zPFGIL1BJCPg2TAnlAJkwjuwHfHi+Qs3XyrZA=
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:net-swift.com:qybglogicsvrgz:qybglogicsvrgz7a-0

> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: 2024=C4=EA4=D4=C230=C8=D5 18:38
> To: stable@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>;
> patches@lists.linux.dev; Duanqiang Wen <duanqiangwen@net-swift.com>;
> David S. Miller <davem@davemloft.net>; Sasha Levin <sashal@kernel.org>
> Subject: [PATCH 6.6 044/186] net: libwx: fix alloc msix vectors failed
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
> vectors need irq affinity.
> when num_online_cpus is less than chip max msix vectors, driver will
acquire
> (num_online_cpus + 1) vecotrs, and call pci_alloc_irq_vectors_affinity
> functions with affinity params without setting pre_vectors or
post_vectors, it
> will cause return error code -ENOSPC.
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
This patch in kernel-6.6 and kernel 6.7 will cause problems. In =
kernel-6.6
and kernel 6.7,=20
Wangxun txgbe & ngbe driver adjust misc irq to vector 0 not yet.  How to
revert it in
kernel-6.6 and kernel-6.7 stable?>=20
>=20


