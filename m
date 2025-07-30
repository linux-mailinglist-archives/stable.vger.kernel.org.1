Return-Path: <stable+bounces-165198-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4E2B15A05
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 09:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76D5D7A4C1C
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 07:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F6A2877C1;
	Wed, 30 Jul 2025 07:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="tHoTEQpc"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291921F1537
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 07:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753861953; cv=none; b=iZdXPthdU8gpiixnapZyFBrtexx6zIB9SqXxK6THjOywCAbrVCl0WITSLMygoGmmKwF1KV0Dqe44iydE97uq16oWQXtTXMROBoEfeMnJ9H8BDZczJTfgFAdcqB7oSgeb05VbHwmAPLiqAA9ZVioXYxSMUxXRedvm5A6vVUk9evI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753861953; c=relaxed/simple;
	bh=RfRzky2XO+T1kuZiOGjoEqu3nC9xEMyowz6O2MKUaG0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IsoswwSocZcuBnUTyQpM1w8DB3DO29IZgYlpDyKPw2FRWeRRy4pbG6FfjbQI73Ew3bgr0l/SsD8Ut30h7PiujPOPc3TEzK2o6geDBjPC4kxKnSKjOXhEoHT7cuoNrmb6wkCFz9lb7obAwdxUSFPXxJ9BGffXMWyMVpGYBWf+bpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=tHoTEQpc; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1753861952; x=1785397952;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ewmKg2qydsqsPsmwmuOE+1zussXmQpRpngogWAjgHX8=;
  b=tHoTEQpcMpxAJH8kTlOgA+dowGj4ZP+N2qD1igBOOJuh3guI1uhq1Z07
   bUM0S4m/Q7lOHju4pbCtR+EtrzqT4Pv3RQoZkbCvdQhOn3YitB+tHyyVh
   KEE+8oXQpJUzHCtZSxYdzVSWzf+gXLaul9/te5O2o8XT8t5OgVTbGeHaQ
   oVP78e4PCTR7OzDcfxQGIWxnI8FbGBIgyDjlbozUe7l+dS0h02H55ofar
   qBMz/awAHC1gmYuShpjeBcEcMuN2KloNfkQadD37zJm3xdy2NuoKtU8lY
   gIdcL44hL4sPepZ3/6r6iXhzdt2thpnYCPKOq6I7VjToXiTeVPRg9fpBh
   g==;
X-IronPort-AV: E=Sophos;i="6.16,350,1744070400"; 
   d="scan'208";a="218293529"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 07:52:30 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:12002]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.62.141:2525] with esmtp (Farcaster)
 id bd670100-5b4c-4039-a6c9-e56ef9592578; Wed, 30 Jul 2025 07:52:30 +0000 (UTC)
X-Farcaster-Flow-ID: bd670100-5b4c-4039-a6c9-e56ef9592578
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 30 Jul 2025 07:52:30 +0000
Received: from dev-dsk-acsjakub-1b-6f9934e2.eu-west-1.amazon.com
 (172.19.75.107) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14; Wed, 30 Jul 2025
 07:52:27 +0000
Date: Wed, 30 Jul 2025 07:52:25 +0000
From: Jakub Acs <acsjakub@amazon.de>
To: Greg KH <gregkh@linuxfoundation.org>
CC: <stable@vger.kernel.org>, Liu Shixin <liushixin2@huawei.com>, Yang Shi
	<yang@os.amperecomputing.com>, David Hildenbrand <david@redhat.com>,
	Chengming Zhou <chengming.zhou@linux.dev>, Johannes Weiner
	<hannes@cmpxchg.org>, Kefeng Wang <wangkefeng.wang@huawei.com>, Mattew Wilcox
	<willy@infradead.org>, Muchun Song <muchun.song@linux.dev>, Nanyong Sun
	<sunnanyong@huawei.com>, Qi Zheng <zhengqi.arch@bytedance.com>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>, Jakub Acs
	<acsjakub@amazon.de>
Subject: Re: [PATCH 6.12.y] mm: khugepaged: fix call
 hpage_collapse_scan_file() for anonymous vma
Message-ID: <20250730075225.GA39475@dev-dsk-acsjakub-1b-6f9934e2.eu-west-1.amazon.com>
References: <20250729090347.17922-1-acsjakub@amazon.de>
 <2025072932-scorer-manhood-b6fc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2025072932-scorer-manhood-b6fc@gregkh>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: EX19D032UWB003.ant.amazon.com (10.13.139.165) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Tue, Jul 29, 2025 at 04:49:51PM +0200, Greg KH wrote:
> 
> You need to sign off on patches you forward on.  Please fix that up and
> resend all of these.
> 
> thanks,
> 
> greg -h

Oh, that's embarrassing, my apologies for the miss, sent v2s:
https://lore.kernel.org/all/20250730073927.27312-1-acsjakub@amazon.de/
https://lore.kernel.org/all/20250730073956.28488-1-acsjakub@amazon.de/
https://lore.kernel.org/all/20250730073945.27790-1-acsjakub@amazon.de/

Jakub



Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


