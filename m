Return-Path: <stable+bounces-216887-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DJSM5y1lGlbGgIAu9opvQ
	(envelope-from <stable+bounces-216887-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 19:38:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 902BE14F3B1
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 19:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 42727303C865
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 18:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BDA374170;
	Tue, 17 Feb 2026 18:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDK4YMyJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2B52D8393
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 18:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771353496; cv=pass; b=NtFLIMiq+h6poJ34xhupU07T1fi5UrdMl/NqgWNnNYvo7Ltd+dZVU/K1PdI14fCj/EzDoJEfZyzO2g47rANspYOnCXEPZDlxMsTHkFFPIKQq9QYLAD+4bkAO8pJ8S+gmd+7in41nREiADCnOj0q5CIRr5OYPeVRnfg6QrApq27c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771353496; c=relaxed/simple;
	bh=6+aIOqPXhpAr7dPhRhS5XFq9e6htkgUr0mLJ2+X2rNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kpkOHPgJIL5XX6iE9lVWu7gw78rVaChN+p7eT5nYvszvO2uCgKxgrgt9XPaejUXEKSsu4R9WZ5JByGGfhbIDpLx+Gj1QyM2KoPlp9/Xj6yMCcZPgikV3KLjJivJka0mM7wydny8dpIT7doFB9y/DtvNURrXJ+A32etcTos5zZFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDK4YMyJ; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b884d5c787bso605147366b.0
        for <stable@vger.kernel.org>; Tue, 17 Feb 2026 10:38:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771353493; cv=none;
        d=google.com; s=arc-20240605;
        b=dtDxe+K15swFS9d9iKYAtM0uCk69eEUaIeNz1omVOBwT2sH+QznawYH9TjfzemsUnD
         /LZqTOeJDEsm5t7Ew+PpZVfAuNLwvvXG1N9Q41p+M+rxn+7mQHbOLuaJ9G5w7v+sKMyy
         gLNm3ZuAhuv6UnVlKOhBQre7EleM7t3RrxeDxQiV91ZViAcTjLT9lWa1yFJp83btIfzf
         G9Vk0MVMFP4HZh61R8e1+ipQAWGBCUxIw5vxlhQpmcA3Dz9voh9K2v9vaBEeMRo541m+
         wEmOenuO8sNTa5qVfh7C4ifCyxZC+NFm1CEir4Hwhk0XdynDhtm8bzCbVz8L/+t+OIHn
         8ybg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L0kfgHuKL0CgrURLYBZypVOq8WTafDbOBreYdMsaND8=;
        fh=5HNWy0QflvO2meo8AbVaTtmEBv1ssVkGRGmMRL8cqWY=;
        b=ep+alYPIijr4RCxkwBYQS/26axVS9d5ySj5rvVt7qoAHdIXsDPwMy6MXAZ9/+2wBnP
         5OJNQ4b/tWkGLogRhgDIyrGE2mpddDhWONSY3vZ1C5YFtYygvGI2UatdHlOHtG/W9wvh
         KT6sHaQj6zGPf5b699kilpt8OlsCfA/Qcp/eoF8gFKF8u/B6n0BhRhZR93KWeb5iH5Kg
         E6/hPv3/udbC4tP93ynN59jZv5qxFJog1aEmjI3LJbDcyxpOi7olQbznInwgxg+FIhj9
         bx+QlTIWORCJ2jQMRBcvKvNID4KVXLc3J38V2yHPPv1Lu92mSOV43geUR7SLxt+GgOxa
         pZ+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771353493; x=1771958293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0kfgHuKL0CgrURLYBZypVOq8WTafDbOBreYdMsaND8=;
        b=EDK4YMyJK1lz0f9Y/YK4ggQRJACRHuYi2GrbYflgNNAHQ9k/qMgXVVfWMzVZSF+y72
         Wn6psEajRmObsSmzcr6eEfOTYhQ11kpbRbR88n4QPResS3hNXVpBMfZXW0zyY12DIJ5L
         x20MmSWMhuZAsGoA8yDv6jIG2t8v9x+y/n3RKPxQM8FsULlGtz9u5cmy6zwkUw6jXYCg
         1THEe+7p9qnaEEmrzUbQB4yhIgLXy2GSXN+a3KQY0c9FmYLCKiR3ji0YnpGN8ICC0JE5
         IIugICSv0eUI6/Hgf8ZzaUE1WL62l8nZjZasa1gIHquz1m5tfT5dJrgbn1vs7QPD7dWn
         xNpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771353493; x=1771958293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L0kfgHuKL0CgrURLYBZypVOq8WTafDbOBreYdMsaND8=;
        b=tkCBfCtKOLWKuWkBFGbjrt+fQYXUaC/5kqP2Y3ZXr3Es5au1vPi9kn9+nFe27fts5G
         fb+7ixkj7rBwZXuvlB7d1jkAVy9qMp8qjI9I6foyLP1ZRVNWx9wHUkLabD6K3WFHFd60
         GH8D3jCFxCMZPtoFpiXLMADrdjNGUbExNnGj/s+ukuJXKadiXCgK0HT7R4/EI/JOA2iH
         mbIf3vl3nqqha1Ed33T5fP9eHzjqCutNNP/hO2yMNW/xLlVEchXfd/waiQ2bV7cLmjGG
         3yzZr2iJ3VebCVuRTs5hJEuXlI1aiCvguTwPvOmfPgnyyeZiOCOO3t8sybHVhlvVzNhR
         QZlw==
X-Forwarded-Encrypted: i=1; AJvYcCXcg2CJyittDSC9X7oUjtEHDkCFc0SWMcrI2K1cUuVNGEraN1FPqK1VsHRc+fbpaI8mRVhn798=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX+qHX5nZrozAjc7NQim/JumrzIqohxlGKHB5ICJFmmXxoyD7D
	BrH3fTVlAUeI6GF4ckWsCAVD3ijdaUGVOBcmnQXrArkymS33m7lYfWvQ+izv7ZFPz5l2t+EL/J3
	kz5eMakwe31SRq07egQS5tr3CQJXoLfI=
X-Gm-Gg: AZuq6aIotqkdWw4Wh0Lo53/+op70/A9NTKSsu+1xEg4hL0kK6+6nVnG/jFHe6B7jbQ9
	vl/yvtKB5TDLq5zFriSdzxhp5/MRLCkuW/Z0dUbn+Bysm+9WQZP7Soo4n5gK1yieTP2ElG1NH11
	ltwnXppfuq+mlrWlXIDOosAkuHZSgi1GK3iUZ5T9NToM+q7yMMpgYdlnoDPWMnWyCu53GETwa0f
	yjcQH03OVkP9Nb+tZFKUdObBfMeRnA4vwHwmEZzazmtw9L5MfCEVu3qZtUPpwskBksDA5+sfc2w
	3LNc9dWNBl/ieaI/EuryeCSTic4FNytFPULfhNFP
X-Received: by 2002:a17:907:3d0b:b0:b7d:1cbb:5deb with SMTP id
 a640c23a62f3a-b8fc3b5abf0mr768614566b.27.1771353492689; Tue, 17 Feb 2026
 10:38:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216-hibernate-perf-v4-0-1ba9f0bf1ec9@tencent.com>
 <20260216-hibernate-perf-v4-1-1ba9f0bf1ec9@tencent.com> <20260216134222.5ec936d6503e72348227c58d@linux-foundation.org>
In-Reply-To: <20260216134222.5ec936d6503e72348227c58d@linux-foundation.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 18 Feb 2026 02:37:36 +0800
X-Gm-Features: AaiRm51x0f9h4WRnSrAyvxbfHlB_6iU_mFxctjVNumteF3OZtK_Fw9fGifvYBbo
Message-ID: <CAMgjq7BGAk45oYCcZymNUcRWU-T5k4AdzgAhk6mr+xPJyD3-uQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] mm, swap: speed up hibernation allocation and writeout
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>, linux-mm@kvack.org, 
	Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Carsten Grohmann <mail@carstengrohmann.de>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-kernel@vger.kernel.org, 
	"open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>, Carsten Grohmann <carstengrohmann@gmx.de>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216887-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,kvack.org,huaweicloud.com,gmail.com,redhat.com,carstengrohmann.de,vger.kernel.org,gmx.de];
	TAGGED_RCPT(0.00)[stable,kasong.tencent.com];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,tencent.com:email]
