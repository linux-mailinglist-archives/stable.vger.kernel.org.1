Return-Path: <stable+bounces-267851-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3W+0NAL2OWrVzQcAu9opvQ
	(envelope-from <stable+bounces-267851-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 04:57:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D39E6B3A76
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 04:57:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=thCksxOr;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267851-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-267851-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 060013026AD8
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 02:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139B1387363;
	Tue, 23 Jun 2026 02:57:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0F73845C1
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 02:57:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782183422; cv=none; b=km1jkqoVDddPJSKL35+WfyDA1UUGdR3MxckVpL45TKsHkb/xRm/viGC/pfjFY8cKGahyqMiqenaEGqsgcK5W/BdtN1oVS9rl7pCSCsRNWBfJf5utAJ9K41gaPW+VO2ZNImjSQXYXPlqA6RQp3YZKKruFSwVuKhF/dSPSiMeUFSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782183422; c=relaxed/simple;
	bh=cq4gwAIKAiSr1nnH84acTmsZcoVvmcL4+9dkCXF00UA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RyPnY4HOv6on/oTx5nqgjhgHZOUnvUJzYJYt84/XyWeGxD2bjIOFVbruZO7dq/2/bwRTD01JPUaikliVHjVp1GruJvlvi4Rt2Va8HlbCNLtryMw576KvgJ9vrQkOOJxvtVPoYGJCNhylZwzTxr40PcwPX2MpV7cYZlT72DVj3TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=thCksxOr; arc=none smtp.client-ip=95.215.58.178
Message-ID: <08f71d27-db8a-40d3-b906-28405f790e56@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782183409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gamJXZDJG5FoQ+0MRzknU1CG7VksU99okaa549Y0pGE=;
	b=thCksxOrVcOVb8+PUQuVaNwG96PRajMNWiIzsT7m1Cc/eD1A4hXIZc4cqtegkrbEe2nIRE
	Z6L7GOJjZCL/Fj16FxaYfthJrd6nUSFj3xiCmnlpgfpFs1/V5nEhpWPc3qfhrpt/CoaBjR
	ZC4AIccBDvqnrhZ/NDhsEt7zjhQ0Ojo=
Date: Tue, 23 Jun 2026 10:56:14 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] mm: mglru: fix stale batch updates after memcg
 reparenting
To: akpm@linux-foundation.org, david@kernel.org, kasong@tencent.com,
 shakeel.butt@linux.dev, baohua@kernel.org, axelrasmussen@google.com,
 yuanchu@google.com, weixugc@google.com, hannes@cmpxchg.org,
 harry@kernel.org, muchun.song@linux.dev, peiyang_he@smail.nju.edu.cn,
 mhocko@kernel.org, roman.gushchin@linux.dev, ljs@kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260623024237.45990-1-qi.zheng@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <20260623024237.45990-1-qi.zheng@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267851-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[qi.zheng@linux.dev,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:david@kernel.org,m:kasong@tencent.com,m:shakeel.butt@linux.dev,m:baohua@kernel.org,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:hannes@cmpxchg.org,m:harry@kernel.org,m:muchun.song@linux.dev,m:peiyang_he@smail.nju.edu.cn,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:ljs@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qi.zheng@linux.dev,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nju.edu.cn:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,bytedance.com:email,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8D39E6B3A76



On 6/23/26 10:42 AM, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> The mglru page table walker batches per-generation size deltas in
> walk->nr_pages while walking page tables without holding the lruvec lock.
> The reset_batch_size() later folds those deltas into walk->lruvec under
> the lruvec lock.
> 
> The page table walker can run concurrently with the memcg reparenting path
> as follows:
> 
> CPU0                           CPU1
> ====                           ====
> 
> walk_mm
> --> walk_page_range
>      --> update_batch_size
>          --> walk->nr_pages += delta
> 
>                                mem_cgroup_css_offline
>                                --> memcg_reparent_objcgs
>                                    --> lock lruvec
>                                        lru_gen_reparent_memcg
>                                        --> reparent child folios to parent
>                                        unlock lruvec
> 
>      lock lruvec
>      reset_batch_size
>      --> child lrugen->nr_pages += delta
> 
> This will trigger the following warning in lru_gen_exit_memcg():
> 
> 	VM_WARN_ON_ONCE(memchr_inv(lruvec->lrugen.nr_pages, 0,
> 				   sizeof(lruvec->lrugen.nr_pages)));
> 
> To fix it, add lrugen->reparented to remember the new owner of a
> reparented lruvec, and make reset_batch_size() charge pending deltas to
> that owner.
> 
> Reported-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> Closes: https://lore.kernel.org/all/5A9E929D82717101+12fcf643-efb8-4b9a-a53a-1e28cc894f0b@smail.nju.edu.cn
> Fixes: f304652609ea ("mm: vmscan: prepare for reparenting MGLRU folios")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Barry Song <baohua@kernel.org>
> ---

Changes in v2:
  - update the commit message (pointed by Barry)
  - collect Reviewed-by

>   include/linux/mmzone.h |  4 ++++
>   mm/vmscan.c            | 43 +++++++++++++++++++++++++++++++++++-------
>   2 files changed, 40 insertions(+), 7 deletions(-)
> 

