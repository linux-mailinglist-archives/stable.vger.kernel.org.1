Return-Path: <stable+bounces-5005-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1AA80A1B7
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 12:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F1CA1F2146D
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 11:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19688199DC;
	Fri,  8 Dec 2023 11:02:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
X-Greylist: delayed 142 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 08 Dec 2023 03:02:49 PST
Received: from mail78-59.sinamail.sina.com.cn (mail78-59.sinamail.sina.com.cn [219.142.78.59])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0120B115
	for <stable@vger.kernel.org>; Fri,  8 Dec 2023 03:02:49 -0800 (PST)
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.70.31])
	by sina.com (172.16.235.25) with ESMTP
	id 6572F74400006BEA; Fri, 8 Dec 2023 19:00:23 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 77654034210456
X-SMAIL-UIID: 457102411D424AB8A7BC2C68FF80975B-20231208-190023-1
From: Hillf Danton <hdanton@sina.com>
To: Yu Zhao <yuzhao@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Charan Teja Kalla <quic_charante@quicinc.com>,
	Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH mm-unstable v1 2/4] mm/mglru: try to stop at high watermarks
Date: Fri,  8 Dec 2023 19:00:11 +0800
Message-Id: <20231208110011.102-1-hdanton@sina.com>
In-Reply-To: <20231208061407.2125867-2-yuzhao@google.com>
References: <20231208061407.2125867-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu,  7 Dec 2023 23:14:05 -0700 Yu Zhao <yuzhao@google.com>
> -static unsigned long get_nr_to_reclaim(struct scan_control *sc)
> +static bool should_abort_scan(struct lruvec *lruvec, struct scan_control *sc)
>  {
> +	int i;
> +	enum zone_watermarks mark;
> +
>  	/* don't abort memcg reclaim to ensure fairness */
>  	if (!root_reclaim(sc))
> -		return -1;
> +		return false;
>  
> -	return max(sc->nr_to_reclaim, compact_gap(sc->order));
> +	if (sc->nr_reclaimed >= max(sc->nr_to_reclaim, compact_gap(sc->order)))
> +		return true;
> +
> +	/* check the order to exclude compaction-induced reclaim */
> +	if (!current_is_kswapd() || sc->order)
> +		return false;
> +
> +	mark = sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING ?
> +	       WMARK_PROMO : WMARK_HIGH;
> +
> +	for (i = 0; i <= sc->reclaim_idx; i++) {
> +		struct zone *zone = lruvec_pgdat(lruvec)->node_zones + i;
> +		unsigned long size = wmark_pages(zone, mark) + MIN_LRU_BATCH;
> +
> +		if (managed_zone(zone) && !zone_watermark_ok(zone, 0, size, sc->reclaim_idx, 0))
> +			return false;
> +	}
> +
> +	/* kswapd should abort if all eligible zones are safe */

This comment does not align with 86c79f6b5426
("mm: vmscan: do not reclaim from kswapd if there is any eligible zone").
Any thing special here?

> +	return true;
>  }

