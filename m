Return-Path: <stable+bounces-230269-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOkNIqp7w2l6rAQAu9opvQ
	(envelope-from <stable+bounces-230269-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 07:07:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D90CC32010B
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 07:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08744301F9A2
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 06:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A543346AF;
	Wed, 25 Mar 2026 06:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMulB5CF"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14F3218E91
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 06:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774418852; cv=pass; b=OoZBKf3bROVZpacadEFDqjmIt/9TPrWQ+vm14sVNDqFYfCHWqlEp3zp6owZlAg7Qu6MhJlRiSOvyIMLndKy/JRqgoBa310RGBh1+f42ahdza2NoCgRQJjcp0pN2GW72w0MYcvFCXx+6zyc1HnlzoYDL35ZyCETHNP5JVEnfo6lE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774418852; c=relaxed/simple;
	bh=Zq8+G9VWqChM2gZ2bLHX8mxlCNbZQcnWNan/IlCfO8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E9O9uBfpV3bLNZseDgI/PkJcbPPOtWp+xn3uNzoomT/DEC2R82SBedwUSlNOadV22BIyfSSgh/wPbmkwi609w/uSbEjffSVO5s5YoY9rNT4JqZanVk9LgWIHHcoR8xJNub3l90qWrnwddsZcrtL6JahEYnKna+3668/ROtsslYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MMulB5CF; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1274204434bso415165c88.1
        for <stable@vger.kernel.org>; Tue, 24 Mar 2026 23:07:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774418851; cv=none;
        d=google.com; s=arc-20240605;
        b=gFIEoIYgI6/YP9skQ3zO/HyaZM85Iex8Zeo5Jjzr7hNkEN6f3v0PNXy/SRclO8HQ+K
         TmjyD7fqwlHC4yAuJCpCuH5wxhOC9C4RJwPx6NtokyRt3kCsaqN/XOBo0mNtHf5LfRFG
         ZLlJXPxH54VcAbNAI9JlAOt9zOiGxFNZc/VZiBiouX79C83tyM0UHfU1v1KYtT7IXv/7
         DT8AX8OgGb2TP43Wm3/ighDiG7qQmNfEWZGnvNMUI7QBQAcp/3vSOws81jz6+6q9vt+R
         oy4tmB50m5aFrbzNTGon5X+WQKO17lxoo4lJfNPnQUP9RTupT6zDS+oZWsHHfGBYgH41
         yQ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KtCjk7jIGe8HtkgOl+H4cw5it+c5WJ0CClrVvqXmnPw=;
        fh=E57XBg1CnNskgki3vSJj12X3x2q1sWxAbSSDp7Uawyw=;
        b=OcL6L+Dl3ab4OW2ofE/aBkEeV4z+qljibFg8lph2O3g7QWL0FNjuweFtq9LXe2z559
         JIkYs930mT5lZAuPyTujnceQmLhM8/p2DM/R8qbUW3NcCPMwlRnwmVOWsLKY1GTX+zxi
         7DGodcT/h1eyFYYdqr8U1xqOBLeKxP7v0WPdfyeS80LlRy9rRUr9BY+Xlbf2ou7+I9Ma
         3RjlD23vkCPmkJFARUaFtSHk2uXE6ag+L8oBv3Sz6hPSbuqSITkQK4jRrlkuwOlRH1ki
         tREPBEKCqe+Gq8qBqI/gKV90NrxHqWZgeNwKWTac4ZeCRuWF8dFPhC4vC0da1fFDcCR+
         gfVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774418851; x=1775023651; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KtCjk7jIGe8HtkgOl+H4cw5it+c5WJ0CClrVvqXmnPw=;
        b=MMulB5CF2laNTdYM+YOQI1DnHSj46ooZyV2DTOQimaBnPW2ZrUHgiKIQM/WlR3TCmP
         GfeOnaI4y1K5fq9GrO1QEYdVuKfgx9vbj5v/ZZ6oetn2cF+ClUhCNEtFF+OKN6tBT3CY
         gEkkTqm0v0cJJjTW5GnJDLxXZlFdDKPmPGG0tVNcnAVqabPFX5wZRHj/36DXK0K1ccc9
         pcqSNYLYbrAqu+PN6CLHEsPyujjToRnm/HzatQgR6FJw3BJJkSOhahK5bRgEBY7b92gl
         kDjG0RUfchNHmt7ykOLGGKZPoOVFMr9Xc5qg5esgXyyiC8mMhGY4aNGBzb8x5mg01L0A
         73fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774418851; x=1775023651;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KtCjk7jIGe8HtkgOl+H4cw5it+c5WJ0CClrVvqXmnPw=;
        b=m+FBU9ALotCuRp9PE95XEhLaKzOdLRleXKmy5UsieG5aB2ntnNBxk1cQmYK+D2Qxsi
         NNTxzYbiwmsg8658PGHnIZ1t6Hs+a8FRkn4OCkzAL10LOeNwifRw1QJSSH3rjgBGvdEt
         CNBlbchUOW3i6OdotkaptfUU2tVA70r3bIWKPES20YqxCbE5qyaasTquIID5kbUEw2eX
         NcPz6pPJZZZJ6PemvsUxXWefz2EGxkbMObAVqoPaFJeM8sUYsy/mqtGmbhyxdsJe0BPg
         AxBQUQmhj6J1vRGy5VIB4U7mefz5QR9u+Bx9JxbmGNdwSRFwV5mbk63aEICCCCeJMO4i
         XL0A==
X-Forwarded-Encrypted: i=1; AJvYcCWjv71c99vtk+r3bWRHncnDFERnY8wcRPyLA9OxpjLWt9kf1aSvP8JL0jG9krirHXis+q5LA9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8tBPNtMIMXVTb1YpNXsuykrUd1xTBODayg2Vn4z2qrZqRftLw
	6zu1QQbdNJiT3sliCS8pimcjvRxhymiewFjl2HUjkq6ASqAsT8eFxdTxHZFZFZnbkDLIDQ1wK0Y
	80Q4oNI4V0OqZaHps98vI4VeEJhEi/QA=
X-Gm-Gg: ATEYQzxQ38EifREc7B9LO/qyZMi1VBSlBxpwNhj90/l+xhvgkFXLbBYv02ZA5ttUcRC
	W+N9Pd/EA/7QhINjsMFW7k5FMu6mCvkA5HD3jhgFpl++BiWoRvEzkiZ6DqSbpQukdNEpE6i2YYy
	3OcFjdX6Uh76lYxSJGlfnFjUWtLK8VD0kSJCyhXUumPWa35r9NhYPDSFp9wwVK/Y0vAtAQPfdS+
	40CZVq160yfaqe+iSLs565Dc3dZwXegzzz0c0T3/LdC6Gvs0MkH4f48czuYYeqdJ4g9gBeNhjIN
	lXwVUX4Nng==
X-Received: by 2002:a05:7022:418b:b0:127:38a9:5abd with SMTP id
 a92af1059eb24-12a8e12779amr2781669c88.12.1774418850537; Tue, 24 Mar 2026
 23:07:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324170311.dc5b54fe0765f2e680e3cc90@linux-foundation.org> <20260325010618.85366-1-sj@kernel.org>
In-Reply-To: <20260325010618.85366-1-sj@kernel.org>
From: Jianhui Zhou <jianhuizzzzz@gmail.com>
Date: Wed, 25 Mar 2026 14:07:19 +0800
X-Gm-Features: AQROBzDgekBiTRh3Wyt5V3QjVPaGatJnjSIYcCimGVtb7zNwBX34hEmD52gmYHc
Message-ID: <CAEgWzV5vp7bfr8=W6aVXNBFqxd9nVc-BGtG1jFUXJ_-+WWmPPg@mail.gmail.com>
Subject: Re: [PATCH v4] mm/userfaultfd: fix hugetlb fault mutex hash calculation
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, jane.chu@oracle.com, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, Peter Xu <peterx@redhat.com>, 
	Andrea Arcangeli <aarcange@redhat.com>, Mike Kravetz <mike.kravetz@oracle.com>, 
	Hugh Dickins <hughd@google.com>, Sidhartha Kumar <sidhartha.kumar@oracle.com>, 
	Jonas Zhou <jonaszhou@zhaoxin.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, syzbot+f525fd79634858f478e7@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230269-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jianhuizzzzz@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,f525fd79634858f478e7];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D90CC32010B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 25, 2026 at 01:06:00AM +0000, SeongJae Park wrote:
> Seems userfaulfd.c is the only caller of the new helper function.  Why don't
> you define the function in userfaultfd.c ?
I kept hugetlb_linear_page_index() in include/linux/hugetlb.h because
this is hugetlb-specific logic, not userfaultfd-specific logic.

The goal was simply to avoid open-coding the hugetlb index conversion
outside hugetlb code and to make the unit change explicit at the call site.

