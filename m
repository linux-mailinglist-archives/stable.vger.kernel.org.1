Return-Path: <stable+bounces-249639-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJ4IE6+PDGqGjAUAu9opvQ
	(envelope-from <stable+bounces-249639-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 18:28:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7D25825F1
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 18:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0D30E305083B
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 16:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED2940961F;
	Tue, 19 May 2026 16:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOJL2ScV"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C7E3EA961
	for <stable@vger.kernel.org>; Tue, 19 May 2026 16:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779208044; cv=pass; b=Vnh1uJdI9YnlCR2khNI0yCOk0+UStrdnOUDaFPhsDAdN4ikwoJ9QF0SPGw6BCJS5dChoABQa5f+ytrZghoTzu5DOagY0yVFhMH2xZD9Fh0YfQi5qyitmG8HPxt2tE7i+Lx//+6yvzzIxARtGv00cMXSqtoR5MyEwmuIzygtfEfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779208044; c=relaxed/simple;
	bh=B6BJ3Zsa1dczVVp0M9UD9HVDpJCBAvt2NLaHwYhQoew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fq2wTR/b2c4zGUDP4tOzOe2mOFd91Kq4DQGl4xLKR2csgL6wMyOBn9Fda5z31UhmR0KhbYBYc3a3LUkES44PHfK9Iu0C2UOvsV7N3lQJCpRjA11VGcd15ZDsYYRLuREnCOUxbgBXQA/A9JdPY7FEfWj12B2T50+QAf17qKlrEgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOJL2ScV; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-67be871ed3fso8541650a12.1
        for <stable@vger.kernel.org>; Tue, 19 May 2026 09:27:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779208042; cv=none;
        d=google.com; s=arc-20240605;
        b=Mw4xTbHJQp5pcXVZ11irBIe7hA+1jeS6o+pydxa5gWSmRxuL9HREjhtQRTNRYOQ4St
         GANxPseVbG3YKdkBxW1P/nYlLDoVzefR8Zv3KfkLXfz9E+5g7Fba5PQtV7BovD3C5kAH
         LKC40gHQESU+x6MSwKFG4Sc99Zeb9bhhwtZpndC/SrJWbxCEiGyRyp3sGp8aJzyKteKx
         /Cyu/skr9xr06n1tGQ7LwO9Iu8Gg3v0WKs1rt15xPSD9MjBxYaF7cJMO/ttmXzfQYj3i
         f39hFEV2W3KAKnx9QfJnKOF+flab3DBB9iGEvXegK5obHTZlk/OSGr5g//EAun6oXNjn
         mpEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5usbpjdW6V4GRZxIENdpTSPGB2A/F8Hn+HvhpsraCUY=;
        fh=Bj0OGKGfw9tBcOhwF0uXUg+irJ1w6Qb9ZFiZveDEdvo=;
        b=cQeq4AmUK9ACgM65wxJc19KSNXlOaw06LWCuXDMI+9haZT4UE2L+NPEVQWJ2LYMwB8
         ms5Ry947CX3CqqO2XQ5+aLxLeP8sUCCMX5/VojnhXVM7eZqHDqRuMFf6leQvt7BG763Z
         hCDHugGMX1TwI0kxUU9jCO1JahR0vi+deN83GgiJc+cGRGvki9BG8cYQfqfCiOOumAlr
         kTFbWDNv1z/R3+rLOj/8fztNkCOls1/PuWY0sei0mUrH/ZVbO65gWNeNF318Njk7TS9c
         V91lkdqXY6vHdL2HU0ugWfNPka4fxXqIyosp09Nki7fjBl+hHk+dPnRf2shxLUVoRwRc
         D4Gg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779208042; x=1779812842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5usbpjdW6V4GRZxIENdpTSPGB2A/F8Hn+HvhpsraCUY=;
        b=AOJL2ScV0gHxhzWMeYgnozojKksV50S1PyHfAe/SxObvSctFfnHXVg8CUtIYaQIjkJ
         UYoxR1Cc1HkdTH017gSzgDk/Q3vi/IF1JyAO8VQ2S2iCiFZIDISVzjhA8qFGOeQI+ZyQ
         VN0gWXhJQ9XewAy1hq0dzeuh38Pho5sLIsMxdnMgiry6+8+PtGABzkOwEimxQv+Anl81
         WEaOqwvpBFdE/StwUKuesxG5tfcICuoYMlHULWFbgbhffOxillFKB5su4gH/5Izr7cLr
         NbESmd31uNVV/4hxMNvFFBbWYldaeFIc8GHEocRTp14kN1nvaPARPYLC9TuDey3HnuCF
         mmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779208042; x=1779812842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5usbpjdW6V4GRZxIENdpTSPGB2A/F8Hn+HvhpsraCUY=;
        b=AtPb0G/nWDrW24ERZC5vgcdRFCB5v8N/7eZVCHci5vMHWr6nR7p10bnuWqgc0/sZa1
         C12pOJtmjos+Ah+7sSTfkN6zPHb2XHG27e2wgfmKBglSeOBhNgAQaDhKbCqPsw06uzxH
         lhfGH/EGHJtanCX260F3uXTfQZJ85r5GWEdYY4bnlrQOn4g7kOP3cLvyuEVWkYOxx2j8
         SekcbQ7p+o9dJ2QH6IXAIEizKN5Qh23XyRnc/ozhNsmBMKLMx49NaouHIQc22OGqWIf5
         RGqclgz8ni0Boi645jqVzHNPv4FmmGu4DlbpG0WFhL+8jGeKkpIkqvhq1ReiCpoCE9BM
         w/Bg==
X-Forwarded-Encrypted: i=1; AFNElJ9adggffv0fyZIfQdTt6RNhxa9kjsVQ+0KioCDgFz69J9wWknKdldUPbTEinV7XyHKV00RIju8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF6jU5fUpv7wnzGIM0bGRTk+d5Nw4/jN0ek/ytvmhIMKUIYJ+a
	SF0XheLuy3e46V1OQ9kNMf9wgi5GUqkpUgrPuf6R4l3kPo5ySYsm69lGmYEIaLGr1fRotWFio34
	k4lIo/IPbLoc+7c+DfIufAMmbYr1kW5A=
X-Gm-Gg: Acq92OFhxj0YrzHT/OHKNQH4fbZfCgLoj+Fx+60eRrgyhSOMvKptYQBd/Ncib3neuxh
	CLH1P9xV4Gn/x2GdRMUVKqIQ1+mostusmX7uz56JVx3872o7T66qJCDvjtepWi2nce3RW3/ak8a
	2vrlZ9bxTDGMWYeVqpvmOfDOoghn+3p0wXjGDF05g7NU9zTHvn2uaYCGzxMZOT347mEm6fiaoRz
	23uh7P1o2938HhPvIwiDa0U4HWUUjaiFX/MR06TmkWux7rDNxvM16N10PzHmlDXcUHwvM0OkSTc
	L6d3s1DEGHU2Kz2CFn2nxkBIZ9AkvQN3bjej5ZWy
X-Received: by 2002:a17:907:9719:b0:bd5:2a43:b471 with SMTP id
 a640c23a62f3a-bd52a43b4bfmr929160266b.48.1779208041621; Tue, 19 May 2026
 09:27:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519151008.1399226-1-qkrwngud825@gmail.com> <5d00b63c-1802-450f-8e54-8da6c0aeedc2@intel.com>
In-Reply-To: <5d00b63c-1802-450f-8e54-8da6c0aeedc2@intel.com>
From: Juhyung Park <qkrwngud825@gmail.com>
Date: Wed, 20 May 2026 01:27:10 +0900
X-Gm-Features: AVHnY4LdRR3qD6dMJRp9P0dqGJ2iwd73wpIsKyKrAimUaQe9thTXgPYirbbLgfM
Message-ID: <CAD14+f2p7D6eco+-O0X6zWwi-XaxGLs0nQKDAC8eVWhQmB1VhA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249639-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qkrwngud825@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid,intel.com:email]
X-Rspamd-Queue-Id: ED7D25825F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Dave,

