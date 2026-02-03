Return-Path: <stable+bounces-213162-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oA/oA3hqgWmwGAMAu9opvQ
	(envelope-from <stable+bounces-213162-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 04:24:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60121D4183
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 04:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBC7A304A665
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 03:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414922F25E4;
	Tue,  3 Feb 2026 03:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNVfBLEi"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23232E972B
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 03:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770089027; cv=none; b=cEcvKCOEfKDYQuHLhqajHk1+NLYgOAryxQvFulL0Plby3oCA1cm45+4f9svLV+Ueu3BoPH790+mcdMzR2OGyFUGXPGCv+JbtE58BDfIHcUWgL0avGw6t5JdUo+KLcyYQIRWEj6YyVCtT1AH48XMBZrngr0Ohm3qDKuVPZMX772Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770089027; c=relaxed/simple;
	bh=6ElrO55Og8Plmd9KRwBV3wRAIZ/+Foks3OuMDg0VN+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cH3ePYB3LCT7zYsE5XZDHmZjHAIvKBJROrpKtyqH3wvccpmdTBDf5Q/kG+J1P6/UZFVppCvFJ2CkFNFcQSYJn6+nQM78tpuhdsvoL653v+tZJWiDzgVKrDZehQr+SjkFn4wcqre/wqNmQtffolSpmlo5qZNdEIp1q6W76omfz9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNVfBLEi; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-66106a2f8d1so3590927eaf.1
        for <stable@vger.kernel.org>; Mon, 02 Feb 2026 19:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770089024; x=1770693824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqF7j9+NtH77eRf3A06joazi3wU3U3ry+bHbamRYbTw=;
        b=XNVfBLEixbkKJIJzIk5pXKUwtULH1mXcq7UnQildgnUNaEyuXH0A7Ok9FkUpoGehFg
         rZTWGNxNz2QrB92CWDhCnizc9LduwZWpatBr2VnyLQWXcYLriNkqU1UMtwpVe2UZSQFf
         0cl5EWo/b4ZlZJME006eHISnbiRZi2LUUWHKS8Ej5Gep6EXT+coFFIkFAU5dTpZhVEch
         bWblzYDyFj9fpVLcL0FUoeFErJVinWVGzSXeSFhiN0JLTP5D3wt1yTSiqZu27Er9F3il
         tPlBilaKWToQUH1RA6KGlQnsTVHvzXkJ4YcI6VOhk0ZmifQan+753IilNButHfg7yFvV
         Gw8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770089024; x=1770693824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yqF7j9+NtH77eRf3A06joazi3wU3U3ry+bHbamRYbTw=;
        b=jGd1b1Xdi77JKn0n95FljfqL97CEKNQIovxjfyOJ12YcBseX37HCqvrmFkZuF2KJBc
         WDemVEQ6Bu2W9JwCCxS/Lm3ucem0xoYmddzDgjHrDqrB39Dov7eA76isQh2XNKXjDDGF
         YJZB2BmJrdqt5rHc36/zxNQ/sfsEMOSpTce/xhTpYJLFbYyf1Qf2K5lUvvrFugsl0Dyw
         Bgx9/xxRZcMdl8El/OsMTDATCJuLu3aVcS5a+pEBF2ODx21Xrb6KKdFg6N2cdO5z8BzU
         E42yfLVWJ6S0yBUmk0AGQjsJ2oStA5W55RleBnmR2YWuYq3WrRX6zRLwNFnBSG8w4PDp
         jCTA==
X-Forwarded-Encrypted: i=1; AJvYcCXflFXh7h8+lgLbQkTstaSZvWgVw7H+7qVmie1gc6+j7XQQyqmZjspxHEQ/QK0OeRkTl6CdUOY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+16NAGMSLLMsaa/70Wjrlev4QyCbsEzQ4ENTiM9CQ++n8be7a
	M3tRMBc/0q29Toe6DsdYBNj7Msl+zz5gYlZEmSqHflrekdM3alUqLYYK
X-Gm-Gg: AZuq6aLJA39apiRdV7NvxcjfBtQYhPYYH7RaIL8iLtYtQEsi6HkbkhOgW/MbTHHSBWy
	d1S1DeMp7cMKKHh+hEI7TPQKMgr5NG8fGn5Ign8kzueyKTk+FGOWH9cryoOsACEStZvmEfKn5HJ
	ek5tPnqjHrnegvgXGkC4jwTE6u2NflSXqw/FsAdjxf7FrE0yfSV/ZAC7uLkm7XXLBdU2dIDVhNR
	yrY52YiTuwojPmkX0aUxnULkP2mCxXD1TEVefqFpBgn8520zMiAuiESM7R7QCj2ZUoevncHvJs4
	0vma5mXIBmpiFd0gCx3wY8TAgtgdeXgelqz8geGaWWDj5cXnCNCSg+weq09NvKBzd5M8yED+Btz
	RdbBRstdHoG5KlhKTLgFPdhss46FvI7pIPBRgmpFr+HVuzzPZRFBbq5lll4Ntu6liBSUU2PXNb3
	bEl1bemXx4nA==
X-Received: by 2002:a05:6820:1528:b0:662:c161:206e with SMTP id 006d021491bc7-6630f3cdb13mr5166424eaf.82.1770089024432;
        Mon, 02 Feb 2026 19:23:44 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:40::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4095717052bsm12915115fac.8.2026.02.02.19.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 19:23:43 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Wupeng Ma <mawupeng1@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2] mm/hugetlb: Restore failed global reservations to subpool
