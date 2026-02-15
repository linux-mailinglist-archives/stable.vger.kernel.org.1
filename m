Return-Path: <stable+bounces-216640-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iD2eIxAwkmk8rwEAu9opvQ
	(envelope-from <stable+bounces-216640-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 15 Feb 2026 21:44:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B58913FAAB
	for <lists+stable@lfdr.de>; Sun, 15 Feb 2026 21:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86B803008D2F
	for <lists+stable@lfdr.de>; Sun, 15 Feb 2026 20:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D24D3043BE;
	Sun, 15 Feb 2026 20:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P01W/YS3"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA129274B59
	for <stable@vger.kernel.org>; Sun, 15 Feb 2026 20:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771188234; cv=pass; b=mhLWz/sjORjqSbRGocJ41wTseH9pKhhgyCTSRcwJ1jdeRsSNTcfP6L+T0cajGIsnRX1r5lGyXKHIqNBBqQFpF9GcnUNobaY5ZudPmHOQ10SVIPb+Nr4KROEGLRoA4uCWI557pZpqAbWfTSNzZR8RrdEEoell+EF5fBQekSQtsaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771188234; c=relaxed/simple;
	bh=zD5CZP34AdfNzMLyyeRSFpmesixbFhvK4lsi6vLs53Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QxxFr8LNeY2fx0Cn5fWFavAWST2hT/vKo8709Wud3ksQsdGjzx0DlwkI0vEERAKVhPZC2rMVvYeS8bBw9mIn8GTekmVnuHBJh/TDkQvfi+L7nPZxpyP0CXSqZocYNb2F4lISpTy7MTM31lcmbg6CZpykQtPMetZTiDypOoh1D/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P01W/YS3; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5069ad750b7so24360431cf.2
        for <stable@vger.kernel.org>; Sun, 15 Feb 2026 12:43:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771188232; cv=none;
        d=google.com; s=arc-20240605;
        b=U3WsdydvKKbRK0wjbPq/ZXM5CKeMQfoT10ZpgrR/MXDYkWKfPtgHiyHja5ENKFclS4
         XzxA6SdvgrGNw3kWj1sB3YCCopmAwiHPSNfuzTxVOtzu2i+pLcNqM0zyBviIRKCx52Qg
         fMII3hNFE0316/jqsK16XNwRKcCGKzgGv7tuwLEMJEx0+MrVwNT+XG8EZvTIyFbMCjwF
         hUMLieXh16Rwcyvha4XH5y4uPT2rkHkWxgT71b5vTi0+fks2NeivXk7F09+eKkpWvc/D
         OmoxdBCDwVc+oBFniMKbD3HqAtzRyt/sdETj4DpYkqehJBRjz6VTlUKIsyMkGZB2u1E4
         eNyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sUYiczTId7sm36/pcGB9sAOFpwsRYPpRXY+ssJjaFVI=;
        fh=o33bYlUZG8tGkoIQzAdbLNHGplYT/qVoKeBp24mIeAE=;
        b=YZ7/yAXgWt4o5PoCouMFqHbNZQEpRGaFzjC444pnJNtwhqxmA7Nmw5XbQNkLuk2l4T
         ZaI82auT7f/U/bi1ebwO0D2ibE2XQ47w3aP/tT3XAWENWMiLJKUdKUM0+al4cjS+awgr
         kGivybifT/snZIu1Vlo1v61j3TVjYiqaxRPlePjb47Iq5Nkh+tEMJi9e3kUdLYxGA//b
         hjOMd8xhhdAwFqupNBoJIgj3sZfNG4Q1a6AyEVGWPDXiv0/h+8iv0B4Xozk6+AmpitLY
         CrMl+OHAVvlQv7WdLEz6oOYT+7X5AAJaaEIVW5fq6MRndkQf1fW6cL0eM1K/7RWC0Vi0
         iMDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771188232; x=1771793032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUYiczTId7sm36/pcGB9sAOFpwsRYPpRXY+ssJjaFVI=;
        b=P01W/YS3AfVe08mAkH9z8nsJGx0/Xe85vHYoQX52xDEMBB6Hi5jfkaGwvfWpr+gSVn
         P2FSv+LCICN3h2beM9mP4p5wEttmT0LkQKhBua2nqhIhqq3+OcAJiHpdsRpGlXQQX7gM
         Hafq/AtZymrPZtlwX21Vcs68/YB9YBRc2cZtpksa+iVu4kATPWVuz4V3T2B4O9oQBRtV
         3kuXALGHHl0lHnMn2b2cz4IVOPKm35xKDfOzJbgpt7mEJ65w8k/McAg5Qc4FSBKk08YO
         Kc3jf/FA/879scNf4Z359q61Di+xNajDL4cGN9i6irzvAHY+bW3lixUcVAiW3+RwIhZZ
         v0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771188232; x=1771793032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sUYiczTId7sm36/pcGB9sAOFpwsRYPpRXY+ssJjaFVI=;
        b=OhZXR8gu3pw8l4FXU7dNn/rPqNNah3uqbitkgHzVexYEvmd4d91RkNZNJyot+JOFjX
         QNH5yE+iVLJFYUpbhgScqHi5vQoLoTKyR6ezjQ1qPM6OB+7871WKE7bphB1aA+mz7/dD
         VS/rIDbc+fykarYtht1+eSMZKQ6xu5EeXmwS+9Lfr3hlINWIQIv2+RrQWpA1Bu+0okj4
         Tx67KPpVNYpZgFRXkM8IJBSjmXOYuUYA3Is69Knv7Nw9Z3UVLxSdNK5q0XIXAtzh1Jip
         RAXcbTabwsEPd+noGTTYK6uGUSn1HLNf95mc2OCi3dljO7nXxv2GqOaqwJ0TCHoAN3uA
         wcPA==
X-Forwarded-Encrypted: i=1; AJvYcCWY3zprzEK1olbefFHnaENXrtYxYqW4Moxxc/nt4jM2uprqozagwrhcWTSP0tddN44kUxLYz34=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdJ87vJ/QqaYGvbHkQqiBv03QlndCKXzbu78PNdm6Jn+5pbtDI
	Ugpmw/aLLGjSOQ46XfwsWlJwnDrUMLK7HFvmZbmi684eKQljWRYxFnPQecePpj8GT1HUyncmYbp
	lxDiFR5VA7vl65Iffl3XfgvM4t3Zjicc=
X-Gm-Gg: AZuq6aLYioIn1ozW+63Jw50CZ21xodkZihN/T6/6li52ohozXzIhgnlrHREADJfLEkx
	mCfuD+1DambNq7GmdzXl0IMoEATDyUutW99xpGXvMiZ2DLWrskgyfEJHUhU0Uj5nhsIF5GmrfcG
	XDXzOQ4rY/lyw8FanVMOitGrQDeCRwSZGxtaWHjSSorF3HK+aafLwERl6jnobB80mcIzBDIajWv
	a7EkiYIGgNkblGOGCfGQRnGaRwItDawzBPJpmdOfBx2anJHMrjb9OG/3HYNn5jjkCRDHOzwJjJI
	KuXafw==
X-Received: by 2002:a05:622a:58c:b0:501:4ff5:ae3 with SMTP id
 d75a77b69052e-506b3ffff08mr84696281cf.42.1771188231378; Sun, 15 Feb 2026
 12:43:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216-hibernate-perf-v3-0-74e025091145@tencent.com> <20260216-hibernate-perf-v3-1-74e025091145@tencent.com>
In-Reply-To: <20260216-hibernate-perf-v3-1-74e025091145@tencent.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 16 Feb 2026 04:43:40 +0800
X-Gm-Features: AaiRm52fgDtfNvU3kxKbZLjl0RB593izYUrm1DGrHb9hftHazRJhLykKi9hoAlw
Message-ID: <CAGsJ_4zTCnL-bYN+nMXJEDPqHtF3hgiyHwyCoTc+nb-t6wouRg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] mm, swap: speed up hibernation allocation and writeout
To: kasong@tencent.com
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
	Carsten Grohmann <mail@carstengrohmann.de>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-kernel@vger.kernel.org, 
	"open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>, Carsten Grohmann <carstengrohmann@gmx.de>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-216640-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,huaweicloud.com,gmail.com,redhat.com,carstengrohmann.de,vger.kernel.org,gmx.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[21cnbao@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 3B58913FAAB
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 3:00=E2=80=AFAM Kairui Song via B4 Relay
<devnull+kasong.tencent.com@kernel.org> wrote:
>
> From: Kairui Song <kasong@tencent.com>
>
> Since commit 0ff67f990bd4 ("mm, swap: remove swap slot cache"),
> hibernation has been using the swap slot slow allocation path for
> simplification, which turns out might cause regression for some
> devices because the allocator now rotates clusters too often, leading to
> slower allocation and more random distribution of data.
>
> Fast allocation is not complex, so implement hibernation support as
> well.
>
> Test result with Samsung SSD 830 Series (SATA II, 3.0 Gbps) shows the
> performance is several times better [1]:
> 6.19:               324 seconds
> After this series:  35 seconds
>
> Fixes: 0ff67f990bd4 ("mm, swap: remove swap slot cache")
> Reported-by: Carsten Grohmann <mail@carstengrohmann.de>
> Closes: https://lore.kernel.org/linux-mm/20260206121151.dea3633d1f0ded7bb=
f49c22e@linux-foundation.org/
> Link: https://lore.kernel.org/linux-mm/8b4bdcfa-ce3f-4e23-839f-31367df7c1=
8f@gmx.de/ [1]
> Cc: stable@vger.kernel.org
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/swapfile.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index c6863ff7152c..32e0e7545ab8 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1926,8 +1926,9 @@ void swap_put_entries_direct(swp_entry_t entry, int=
 nr)
