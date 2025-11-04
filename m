Return-Path: <stable+bounces-192445-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD29C32EC6
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 21:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD6CC4EC9B9
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 20:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7792F6572;
	Tue,  4 Nov 2025 20:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aasyrEeM"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984472ED165
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 20:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762288482; cv=none; b=D0uR+gZPhNODCaottYU9SK8/tzybxpa0VIjdZ1f7aCIxYiSRBHECTP7a/HQREgdic/bHpu3jbPgrxdGnHf9TyV/MUA8lYVanoLkrvGwDKWzHluMIMUXAR2AZMH+OPbxjlZxwBIRtf+qHvSucOc+AjbPdkUd9f0OI7TwfDFSQBis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762288482; c=relaxed/simple;
	bh=pcqbzs87TVZHGwd0PFnmjPS0uPadDYSXPyKwjnuXgBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iiw7N9e+BGjP3eTFFu6jzk+iepSTsvNqRjbrmgRGItLqdYhtkYfkR4S1CgsYMoQY4GAdvjfhFYWBrLk/eo1LoQmabNioY8Gf33I+oW/S1XO5jz7nwg/vgOAo1a5e9PYbR7HOX4boNLebOLY/VVQST2Z+43xwJ870SeR6ikr4xjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aasyrEeM; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-429b7ba208eso3733973f8f.1
        for <stable@vger.kernel.org>; Tue, 04 Nov 2025 12:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762288477; x=1762893277; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ElfU6/I0L9mmjF7bkTwgY90FbMhY7drclQ1JLKFiKW4=;
        b=aasyrEeMPaUORie+gF/MXEFkE5m2ZAXfyqKNV5WBRLupbMn99dJ9Y3mwOSBR+dsFpE
         RSdt81JlofYM2dx7kvP2svb9n6Oyppq4olWYfAlQeVkajQazr14fP9KRpZmeSJddIk/F
         s/ojyxOFrqN2wg0MUacWa+9netAwIoaVPUlwDLpkRa5o91usB0dWMH15P6sUezNs3Tl4
         brgT8bZYvPgEZ9OspZVwWNX9seVd5+33VeCijT/+LH+xlJio3WJY5aJowzYrhSmVf6U1
         tT8MNuuVtPOtYV3vs2dpFOYlFW18aBcrBEfVkXgv4imLZV+X+LZosGM0B5IpV3x/kQRz
         ZTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762288477; x=1762893277;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ElfU6/I0L9mmjF7bkTwgY90FbMhY7drclQ1JLKFiKW4=;
        b=QiLfWmL6mpqAiVJESwc4Xn3/J0w81rAv6GQVyQd1v0Ot0G9JEpG8t71Xli+07Bbi/x
         +gRqMdr0YphBTzcxZLBrBSBok7mnAUiwxj7/CLJri6mlfu+h6N/UdX9BDyyCuIY/wi06
         6fz6LSg+Kf3pIV82CUrmY7qQHsgX3qlilEc/kUVGMo+nuSJflWoMSRgIFm+/YV94rqw7
         IwMDPo4H5iRA1u2HFg46EJPns4y86zA+dN7v5U02kK+KJXT9Cix5LumHxjbp/9a3unX9
         U+4T4+nNUvp5MYj1TpXKa/sIfGQaa5aYrYob5oqQLtqG7MMpUAWzapTpK7cOeYCbFzso
         GKNA==
X-Forwarded-Encrypted: i=1; AJvYcCWAZVin8mLR/uY08HBhEezjJCt0dNEpP5d4/53Qr1uoCNRWlAQzjpNkEy3e2QL0aG7v6mlLwh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnTIM+KFZNcZW9j+kggFWQNup8v1bVWIEPJoechIqYoLAUSvYX
	7OpHRtc7srcAbb7xOe/GuFIeRLfndGDxNmNtFw7/KF+aXgC4X4eevxT6g/XkRMOn6is=
X-Gm-Gg: ASbGnctzPskhBAHYxQtSJjUd755PADzA/7S2ElZ5xLxLCFcqV2Lmewf8McIF/6722NE
	pzeIWKEQFagPFoE/Q8B40LUF9SBRifnh6GHDeUsTV0TJKH7O/EA+RfS0CSJCtjc5k71us+ZQAds
	YnLuVNG+puVCcVJVT+igtkJ6Xxf/S7VtPvTpahYwuG58YcjjprHN8BWt4YHhUojv8TY9rn/GT6X
	YzpwjUvAnDEprO9pHXNQdLGp+kEiAUKHrjgjraAaQxN3jQyX5BH/AZD3ld3lBbklVcAxsyYuaY5
	lx1TDBhOeVjNvp6E2vIeeTks7lX5CNZFHe/4Si1r09MZzalV0e/Ye1825q8oLEdJLz0pr0pFbWE
	4FJ4VkHO0F7l0grtYHRQ95w5+OqAp3W8p8HR9TZmeUTEM6LDtOj5UkRLOlessYhnrxKczXsuR2c
	YZUQSbBF5skI4tl+Lxt6J5IDHLAbiM
