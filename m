Return-Path: <stable+bounces-161504-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB599AFF684
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 03:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6798483DE3
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 01:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9422727E7EC;
	Thu, 10 Jul 2025 01:55:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A789846C;
	Thu, 10 Jul 2025 01:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752112547; cv=none; b=rhStFfcRUspOaaRoQgtF76OHvAcevEtnx4HApbeWA2GDb8qpbHRCwai0CoYwvz0oIrQltI+uOW1XXSFM0usTVPoOqDfvH0Vwyuxohi/xGJ8Awgr4CA1Jhao43Rid3aiY5WaNvmyU4UDK2nHZPMJ+tIUxQqpeJtewomh1Akk9Zq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752112547; c=relaxed/simple;
	bh=+L/rwZ6HABHIMhGOP2zkn36SLvTa9s3kx/uJ/DlIHRI=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=EJmbMdTiff/g3FUt1gPpCTnvE++p0uTGCov3nt3mtpW1Ta+HCXcpUpEPNk2UEi2JgIw1OF1MbaInPzcZ+qdH0XjCn5L3HHYCOLP62GAeMc3IFMymuFgXrx5JX8tGrjj2gBh8G04ConAb8KQOnqGQlXyCMmAYJTC0omw2zeorN2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas1t1752112454t545t20380
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.20.45.108])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 2056198709268237627
To: "'Simon Horman'" <horms@kernel.org>
Cc: <netdev@vger.kernel.org>,
	<andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<mengyuanlou@net-swift.com>,
	<stable@vger.kernel.org>
References: <FD180EC06F384721+20250709063512.3343-1-jiawenwu@trustnetic.com> <20250709112937.GU452973@horms.kernel.org>
In-Reply-To: <20250709112937.GU452973@horms.kernel.org>
Subject: RE: [PATCH net] net: libwx: fix multicast packets received count
Date: Thu, 10 Jul 2025 09:54:05 +0800
Message-ID: <086c01dbf13d$84ab4ec0$8e01ec40$@trustnetic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQFEaMASMAu75b72C5g8YPIt++TR2gHIKvCMtUtmlvA=
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Nw9C1WBu09hPPyKucH/9W1kgI0owSi5xAGWjqu/a70S4ZshD0WHJAaHg
	gG76x8QU2Wo7Mfu4QK4ISWu45mz+tbSHPeuHJVUk4y3h50JuyRZ1xcGSbJqMz7LK7uKf3dt
	gEc2vist1fdQfvrTR8Psnev8KOjo//q1cHiOnhzmj5+Cq952dwcyVgcutinYJaKWZrAxeGq
	QP1T02KfMCkuNQiuba2AS4sc/1WUdrczRABcgV9cPS77ZDO2ZlRhrYYUG1jL3renr2ffN0R
	xekf1/xPInW2LkwKPKcc6qWquUOe0q0MDlKrtt6sfhpEveInfQ8EcdoCN7+z8qdDHNp7mgV
	IB3RWYAliaZP1TYF4Id6H+FjtVyu9/RfwuShlcdGQSwrymMldU/DDT4LPMkK209RN/4zbWR
	UdHC/n5Uquun9XHFaRRiNFHxLpKq8GrwdXhd61cOE+i0O1x2eFqyF4hC8IIWLYMwFZUNaHa
	q4ogRHvSD9dJai4m1EHgZzDTZnbFlpNYFcuqmOn8BLnMJ+G63ZOvrEVALULq/1/4qt3N8ex
	FkudbcfNFONH/seqn5Cwudw37+Nte6r3MlZTPXBrtETJ8mGmMKj0FGWflDVGxt11ICeticW
	qP5oKlZ4DWnGpCcRHsTr6u28Su8g3Lfba5zlF8Rq4cQWQ+eCCk3dfaOHhyEL4m/ht82rI7u
	AZ25Js8SCYfZ59/AO+REOu+U+MVBGe2Loy77fWvKfg3QEgA7cSAEI5KfLJvDcimwrf5erGX
	lTjoV0OvRfkCnpL/FX5m2bIF0zbE/AT9zNl7fFQvV4Wc2Kyalz1eV1KfnSN6fPteD00BbTv
	OPF+2z7aVVfCTOAPZjFUyLHsLO/fo2gXJStPVfjc5qCFRkZ37+QWN6JDfgs0ZBW9I97qcdU
	gvppRUptexo/eVdmkrn0rcR9Q4V9LRoRib6nQ1I1u2iUYQeU3eBlZhbrR8pJhNqUjoEP3sh
	uBwd75Hhz8FlOCcDzspzFMku9N6PxTDKT8goSMgKGHWbijiur9Z/dIcqOM2q4d/WQvdj9yY
	QxdP2rdw==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

On Wed, Jul 9, 2025 7:30 PM, Simon Horman wrote:
> On Wed, Jul 09, 2025 at 02:35:12PM +0800, Jiawen Wu wrote:
> > Multicast good packets received by PF rings that pass ethternet MAC
> > address filtering are counted for rtnl_link_stats64.multicast. The
> > counter is not cleared on read. Fix the duplicate counting on updating
> > statistics.
> >
> > Fixes: 46b92e10d631 ("net: libwx: support hardware statistics")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> > ---
> >  drivers/net/ethernet/wangxun/libwx/wx_hw.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> > index 0f4be72116b8..a9519997286b 100644
> > --- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> > +++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> > @@ -2778,6 +2778,7 @@ void wx_update_stats(struct wx *wx)
> >  		hwstats->fdirmiss += rd32(wx, WX_RDB_FDIR_MISS);
> >  	}
> >
> > +	hwstats->qmprc = 0;
> >  	for (i = wx->num_vfs * wx->num_rx_queues_per_pool;
> >  	     i < wx->mac.max_rx_queues; i++)
> >  		hwstats->qmprc += rd32(wx, WX_PX_MPRC(i));
> 
> Sorry if I am being dense, but I have a question:
> 
> The treatment of qmprc prior to this patch seems consistent
> with other members of hwstats. What makes qmprc special?

The other members are read from CAB registers, and they are cleaned
on read. 'qmprc' is read from BAR register, it is designed not to be
cleared on read.



