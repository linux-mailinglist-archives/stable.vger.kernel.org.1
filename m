Return-Path: <stable+bounces-77868-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9F3987F0E
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 09:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECF881F21E84
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 07:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA978170A27;
	Fri, 27 Sep 2024 07:01:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACDEEAC6
	for <stable@vger.kernel.org>; Fri, 27 Sep 2024 07:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.155.80.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727420477; cv=none; b=sRSCWxN71HNtwNyp0hXyUfKXBfE3CUFeTrgxx/jxPWdiK1hMF8H0ES+400wpd3/aMhaTNdP7o6wyde7825uweG4pGaIvWN10ykYgJd6NmDf616j3my/6cKs6fSV0dYYTMey0cqdwDDNhy8PoxyAndk0rrktne8qehtJ1f9LFPRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727420477; c=relaxed/simple;
	bh=PFnApE/C+ZHBlowwZwA9bLXw/UX4Qkv6SWf9h8FhqQs=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=eGRTmNF3Sk9MMHRcchAngm76SeScwBTxehaMMcRKbL3nRDywXgmjxFbJu+y+wInF6ED1C8hjyrr/Fb3+U5vnIfa3HFRkT/F7RUndMm60vcQfg4WD9tdDITGTf2pv46QXf1L6rk1Fh9mxWRtPs6TsEgOOgEDQ1wc2dyle4lbNPnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=43.155.80.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid:Yeas7t1727420383t138t30679
Received: from 73E00E8BC808433CB9DB281092DFBE6B (duanqiangwen@net-swift.com [60.186.242.192])
X-QQ-SSF:00400000000000F0FI4000000000000
From: duanqiangwen@net-swift.com
X-BIZMAIL-ID: 11177712466447322945
To: "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>
Cc: <stable@vger.kernel.org>,
	<patches@lists.linux.dev>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Sasha Levin'" <sashal@kernel.org>
References: <20240430103058.010791820@linuxfoundation.org> <20240430103059.311606449@linuxfoundation.org> <000201db1081$45ae0660$d10a1320$@net-swift.com> <2024092715-olive-disallow-e28c@gregkh>
In-Reply-To: <2024092715-olive-disallow-e28c@gregkh>
Subject: RE: [PATCH 6.6 044/186] net: libwx: fix alloc msix vectors failed
Date: Fri, 27 Sep 2024 14:59:42 +0800
Message-ID: <001701db10aa$d3fd7710$7bf86530$@net-swift.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFOC2zPFGIL1BJCPg2TAnlAJkwjuwHfHi+QAbIP1l4BpKpYSbNbj4Yg
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:net-swift.com:qybglogicsvrgz:qybglogicsvrgz7a-0

> -----Original Message-----
> From: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
> Sent: 2024=E5=B9=B49=E6=9C=8827=E6=97=A5 14:53
> To: duanqiangwen@net-swift.com
> Cc: stable@vger.kernel.org; patches@lists.linux.dev; 'David S. Miller'
> <davem@davemloft.net>; 'Sasha Levin' <sashal@kernel.org>
> Subject: Re: [PATCH 6.6 044/186] net: libwx: fix alloc msix vectors =
failed
>=20
> On Fri, Sep 27, 2024 at 10:02:14AM +0800, duanqiangwen@net-swift.com
> wrote:
> > > -----Original Message-----
> > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Sent: 2024=E5=B9=B44=E6=9C=8830=E6=97=A5 18:38
> > > To: stable@vger.kernel.org
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>;
> > > patches@lists.linux.dev; Duanqiang Wen <duanqiangwen@net-
> swift.com>;
> > > David S. Miller <davem@davemloft.net>; Sasha Levin
> > > <sashal@kernel.org>
> > > Subject: [PATCH 6.6 044/186] net: libwx: fix alloc msix vectors
> > > failed
> > >
> > > 6.6-stable review patch.  If anyone has any objections, please let
> > > me
> > know.
> > >
> > > ------------------
> > >
> > > From: Duanqiang Wen <duanqiangwen@net-swift.com>
> > >
> > > [ Upstream commit 69197dfc64007b5292cc960581548f41ccd44828 ]
> > >
> > > driver needs queue msix vectors and one misc irq vector, but only
> > > queue vectors need irq affinity.
> > > when num_online_cpus is less than chip max msix vectors, driver =
will
> > acquire
> > > (num_online_cpus + 1) vecotrs, and call
> > > pci_alloc_irq_vectors_affinity functions with affinity params
> > > without setting pre_vectors or
> > post_vectors, it
> > > will cause return error code -ENOSPC.
> > > Misc irq vector is vector 0, driver need to set affinity params
> > .pre_vectors =3D 1.
> > >
> > > Fixes: 3f703186113f ("net: libwx: Add irq flow functions")
> > > Signed-off-by: Duanqiang Wen <duanqiangwen@net-swift.com>
> > > Signed-off-by: David S. Miller <davem@davemloft.net>
> > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > ---
> > >  drivers/net/ethernet/wangxun/libwx/wx_lib.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> > > b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> > > index e078f4071dc23..be434c833c69c 100644
> > > --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> > > +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> > > @@ -1585,7 +1585,7 @@ static void wx_set_num_queues(struct wx *wx)
> > >   */
> > >  static int wx_acquire_msix_vectors(struct wx *wx)  {
> > > -	struct irq_affinity affd =3D {0, };
> > > +	struct irq_affinity affd =3D { .pre_vectors =3D 1 };
> > >  	int nvecs, i;
> > >
> > >  	nvecs =3D min_t(int, num_online_cpus(), =
wx->mac.max_msix_vectors);
> > > --
> > > 2.43.0
> > >
> > This patch in kernel-6.6 and kernel 6.7 will cause problems. In
> > kernel-6.6 and kernel 6.7, Wangxun txgbe & ngbe driver adjust misc =
irq
> > to vector 0 not yet.  How to revert it in
> > kernel-6.6 and kernel-6.7 stable?>
>=20
> Please send a revert.
>=20
> thanks,
>=20
> greg k-h
>=20
Should I send revert to stable/master repo? I only wan't to revert it in =
6.6.y and 6.7.y.
How maintainer recognize this revert should be applied in different =
tags?


