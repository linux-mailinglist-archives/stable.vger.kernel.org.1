Return-Path: <stable+bounces-244743-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJQ2KnzJ/WkpigAAu9opvQ
	(envelope-from <stable+bounces-244743-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 13:31:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E084F5C8C
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 13:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7CA493017538
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 11:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE303B8BDB;
	Fri,  8 May 2026 11:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MyK0sl5Q"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F3E3B7B84
	for <stable@vger.kernel.org>; Fri,  8 May 2026 11:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778239865; cv=none; b=j9Le3SG+BpNhKmPYQCfzcgIsoobFb2d7HQ1LZd1ex7cqHYPSpy6YHkPzI1w9iXlC5rVDJ/2B8l99NRQ53lQ3DL7rGG8KQ/Z6eKRAEf2QWGV+Lmjj6l2MCYzy+E2siN1mD+vGIgJJa01NuKsfg3U1qf1PZOYsSLkYpgnXl2fqmCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778239865; c=relaxed/simple;
	bh=BbxJFnwClrzpI9NJL8l2W8HPO2FxxlMcsmgLf6HUPsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9P9WhnRa1JpyU0lM9nRXODqVJUPTi/yDMhRlO4hVGKAuklLqj/MQ+a/OfKDxc0Qux7mn8QBdO4uLTF44kwjKT/w5b0MNA0ApQOahcj1xhbOppTy0NQ9Td81dTyl4/3Jwz0C15yBcjlR25KTV6aO6AF+TTBU7OL/qYQSFLS36KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=MyK0sl5Q; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1309f4ee973so2239968c88.1
        for <stable@vger.kernel.org>; Fri, 08 May 2026 04:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778239863; x=1778844663; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BbxJFnwClrzpI9NJL8l2W8HPO2FxxlMcsmgLf6HUPsA=;
        b=MyK0sl5QfoWxORevjtZ2QeLcYcRFFfX2P5C+ZfNnPAcBwYAbrtrXFoK0pzeS0NUAfW
         +/VbZrkZfzJKq00pdEawB5wz0R2fcXAXLQWlMF7tpQy2OLnxumLpP268c4lR1L+eywxg
         599ybL6qphAb4rV9TPc5k49qb9FuE03OAYYOT34bwjDUMjoCgaMm5PsbZg5gSXKGMWV6
         78g2NDQqf7mD0X0/ZosXn8d9mao5sJwTXrBLvfmZs8/fo+YjlGil1bcHIAbvVC/C6CnK
         5NLtt9E/0s8Bai2BLvzWWu2xZrs0J47Pb5StI/Hf4Y2WaggtTLeVPvM80p7Jl67faSm/
         DU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778239863; x=1778844663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BbxJFnwClrzpI9NJL8l2W8HPO2FxxlMcsmgLf6HUPsA=;
        b=Q7iu+la2nJ/qjYdYNdNIxkGn82LWo0IS+MQSXSWe/Sp0Qru17addM22eTOqDf8IDwr
         gv5gmlRuuDekUlY/WUCWuPJOMpMsa0Bf1n/q41Vw2VarGwohXTnQkH/8giwtl3Gru2Tk
         UVv6lfCMevfFK0CS7BzfhPvXdiuNszSi6NKuv95r6CBLMuDs7WllqGu65gyutTkh8ziy
         cWc+BdYiawkE8d7oGltLzgxmB/ktwBAlV455vNsDGH5bGleIaT9GHqATeE2Z0L3v40aK
         3Cln6F8Y2skb1akFGYhUCKqBeJovT3nSs7134B189l8AuRrgBLd0s6hSBXsjU6CIwsoR
         rKuw==
X-Forwarded-Encrypted: i=1; AFNElJ9CzBUwlG7CMXTq5xj6xJq9sZj63G0Z6sqerohWoiB8ik4KPULs5GQYRD71KPSIABp0aZKjCM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQale3tmYqT+GSXuyubs1PfHAq6dg+DJRv7c8W+wcowCZDYwNi
	hVruK4ja8xFTSG1m5QjHRlZo0kmKieevmRyfMlgCjQNwNxmerKMfTBJ+A8eWofaqRlg=
X-Gm-Gg: AeBDietqGFgHnjfNhV246aPu5bGdvy1AjqAKLAGlx9MfokgtoPrq/U7nWqayEMhMUHy
	T0rAfqx0nv35u9Sb1XdvwEFe6eizhAte7bHolFjfpC/x0T9Aonf1Q46sxon63y9puWuoePa0Fh2
	kiCbjqJPQWkDXcau3mUexA9MtTY5tFCisXO3Ak5gC1j197lm1f8erS42m7ZERFzyNXk4nW9a1SK
	jTgIRWNdi+jyoZ0ocW4t3Si4i5w15Lng5cU/EL4HqQkbaPAVdCgi3UwcHKY0YxykCS+xRFQuOKR
	WCpIGaeMJro61fqsodyDElP4zttjLH1x/f0CxYogKdVwe1zbIhBP2H3tkve7T4TsrWWFw7dWECl
	KJf4yDupUHWgNgysrFXGpdWPtSHlm/HdMHHoooix3j/ge2W5Ny3kLs6K54W14KAEkMq53jcFD1X
	NqZ4P9lGKt
X-Received: by 2002:a05:7022:1a83:b0:127:5c3d:bd95 with SMTP id a92af1059eb24-1318e919fcemr6049587c88.32.1778239862942;
        Fri, 08 May 2026 04:31:02 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-132781103e7sm2331622c88.1.2026.05.08.04.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 04:31:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wLJQ4-000000002Qs-3y7p;
	Fri, 08 May 2026 08:31:00 -0300
Date: Fri, 8 May 2026 08:31:00 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jianpeng Chang <jianpeng.chang.cn@windriver.com>
Cc: Robin Murphy <robin.murphy@arm.com>, m.szyprowski@samsung.com,
	leon@kernel.org, kbusch@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: remove bogus test for pfn_valid from
 dma_map_resource
Message-ID: <20260508113100.GA9285@ziepe.ca>
References: <20260507032120.4072283-1-jianpeng.chang.cn@windriver.com>
 <2dcc29d6-a4a9-4fdf-861d-312941ab0f07@arm.com>
 <89094011-fe78-40f9-9695-d50ee19167c5@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89094011-fe78-40f9-9695-d50ee19167c5@windriver.com>
X-Rspamd-Queue-Id: 03E084F5C8C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-244743-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 06:01:01PM +0800, Jianpeng Chang wrote:
> > As I said last time, I think pfn_valid() && !PageReserved(pfn_to_page())
> > would be enough for what we want here, although now it's strictly under
> > CONFIG_DMA_API_DEBUG, perhaps the overhead of memblock_is_map_memory()
> > might be less of an issue. Either way though, now that it's all
> > channelled through the single dma_map_phys() path, it would probably
> > make sense to consolidate any MMIO sanity-checking into
> > dma_debug_map_phys() anyway :/

> Thanks for the suggestion. Move the check into debug_dma_map_phys() is
> indeed better, and I will replace pfn_valid() with pfn_valid() &&
> !PageReserved() as you suggested.

I'm not sure that is right. IIRC pfn_valid() is true for ZONE_DEVICE
P2P pages that are used with map_phys but never with map_resource.

PageReserved isn't enough to fix it.

Jason

