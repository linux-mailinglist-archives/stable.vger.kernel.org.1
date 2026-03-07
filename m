Return-Path: <stable+bounces-223423-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KrO3Bj0qrGmfmAEAu9opvQ
	(envelope-from <stable+bounces-223423-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 14:38:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6988622BFC0
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 14:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D61E302F261
	for <lists+stable@lfdr.de>; Sat,  7 Mar 2026 13:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD362D63E8;
	Sat,  7 Mar 2026 13:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmdOjsRt"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62613207A20
	for <stable@vger.kernel.org>; Sat,  7 Mar 2026 13:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772890680; cv=pass; b=OqqSaMkxit/vNASHo8NXACc7Tb09x4d4tqmUFJ4Ikzt5JHmYmOGBNIACRChxWrV4dWrdt6UCIs1xfW5hq8AWES/Q2kz/kO1bzhFgjS7b4P7UHklmik0YRup2fG1bMc0Kg6ly9lASd6mbNCX09/mLovtwbujAuaT/2mrfflgDCl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772890680; c=relaxed/simple;
	bh=wRzLVvHgWD93HYQHbQBL1as10gw9qzKkfCllaJztG9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=usNBYqW4sWp6d1qSjYKTPcQ858NDkRbYcT6uIHj2arsd60aL9OFA+i5CO6lh+gmOUSb4VlsUNXkznR/gNs48ixhiWHd8cxT9OXS2tte5Y+PjfoiEpWwp+WpGsOhM+qhXSrEaHfw9uoSzUAvtXRbI5S3pDMzRGB2PjoxvDFWeqOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmdOjsRt; arc=pass smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2be0711f493so2428899eec.0
        for <stable@vger.kernel.org>; Sat, 07 Mar 2026 05:37:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772890678; cv=none;
        d=google.com; s=arc-20240605;
        b=BTv4Ae8iszB+8aJfnhBZ2BPJOIwF69KHl/eEncgWdZREcT2nm2Do7ql4+zxXCNd/Tj
         pb5ucMZTYTVBswY98doW+EKGC1Dnu8tRE+KQJALEVbiNJCUMo0A7aY5Z6P7dMklef0qW
         DpkPS0DWCzrao3JmIEu5MMGIf09BU3kqlxuly2MIJuoSEPvv2iXucqplsA7clbnGvSYc
         4/w/CnuZpg6TC5Dqf7wtYvXVQAOzIK2ziqEow1ZIfbOBZsTCRUa4RWpZ1z84iZzQB+/1
         zMgnFVrGKUfHyNnM0fj8u7kZ9dV17weM7lGTT2jdYCNrDTl6L6z2QwdUjaxAjPWyFDXh
         fTFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wRzLVvHgWD93HYQHbQBL1as10gw9qzKkfCllaJztG9o=;
        fh=lLI28I2DT+6lMCXprET6zuPsZqVm6KdEXRcVdnNwUlM=;
        b=hUHWx/9aD57RJJiN6GuIPPVaUfKeUYgeSbn45pX9ybJOiWANzDr5LGeMIMvEQpAjMe
         XbqUAGpZENXxEAC/JLu7mjQiHZrA1Ae3dgZueHZUWm+Db12xgwsSrTmrHyhHPU0iFS1l
         kK4Yje07RLar5j1Cb/NWBjD1nH7PbUkcne/MP92941sotKqfsDVQV46XeaPz8NGVFQmT
         eUK10eOjIoGzsQoHvss9a060jlWSORb/VJfoqMLBYYIbfrJoFJw7EjZxpZO+YVbEe+Tr
         tuIF0rlsCCsJYcELrca0LcuwlD0+aWduKL/h+QMFWgNeLkslEOTcosoxKfHe4GR/1ROG
         yukw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772890678; x=1773495478; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wRzLVvHgWD93HYQHbQBL1as10gw9qzKkfCllaJztG9o=;
        b=lmdOjsRtMtfnAEO3hiEAhwdAPaXGx4cUp2eKQ7Y1CGKHaI1Q7l/Cvjj4UL68KAlCnh
         Ep+s54yDMEUaPu5jqWAZA+1HlPKp986fWY/yThoapfNm7JHxCNv7hSF/7ZXWnEX6ZGoR
         894To09uMLJj4V7SxHMFQ0IjFVg/1gUMbLZBSpff9bAiMj0FX/NFcpmW/xaZHM0zNLLo
         u8crvdejKuSLbVRtfLEmN9e75u8Jl/JuB40YZzVSJT4BH10hNFI+evAh8FtrUIdWHv2G
         kBobGwEc/I3Md0BMq9e7l07PAMto7wadIb3AC6pIf8FCW517xNxEYnlKegDKZGs4TDx+
         1GNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772890678; x=1773495478;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wRzLVvHgWD93HYQHbQBL1as10gw9qzKkfCllaJztG9o=;
        b=WEIXSKpBO6aYcKFplKuiIZXdl3Lg54Lbj+AJC2xMpO2alqd9fQyCzMPlciUYW9YVNM
         L/7WjIDNUu2huKS6W/jk/v1dZMFoD1twvIJagsxPYOHi7Vg5o9Qd3uMCX80hFtQHkEy9
         BxCcIduYryQSe9WK8+qjiWFPSEMAxG1UOIVePuqVbXVZqPoTxRaTo1kuicCxAW9usZcX
         VKHsusAj61uQlvvgWKDoCTMn7QVL0LQVa0f0Wq9Luv2846jsR/UF7LMT+vM1gMxAldV2
         yGUK5C9LkAZwvccgOiyiiph2vkH2uIaajWxV3GIAsXu00yyD6/vmFiYT+DNbca16VwmH
         U8uA==
X-Forwarded-Encrypted: i=1; AJvYcCW1A7mrCn3xphCAI/J/CUZ14S67KhdRyBgKmhPY1lBmLt4tEJkERVXnYs7nXEp/StDsjhZGWbI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf7gvb5SU4YSyDyjOB98pNjkDUNSara23DQlvj3+J4yImCHpvO
	vQuEMvjrSIN9FzZUuVEfIKUox03Xfz0lD04piApZSFo2MOts7JrLto0EkHmO7D9HzjKMeK7jvJ1
	7r8U7JRmwNsNhKt9t5VwpEOFHtEe6fsg=
X-Gm-Gg: ATEYQzyxoT4piiX+BdNgwvTuzms0OIbhWl+aTz6bQuVW18BfJYIbRL+8fvSzQcdZaSy
	b3GK3G9AMaqatb1oeo3uMMFc1VaQeVbxdcd/lkH+WZO2T88hjglvHB3IlvSwZ6jCU43gfSwaxms
	Ck//z7Po5C1s5PGx2q6ngAmb71s0IREIJNZP38FpFRv2HqvkKxHyn8O9Sgy6CU3mVoO78f3oASh
	JBAEFpeI8FpEE2JnwONJai8TSbGXoUSxDR6mVB+8p/bDMVn/vexINJVfFnlO/VVkALudJs8tFrp
	3FGvMXzw7QRMuDVHKH6JrBN56wABzsCBMdaIPvyz
X-Received: by 2002:a05:7301:408c:b0:2be:fe8:8af6 with SMTP id
 5a478bee46e88-2be4e6f4529mr1593900eec.17.1772890678441; Sat, 07 Mar 2026
 05:37:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306140332.171078-1-jianhuizzzzz@gmail.com> <aasGkA4r56pLqNC3@x1.local>
In-Reply-To: <aasGkA4r56pLqNC3@x1.local>
From: =?UTF-8?B?5ZGo5bu66L6J?= <jianhuizzzzz@gmail.com>
Date: Sat, 7 Mar 2026 21:37:44 +0800
X-Gm-Features: AaiRm506r2slOn8XqCP2XahA-mrOVOm_yyBjDyj8B2uPbMpTlfnoOusq7ajmnes
Message-ID: <CAEgWzV6KLtd+05Q=YGJXWSyKF+UJvyAXk1dhq_a7s4M3h0U5zQ@mail.gmail.com>
Subject: Re: [PATCH] mm/userfaultfd: fix hugetlb fault mutex hash calculation
To: Peter Xu <peterx@redhat.com>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Andrea Arcangeli <aarcange@redhat.com>, 
	Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Jonas Zhou <jonaszhou@zhaoxin.com>, 
	syzbot+f525fd79634858f478e7@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 6988622BFC0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223423-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.944];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jianhuizzzzz@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,f525fd79634858f478e7];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Mar 06, 2026 at 04:53:00PM +0000, Peter Xu wrote:
> IIUC we don't need this; the userfaultfd.c reference should only happen
> when CONFIG_HUGETLB_PAGE. Please double check.
You are right. mfill_atomic_hugetlb() is guarded by
#ifdef CONFIG_HUGETLB_PAGE in mm/userfaultfd.c, so the stub under
!CONFIG_HUGETLB_PAGE is not needed. I will remove it in v2.
Thanks for the review!