On Wed, May 20, 2026 at 1:02=E2=80=AFAM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 5/19/26 08:10, Juhyung Park wrote:
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
>
> I find myself really wondering how much of this came from a human and
> how much from the LLM. Could you share that with us?

Not my first kernel contribution, just so you know. (first in mm tho)

I asked Claude to write both the commit body and comment and it was
too verbose. I manually trimmed it down.
Sorry if it still sounds too LLM-ish.

This was tested on a VM with virtualized CXL device and toggling it
back and forth was visibly causing leaks. kmemleak was unable to catch
this (rightfully so), so I skeptically asked Claude to see if it can
figure it out while pwd was the kernel source the VM was running.
"Access the VM at "ssh -p2223 root@192.168.0.185". There's a memory
leak whenever CXL memory switches modes via: daxctl reconfigure-device
--mode=3Dsystem-ram dax0.0 --force, daxctl reconfigure-device
--mode=3Ddevdax dax0.0 --force. Figure out why. If you need to reboot
the VM, do not do it yourself and ask me."

It did in 6 minutes and it basically told me to revert bf9e4e30f353. I
was very skeptical and reviewed manually (with my short knowledge of
mm) why this would be a correct fix.

>
> We're trying to get _away_ from using the 'struct page' APIs on page
> tables. This goes backwards. Worst case, do:
>
>         /* vmemmap PMD leaves are not compound pages */
>         for (i =3D 0; i < 1<<order; i++)
>                 pagetable_free(page_ptdesc(&page[i]));
>
> Right?

Shouldn't I worry about the loop overhead? With order =3D=3D 9, that's 512
iterations. That's compounded to O(N) when the entire memory size is
in consideration.

>
> Even better would be to *make* these compound pages.
>
> Even better than that would be to use some 'struct ptdesc' space to
> explicitly store the order, just like compound pages. But that's
> probably not trivial and probably not great for a bug fix.

