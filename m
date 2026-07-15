Return-Path: <stable+bounces-274766-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XUTGIYpFV2qrIQEAu9opvQ
	(envelope-from <stable+bounces-274766-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 10:32:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DB775BE7C
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 10:32:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=BozRlNq8;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274766-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-274766-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8AF33014C0E
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 08:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F25362130;
	Wed, 15 Jul 2026 08:31:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEA01FBEA8
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 08:30:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784104261; cv=none; b=JUyNNNEAy0WMx7JFV9uSyqHURT2YQjhlkF5ijUYHXB1o6JFBG1ipBqPqIjH9Xni2zVpAodMzpeV9jA9AXhDrQ718cKXzRKV+c2oIuYNsdcfoK0VqvggMiFYaoAv66QlEKUlazLcAAwy3iaaEy+l32Lm5KaPEMuzRP54FkIGOJa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784104261; c=relaxed/simple;
	bh=fsO3AO0raATK8j0HGKAwPovfT+eHZM8MEFa0Mee9Bms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Be3yUbvoLLEVEE8g1Jy6oAyzfGx9jcFQcl6xjIh8Y+RBVw/OoleAs/3iX1G6RV9oIt2yfxHRhtCk93FK8R0it9BCDrUoKUZNEsSm51SuiJHXEm23uuVB2HGtrDnUOq5iLuuakbK2+0aAVctdKgbVZe71LZTxl5EYj+WP3uFDSHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BozRlNq8; arc=none smtp.client-ip=91.218.175.189
Message-ID: <fcd20554-beb3-4ac8-9768-14f9bb8ce8b4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784104257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dQrae6Cm2MY06HGEjU3/xL5rXu67Kdy2Kb+NwAvEBps=;
	b=BozRlNq8VOl4+ctCscuxFAqWjvKWlDxZhZ0vNzXbzqpf6ftrM/RVx1jZTju87PpDmjx5oY
	Ks1kx1HbxJeEzhhtBmOjUT2JC46bRzooaqV23riTSdmRwc0BOG4cBUU37TQXx48DqxsZHv
	Yi0dfoPdmWHvID0sLp2lCrdZZzMkBVQ=
Date: Wed, 15 Jul 2026 16:30:06 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH iwl-net v1 1/2] iavf: fix ASQ command buffer leak on init
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
References: <20260715061131.34420-1-xuanqiang.luo@linux.dev>
 <20260715061131.34420-2-xuanqiang.luo@linux.dev>
 <PH0PR11MB590272FD2023440F52E95689F0F82@PH0PR11MB5902.namprd11.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <PH0PR11MB590272FD2023440F52E95689F0F82@PH0PR11MB5902.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274766-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:from_mime,linux.dev:mid,linux.dev:email,linux.dev:dkim,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D7DB775BE7C


在 2026/7/15 15:24, Jagielski, Jedrzej 写道:
> From: xuanqiang.luo@linux.dev <xuanqiang.luo@linux.dev>
> Sent: Wednesday, July 15, 2026 8:12 AM
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
>> index 6937b7dd44cbb..82a32f8e78c12 100644
>> --- a/drivers/net/ethernet/intel/iavf/iavf_adminq.c
>> +++ b/drivers/net/ethernet/intel/iavf/iavf_adminq.c
>> @@ -346,6 +346,7 @@ static enum iavf_status iavf_init_asq(struct iavf_hw *hw)
>> 	iavf_free_virt_mem(hw, &hw->aq.asq.dma_head);
>>
>> init_adminq_free_rings:
>> +	iavf_free_virt_mem(hw, &hw->aq.asq.cmd_buf);
> Hi Xuanqiang
> much thanks for the patches!
>
> how about moving that line directly into iavf_free_adminq_asq()?
> then free func would be paired 1:1 with alloc func

Thanks for the suggestion!

I've addressed it and sent out v2.

>
>> 	iavf_free_adminq_asq(hw);
>>
>> init_adminq_exit:
>> -- 
>> 2.43.0

