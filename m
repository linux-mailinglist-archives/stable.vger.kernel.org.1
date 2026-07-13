Return-Path: <stable+bounces-273635-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6E6bEjPBVGrjHQAAu9opvQ
	(envelope-from <stable+bounces-273635-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 12:42:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF37749ED4
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 12:42:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cmpxchg.org header.s=google header.b="dcB/RAqB";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273635-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-273635-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=cmpxchg.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79B04304227F
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 10:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4104839EF12;
	Mon, 13 Jul 2026 10:41:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE173368AA
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 10:41:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783939305; cv=none; b=iyGXNLXbs6qmgAXT5Cc+amcybgNYoncbUfIaZgdbhE1LYzR77AhTLPHNcmfoJFxQfhrCwMqgoIsNkq27voPca7ntqV2ZH4m1t5jddhgNYSZuAbnfRXgzbg/sVaJH4N80cF3/jnpqmwED3GB6ml1jrI6ER7kTjnxQmXluBIZmhFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783939305; c=relaxed/simple;
	bh=9OwuFF7+/jzfb+mWPqzlkgj5ZqG7UgrX3Yt9wiO5b84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HS29pw/lgPdukbNFphD+8ML5PE3c5F9xR9I+zDGK371r98ltSiPvEYCG/PlP7kGu5KZLItNIF6wxdjhlRA4fBV7BPaGtUauZ7SDjyqiRhaCi3NpcqBVzrNnqOZKfU6EUQbYgKvtCb/9FNsoJzMHZENeUJ5TlAE9zW7OYZGsqCUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=dcB/RAqB; arc=none smtp.client-ip=209.85.221.44
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47d6c634f45so1540235f8f.3
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 03:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1783939300; x=1784544100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GYEvHk/YQwaSKZb15XTEhRLqDQdjnw2zpv1OC/g28DM=;
        b=dcB/RAqBb+PSyJKjR4JQ8zH27dKzbTL9xxlaUE0vCpAp8QbWUVzXAhBW2bmx1FaVNi
         P8+0CDzYPcwsadVLq09aMC7M/C34rWFmhMO/qMtm2k4nbOJxdGCEhFFeSwkq9mzs/HAU
         TbyJjVR97MFRn0EeVlY6vSh4WiZ5mR5GRRlREYOz0rrAS1xFifosscUg145AM+p+5e4p
         oHv11Tx5S9QQdfXSWPn55L365QII6LWAjyacKVGkvgZ1E1Ah7fyHwnxh3rVw/qo8HGi1
         0xByqMHq635F01rdTUXXcOm+5lxITdLjy39+ooMEZmHro+UU6KeN2rlcZSQfI1lzgef4
         n3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783939300; x=1784544100;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GYEvHk/YQwaSKZb15XTEhRLqDQdjnw2zpv1OC/g28DM=;
        b=JFxtJK8bfU7ClaJ68iWVWy/44m5Vv4D96A65JElKjvTuehg9x9HIDyMu9Biy+dN5KJ
         Roq305RNE0YUt6M8SFi4PkKwuoz6qojeHqwirj7GMwkJppxgVbzcfGOKSzJXM+pJIWNP
         XSRLPEbWOc9OuBZNcf9bYfqweGxFzyxW6l3EfHYtVOAzHldqOxWDpSJnHsnD/sZRopMf
         ZmUXbOTFmea4jMFp603Z2C98bvO0+2zvFW4EM90RMtNtu4q2Mv+EuPvI7OUv7N1b/gLf
         JcFwpiThasSLWB2RyF1dacREt3OurISWjWG8dpJFzbu1rhwH6814ee8q0bN6rT8pubbv
         8ckg==
X-Forwarded-Encrypted: i=1; AHgh+RoIIAh/7BDgaT1mNRzyRMvJdlFBdG12zUIrY/0lTbYmKfFezMDD0CkPxGK0ZKOT0f/YI1M38Co=@vger.kernel.org
X-Gm-Message-State: AOJu0YycWOvStrG9NwYBYgRY/KQFVna/BeGE3OfA+CrC4bP3l02epeJa
	FbAvhbmowQZ79WrysIJ5ouC/9HrFvlVmjta7qOOZw3mKaYCJh9ptXg27D7i6dKZCKyA=
X-Gm-Gg: AfdE7cmETIw6jxv4B61bAq20I1C0GJ0vUxSNGRiB6d5cpyryqw3jAuzNS1jOSNessZF
	1kEN038E1RWy6h/QKWJdPeR/B/YebGsUKgOCb3iRnNercR0tRfIXC4i9fs4IowlvfBNGPYAK9GR
	ugsy8ApmwvYIOKmGMVQn1wGI4+ubkV6qG0fxXOC7jQLDQCBF9NY5YH2OzzhKHhbhWkQ5oqYofMV
	tZBo7ptel01mrwSI1ZlpUjLZy0170voBDfzBHZhujuSSMBhWv+ezA2b+c9thD3pSjjSf5h80Rsj
	yWnxm2DNaX3N7FgiJMU1YHEneK1tOmV6L//0T+m2zVyRi2SpVQ0ZiMuSYk2ctOaGve5vUtew+dJ
	V/FZyruK3neZBlclygMZCmIvzJblw7SBz8YIofy3X/yT1WOk3qV+YqcXQ+jvZhsJ5QZ4l9bxgeq
	gKN4woTiycxQ==
X-Received: by 2002:a5d:64e7:0:b0:472:aaba:faed with SMTP id ffacd0b85a97d-47f2dcc6bd5mr9999848f8f.31.1783939299409;
        Mon, 13 Jul 2026 03:41:39 -0700 (PDT)
Received: from localhost ([2a02:8071:6401:180:d892:bf43:a0b4:83b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039af67sm95258224f8f.17.2026.07.13.03.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 03:41:38 -0700 (PDT)
Date: Mon, 13 Jul 2026 06:41:34 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: akpm@linux-foundation.org, david@kernel.org, kasong@tencent.com,
	shakeel.butt@linux.dev, baohua@kernel.org, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, harry@kernel.org,
	muchun.song@linux.dev, peiyang_he@smail.nju.edu.cn,
	mhocko@kernel.org, roman.gushchin@linux.dev, ljs@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>, stable@vger.kernel.org
Subject: Re: [PATCH v5] mm: mglru: fix stale batch updates after memcg
 reparenting
Message-ID: <20260713104134.GA276793@cmpxchg.org>
References: <20260710154318.75388-1-qi.zheng@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710154318.75388-1-qi.zheng@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273635-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:qi.zheng@linux.dev,m:akpm@linux-foundation.org,m:david@kernel.org,m:kasong@tencent.com,m:shakeel.butt@linux.dev,m:baohua@kernel.org,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:harry@kernel.org,m:muchun.song@linux.dev,m:peiyang_he@smail.nju.edu.cn,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:ljs@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:zhengqi.arch@bytedance.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[172.234.253.10:from];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[hannes@cmpxchg.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DNSWL_BLOCKED(0.00)[100.90.174.1:received,2a02:8071:6401:180:d892:bf43:a0b4:83b:received,172.234.253.10:from,209.85.221.44:received];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received,209.85.221.44:received,2a02:8071:6401:180:d892:bf43:a0b4:83b:received];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[cmpxchg.org:dkim];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bytedance.com:email,cmpxchg.org:from_mime,cmpxchg.org:mid,cmpxchg.org:email,cmpxchg.org:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DAF37749ED4

On Fri, Jul 10, 2026 at 11:43:18PM +0800, Qi Zheng wrote:
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
>     --> update_batch_size
>         --> walk->nr_pages += delta
> 
>                               mem_cgroup_css_offline
>                               --> memcg_reparent_objcgs
>                                   --> lock lruvec
>                                       lru_gen_reparent_memcg
>                                       --> reparent child folios to parent
>                                       unlock lruvec
> 
>     lock lruvec
>     reset_batch_size
>     --> child lrugen->nr_pages += delta
> 
> This will trigger the following warning in lru_gen_exit_memcg():
> 
> 	VM_WARN_ON_ONCE(memchr_inv(lruvec->lrugen.nr_pages, 0,
> 				   sizeof(lruvec->lrugen.nr_pages)));
> 
> And the user-visible impact of underestimated nr_pages in MGLRU was
> premature OOMs because MGLRU does not try to reclaim memory when nr_pages
> reaches zero, but there are still more pages.
> 
> To fix it, make reset_batch_size() check CSS_DYING under RCU before
> flushing the pending batch. A non-dying memcg keeps the original lruvec
> stable against RCU-delayed offlining; a dying memcg redirects the deltas
> to the first non-dying ancestor.
> 
> Reported-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> Closes: https://lore.kernel.org/all/5A9E929D82717101+12fcf643-efb8-4b9a-a53a-1e28cc894f0b@smail.nju.edu.cn
> Fixes: f304652609ea ("mm: vmscan: prepare for reparenting MGLRU folios")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

