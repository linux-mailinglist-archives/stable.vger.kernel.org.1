Return-Path: <stable+bounces-249645-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FN+JdmXDGphjgUAu9opvQ
	(envelope-from <stable+bounces-249645-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 19:03:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 31991582CB4
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 19:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8BBA4304E402
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 17:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D9F3264D8;
	Tue, 19 May 2026 17:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oPHWBoR6"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997F8409131
	for <stable@vger.kernel.org>; Tue, 19 May 2026 17:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779210009; cv=pass; b=joWRzODhsjV0dtJdxAfrwUNVwI4NKwjAVt5MRCOuewn7mX16lRgEFfTTiZmY48KDVgi0x9YTmof6byFhmCKb7uEFwsg8yBgrGeN82NzHosvFpSsBS28tQ4IMwVvTbWFRHm04jz/EctqA5yrBqNGT7qH+qJaARYhl3Y4zuppOWEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779210009; c=relaxed/simple;
	bh=CAA/xks5Y5gsSYqPnbDpUtTl6A+TM8EjrXGeuoOa8QY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QeXBZyXei2WeL01KlpDEx1YNnMgbBbY7VDAe7OVi38Aunn+H1tBxLQiXdxSuZDDcyedUAUbxiUMtuz/VPOvGw2CVwJxWIupm/56ueOX0h++UKtDm1BtY4aJnUuM8fWhsESBOpFzPXRFgYf5mwKaYJTtZI+3uR0XVhZa0uzBHJi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oPHWBoR6; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bd11a3729e8so641640066b.0
        for <stable@vger.kernel.org>; Tue, 19 May 2026 10:00:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779210002; cv=none;
        d=google.com; s=arc-20240605;
        b=eUtIHpL+TZ4EnErcMnBNaF+8paE5acFUtsSO66jLPTf6KNILu20hq5sMrifbkLDguK
         BuFcws1Tb+K8A8J6B1GbGZsh+2ZP9hbnQYntbcTZqQR1n4taF4PfEECB00HcnEH7ZlRD
         1Tvio5ouz6VaOr+ez2JwV6TRKXYPaPu72Naswi8XShqFhxgMKjB2zrwDP8N130km2C/V
         8W+sHoDO2BTQlKYab4UbAEY+iMbQ3nCO8+P+B6EVuMabm/OWL5MgU+zz+ljklhLb8V0k
         0WBP5NfOQ5FXxvRiqBJCbbCZ2l4J8QllCt00ZCeM/gjO6PTUG9/8iHqmyhpFZMjU+dzc
         YOyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pyhG4QIZqICKavDwcU8OoLlp4cF7iJkoZFMHnoscP14=;
        fh=CJM67CiwL6umorZXdgn8u8A0Qy5eu+ks4RYqL54wDV0=;
        b=jx3iKhhJMs53lg0+uZlZ1e8EG6g7qL3++WAvzBgBseNYTiW4pPrKYmatqjNLn/esi/
         PKEaMbn/nF1LZH3aGqs9fZAdA40Xd1DU95+Mh6Rso3XFe5Y/ylPFA1172BL8HT0tQbKF
         wuTlNBiiAcCf2JMHHUKm5ti2bcOPseJXy9NcsWi/sybcy2aek2PISqh1wjyHATSWIETu
         dWKjEk6VbujPmNEnnwrhNK8rm85zGELHaxT0unP0khjcgNfSGLQwtT6DNUWKIFCws6Ig
         uB1rSwxBweyiJvP++lVoiPAzSAPmzy55evmox2EQapR01lfhQCFiapI73vsxE7KCYS6b
         aXtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779210002; x=1779814802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyhG4QIZqICKavDwcU8OoLlp4cF7iJkoZFMHnoscP14=;
        b=oPHWBoR66St03Xr29tlArhBtnXu2DLE2rvcvDEXaFR0ZYIltbj8pO99MutDP4Hs8y1
         qURR+BI1RBFv4ES2d8ywDPhdt+/kZt/4DvP80129EbcDzt5OcWUFAMNmG6YJITBbHA6G
         k/BhQDelw9MM6OxEgp3flPOzIWlAoK0xyq372WFKPIA8h/6J7zZn/8n9xCG6Sr0Y7FpR
         gsfTQQz/91BFnjrELwPGulvdVg9NbwCI7U92RW2PE/+Q006kGqGBuKWhJ6/+0mr/SMes
         XPxTj54nEUFGoTKzpeCLFRqUB2wrZiU/HZpp+3hvZBpsfwiOfV+Lt0U0zvmO8UkY0qNt
         zQMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779210002; x=1779814802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pyhG4QIZqICKavDwcU8OoLlp4cF7iJkoZFMHnoscP14=;
        b=capCvmAFwQiOvAtMdwqjHowuBxBw4PhY0iDT8FcsHbwlI+/MPyFdWYogHnU3ml2/ke
         fWbtbHsxvhUR7yxM04pmldlRNMHGEBoBaGZOaRBrEmwb9cpJteEJhWeV0tzNoMUZou+H
         1zONj7uL8fCXUeBLnzWDmAgTn0zSHnLhfyobQN6WOaciwPoEmeGz8NDAimIH4fK2gzva
         f/AhXf/PFf4ML8iTcyJ3crhiO+7K4bVn/6r3mBjlpa7+jBbwd8zRSNHARHwBH64klxju
         3mTP3LkzKtnFtjgQhJL1kWi6uQujbnLHUSyPNihoDrZMoJHhLixHZXAdUlgAXSV5Pb9E
         qhvg==
X-Forwarded-Encrypted: i=1; AFNElJ/WCZm6P4N/aug5WX0lUpHB/rG8whLo9eB++wItVLHbwjGwuJpMZRCM+xBZ4atz87L9dr1Jvzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTziIvRckIe5HKVDR15rzwaDkPFZgEt5AMMYU1iEq59KwzcyBX
	xHK9i5JcINHFNQH8OEc3lesmI3OR5wBOQW4JD8c8ov2TOXoK9co6N0LN0rNdGmaFNzL0p8NpbnA
	TCTQxH5C2bHsKIeT4qg66EJTy68C6eBA=
X-Gm-Gg: Acq92OGu1TWW0C4ij6K7ll6z5ZDCrmt/SLU9eFtuepqHKHIEEttDz18lWdWvP0qkBZL
	tUpF9G+PUB/R4DYhzM737R0b2/eWKbH+QUKlQa29rXPvpAEifnqlQycPmTA1beUo8un5hQY1EEt
	2TYmG9qeN29dYrwShmsF4Gjz9xIQB5q2WD9/otuTYGpTRnIcUzlxUu2oHRWTNzwZRP09R4nGcTR
	8JVP53u/4OGBeqUDLFI48SwjkIO/1u1YE6AWG4kksNn48XaqsOXMgMxMtyNsQdVTFfouE6sfTlB
	SF/LQs+ny48IT0q84iaf6oNGipEACcaPiTQwUwa1MkPKaXgmR6M=
X-Received: by 2002:a17:906:f59b:b0:bd6:4d6d:e02c with SMTP id
 a640c23a62f3a-bd64d6de820mr859954566b.2.1779210001640; Tue, 19 May 2026
 10:00:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519151008.1399226-1-qkrwngud825@gmail.com>
 <5d00b63c-1802-450f-8e54-8da6c0aeedc2@intel.com> <CAD14+f2p7D6eco+-O0X6zWwi-XaxGLs0nQKDAC8eVWhQmB1VhA@mail.gmail.com>
 <e38e5fd0-db57-417b-a2d1-0521333ae7cb@intel.com>
In-Reply-To: <e38e5fd0-db57-417b-a2d1-0521333ae7cb@intel.com>
From: Juhyung Park <qkrwngud825@gmail.com>
Date: Wed, 20 May 2026 01:59:49 +0900
X-Gm-Features: AVHnY4K5SYQOv34TwiBv3zKFQF1M6Tyl-TeVLU2eS0aTWiFY5udiXMkdBY5RsDs
Message-ID: <CAD14+f3sohXj9SKEkRXGK_Mpbp73R5az-tsiHnHkj0poBHwpvw@mail.gmail.com>
Subject: Re: [PATCH] x86/mm: fix vmemmap leak on memory hot-remove
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-mm@kvack.org, stable@vger.kernel.org, 
	Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	David Hildenbrand <david@kernel.org>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, Oscar Salvador <osalvador@suse.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dan Williams <djbw@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org, 
	nvdimm@lists.linux.dev, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249645-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qkrwngud825@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Queue-Id: 31991582CB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 1:41=E2=80=AFAM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 5/19/26 09:27, Juhyung Park wrote:
> > Hi Dave,
> >
> > On Wed, May 20, 2026 at 1:02=E2=80=AFAM Dave Hansen <dave.hansen@intel.=
com> wrote:
> >>
> >> On 5/19/26 08:10, Juhyung Park wrote:
> >>>  #endif
> >>>       } else {
> >>> -             pagetable_free(page_ptdesc(page));
> >>> +             /*
> >>> +              * Use __free_pages() to honor @order: vmemmap PMD leav=
es
> >>> +              * freed here are not compound pages, so pagetable_free=
()
> >>> +              * would lose leak 511 of 512 pages per 2 MB chunk.
> >>> +              */
> >>> +             __free_pages(page, order);
> >>>       }
> >>>  }
> >>
> >> I find myself really wondering how much of this came from a human and
> >> how much from the LLM. Could you share that with us?
> >
> > Not my first kernel contribution, just so you know. (first in mm tho)
> >
> > I asked Claude to write both the commit body and comment and it was
> > too verbose. I manually trimmed it down.
> > Sorry if it still sounds too LLM-ish.
>
> Yeah, it still sounded really LLM-ish to me. Still rather chatty.
>
> > This was tested on a VM with virtualized CXL device and toggling it
> > back and forth was visibly causing leaks. kmemleak was unable to catch
> > this (rightfully so), so I skeptically asked Claude to see if it can
> > figure it out while pwd was the kernel source the VM was running.
> > "Access the VM at "ssh -p2223 root@192.168.0.185". There's a memory
> > leak whenever CXL memory switches modes via: daxctl reconfigure-device
> > --mode=3Dsystem-ram dax0.0 --force, daxctl reconfigure-device
> > --mode=3Ddevdax dax0.0 --force. Figure out why. If you need to reboot
> > the VM, do not do it yourself and ask me."
> >
> > It did in 6 minutes and it basically told me to revert bf9e4e30f353. I
> > was very skeptical and reviewed manually (with my short knowledge of
> > mm) why this would be a correct fix.
>
> Neato.
>
> >> We're trying to get _away_ from using the 'struct page' APIs on page
> >> tables. This goes backwards. Worst case, do:
> >>
> >>         /* vmemmap PMD leaves are not compound pages */
> >>         for (i =3D 0; i < 1<<order; i++)
> >>                 pagetable_free(page_ptdesc(&page[i]));
> >>
> >> Right?
> >
> > Shouldn't I worry about the loop overhead? With order =3D=3D 9, that's =
512
> > iterations. That's compounded to O(N) when the entire memory size is
> > in consideration.
>
> Is it optimal? No.
>
> Will anybody ever notice? Also no.
>
> Will anybody ever care? No sir.

Just spun a test with that loop. It doesn't fix the leak.

I hate to be the guy that copy-pastas LLM but this is outside my
knowledge of mm. Claude suggests:
"Each pagetable_free() on the tails is a no-op: When
alloc_pages_node(node, gfp, order=3D9) returns without __GFP_COMP, the
buddy allocator only sets _refcount =3D 1 on the head page. The other
511 pages (page[1] =E2=80=A6 page[511]) have _refcount =3D 0. There's no
compound metadata, so they aren't "tails" in the folio sense either =E2=80=
=94
they're just contiguous pages whose refcounts the allocator never
touched."

Any ideas?

Thanks.

>
> Can you measure the difference? I'd wager a beer: No again.
>
> Even if someone manages to notice, then you have a clear path to fix it
> *right*: fix the ptdesc data structure to represent high-order allocation=
s.

