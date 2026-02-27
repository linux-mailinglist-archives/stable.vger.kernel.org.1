Return-Path: <stable+bounces-219975-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOreM5ewoWmMvgQAu9opvQ
	(envelope-from <stable+bounces-219975-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 15:56:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 758951B9520
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 15:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D2548301346E
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 14:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5540B42982D;
	Fri, 27 Feb 2026 14:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="hf85UrWi"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4442D780A
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 14:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772204179; cv=none; b=gpKedysdIW6hx65CCOebutAJJIw/cNk4ZkZ7fqPRVjPJJeInAFcZ+ZO45uM9iDqwR3wQ75xmQ9FyDQfy17CB/covYpBwGoGT+vYRNBLgLB1BzDr9VJcgMmX/EUZR6mY6JyQ9TuvMqw8GvCmHlOaEtr3g9UOspjC3i7BSQQXisVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772204179; c=relaxed/simple;
	bh=mimlqZ9LuKjxCReM0ltzHrYQT5WxgY+RWWDcaLIDqLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=olabzWOASbnZDka3aW283ZXtndX5vCf7kjsx7saeiqP6CVEC4t6CpgMKzF4bsMuI7rGfUx1awuVv5v9Q2CVlEgP71E5F7a/pQvb9r5Walvcc98rGyk+OEJRMjl5ZWBGbiM5XarSIpAka7jZ0/Lb1LQgRl6sGeWxBUOsubb1qOUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=hf85UrWi; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PXzg89hjwRM/PagE+dX+gN3W2rh61OKrpnFxZ0ownQs=; b=hf85UrWiXpJld8S1PgqnVjePrm
	Hkrg2nImO2WiEp5XNsxEZ2U8IVyMlP87SwjQHEG6VKeSsSIP/joL/ucHWlstPVvwIieC4o/NxZtjz
	3zkvABwI3sIQRcpncI8zITk/9UzTZ48tOqRGlzSv1TisaJ4lz09plD9Ek0e4+YCljfQSv9XvsBH/w
	jsWXCWcAmmxit0vmG7GZJ++m1osRi65VstJELj3Oog/ZraF/2F/h+Ht9++hQgv+gy9JwJAjLbEz/N
	5t2Y+cbmsvH2B7IWlkjqoDqTIiNSTc8LioJBuVRreOtPgSiY3VHQ2O+rMNH8KrLs15FmCQ4XcrcSk
	QRpkVdPw==;
Received: from [90.240.106.137] (helo=[192.168.0.101])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vvzGB-006Z08-57; Fri, 27 Feb 2026 15:56:07 +0100
Message-ID: <72f8293e-41a8-4149-a767-a27b14bc952b@igalia.com>
Date: Fri, 27 Feb 2026 14:56:06 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ttm: Fix ttm_pool_beneficial_order() return type
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Thadeu Lima de Souza Cascardo
 <cascardo@igalia.com>, stable@vger.kernel.org
References: <20260227124901.3177-1-tvrtko.ursulin@igalia.com>
 <9b0fd219-706c-4f15-9c71-f4e577ab6061@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <9b0fd219-706c-4f15-9c71-f4e577ab6061@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219975-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[tvrtko.ursulin@igalia.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:mid,igalia.com:email,amd.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lists.freedesktop.org:email]
X-Rspamd-Queue-Id: 758951B9520
X-Rspamd-Action: no action


On 27/02/2026 14:48, Christian König wrote:
> On 2/27/26 13:49, Tvrtko Ursulin wrote:
>> Fix a nasty copy and paste bug, where the incorrect boolean return type of
>> the ttm_pool_beneficial_order() helper had a consequence of avoiding
>> direct reclaim too eagerly for drivers which use this feature (currently
>> amdgpu).
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Fixes: 7e9c548d3709 ("drm/ttm: Allow drivers to specify maximum beneficial TTM pool size")
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
>> Cc: dri-devel@lists.freedesktop.org
>> Cc: <stable@vger.kernel.org> # v6.19+
> 
> Good catch, Reviewed-by: Christian König <christian.koenig@amd.com>

Well self inflicted.. :( Thank you for a quick review! I pushed it 
straight away to drm-misc-fixes.

Regards,

Tvrtko

>> ---
>>   drivers/gpu/drm/ttm/ttm_pool_internal.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/ttm/ttm_pool_internal.h b/drivers/gpu/drm/ttm/ttm_pool_internal.h
>> index 82c4b7e56a99..24c179fd69d1 100644
>> --- a/drivers/gpu/drm/ttm/ttm_pool_internal.h
>> +++ b/drivers/gpu/drm/ttm/ttm_pool_internal.h
>> @@ -17,7 +17,7 @@ static inline bool ttm_pool_uses_dma32(struct ttm_pool *pool)
>>   	return pool->alloc_flags & TTM_ALLOCATION_POOL_USE_DMA32;
>>   }
>>   
>> -static inline bool ttm_pool_beneficial_order(struct ttm_pool *pool)
>> +static inline unsigned int ttm_pool_beneficial_order(struct ttm_pool *pool)
>>   {
>>   	return pool->alloc_flags & 0xff;
>>   }
> 


