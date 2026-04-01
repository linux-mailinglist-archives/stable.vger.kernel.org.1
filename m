Return-Path: <stable+bounces-232870-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLdJLgqZzWkrfQYAu9opvQ
	(envelope-from <stable+bounces-232870-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 00:15:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13825380E08
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 00:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07289301BCE2
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 22:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC812346FA6;
	Wed,  1 Apr 2026 22:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NjQD32in"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5046A31A56D
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 22:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775081436; cv=none; b=nYWW+S6AnFEZ/MrvmESdlMzlPG815LcehKMy7nz88pLVSTIz/vDi8bAlwWbaEkIjGDlNoLaPlAGh2ms639rodsA+WQhVxTWrlHUtRWOmH19jr9oYaVZ3lvZ2k4Pf1s09oD0Y+z1GelCOdEJRMuYuyPPM6qEUBfJ4Ztp0X8tVQKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775081436; c=relaxed/simple;
	bh=urctENoJz1VQH9VBs2R67GU+6j7TuKW03BVzg14YeFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ucrp6B4DLmWN8lRWSB92WaUb8eDqD1MiUhClr6he5sqzDgU2406Nyv26Uwe9gp1R9Hr8LrmCDxMj2IpYJETcXJJQiBiMfyf9PXdZ3u7jrCFXRWS2LFC7S9v46FQz+nIYVe4nojB8oTCbSjFRtLx8R8vwD0FfttA4fMn4SVruWcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NjQD32in; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso1341105e9.3
        for <stable@vger.kernel.org>; Wed, 01 Apr 2026 15:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775081434; x=1775686234; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGn8ZfejuIHQEAr3dSJQgxj1UyGWLDa21lXVxlUAKPg=;
        b=NjQD32inKqlmYF1HlZBHVLePM/EMkXf8zsq+4wLzrf8yrjYTV5rdgS9hZX/PAh46w/
         No74Z78wDxMnaE45UVQyWt8bw/dPvc/4C+Szsx9K4w4gVY+NvB31h6wYwWxkNMCh6e8V
         BwKxWedxse7xRuhqPG6slJe61+vSZQ4q17KyGDPWrI06lMHplzXkBNBTgZMO64oq9IjH
         joHDvsJ4pvTYNF/3FSdJj31VlI/RbCwmIQCKNrC+pVduv2dn96TvO4+eSiFHV4ts3D43
         EhpreGNfEKpxDDbz9pU4K55GMVxITC7Z25xA9EOY7tnMlQTVB3zpBNyX6wIycpbpoINI
         qGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775081434; x=1775686234;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGn8ZfejuIHQEAr3dSJQgxj1UyGWLDa21lXVxlUAKPg=;
        b=d96zyyi4eD9/ibjr2Tbv73NZ7T/TufWBDFDdL06LgjTzxhS/e8Hu3p1p/NLyiWa+ax
         aVQPw25e1Z2c2+VMXZL5o1X5AcdMCwozVEKCXT2OsONPwboN7WVtli/fXjatG/A/ZczE
         cK1Nug5pPOdgZwotxAy20w4PUh3qERH07rhlXdjP6kSi/FIEsRuVYGB4ilJDrYS3130j
         4sIvgfWpzmacqcmVKJXEUoddR156xPCZxEs8Wga4E1RXZ40jq7Smw1dd/o13xgnOo2/E
         h1gz7IEaxm0YP/nvKotlvDCVw38LgkdotQ7CMx4DwqzSfdB7u8KevMMUNreRrpCZ8NzX
         u/8g==
X-Gm-Message-State: AOJu0YzlLOPKaxMDaZ9OSW9DjjPArwFWh2uoTKs7RacjD9Zg19qOI9vh
	CmIW5G/ZCMsY6H4+11RIf3ldJQrN46VcNSMixHpKBX1M8wBk3nTCGF5U6Ujn0rF0igw=
X-Gm-Gg: ATEYQzxkGFGqUhWZU+tGWo87e0zQTd7g5bnQieOui2b15Uvpx86YdNbKfekAebQqKvJ
	WRr1add8o+tNb/kYU9q2yP5MmZQZMyksz14NIA4Fudsjnz6t5eUNBmTK37HHNeuRNACpNGJzmsb
	sriezDZ1NWYyK/P9+ebwGY/J8kPUVO6TdQTmx9d+5s/RLwyjcycm3mryeSuvP3LIuHtJORePbKf
	I64uNEceMWwa81vCI3A56X0lgXbcgoisF4YC3XUodhy7oxEAjbVm09lq4cniNH/AkLAjOJR02ry
	0TZj3xK+eOInv3zaOB6ULdL+hfByhcZx2aX2K96kFBAmrs4/yZeecG8KmxdOxDmnlPBd1tyNgpi
	d5ZfpkEcfNFMH5dc7T7Hm9mXNsSdQJjbCyP3Vmdx5dodPWXBSuFvXSqgjP/oyZvECMw+AWbj0Hi
	kPWaEEufWAEY5IAUji6VXvPh3f4edUjg1n7ULdGMvzwAKFzuWToyg=
X-Received: by 2002:a05:600c:46ce:b0:487:1108:48bc with SMTP id 5b1f17b1804b1-4888b74c1f0mr16046915e9.17.1775081433564;
        Wed, 01 Apr 2026 15:10:33 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749a34a6sm7221725ad.60.2026.04.01.15.10.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 15:10:32 -0700 (PDT)
Message-ID: <d8344ab4-5d26-4cf9-86da-a28434cc9477@suse.com>
Date: Thu, 2 Apr 2026 08:40:26 +1030
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: fix double free in create_space_info() error
 path
To: Guangshuo Li <lgs201920130244@gmail.com>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, Jiasheng Jiang
 <jiashengjiangcool@gmail.com>, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260401105619.1506398-1-lgs201920130244@gmail.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
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
In-Reply-To: <20260401105619.1506398-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-232870-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,fb.com,suse.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:dkim,suse.com:email,suse.com:mid]
X-Rspamd-Queue-Id: 13825380E08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



在 2026/4/1 21:26, Guangshuo Li 写道:
> When kobject_init_and_add() fails, the call chain is:
> 
> create_space_info()
> -> btrfs_sysfs_add_space_info_type()
> -> kobject_init_and_add()
> -> failure
> -> kobject_put(&space_info->kobj)
> -> space_info_release()
> -> kfree(space_info)
> 
> Then control returns to create_space_info():
> 
> btrfs_sysfs_add_space_info_type() returns error
> -> goto out_free
> -> kfree(space_info)
> 
> This causes a double free.
> 
> Keep the direct kfree(space_info) for the earlier failure path, but
> after btrfs_sysfs_add_space_info_type() has called kobject_put(), let
> the kobject release callback handle the cleanup.
> 
> Fixes: a11224a016d6d ("btrfs: fix memory leaks in create_space_info() error paths")
> Cc: stable@vger.kernel.org
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
> v2:
>    - add the full failure path to the changelog
> 
>   fs/btrfs/space-info.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 3f08e450f796..d7176eb2fcbf 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -311,7 +311,7 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
>   
>   	ret = btrfs_sysfs_add_space_info_type(space_info);
>   	if (ret)
> -		goto out_free;
> +		return ret;
>   
>   	list_add(&space_info->list, &info->space_info);
>   	if (flags & BTRFS_BLOCK_GROUP_DATA)


