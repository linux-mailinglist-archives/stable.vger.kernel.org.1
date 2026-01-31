Return-Path: <stable+bounces-212962-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIasM2pvfmnEYwIAu9opvQ
	(envelope-from <stable+bounces-212962-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 22:08:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F259C3F0A
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 22:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E508301753C
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 21:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC1C3783D8;
	Sat, 31 Jan 2026 21:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KiARXdBh"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B57364059
	for <stable@vger.kernel.org>; Sat, 31 Jan 2026 21:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769893735; cv=none; b=uQO46UC9L/HfXJWGdogRLceixjFHlJNQF9khuPSWcIYhKAaXlbQBDrkIKRESLnP7nHhctkb5vViJr8JVHmP7OyDcg21rIKq/EPVQu9NQ22mk1px594NV3JdKnAXAej/O+KNs9JVmrZiqSPhTJNlt6lYHWsWGuzb9uzFoSt2hoZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769893735; c=relaxed/simple;
	bh=PJlaNBhMeVenCU4MSJ2L/KqPTZVKtN/IJ0GwWQ46OsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QWrVkuu8sBmY5XfhB9t7GmDzqosGXGEIt9cNd8JY13B/IqX4GQXsdSsaXHsveKCtt7flGOt+ISGObKBDb91NDsNrtZ98faz1vavy8EZAEf0e0684AAMMTcpNz9PGAM64RYsAVD6NTnTcON5JAD/xa8/d0qnLBaTVg5ROi8JVlmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KiARXdBh; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4806f80cac9so17770615e9.1
        for <stable@vger.kernel.org>; Sat, 31 Jan 2026 13:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769893732; x=1770498532; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MCj7RuBeccCkx+qPH+2oe1q+IyLUX5ND6U/pICPBbzA=;
        b=KiARXdBh6sU8QkLrHfJP3Wx9YwXEni5hDXZgAX2SWMs76pMwmufKULo8dWy6fqg0eR
         jE+6b6YFmOHWQzyBgilrcP6n07Mu3CuwhPPNhVzX1ADG+Jczc9xnKG3pvfwtUCOgYuRO
         T0NAH6gBpLg1zcohVN0E436IjhEJDf2PbnmxGQyqc45V4mZzOHhjegFNL59br4uZL0aq
         KxuwB7yc2dThoovj9I08lpijqnKk+ENDUX7QPVY7ddtzVVO1m4u4fT7U6Em/Y0G/F8SQ
         r0S8mwIAnne1TR+AFLgPgxwE6C2Z6WfazZ2Yj1jzT5NUXobRPMDnmCz9Nz+BufNbZv3p
         DtUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769893732; x=1770498532;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCj7RuBeccCkx+qPH+2oe1q+IyLUX5ND6U/pICPBbzA=;
        b=eXZ0oWI+LlxOcYHSPflb3ppPLVwEPT3gy1T3LXRphI0Ft0AMl6nuV27N2T2AzyH3BJ
         b3osOuqWH/7R05NCsQXc9Mx5CELiuxNNtcNUUtv0IBVlpGYCM6z/zwTmfgbiGhCCLv+l
         OI0vPFVIV0rWlafCBRRu0zr/W5lIcvmX03RWtnO4soxS6pf/h087W7fwyHpNPRaxAr6n
         HU+BrYh+Iu9Aiw9pWRz91I1t7jLqGm5hhMmknm19ch4cy98kO4XomPR7/rcN628fblAM
         YU+sym2QYK3tDN2bBM57Zc1zZpRXB/06Y60T/PDl/i00J6XY39bSLyWorXMZZMZ46ZP4
         qf0g==
X-Forwarded-Encrypted: i=1; AJvYcCUj3qzOMsVMvxSSKTixtyv9jsb6WfZ7uVujWM8HwJxiZYNzDkZmcdpeZubyZdBuznLA4Rt9o8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YztUVvFEIzqNNStDM1ZTDqP+Il6wJWmDXMcaIgZDPOv018JPxYh
	A5v6kGEk+B+Qv7fxpgGiw+lk71O2z292/Ib6Djij19L4LM1TEWrmbJzPH2t3mjnln+E=
X-Gm-Gg: AZuq6aIG2Gd9sDDVGshr/YvsZNbcMgJetrJllCcaMM9VUTo6tI3OhiDGPyHTkS4od5n
	B6MFKl7lgxMdA2wg2+dCs+QYZmIDZ5taAlP8PyBW2GJRm9HJUazMvNSvlfWup9ZlwcHxNbd++8k
	p6pDKtuXNbsPkaiOyOc12aNYGm1DR5tm3Dk1CrEfiB3t0uH3Mi1X46amtP0PUlcAgxWrPvOqjGX
	bBjPWxHkyVsPyXKkBo9q2zzFC+3k1Xt/0Fzb2OmXEUrRP529EhAgyLw/T35EgXTvOfOo4BwqZD5
	XlLlKSL42SBRnJyySTR6DghaTAkUmgWKuRuoXv4TAKZ1eRiKtrVx+5ttFjj+5E7PbBXOrqF+JZA
	fX0j2JzvIcewvJHdn/slx2JZc+Rv/5lJ90+cpcj+NNiSR8y2Uoa2KJpSzt2I38Rz/Gpu6GgcCb/
	fY6bIcSAtN6xUHEXqDuF7/zNrmNBZOja7D1RyryY0=
X-Received: by 2002:a05:600c:3b23:b0:47a:8cce:2940 with SMTP id 5b1f17b1804b1-482db49ff27mr87125175e9.14.1769893731775;
        Sat, 31 Jan 2026 13:08:51 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379bfcab8sm10656042b3a.36.2026.01.31.13.08.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jan 2026 13:08:51 -0800 (PST)
Message-ID: <4c37d4e1-e656-48e3-ac80-83c09fe92625@suse.com>
Date: Sun, 1 Feb 2026 07:38:44 +1030
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12] btrfs: prevent use-after-free
 prealloc_file_extent_cluster()
