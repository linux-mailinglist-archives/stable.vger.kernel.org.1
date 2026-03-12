Return-Path: <stable+bounces-224778-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NBgKvcRsml0IQAAu9opvQ
	(envelope-from <stable+bounces-224778-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 02:08:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D2326BD7E
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 02:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0DE2930219FA
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 01:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719C2340A6B;
	Thu, 12 Mar 2026 01:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SxB8HcUi"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F06D29E114
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 01:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773277680; cv=none; b=Yfiz6l0/vnvMIfmvq1rxk65Y5fo1JUwua+K4ykIQZuJtUzyV75SHCzgBHSBtpWZdCq4D3sil209owmQDrRbWJoX0fVmg8cWSr3MflZzpORGaoUmZN2FEV1aGHowS8Cjr1bwLyAZRPkphyUCOPFmLGbMv4xno+4O2lwz4eZuPSK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773277680; c=relaxed/simple;
	bh=a+hQuRsybNkUPcYsS0y+rM852fhUsXqBnm0YpohSO8c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FRRGYt+0co9drOOlboo3G8vNLEcvkhZkFOQHW2DTvUJBAi/fmwSIWE7TVEIfzF71RIJX6q9z2HeHP+jG35OF9PR+rCtT+8OfIQtSj9joiSQd1hq69SXZJqyXSLVtsDVv5Q3AQtZ7RoIjMWbNiNYy1cyTvizLOBOLunGTqmjUuZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SxB8HcUi; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4852ff06541so4293935e9.2
        for <stable@vger.kernel.org>; Wed, 11 Mar 2026 18:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773277676; x=1773882476; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tZsHRG8o/nbNJjk32sqXiP9sp0quOA3uEWj8KPrCrcI=;
        b=SxB8HcUibORQCVQVCk3DQpV5AnNywo3TT1AcIk8LRo7l2GM0zYN92SjBgnJAMSuPrG
         /hvLBTT5RFpAyzGAhpX69fMSU/XXpYxRFp81nMZtCqrU/IZWaIuN5jcpIwQJNwTDBi80
         F0x0kmrvWCfdW4xX5nv88u2+Qo6oLvRX99HmuQrmx6eTswzg7GNkmGM1ERM8kHrUuwMg
         el9wdBP86hjBywvuTRF9kn1qMn2mCTA3OHfQo//08412IhZ/HczFDbNvgAz6lKalrbXI
         tYW8SpT4n6GmZl55NuXU7403VIUJ0g80lVGMHhlDRsWiouYs1SdKV6AkkXhIegpKG1LH
         1wWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773277676; x=1773882476;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZsHRG8o/nbNJjk32sqXiP9sp0quOA3uEWj8KPrCrcI=;
        b=fhOx2I8B0dvwTlYREX/k5FApESj+t4QzqKqF7Er2FomnLAyqAlimZwV0d3vcY+kl0r
         9D9oGQEgr9+Rx3c07mbQnUUkD9NC1rAVApTmYW/q+H4T4Ythc6xMPL5/Pa7oy/SSn0JU
         4vaOLme5F71WRuO3UTwmKdzIZcjkddCzmlkS3m1/KS7T9BhDgN3XKGLyJmh+6NEQfG36
         Fc0aorOvKbjhQHSyHLAQrJXpe0Kq9W9+aDGc+Qeoo/ZHSZFyl0XgOB95t0bmavGc/e8m
         j5v53wu6v/IemFID7bExGz2bjMCSraaMTFjHL79iUnKIURDU/ev1TIwvNLZaslcngqW5
         qNUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO+Ct2PZPcl8BW940oIzhlrrHXiAEUc0dGXcKu1bufcs0eGFidwPSFQ/LskDUDcOWFmtWHUsk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2X/LQOjvnNX3jYklVwslQH7XZXZ/+svPz81B1JcIZWxFYYQKh
	txMFHnhH2bnmMToCu3XcT2pxgKO8zptJTZ+L5ZaY/r5ctJnxRJNVeeMdUALr1jBSVEw=
X-Gm-Gg: ATEYQzx00vfV/Q2l762gT12kmo18WSTQpnhgWecG0tPKZxAgl2DwWOjVhXP3S04OdJ9
	lV9C4nZuVedU4zAP4nhy9oEAPUPYYfgVuFd2RGmIA0Dzpd134BC1Wvn/RVMp/fTl0t8vaXI6hU/
	e3HnYWLzIi9LzP/O4iMM4iQ7XBm1PodToZPoVy9BtEMutc0cFrWAF+XZzWXYY5MLnt3ABDEQHeL
	biAJ+SnHMZ4UHM0n6Xkjxc5U52UE2TEp9KTebvJujeD0lD5FTAozDycV7VnK1yreyYrHLYpIups
	nPO78xhrLBSIbuAju+805EYI3Ip976qbEz/DwYf8ANmOysMZZaDH1V6kwFP0Z0Y+rrNLdnNTE+s
	Q0Yp5WtLPFpbIzUlBKV1450+N3HMJhgRbRIRchdP+tathEEcELkSwe+lVo1GgFSVHjtEo/l05A0
	+Uv55cI80hZt55Kn6qTNx6r7gr4oCOREFOqxtLc6O94AdruJfzLudsK1NFx2Ut1Q==
X-Received: by 2002:a05:600c:3104:b0:485:3e19:9e01 with SMTP id 5b1f17b1804b1-4854b10d0e1mr76242195e9.28.1773277675887;
        Wed, 11 Mar 2026 18:07:55 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aec07d017esm919535ad.9.2026.03.11.18.07.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 18:07:54 -0700 (PDT)
Message-ID: <8533b404-3377-416e-81d9-2bdb00baaae2@suse.com>
Date: Thu, 12 Mar 2026 11:37:24 +1030
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: reject root items with drop_progress and zero
 drop_level
From: Qu Wenruo <wqu@suse.com>
To: ZhengYuan Huang <gality369@gmail.com>, dsterba@suse.com, clm@fb.com
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, r33s3n6@gmail.com, zzzccc427@gmail.com,
 stable@vger.kernel.org
References: <20260312001443.3011961-1-gality369@gmail.com>
 <17c102a6-bbd1-4937-b5cc-5f6912551180@suse.com>
Content-Language: en-US
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <17c102a6-bbd1-4937-b5cc-5f6912551180@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-224778-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,suse.com,fb.com];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 55D2326BD7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



