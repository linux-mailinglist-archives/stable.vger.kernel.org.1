Return-Path: <stable+bounces-158518-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7ADAAE7D71
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 11:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3148189B209
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 09:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9812BF015;
	Wed, 25 Jun 2025 09:24:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDABF29ACF1;
	Wed, 25 Jun 2025 09:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843452; cv=none; b=mnknI3Zav/VqWCLPq9G08tkg1mS/9LZW/+OYjaH4alFxA6HFq8iWbHwbxYaSQ+VK2diDQlmVgesvlYPLh7Z+83gdWlEFwmLr0GkycU4fTtX7/aiw4cPB/DAI8cxHSAAf8X+0XHbCC9JBpmJtAqEIuDrIcKQ2uidY2oSN7ay8P5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843452; c=relaxed/simple;
	bh=GtMpUXf0AldAqwlsG4t8bk9VWwvpumUXn1uff4D2zt8=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xu+hkVtCAjLF0oKaYXNngYQgV7XXa0RK7FTfZm3WZnCRW0IqB68PIHaYlFABN4IgWa1FiP4DaNYtrdvj4qkb/1qeVOzC2A1U6y0t6uxzmkm60CcJlamDrOpObRpvLXmfqbOtdtVCCoWCZQXSR/3+SS47K39BBs+XJOCRowvUJgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas3t1750843353t755t02024
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [60.186.80.242])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 8753326016482812335
To: "'Michal Swiatkowski'" <michal.swiatkowski@linux.intel.com>
Cc: <netdev@vger.kernel.org>,
	<andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<horms@kernel.org>,
	<mengyuanlou@net-swift.com>,
	<duanqiangwen@net-swift.com>,
	<stable@vger.kernel.org>
References: <20250624085634.14372-1-jiawenwu@trustnetic.com> <20250624085634.14372-2-jiawenwu@trustnetic.com> <aFu4yUsWek/x9kqd@mev-dev.igk.intel.com>
In-Reply-To: <aFu4yUsWek/x9kqd@mev-dev.igk.intel.com>
Subject: RE: [PATCH net v2 1/3] net: txgbe: request MISC IRQ in ndo_open
Date: Wed, 25 Jun 2025 17:22:27 +0800
Message-ID: <030d01dbe5b2$ab34df70$019e9e50$@trustnetic.com>
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
Thread-Index: AQG8FB25wsfEchebLehyFWt5Oiz5UQF8meEIAbHDH+a0OceckA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MdzdX6p4PZzkstnd+MI+6iK2WIaBPpUZFtVUh2Y7AVwo+LdIRhetfZM1
	/XdQWu2ZThmfXaA0k78T+Jqk25Whsa9Nmq1kZp7k0/W7QO4rT+RupcbjNWM2QNS2p1NC18W
	/jeJhkSWx/HuH15Enmsr4CdogPxB5FbKfonLJVX5ojwKZEJRaTen3xMK/Q06vqGSH2RgRzV
	L7OdW6xCeWCOYlZjn3Zio44YM9/Q4Q6Z67GsQ/m9d/qwna8nt5CZBrAqAH5Iq7UweoqYqJq
	L8DfW3w/e7aYuWux8TN9GGmfeTTlqxo/1Zm0BVr/GRhLlcjy23pDFlgApCV647mArAAdyoq
	4zbwiOdIiYZHQfr4AgaBeZdTTso2RcmHkqv+cZde3iL/wWl0UBk/+9v87xCNLHRtg1OEZtV
	/zTRkEWdRF1sHDICD5IVKf3MfI1sTh/OvvEx72InYb3X2XtLWC/vYdZVDqbsDQORXkDGOiI
	G6w1cUnv6DKnAClGXlhl+McGGhfzUP6hy6WDA2FIQVgi/93gsYN/HLR2HV79IrDqGC1GUm3
	XwM0OlWf2PXz+rR8FFBZBmJJMW6ganpu1Df4PXxO8UD8tSkk/4hh8mwTza16sdGnr2RYtF5
	XEIlaGg3yn1r+VxxjocepjDJFikd9iQI/T3yXMh1xKGpgUH787Qb8JL1DB2j629/ZyQFqaI
	JAbhi56x4rWpfBDhrrzoCfDSM0eSbc1Ih2iXIZLDxkwSs0aHzvtBXnG8eP3R6g4tBr4XFkI
	2MBcj0FVARgjf+Y0Dg9lxafabyYqxvysZ1u9MTDMvWHsnIlQgQlSlMD4MBOoZZl2fgOfVQE
	ek9ygWTKu3XykPDdNIsLBgbL7+IIHtrIOQAT/kzyiTG7ylhxd3Th2NZPjaTfrn6EP/fVvbe
	V17d2sKJ38bmGffMoc9R3gEGe0D0fUd55JtAH/2YXzWuyIgdk1XdNCT+d/gHil04lMf/ubb
	6XV1RZ3eAtb6F/lDoz/ynXRx1syr7u7vyx+Z6jBMZf69MCCyC6AGvpNZIzSHI0u7sDCWdxP
	ECJbH4cf+QjWozfDD+FcjVoaLdEA9AdAjr3JHjnw==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

