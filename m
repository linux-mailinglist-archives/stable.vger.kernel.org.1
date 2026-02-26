Return-Path: <stable+bounces-219824-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDxXAOpdoGlgiwQAu9opvQ
	(envelope-from <stable+bounces-219824-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 15:51:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF7F1A7F3C
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 15:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E011301570F
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 14:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6E438A70D;
	Thu, 26 Feb 2026 14:46:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out28-172.mail.aliyun.com (out28-172.mail.aliyun.com [115.124.28.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89933334C39;
	Thu, 26 Feb 2026 14:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772117164; cv=none; b=nBobBYOTpC/MFZDeTfFq4rPkqAJbWT6Sh5U66TiXVM0eBA12y2BsXg7Zc8fNol5KTxoYpEP/vLnsSVeMmGdU/3cd3CRbZ5bpsamxFnANU5aL2M7h5xcMkpUeZtzfPuwBMCFg8um79O73vsonsDKdJykOwZkC4hwo79yLvgG7x24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772117164; c=relaxed/simple;
	bh=DgF0IYjBbsyJh857YMJXjn6QIo0nTyjfcImW8VJYEw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oGrF2/pY5CBUPVHK7J1SMo9B862I+IdeSZMPkp8+xkCWDx2dpu+XGdId4JS5ZwsT/Jck7btwk06gb218y8WnGJMZEhyQQJmEKkhhxnQd0r6fvYfemNJEKUGBAkDYMlzSDbTuLbo5yWO9kvp1BXkjLikkps+xD6ZBit8M7qWP5E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bosc.ac.cn; spf=pass smtp.mailfrom=bosc.ac.cn; arc=none smtp.client-ip=115.124.28.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bosc.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bosc.ac.cn
Received: from 192.168.0.24(mailfrom:guoyaxing@bosc.ac.cn fp:SMTPD_---.gff0XUD_1772117154 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 26 Feb 2026 22:45:55 +0800
Message-ID: <db7a0ea0-afef-410e-bc20-7592065e1c88@bosc.ac.cn>
Date: Thu, 26 Feb 2026 22:45:40 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] uio: uio_pci_generic_sva: fix double free of
 devm_kzalloc() memory
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Guangshuo Li <lgs201920130244@gmail.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260226011632.4186353-1-lgs201920130244@gmail.com>
 <2026022555-improper-fanatic-cd10@gregkh>
 <CANUHTR8hzrnM6s_ysGea3kO8crbeq_onzgcfDTV6UAMB9QFogA@mail.gmail.com>
 <2026022659-carry-raisin-05ff@gregkh>
From: =?UTF-8?B?6YOt5Lqa5pif?= <guoyaxing@bosc.ac.cn>
In-Reply-To: <2026022659-carry-raisin-05ff@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219824-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[bosc.ac.cn];
	FREEMAIL_TO(0.00)[linuxfoundation.org,gmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guoyaxing@bosc.ac.cn,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bosc.ac.cn:mid]
X-Rspamd-Queue-Id: 5EF7F1A7F3C
X-Rspamd-Action: no action



On 2/26/2026 10:32 PM, Greg Kroah-Hartman wrote:
> On Thu, Feb 26, 2026 at 06:14:54PM +0800, Guangshuo Li wrote:
>> Hi Greg,
>>
>> Thanks for the reminder.
>>
>> This was found by a static analysis tool I designed. After a manual
>> review, I confirmed the issue and sent the fix.
>>
>> Would you prefer that I include the “how it was found and tested”
>> information in the commit message?
> 
> As per our documentation (please go read it again), it is required :)
> 
> thanks,
> 

Hi Greg, Guangshuo
I’d be happy to help test this bug and the proposed patch.
  (Well… to be honest, I probably should have fixed it myself earlier — 
I’ve been meaning to, but got caught up with other things lately…)
Thanks for working on it!

Best regards,
Yaxing Guo

> greg k-h


