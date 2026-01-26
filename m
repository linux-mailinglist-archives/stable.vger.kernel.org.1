Return-Path: <stable+bounces-211553-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yH/iLxdWd2nMeAEAu9opvQ
	(envelope-from <stable+bounces-211553-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 12:55:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD9087E07
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 12:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F47D303B4C4
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 11:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC76332EC4;
	Mon, 26 Jan 2026 11:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="b9J9SHkj"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440E933033C
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 11:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769428227; cv=none; b=R01r3nGPpEdrS9W2tk3un8y7PMtBmls85XvFVChxag0Sb+ghftUMuZTDrTeuwoERT21fM94JtHrLCVPr6Kt+oc6aqDWcK0PXKwQExjjd77J40lF2GRxb2WxlBX4zbIhoiaCQSelX1pkqdiQFCd7QOiBvjA5TWm0GxQCZc8OtsYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769428227; c=relaxed/simple;
	bh=vcrzpCDdtv6Hrev0Z5UmeaahAhfpfn7TvVcuoU3lJ9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NWPTSuCNwl1W2qngPvLGyz1M7v4XBrY5uhaMwAVQUFNmBkGuadgfIIZ9PkeXne0OrZ/Y0YsVDcFmRDVktsXDAKKDPA6bU9AkkqRG1Vwzp99ZLxXvPuGhF0HoTwnR3Hz0ZfKl7jR+Bj/sgowOwZbYYnFT1ubXLO+9OaohxUBuufc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=b9J9SHkj; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fNdXdx3qpgtP8W7eHWimmJlGqGjPkF4bLSPE3qsDDxw=; b=b9J9SHkjo7vDS8rVgQb9Ekv8XW
	ZtJu4j7xsdILnMAyjAO9GiewSYRe3AqXcUtC3oNZkFLsu+cFwKW+b2KrW0JRCeIx7hPqu0Quj7Fef
	yWC58z14q3GHqX8XonMeb6IojX98lIgHoguoCfhj7NaaurZjqcELugQSshlb34/e/DhkPZjbqsg2c
	ETBYK4Pi6fqz0FEX4RzXxufJ2WzZ6b+tzoOesfO5OTo6YgRXqHGOrUGCK7s2gnExgeiJVl6cjc4Gf
	KwijCChSx+WQ/b1yfPzQUPmbXeZRRkHOao3cFmUlEraxiugChA+jE4qwuI5mqEG8glI/F1PQ1kA3G
	j6DQYMSw==;
Received: from [90.240.106.137] (helo=[192.168.0.101])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vkL6j-00A1TM-Hn; Mon, 26 Jan 2026 12:50:13 +0100
Message-ID: <03cd76ac-7cb9-4493-8695-3d2d60358709@igalia.com>
Date: Mon, 26 Jan 2026 11:50:12 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm: Do not allow userspace to trigger kernel warnings
 in drm_gem_change_handle_ioctl()
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Zhi Wang <wangzhi@stu.xidian.edu.cn>,
 David Francis <David.Francis@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, stable@vger.kernel.org
References: <9bde8c39-ba4c-49c5-a0bc-4e78338f055a@amd.com>
 <20260123141540.76540-1-tvrtko.ursulin@igalia.com>
 <9e5f8140-d197-46f2-8324-bd705a889ecf@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <9e5f8140-d197-46f2-8324-bd705a889ecf@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211553-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	FROM_NEQ_ENVFROM(0.00)[tvrtko.ursulin@igalia.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:mid,igalia.com:email,amd.com:email,xidian.edu.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0AD9087E07
X-Rspamd-Action: no action


On 26/01/2026 09:02, Christian König wrote:
> 
> 
> On 1/23/26 15:15, Tvrtko Ursulin wrote:
>> Since GEM bo handles are u32 in the uapi and the internal implementation
>> uses idr_alloc() which uses int ranges, passing a new handle larger than
>> INT_MAX trivially triggers a kernel warning:
>>
>> idr_alloc():
>> ...
>> 	if (WARN_ON_ONCE(start < 0))
>> 		return -EINVAL;
>> ...
>>
>> Fix it by rejecting new handles above INT_MAX and at the same time make
>> the end limit calculation more obvious by moving into int domain.
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Reported-by: Zhi Wang <wangzhi@stu.xidian.edu.cn>
>> Fixes: 53096728b891 ("drm: Add DRM prime interface to reassign GEM handle")
>> Cc: David Francis <David.Francis@amd.com>
>> Cc: Felix Kuehling <felix.kuehling@amd.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: <stable@vger.kernel.org> # v6.18+
> 
> Reviewed-by: Christian König <christian.koenig@amd.com>

Pushed to drm-misc-fixes, thank you!

Regards,

Tvrtko

> 
>> ---
>> v2:
>>   * Rename local variable, re-position comment, drop the else block. (Christian)
>>   * Use local at more places.
>> ---
>>   drivers/gpu/drm/drm_gem.c | 18 ++++++++++++------
>>   1 file changed, 12 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
>> index 7ff6b7bbeb73..ffa7852c8f6c 100644
>> --- a/drivers/gpu/drm/drm_gem.c
>> +++ b/drivers/gpu/drm/drm_gem.c
>> @@ -1001,16 +1001,21 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
>>   {
>>   	struct drm_gem_change_handle *args = data;
>>   	struct drm_gem_object *obj;
>> -	int ret;
>> +	int handle, ret;
>>   
>>   	if (!drm_core_check_feature(dev, DRIVER_GEM))
>>   		return -EOPNOTSUPP;
>>   
>> +	/* idr_alloc() limitation. */
>> +	if (args->new_handle > INT_MAX)
>> +		return -EINVAL;
>> +	handle = args->new_handle;
>> +
>>   	obj = drm_gem_object_lookup(file_priv, args->handle);
>>   	if (!obj)
>>   		return -ENOENT;
>>   
>> -	if (args->handle == args->new_handle) {
>> +	if (args->handle == handle) {
>>   		ret = 0;
>>   		goto out;
>>   	}
>> @@ -1018,18 +1023,19 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
>>   	mutex_lock(&file_priv->prime.lock);
>>   
>>   	spin_lock(&file_priv->table_lock);
>> -	ret = idr_alloc(&file_priv->object_idr, obj,
>> -		args->new_handle, args->new_handle + 1, GFP_NOWAIT);
>> +	ret = idr_alloc(&file_priv->object_idr, obj, handle, handle + 1,
>> +			GFP_NOWAIT);
>>   	spin_unlock(&file_priv->table_lock);
>>   
>>   	if (ret < 0)
>>   		goto out_unlock;
>>   
>>   	if (obj->dma_buf) {
>> -		ret = drm_prime_add_buf_handle(&file_priv->prime, obj->dma_buf, args->new_handle);
>> +		ret = drm_prime_add_buf_handle(&file_priv->prime, obj->dma_buf,
>> +					       handle);
>>   		if (ret < 0) {
>>   			spin_lock(&file_priv->table_lock);
>> -			idr_remove(&file_priv->object_idr, args->new_handle);
>> +			idr_remove(&file_priv->object_idr, handle);
>>   			spin_unlock(&file_priv->table_lock);
>>   			goto out_unlock;
>>   		}
> 


