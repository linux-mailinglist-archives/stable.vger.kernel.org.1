Return-Path: <stable+bounces-267806-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4itbCIOaOWoovgcAu9opvQ
	(envelope-from <stable+bounces-267806-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 22:26:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C726B2413
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 22:26:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cmpxchg.org header.s=google header.b=e00fEzYd;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267806-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267806-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=cmpxchg.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE485304E6EF
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 20:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC9B34CFDD;
	Mon, 22 Jun 2026 20:23:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DC534CFC3
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 20:23:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782159833; cv=none; b=Is0oN9o8wHneRf1VUCL2m1Y3BF3hSfYYq3tgewe65DCtWBkrbEzmvZseNRDDQwxi11/ri6+oBghLUaU4FBUatF/GXtVlmMg/FY38jHnnAT4+qPmck0qu25hXVqIg1NBHUiKfXZYNpXSqQ+10zpYfjpaA0SPwEfVgMpStkcgwbP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782159833; c=relaxed/simple;
	bh=L7H2ibsXc8PoK8CbMSVQjpP3esUP2noyWgkyHLN4J0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=owPP8rFOF/S4KNP8bfAnwoW1mrbwajWKqA2Zce9P+6QeXYdmCj8+sXMDmTpShluWu5ENgY44P6Vi2h0kEyGpMoc0PO/SRpbNNjca1C0+zYJunOk3Bl+n6ztpUl+fErIypUcOu1FOOllfd8dxblVAtZ7/y+qwjvTqVnRRA7+Ami4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=e00fEzYd; arc=none smtp.client-ip=209.85.219.43
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8dcd895a4c0so57517056d6.3
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 13:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1782159829; x=1782764629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DmKAzXUWgr5Z6Z1mBVW0DXpsiSegxpV2RCsb4MGdO1I=;
        b=e00fEzYdm3eKKkSjXGKsOE3t+yVBkHwDQ3dhgoj4BlE/cyobHqlXyVvQBAwYSTdxXy
         5a8R5TxzHXSr7LO9ZJXULz3/W8FMmG6bUI1RryaOTXQaSeAW0Kyg15HdOdoKTrvjNnlA
         Dz1O+JuNNTjwzENemuE50HWUh3/kpslePtQ4RZnV0wb9d3CKgF6wTIPuz9TrmrcgBtZQ
         4MAGe5AUSd6kBuDwlvpNzOUFAZtXuCzbifmPxrZYh2lsSXtfwtmzU0n1oSoDppTr/VJ6
         1S0GPmgWAQ8X/c8IJfO+sLUJZQ5TFyqJ6ApX4TkHFl9Mu5ZVd/67u4GEeBI0EPn3qCbY
         9pew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782159829; x=1782764629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DmKAzXUWgr5Z6Z1mBVW0DXpsiSegxpV2RCsb4MGdO1I=;
        b=i69neRCuW+CS1S+rZ636+7/07PY1RnvZYeIWajJ7BOmNizPDGT2b6ufLSfD/k1aq5L
         Q2Yn7vCq4MBADo7asqlGSBoHuy4DX4wxHs4Y6yRsobaONc8wIb+/N4oLqZtSTuR/talK
         745RjeSSMWckyMqyPju+13XwrySYbntSy2nDwX05nadFYrAyWUwRYPiO3sydNU+Quqek
         oqxpDyDe5xuYYfBjZTBRPKIH3tr8u2XkTCJnmjtAlxlnRdDqj4AvHi8HbjIcD5eLWjjk
         Sr/FZ4UtvT1x9sJNGNVu/HlUcNCTc8d0ljxM9O5mD3HbGyrP1H8x4b7UixhcOV3I8ua/
         p9Hg==
X-Forwarded-Encrypted: i=1; AHgh+RrcnJDdf4rK53SZTesHTDZ+u58FnY5MmhJbulp9VYxCkpS5wKwNcg6JYFbs63h4rUVmTtdUO4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKqW+yotysNAc7u+7wzTJaoJ1SK8OQidFDTgQjTIl5FJ/xooJd
	0XeF5oWFh5dvjNnuNgP7xf+nMyz7KbuTCm8LuexDElPmINm8XFFTRM7l9oIsbBhXihM=
X-Gm-Gg: AfdE7cnupZukiTEyg89+BIkz3NBBriX6yfXtnvUTdHpIlGyUAiHRE9yU1hg3YM2nLWE
	94DUHx3E6a5VTYZX5EqBHRCEvd8ZajfbiBqSIVl2urWU3tdaqkjjch6OgWg9m50HwgocXgluFc9
	/alIncEjcl9phqMBcKR3CbmSGTcvMVfYjU7NM+YMtfRDzjn6Q44FX4OORZryIClMN1x17TWh4Px
	KwJUCdEoj0OvxTmupatO8UbbtezeJgl8BpLAUXeqst8cOyvMFc/cRNoLd3cUvU4jJS970IG7Gtg
	TeYw4Yv55fTt5BCntiH0Q++j9Bd07Op4NqsOjZiE2rNhDaYMoTaTgPALweOb8hn39JSxX0AgW7D
	4W6Wphsr2XfAVrXfVM6432DfFC1lCZAKMSp81Y8lGSHEQe19NNcBLasAN0BRgpcqCMCY9KW6Hl5
	iNh6D+GXPQGHg=
X-Received: by 2002:a05:6214:3314:b0:8c9:cb98:5fb1 with SMTP id 6a1803df08f44-8de3f78e4f3mr241102106d6.12.1782159829411;
        Mon, 22 Jun 2026 13:23:49 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df81cde319sm105792376d6.31.2026.06.22.13.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 13:23:48 -0700 (PDT)
Date: Mon, 22 Jun 2026 16:23:44 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH hotfix] mm/compaction: handle free_pages_prepare()
 properly in compaction_free()
Message-ID: <ajmZ0IPORONQ_Vs4@cmpxchg.org>
References: <20260622-handle_free_pages_prepare_in_compaction_free-v1-1-fcf3b14abcf7@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622-handle_free_pages_prepare_in_compaction_free-v1-1-fcf3b14abcf7@nvidia.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267806-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:ziy@nvidia.com,m:akpm@linux-foundation.org,m:vbabka@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:jackmanb@google.com,m:baolin.wang@linux.alibaba.com,m:jiaqiyan@google.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[hannes@cmpxchg.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 89C726B2413

On Mon, Jun 22, 2026 at 11:30:42AM -0400, Zi Yan wrote:
> free_pages_prepare() can fail but compaction_free() does not handle the
> failure case. Failed pages should not be added back to cc->freepages for
> future use, since they can be either PageHWPoison or free_page_is_bad()
> and might cause data corruption.
> 
> Fixes: 733aea0b3a7bb ("mm/compaction: add support for >0 order folio memory compaction.")
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Cc: stable@vger.kernel.org

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