X-Rspamd-Queue-Id: 902BE14F3B1
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 5:42=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Mon, 16 Feb 2026 22:58:02 +0800 Kairui Song via B4 Relay <devnull+kaso=
ng.tencent.com@kernel.org> wrote:
>
> > From: Kairui Song <kasong@tencent.com>
> >
> > Since commit 0ff67f990bd4 ("mm, swap: remove swap slot cache"),
> > hibernation has been using the swap slot slow allocation path for
> > simplification, which turns out might cause regression for some
> > devices because the allocator now rotates clusters too often, leading t=
o
> > slower allocation and more random distribution of data.
> >
> > Fast allocation is not complex, so implement hibernation support as
> > well.
> >
> > Test result with Samsung SSD 830 Series (SATA II, 3.0 Gbps) shows the
> > performance is several times better [1]:
> > 6.19:               324 seconds
> > After this series:  35 seconds
>
> Thanks.
>
> I'll merge only [1/3] at this time, into mm-unstable at this time (I'll
> move it to mm-unstable after resyncing mm.git with upstream).
>
> We don't want the other two patches present during testing of this
> backportable fix because doing so partially invalidates that testing -
> [2/3] and[3/3] might accidentally fix issues which [1/3] added.  It happe=
ns,
> occasionally.

Sounds good to me. I'll send the cleanup separately sometime later again.

>
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
> >               if (si->flags & SWP_WRITEOK) {
> >                       /*
> > -                      * Grab the local lock to be compliant
> > -                      * with swap table allocation.
> > +                      * Try the local cluster first if it matches the =
device. If
> > +                      * not, try grab a new cluster and override local=
 cluster.
> >                        */
>
> nanonit, worrying about 80-cols is rather old fashioned but there's no
> reason to overflow 80 in a block comment!

I'll be more careful about this, thanks.

