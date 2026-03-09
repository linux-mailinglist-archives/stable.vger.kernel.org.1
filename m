Return-Path: <stable+bounces-223473-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAQ5K9ArrmkqAQIAu9opvQ
	(envelope-from <stable+bounces-223473-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 03:09:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F92A23325A
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 03:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92D3B300D729
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 02:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DF31FC7FB;
	Mon,  9 Mar 2026 02:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gij8bxaW"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417B3191F91
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 02:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773022143; cv=none; b=lk7nDsEobhAuByGBpgt3YbRhzwdHWpMzU1HP+TFNOwGNBYTbGYNsTgveHnsk+wsXP+IYjEXTFK56Gl5XSIT4vMdEIbHqLL6LNIZFNYwQp3n04JpFyBT35+5oVRgGFw1nJZ316BTBdCf4vT1HYcXEEwMqfOkshiPP7jktKRZW/HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773022143; c=relaxed/simple;
	bh=XnQmXd/6Na0l4V5WpJ/PK8yF/lmO2j/SmpVr+WhHrO8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nA8soXQAQ7sHs+AYOSCShKXDvV077sintRlXbLCHYydmcwTwNSm0CfqoPgjKMmNTC6QNlu78Vysia7EYVBGRPxYo54DEc/Kc0nNefEjhd2hke1epHNKYEadr9C+BOH7SCzQa2NaOjqP1t9I45ES8nGFvUDVPbod0ORIS0rQksUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gij8bxaW; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79901821bb0so633937b3.2
        for <stable@vger.kernel.org>; Sun, 08 Mar 2026 19:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773022141; x=1773626941; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R6//2ijlmMRzvlm6uQ16m8RLuSwott7gMXyhq9LM7gw=;
        b=Gij8bxaWuKUXWQiSH/S/vH7VwkKcz/Lpc30Q+Oq1LxzAyPt4qHcDMKa1nofPNp45cb
         FpW40MDUbHBCu4rNmBBTcgyYL8uSi3l4VnXXMWnfb5OCibyqOb2/d9Qe8OR7RolQbzNW
         0r3/0qY4lxwc819epiWPNmzA/A9FEH081kNEWVEFl17a3NI2eHw795Rh+xZ8ghih89Dx
         qRpEUa6of0SwpTumXWs32Q20p0fpNkj/adM1iAcNLXqPADas6FOZzH2BG2UaZmpm52BY
         CcIPk2MtvD2xi9/Y5SnrsNAD3yrDzVy4TBHZq+tgTJUKZD1ZX1DSQOSAgT/02eCQoJQO
         QLhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773022141; x=1773626941;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R6//2ijlmMRzvlm6uQ16m8RLuSwott7gMXyhq9LM7gw=;
        b=RTAps+swCDiq6YsWmvJHrrwZO66T/lJ3mDcmOWbRgnIodoIjPNolEcCqcuLr/m/fOt
         Idk2/WBKs1rm8bpKv7PCcebd5ieVcyhIB8zt0n1UTVI2kjXfsXiu+5SObJAUqwL2PUbU
         4RR2uBLzUouk5yMI/7cP3dgj8XFBOuT9dipE7Vxdum2G45Qg59CzIIvNXtIYNQyV6Z6H
         KmwzFQdP8WfPvHDXtyPKETzuzKZN36V+0FmP9hwADf0caTr/vRwDAzHwMrmi2Uw+6Wja
         07ghU2ymbZJb0SG+ea9zIXhgRBde005sMF4V8WP7X0WRl8SvqUBD5tsIb/bizo9BIzDW
         f5oQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlsvDKHq5uISVDU+1rDRHU6xY78wBg4U1aPCRBgjHTCxDHr2jwRoP5QK39MjaZ3Cd5WvIGSno=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVWjEFHkHhikRu7ApSyfsFEKEFv2YAwco7Io6M5dOIMBLIz9WG
	aauminsC8PcD8yK2n67ufEwK41wcGrwQjnSms336O2g3fEkmQg4SAbYmOAo8xzXhBYSAQTUM/KD
	UVSuj+g==
X-Gm-Gg: ATEYQzznRUwbhG2YPegLmhhAavWDGa+p75clK8GPr6rOvEFCBCQzSmy4mwZarjodia8
	6EMYWIjLFMHjB+qnA1iKgqukh9cer1z2YQ3S9HGTYj/xQnfmNg7Pj5izjVOaTh8Pkz3QtL3MXka
	3RKfeVYR5g4Yxudq9MwX/sUmPpBfq5bEPoGsW8PATQKPTgt3jttWwX4nonU2WOuG/HQ5zsRFaj6
	/42bVZ2KyD2jEq0525qZOdldOjNMU2VZAk+bWh6+yiYswl9yaFJQ2wp+Ei4OyA0X1Ew/kklAUzU
	iMvPLbDvDf9oEfToJ/o48cgWL1Slbk0r1nCErf9NCA6O1L1ParH0IH5HwWtgP5bkMfCC9NpkCKN
	yhIhvO0NUf3g3RefMHZIsLiQjeHiOye0ZdNwjn+sNMYP3ufDAGp4RMIju3bkAI2ArXcz1M3Regu
	QllwRlysBbHie7KUquuJU534cSi/GoocwcFXcyOsW9tmVoL5jN6sY4Yq+h3s4ammCCVofb/NaV0
	mWt
X-Received: by 2002:a05:690c:670c:b0:793:db81:f1dd with SMTP id 00721157ae682-798dd672d69mr99067567b3.4.1773022140970;
        Sun, 08 Mar 2026 19:09:00 -0700 (PDT)
Received: from [192.168.1.163] (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-798decec989sm38049157b3.16.2026.03.08.19.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 19:09:00 -0700 (PDT)
Date: Sun, 8 Mar 2026 19:08:46 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Jianhui Zhou <jianhuizzzzz@gmail.com>
cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
    Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
    David Hildenbrand <david@kernel.org>, Peter Xu <peterx@redhat.com>, 
    Andrea Arcangeli <aarcange@redhat.com>, 
    Mike Kravetz <mike.kravetz@oracle.com>, SeongJae Park <sj@kernel.org>, 
    Jonas Zhou <jonaszhou@zhaoxin.com>, 
    Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
    syzbot+f525fd79634858f478e7@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] mm/userfaultfd: fix hugetlb fault mutex hash
 calculation
In-Reply-To: <20260307143542.179953-1-jianhuizzzzz@gmail.com>
Message-ID: <ffc6106b-292b-d8d7-3c34-aebe4feb6e5f@google.com>
References: <20260306140332.171078-1-jianhuizzzzz@gmail.com> <20260307143542.179953-1-jianhuizzzzz@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 2F92A23325A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223473-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hughd@google.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.967];
	TAGGED_RCPT(0.00)[stable,f525fd79634858f478e7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Sat, 7 Mar 2026, Jianhui Zhou wrote:

> In mfill_atomic_hugetlb(), linear_page_index() is used to calculate the
> page index for hugetlb_fault_mutex_hash(). However, linear_page_index()
> returns the index in PAGE_SIZE units, while hugetlb_fault_mutex_hash()
> expects the index in huge page units (as calculated by
> vma_hugecache_offset()). This mismatch means that different addresses
> within the same huge page can produce different hash values, leading to
> the use of different mutexes for the same huge page. This can cause
> races between faulting threads, which can corrupt the reservation map
> and trigger the BUG_ON in resv_map_release().
> 
> Fix this by replacing linear_page_index() with vma_hugecache_offset()
> and applying huge_page_mask() to align the address properly. To make
> vma_hugecache_offset() available outside of mm/hugetlb.c, move it to
> include/linux/hugetlb.h as a static inline function.
> 
> Fixes: 60d4d2d2b40e ("userfaultfd: hugetlbfs: add __mcopy_atomic_hugetlb for huge page UFFDIO_COPY")

I have not thought it through, nor checked (someone else please do so
before this might reach stable trees); but I believe it's very likely
that that Fixes attribution to a 4.11 commit is wrong - more likely 6.7's
a08c7193e4f1 ("mm/filemap: remove hugetlb special casing in filemap.c").

Hugh

