Return-Path: <stable+bounces-223480-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIJgAcE5rmnCAgIAu9opvQ
	(envelope-from <stable+bounces-223480-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 04:08:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C9223376E
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 04:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DA0AA3002B43
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 03:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224B427510E;
	Mon,  9 Mar 2026 03:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ks7JkhbG"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD197155326
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 03:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773025722; cv=pass; b=Yq1+C1u14+bPs3lpR2au48vTQ1nHhclrp2M94H0P22JI1bJy05XbhMsHrj1gABjC0fQ2VSSJQbe9JBhefcZUk/m1RQvmUDelLzX60JLZk1MjpG7sj3Y1ZMm3KnghaQ6jNKh+W2Lu6eAinaYsObW0Vgo5xwv+eEdImvKcMxYvrVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773025722; c=relaxed/simple;
	bh=fzqPjms/tffjy4BC2lVO9Tm/P6GB1dUduvpzcwiyUHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lvDjrhmOfMDOIr+fLkdvdvkKvgeXO1syPzlKZVp2am7dcH4Ew+EvrV7OGLXXGgTIwzDJrubIXUGI9pz54Nz95sxq9ZALcmsGk0A1H8tG+STTtl7nhmESAR8QHmN67P0vibpdocaCMUzP7lYtcIQjWqy7vKocdUPicUa0IfRoUJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ks7JkhbG; arc=pass smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2be1b5fe11cso7742675eec.0
        for <stable@vger.kernel.org>; Sun, 08 Mar 2026 20:08:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773025721; cv=none;
        d=google.com; s=arc-20240605;
        b=K/7nQUfS4yHvIB1GK0+VcLxNT4jYfb3NqOzxCUNQLo4Pa49tWbrj+OksIFvAOlmz11
         MCkzIvxX2sbfXbWsEemNOMpYAGxjNx7fMn0n7LQOwu4C/MU2UgQvBW1JDc22pVoSXhJn
         OcjKxc9fefRRCsLv4tjo/U8cLvtOln6WL2nhCc/oPdCQl7/Mw483/HdbFXtqB6qIIIJu
         TobtDc0cK5s/kVaWnvH3zBc05KEiCthOYEwp8hODt1mqA0CkxR0uI1BYGxrpIHDjR0Dv
         9XkS5barUEYFtYGCDVgelLcHq6oGQuhr6ReBDZvBKwIZHBuy8kvwMrv7DIbi05C8WwJU
         TCkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fzqPjms/tffjy4BC2lVO9Tm/P6GB1dUduvpzcwiyUHc=;
        fh=Mn60u8DNlCA9k7zDP/WhlBUjHW335kwykjmQoZcgqEA=;
        b=IhNvqRTIj+B0Vf9jKDDXUdthP5Jylf77lga9AkYAlsMzBdMeMPedr5uk7vrn9qVrXg
         KhQT4uArOylUdjWInxWUkSw8iZHlTrJXfHuMs8qZsBPs8OTPimGQAxObhp3r4U/7kFrb
         CcLRcRBvL3baNPsgSLW1TqILu4lXpq2/D4oJxPCn7V8XeyPtN3HVImEzkAaP/+nHJngt
         qrXh3q/D0ndp6juloArP9GWIExySuwSbj5oVxjmDewqy5Q7Itzx5g6YlfCuL8CRb+rl5
         ilADCzK/OlijCTOKZfH46Ff2xT5Aj5eDHeLQb4MQNsVKBFL7DxyggBlZXnQJBWcaSIXu
         8k5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773025721; x=1773630521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzqPjms/tffjy4BC2lVO9Tm/P6GB1dUduvpzcwiyUHc=;
        b=Ks7JkhbGh4eIKHbpBqKHYcuddl3UUhRfH+IA4hGF1FAkD88KJE6FwJM0L/jgrSZ7p6
         6VXxJS9LbiqG5piCREHYTnGB8MADSoK0NpCcia85ERn1SAwGPGnOLGfhw3IqciPwg5Ny
         FirM3wTuPv4KWFC+dOQFVav5WBkmrFSlibL+Gluvixqql1jhbxmheygabHMt2qmZVQXX
         GLjutv2BtWem3K1dGUNZV2DdMsvNYxDY0bW5/gziCgVo0XQFPRuhBRA8AFxZ/Noxo3jp
         I6vTyA9poaNNRnQXJ9Lbuy5tgwZe09Ilt4vLcXk1ehowrHFhAg1FFk9f2OkKWG2dzSOs
         UMxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773025721; x=1773630521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fzqPjms/tffjy4BC2lVO9Tm/P6GB1dUduvpzcwiyUHc=;
        b=HeAUzYv8aY56NqaQG54/hM33AKXAVQBZyHxGm/eDEoivcWX6tFKIPtyCJz9efx18MZ
         FOTUKXTnRdjoa/jGECpOm4VrHl5lGwPp9+48LjJWyNYi5G6l8oguPYVzXOTVNIwDUkE7
         0uk8cwd8SB0/cA3z5KKRATQQTr1I3CzxDcPYo9t99S77EDUT3XdA3McTPxo0W8vxWDhE
         xwa22LimorteD9KkwSRFhDf0f+pZ9FtjlPfg8/ipJo87PAYwy5ApvA4VcTyT1oyGb5wI
         JAuM90esvYWg/YhDfr9v46pD/xMsLsj9VIW5fQdw9x1PZ76wPM8yfvYO25zajgbkun8r
         DyCA==
X-Forwarded-Encrypted: i=1; AJvYcCVK7jXgKcpzS3++arvHb1tYfi6ECT6W82Ji5Z5ysxhNbVz47o1yuuDx3kPdc8YZt735k+P1THA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrb9IhpGKF94M/6QYfXKgE/D+iX6ye+ta4iR/aBR+IGH9DUXkV
	LLHBT5ipeg6AYx+Q6kdB8DQbwfOlkjCwmU0JpeQXkGIeLCA3tWDOI7wXHLMXh/60WkPK9YbzYa8
	aeSJNC0WmrIq2ehJakAeV97rCUtmRxuo=
X-Gm-Gg: ATEYQzyUDo7d4zrzQgQyoMkE6HhELj4y6dNBG3h3ZtW0XlRW/U/Q8CFwiyLRQuUY7eH
	FCPpQNF3dX7jto5eFUNJipvBZ+T/IrG0BzxsM+yPQ7x7rFsLumQxYrGusVfKUBBJy81Pmro1ycV
	DhbGMvUjpTu6rdVgGcGhgpSlivX5S02cmIFmnn2efaHKt8Lsz56gm23MG7mjZpGc6WDNsXkiZmE
	UPnUHdObQMHFX2rzAMMtstwY5LAuwz4QFEmGJduTNCza3fAmsktSPzCv/dsXiHcsHXZrTPJPG3/
	tG80Amr2DSZ7HweBYqT6iCeOyBUNXbvrd9URw2wOQA==
X-Received: by 2002:a05:7300:b90b:b0:2be:6f6:a39c with SMTP id
 5a478bee46e88-2be4dff28a3mr3189470eec.13.1773025720706; Sun, 08 Mar 2026
 20:08:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306140332.171078-1-jianhuizzzzz@gmail.com>
 <20260307143542.179953-1-jianhuizzzzz@gmail.com> <ffc6106b-292b-d8d7-3c34-aebe4feb6e5f@google.com>
In-Reply-To: <ffc6106b-292b-d8d7-3c34-aebe4feb6e5f@google.com>
From: Jianhui Zhou <jianhuizzzzz@gmail.com>
Date: Mon, 9 Mar 2026 11:08:29 +0800
X-Gm-Features: AaiRm5345nQP7wJtt_NLhvQXt--b6XhTjz5lByTfdLY_4-yd1IfeVU4kfncXG9s
Message-ID: <CAEgWzV62v3TPrvLLpQac-KBkDFNTWg-=V2Xep_2+h0c5NXOaYA@mail.gmail.com>
Subject: Re: [PATCH v2] mm/userfaultfd: fix hugetlb fault mutex hash calculation
To: Hugh Dickins <hughd@google.com>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Peter Xu <peterx@redhat.com>, 
	Andrea Arcangeli <aarcange@redhat.com>, Mike Kravetz <mike.kravetz@oracle.com>, 
	SeongJae Park <sj@kernel.org>, Jonas Zhou <jonaszhou@zhaoxin.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	syzbot+f525fd79634858f478e7@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 00C9223376E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223480-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.935];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jianhuizzzzz@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,f525fd79634858f478e7];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sun, Mar 08, 2026, Hugh Dickins wrote:
