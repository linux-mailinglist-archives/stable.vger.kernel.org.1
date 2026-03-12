Return-Path: <stable+bounces-224776-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ESfL44HsmkCIAAAu9opvQ
	(envelope-from <stable+bounces-224776-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 01:23:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DC326B970
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 01:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 55A3B302490F
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 00:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289E632AADC;
	Thu, 12 Mar 2026 00:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fpq3h+sL"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEBD32861F
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 00:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773275017; cv=none; b=G0a6xKnxh2jNQDzu57jJ5PvoYdZvoF1PzanXJnUowRHvnSNV1LvG2n5u6Pbs0TWT36gWZzPaT8nb8LZqxYw2dMkAlqfdbH0mReTN8NMCgiScozDq0GabwPiPEGeT5491khA42CvWifMDP2XViTheQzuNimV4FIACtWURxm9vIxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773275017; c=relaxed/simple;
	bh=lIREHVsprLQv+sgvZvN0VmPTBmLtDoktLDJp29IoUnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MqWMpEBHhZ/UJWqBbpMqEw/g+DbxWW0XrA4CvVwm3UiCEf3sc3Bo4DO9e8XZ4QUSjPc0H/L+jVhNzQMc/XdT54tYtPZrQPzxATEWl7L9ulSluk4OMtC3Zqao/CCy7YX/ZbNnoDzZevz2m7a//gGAt18JEBF3L19iXCl8M2U5+XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fpq3h+sL; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso3529575e9.1
        for <stable@vger.kernel.org>; Wed, 11 Mar 2026 17:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773275015; x=1773879815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=v1jAmHuTmJRFGX94V+S2RHH1PydmtxgIsgp10o+ygDg=;
        b=fpq3h+sLg+PWdHvDG9isqzJowL0anZwTqVhLhmS5tfmexwB4z2SEJ3mWluz+pkfb/M
         7T7iJBZMizbfipvTCSZlN8L+8PaO5MPbuIZDhAHUYS+xYZH3e6FBxgPnFRig8sVqfXhy
         yzHNEf0u9TOSJYiknjaXkdC6kVjXtoEZ8ib3w7wx65+RSqH7NUYaVn90S8UtnrmbVwbI
         PnBGYVGy5I3HL3g6pGd+ihdmWghkE35lCH+WTVOxhisthK6vUZME7lETIO8rn9i8V+zC
         nfx9pR4bJpz1hrQpLg6G+sS5YPWlvKPdOLT/qIm8Lkicx1z6FugnZ361UgiTbXp2ACRj
         yCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773275015; x=1773879815;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1jAmHuTmJRFGX94V+S2RHH1PydmtxgIsgp10o+ygDg=;
        b=Dc8Ro2Iybj7/oMqFMcwWwmoHPAEU6H8i2vKxiFVnXjYgK9NvqyTa4f1IAdR74IwEvQ
         79Zkhhq/CnS4Mrz2aDQwqfj+LmCquiMxoMYyjHgIXY5kzphHL338XA4/A2X/E5SZVFjp
         ZEPH5YFSWz3HKIQt7J8ymmvTwSeUH2QatrbbAn13KsdRosW0R0nKzR7QGkHf3b2gOKwL
         rsap6y4i1EVfjMuwjuwMQOXy1E6B1G2foPy/TFniEPo6Zadw4OOV687xxSVc1CHeAI/U
         g6rLPTkqDTvcQemJnPEPj0YBvwJvTMnKpAf8C1CzT9m/bzaZZSMqH28uQq03RAPMxBUr
         uYsw==
X-Forwarded-Encrypted: i=1; AJvYcCX7CX3UZkSeDOwOxHIEt/Mv8QRdUIj0uuPOaMKuvaEoQg86X3Vjr5XQPiD103j0+ETLyqOtcFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtYijSAUnA1U2MWLhsZGiBOoYl5wFzWE2/deU2FA0KZ4ml1Z6N
	dWkDQH3oXzLJFjezaLyfaVdzbEvTta7bgIRUAec7JCzSgwBlf2zHwUd9O3c+MvyHzR4=
X-Gm-Gg: ATEYQzymO9W0H7NSGUeOi+vGO8jSXHOSWH/1brlncDgG6X67rWzrqLXocgaKPFAzevB
	4JfDZ7Yq5cmx2l1xIpfh8c2UYw5WeoWrojtUR3dmHFV+TMzwESS4r8v3FdRNV4nfxMIUxTWf5gO
	mC70xd43mhVbyzvH5evfnmGKuLo02gy80+ReWMAV/M153siSdgEVIbP/sIbzth681BvXk4YGJlj
	/1wNpeiqjjTWcXjZOgQm0H/ko/Xvf2vtbmgNwf8q8Mk3BVHJHmU+mDWWM/TVgGlqSKkO5OKqtUO
	rQF07jhtsrQXi1709+JxjT/Y2mHbbMtjxPooqGmeEwT2Ptp/u7flg+TaTIml9K/YlN5343CBij7
	/K8LVOMS8ofdOGpF5K8/FIEQaboUct5S8TieJO7M9suyqZX6+wRO5KcetxW/tlXj3elC4O/CHon
	Zmrao5T0AUYzGRAg/FkC4E5klcrJbBZ32K783fNKVeRFdUjhLkLRA=
X-Received: by 2002:a05:600c:314e:b0:485:3f65:94a1 with SMTP id 5b1f17b1804b1-4854b10a1ddmr80933685e9.18.1773275014806;
        Wed, 11 Mar 2026 17:23:34 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae34cc99sm35120315ad.54.2026.03.11.17.23.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 17:23:33 -0700 (PDT)
Message-ID: <17c102a6-bbd1-4937-b5cc-5f6912551180@suse.com>
Date: Thu, 12 Mar 2026 10:53:27 +1030
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: reject root items with drop_progress and zero
 drop_level
To: ZhengYuan Huang <gality369@gmail.com>, dsterba@suse.com, clm@fb.com
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, r33s3n6@gmail.com, zzzccc427@gmail.com,
 stable@vger.kernel.org
References: <20260312001443.3011961-1-gality369@gmail.com>
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
In-Reply-To: <20260312001443.3011961-1-gality369@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,suse.com,fb.com];
	TAGGED_FROM(0.00)[bounces-224776-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 64DC326B970
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



在 2026/3/12 10:44, ZhengYuan Huang 写道:
> [BUG]
> When recovering relocation at mount time, merge_reloc_root() and
> btrfs_drop_snapshot() both use BUG_ON(level == 0) to guard against
> an impossible state: a non-zero drop_progress combined with a zero
> drop_level in a root_item, which can be triggered:
> 
> ------------[ cut here ]------------
> kernel BUG at fs/btrfs/relocation.c:1545!
> Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
> CPU: 1 UID: 0 PID: 283 ... Tainted: 6.18.0+ #16 PREEMPT(voluntary)
> Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> Hardware name: QEMU Ubuntu 24.04 PC v2, BIOS 1.16.3-debian-1.16.3-2
> RIP: 0010:merge_reloc_root+0x1266/0x1650 fs/btrfs/relocation.c:1545
> Code: ffff0000 00004589 d7e9acfa ffffe8a1 79bafebe 02000000
> Call Trace:
>   merge_reloc_roots+0x295/0x890 fs/btrfs/relocation.c:1861
>   btrfs_recover_relocation+0xd6e/0x11d0 fs/btrfs/relocation.c:4195
>   btrfs_start_pre_rw_mount+0xa4d/0x1810 fs/btrfs/disk-io.c:3130
>   open_ctree+0x5824/0x5fe0 fs/btrfs/disk-io.c:3640
>   btrfs_fill_super fs/btrfs/super.c:987 [inline]
>   btrfs_get_tree_super fs/btrfs/super.c:1951 [inline]
>   btrfs_get_tree_subvol fs/btrfs/super.c:2094 [inline]
>   btrfs_get_tree+0x111c/0x2190 fs/btrfs/super.c:2128
>   vfs_get_tree+0x9a/0x370 fs/super.c:1758
>   fc_mount fs/namespace.c:1199 [inline]
>   do_new_mount_fc fs/namespace.c:3642 [inline]
>   do_new_mount fs/namespace.c:3718 [inline]
>   path_mount+0x5b8/0x1ea0 fs/namespace.c:4028
>   do_mount fs/namespace.c:4041 [inline]
>   __do_sys_mount fs/namespace.c:4229 [inline]
>   __se_sys_mount fs/namespace.c:4206 [inline]
>   __x64_sys_mount+0x282/0x320 fs/namespace.c:4206
>   ...
> RIP: 0033:0x7f969c9a8fde
> Code: 0f1f4000 48c7c2b0 fffffff7 d8648902 b8ffffff ffc3660f
> ---[ end trace 0000000000000000 ]---
> 
> [CAUSE]
> A non-zero drop_progress.objectid means an interrupted
> btrfs_drop_snapshot() left a resume point on disk, and in that case
> drop_level must be greater than 0 because the checkpoint is only
> saved at internal node levels.
> 
> Although this invariant is enforced when the kernel writes the root
> item, it is not validated when the root item is read back from disk.
> That allows on-disk corruption to provide an invalid state with
> drop_progress.objectid != 0 and drop_level == 0.
> 
> When relocation recovery later processes such a root item,
> merge_reloc_root() reads drop_level and hits BUG_ON(level == 0). The
> same invalid metadata can also trigger the corresponding BUG_ON() in
> btrfs_drop_snapshot().
> 
> [FIX]
> Fix this by validating the root_item invariant in tree-checker when
> reading root items from disk: if drop_progress.objectid is non-zero,
> drop_level must also be non-zero. Reject such malformed metadata with
> -EUCLEAN before it reaches merge_reloc_root() or btrfs_drop_snapshot()
> and triggers the BUG_ON.
> 
> The bug is reproducible on 7.0.0-rc2-next-20260310 with our dynamic
> metadata fuzzing tool that corrupts btrfs metadata at runtime.

I'll move this part into the BUG section as it's about how the bug is 
triggered.

> After
> the fix, the same corruption is correctly rejected by tree-checker
> and the BUG_ON is no longer triggered.
> 
> Fixes: 259ee7754b67 ("btrfs: tree-checker: Add ROOT_ITEM check")

Again, it's not a bug fix. You're just adding a new check.

This fixes tag should only go with the error message fix.

You don't need to send a new update, I'll do all the update at merge time.

Otherwise looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> Cc: stable@vger.kernel.org # 5.3+
> Signed-off-by: ZhengYuan Huang <gality369@gmail.com>
> ---
> [CHANGELOG]
> v2:
> - Split out the error message fix from the previous patch, as requested
>    during review.
> ---
>   fs/btrfs/tree-checker.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index dd274f67ad7f..1e052c3303b3 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -1260,6 +1260,23 @@ static int check_root_item(struct extent_buffer *leaf, struct btrfs_key *key,
>   			    btrfs_root_drop_level(&ri), BTRFS_MAX_LEVEL - 1);
>   		return -EUCLEAN;
>   	}
> +	/*
> +	 * If drop_progress.objectid is non-zero, a btrfs_drop_snapshot() was
> +	 * interrupted and the resume point was recorded in drop_progress and
> +	 * drop_level.  In that case drop_level must be >= 1: level 0 is the
> +	 * leaf level and drop_snapshot never saves a checkpoint there (it
> +	 * only records checkpoints at internal node levels in DROP_REFERENCE
> +	 * stage).  A zero drop_level combined with a non-zero drop_progress
> +	 * objectid indicates on-disk corruption and would cause a BUG_ON in
> +	 * merge_reloc_root() and btrfs_drop_snapshot() at mount time.
> +	 */
> +	if (unlikely(btrfs_disk_key_objectid(&ri.drop_progress) != 0 &&
> +		     btrfs_root_drop_level(&ri) == 0)) {
> +		generic_err(leaf, slot,
> +			    "invalid root drop_level 0 with non-zero drop_progress objectid %llu",
> +			    btrfs_disk_key_objectid(&ri.drop_progress));
> +		return -EUCLEAN;
> +	}
>   
>   	/* Flags check */
>   	if (unlikely(btrfs_root_flags(&ri) & ~valid_root_flags)) {