>  /* Allocate a slot for hibernation */
>  swp_entry_t swap_alloc_hibernation_slot(int type)
>  {
> -       struct swap_info_struct *si =3D swap_type_to_info(type);
> -       unsigned long offset;
> +       struct swap_info_struct *pcp_si, *si =3D swap_type_to_info(type);
> +       unsigned long pcp_offset, offset =3D SWAP_ENTRY_INVALID;
> +       struct swap_cluster_info *ci;
>         swp_entry_t entry =3D {0};
>
>         if (!si)
> @@ -1937,11 +1938,21 @@ swp_entry_t swap_alloc_hibernation_slot(int type)
>         if (get_swap_device_info(si)) {
>                 if (si->flags & SWP_WRITEOK) {
>                         /*
> -                        * Grab the local lock to be compliant
> -                        * with swap table allocation.
> +                        * Try the local cluster first if it matches the =
device. If
> +                        * not, try grab a new cluster and override local=
 cluster.
>                          */
>                         local_lock(&percpu_swap_cluster.lock);
> -                       offset =3D cluster_alloc_swap_entry(si, NULL);
> +                       pcp_si =3D this_cpu_read(percpu_swap_cluster.si[0=
]);
> +                       pcp_offset =3D this_cpu_read(percpu_swap_cluster.=
offset[0]);
> +                       if (pcp_si =3D=3D si && pcp_offset) {
> +                               ci =3D swap_cluster_lock(si, pcp_offset);
> +                               if (cluster_is_usable(ci, 0))
> +                                       offset =3D alloc_swap_scan_cluste=
r(si, ci, NULL, pcp_offset);
> +                               else
> +                                       swap_cluster_unlock(ci);
> +                       }
> +                       if (!offset)

I assume you mean SWAP_ENTRY_INVALID? Would that be more readable?

> +                               offset =3D cluster_alloc_swap_entry(si, N=
ULL);
>                         local_unlock(&percpu_swap_cluster.lock);
>                         if (offset)
>                                 entry =3D swp_entry(si->type, offset);
>
> --
> 2.52.0

Thanks
Barry