To: JP Kobryn <inwardvessel@gmail.com>, boris@bur.io, clm@fb.com,
 dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20260131185335.72204-1-inwardvessel@gmail.com>
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
In-Reply-To: <20260131185335.72204-1-inwardvessel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-212962-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,bur.io,fb.com,suse.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Queue-Id: 3F259C3F0A
X-Rspamd-Action: no action



在 2026/2/1 05:23, JP Kobryn 写道:
> Users of filemap_lock_folio() need to guard against the situation where
> release_folio() has been invoked during reclaim but the folio was
> ultimately not removed from the page cache. This patch covers one location
> that was overlooked. Affected code has changed as of 6.17, so this patch is
> only targeting stable trees prior.
> 
> After acquiring the folio, use set_folio_extent_mapped() to ensure the
> folio private state is valid. This is especially important in the subpage
> case, where the private field is an allocated struct containing bitmap and
> lock data.
> 
> Without this protection, the race below is possible:
> 
> [mm] page cache reclaim path        [fs] relocation in subpage mode
> shrink_folio_list()
>    folio_trylock() /* lock acquired */
>    filemap_release_folio()
>      mapping->a_ops->release_folio()
>        btrfs_release_folio()
>          __btrfs_release_folio()
>            clear_folio_extent_mapped()
>              btrfs_detach_folio_state()
>                bfs = folio_detach_private(folio)
>                btrfs_free_folio_state(folio)
>                  kfree(bfs) /* point A */
> 
>                                     prealloc_file_extent_cluster()
>                                       filemap_lock_folio()
>                                         folio_try_get() /* inc refcount */
>                                         folio_lock() /* wait for lock */
> 
>    if (...)
>      ...
>    else if (!mapping || !__remove_mapping(..))
>      /*
>       * __remove_mapping() returns zero when
>       * folio_ref_freeze(folio, refcount) fails /* point B */
>       */
>      goto keep_locked /* folio remains in cache */
> 
> keep_locked:
>    folio_unlock(folio) /* lock released */
> 
>                                     /* lock acquired */
>                                     btrfs_subpage_clear_updodate()
>                                       bfs = folio->priv /* use-after-free */

This patch itself and the root cause look good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

> 
> This patch is intended as a minimal fix for backporting to affected
> kernels. As of 6.17, a commit [0] replaced the vulnerable
> filemap_lock_folio() + btrfs_subpage_clear_uptodate() sequence with
> filemap_invalidate_inode() avoiding the race entirely. That commit was part
> of a series with a different goal of preparing for large folio support so
> backporting may not be straight forward.

However I'm not sure if stable tree even accepts non-upstreamed patches.

Thus the stable maintainer may ask you the same question as I did 
before, why not backport the upstream commit 4e346baee95f?

If it's lacking the reason why it's a bug fix, I believe you can modify 
the commit message to include the analyze and the fixes tag.


I'm also curious to learn the proper way for such situation.

Thanks,
Qu

> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> Fixes: 9d9ea1e68a05 ("btrfs: subpage: fix relocation potentially overwriting last page data")
> 
> [0] 4e346baee95f ("btrfs: reloc: unconditionally invalidate the page cache for each cluster")
> ---
>   fs/btrfs/relocation.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 0d5a3846811a..040e8f28b200 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -2811,6 +2811,20 @@ static noinline_for_stack int prealloc_file_extent_cluster(struct reloc_control
>   		 * will re-read the whole page anyway.
>   		 */
>   		if (!IS_ERR(folio)) {
> +			/*
> +			 * release_folio() could have cleared the folio private data
> +			 * while we were not holding the lock.
> +			 * Reset the mapping if needed so subpage operations can access
> +			 * a valid private folio state.
> +			 */
> +			ret = set_folio_extent_mapped(folio);
> +			if (ret) {
> +				folio_unlock(folio);
> +				folio_put(folio);
> +
> +				return ret;
> +			}
> +
>   			btrfs_subpage_clear_uptodate(fs_info, folio, i_size,
>   					round_up(i_size, PAGE_SIZE) - i_size);
>   			folio_unlock(folio);


