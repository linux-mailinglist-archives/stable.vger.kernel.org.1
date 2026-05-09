Return-Path: <stable+bounces-244887-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iD/9IUaZ/mn0tQAAu9opvQ
	(envelope-from <stable+bounces-244887-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 04:17:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B84244FD946
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 04:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF1D1301B707
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 02:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00F8293B5F;
	Sat,  9 May 2026 02:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TGQZxyM5"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F0A2673AA;
	Sat,  9 May 2026 02:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778293056; cv=none; b=CnKFhEDf/zfDCA78cwqckGIHW+2Kr0w7N4eOigPuu1TPeU+lEAtiPuuH/xJelYB/ucgUAw+YryL5yEk7XvzaMH6gSqH1PCIBXiR03t+kyCBglLzTBBrZl/odngW/x0HUL/fGl5vgq4R467fbOPmQm3CENBW1glom2bzSCTK3+UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778293056; c=relaxed/simple;
	bh=HRmuLMDGFYWhflCqKnfSkmScy+y46tyDgDM3eZms4hs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R61WVzVWUBXB9MWaf2rr4X8LDi++iYXocS12OFvNQphQQPZQeDFYsLhQzDOPhA6B79AnUNare+I5gtxO2zDIpqHJIhGwvNN/R2LdHvC8qD80SQigluURVBrP0+3MXfg6u4XzeA2kzd8/amlsVBMeOSNTfagFeFtGsYHgDDujmL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TGQZxyM5; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=UKqqnZOvff6wGycc934hoYnnxSVsfu+OX89TZPksU5Q=;
	b=TGQZxyM5AiArmiorag8L41jzjr70HJE4x8IiDf4dm6mq6dXDzlVeaP2EH82eMK
	ZT4Rl6wDUEsf3FICOmnCfNIlY+i80v9uDHWRxldyY6hCQQlFh9e7KdTQLXPaeQbT
	HDn2XgjrVk3k9ShrFfIXybR5lU+tcPOO96U/p6AiJECew=
Received: from [192.168.1.40] (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgBXUA0Ymf5pGXcQCw--.145S2;
	Sat, 09 May 2026 10:17:00 +0800 (CST)
Message-ID: <00716c13-bec3-49f2-ab23-161b6e48c2c4@163.com>
Date: Sat, 9 May 2026 10:16:56 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6.y] dmaengine: idxd: Fix leaking event log memory
To: Sasha Levin <sashal@kernel.org>, gregkh@linuxfoundation.org,
 stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
References: <20260507040415.565-1-jetlan9@163.com>
 <20260509015927.agent5-0003@kernel.org>
From: Wenshan Lan <jetlan9@163.com>
Content-Language: en-US
In-Reply-To: <20260509015927.agent5-0003@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PigvCgBXUA0Ymf5pGXcQCw--.145S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrZF4kuryxGw18XFWkJFWUurg_yoW8JF17pF
	W3K34Yyr9rtFyUG390ga10y34Yyrsak3yrGw18KF9FkF4fGFyftFyfAF4jgr1rCw4fCFy5
	ta90q3ykCrs0yr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UTHqxUUUUU=
X-CM-SenderInfo: xmhwztjqz6il2tof0z/xtbC6x2HUGn+mR08BwAA3J
X-Rspamd-Queue-Id: B84244FD946
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-244887-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jetlan9@163.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Action: no action


On 5/9/2026 10:08 AM, Sasha Levin wrote:
> On Thu, May 07, 2026 at 12:04:15PM +0800, Wenshan Lan wrote:
>> From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>>
>> [ Upstream commit ee66bc29578391c9b48523dc9119af67bd5c7c0f ]
>>
>> -	gencfg.bits = ioread32(idxd->reg_base + IDXD_GENCFG_OFFSET);
>> -	if (!gencfg.evl_en)
>> -		return;
>> -
>>   	mutex_lock(&evl->lock);
> This drops the only thing that protects no-evl-capable hardware
> (idxd->evl == NULL) from dereferencing evl in idxd_device_evl_free().
> On 6.6, idxd_init_evl() returns 0 without allocating evl when
> hw.gen_cap.evl_support == 0, and idxd_device_evl_free() is still
> reachable in that path, so taking ee66bc29 alone will introduce a
> NULL deref on hardware without event-log support.
>
> The required prerequisite is upstream commit 52d2edea0d63c
> ("dmaengine: idxd: Fix crash when the event log is disabled"), which
> adds the "if (!evl) return;" guard at the top of idxd_device_evl_free().
> It landed as patch 2 of the same v3 series and is missing from 6.6.y.
>
> Could you resend as a 2-patch series with 52d2edea0d63c as the
> prerequisite? Then I'm happy to queue both for 6.6.y.

Thank you for your review. I will resend v2.

Wenshan Lan

>
> --
> Thanks,
> Sasha


