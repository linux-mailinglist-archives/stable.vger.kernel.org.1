Return-Path: <stable+bounces-225219-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEwmIUsws2ntSwAAu9opvQ
	(envelope-from <stable+bounces-225219-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 22:29:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E74BC27A021
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 22:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF6DF3057E94
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C2F3D090F;
	Thu, 12 Mar 2026 21:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WHcjPxi1"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D6B3A5E80
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 21:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773350970; cv=none; b=JtljszZner0ajJ0mFYEEvCx7UOjtKQ3Hv+0jGOwS25qrYA45WxtHGxZpY3RmwvGxetQ3h6NBfDOVIEOjTNYumwRbS3x9BnWDUIf/BUPt2bhzca3ZXnDFXWjMWwVWgQazCO/ArhrQm6ZP7FdAcdVlnbgaP25IyRe/zpZWyjYCOE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773350970; c=relaxed/simple;
	bh=1mrcok7lLWw3BKqb6jcTbX/ttIp2UVoNTzWkQHr3+jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=If+OLI/myg0KYcOr3hZE1136g1ZEl/9SYvrf0l8bO8uhvOhfIkJxvuhl9dgpxLajzwHUt9r+3YJnVMfsMwUx6AIkc7yst45WW9bDaI8LwUtbKjcg4gkLcfvmrH4wr0ZH7bwlc5l4fZUv9rdE0+H6mHE7koWHMUe4wixJ+Oi3/Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WHcjPxi1; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48539cbb7b1so8474235e9.3
        for <stable@vger.kernel.org>; Thu, 12 Mar 2026 14:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773350968; x=1773955768; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rYZIRyMjn1f9/0KoletAcCwq5B4EGUP8BoRgBSg1lAA=;
        b=WHcjPxi16t9sVdwFUWVi+CSwrCUIj8c90OM29MsaO450NeZzoMCbpcMh6d0XKQwRJG
         HJ5j2KP4I2SIT2YAZhNHNIWQ+y3QSuvahn6jbgIe8EIHtp4Lx4OlIx58R+NFlcb69xFU
         9oOo5anZNN96uG5FM4FqtnZXf7qsblLLU78QwNXElBN/+jY5Lnd3xxsesbHlK5g0sa7I
         oDsVa8ucrx3GZopdeODM5U+swmzeSkuGpPYoKs6xr+Fkg7uDtsFVUcbrJvpenX2vXw/S
         G9JsYKuhMq3KYu++YQv37TEacpU/xUjcMRbMzTyAgFbEmpE37Gmb3V4/H8aAUV3mYehW
         QeNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773350968; x=1773955768;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rYZIRyMjn1f9/0KoletAcCwq5B4EGUP8BoRgBSg1lAA=;
        b=VxJG9Vb6Sns7JUvhJKO84hqW3KSECsnYJk3992kppLC5RBJU98cDwsN2Qz17GkcVr7
         +7xEoedYo6OtyG/hUrU54F6r4gzutk64Ua3aSgqgxwTfjkaCQuR2CN2J+oHZrcoo5J2o
         Efp5AcPnWWWR7quURoXCS4Po5ML7FTXsf39fqBkM2kp2JLsozgpkdSpt5Wpu18KD6vht
         Ag4bqZz6M4jnb7OrfVb0VoosXQvwWRwuzBZXNzq94gz5FmsD0Ay9ZY6sn2j1A6Ra087B
         wYB2lD5Sl3GyMgY+IUPIlPPjBGLzu5sYjKg9nzbpuI8I95/n1wlId8lULQoPneg3/Ob/
         c37w==
X-Forwarded-Encrypted: i=1; AJvYcCUAj7J2BZE4Droiv4sl0VLAS6yoskRR8XHEmbf0KJDbw653h+tl/7mASTvV+pdQK+/g9XyfKIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx10KtHNeoteQkKBE5X4U50nwd2exj6gIbPEEAH/6H44JdCNbZa
	vrdMv0wSZ0lo5HXMOQXgqYVe4Wtfo4jblLOo1qCuwEskhgSc0EF8gOyg3oFiji8zFSA=
X-Gm-Gg: ATEYQzxqkUXMi++dLbAJk9goVim3Icn6ih87GsCgUUHZ9A9DBnphzuArIaIvzFl1/ia
	YOPFekd+E/zXvrTA/TbqLHMqRBCdCpTn8LsMkGb+f3Bg3f9l0IvIk3/KpJkO0dXNvZebnXafgBD
	k6sZGAYlxILT9YFqaofW3NTcP5UCzncqhd+dbo1wFrCpxM9CSTefN3hv9mHHqpBovpMRvHZG3Ml
	Dl3t+IFe91WtY/jYIMCrNK6PA3GiZiRW3xCSfg2fjVLea5B7IpHU6ljI7bua4IyYpR5nYo8PPqo
	PRok4YZQyGmWJ4fG6yq4oBkAgNS4WTFujReXFgxS3EEKhIVhrdUP1ErIaicLVpxdrTQYcshdHwW
	D7aq36kvp0ApJflJIM4gs6xhW35LnB2O3L3tjS49lt+3PhgbOVohBXFoOk8atLLb+yDe2i5uF5y
	XOZouI8MM1hkeli2Yr1IiQv2qYe4AVrViLjk2mDTeLh+6iX/+plL0=
X-Received: by 2002:a05:600c:1d0e:b0:471:700:f281 with SMTP id 5b1f17b1804b1-4855671fac1mr14558705e9.25.1773350967783;
        Thu, 12 Mar 2026 14:29:27 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae378249sm65253025ad.80.2026.03.12.14.29.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 14:29:26 -0700 (PDT)
Message-ID: <ac5058d0-ba4e-4de6-b231-64a29ee2d5e3@suse.com>
Date: Fri, 13 Mar 2026 07:59:14 +1030
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: reject root with mismatched level between
 root_item and node header
To: ZhengYuan Huang <gality369@gmail.com>, dsterba@suse.com, clm@fb.com
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, r33s3n6@gmail.com, zzzccc427@gmail.com,
 stable@vger.kernel.org
References: <20260312102229.220570-1-gality369@gmail.com>
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
In-Reply-To: <20260312102229.220570-1-gality369@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,suse.com,fb.com];
	TAGGED_FROM(0.00)[bounces-225219-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E74BC27A021
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



在 2026/3/12 20:52, ZhengYuan Huang 写道:
[...]
> 
> [FIX]
> Catch the inconsistency in read_tree_root_path(), right after read_tree_block()
> returns root->node and the generation and owner checks have passed. At that
> point level = btrfs_root_level(&root->root_item) is already known, so
> comparing it against btrfs_header_level(root->node) costs nothing. If they
> differ, emit a btrfs_crit() message and return -EUCLEAN to prevent the
> inconsistent btrfs_root object from being installed in the radix-tree cache
> and reaching any caller. read_tree_root_path() is the only place that sees
> both root_item.level and the actual root node simultaneously, making it the
> correct and minimal location for this cross-block consistency check.
> Returning -EUCLEAN is consistent with the existing owner-mismatch check
> directly above and with the general btrfs policy of converting detectable
> corruption into -EUCLEAN rather than crashing later.
> 
> After the fix, btrfs detects the level mismatch at root load time and
> fails with -EUCLEAN instead of crashing later in
> handle_indirect_tree_backref().
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: ZhengYuan Huang <gality369@gmail.com>
> ---
>   fs/btrfs/disk-io.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 900e462d8ea1..06a8689cbf62 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1067,6 +1067,26 @@ static struct btrfs_root *read_tree_root_path(struct btrfs_root *tree_root,
>   		ret = -EUCLEAN;
>   		goto fail;
>   	}
> +	/*
> +	 * Verify that the root node's on-disk level matches root_item.level.
> +	 * These can diverge when the root item in the root tree was corrupted
> +	 * (e.g. a bit flip changing level) while the actual tree block is
> +	 * already cached in memory at its real level. In that case
> +	 * read_tree_block() returns the cached buffer without re-running
> +	 * btrfs_validate_extent_buffer(), silently bypassing the level check.
> +	 * The mismatch would later cause a null-ptr-deref in backref walking
> +	 * (handle_indirect_tree_backref) when the commit root's real height is
> +	 * lower than what root_item.level claims.
> +	 */
> +	if (unlikely(btrfs_header_level(root->node) != level)) {

Nope, we have btrfs_tree_parent_check structure, which has all the 
needed checks at read time.

The point of using that other than doing it manually here is, if one 
mirror is bad, but the other mirror is good, then we can still grab the 
good copy, but checking it here means if we got the bad mirror first, we 
have no more chance.

And during read of root-node, we have already passed the proper level 
into it.

So the only possibility is, your fuzzing tool is modifying the memory 
after the read check.

If so, it's impossible to fix.

> +		btrfs_crit(fs_info,
> +           "root=%llu block=%llu, root item level mismatch: "
> +           "root_item.level=%d block.level=%u",
> +           btrfs_root_id(root), root->node->start,
> +           level, btrfs_header_level(root->node));
> +		ret = -EUCLEAN;
> +		goto fail;
> +	}
>   	root->commit_root = btrfs_root_node(root);
>   	return root;
>   fail:


