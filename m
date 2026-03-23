Return-Path: <stable+bounces-227889-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMOzOMrewGn6NQQAu9opvQ
	(envelope-from <stable+bounces-227889-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 07:33:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2815F2ED1B3
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 07:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0DE213004CBD
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 06:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31073191BB;
	Mon, 23 Mar 2026 06:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CZh92Vqp"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508172FD7BE
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 06:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774247613; cv=none; b=GPlyJnVXz6cs0IX4DsHRr3Q5N0Z+KGAgVjQ2MIBElrzgB9vOpajwmEgEZMdPQM8Q4/R9EpX+wuoTPuCyUeJCHNq6MNfC/JK0UcijGcMrBQMuwwyTjj1vGsp4is0RPSgzVRjs2TPf+3KGuyhP6MRUKDqvCFwBRPX8jlAa4QiMr3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774247613; c=relaxed/simple;
	bh=TEU6DYkEQGRfvG4wSTCS9MsLZyPrDr/7yC/Q1P9jTVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AO6R7Z5rZ6zkich9+W+96uD5TOWb7C8aioB4yxwL9KUEReGp8cucG8BxAtZRsCu/VBCoiRm3T+mpi0T4Ids+I7gem3sfA1jJkG+p+7iyCwLp7h1yl2P+B2XZh+bQ/J3gWqSbgENa1B+2NXVIR/4ZHCC6+Upeu2CatipaN0Gi/2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CZh92Vqp; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48540d21f7dso28551185e9.0
        for <stable@vger.kernel.org>; Sun, 22 Mar 2026 23:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774247610; x=1774852410; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YGTwgK5nYvcCyOG242Pe97TZCZ73pNnFR7VrLz4Ca/Y=;
        b=CZh92Vqp71WT3svFN9TqQvz7NXrKGXJRRZSmU5xc3AZnwKVojxFqG5JRr9HODAvDBk
         Lk8Up1C3KQSF0Na/1GPWHhwIgeSRgDJB4Dex6i6hvHyNSu576AhrrltgIhb7K5hqIOgU
         zHGu9Liti7eg75xGEAB9ziENXA2iwCJJDTKfZNmSkto0T8Wbt+EmEodNGu3iqax3C/HS
         GOi0ak69EVPGLB4Odes5q0uetAnWPbcY/+M7AIiVyRGPr6Zm8jeEWsl4DTOYV3hfHxAA
         zXm/dN3GydoSgqEjqEHPsR6Pg4cY27rnnVpFncglC9orYo0ALW/bjluOdR3fLX9GVnP4
         /1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774247610; x=1774852410;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGTwgK5nYvcCyOG242Pe97TZCZ73pNnFR7VrLz4Ca/Y=;
        b=GYaIxHYE/Myu2qlkrlFW8nMSVxUkGZ5r8f61wUhpb+8MzHbYcMvtb70+nx16g873rO
         8vZBZE55s9I0NEpCTznDht0tQqdDfrajJXPeMelJRU4hNomHXku09teXyRrbVSs9XzIZ
         oeDaC83iSqcoXnFQuSlpcRMPJrRhG92m/knH+JQcUn5fT5Pc4iYQ6Ssxvh1h3rGhonS5
         cRv+KgcP+VfsgAXB/NCnXUK3inNnv9+tKagaCwEPL9d9O1fNrrpJVZUjBujalPXerJL2
         eEEPqYPtdeT783zyBQydFo+ld7Y9VciL3pypaElcm1YgPP+7KWKiPZX2A0NfTp2tEYt4
         BJBw==
X-Forwarded-Encrypted: i=1; AJvYcCUO2Y6xXDzZtVTMxIpZJdCyRtO+tMEM5Mus9cqJCLtJj7Bxri73Xyx7xQf8KWXXTK8XGxJq2sI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoKaqpodnwdlZNGQ5D1ggoO1q6JzstGzIEWIEN3a2GofaQ3Hxa
	cF8aD9/jSlN+j/t8J9joIQLqG7kObpU1BcTLtAONojJPCb39CbgGkUFGuO7YCsEX7uo=
X-Gm-Gg: ATEYQzzEr0PEZxKqVljzp6fPrP3bY8g4N5fcgavbLPsHV6tyozzboBUSsZD/W8aOVps
	fojCytokos/eussfOVzbeJgPzs9DSMRSSt1TuKggUZ7Wcc0HRKC3/EkeJDumSgH6+uecmgA9HY3
	7el0XJBM+g73k+Sq8c0k4L+QozU33g57HZz9exAzvLAUNOHj8IBxk5dd5wHrTMaOF++f/iktD4k
	jG/8gzb/OtKs6kcAD2LfJKxUI5p5xfqp3+nO1w3kUl69glIxvGUiu2dedtsfy07EOlnh9qCeqXo
	j+pwMUx7nA+ebHPwSPbiggkcUTtKd5jMddpQkmOcEAch/T2eCNoOljzEVh35OqiZ/NylZog3ufh
	gxK3DnsGONOBxM3Ls8MFjmBzFfTjhH3/J7KyhsOlMRabanh3sfBkjZy9dP92n1cEQcQWGMkLH5K
	O1SKU7SIufjOTXtrp+jvpZO6FtGSrg9pYa7AAPfkCH596Y+0PTPD4=
X-Received: by 2002:a05:600c:45c7:b0:485:3fd1:9936 with SMTP id 5b1f17b1804b1-486fede721amr142064755e9.5.1774247609567;
        Sun, 22 Mar 2026 23:33:29 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083516ab1sm127821195ad.5.2026.03.22.23.33.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Mar 2026 23:33:28 -0700 (PDT)
Message-ID: <78228756-0f0c-4ecb-86d5-da6613160a72@suse.com>
Date: Mon, 23 Mar 2026 17:03:23 +1030
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: Fix BTRFS arm64 tagged KASAN false-positive
To: Daniel J Blueman <daniel@quora.org>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, stable@vger.kernel.org
References: <20260323061827.22903-1-daniel@quora.org>
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
In-Reply-To: <20260323061827.22903-1-daniel@quora.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227889-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,quora.org:email]
X-Rspamd-Queue-Id: 2815F2ED1B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