X-Google-Smtp-Source: AGHT+IExUHtfVKDjgXTSPNckPXQhySLpTav0VeGsiTnCNS2KyTCAao18XUn6RYqTto5ou7sSH4icmg==
X-Received: by 2002:a05:6000:2887:b0:429:d528:649f with SMTP id ffacd0b85a97d-429e32c8378mr576294f8f.2.1762288476768;
        Tue, 04 Nov 2025 12:34:36 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::e9d? (2403-580d-fda1--e9d.ip6.aussiebb.net. [2403:580d:fda1::e9d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601976196sm36462045ad.22.2025.11.04.12.34.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 12:34:36 -0800 (PST)
Message-ID: <9ef50974-62a5-4b22-959f-c3be7abfc4ae@suse.com>
Date: Wed, 5 Nov 2025 07:04:31 +1030
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix NULL pointer dereference in
 backup_super_roots()
To: Zhen Ni <zhen.ni@easystack.cn>, clm@fb.com, dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org, stable@vger.kernel.org
References: <20251104081416.759194-1-zhen.ni@easystack.cn>
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
In-Reply-To: <20251104081416.759194-1-zhen.ni@easystack.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/4 18:44, Zhen Ni 写道:
> backup_super_roots() unconditionally dereferences extent_root and
> csum_root pointers obtained from btrfs_extent_root() and
> btrfs_csum_root() respectively. These functions can return NULL when the
> corresponding filesystem trees are unavailable due to corruption or
> other error conditions. This causes a kernel panic.

Explain why backup_super_roots() is called on those situations.

Remember csum/extent trees can only be NULL if corresponding rescue 
mount options are used, which requires the full fs to be RO (and no log 
replay is allowed either).

If you hit it in the real world, please give the call trace.

Otherwise give a deeper dig first.
> 
> Add proper NULL checking and skip the backup operations for the
> unavailable roots.
> 
> Fixes: 29cbcf401793 ("btrfs: stop accessing ->extent_root directly")
> Fixes: f7238e509404 ("btrfs: add support for multiple global roots")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
> ---
>   fs/btrfs/disk-io.c | 28 ++++++++++++++++------------
>   1 file changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 0aa7e5d1b05f..b54c79a1db14 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1670,18 +1670,22 @@ static void backup_super_roots(struct btrfs_fs_info *info)
>   		struct btrfs_root *extent_root = btrfs_extent_root(info, 0);
>   		struct btrfs_root *csum_root = btrfs_csum_root(info, 0);
>   
> -		btrfs_set_backup_extent_root(root_backup,
> -					     extent_root->node->start);
> -		btrfs_set_backup_extent_root_gen(root_backup,
> -				btrfs_header_generation(extent_root->node));
> -		btrfs_set_backup_extent_root_level(root_backup,
> -					btrfs_header_level(extent_root->node));
> -
> -		btrfs_set_backup_csum_root(root_backup, csum_root->node->start);
> -		btrfs_set_backup_csum_root_gen(root_backup,
> -					       btrfs_header_generation(csum_root->node));
> -		btrfs_set_backup_csum_root_level(root_backup,
> -						 btrfs_header_level(csum_root->node));
> +		if (unlikely(!extent_root || !csum_root)) {
> +			btrfs_warn(info, "failed to get extent or csum root for backup");
> +		} else {
> +			btrfs_set_backup_extent_root(root_backup,
> +						     extent_root->node->start);
> +			btrfs_set_backup_extent_root_gen(root_backup,
> +					btrfs_header_generation(extent_root->node));
> +			btrfs_set_backup_extent_root_level(root_backup,
> +						btrfs_header_level(extent_root->node));
> +
> +			btrfs_set_backup_csum_root(root_backup, csum_root->node->start);
> +			btrfs_set_backup_csum_root_gen(root_backup,
> +						       btrfs_header_generation(csum_root->node));
> +			btrfs_set_backup_csum_root_level(root_backup,
> +							 btrfs_header_level(csum_root->node));
> +		}
>   	}
>   
>   	/*


