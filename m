Return-Path: <stable+bounces-219955-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NBpD6aToWmvuQQAu9opvQ
	(envelope-from <stable+bounces-219955-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 13:52:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 936B51B7602
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 13:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25691306376B
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 12:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBA23B9600;
	Fri, 27 Feb 2026 12:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="WnNnk6ta"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCF4368971
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 12:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772196702; cv=none; b=Z8Ftt+4yfQD8XgNEkcaEftQ57jc1IvhxwOv0Mn+zy3bC0+dNhkcPIb7W6NabX7DxYHeYlWszHcaXqGuV6UM8ILtL37uNTa6Q3p5dg/cqjhAsAR1kVqm+kXlFRq/sDzWNrrtwyLLScOfpWTDbTL3K2FdpZWJ3U3cNJbyPfXvY7VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772196702; c=relaxed/simple;
	bh=UiOExHwzPgH+a46X6Lafnzd0iwNqcF99JpO1VfaFk6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QkKOtPEV7IEAnhwmX7hE5MRUZQ+dSaDFSUfIvjI2s6S3jR2THWIjnjZZH7LdGvXjBxkftPh23J1Bzqf93T9+TsYw77gDpIMfvIKrs8Z0uJTg1GeK1GXnk4RvfcFQYmn+WDupziLzY3nFdmjepSy/CKd7E4YPCLKljPn3eVzY3fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=WnNnk6ta; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8cb20bcff5aso189898185a.3
        for <stable@vger.kernel.org>; Fri, 27 Feb 2026 04:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1772196698; x=1772801498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aJsL5ft8+uR36go2nZZ3KkNMsYpE/8dDd7y8kbPIygc=;
        b=WnNnk6taGLfSyse3NXarTcsKgYa9cign4AIBk6jLFihgslnu/ip9PoeXd0aLpRQOjD
         4Su8CqDUo40VEjt4MhjXyMgeLB7GpElOIhhHptbwOMYb86DfJJXU+JNSG5cFcmqtrvEq
         jzyEHuc7Evzb/SOoZXnywGvZ2pq1V6ew5UsIdX0MCsmeVvc75+UvT2TVY+W6Z/5Ir/ca
         BG4bUEea2pvYIQSX0UcjmUGrQsUEW6emjbJCqjYveT3UCC//KRSiDLKL6IKqmKcq2lNh
         SUuoW9LPPn33FLTZd+dastxxDZzch7J0/+zKHAvPkJ7OcECChyP2WARTCkDZOTYtsNKn
         J+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772196698; x=1772801498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aJsL5ft8+uR36go2nZZ3KkNMsYpE/8dDd7y8kbPIygc=;
        b=dpmyD+FkDn899jZYc7nY2lTd+jwtoY86uSLoCMH7732CAJLGxwirEaekGi8bjAxrtu
         rN8i7jQ2qisHJfHRQxD8VOBTDA9R21cUC8eBeJNUP51SvR1mKMvQKDxrzYh8g5VSg6Pr
         WgTXOVCi+YVJrI9z1gYvL/7SAAMm/C4TTHhEBf/T+n7UTsjiotFD5erETIF3WOXWHQ9J
         LTPAvBH4RMbmUgzBzB+QKvE3U2WbZ1fDp/gw8vtnZ3HUjCDeLw+vMrnygLQtnq1Wj1o9
         +ytHZA6pwV8W2tm7k09aC6D5SiCW1pbThYSWdum933qO01urmIWE0eSfjAuxBGet4Hdc
         L72g==
X-Forwarded-Encrypted: i=1; AJvYcCV2Z16RSOzvtafVEfOXR3F0HThJsi7AElHHN/Y5t3uUwq73+GGvfUjB0dNtMScjbXIPAM4B0CI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEyvkRRtldfGPUg5dmJ6jw83ZjXKGFRS1k3lUj27G2UM3b78Z5
	0mC8XvdlbdRii+8yh49w99q2HyS8DNeHuI7IuKNdn75hbD9b4z4KDcF6kyfG97/1vsI=
X-Gm-Gg: ATEYQzyFAat6xSVTxK5EwvNzFztQjtnPTxoZwglBVfs/19oyqqTYGmdHBVti60UKgXJ
	AIs13iawc+Qm1vQvo/da63X1Spvj0JVF8g1yw+3fBD65xd4ZrLaAd5mDyE6Lctz05pGSb2nE8e0
	I5WTey5ks+44RHHMCMtmY1Ra5/xGmmE5y+bs5tCG31huDAWuYhIVE0nB/gCottiTAImTOIGJAEJ
	NLOMHmzOzRq7eB3XB3bf2zby0jS0C7aZhwqeELucVtNEEiYhTCdL0BYiPBgrBxxX6IfXvtCnuu6
	MzSsd/TPOdt0rUb/zbq3RLKCbvv/+RIqJ+bSeyverUCzgjtPtU31ud2Y80X8fyeS29W0b8Jz2XM
	Qgu2EcXdQcgLOxoMNLiwFvlOO0Ohj3n9ZvecMXVH0dNyDmJ3Zr2En1cBesAUy8H2QQzlONOjQrJ
	zFZkGhBEZNW4SqKlz1DWH5zA==
X-Received: by 2002:a05:620a:318d:b0:8ca:3c67:891a with SMTP id af79cd13be357-8cbc8e0515cmr303454985a.52.1772196697812;
        Fri, 27 Feb 2026 04:51:37 -0800 (PST)
Received: from localhost ([2603:7000:c00:3a00:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf68b014sm472521085a.21.2026.02.27.04.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 04:51:36 -0800 (PST)
Date: Fri, 27 Feb 2026 07:51:33 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Hao Li <hao.li@linux.dev>
Cc: mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	vbabka@suse.cz, harry.yoo@oracle.com, muchun.song@linux.dev,
	akpm@linux-foundation.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] memcg: fix slab accounting in refill_obj_stock() trylock
 path
Message-ID: <aaGTVWumz4jYEx9L@cmpxchg.org>
References: <20260226115145.62903-1-hao.li@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226115145.62903-1-hao.li@linux.dev>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-219955-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,cmpxchg.org:mid,cmpxchg.org:dkim,cmpxchg.org:email]
X-Rspamd-Queue-Id: 936B51B7602
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 07:51:37PM +0800, Hao Li wrote:
> In the trylock path of refill_obj_stock(), mod_objcg_mlstate() should
> use the real alloc/free bytes (i.e., nr_acct) for accounting, rather
> than nr_bytes.
> 
> Fixes: 200577f69f29 ("memcg: objcg stock trylock without irq disabling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hao Li <hao.li@linux.dev>

Oops. Yes, I suppose the contended case is quite rare (this is CPU
local), so I'm not surprised this went unnoticed for so long.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