在 2026/3/23 16:48, Daniel J Blueman 写道:
> When booting Linux 7.0-rc5 on a Qualcomm Snapdragon X1 with KASAN
> software tagging with a BTRFS filesystem, we see:
> 
> BUG: KASAN: invalid-access in xxh64_update (lib/xxhash.c:143 lib/xxhash.c:283)
> Read of size 8 at addr 7bff000804fe1000 by task kworker/u49:2/138
> Pointer tag: [7b], memory tag: [b2]
> 
> CPU: 0 UID: 0 PID: 138 Comm: kworker/u49:2 Not tainted 7.0.0-rc4+ #34 PREEMPTLAZY
> Hardware name: LENOVO 83ED/LNVNB161216, BIOS NHCN60WW 09/11/2025
> Workqueue: btrfs-endio-meta simple_end_io_work
> Call trace:
> show_stack (arch/arm64/kernel/stacktrace.c:501) (C)
> dump_stack_lvl (lib/dump_stack.c:122)
> print_report (mm/kasan/report.c:379 mm/kasan/report.c:482)
> kasan_report (mm/kasan/report.c:597)
> kasan_check_range (mm/kasan/sw_tags.c:86 (discriminator 1))
> __hwasan_loadN_noabort (mm/kasan/sw_tags.c:158)
> xxh64_update (lib/xxhash.c:143 lib/xxhash.c:283)
> btrfs_csum_update (fs/btrfs/fs.c:106)
> csum_tree_block (fs/btrfs/disk-io.c:103 (discriminator 3))
> btrfs_validate_extent_buffer (fs/btrfs/disk-io.c:389)
> end_bbio_meta_read (fs/btrfs/extent_io.c:3853 (discriminator 1))
> btrfs_bio_end_io (fs/btrfs/bio.c:152)
> simple_end_io_work (fs/btrfs/bio.c:388)
> process_one_work (./arch/arm64/include/asm/jump_label.h:36 ./include/trace/events/workqueue.h:110 kernel/workqueue.c:3281)
> worker_thread (kernel/workqueue.c:3353 (discriminator 2) kernel/workqueue.c:3440 (discriminator 2))
> kthread (kernel/kthread.c:436)
> ret_from_fork (arch/arm64/kernel/entry.S:861)
> 
> The buggy address belongs to the physical page:
> page: refcount:3 mapcount:0 mapping:f1ff00080055dee8 index:0x2467bd pfn:0x884fe1
> memcg:51ff000800e68ec0 aops:btree_aops ino:1
> flags: 0x9340000000004000(private|zone=2|kasantag=0x4d)
> raw: 9340000000004000 0000000000000000 dead000000000122 f1ff00080055dee8
> raw: 00000000002467bd 43ff00081d0cc6f0 00000003ffffffff 51ff000800e68ec0
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
> ffff000804fe0e00: 7b 7b 7b 7b 7b 7b 7b 7b 7b 7b 7b 7b 7b 7b 7b 7b
> ffff000804fe0f00: 7b 7b 7b 7b 7b 7b 7b 7b 7b 7b 7b 7b 7b 7b 7b 7b
>> ffff000804fe1000: b2 b2 b2 b2 b2 b2 b2 b2 b2 b2 b2 b2 b2 b2 b2 b2
> ^
> ffff000804fe1100: b2 b2 b2 b2 b2 b2 b2 b2 b2 b2 b2 b2 b2 b2 b2 b2
> ffff000804fe1200: b2 b2 b2 b2 b2 b2 b2 b2 b2 b2 b2 b2 b2 b2 b2 b2
> 
> This occurs as allocation in btrfs_alloc_page_array is from multiple
> discrete pages thus different KASAN tags by design, leading to a tag
> mismatch when linear access is used where the pages are physically
> contiguous.
> 
> Fix this by retagging all the EB pages with the same KASAN tag.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel J Blueman <daniel@quora.org>
> Fixes: 397239ed6a6c ("btrfs: allow extent buffer helpers to skip cross-page handling")
> Changelog:
>   v2: Retag pages rather than bypass linear access optimisation
>   v1: https://lore.kernel.org/lkml/20260319053413.14771-1-daniel@quora.org/
> ---
>   fs/btrfs/extent_io.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 5f97a3d2a8d7..37836d685f21 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -10,6 +10,7 @@
>   #include <linux/spinlock.h>
>   #include <linux/blkdev.h>
>   #include <linux/swap.h>
> +#include <linux/kasan.h>
>   #include <linux/writeback.h>
>   #include <linux/pagevec.h>
>   #include <linux/prefetch.h>
> @@ -706,6 +707,18 @@ static int alloc_eb_folio_array(struct extent_buffer *eb, bool nofail)
>   	if (ret < 0)
>   		return ret;
>   
> +	/*
> +	 * Since separate page allocations are used for the same extent with
> +	 * linear addressing where physically contiguous, apply the same KASAN
> +	 * tag to prevent false-positive warnings when crossing page boundaries
> +	 */
> +	u8 tag = page_kasan_tag(page_array[0]);

We do not mix definition and code.

> +
> +	for (int i = 1; i < num_pages; i++) {
> +		page_kasan_tag_set(page_array[i], tag);

Please note that, at alloc_eb_folio_array() we have no idea if the 
folios are contig yet.

And if they are not contig, tagging them with the same tag will mask 
some real bugs.

To me, the proper re-tagging timing should be inside 
alloc_extent_buffer(), under the "if (page_contig)" branch.

Thanks,
Qu

> +		kasan_unpoison_range(page_address(page_array[i]), PAGE_SIZE);
> +	}
> +


>   	for (int i = 0; i < num_pages; i++)
>   		eb->folios[i] = page_folio(page_array[i]);
>   	eb->folio_size = PAGE_SIZE;