On Wed, Jun 25, 2025 4:53 PM, Michal Swiatkowski wrote:
> On Tue, Jun 24, 2025 at 04:56:32PM +0800, Jiawen Wu wrote:
> > Move the creating of irq_domain for MISC IRQ from .probe to .ndo_open,
> > and free it in .ndo_stop, to maintain consistency with the queue IRQs.
> > This it for subsequent adjustments to the IRQ vectors.
> >
> > Fixes: aefd013624a1 ("net: txgbe: use irq_domain for interrupt controller")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> > ---
> >  .../net/ethernet/wangxun/txgbe/txgbe_irq.c    |  2 +-
> >  .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 22 +++++++++----------
> >  2 files changed, 11 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
> > index 20b9a28bcb55..dc468053bdf8 100644
> > --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
> > +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
> > @@ -78,7 +78,6 @@ int txgbe_request_queue_irqs(struct wx *wx)
> >  		free_irq(wx->msix_q_entries[vector].vector,
> >  			 wx->q_vector[vector]);
> >  	}
> > -	wx_reset_interrupt_capability(wx);
> >  	return err;
> >  }
> >
> > @@ -211,6 +210,7 @@ void txgbe_free_misc_irq(struct txgbe *txgbe)
> >  	free_irq(txgbe->link_irq, txgbe);
> >  	free_irq(txgbe->misc.irq, txgbe);
> >  	txgbe_del_irq_domain(txgbe);
> > +	txgbe->wx->misc_irq_domain = false;
> >  }
> >
> >  int txgbe_setup_misc_irq(struct txgbe *txgbe)
> > diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> > index f3d2778b8e35..a5867f3c93fc 100644
> > --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> > +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> > @@ -458,10 +458,14 @@ static int txgbe_open(struct net_device *netdev)
> >
> >  	wx_configure(wx);
> >
> > -	err = txgbe_request_queue_irqs(wx);
> > +	err = txgbe_setup_misc_irq(wx->priv);
> 
> Don't you need misc interrupt before ndo_open is called? I wonder if it
> won't be simpler to always use last index (8) for misc irq. Is it
> possible? I mean, use 8 event if the number of queues is lower than 8.
> If yes you can drop this patch and hardcode misc interrupts on index 8.
> 
> [...]
> 
> BTW, assuming you can't always use last index, the patch looks fine.

Cannot always use index (8). Because the max RSS index is 63 for TXGBE,
but 8 for NGBE. This hardware limitation is only for NGBE. And index (8)
cannot be used by PF when SRIOV is enabled on NGBE.

In fact, the misc interrupt is only used when the device is opened.