> I have not thought it through, nor checked (someone else please do so
> before this might reach stable trees); but I believe it's very likely
> that that Fixes attribution to a 4.11 commit is wrong - more likely 6.7's
> a08c7193e4f1 ("mm/filemap: remove hugetlb special casing in filemap.c").

You are right. Before a08c7193e4f1, linear_page_index() called
linear_hugepage_index() for hugetlb VMAs, which returned the index in
huge page units. The bug was introduced when a08c7193e4f1 removed that
special casing but missed updating the caller in mm/userfaultfd.c.

I will fix the Fixes tag in v3. Thanks!

Hugh Dickins <hughd@google.com> =E4=BA=8E2026=E5=B9=B43=E6=9C=889=E6=97=A5=
=E5=91=A8=E4=B8=80 10:09=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, 7 Mar 2026, Jianhui Zhou wrote:
>
> > In mfill_atomic_hugetlb(), linear_page_index() is used to calculate the
> > page index for hugetlb_fault_mutex_hash(). However, linear_page_index()
> > returns the index in PAGE_SIZE units, while hugetlb_fault_mutex_hash()
> > expects the index in huge page units (as calculated by
> > vma_hugecache_offset()). This mismatch means that different addresses
> > within the same huge page can produce different hash values, leading to
> > the use of different mutexes for the same huge page. This can cause
> > races between faulting threads, which can corrupt the reservation map
> > and trigger the BUG_ON in resv_map_release().
> >
> > Fix this by replacing linear_page_index() with vma_hugecache_offset()
> > and applying huge_page_mask() to align the address properly. To make
> > vma_hugecache_offset() available outside of mm/hugetlb.c, move it to
> > include/linux/hugetlb.h as a static inline function.
> >
> > Fixes: 60d4d2d2b40e ("userfaultfd: hugetlbfs: add __mcopy_atomic_hugetl=
b for huge page UFFDIO_COPY")
>
> I have not thought it through, nor checked (someone else please do so
> before this might reach stable trees); but I believe it's very likely
> that that Fixes attribution to a 4.11 commit is wrong - more likely 6.7's
> a08c7193e4f1 ("mm/filemap: remove hugetlb special casing in filemap.c").
>
> Hugh

