Return-Path: <stable+bounces-235784-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GE7ZH6IQ22mU8wgAu9opvQ
	(envelope-from <stable+bounces-235784-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 05:25:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 738BC3E29C2
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 05:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 30F5A300E191
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 03:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DF329B78B;
	Sun, 12 Apr 2026 03:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZgMuV62l"
X-Original-To: stable@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907CB24A06A
	for <stable@vger.kernel.org>; Sun, 12 Apr 2026 03:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775964316; cv=none; b=bIkcjDmNhbPnI42LUJssso6eBd3pTdxMnBRxOIzsptO2RGFefmhUglY7PZgGsd3tMOsQV2/gw8aNC0wMA7V02qQgn13IGpIWTQ7EYrDVeUzoLw8EOnUfErYM63f/repufhs2W9oknxF09m74CsPefbrQuY9qbd3ZUC3UJ9kK+WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775964316; c=relaxed/simple;
	bh=6DKS+kta3wZMzy28C00x/4732l2px1rBCzdvhowZKvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dw+QOHS5gr+8Y8RsYVf8chAChxgbj/0N7WW3PM5bLczBKqpWUYYJKBaJC9S4+DmKQMX+3D6c2u5OhAhk/T8ACA9llZ9RjNvzcvKANRx7xwyGJo1Dg3BdlweP+KH78mdfvOXBL9RUN8spOeZbcehm5PKgvHs3LS4VUFHnun/r4Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZgMuV62l; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3e688ea1-05ba-4e75-9d92-2751ff6f3b7b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775964301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P7F6ExSq2zsiYKOQxY6wgG6WKAhk4DvCSTWfDleLB2Y=;
	b=ZgMuV62lY8nfvrhh5RSEipLHno6dZ7PcK6Aduun7TThkr7wr8/4Wo+FK+uadqLJmEPPwDm
	/jk/E3QAMoEs6mZc7ViZUSXUVArA6w3AtTPhcp13XBglkOqPtHd7/4exmgI3DE70o7tSXt
	ed14obd+deDrohCEwy/u61pg3hAPDNQ=
Date: Sun, 12 Apr 2026 11:24:53 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm: thp: Fix refcount leak in thpsize_create() error path
Content-Language: en-US
To: Zi Yan <ziy@nvidia.com>
Cc: lgs201920130244@gmail.com, akpm@linux-foundation.org, david@kernel.org,
 lorenzo.stoakes@oracle.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260411062152.2092967-1-lgs201920130244@gmail.com>
 <20260411142858.85496-1-lance.yang@linux.dev>
 <848180C7-F98C-44B2-AB1F-579BF9EEA28E@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <848180C7-F98C-44B2-AB1F-579BF9EEA28E@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,kernel.org,oracle.com,linux.alibaba.com,redhat.com,arm.com,kvack.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-235784-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lance.yang@linux.dev,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 738BC3E29C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/4/12 09:49, Zi Yan wrote:
> On 11 Apr 2026, at 10:28, Lance Yang wrote:
> 
>> On Sat, Apr 11, 2026 at 02:21:52PM +0800, Guangshuo Li wrote:
>>> After kobject_init_and_add(), the lifetime of the embedded struct
>>> kobject is expected to be managed through the kobject core reference
>>> counting.
>>>
>>> In thpsize_create(), if kobject_init_and_add() fails, thpsize is freed
>>> directly with kfree() rather than releasing the kobject reference with
>>> kobject_put(). This may leave the reference count of the embedded struct
>>
>> Right. As documented for kobject_init_and_add(), once it has been
>> called, the error path should go through kobject_put():
>>
>> /**
>>   * kobject_init_and_add() - Initialize a kobject structure and add it to
>>   *                          the kobject hierarchy.
>> ...
>>   *
>>   * This function combines the call to kobject_init() and kobject_add().
>>   *
>>   * If this function returns an error, kobject_put() must be called to
>>   * properly clean up the memory associated with the object.  This is the
>> ...
>>   */
>> int kobject_init_and_add(struct kobject *kobj, const struct kobj_type *ktype,
>> 			 struct kobject *parent, const char *fmt, ...)
>>
>>> kobject unbalanced, resulting in a refcount leak and potentially leading
>>> to a use-after-free.
>>
>> IIUC, this looks more like wrong kobject lifetime handling and likely a
>> leak, not a clear UAF :)
> 
> kobject_put() ends up with calling kobj_type->release(), which is just
> kfree(to_thpsize(kobj)), equivalent to kfree(thpsize) in the old code.
> IIUC, there is no leak. Let me know if I miss anything.

Right, the fix is correct. I was only commenting on the changelog
wording, especially:

"resulting in a refcount leak and potentially leading to a use-after-free"

The old code does skip the required kobject cleanup path, but is
a UAF actually possible there?

Just a wording nit.

