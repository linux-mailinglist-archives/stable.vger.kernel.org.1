Return-Path: <stable+bounces-274794-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VEFgNsBVV2r8JwEAu9opvQ
	(envelope-from <stable+bounces-274794-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 11:41:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E3D75C9D0
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 11:41:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=pishA9GC;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274794-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-274794-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E2B8D3006B5A
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 09:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF35D3C7E0B;
	Wed, 15 Jul 2026 09:41:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AD443A7FB
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 09:41:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784108473; cv=none; b=Dq19SHezjEAZdGSWT/CNOJZIan2dDkA965Cmr1VaFB5PVoVp/8yC123tr/qBsGCUJ6aFCLXtUXvDBIuwOuJvkJcx+imORRqjqk+/ffx1MMXmHaFm8VRdDRqeMF9NbjVz2TQTHxABFPEXsvkRCWRpPZ12ma4QbIH2B4NSjiKruNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784108473; c=relaxed/simple;
	bh=YGHRu+F97cWhGi6/KVH2KxwUVUoIhplxmVJj/OEzjb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F7STfiCTZZ4RORNxDgub7XUVZ0mhiD7TcF0npnYcX11dMjyg0TiGUiKVfVXQS38fjy59mgzF6PeqUq1gc79dELmHhZut7LmDKgarfs4tT4TKm+fVcoQyQr4VeLz1Z/zsTqB5xL4SgspkItbY6tzehlLtCSIKayWV+v4+v7PL6s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pishA9GC; arc=none smtp.client-ip=91.218.175.179
Message-ID: <b2b2a0df-2164-44a5-a7a1-e7cecf1f7b86@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784108461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9pLf70bhIsBjYYAuXnkUf9IaSpfzFW1UY6uqtiFu0Cc=;
	b=pishA9GCA8WBAZW7KVKBT0Ofny9G+wF+WswAd6T6SRV3HSSZjsheVlF3H3Te2smds2jHX7
	d/3Irf3H7Z+CbcsQkijkkvpR7n9cEU4Yig7ZGAITVMkmWtTTqnY6hmhogBKQQB+hmZqOLT
	wZr6Gu+f84lxn/AB67o0IehsNJdxmPI=
Date: Wed, 15 Jul 2026 17:40:01 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH iwl-net v2 1/2] iavf: fix ASQ command buffer leak on init
 failure
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 Mitch Williams <mitch.a.williams@intel.com>,
 Greg Rose <gregory.v.rose@intel.com>,
 Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20260715082548.56687-1-xuanqiang.luo@linux.dev>
 <20260715082548.56687-2-xuanqiang.luo@linux.dev>
 <MW4PR11MB5890DCEED74E887ACBC9161AF0F82@MW4PR11MB5890.namprd11.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <MW4PR11MB5890DCEED74E887ACBC9161AF0F82@MW4PR11MB5890.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274794-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jedrzej.jagielski@intel.com,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:intel-wired-lan@lists.osuosl.org,m:andrew+netdev@lunn.ch,m:mitch.a.williams@intel.com,m:gregory.v.rose@intel.com,m:sudheer.mogilappagari@intel.com,m:netdev@vger.kernel.org,m:luoxuanqiang@kylinos.cn,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[xuanqiang.luo@linux.dev,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanqiang.luo@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[stable,netdev];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:from_mime,linux.dev:mid,linux.dev:email,linux.dev:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 72E3D75C9D0


在 2026/7/15 17:28, Jagielski, Jedrzej 写道:
> From: xuanqiang.luo@linux.dev <xuanqiang.luo@linux.dev>
> Sent: Wednesday, July 15, 2026 10:26 AM
>
>> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>>
>> iavf_alloc_adminq_asq_ring() allocates cmd_buf before the remaining ASQ
>> resources. If iavf_alloc_asq_bufs() or iavf_config_asq_regs() fails, the
>> unwind path elides cmd_buf while freeing the other allocations.
>>
>> The ASQ count is not set until initialization succeeds, so the shutdown
>> path cannot reclaim the buffer. Free cmd_buf in the common unwind path.
>>
>> Fixes: d358aa9a7a2d ("i40evf: init code and hardware support")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>> ---
>> drivers/net/ethernet/intel/iavf/iavf_adminq.c | 1 +
>> 1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/net/ethernet/intel/iavf/iavf_adminq.c b/drivers/net/ethernet/intel/iavf/iavf_adminq.c
>> index 6937b7dd44cbb..40f76f9507f4b 100644
>> --- a/drivers/net/ethernet/intel/iavf/iavf_adminq.c
>> +++ b/drivers/net/ethernet/intel/iavf/iavf_adminq.c
>> @@ -60,6 +60,7 @@ static enum iavf_status iavf_alloc_adminq_arq_ring(struct iavf_hw *hw)
>>   **/
>> static void iavf_free_adminq_asq(struct iavf_hw *hw)
>> {
>> +	iavf_free_virt_mem(hw, &hw->aq.asq.cmd_buf);
>> 	iavf_free_dma_mem(hw, &hw->aq.asq.desc_buf);
>> }
>>
>> -- 
>> 2.43.0
> Looks fine, thanks!
>
> Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
>
> One note for the future - please be aware that there is minimal time period to be
> waited before resubmitting new patch revision, which is at least 24h for netdev/IWL
> mailing lists

Thanks for the reminder!

I also received a notification from netdev-bot, and I'll keep this in
mind for future revisions.


