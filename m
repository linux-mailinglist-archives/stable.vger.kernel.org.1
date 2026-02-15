Return-Path: <stable+bounces-216646-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id rnUKJlxNkmk7swEAu9opvQ
	(envelope-from <stable+bounces-216646-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 15 Feb 2026 23:49:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D52AB13FED0
	for <lists+stable@lfdr.de>; Sun, 15 Feb 2026 23:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18638301A722
	for <lists+stable@lfdr.de>; Sun, 15 Feb 2026 22:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1862B30BBAC;
	Sun, 15 Feb 2026 22:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hjRTxaN9"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B97326158C
	for <stable@vger.kernel.org>; Sun, 15 Feb 2026 22:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771195735; cv=pass; b=SKsPEeMsoXmif9kcixQYpn9CB2QcQVqxA6LKUjFvc9/QHb8RasbFL/eKMi2XYEU/7APt96nY7Oxuk2U2osY3r7ZjjG1XPCbk0MuFeYq2WDLZMpKk9Sz0ftKMNLaMBWBanUB9p0ZepXl8Gv650qYionYlDqvSOaoW/NUb+SXT7MU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771195735; c=relaxed/simple;
	bh=YQtu3zlzSmUdYoQNnQZceEbrqfuqwQux6loH2dpaFVY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QNOkNoAaIl5FfX2MsFeEm0NYxoGSsWyjFmbU4Viud5l5JjUmR4eVIkyRX0+rbGlo3Hbs+YT/5axuohhdiGu+VzVhLKWdtQi8r+jNWdx4C4M44SgdpPt3CQfIFHNIDARrJsdqxpskzLSFNUveSRytAcBBzrwJ+JOVk0b/iBaE2u0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hjRTxaN9; arc=pass smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5664848545fso936581e0c.3
        for <stable@vger.kernel.org>; Sun, 15 Feb 2026 14:48:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771195733; cv=none;
        d=google.com; s=arc-20240605;
        b=BD02kRysX8PCD7EsBIPx0HRiE2VhlW7qEroMrZgih2TdkvQ0ivc7r/LTvtpaS84Pnq
         MW2bKOzHhWFAdBX31cLoCVtqi6pRryoRpEKTV9J+Inuq1/eMOjVZhf9OcvxjzbCyQy/s
         9eAzg6xo9rKujPuuKaWN8Jfwpw/UNYFeWTqbFhVFC1x04cFeQeAoQ9ml/BpGdaUEu8FD
         ZNUZhIdTMBIxa6cRuj1C9T5cFwdf/vEywrnD8kJ9X8h89TCqgDTyE7wBLfFjPVGVLS4B
         04NP8zwbcfxob1yYK79rYtApNta0yH6+RyLsY0OQR/6WyV8ryec/xASe8vM60BzU1QZI
         CQxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=aB7V1WHeYzB7KogdF1kJespp6q092hH6CqwnHTfTF00=;
        fh=qLaJJRP1RzRL/Xum7q4Ks+eqXu1zXzN/Ca8lka2i4p8=;
        b=ZHWB95fRa/NU9eD3H6PkLUD4k9lv3cRflg9s10epy3ne+FHYJjLXolK/9Gs8xp41wj
         ABNstUNNPjqJ2lO1acGdW8sEBgmaT0Ek4FrWGnC2ULSwh5Zga/zZ6L5s6RqS7hWErp3I
         VOtm3kIluLiv4s1CQn5kbh+Uxjx9c2edASgtvz4EHB9/AUvCW+P2MYLWFY6hAHHkHyj6
         yVpsTpPUd2R9m2Y1xbCJtneG+2ZPKsbZVbCWYLWLxr2fNGbLtm8qC8Ht/rJ1V3d4vOUH
         1HvI/MsMY42dVN4SqisevFe+KAjdHUk4WoHwYoTc4662r9tvtdXqhKzANtcHf+inowvq
         5eow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771195733; x=1771800533; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aB7V1WHeYzB7KogdF1kJespp6q092hH6CqwnHTfTF00=;
        b=hjRTxaN9Dbu9VVLLRQmuTdvDEL72kWHLAa2VZgpI56rU8NSDwvz9aHLUeOVsca/4Et
         EiXlpMh83rUQDXADpcQu3DStLXEqvBw1j0hDe4Op6gjUtKlEBmulvfsjvP4f47ZUE99J
         jbAzmWSHCRL/jhaEs6mre+5uwiAnDjLbSQ48G5m4i1omJFkvI6cylrKnNpgni4lfpl1t
         tCEESPSUC4zUzW+meXE9uubBG6PNtKyGSiccEH555osEbG3/icOQXm+ypNgIVg/LZWgp
         67thw+yyYrogCjcvorBoI8w1goMLf6gUHEGSztAxClCrXq91ei37hvPY/BwtoWaQA1yd
         m9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771195733; x=1771800533;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aB7V1WHeYzB7KogdF1kJespp6q092hH6CqwnHTfTF00=;
        b=Z1prWV0u4DTrdP/777i0WW/Q7IUqmp8VkPS2ZnRqUAmfAYvfQOmZaX89ty7TDHW9JC
         buuMvjUS3SlaVun0poRDSeMaALmWKD6EvatsKi7KMNfgjC72aj2eEmX3bULPw5UY6uZs
         YeloPZfOIc1x1v6veKWGR4i5FagvfAzAGkI4IWg15GW7Tsv4PEYaoecu96EU5PR8CbpK
         yLI+RdksWgb2H0ixTa8eo2a4gOk5XRx+0mfiAVnzUKqqRp8ccGO9lKcCqwHB1MWPaAKT
         SvtraRFY988BlwElk0lfFweHWL9MMd+qyb4/oJ/SxAyl7kIHLl8E15nM+swa5+Jx9yqc
         hwDg==
X-Forwarded-Encrypted: i=1; AJvYcCVYvl/u06MWKHdnaqii8g5UPdO5yAPtBmcs7gvJtdQFIG8f4MX0WBE70nqJtrQoDTVYlBoKkh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG7cP7v3EwqfGvVqMBm2J4D5MVysrzEdoVrIpS4WL15V1Cjgr1
	WLhb0LOQ45e9mTmhgYBVxT/264hUP5hADzpwZuMQyQF/g7OPUABd/aCHqewP+aXICBUnhDoG7FB
	UOKOAR4/acYTYahCU8Pbj+xE2YtAIrs/U3YVYzqa6
X-Gm-Gg: AZuq6aJUtq7xurR0tGwgsjzkpPlyiXmJPwlHFzCswEkaslRHRbBBZuUoOrVqtPCdlxE
	Vs9KFOH1SjnR8bfQcenwP5cUA66jHnq4HFC1NZCBgRBUOAIQMu1XkmBvx08LLEkPmP2RJdOcprm
	3SPrlk+S2xyGSlNngJSL2IboMFiduM2QVt4zAhY431zRPt1qSC+FtujNgYRxi9EgJCEStePOxgJ
	PW7s22IuPWIqZW9WcNF2KDRMnqqDbIbteahBsO6PTb0JOw1D0AeSY+h2e2QaO8JANXqYlkQJF0b
	YIIUjY0LDRtvB2c9bKetqfwtEmtiG8BSWGBYObO46w==
X-Received: by 2002:a05:6122:d92:b0:563:7d93:b135 with SMTP id
 71dfb90a1353d-56768179fb7mr2621169e0c.2.1771195732879; Sun, 15 Feb 2026
 14:48:52 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 15 Feb 2026 14:48:51 -0800
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 15 Feb 2026 14:48:51 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <b398d163-7b58-402b-a37d-9562d658a62d@linux.dev>
References: <20260214001535.435626-1-kartikey406@gmail.com> <b398d163-7b58-402b-a37d-9562d658a62d@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 15 Feb 2026 14:48:51 -0800
X-Gm-Features: AaiRm52UXXicsi141L_UNf5JmMFNKNoMBVCTGWwMUSkJ1ZSHoalesk6JUL2jVjU
Message-ID: <CAEvNRgGLAnZkfPZt32-wyCaefu-tvG9WcX3zq1Xe7fsTabZqmA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: thp: deny THP for files on anonymous inodes
To: Lance Yang <lance.yang@linux.dev>, Deepanshu Kartikey <kartikey406@gmail.com>
Cc: baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	linux-mm@kvack.org, npache@redhat.com, linux-kernel@vger.kernel.org, 
	Liam.Howlett@oracle.com, 
	syzbot+33a04338019ac7e43a44@syzkaller.appspotmail.com, ryan.roberts@arm.com, 
	stable@vger.kernel.org, ziy@nvidia.com, dev.jain@arm.com, i@maskray.me, 
	baohua@kernel.org, shy828301@gmail.com, akpm@linux-foundation.org, 
	david@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216646-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linux.dev,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[linux.alibaba.com,oracle.com,kvack.org,redhat.com,vger.kernel.org,syzkaller.appspotmail.com,arm.com,nvidia.com,maskray.me,kernel.org,gmail.com,linux-foundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ackerleytng@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,33a04338019ac7e43a44];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,appspotmail.com:email,linux.dev:email]
