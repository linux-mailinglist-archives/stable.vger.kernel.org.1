Return-Path: <stable+bounces-268929-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NvArOQqFPmq+HQkAu9opvQ
	(envelope-from <stable+bounces-268929-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 15:56:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A83F6CDBEC
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 15:56:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=YkkxJIrh;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268929-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268929-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B29B53015703
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 13:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A743F823C;
	Fri, 26 Jun 2026 13:56:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0D53F7AAB
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 13:56:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782482178; cv=none; b=Jht2cqRuqiHlYT+Yh6kKzq5OrRa/ub9oBVL/XeiltX7dZK0WA0sD+h5vyxTCHxVDuaFPP36YomTvMpbk5NTADFOmku/IXFLzuAiXtTJX8qX8sftkBWnsYFMVStLJVEsFfa/fRMEGo3haPCWJAF/Ll54cpOXd/Ul+QszDiJGZels=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782482178; c=relaxed/simple;
	bh=8YjLWx3uGgLTfeLy1uzKCPph1jBGv2rvv9gzx0Sr4DU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bv4O1CyF8ipyMVKyinxwtnVz6Z47yrji4nO21mPQh/Af4yQPzlZUGDaCmVSM2UwvdJHuK0TIs1siTTggnk0FN+VsOQ+NPDP+33CcxiEYnGze2w7QfB/2yrVMOTw59w+AJQKsScyaO7O+RwH2guD2T27Zbn4ole7oCaKV59FJUxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkkxJIrh; arc=none smtp.client-ip=209.85.210.49
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7e93cd4e64bso713076a34.2
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 06:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782482174; x=1783086974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3f5RmGjrL90PeH3JGsX34cT0iH3rBjCVdu823akYB8U=;
        b=YkkxJIrhmwIasBKM/f9cGBELgpIpZTNv76mCQPbObnKMydo5S3p8yu8z5ZRTewCLpv
         sbXXewgM+2uHawzAsfj1cVbN7SovNd605HR9+pKdhCTdJ4lsQf2xPnGN3hhle6jv0OZd
         tjjWDG9q/UVvzrkNPdZ8aVVIYRhKT/cf/5jAfmA53Uc6dS5KYZzcha9jM7CTvR52BSeb
         o/HWOkXuTHbmLuxQIAwvCT2lW2jIaSNB+KokB+3qHyjtguqBKHbnGLiGXBgKq5LXHJDp
         PyBX1OwbzCxgdqLuRLqGR1o41bH0Kt7Jelic93D/UVpfwHJ8qNQiaKpwiTqY7tbX2bcM
         Mb6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782482174; x=1783086974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3f5RmGjrL90PeH3JGsX34cT0iH3rBjCVdu823akYB8U=;
        b=l7IqiL5ekcVx+SA7WOOrE3x0cnh8E3TF+fNPr+5lzakHiAC3df1mcYBEwAClURtHxI
         dxGIOgBHuCMAalxKaTscvx0dq7QyAyltC8Kpme1ALQQfgaJUXxNpa0raYeE2rpcYA82d
         9Fh1IMSHdAej5lM5CSN8+eMW5hvEEPfTcc91ULzFOxHkWslppNQ8awQDnrJsxCcvTNSr
         muURD0ayoXmlSy/TtuN2WlW1hyAa5k8gb4rcdHmPfGcx3NC7g1DBgbYC9NW44vMlCrSQ
         v3wut2w5pLyDob01xAx5Qt9CLaWD7dzPPHt5h/E07dw5wM3xPig03q4uIX6lPoS1wCmO
         8p3g==
X-Forwarded-Encrypted: i=1; AFNElJ9PBrtGbG4gBcCcCQr6LUBE426SAibL+tKqQOuRveUcql8uzwTnW1pphUk8WiB1xPp5n/a7Gng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz86wq3UeVTt6tyxp1zsUpjjK5KeWObf6ZbSQB5DhM2F0r+ARAs
	F8RDF4sY7PL6C2eglhNXhBIThaG6GZm+BeXnAf0j5cmO80HyDagiTwua
X-Gm-Gg: AfdE7cmMT0P8LO/p8Dz0gY35JmPlC7NyAZ198xbDWyg3X5zQnXNRSYf4lvSKs1LUVr0
	P6zRFniTw5qFetBTty/XS0tRp55f3ocPtnbXtYLBmefDz0UurVPXGlbHfwwDLmasNV0Ajg7f3/W
	KOcHDB4d1IZcZ1Qkxwh8dqcAwaVYoHKlHxKqSYonmu1uNOxBz+3FSTomJxyufyrefh3Z39KGx0I
	qgZz2VqfQ1cf6mnOiZM+RbhWv9KlM92693CwukrzWuBJmzFYpP3uBuWg8lbbICW6SB9486Lnyo7
	2E1qLPr/AnJQhXXfT8wEey5+0yAS3C0YmsbPWOENWpIkFI1ZP/0bV0C5pl8vimbSBh4uSQKJYgW
	dP+R8xf+SwAiplx6iLLxplFmez5VGdwofkPULp/Hsff9nAp5OkfVpiMKXhPqiHr6zvyE99enRgr
	yQBEqj8uvAtMVrI/PjYYBZM+sYWWysbZ8mGuPsJY58yJGLynzpFIXdJw==
X-Received: by 2002:a05:6820:190c:b0:69d:f889:f55c with SMTP id 006d021491bc7-6a135208f39mr5607866eaf.27.1782482174366;
        Fri, 26 Jun 2026 06:56:14 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:40::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44748ec8a42sm12948931fac.3.2026.06.26.06.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 06:56:13 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm: memcg: initialize *locked in memcg1_oom_prepare() stub
Date: Fri, 26 Jun 2026 06:56:11 -0700
Message-ID: <20260626135612.3697893-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626-memcg-oom-uninit-locked-v1-1-a00175936b39@debian.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-268929-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:mhocko@suse.com,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[joshuahahnjy@gmail.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4A83F6CDBEC

Hi Breno, I hope you are doing well : -)
Woah, thank you for finding and fixing this bug! 

> Fixes: e93d4166b40a ("mm: memcg: put cgroup v1-specific code under a config option")
> Cc: stable@vger.kernel.org
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  mm/memcontrol-v1.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
> index f92f81108d5ed..4fa6e2bc8413f 100644
> --- a/mm/memcontrol-v1.h
> +++ b/mm/memcontrol-v1.h
> @@ -107,7 +107,11 @@ static inline void memcg1_remove_from_trees(struct mem_cgroup *memcg) {}
>  static inline void memcg1_soft_limit_reset(struct mem_cgroup *memcg) {}
>  static inline void memcg1_css_offline(struct mem_cgroup *memcg) {}
>  
> -static inline bool memcg1_oom_prepare(struct mem_cgroup *memcg, bool *locked) { return true; }
> +static inline bool memcg1_oom_prepare(struct mem_cgroup *memcg, bool *locked)
> +{
> +	*locked = false;
> +	return true;
> +}
>  static inline void memcg1_oom_finish(struct mem_cgroup *memcg, bool locked) {}
>  static inline void memcg1_oom_recover(struct mem_cgroup *memcg) {}

Part of me wonders if we should just initialize locked = false in the
caller (mem_cgroup_oom) as to not make the stub have side effects,
but your chnage looks correct and this is a fix so perhaps that is
not so important.

Looks good to me! Thank you again Breno : -)

Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>

