Return-Path: <stable+bounces-136990-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF323AA01CB
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 07:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56E8E1B6309A
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 05:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658D126FA4E;
	Tue, 29 Apr 2025 05:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BSpWPQH6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E86220D4E2;
	Tue, 29 Apr 2025 05:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745904366; cv=none; b=Fk+7exSJCiWrHeqYWwNCzgoIMe7neW5wT5qi+j1AdFR3JHOSo9g6Ls0b7TAD6je1dupb5jl66Nc0ldg9FwoIh4LYPImUUnUtv056E2ThW+L96/smjWCdXv9bic/hO1SnFRHtuLdQkC0xIipDnUnFqxiTy+2JraodDb/h3AbcXP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745904366; c=relaxed/simple;
	bh=4MUBUkoGJl4Bv5nfEzeKWaFYA0vnWu4Vn3SkigflzUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddAMIxLSadeICqkB3U3wbLczXIY9LdeSD+iokiC+isITZAuXAKxBjoAiDmMlOATfhHh/yaHGp+UQ6KEe/pP90TDmB/kxcbVa/JpvMn5K8B8IkNbYM8LlvCxo5M6u2BZqQzdddqEnw0FlZTh7e2+lC5gQkhThisQimsks0NRu5s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BSpWPQH6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8517C4CEE3;
	Tue, 29 Apr 2025 05:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745904365;
	bh=4MUBUkoGJl4Bv5nfEzeKWaFYA0vnWu4Vn3SkigflzUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BSpWPQH6o5cG2ChcPFT+OsrrYUU+oIFjr5s8tA/ta6yM9Dm9kwVtu53tAxmPQIdHi
	 gYvf0VaWNdoruDgt7J2+LO4Wd98+gBMfHuIxQ6t1Sii2pvIVltZhOAlhH6H101wxs1
	 4sqvx6hRfP4Tcj8M+I43olzb3IV4EgrOujMvHSj4=
Date: Tue, 29 Apr 2025 07:26:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Ren, Jianqi (Jacky) (CN)" <Jianqi.Ren.CN@windriver.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jhs@mojatatu.com" <jhs@mojatatu.com>,
	"xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>,
	"jiri@resnulli.us" <jiri@resnulli.us>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"michal.swiatkowski@linux.intel.com" <michal.swiatkowski@linux.intel.com>,
	"He, Zhe" <Zhe.He@windriver.com>
Subject: Re: [PATCH 6.1.y v2] net/sched: act_mirred: don't override retval if
 we already lost the skb
Message-ID: <2025042928-vessel-mulled-fbf3@gregkh>
References: <20250428080103.4158144-1-jianqi.ren.cn@windriver.com>
 <2025042844-pavestone-fringe-1478@gregkh>
 <IA1PR11MB61703A24C42BAA887F5263ACBB802@IA1PR11MB6170.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR11MB61703A24C42BAA887F5263ACBB802@IA1PR11MB6170.namprd11.prod.outlook.com>

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?


http://daringfireball.net/2007/07/on_top

On Tue, Apr 29, 2025 at 02:07:54AM +0000, Ren, Jianqi (Jacky) (CN) wrote:
> Hello,
> I have already dropped the first v2 patch for incorrect comments(Maybe you missed the dropping email). This v2 patch is just I want to send. Thanks!

You can not send two different "v2" patches, that defeats the purpose of
versioning them entirely :)

thanks,

greg k-h

