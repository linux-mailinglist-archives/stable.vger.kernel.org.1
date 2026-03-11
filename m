Return-Path: <stable+bounces-224671-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNADDppJsWlCtAIAu9opvQ
	(envelope-from <stable+bounces-224671-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 11:53:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A68AE262995
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 11:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D4DE3069DEC
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 10:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4223D47BE;
	Wed, 11 Mar 2026 10:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2Y7wt6d"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF923D4133
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 10:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773226386; cv=pass; b=Fjds31KQr2S6CH/VgzbsAzpry9p9vlRu/3rTNTSm7T6tYtrDVpCQ3ql0eP78yZ9yzsQ7wSlazPAGrKdT0y2I/7Q7QD4URuxbJfSvURk/46cgnZPN/ydI+ADILlGziXnyxogAG5n69XE9TvEtKZB89Tj04Ej0Tyd91Ni9wAHcIrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773226386; c=relaxed/simple;
	bh=vH83CfD6b+fPIElw8HYZ+7tqfBABuR1WL3xdEB6i9q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dvImClautUBAgNWuvLsoyktrMrMnIu9TpkGPoMZqsAnhnwKUyQGsGaWDpApxDpmt0oN74M/9sxqzFtVqFiPwH9mJQmx9hC9i9o4KBAPUqqMJdVVjW3aoborI/UCaGb/yoF5lqvtOVnQok9r1jqpUjRuAZakeaYDUHMllkxk3hq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2Y7wt6d; arc=pass smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2be19f05d7dso274807eec.1
        for <stable@vger.kernel.org>; Wed, 11 Mar 2026 03:53:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773226383; cv=none;
        d=google.com; s=arc-20240605;
        b=kA/DglpsqVsxm95PHzxr60mdBCtAniKOLfi5HWRyzSScOH3i9/qrjn8Q5CWpI5LSjl
         H5XCZy8kgK3dRlswx2loRWrq1dF4h+0OwrQ9N3ktgIboEes3ncFsHvSSJSaggUqMFeWf
         mUvlDrSQr1fQ3+Ljj6DDK7HVqAEHTjHBCMcixVvsMB3bicUaYuLfYD8LIvKShmfuXKIT
         hwplmPf33CunSSLFTVHbiqtt22QqFDEexAaeeb6YutyfZ8osGxukVE/JhYb5GIs5csU0
         WFlAsUYpQJH84DmwNk4+qTR/z++AdEI8n1Bcdw4x05Xtro1YkmrA0BB068m26SOHFj5G
         sqzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gTw5419sO+ZQt/ZQu5o3TXcHUiN5SVxEL8bwcCKa16Y=;
        fh=/w92ClHJ+KIRnv36ecldmXRx/8s+ZazvfmdGHM7DDNQ=;
        b=fwJ8u95xfUHyWc03/SkGnH7nItShvj1Yk+YgyB4bE+TVAQvlXXIii7adusviugGodD
         fXd8I/PwnRu9bp5SGk1Eerzke4K0/xl1w+lcb2Gb9MFGPggfiodcsNvcFLBwHHXvKfps
         okJQszE0wDyYVGBJSYDnmW3/7eeeojNtBhvkLTnzZ69ME9FXFv2T2oLY0b/mRCntGwEw
         55ZIg9FcqyDYdp3rYndKKRvLU9PKRQWp9MAARgxjHIY6u5uZs0zN8sUkI/y0rL+zB3SM
         Gk8oyTBUOoFiWBDgOMF6HC8jKNaaD+cxtfE5wUHL6UsUeAhuUCnTaMhx8obGpCd0evHY
         VzAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773226383; x=1773831183; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gTw5419sO+ZQt/ZQu5o3TXcHUiN5SVxEL8bwcCKa16Y=;
        b=M2Y7wt6dzkFgNEdHyLzuXlTts8XW7hHUaFR4fBrJlRbQV76WBU0fxBy3ZYBG2HCzQR
         YTl7T+WsIxT4kZekn4uraW6lJAyqenhT18Ycya3wJfpR8YAXYg/XG3+PjGZ4vURrxuBv
         oS3wcUQmmRKx34qb8ZprFrLV/eacRk1C21ZhWR/xLIzguV/Z3Y++njwKSEa1ujqOZ8ws
         fPlcIAtJdFVwPCxGEK4hquprh2mPg5X2mbLjzK3sDbxAVCiAMSzz7jAQOusFJ98x3b96
         Vy7T9ZmXfBsveY3f3JuPmz574sZHUln/eIbcfW8pbpCt+d69GoYP2byo2t/eIWtfMEHv
         Lm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773226383; x=1773831183;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTw5419sO+ZQt/ZQu5o3TXcHUiN5SVxEL8bwcCKa16Y=;
        b=vNxaxcBneqXJp3d2ug3hvkWGK27e3jqbAw8U9qlINLjD4m3LdjT9AOWelH9xkfwQJG
         4G9ofmEkh5tmdL1ALA0K5I7N7swZh38ygHYO6RkFh66tES5bqAlAYCk9XK46xwk9r3/O
         XMOwHIDvloIe6ckoOXbJVKL8wwxDHsKfCH9efxq6d2yB9/jV5EhtcwNKrcch+QUGFOOd
         F23feMHs2c1LL46EqICDbAy9hfrSYZQDyTYMDO258KvQtl096ZA9IZpaxR5FOdH5QTAw
         KeOWpsnSKsLShFc4Qpa+riHkZ8drH1DqiohQ4WOv9egpIgXUX3lIf7cTATn7fxljJPHH
         GHXw==
X-Forwarded-Encrypted: i=1; AJvYcCUHBFXAo9+Bk5bm/i+/hk7VJd+73vcNp6foJeEVaOdkrjH0beJUiiBkGHjnDhx5LN86jGd7BTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbVtcXSm1UY5qila+jPcSsdRrR6V9z6sUj9n6AII64n+U6qAYY
	Y9n/ayHBWTR67nKXDREm3zlZIIHzwmqsOZWOZ75oaTvk9Apt8cSA+6X/0++WomPkfvRRQvQ/kT+
	gOtNbCI42qImfW9soJ7zETHfv8x4eYto=
X-Gm-Gg: ATEYQzycSvu7yyPXoBhxLVRdsa3DXo/68gOJ7PC7HA9LZcayTHirUSqpssX/Stgeah9
	3FjN/8CRPo+HArIsWl4EuJy4Y3jlSdhWRXZq718PNHU2Yo7p1oC9m1p3wjDf8zrk/KRXDxyG4cg
	JMR+WpEqs/YYeoomDXKROU1rw/U6OvkYUKZLJLau9bqTL28KjAyALRZvWbPaoJaIO490mplV9Ny
	rlAlgo2b1INWEigRY4RPsvljcm2dMSny7YMZVvKteq3y1sb6rb/dd53raVi+extXR9wcRbmaM6J
	eeWenCvNXWeD+7Vds/S5TmPF+zicRuFMHI/zzU5niA==
X-Received: by 2002:a05:7301:1292:b0:2be:c4a:d31b with SMTP id
 5a478bee46e88-2be8a2fb45fmr903381eec.18.1773226382898; Wed, 11 Mar 2026
 03:53:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306140332.171078-1-jianhuizzzzz@gmail.com>
 <20260310110526.335749-1-jianhuizzzzz@gmail.com> <12e822c4-a4f2-4447-80b9-2eec35a03188@oracle.com>
In-Reply-To: <12e822c4-a4f2-4447-80b9-2eec35a03188@oracle.com>
From: Jianhui Zhou <jianhuizzzzz@gmail.com>
Date: Wed, 11 Mar 2026 18:54:26 +0800
X-Gm-Features: AaiRm50xoqHIgHtMNuCnYEMaVNP__SmFrpCyLTigX-k2JUIeVxgHaApqFn99lXE
Message-ID: <CAEgWzV5ryMBgJWH3QmWfr9LaZoihXcffFWKjK6OfJF=pDF6BtA@mail.gmail.com>
Subject: Re: [PATCH v4] mm/userfaultfd: fix hugetlb fault mutex hash calculation
To: jane.chu@oracle.com
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Peter Xu <peterx@redhat.com>, 
	Andrea Arcangeli <aarcange@redhat.com>, Mike Kravetz <mike.kravetz@oracle.com>, 
	SeongJae Park <sj@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, Jonas Zhou <jonaszhou@zhaoxin.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	syzbot+f525fd79634858f478e7@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: A68AE262995
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224671-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,f525fd79634858f478e7];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,oracle.com:email]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 12:47:07PM -0700, jane.chu@oracle.com wrote:
> Just wondering whether making the shift explicit here instead of
> introducing another hugetlb helper might be sufficient?
>
>      idx >>= huge_page_order(hstate_vma(vma));

That would work for hugetlb VMAs since both (address - vm_start) and
vm_pgoff are guaranteed to be huge page aligned. However, David
suggested introducing hugetlb_linear_page_index() to provide a cleaner
API that mirrors linear_page_index(), so I kept this approach.

Thanks for the review!