Date: Mon,  2 Feb 2026 19:23:40 -0800
Message-ID: <20260203032340.1861093-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260202183918.057dac34b3a1819328814fc9@linux-foundation.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-213162-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:email]
X-Rspamd-Queue-Id: 60121D4183
X-Rspamd-Action: no action

On Mon, 2 Feb 2026 18:39:18 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Wed, 21 Jan 2026 09:47:54 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> > On Fri, 16 Jan 2026 15:40:36 -0500 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
> > 
> > > Commit a833a693a490 ("mm: hugetlb: fix incorrect fallback for subpool")
> > > fixed an underflow error for hstate->resv_huge_pages caused by
> > > incorrectly attributing globally requested pages to the subpool's
> > > reservation.
> > > 
> > > Unfortunately, this fix also introduced the opposite problem, which would
> > > leave spool->used_hpages elevated if the globally requested pages could
> > > not be acquired. This is because while a subpool's reserve pages only
> > > accounts for what is requested and allocated from the subpool, its
> > > "used" counter keeps track of what is consumed in total, both from the
> > > subpool and globally. Thus, we need to adjust spool->used_hpages in the
> > > other direction, and make sure that globally requested pages are
> > > uncharged from the subpool's used counter.
> > > 
> > > ...
> > > 
> > > Fixes: a833a693a490 ("mm: hugetlb: fix incorrect fallback for subpool")
> > > Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> > > Cc: stable@vger.kernel.org
> > 
> > This (simple, cc:stable) patch presently has no reviews, if someone
> > could please be so kind.
> 
> Oh.
> 
> Joshua, it's unclear from the changelog - what are the userspace-visible
> effects of the bug?

Hello Andrew,

Sorry about that, I definitely could have been more explicit with the
userspace behavior. What ends up happening is that the subpool will
imagine that all of its hugeTLB pages are consumed, so it will be
unable to service allocations trying to get hugeTLB pages from it,
despite none of the hugeTLB pages in the system really being used.

Maybe we can reword the following block:

> > > Repeating this process will ultimately render the subpool unable to
> > > allocate any hugepages, since it believes that it is using the maximum
> > > number of hugepages that the subpool has been allotted.

Into this block, to make it more explicit?

With each failed allocation attempt incrementing the used counter, the
subpool eventually reaches a point where its used counter equals its
max counter. At that point, any future allocations that try to allocate
hugeTLB pages from the subpool will fail, despite the subpool not having
any of its hugeTLB pages consumed by any user.

Once this happens, there is no way to make the subpool usable again,
since there is no way to decrement the used counter as no process
is really consuming the hugeTLB pages.


I hope this makes it a bit more clear, and please let me know if there is
anything else I can do! I hope you have a great evening,

Joshua

