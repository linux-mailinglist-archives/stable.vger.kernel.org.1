Return-Path: <stable+bounces-217882-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFbiA/pbnWmxOgQAu9opvQ
	(envelope-from <stable+bounces-217882-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 09:06:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C24E91836AE
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 09:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF4AC302925C
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 08:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E396364E8F;
	Tue, 24 Feb 2026 08:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/xYP37F"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38302BEC43
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 08:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771920289; cv=pass; b=El1tW2hFGFfgCbM4+Rkd+O0d54aTyLEoR2TBPHc81EchL8WpuqYlUUD0I5Rr2LA0ZCj87azBaFzOaKiSeipt/YLuiQ9/Dchzir+5YtmRDL2urwZpcy9IiBdLlEfBmm+tMmqcrrws0qA40nL6PnUnBuCFRI6FLtkOHUQtdN4SKdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771920289; c=relaxed/simple;
	bh=q788u7OcaU/vO5vvo8loPawC/rSoTs7ixXhcvuFet7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bGC1+U/cGPR30a6Xxs2f589bU7a7uMVd3WdGZWvNeVy0+mc/5xRSXpo0hsfxvcnjt4yJjJbFWAp3q+iOqihkBDZaY1xuONwYFlpIKh/YwiTIly57IgZib/Xg+DFxJI5QB87mhHPI70SzdPI4wu8g5diRP5bvMfPJL6VLSOWAppE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/xYP37F; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b885e8c6727so913601466b.1
        for <stable@vger.kernel.org>; Tue, 24 Feb 2026 00:04:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771920286; cv=none;
        d=google.com; s=arc-20240605;
        b=YsPcR01Gfc3EL/rBJI55LOX4PplL6QOIfe9uq6IVKVkUFx16NsVqPjwOjyv/Cfkct0
         CKuNpkON7gCBXFanqyE+WgmHGRFMrv4736XV7wZqD0sYsqh8lB/1RXBKuXt4WmMeq27y
         CGhKHnpi+9SDXcANSYROgUjbzwbmdZhfb1dO5j+wH0WxgXEInA2jKQkiaIjMEiVF7UqE
         sz/iBRx2W9xFUzYxU3Y52NxS7OS+5yf8D/stmQPS3HJ+gj8+2GHObf+kAWqg9Qkm5HWR
         fw60WZkQRhLBmO54rMIPrJzyVKV8oTx05gxKbn+AHm6nXnTnDLHd+a8EqZU7DYHin/O+
         mUyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=drSksRq4NuWRvjnW2zeUkqenpzJUzAwBwFqniaqgFZg=;
        fh=xb915f5dAZ9OLbnQdZbVRte+cnYa98rk+U4Ap69ueHM=;
        b=BmPtBWaozL/zmuRf7U/kDns4vfdnVd0v5doZ1drTcMUjyVyc6AkvT0acDQwMSnDkwd
         1XNtnZ8ey2NQVwRa9EoUHODE2LTnw3qS/hDqYWfyC8jK8pvhKto5ybi8D4ESZWW6z3OU
         u7zqrkRts7d9GYG0uyAp+mTlDK9GwXAjxlccQ34t+D5LUyl1KkJI1pGnN9km9BLw8R4I
         buN9+gD4YN1UHAcyn6PaicARB6OmqsIFTO9RUxhpNLfX+Im7yhLPgQHdbZiN5nb0Z227
         PcdHdJC2wVZcwL1IlyoEmxni8P7O1rjzO6tOC0kndRSjHZJNe9VsvU29U0Yz+XlGAOUa
         Y+ZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771920286; x=1772525086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=drSksRq4NuWRvjnW2zeUkqenpzJUzAwBwFqniaqgFZg=;
        b=e/xYP37Fjw3+Z1uMaMAK08cKhplglvWfJZeOZzgZHGhyXTFE5h55+ntVV1iNjtrDfr
         kutW6O1xd66bSks6nktkIxLdFM160LyiBFXSdn/QDoN06bc+0tgH4qBMRtHPdjtQGJEJ
         wh5+EelLcd3Ef/A5wxg1bLWr4LIfu/zAlEjI87qMCkt/ooeiStq2w54ciOc1G+T5FHhz
         BbiMSud+b5gVqxiCEmeehuClRtq4uCkE+awJq0wxno9W6rlAval5kd71bloQXICsg8lj
         WWhmVN4SqySMLMyt+cGypUkgY6Rah+/+a/bS/gvfQ5dOUmjsMDfZdzbp0nrNbd+/nYIg
         ShpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771920286; x=1772525086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=drSksRq4NuWRvjnW2zeUkqenpzJUzAwBwFqniaqgFZg=;
        b=FOGczcfV6U+gRkr6O76pWt4yZWQhTdL7VKD2fVGLUvGzVFfasLJM9nxIUEEcFzxzdn
         Uws0PolI3/GVpYD4o8si3HmHpT2gFgNznnCs56kqE3aZUgzDguNw6l9nfK/l6hnxkEbi
         YJYmRbpotpX0cAaM8NrIpSF1eqXvKoS5o/mxc8QwOKcDP+M/wLPpeaP2PCs2gNHNFz2k
         dt0RupnCL3OkzyJyUN2qWgN740WYxkGSbU4XfxIPYzjNZVY2Vcqe9D+o6+eqtliuXV+S
         eydBvpk6IU5O4I3ec+fyPa5pUr16hHlyArYeZhQcHad2HOX9Kp9xMXGLgfppQycYevqZ
         UOgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYrXaMap1JgARQcJPVhZtLA8SWhfGqNTHrvShjC2g+zvm4ucMHhmB3Stm/ZpasAYMU8ZUxGzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzudYlB6T4ruk9R1hT121QXHymPOra01uyg4SPWcwGP3R0ItZSu
	wxwApPrsuhv5utXg2tssRiIJ5Q2Z/Gv+ZXHBm9WGAPu0TyJ4pQvR0vIGiOcfxdmK2oa6FFG+hIn
	weAKI7ZzrJgmG7y4S/jlbMUfMwK3KJZA=
X-Gm-Gg: AZuq6aI76gcmyIxYVZGrHHvys1fLfpYaPiSSXTYJNizEMwzJVaPDO/jVH6fIVlvQsQe
	Q/c3u3bvQM3SZDcOCmVugUWwzOyMnW3UBcf8/f5BhdqrgqTqrMRKmv/0VLMDnjeDhAgZIOkiTij
	EEOH+DdpeP91kXH9cTlwoVV436xPNevBJnw/N/4io+BKwyjytCKyMBSTKMIfJcIhK1l78F7t9+k
	tsX1D8fZckfXgNZahUVv4jfOo1MePPf480k5CWnv8jkrAtuUh43eZFMSJ6SQd8O5V4I1hP7QIXY
	vHNlSmsLMNHEd1da7GcfyQFsAXQPZTg4oKxpfyIf
X-Received: by 2002:a17:907:3ea7:b0:b90:77bb:5aa3 with SMTP id
 a640c23a62f3a-b90810895b3mr612662066b.16.1771920285771; Tue, 24 Feb 2026
 00:04:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216-hibernate-perf-v4-0-1ba9f0bf1ec9@tencent.com>
 <20260216-hibernate-perf-v4-1-1ba9f0bf1ec9@tencent.com> <aZ1X1OwbAUq1k+C6@yjaykim-PowerEdge-T330>
In-Reply-To: <aZ1X1OwbAUq1k+C6@yjaykim-PowerEdge-T330>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 24 Feb 2026 16:04:07 +0800
X-Gm-Features: AaiRm51-aSztyUVcxT5UZHw9khAHxRhvCbDhyMjH-cHVvB6r2w9pZ5GYsuDWoj8
Message-ID: <CAMgjq7BeA4cr5DSjpdaTVRRmcb_Pq+68yGZiiDg21fNPfGUQNg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] mm, swap: speed up hibernation allocation and writeout
To: YoungJun Park <youngjun.park@lge.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Carsten Grohmann <mail@carstengrohmann.de>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-kernel@vger.kernel.org, 
	"open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>, taejoon.song@lge.com, 
	"hyungjun.cho@lge.com Carsten Grohmann" <carstengrohmann@gmx.de>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217882-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,huaweicloud.com,gmail.com,redhat.com,carstengrohmann.de,vger.kernel.org,lge.com,gmx.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C24E91836AE
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 3:50=E2=80=AFPM YoungJun Park <youngjun.park@lge.co=
m> wrote:
>
> On Mon, Feb 16, 2026 at 10:58:02PM +0800, Kairui Song via B4 Relay wrote:
> > From: Kairui Song &lt;kasong@tencent.com&gt;
> >
> > Since commit 0ff67f990bd4 ("mm, swap: remove swap slot cache"),
> > hibernation has been using the swap slot slow allocation path for
> > simplification, which turns out might cause regression for some
> > devices because the allocator now rotates clusters too often, leading t=
o
> > slower allocation and more random distribution of data.
> ...
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index c6863ff7152c..32e0e7545ab8 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -1926,8 +1926,9 @@ void swap_put_entries_direct(swp_entry_t entry, i=
nt nr)
> >  /* Allocate a slot for hibernation */
> >  swp_entry_t swap_alloc_hibernation_slot(int type)
> >  {
> > -     struct swap_info_struct *si =3D swap_type_to_info(type);
> > -     unsigned long offset;
> > +     struct swap_info_struct *pcp_si, *si =3D swap_type_to_info(type);
> > +     unsigned long pcp_offset, offset =3D SWAP_ENTRY_INVALID;
> > +     struct swap_cluster_info *ci;
> >       swp_entry_t entry =3D {0};
> >
> >       if (!si)
> > @@ -1937,11 +1938,21 @@ swp_entry_t swap_alloc_hibernation_slot(int typ=
e)
> >       if (get_swap_device_info(si)) {
>
> Hi Kairui :)
>
> Reading through the patch, I have some thoughts and review comments regar=
ding
> the hibernation slot allocation logic. I'd like to discuss potential
> improvements. (Somewhat long... lot of thoughts come up on my mind)
>
> First, regarding the race with swapoff and refcounting.
>
> The code identifies the swap type before allocation, so a swapoff could
> occur in between. It seems safer to acquire the reference when identifyin=
g
> the type (e.g., find_first_swap). Also, instead of repeating get/put for
> every slot (allocation and free), could we hold the reference once during
> the initial lookup and release it after the image load? This avoids
> overhead since swapoff is effectively blocked once hibernation slots are
> allocated.

Hi Youngjun,

Yes, that's definitely doable, but requires the hibernation side to
change how it uses the API, which could be a long term workitem.

>
> >               if (si->flags & SWP_WRITEOK) {
> >                       /*
> > -                      * Grab the local lock to be compliant
> > -                      * with swap table allocation.
> > +                      * Try the local cluster first if it matches the =
device. If
> > +                      * not, try grab a new cluster and override local=
 cluster.
> >                        */
> >                       local_lock(&percpu_swap_cluster.lock);
>
> Second, regarding local_lock:
>
> It seems mandatory now because distinguishing the lock context during swa=
p
> table allocation is tricky (e.g., GFP_KERNEL allocation assumes a local
> locked context). Have you considered modifying the swap table allocation
> logic to handle this specifically? This might allow us to avoid holding t=
he
> local_lock, especially if the device is not SWP_SOLIDSTATE.

I think you got this part wrong here. We need the lock because it will
call this_cpu_xxx operations later. And GFP_KERNEL doesn't assume a
lock locked context. Instead it needs to release the lock for a sleep
alloc if the ATOMIC alloc fails, and that could happen here.

But I agree we can definitely simplify this with some abstraction or wrappe=
r.

>
> > -                     offset =3D cluster_alloc_swap_entry(si, NULL);
> > +                     pcp_si =3D this_cpu_read(percpu_swap_cluster.si[0=
]);
> > +                     pcp_offset =3D this_cpu_read(percpu_swap_cluster.=
offset[0]);
> > +                     if (pcp_si =3D=3D si && pcp_offset) {
> > +                             ci =3D swap_cluster_lock(si, pcp_offset);
> > +                             if (cluster_is_usable(ci, 0))
> > +                                     offset =3D alloc_swap_scan_cluste=
r(si, ci, NULL, pcp_offset);
> > +                             else
> > +                                     swap_cluster_unlock(ci);
> > +                     }
> > +                     if (!offset)
> > +                             offset =3D cluster_alloc_swap_entry(si, N=
ULL);
> >                       local_unlock(&percpu_swap_cluster.lock);
> >                       if (offset)
> >                               entry =3D swp_entry(si->type, offset);
>
> Third, regarding cluster allocation:
>
> 1. If hibernation targets a lower-priority device, the per-cpu cluster
> usage might cause priority inversion (though minimal).

Right, the problem will be gone if we move the pcp cluster back to
device level. It's a trivial problem so I think we don't need to worry
about it now.

>
> 2. Have you considered treating clusters as a global resource for this
> case? For instance, caching next_offset in si(using union on global_clust=
er or new field) or allowing the
> allocator to calculate the next value directly, rather than splitting
> clusters per CPU.

I'm not sure how much code change it will involve and is it worth it.

Hibernation is supposed to stop every process, so concurrent memory
pressure is not something we are expecting here I think? Even if that
happens we are still fine.

>
> Finally, regarding readahead and freeing:
>
> Hibernation slots might be read during cluster-based readahead. Can we
> avoid this (e.g., by checking for a NULL fake shadow entry or adding a sp=
ecific
> check for hibernation slots)? If so, we could also avoid triggering
> try_to_reclaim when freeing these slots.

Definitely! I have a patch that introduced a hibernation / exclusive
type in the swap table. Remember the is_coutnable macro you commented
about previously? That's reserved for this. For hibernation type, it's
not countable (exclusive to hibernation, maybe I need a better name
though) so readahead or any accidental IO will always skip it. By then
this ugly try_to_reclaim will be gone.

> Thanks for your work!

And thanks for your review :)

