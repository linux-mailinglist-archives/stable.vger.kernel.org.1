Return-Path: <stable+bounces-238467-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NFmGgT54Wn50AAAu9opvQ
	(envelope-from <stable+bounces-238467-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 11:10:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A134191BD
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 11:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD9C930CF16B
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 09:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388753B2FFD;
	Fri, 17 Apr 2026 09:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sq+VPdjZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81A13AEF30
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 09:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776416750; cv=pass; b=XbHzW92JeElHjgB50MwT5Bo22Ee6fWZRaKs2w9SgNVl3PafVxszWW+1BHL8zO7QK/JJDH7nKfuSpHmE/4mIYXCWbbRk9aeO3/83rmcnFOHdHoqPnXmr7DujPKFrdj9tmysDLk64YQEv2ZT6PB+5FlxflMxAyFgX8ApH7JiCSK50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776416750; c=relaxed/simple;
	bh=MiuYHW7wVgwTgBMl8xglfNia3wv18RcOD3OJCDOP2AA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uES+dg09ixAE77sN1uQ8EN6Hf95nlEQhvG2NAE78zHNV+HIcWF1sKPa7ExLNYNItPliTPVRNBxoFseXuGa8gJyjT/ZpSKAkIXhRtP898qGRDtm1Oovlz0rqv3QIGof4md6vgIvV/CjofauZGjbLw2TPG5SimY9awyyizJaj67qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sq+VPdjZ; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12c637089ccso1086474c88.1
        for <stable@vger.kernel.org>; Fri, 17 Apr 2026 02:05:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776416748; cv=none;
        d=google.com; s=arc-20240605;
        b=THVt/ltmaFLfqBhFhNtsI/d/d4D9ql/qRt2aCkrfOfRHrvcQM9Z4O2ewyDt4lifawm
         KxnNheBgPy0hOgUBkWiBZSYrKjStF3i9Z/j71osttGbzcCzeWi84W5sAM0aZdkkVOnph
         0kZGPrIoV+9gzInUtvtmH/60xaktfJxHO5NYY74J0GJxbnTfkJfzZhXv22dnmS5CTZcW
         qx48SGPmtUY23oxxRCpmRQYy8OR0LvBwJQPEiQpeg4rxV8CZpJ4uWwHqyy8s9A2VNHly
         fH4QF20AC83WtefwHykiNLfFK3r3cOndRiGhWwzqxENYkpuTWrIJ9lgn55dKsyGBALIw
         RXvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=m6h+hUT8JrfeVoyladjL7W9cfNjf2SDBTuYVEHwKaoo=;
        fh=/yDNFS0gpKTww8DeRMq7egtvBkU6yh2R6tM9dKZZctw=;
        b=hoqFCunVu/SUKTQd4SXbbJETnGF1MmEbfEgr7PNO+SOL500cxHzoYEmE0ls+LdVmkO
         Hx9id15n8i9cnImK2PNXY2tKB1p2Hry8awNec+7JqMddUCWZnTf86f1/9umDTMpgqtKg
         2KGUlf0tTT5G7+IxVXGuV0b/zhttUTosOdEU89EKe2BmZnvtePJUuacpA0t2/hgGrNT3
         zoX5ySpcyqp38xUMvBVzdkAGHd8yiduug/vwE3dwWgnVnp55lAEEyu4TSwhs5q3kkxMf
         k+BhLoQZPuXu0rq1Rb8hrUXOHuCmsVQgQCqbU+QS1thS+G6VrOGpQO5AKhBvCAhAUm9u
         YoDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776416748; x=1777021548; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m6h+hUT8JrfeVoyladjL7W9cfNjf2SDBTuYVEHwKaoo=;
        b=Sq+VPdjZS0STDPF6M3zXRgdOlQvuHu0VN6Bhyt7lJ3TSefSDv829jR91cmgDiOIBFM
         B0iozmEFikyy3i7NLmO8NV678Ujkt0i4ux8AUrp3PzQwY7cJ30x1yWodenMawIO/uZ5l
         MGeuf2ilDcT0VT2S3pJZN11OzX+mwuCYwiUxdZaz2jtmwGzbFP/xJ7i01FDBO0nWBjQ2
         FYDr38d860QiftMOk5c5Qjnn7CGi5r5ON8EsH04F+Oj3m5Xwn+ImWC53HsKOHSFc0rNC
         csy27YB7CROYqNgIAfStmEJBO7j4gv0yL16vvx1GdOtp+sRZ6bMAQAbQENMjf077l7+j
         r8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776416748; x=1777021548;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6h+hUT8JrfeVoyladjL7W9cfNjf2SDBTuYVEHwKaoo=;
        b=av771zujTG8MeLT2bVcksk98fN770NpzENzvAVEPmJEZR+IwrKrTMzKRVrBDc6QLDN
         hqJaYeRL8An/3SZ//nLKbhMgmCjt07/WO/ysQSTh8jCIx/Fs/OdFIz+xCFvMDb3ug0Fk
         7jrM57jUtjxTu+Mg1fRQEapb3Ss8lAFhfYTB1HYGBMbKlRGO2XUTkFK5yXxaSdzQdiY+
         SIodOHIIBRlLj5HCV1QKD2v53qoI9ItJ4Az+pLcK0qz0Y7LaN3sOmto2e6pR5mmbB91r
         6ziul6fflwt4FKMyl7fAIRyHFWaNWD3ba9xorVp6S3l8t4GpIKlh2GZns5FkYH7cpKiQ
         RikQ==
X-Forwarded-Encrypted: i=1; AFNElJ8PUi/h/kkkQofVtq5Ve6r5VWM/V8x4gNS66arRXDBGvTfFzhYdUH9jwwaahn2Vns5vQHZ+LeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFT3so/oCb13vNP1MEUQebhpcMT4CyngOrYiwOsnMnHUow2vYH
	lL2SQ/z0ngOUJzoRbzdkM6zK0IRWr3B6wEZlHhOewiiIEfA7PbMYMEO7KN8V9lK18URylimO+z4
	wgx7FTShLj4OD/MhZBxsgItFCNgYz5M4ez0UoymCs
X-Gm-Gg: AeBDievF8BPMiyTtVlVYBA2PkQuzbeT7uveajQ3vw/RXDwv2nQ4ECetNJvbgg+AxZBq
	a8zDlm0t0wczSEh54rpt+qoMu7BexVrikef3dxKjRhKBf1ldCGYRxO3vUTgVRBz7pUZ7FLbw8Gb
	f3iIe+pPKZ4Y4ZUmH5QBYAgzDRSjwy47zBFceUcT325fbpVEhIa5FweTE9q3lTvdqycfubmlaWZ
	oJFERviCd07up2qTdxI9cVobV1hdfkU240jeJl9e2mQc0kooA5T/WMVFaMsZpVtJZ0eEYmmgVJ7
	snQLBQCJ8tLoddzTwXm0h3oDrDbLBc9oft+48vB5dA85u7xQcw1OBhDFwM78rGcEYUIX8w==
X-Received: by 2002:a05:7022:6085:b0:128:bac0:2edf with SMTP id
 a92af1059eb24-12c73fb6c49mr915659c88.34.1776416747190; Fri, 17 Apr 2026
 02:05:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416132837.3787694-1-elver@google.com> <aeG6RG41sgZuerYa@hyeyoo>
In-Reply-To: <aeG6RG41sgZuerYa@hyeyoo>
From: Marco Elver <elver@google.com>
Date: Fri, 17 Apr 2026 11:05:09 +0200
X-Gm-Features: AQROBzBPHFPjIQbZYgiVCtPkYdTt_jdnGikf9TMYOKgcXpS_D48owm4g6Ox5x3k
Message-ID: <CANpmjNPMxDkzvVnD9pXy1YBTO4n-abQZ+if6XdDj-u4dnfks5A@mail.gmail.com>
Subject: Re: [PATCH] slub: fix data loss and overflow in krealloc()
To: "Harry Yoo (Oracle)" <harry@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, stable@vger.kernel.org, 
	Vitaly Wool <vitaly.wool@konsulko.se>, Uladzislau Rezki <urezki@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Alice Ryhl <aliceryhl@google.com>, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238467-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,linux.dev,gentwo.org,google.com,kvack.org,vger.kernel.org,googlegroups.com,konsulko.se,gmail.com,oracle.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elver@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 00A134191BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 17 Apr 2026 at 06:42, Harry Yoo (Oracle) <harry@kernel.org> wrote:
>
> [+Cc relevant folks]
>
> On Thu, Apr 16, 2026 at 03:25:07PM +0200, Marco Elver wrote:
> > Commit 2cd8231796b5 ("mm/slub: allow to set node and align in
> > k[v]realloc") introduced the ability to force a reallocation if the
> > original object does not satisfy new alignment or NUMA node, even when
> > the object is being shrunk.
> >
> > This introduced two bugs in the reallocation fallback path:
> >
> > 1. Data loss during NUMA migration: The jump to 'alloc_new' happens
> >    before 'ks' and 'orig_size' are initialized. As a result, the
> >    memcpy() in the 'alloc_new' block would copy 0 bytes into the new
> >    allocation.
>
> Ouch.
>
> > 2. Buffer overflow during shrinking: When shrinking an object while
> >    forcing a new alignment, 'new_size' is smaller than the old size.
> >    However, the memcpy() used the old size ('orig_size ?: ks'), leading
> >    to an out-of-bounds write.
>
> Right. before the commit we didn't reallocate when the size is smaller.
>
> > The same overflow bug exists in the kvrealloc() fallback path, where the
> > old bucket size ksize(p) is copied into the new buffer without being
> > bounded by the new size.
> >
> > A simple reproducer:
> >
> >       // e.g. add to lkdtm as KREALLOC_SHRINK_OVERFLOW
> >       while (1) {
> >               void *p = kmalloc(128, GFP_KERNEL);
> >               p = krealloc_node_align(p, 64, 256, GFP_KERNEL, NUMA_NO_NODE);
> >               kfree(p);
> >       }
> >
> > demonstrates the issue:
> >
> >   ==================================================================
> >   BUG: KFENCE: out-of-bounds write in memcpy_orig+0x68/0x130
> >
> >   Out-of-bounds write at 0xffff8883ad757038 (120B right of kfence-#47):
> >    memcpy_orig+0x68/0x130
> >    krealloc_node_align_noprof+0x1c8/0x340
> >    lkdtm_KREALLOC_SHRINK_OVERFLOW+0x8c/0xc0 [lkdtm]
> >    lkdtm_do_action+0x3a/0x60 [lkdtm]
> >    ...
> >
> >   kfence-#47: 0xffff8883ad756fc0-0xffff8883ad756fff, size=64, cache=kmalloc-64
> >
> >   allocated by task 316 on cpu 7 at 97.680481s (0.021813s ago):
> >    krealloc_node_align_noprof+0x19c/0x340
> >    lkdtm_KREALLOC_SHRINK_OVERFLOW+0x8c/0xc0 [lkdtm]
> >    lkdtm_do_action+0x3a/0x60 [lkdtm]
> >    ...
> >   ==================================================================
> >
> > Fix it by moving the old size calculation to the top of __do_krealloc()
> > and bounding all copy lengths by the new allocation size.
> >
> > Fixes: 2cd8231796b5 ("mm/slub: allow to set node and align in k[v]realloc")
> > Cc: <stable@vger.kernel.org>
> > Reported-by: https://sashiko.dev/#/patchset/20260415143735.2974230-1-elver%40google.com
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
>
> Looks good to me, but I think we still have a similar issue in
> vrealloc_node_align_noprof()? (goto need_realloc; due to NUMA mismatch
> but the new size is smaller)

Good find.
That's a separate patch, though, since it's in the vmalloc subsystem
(it's also not confidence-inspiring that vrealloc_node_align_noprof
has a bunch of TODOs sprinkled all over...).
Since you found that, do you want to claim it?

Also by the looks of it slub and vmalloc patches go through different
trees these days per MAINTAINERS.

Thanks,
-- Marco

