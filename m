Return-Path: <stable+bounces-227929-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGqZFlkIwWmtPwQAu9opvQ
	(envelope-from <stable+bounces-227929-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 10:31:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D84182EF1A1
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 10:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3FD4301A931
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 09:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E7F2FE056;
	Mon, 23 Mar 2026 09:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IBZ7NrQ4"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F68313AD05
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 09:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774258190; cv=none; b=I/cxvdg+g3jQM/GW7iqZHFGbbaOz0vX490XoJDLnzyWAsomiT2+qVkhfacgQO8MWezkq4dd1VP6jSAHxVBvPcZI1yAG1N65RIrbB3zYupu40JcSeMWn8vCB13safOk9DYAI4mehabyhAXlS8wLOX7CYFB+jtAjWwbeRRslNA0BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774258190; c=relaxed/simple;
	bh=L9ha+qebjDuvaJjyvQQ1qsys1Tyr5W+TeSi61Xg0Cmw=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=MidfQmLrmCi6ZjnlwJMb9BpDwPiCIO6Zv1dTzoEu/iZ8zqxtJ19JbtGcqkq5mTyye5zX8nvbOgO0tzOnryLndXCK7dT1v4yNgeUrX5/2fYrPRNzRU5bL5cDkVNtdJpDUOrg+EdOf07lkXk+oz6vmrAdqwUczpC5QhN1oSUKwwPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IBZ7NrQ4; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64ae222d978so4033215d50.1
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 02:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774258187; x=1774862987; darn=vger.kernel.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FDl7NWjENZ1t9QVlVJvW3GrxggXGGi4wt42t7kIc9bE=;
        b=IBZ7NrQ4NzbaL43e9zIjz1RXsz2NSnoAwZiCop8ObtmRvC+c1ZACUZLLvB/eK88ycu
         +XeqL1srDPWw7XXHdoUIyHmQbp53CXb8cDyg6Nub5KP8mwBVdFKbNPOIrqbmND3akWUJ
         114t0CBLsyVQfb27hRYrV6wBeJvk9xG6hYLGyCTrHj1te6vL1DFSj8HA4i/X7rZ7g622
         6IQCbBjXloSZBnCdqfivbpFOBS+6sDybyRXaBx7mdZJow12my5iPvUsyRAfHjfmYm4DQ
         R6Q+pjkoIn6G5DkbmA7H3VHcBrUcfwLkprtMOFp5PnFUnCPbhNm1tXqDWA36C9jRqQjz
         iUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774258187; x=1774862987;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FDl7NWjENZ1t9QVlVJvW3GrxggXGGi4wt42t7kIc9bE=;
        b=iQDd+AHvDrs8RfbmiBSa1NVjI9cGs8BeQrISu7f1ff6bjYL8Tmw3YGgI9Gkdda4tkj
         5RolnTYPb+TaC6eqv+yQ5KYcmJhF1TPznkDA4CUBX5voPKCDEbqyhfouLft9nvhjBtY+
         neL0R0UCsueMp6vKBf89uVE1xsxrWqguv+cleobSrjQj7iiRE7ZEEA1FTdjlmglCipug
         FEPeaRZCofQKZdIO8fHzSiZy5MDKcyjUv8Z0nhPtJ0CclSdiV0PcT8i98gLEf/roqP0w
         Djv80mJqm16ioqFmu54y/+DD2lgEVMFeIy4qT3Sg+AzzxqBiRVpj3ZKswU54Kduz0DHz
         gj4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWnkRY+hmiATGBo2D3u9QENAPrOk3n8PufsUnnsKn2ZB+EbJuAwLi08YgtHEFvUg5dUMd/5S+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6QKFRODWcFipwI1LZFt9+vFotHbvf2aka4JwvwZ5UP3fb4uYX
	98fUKtRhCskyLTEM+Lq4R/C6LH+i7SFr19Ucrv8yrDpQOEDfYk8w9m2J+Emfp/y8rw==
X-Gm-Gg: ATEYQzxzNhQ+ZXMy9AT2ssSnNrd5IptFds6M9P2yZn1ro3bl5OFc3ChCy7CUqu3C/yn
	JXUADHa7aLrEcN635GxXxCBHHL6yzwioO+KAlUBzjaor6dPf0zU0Ni+8kikg1FPQrCZJBN2h2gq
	fdJZ42Q20XEnOlgCk3GIR6/fieBBFBODPk+MiPrNCcazeKve2Mnp391UbqY+VUetuIOgn4rRW5a
	r56K+z7sGRnY5A35z2dOq+gGjBKVKDNS3JSnrNIAwgFOgZVIuZviViSvOy3H4Shnn9KknpSto8O
	rOfnTQdDsb83nt7Hb5DLVZER5qbgCwXijRLXf1lbz3tqwHTFXdHW0d18AiWcNz/YL6tJwZCcpRh
	ygxMMJCUPBNE8Zm4CqLjH+1vW93didmROOFC71QhI+fmC/K6f+K5+5KeQTxtTkW6B2ldT9Ywr2a
	sDWP+2e45H905zs7n+YOYGYv9g88M0R/WSElPgikBTXuHuCy3B3SVt2/VZLvhap8XViSgdebOVV
	0xvdDDi178=
X-Received: by 2002:a05:690c:6d81:b0:798:7ab2:eb6f with SMTP id 00721157ae682-79a90a8a954mr118996327b3.11.1774258186967;
        Mon, 23 Mar 2026 02:29:46 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a903fd41esm55901987b3.19.2026.03.23.02.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 02:29:45 -0700 (PDT)
Date: Mon, 23 Mar 2026 02:29:34 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: Andrew Morton <akpm@linux-foundation.org>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, Baoquan He <bhe@redhat.com>, 
    Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
    David Hildenbrand <david@kernel.org>, Dev Jain <dev.jain@arm.com>, 
    Greg Thelen <gthelen@google.com>, Guenter Roeck <groeck@google.com>, 
    Hugh Dickins <hughd@google.com>, Kairui Song <kasong@tencent.com>, 
    Kemeng Shi <shikemeng@huaweicloud.com>, Lance Yang <lance.yang@linux.dev>, 
    Matthew Wilcox <willy@infradead.org>, Nhat Pham <nphamcs@gmail.com>, 
    linux-mm@kvack.org, stable@vger.kernel.org
Subject: [PATCH 6.12.y 0/4] mm/shmem, swap: overdue shmem_swapin_folio()
 fixes
Message-ID: <a07eace6-82f2-32a8-0cbc-85972d4b1eee@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,linux.alibaba.com,redhat.com,kernel.org,arm.com,google.com,tencent.com,huaweicloud.com,linux.dev,infradead.org,gmail.com,kvack.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-227929-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hughd@google.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D84182EF1A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Greg Thelen (assisted by Gemini) has observed that 6.12.69 commit
a99f9a4669a0 ("mm/shmem, swap: fix race of truncate and swap entry split")
and its followup
dfc3ab6bd648 ("mm, shmem: prevent infinite loop on truncate race")
both rely on shmem_confirm_swap() to be returning int order or -1,
whereas in the 6.12.78-rc tree it is still returning bool 0 or 1.

Quite what the effect of that is, I've not tried to work out: luckily,
it's on an unlikely path which most of us find difficult to reproduce;
but better be fixed!

And applying the Stable-dep which made that change from bool to int order
reminds me of two "Cc stable" fixes from last year (and a followup fix to
one of them), which never got applied to the 6.12.y shmem_swapin_folio()
because of intervening mods.  Aside from minimizing the rejects, there
is little point in holding that "truncate and swap entry split" fix
without the more basic shmem swap order fixes found much earlier.

My own poor testing hit none of these issues: I hope others can verify.

1/4 mm: shmem: fix potential data corruption during shmem swapin
2/4 mm: shmem: avoid unpaired folio_unlock() in shmem_swapin_folio()
3/4 mm/shmem, swap: improve cached mTHP handling and fix potential hang
4/4 mm/shmem, swap: avoid redundant Xarray lookup during swapin

 mm/shmem.c | 97 ++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 80 insertions(+), 17 deletions(-)

Thanks,
Hugh

