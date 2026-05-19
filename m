Return-Path: <stable+bounces-249707-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKZiBBTnDGoopwUAu9opvQ
	(envelope-from <stable+bounces-249707-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 00:41:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2268D585C0C
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 00:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4ED7A300DA47
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 22:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0358636E47A;
	Tue, 19 May 2026 22:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZ/rUNEF"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F2130E0E9
	for <stable@vger.kernel.org>; Tue, 19 May 2026 22:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779230476; cv=pass; b=az9fIrJk6nLCyrHdm1blsQ0o6heU96ZR4FFvalYOuuXEz383m/yLhbd1Qqkt+3t6N0/QY3Ppk4zqs5r2Yr3F96Kama5RbQkDmSMLtdEv5gKa9Ru44Zt6EEqkJ0bhTv3vdH/R8vtmYiGgJntA7oFhiyeB4pK5HMpM9FUuedMdv4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779230476; c=relaxed/simple;
	bh=SV+pkCYA9UqmBQ+Qp7eReLMWP7VcEgqdU1ufh5qr04Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sjqhAr1xbqW+/39kzjlrVMApiTYWin6l6XHgf4I0AgTVp68DQptHv/iXgjfWetloGzyWr9K3uYfKNhcAEL5hevSUOFbwfjbTAVoQuXKhqzfS07OOL1r4s30HTCjzlZ/RI+otSx34kjMOwreAHvhQQFp547nMvzKCXBXdAk0N7ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZ/rUNEF; arc=pass smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-43aaeb6c96bso1233948fac.3
        for <stable@vger.kernel.org>; Tue, 19 May 2026 15:41:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779230474; cv=none;
        d=google.com; s=arc-20240605;
        b=ee/9BYtrmfaZ+3lbS9qkIgrcKiK3MyzMVsI7MwfG6y8IsMiikiRi/N5/i61WWIQ+9U
         1nXKEZmm7zpGowYJt0Upa6qY/WVVUxBDBcjZn+9EBF9TmkMCRcfo67Jtqs9QyWHCLdO1
         VqMY9kZWIUF/gsJwAVqL6CunHIbYbKJ5Jw4FoYx2D0lC1N6uj/CJH6ZklP5MreaM4P2n
         iax/YVlvZMivNDNPphB9HbW0Kk3dBWI2aOo96C3HPKsBb55wIwjSoEJ4mEiWXvbHMJ1H
         aynIXwmDaMqnDfrKon7Lu+7zOFgmAck0oFtZW3Sk7GAvnyicF5uVONSv/nwPQqYA+nBn
         Y4pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Oc7IUMGtW/r1T1j9OaU9cZaiuWsQdebfgPPEltdLKlk=;
        fh=lbm2w0H6ZzwxgKGvLHoWggRdCXgk6W/J5qenUc8VbnM=;
        b=E0g6i52nY9lbYsG5HhepOIfW/1SWH2R3mBXsN3LcZph/k0DjWHimr5qw4pKTA7RXAd
         GvmyTZoClnZVLZtS3E/64fAtrKdpvH8fjABivwW1ZbU1Btci03jWDa0KQsPVaxb5aQ4s
         b8VG6xutB/vltp4sA4/0UI+DWBACs8nwqfBdWWtICEPGI/Wph0ZsQamp8qLnK/4SB7rm
         RB6YSPTZvLeYS9qB5vU6XEhvwEaWmkle5pOd1UOBdiUBDn2Tf7G1ydnQLfDoaesmZt33
         VzUFzAzDOXDMCsOrGyKdyKdaJ8w8F0deSkWYvOn9CDGQmaPVltNa84CjS9LhNs0eGqnC
         4U3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779230474; x=1779835274; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Oc7IUMGtW/r1T1j9OaU9cZaiuWsQdebfgPPEltdLKlk=;
        b=WZ/rUNEFTc41hWAOFgoBx1UcO36zS7EYaqa2FmmYr2vB8KkVNCTTwAZk4QmEpopW+B
         cAcfVrLwTEQesWeHa2jcfxqZFFv+RLTYP5A4AHUct+dwtw8K/GegKn2yiGFsC1B5ns4j
         TFrbXog3Rhwz4i0Np+rN0wCVEX4sVEQJOxLf8GPG9IFI5vBQ6g9o1Yrero7h/ojvVsxc
         csSkbkvHUUX005MY00RppWP277FWCeUXU6xr72UXKEKmH622s1jWGsqt23M95h2FlL+d
         iahPEEBYxpS+VHqsJtD4mwCY+2WeJ6sAnXuylvUCrk39kO5T3JA0bjW5yC1i3/D5gTpf
         TTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779230474; x=1779835274;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oc7IUMGtW/r1T1j9OaU9cZaiuWsQdebfgPPEltdLKlk=;
        b=VoHnDc2kSmqwVVj+p8mae79fVYam7K+cyWOuk2IeW0bEOBNUxwjwI3Ex5XYiQIEfpv
         hjeanEtNACJ87Pfi9K/RIVwLdbby+ITxlMwMILUMNbpf+vMvSuXocWsZDYPlMKYyPfAA
         e/q5UKIgCXT/jT1v18ZG4E+hsDJxbDUIcsUqRa9qrHq3bvJJ40ZuvDB6U5tVfrspEY58
         pp/z3H2xBtErFs4ey4hYCw2ahcLxlXoQRiutIbi4hEmtK1g0POpV7HP3DiEYE90JDvfJ
         g4fiRjJigghWMURtLknu1baddCOT/o5U7Zc+qk5tgtDs0YcbCpRbwDO2EaGlVZfHaSTU
         PpsA==
X-Forwarded-Encrypted: i=1; AFNElJ9CbMoU3wi70YaXkDNN/KgvY9m7Q6J7Y1HYrjNZPVPJRAIkqxkwiyth4uizY1IUFDWaoGicKWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcqSYL1hhfgooapqpb9emAbucbJk9V3dfejbBHokXG51wJQNG1
	2b1rY7KViaWwruFNYCsyaqKgo5FOkX54uZW9M2rpcTgSoa63HoTZhRPa0zabLDpTHJ17xljxL0J
	flST2fs/suVV5x7v+NNcngV83ev7/CAQ=
X-Gm-Gg: Acq92OHMDoHSUH2ozyHGEPIuMR5A37zdGaPdbFzvNRl2TWsJHFNnf17XH7mznm7K0A4
	6++QsQnN1IJeMGhlXwA7o5zzrQ0AxQfaBN7Xua5+6ANwyOaI6pkngYfGrWMHdw551PaE8exooiv
	8bfwaX2nEbL8x9ejaTOHtd4M/gHXLn8WSVZDE5CUmi6hKxyGcvSGSpP8FLMScNEsdeVAOLhy/Og
	yK3YXvtw8k6glgLJ8F5tfY4Tz8/V6nQdtZnmFKLY8lUMyy7pQIiTCfRSMslc33WDvKCAMvPzOyg
	La08FT85Y0SO936l+bWHUXdvh3xuMi0XUdwX3gMPLtl/p2kc
X-Received: by 2002:a05:6820:2203:b0:696:233b:20ef with SMTP id
 006d021491bc7-69c943309afmr13061081eaf.1.1779230474075; Tue, 19 May 2026
 15:41:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322052120.14021-1-devnexen@gmail.com> <EE9ACFDB-E601-4C1D-87D1-F5DAC2767CE2@linux.dev>
 <20260519145215.ef37484626f23a82fc7ef992@linux-foundation.org>
In-Reply-To: <20260519145215.ef37484626f23a82fc7ef992@linux-foundation.org>
From: David CARLIER <devnexen@gmail.com>
Date: Tue, 19 May 2026 23:41:03 +0100
X-Gm-Features: AVHnY4KpwUKI-oNYMLKNHdR25CFG2kd_rkQY2_D5LU7bDSFUMRfHw1eYs8vgCgY
Message-ID: <CA+XhMqxzen7g3H5=tENdPKxq0MqGHxpDsYdPFkPsWG_Xuk5Fvw@mail.gmail.com>
Subject: Re: [PATCH] mm/hugetlb: restore reservation on error in
 hugetlb_mfill_atomic_pte() resubmission path
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@kernel.org>, YueHaibing <yuehaibing@huawei.com>, 
	Mina Almasry <almasrymina@google.com>, linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-249707-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2268D585C0C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

 On Tue, 19 May 2026 14:52:15 -0700 Andrew Morton
<akpm@linux-foundation.org> wrote:
  > David, your patch had cc:stable but I'm not seeing a description of the
  > userspace-visible effects of the bug.  Can you please describe?

  When UFFDIO_COPY's resubmission copy_user_large_folio() fails (e.g.
  -EHWPOISON on a hwpoisoned source page), the per-VMA reservation map
  entry for dst_addr stays marked consumed while free_huge_folio() puts
  h->resv_huge_pages back.  A later fault at the same address then takes
  the no-reservation path and, under pool pressure, SIGBUSes the task at
  an address it had already reserved.  Each hit leaks one map entry for
  the lifetime of the mapping.

  On Sat, 4 Apr 2026 20:59:11 +0800 Muchun Song <muchun.song@linux.dev> wrote:
  > Should the Fixes tag perhaps point to 1cb9dc4b475c instead?

  Yes.  copy_user_large_folio() was void at 8cc5fcbb5be8, so the failing
  arm didn't exist yet; 1cb9dc4b475c is what made it int-returning and
  added the `if (ret) { folio_put(folio); goto out; }` without
  restore_reserve_on_error().  Will fix in v2.

  > Does this imply we might have similar reservation leaks in other error
  > paths touched by 1cb9dc4b475c?

  copy_hugetlb_page_range()'s hugetlb_try_dup_anon_rmap() fallback has
  the same shape and new_folio comes from alloc_hugetlb_folio(dst_vma,
  addr, false), so it leaks the same way.  hugetlb_wp() is fine -- it
  goes through out_release_all which already calls
  restore_reserve_on_error().  I'll send the copy_hugetlb_page_range()
  fix as a separate patch.

Cheers.

