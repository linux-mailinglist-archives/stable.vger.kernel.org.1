Return-Path: <stable+bounces-273654-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ivzNFVTPVGqOfAAAu9opvQ
	(envelope-from <stable+bounces-273654-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 13:43:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF1674A799
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 13:43:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cmpxchg.org header.s=google header.b="MBIf/ySZ";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273654-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273654-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=cmpxchg.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D73B304021B
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 11:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EF13E866B;
	Mon, 13 Jul 2026 11:39:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DA53E9589
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 11:39:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783942798; cv=none; b=IHAbRyWPBN05SmxEf0GYBR/eyHD+eJsBk3S+MBjW3/oCzqB/RzbONRcU8g5zh8Ko6H/pTAtcgNhwhO9UqTFditnzMdgEbnjZBMbQSGkEd5UBMbf+GGPNZK+Zgd42JP/NNvyAxi0P2q7/pXQokP9jA5upMUhT2FbT18v8anvQWSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783942798; c=relaxed/simple;
	bh=HH8yJYozLc4qkKrr/HAaxxtxQon+M9HwA47b2g1ZfE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnweI9a7ycd427BBObi2OUDuxgUmbJ5U67jWgvMdhR5OIZ9exp6bK16mCd2Mbpe/3CAcA1Ii8p9wVyHQkx7+drO1jzUCLOnitosq9itwwJQ8TJl+8qQ92K9cPeCcTWtQHtuWW9rJe5XLiRzQ7EIVhZwmaqpPkuXnfTqL7AT0xdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=MBIf/ySZ; arc=none smtp.client-ip=209.85.128.53
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493c52cde9eso27544985e9.3
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 04:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1783942795; x=1784547595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uhEJSmb1zAc+1BJfU7rn0s0R4zfNHqR+TO6aCnEihGQ=;
        b=MBIf/ySZmCVAhal4XZqddfeWpugm067UrkyGqM9wBcZCyIRCj2jTDSbA/RWy/nGRqj
         mKA8nPiI4N/LAgtkGrBq/N3ktJRZCzvJdD0dObVPiBUzWdj/JER3x4g1cS0bNd+W5PCp
         vMTRwkV6npDdYdaElPcziIrqFuWwFAIPXSZfOcu8Q5p9HD+NWAk9Uvk5mkCO3G06A8AA
         bKuzNn1mc5Hiuj25kXgvHZ3sGyVjnfQ+SvDViTSmqes8b7eKJDSyeULnLNmcaAvkmVOm
         Xp/H2VKhxfdBoWiuA9s2SKjqb3bV3X26514nxb+b1hpYlLpCQPC3xgFB9iRAgJ6jg8cD
         aZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783942795; x=1784547595;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uhEJSmb1zAc+1BJfU7rn0s0R4zfNHqR+TO6aCnEihGQ=;
        b=X7HwVuRLq/j5BT25NF8NIDlNTUX1HA6BuiQUc0XGWHOauAPBGimtfsOjR1FryJtAdk
         vGmPF3NG+PA9cO+1sF2o2s1UTmE4VljVLSt04FC/ZFFAkCu07jufbandj7f/D7CulZlA
         6LqsRGLBuls2E8hgsRk24fu/afcTxXetkNlGNW8XYxIUds39+/YGLCs+OGl1Z3QYLlpT
         IavYjnDkxnARlQSEB/0tQbVA3g1poUE/x4e6DMFZDReG5KIOL6rGKCg3VOk4AiuyI6l9
         g0/GVhnmn57sZcHnCTNO3SGhVBaZ1oFQNp5rAnZzLW7l0rIPEp7zEBSE2tfPvDW7NyD0
         1YjQ==
X-Forwarded-Encrypted: i=1; AHgh+RrPTfmZNLJM6brAcsBB0XEXj1QOsZwxkoTU4t1Z8U9aGutQwekRT1RPV5T40cdmk/mR42EXnOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVzjBwIRgg/+WWtaeo8aTppqejmYkyar1q3fg6YdMtZRrm82Q5
	hjBfX1PGPcwHMmTMNTN6s6KNzKO96ZQrqG5jrxKbm99gotfu1/GarQ8S8kWRxQ5HZEM=
X-Gm-Gg: AfdE7cky5HOclq1yD3EyLEeEukx5s5dECyIaWcvtlGtn7i4cReLdZSI6/vuRQ+oSqad
	Dh3X8VIPwr1i6SEf3rWibHEVzUtu5+LipYkXFfT8UnYjxin0yBO4KawUQGRmNK2Gh8Evx4/jDvx
	Y+Jcrff6iUIFSkewiBVuSmZFcop7kY558+D9CAZzdkVb0jy7S43t+lG1z6/mvA7kpW7JFrUXjyR
	2eMYFoW1J7PCjqlauucZJwgvKLgyhyS2Wca5L6wopy4sRMnyy8aaXYonAj1fhjBy5uXmXrl9vUv
	HKADFNT0nOsid4cY5d+YLLgRlH0r3KXd3TKZTKYg4B+iIhoWb4Yi0cY6Kxqor4xrIBLU6jlAfsu
	zDKA0zrT8fnTnRD60rfilLNon3qwdy122KQmShZayPLxYIz9yDPkPNsyyGh8JEraXmbmZNp5Qc+
	MzCZ8SfOufitgcX+CS++xV
X-Received: by 2002:a05:600c:1992:b0:493:f261:d295 with SMTP id 5b1f17b1804b1-493f87d9886mr86244245e9.4.1783942795022;
        Mon, 13 Jul 2026 04:39:55 -0700 (PDT)
Received: from localhost ([2a02:8071:6401:180:d892:bf43:a0b4:83b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6d5055sm355712995e9.5.2026.07.13.04.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 04:39:54 -0700 (PDT)
Date: Mon, 13 Jul 2026 07:39:53 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Guopeng Zhang <guopeng.zhang@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Stanislav Fort <stanislav.fort@aisle.com>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Guopeng Zhang <zhangguopeng@kylinos.cn>
Subject: Re: [PATCH] mm: memcg-v1: account vmpressure event allocations
Message-ID: <20260713113953.GH276793@cmpxchg.org>
References: <20260713085520.2953121-1-guopeng.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713085520.2953121-1-guopeng.zhang@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273654-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[hannes@cmpxchg.org,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:guopeng.zhang@linux.dev,m:akpm@linux-foundation.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:stanislav.fort@aisle.com,m:mhocko@kernel.org,m:muchun.song@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:zhangguopeng@kylinos.cn,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cmpxchg.org:from_mime,cmpxchg.org:mid,cmpxchg.org:email,cmpxchg.org:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8CF1674A799

On Mon, Jul 13, 2026 at 04:55:20PM +0800, Guopeng Zhang wrote:
> From: Guopeng Zhang <zhangguopeng@kylinos.cn>
> 
> Commit 72797d218b43 ("mm/memcg: v1: account event registrations and drop
> world-writable cgroup.event_control") accounted cgroup v1 event
> registration allocations with GFP_KERNEL_ACCOUNT, but missed struct
> vmpressure_event.
> 
> Use GFP_KERNEL_ACCOUNT for this allocation as well.
> 
> Fixes: 72797d218b43 ("mm/memcg: v1: account event registrations and drop world-writable cgroup.event_control")
> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>

I guess :)

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