X-Rspamd-Queue-Id: D52AB13FED0
X-Rspamd-Action: no action

Lance Yang <lance.yang@linux.dev> writes:

> On 2026/2/14 08:15, Deepanshu Kartikey wrote:
>> file_thp_enabled() incorrectly allows THP for files on anonymous inodes
>> (e.g. guest_memfd and secretmem). These files are created via
>> alloc_file_pseudo(), which does not call get_write_access() and leaves
>> inode->i_writecount at 0. Combined with S_ISREG(inode->i_mode) being
>> true, they appear as read-only regular files when
>> CONFIG_READ_ONLY_THP_FOR_FS is enabled, making them eligible for THP
>> collapse.
>>
>> Anonymous inodes can never pass the inode_is_open_for_write() check
>> since their i_writecount is never incremented through the normal VFS
>> open path. The right thing to do is to exclude them from THP eligibility
>> altogether, since CONFIG_READ_ONLY_THP_FOR_FS was designed for real
>> filesystem files (e.g. shared libraries), not for pseudo-filesystem
>> inodes.
>>
>> For guest_memfd, this allows khugepaged and MADV_COLLAPSE to create
>> large folios in the page cache via the collapse path, but the
>> guest_memfd fault handler does not support large folios. This triggers
>> WARN_ON_ONCE(folio_test_large(folio)) in kvm_gmem_fault_user_mapping().
>>
>> For secretmem, collapse_file() tries to copy page contents through the
>> direct map, but secretmem pages are removed from the direct map. This
>> can result in a kernel crash:
>
> Good catch, thanks!
>
> For secretmem, file_thp_enabled() can incorrectly return true
> (i_writecount=0, S_ISREG=1), so the mapping becomes eligible for file
> THP collapse ...
>
> However, if any folio is dirty, collapse bails out early with
> SCAN_PAGE_DIRTY_OR_WRITEBACK, as secretmem doesn't support normal
> writeback, IIUC.
>

