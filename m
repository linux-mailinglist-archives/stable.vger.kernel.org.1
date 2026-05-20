Return-Path: <stable+bounces-249803-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MiyGPSODWoIzQUAu9opvQ
	(envelope-from <stable+bounces-249803-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 12:37:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E0A58BDA5
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 12:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F40813076F02
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 10:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD68E3D7D8F;
	Wed, 20 May 2026 10:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s81m1jYs"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214EA3D810B
	for <stable@vger.kernel.org>; Wed, 20 May 2026 10:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779273223; cv=pass; b=ukQ13BoOepQrLZTP1JLnvnhYkw/SSikqXOZg7+lNEpBQviENQF+3Ab81al5dLi2W1QpKLIkkmJWc7S0LXVDkbdcYyVXSeThHyo1dweKlagXMnBcMFItsWDYkuJdBnHjKxgtpEgM9kA9oTz1k1iv8dVYoawM0lAE0Fiw44O4kljs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779273223; c=relaxed/simple;
	bh=I3nCSO8EnQlbzVzYsHNKe6zQ9gVE/7aRqrfkKO0oNLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JBQB60zIonWWIkppR5abfCp0K2V1RaBq1cmY0ekq13B/oj2qFVzwlWGFkKYH8jeJZwFU2p3J7yrMbi3TbJx11wiVokknTbKJ3IBH5dkUrMDAeSOYzPVW0A5oFKVui8Ff83qgPEc9GW4g9RARNfdBWpvpIrwwH28UfaGJ9RlWzAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s81m1jYs; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6763cc8775cso11377610a12.0
        for <stable@vger.kernel.org>; Wed, 20 May 2026 03:33:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779273217; cv=none;
        d=google.com; s=arc-20240605;
        b=Hbqgq+5NoFxUkD1HZFBSkMnVq3GN8NBFbbicwUrnC0q/RAMc08XHShsLTruAWcFAl5
         eqXaRzoQNtJ5NrADuSyE67XBI/Ty+wJlvlTPahH2VvmzXKyihJPEps6OL2f1BK7N5lnn
         FzJkwE7gLTb3rhKvCihJQq4Y47a6SQ8XDmY2OavUnT3waclT8rcYlJ7pm4j3PEBnxWao
         nOLiTJKPS7jXakYFrKcHPJnMEyRXiGl4FwUnvqCVTY5CwVF9vMMP3WlLiSun6vMFK4bc
         olY+bAMfsxTCGCbXkr5BAQQKfxbmQpKhN7d6uyA7CUjEvE/gtmB7odeHO2sjjXuomxT+
         a8uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CuNkcUrfA5La6Ov2pSAQWUelqrEhmV3emRmHUdz7AgI=;
        fh=CTTM8CTXpOychGx15i40DY+zbaA0vDAxNpgNiSC4nWo=;
        b=U/CKlLiHKNNLjD4UCsg9171C5byW9s/Q0OsYqPvT0nQSM0bZ1XrDgGJbCBegHdC6eL
         zM0nZeXjQ94/tuTkZ+BeT9QiNwZoWuaraWVr+u7Af5dBiWOjtXNTH2ipyNzC1qjkpDf2
         bWYjOCFerIWnPYcOQSNjoUGrq7UBR7IIl9aVpqIWqUXdn91rvigKYUDwY33MyFv6g0gB
         wZ5PXIOjB9UCqoggMjhqAaK9UMjTNhBX63FWsD2KoQbUgARJdZEo81ajfty3p1C6e9Ra
         QFjGKGN/Qd9fxQ3twqK9Io95QZll17cDWKJzA5TIyp1lp9EoZYpyPUrNcDAY+3Xc3euC
         a9bQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779273217; x=1779878017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CuNkcUrfA5La6Ov2pSAQWUelqrEhmV3emRmHUdz7AgI=;
        b=s81m1jYsA5EyNwOGcooePs7jzXuKz7Mfl4nK6berxNdmoFTLHb6tlPU+i6ds4juqkV
         rjHMMYsdufThTgfjAmiouitPBJLACnRTBATPRxyHIlfx91PJ/zd/BELKAQdN06V9L0eo
         KQn0b55DvY2kYLGsXvd5vC9+9VSL5sd3txPLc3h8F26HQrgNsbmc9GdeIceheYkA33P1
         Sn6swOvWZ+EDVKzF6xEwd5/iFavvx2sdVjeLeWISLBSYRDaHwh3S3mFAQjBf7yJI9np8
         9tqBZ1kZDj3E+CeS6gbrZojZlhwEoRWizEhoyJ6llq3Ta30Nkk72EzhBdKFiForwD7jL
         6GnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779273217; x=1779878017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CuNkcUrfA5La6Ov2pSAQWUelqrEhmV3emRmHUdz7AgI=;
        b=IHLMpUNSSHiJSuZKVNgUG2BtoFCMQyi5PLaOgk+oa2M/0Qki0yalsMZnp0odDhKpGT
         faoSRxEWiOZmbszHeI+ppMb5WkRNST2SnSglUQQky80SlOpmgZp6Gc/b3cB3sQLfua5f
         yPxYBPPqUKNALxKaxpCL4eXCS7PYjQOOjeeXeNMkF0MEGOoNb5eU+tRo4M5lH516RefI
         Yc+zWvnHmT1YKlH4kywMZnfCqVOoQyyFGKoRjMfo+uj08huxkTFEomV4aiGTkKucHdZ0
         heDOSd8djIZ5b6ewBSgNrpmNgLOZGkyI7+FBZGXP+HbLEcGk4yC+gU4nzOFUg6PRlxBt
         9eGA==
X-Forwarded-Encrypted: i=1; AFNElJ9JqNSNovYJ3WXQtmHn4+D9ciwVnTp8rM2x4Jlwi+GHVq3DSlnPR9B8kk5W1S6ckPZwo/YA8as=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWa7J/dYNpZS0ZAoIcxQRd5jFZFPcEvL55WxKqh3z+zi00t0lz
	2Z2bmBOhT++ob7UlpNhDonGd8eAisC1r6cY8k6thdDaFtTVdGgkdHxyo+RnFcrbPtoFV5GPhBSw
	ZIXApMSMacRjVrpQjVObOE7Jmi2dEqtI=
X-Gm-Gg: Acq92OFGDWVbV7Xg3XB6xIfympJLDzNQCpTvNtMW54MbyXghQh7gV5b6/mrk/mDJC69
	ZBlSxcEOhWwjIx2ORp59wWLWPH7vrjHFYJnKLo4TyEr6kEDtoO9MpbWlNDnl96Nkx9DSwJpHEnB
	dbQVs6+XBVGKDyLO9jfFcewjAPzqWy3NPWF5BAQzeUdkC3X/XVcxEj7wAh0hJ6zsWt/+8EAgcjA
	soseCvPp7Ot7V8F47qIBZqSzzX8BGG85G0LI2PEvZckeio2aqWl/0GJQv2OiroYU7lsKM9Gfu2k
	sOTFH8ECbWm8g4ObmduDsRtB72Qt6/E+DBaC98nU
X-Received: by 2002:a17:906:4fc4:b0:bcf:6ba7:4bf8 with SMTP id
 a640c23a62f3a-bd4f34bd118mr1396926266b.26.1779273217009; Wed, 20 May 2026
 03:33:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519151008.1399226-1-qkrwngud825@gmail.com> <e9a08bed-3d5f-4606-8d17-80a16a4c82f1@kernel.org>
In-Reply-To: <e9a08bed-3d5f-4606-8d17-80a16a4c82f1@kernel.org>
From: Juhyung Park <qkrwngud825@gmail.com>
Date: Wed, 20 May 2026 19:33:24 +0900
X-Gm-Features: AVHnY4IeL4rkcfGD6vJpoWHJPVsVY0mlOdz31w-7ieRtyfoF4Q7rZALT5Z8EpPQ
Message-ID: <CAD14+f316+wMZNm_sJF6ULRDUD9EbkdecdDwhGQKcsu70Bdp0w@mail.gmail.com>
Subject: Re: [PATCH] x86/mm: fix vmemmap leak on memory hot-remove
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, stable@vger.kernel.org, 
	Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Oscar Salvador <osalvador@suse.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dan Williams <djbw@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org, 
	nvdimm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249803-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qkrwngud825@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B7E0A58BDA5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Neat. Any sign of it getting merged?

Thanks.


On Wed, May 20, 2026 at 2:24=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 5/19/26 17:10, Juhyung Park wrote:
> > free_pagetable() is called via free_hugepage_table() with
> > get_order(PMD_SIZE) =3D 9 to free the 2 MB vmemmap PMD leaves that back
> > struct page arrays on x86_64. After commit bf9e4e30f353 ("x86/mm: use
> > pagetable_free()"), it goes through pagetable_free() instead of
> > __free_pages(), and pagetable_free() ultimately calls
> > __free_pages(page, compound_order()) which ignores the explicit order
> > argument and infers it from the page's compound metadata.
> >
> > The vmemmap PMD chunks are allocated by vmemmap_alloc_block() using
> > alloc_pages_node() without __GFP_COMP, so PG_head is not set and
> > compound_order() returns 0. Only the first of 512 pages of each PMD
> > chunk is returned to the buddy allocator on hot-remove; the remaining
> > 511 pages stay allocated and become unreachable. Generalized: roughly
> > 16 MB leaked per GB of hot-removed memory per cycle.
> >
> > The leak affects every memory hot-remove path on x86_64 when
> > memmap_on_memory=3DN (the default), including dax_kmem, virtio-mem,
> > balloon drivers, ACPI memory hotplug, and direct sysfs offline+remove.
> > memmap_on_memory=3DY avoids it because free_hugepage_table() then takes
> > the altmap branch and does not call free_pagetable().
> >
> > Reproduced with CXL memory toggled through DAX in a loop:
> >
> >   daxctl reconfigure-device --mode=3Dsystem-ram dax0.0 --force
> >   daxctl reconfigure-device --mode=3Ddevdax    dax0.0 --force
> >
> > Fixes: bf9e4e30f353 ("x86/mm: use pagetable_free()")
> > Cc: stable@vger.kernel.org
> > Cc: Lu Baolu <baolu.lu@linux.intel.com>
> > Cc: Jason Gunthorpe <jgg@nvidia.com>
> > Cc: David Hildenbrand <david@kernel.org>
> > Cc: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Cc: Oscar Salvador <osalvador@suse.de>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Thomas Gleixner <tglx@kernel.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Dan Williams <djbw@kernel.org>
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > Cc: linux-cxl@vger.kernel.org
> > Cc: nvdimm@lists.linux.dev
> > Assisted-by: Claude:claude-opus-4-7
> > Signed-off-by: Juhyung Park <qkrwngud825@gmail.com>
> > ---
> >  arch/x86/mm/init_64.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> > index df2261fa4f98..a2301bddb647 100644
> > --- a/arch/x86/mm/init_64.c
> > +++ b/arch/x86/mm/init_64.c
> > @@ -1024,7 +1024,12 @@ static void __meminit free_pagetable(struct page=
 *page, int order)
> >               free_reserved_pages(page, nr_pages);
> >  #endif
> >       } else {
> > -             pagetable_free(page_ptdesc(page));
> > +             /*
> > +              * Use __free_pages() to honor @order: vmemmap PMD leaves
> > +              * freed here are not compound pages, so pagetable_free()
> > +              * would lose leak 511 of 512 pages per 2 MB chunk.
> > +              */
> > +             __free_pages(page, order);
> >       }
> >  }
> >
>
> I sent a proper fix for this already:
>
> https://lore.kernel.org/all/20260429-vmemmap-v2-1-8dfcacffd877@kernel.org=
/
>
> --
> Cheers,
>
> David