在 2026/3/12 10:53, Qu Wenruo 写道:
[...]
>>
>> Fixes: 259ee7754b67 ("btrfs: tree-checker: Add ROOT_ITEM check")
> 
> Again, it's not a bug fix. You're just adding a new check.

More info about when to use fixes tag:

https://www.kernel.org/doc/html/v6.19/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes

It's more common to use it for a regression, aka, before that commit 
everything works, but at that commit something is broken.

And in your case, the commit is not causing the BUG_ON() thus it's 
incorrect.
Furthermore you'd better not put the commit introducing the BUG_ON() as 
the fixes target.


In your case, you're just enhancing the tree-checker to address a fuzzed 
image (which I guess you'll continue submitting such patches), thus 
getting the fixes tag done correctly will save everyone time.

Thanks,
Qu

> 
> This fixes tag should only go with the error message fix.
> 
> You don't need to send a new update, I'll do all the update at merge time.
> 
> Otherwise looks good to me.
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> 
> Thanks,
> Qu
> 
>> Cc: stable@vger.kernel.org # 5.3+
>> Signed-off-by: ZhengYuan Huang <gality369@gmail.com>
>> ---
>> [CHANGELOG]
>> v2:
>> - Split out the error message fix from the previous patch, as requested
>>    during review.
>> ---
>>   fs/btrfs/tree-checker.c | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
>> index dd274f67ad7f..1e052c3303b3 100644
>> --- a/fs/btrfs/tree-checker.c
>> +++ b/fs/btrfs/tree-checker.c
>> @@ -1260,6 +1260,23 @@ static int check_root_item(struct extent_buffer 
>> *leaf, struct btrfs_key *key,
>>                   btrfs_root_drop_level(&ri), BTRFS_MAX_LEVEL - 1);
>>           return -EUCLEAN;
>>       }
>> +    /*
>> +     * If drop_progress.objectid is non-zero, a btrfs_drop_snapshot() 
>> was
>> +     * interrupted and the resume point was recorded in drop_progress 
>> and
>> +     * drop_level.  In that case drop_level must be >= 1: level 0 is the
>> +     * leaf level and drop_snapshot never saves a checkpoint there (it
>> +     * only records checkpoints at internal node levels in 
>> DROP_REFERENCE
>> +     * stage).  A zero drop_level combined with a non-zero drop_progress
>> +     * objectid indicates on-disk corruption and would cause a BUG_ON in
>> +     * merge_reloc_root() and btrfs_drop_snapshot() at mount time.
>> +     */
>> +    if (unlikely(btrfs_disk_key_objectid(&ri.drop_progress) != 0 &&
>> +             btrfs_root_drop_level(&ri) == 0)) {
>> +        generic_err(leaf, slot,
>> +                "invalid root drop_level 0 with non-zero 
>> drop_progress objectid %llu",
>> +                btrfs_disk_key_objectid(&ri.drop_progress));
>> +        return -EUCLEAN;
>> +    }
>>       /* Flags check */
>>       if (unlikely(btrfs_root_flags(&ri) & ~valid_root_flags)) {
> 
> 


