Return-Path: <stable+bounces-214738-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHgkN1JthmlaNAQAu9opvQ
	(envelope-from <stable+bounces-214738-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 23:38:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 425CA103E52
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 23:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4857D303464F
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 22:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D16D3043D7;
	Fri,  6 Feb 2026 22:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMn6UrSm"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFD82FFF88
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 22:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770417471; cv=pass; b=K5phrXn2bq6FQr6n9xJmFtMKQ9qS14g51zL8VX3IGBrslJHSxlDDyN14VqigLz+APj79z1X7GdYmPsuCfzLVWigGjRk+dh0ryQMygq0MGfu3Xe1ZbEGCUyurk8FiLpS0MVfPkYAIxSJWEa6i9MjlMovgMCvZo3NSDZ4Eapo0NqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770417471; c=relaxed/simple;
	bh=cacv21b2V9VURDvVULHeLUdzvx66P3ydxu2nFeKvxDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eZvhEM9JvD9kb8whV6BE6+kZAyXsUM1aJcZdjmOYpMyF7DyivmafP43DxvLb/n0Ybif35jtKwWd4peiUIUAyVqXMN+0w/z54WWEqIIs8Vzgr2nTrwfqtP1TS/dH6abSD22lCeYpFBphqrpuWFfp1/g/fqhY1VR0kXqr9zFn4xtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMn6UrSm; arc=pass smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7d195166b2cso2027376a34.3
        for <stable@vger.kernel.org>; Fri, 06 Feb 2026 14:37:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770417470; cv=none;
        d=google.com; s=arc-20240605;
        b=NvX08JsqxbKI8/CLcBbGvO8ghVh6sUbT3NGPgjR2JKPJOu30bKfElhyI99vAuBCJBd
         2aiF9U3Zpm4rB2P9wKM/t6iUoQjPm4rnrMJOV8VQdhDUTjWf+3U44fNo3oXKCOLQy0px
         FrfwNaWEqhgh3I4fwHDhigg9epUYnBK3lXH5faKqRV9Z+M6bJWrmv0cWGFI9CDkIHxOG
         mh82wd091cT31p6w5G2QU6DMfDK4kJQHNQ7sV1/UiZmSyvKjE3MfaOpkMdGhkkYwKDwS
         Yh1Hx0mpqfshJr3rKBLJJljE4f7Nkk+oYie9obM4+ATMO/rXC1X42EgPQpg57dYSkHj7
         caEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cacv21b2V9VURDvVULHeLUdzvx66P3ydxu2nFeKvxDM=;
        fh=1+IGIqfwG+mdXf3GJpOylbIv6o0uFyb5F7iMswEMyx0=;
        b=QW0Ln6+rfDeYYzfmPK6DRBVKrcI+o8RoGIEI9TCSDRLbt34Gdzudemx+DNCvF6llma
         W9ULu+14W41KN1mY70RFlPaVYsUWJiRnXneTAVH1DXmVJn3/13LlEGTbToRlEtofuCHt
         Xta3Gi+KHpIinH5n8J1QYdw2kRB2H3cwI4B9NuMCWy+9ZB7TxQ0AZYS3Hnd6zZVFSBGW
         N+0yWc27qfbYvm/HeXFffbKeYW9XoO9//2eVd/aNaut0h5rfiI2Y8HHmRJy77gfB86Uv
         IiBWt3q6en9ZFtoz3L0rD5xSeDmzaAF89Dza7MPEr9GC03KkUgsTGKo8RkJ8rXCzSxUn
         +88A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770417470; x=1771022270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cacv21b2V9VURDvVULHeLUdzvx66P3ydxu2nFeKvxDM=;
        b=nMn6UrSmYh40nYCqwY6oHu9IfnvN5MPiDhEaxZ0USjHXrxyGn7/favFwFDlaaSUkUQ
         RHmNkhEptCSSpzrSmUA5ot2QDgxsu+FFLx68sE8NJFAEOMHWkLLjzhR7Kugb4q6kprZa
         rFZS7KKvcqGK15YrGkLZ7DMj9QgBElwl33eJrOzscy8+iDMbgU7WTIPmD+KYeTRLWXAF
         DOqQVGXHBZxlRxzy4b2PvZDYH0Q8q5LpxoZ6JLN7EfIX1fb0WeYcKc47L0LPGasSQ51T
         7JBETQPmfogs4Pl1jAis7U7dIbv1GkFjuSToTf7+gumY1QXLGllS5q3SFX8e/Rvrw/s8
         CBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770417470; x=1771022270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cacv21b2V9VURDvVULHeLUdzvx66P3ydxu2nFeKvxDM=;
        b=XEMB34p64v7lV//jvZArDiI/HXLdGg3YGuCrkmeVGzSH1QS1K7RWk50OXmqSuid67c
         xl3J0KAaFr/g8ju+thTCXps/pGaR3PLKlx9wjBYYeNAWoEMyJpeIbNgPZsRSDXIq76k1
         H6TRgTQ/ze6xJGSHT5JKXTlTovAjlBZJTFXSuv228vaymsa2eb1gU7P1Dv2LcveFD7Wn
         GFu1pBl0gp84NMgeAKEkjcbqJqL3Zjb3AkETYa9PKbp3Ar6u3qe9esJeVa3L69iC8Gy8
         CL9GnDmxo1CdYcxkPW4iL3CGLNnbPXDagWV1GHEu4XHCbiS0GiALvRgaNWTCsP3qm9P5
         S58A==
X-Forwarded-Encrypted: i=1; AJvYcCW9OOgIzQ0RKs10HHNqWODHnLeCHB3HUiimMsyUGvlO/IQ78kyBrF/dqVPNYZI/W9qEpimQvJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF8YwASQ2j2xcnsRi4hOe8de6FscsXJ5GySdLuweYmveP2Lcs3
	amEdS2xCtLAm9h9Lq+7kS5s+Y60kxQQsoBB/X4wprt5coqiZjsog7RvNgQQiy5wze5RmGaTKLDU
	28NFMJn/nPRmEnO0WBjZA1QVuc0i8Ekw=
X-Gm-Gg: AZuq6aJpIgN651SOlhElaj/3xSXWx08eBbkaVxAHMO/LJTkO7RlZuxafcRPZG3x2bPi
	N3tgJgaL1BD1QXKeC9b5NvE6fzUk3w81WOVdmVy7DODs623JNWMHxhoDOCiebJx2s4HshFOo4Vq
	VSyJ0ZBHmtF/e9sFAO6jRL68FPMPwqMaGCuktskLiEj+LwiPXNQ+8KaPQX9E3yS/DOJ9Bxx4duL
	1zS4W/avwqCxmWR0I4fVHA18N2GKxJl+FzJrfArtYMWbn2A3+mSVpmJ/FxQfsG3mDTFeNmsuw==
X-Received: by 2002:a05:6830:6aa7:b0:7cf:cc2c:1d9f with SMTP id
 46e09a7af769-7d4646a97c0mr2354785a34.32.1770417470058; Fri, 06 Feb 2026
 14:37:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCs03XcXt5GDae7d74ynC6P6G2gLw3ZrwAYvSQ3PwP0mGXA@mail.gmail.com>
 <20260206174017.128673-1-mikhail.v.gavrilov@gmail.com> <3BB6BA1D-3756-4FC6-B00D-79DF49D75C51@nvidia.com>
 <CABXGCsOMzrQTsByYraNby_MXnTuYBNt2vbWu65KCGX6bmi11iQ@mail.gmail.com>
 <F36AF979-5BE3-4399-9420-F41A475EA87D@nvidia.com> <B6CDB0B7-CB9A-492E-90DA-F8D7E3B037E1@nvidia.com>
 <7C7CDFE7-914C-46CE-A127-B7D34304C166@nvidia.com> <4C3D8E3E-D9D6-4475-A122-FA0D930D7DAD@nvidia.com>
 <CABXGCsP2z6sbf_FYZjdxyLhfJZEaxz0_WrEeteS50GLyU=KQGA@mail.gmail.com>
In-Reply-To: <CABXGCsP2z6sbf_FYZjdxyLhfJZEaxz0_WrEeteS50GLyU=KQGA@mail.gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Sat, 7 Feb 2026 03:37:37 +0500
X-Gm-Features: AZwV_QgwJjKjc-AgTrd1ux4zGKdLDvb618tkhqrDGZHWJIHQbK04Qor0t3Z5NFA
Message-ID: <CABXGCsNM8Oex-V3vFSUy3ftMw1fAweHZHQYzRHWU9M6gm7r-rw@mail.gmail.com>
Subject: Re: [PATCH] mm/page_alloc: clear page->private in split_page() for
 tail pages
To: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz, 
	chrisl@kernel.org, kasong@tencent.com, hughd@google.com, 
	stable@vger.kernel.org, David Hildenbrand <david@kernel.org>, surenb@google.com, 
	Matthew Wilcox <willy@infradead.org>, mhocko@suse.com, hannes@cmpxchg.org, 
	jackmanb@google.com, Kairui Song <ryncsn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214738-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,suse.cz,kernel.org,tencent.com,google.com,vger.kernel.org,infradead.org,suse.com,cmpxchg.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikhailvgavrilov@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 425CA103E52
X-Rspamd-Action: no action

On Sat, Feb 7, 2026 at 3:16=E2=80=AFAM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> Hi Zi,
> Thanks for the deep investigation!
> So the actual culprit is KASAN's kasan_save_stack() leaving non-zero
> page->private.
> That explains why it only reproduces with KASAN enabled.
> Looking at the code, kasan_save_stack() doesn't seem to use
> page->private directly - it goes through stack_depot. Is stack_depot
> the actual culprit?
> Happy to help investigate further if needed.
> Regarding the fix location - even if we fix KASAN/stack_depot,
> split_page() clearing page->private still seems like the right
> defensive fix.
> The contract for split_page() is that it produces independent usable
> pages, and page->private being clean is part of that.
> Other code could potentially leave stale values too.
> I can share my .config if still needed, but it sounds like you've
> already reproduced it.
>

I think I found it. Looking at mm/internal.h:811, prep_compound_tail()
clears page->private for tail pages,
but it's only called for compound pages (__GFP_COMP).
Before commit 3b8000ae185c, vmalloc used __GFP_COMP, so tail pages got
their page->private cleared via prep_compound_tail().
After that commit dropped __GFP_COMP, tail pages keep stale values
from buddy allocator (which uses page->private for order).
So the stale value comes from buddy allocator's set_buddy_order() at
mm/page_alloc.c:755,
and __del_page_from_free_list() at line 898 only clears the head page's pri=
vate.
This confirms the split_page() fix is the right place - it ensures
tail pages are properly initialized for independent use after
splitting.

--=20
Best Regards,
Mike Gavrilov.