Yup! In the reproducers [1] I had to try to avoid setting the dirty flag
on the pages.

[1] https://lore.kernel.org/linux-mm/CAEvNRgHegcz3ro35ixkDw39ES8=U6rs6S7iP0gkR9enr7HoGtA@mail.gmail.com

>>
>>      BUG: unable to handle page fault for address: ffff88810284d000
>>      RIP: 0010:memcpy_orig+0x16/0x130
>>      Call Trace:
>>       collapse_file
>>       hpage_collapse_scan_file
>>       madvise_collapse
>>
>> Secretmem is not affected by the crash on upstream as the memory failure
>> recovery handles the failed copy gracefully, but it still triggers
>> confusing false memory failure reports:
>>
>>      Memory failure: 0x106d96f: recovery action for clean unevictable
>>      LRU page: Recovered
>
> Right. On my setup, that would hit SCAN_COPY_MC in
> hpage_collapse_scan_file()
> rather than a hard crash.
>

Deepanshu, were you able to trigger a hard crash on some earlier kernel?
I only saw this false memory failure log.

>>
>> Check IS_ANON_FILE(inode) in file_thp_enabled() to deny THP for all
>> anonymous inode files.
>>
>> Link: https://syzkaller.appspot.com/bug?extid=33a04338019ac7e43a44
>> Link: https://lore.kernel.org/linux-mm/CAEvNRgHegcz3ro35ixkDw39ES8=U6rs6S7iP0gkR9enr7HoGtA@mail.gmail.com
>> Reported-by: syzbot+33a04338019ac7e43a44@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=33a04338019ac7e43a44
>> Fixes: 7fbb5e188248 ("mm: remove VM_EXEC requirement for THP eligibility")
>> Tested-by: syzbot+33a04338019ac7e43a44@syzkaller.appspotmail.com
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Deepanshu Kartikey <Kartikey406@gmail.com>
>> ---
>
> Confirmed that file_thp_enabled() is working as expected now with this fix.
>
> Tested-by: Lance Yang <lance.yang@linux.dev>
>
>
> Cheers,
> Lance

