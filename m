Return-Path: <stable+bounces-210252-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 378F9D39CBB
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 04:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1DF730056FF
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 03:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDF21F239B;
	Mon, 19 Jan 2026 03:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtxkYyeT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714C817AE11
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 03:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768792673; cv=pass; b=pfehFUDP29QmjFsBbiR0dWgZ8MEUpsfXc71w541VbotOxH1aSWaMLTYu31ahQ6QIzb2KQaC5Osy+YlamtcSnk7z56wR75TLb5zDvgrhuHzNriyt5Rqy2EnAksysvqds5E9oH/Z9OQ9Sy0BFtay3UEiB2fDRaYNEOAgBncY+dm5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768792673; c=relaxed/simple;
	bh=N7l/uToNinLd5hQcauiLvJ48iqlwRY90M+CsZ3ATz5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pMW6D5tNGHj3A+QjDYIh77l1qBWOEs843pPDnQ/31g+NnfBixiauoCJ5KNPrmQYDPadWpkWKg2IHPaxIZjmI/+z+ncJcLI8PmYkH8n1IRUlFuhmZwREhc/dPW2P8FD6K67Xypa6Kg2KjIetHHkr9Rq23rJnNkKGA58H+o+CzYYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JtxkYyeT; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-bc17d39ccd2so1485498a12.3
        for <stable@vger.kernel.org>; Sun, 18 Jan 2026 19:17:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768792672; cv=none;
        d=google.com; s=arc-20240605;
        b=QaEUiTmHlsqzMFeJvgdJTYicUE80ne9ggwbJ9XGecTLrsBVe7WuWSDqgqXBvLYl3UY
         Y2tB9I31cicoRfBEH6/6zIbYOF/EiR+v70j0vnf/Z91Ftg2w6c/IkU6bIyOq88j+5cnH
         QWKaQ1xfxk7Jt7V1bDN3DmEkmMJnDk1dx6ebZuGnqsmTU3bmA9CoCgWAI2wiRLsMJUmj
         MaJJHbRu1wY/4ZGuVE4m44Vk1Mz63PZcgYij9mUvMN9rPY1v+Ucwk3yhZkjIW5sF+HGq
         rtlPBhgywbDqE/9jbPMs8xiT1GKyTmfmhZx3lQK/9t2evrm23bCN4WI904Y3yLV9YMMw
         dc6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HnEMERETZXpYSLDDchr/WHVXPVN1Akoe4lLaRnfg5HI=;
        fh=OAnwBAD85+NyMoWmuM0Ysym+II0KHme9XG3pL6r2STQ=;
        b=e/dGMuLY3nqu2R+r45eL6t4c/9G3EvW2ibSqAXczHnviCWkPFxfGCWJ4tYbCo8sJC6
         x85tbIZDvkCK3/BRcAAB4lvI2VQcfZgscwK83gqpU2nv60xp1PkaiX2nDIpYAT2Izh7s
         NTgKgrPuGo5MUbWCrr+seVG3wDgSINoDWmhK7wmeV8CkOdqnzzjXEsvpC/8gTwlcPCAO
         ON91+UgmWaiy/UFVH0A1mOUEd+185GTUh6gwXNgBfPlQlsTKn6rx2rGWa0LmXAhxjm4M
         8FkuhcrVsmJ0eAHdlNBOCmHfXjzv2nAKBKEF3EckBBgAyn/u1c7o8Gqq5gzCtfQpfWNg
         gnhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768792672; x=1769397472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HnEMERETZXpYSLDDchr/WHVXPVN1Akoe4lLaRnfg5HI=;
        b=JtxkYyeT0X/zHgyeYwY34tXhvdS/4COloXrOA6vezkm++F4qUcw2ZUVhQcNsVzEpKi
         RzHWE2OARtxV1UqbRFRqpur31KhHwtM2gOpPNeeBGySxzZ8E7F5lebwe44UHMtYBKpBd
         awrRIq7j6w8AWf/J6jf4x4PyrydSIlUE8+atSz6CskrgfcGX4aDwc84Z8lE1xlMfvTC6
         jrFSvRJW7jNTjBbqh1nXx6sOfWPnFiOZFRyWRRyAN7DnnXzdegyqUlO53IcRteJmONd3
         DMh05jTRKNW547gH4m1/Ubdl1TKlMML7s/CNov7S9sgi+A1LVmhXDUVElO1dU5Nf69C4
         fKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768792672; x=1769397472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HnEMERETZXpYSLDDchr/WHVXPVN1Akoe4lLaRnfg5HI=;
        b=tlC0r+6BCyoY1sDngynaI2XJM8744XJnT7zB95pffXgFNKpAliLKvWwGIXi+HOF196
         bsFC9yYwbWHY02OG+/vINHOv6dsr8d2J+Z9c8UdEu90azyFB9rXXFY08v/9vpFfkYYEB
         kZSPMirpBpGzj6MdCDRPNID4LLHg/MMin1ebZ9ZCKTNOL2Th1RJmqORKuhVjXuRTh7O4
         PamkqOM37o0j07i7QfqoRNUzQwZ5hhAVY6YYUG18JHkNAtICp8JDYVUTeyrx3/q5az58
         egL7ddT1pPWIDWgULqXG7PXMvETFYarVknB4YYB4NMnu8RdiSh0GUrKWgci593eeBpo6
         1auQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjn+40PC4GDVfwVMdluiOhiR+ZTxoVKDnCf0vwoWzfo1nddx3iTFXlWe64dWsncTn0lwDsPl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPskKUgk5KZ3+fmbW+XORRcGU/q/36rmmA4lb8qWPDqhYUcQl4
	2n/QSxuY4lzqnPpzK/JWHjdXY23mwnbTNFFvKgEFj/TbidC6+lKoHybAtiztGoxtN1zljQjZ0Y/
	Xxx6VDfu39sC6bR0eAmlOXgFE7HFWKjg=
X-Gm-Gg: AY/fxX4G6jokBZGOramwn9AjU0j+vi676ebWDDE/OTEDHnPuvxJb/V7LeIYElirm/jR
	yfUWgPR0ngUMyTo3NTuDEag34HEmEe52I/xwR/5XineJdek3WZdzmEVTSTBGJxWJhzsu3cDOAw7
	7npR7YbMlYoO3UKo0kRMqRAXGC4KNAQJYeIxqZNCeDfzRJZUWgig7FltJkGds9r2sTeZD4fCGQY
	7wkQMm02YeaMoo9XOOuz7oghvK1PzGepviFOpLDodQaBQBd8jnvk1bTHEPx2Ct2fK8r/WxIgB5k
	YwZcP6lbWzCapo43nZizpY3R5Nc=
X-Received: by 2002:a05:6a21:68a:b0:38d:f2db:ea50 with SMTP id
 adf61e73a8af0-38dfe7e53e2mr9426676637.73.1768792671736; Sun, 18 Jan 2026
 19:17:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119-shmem-swap-fix-v2-1-034c946fd393@tencent.com> <74fd3fd1-97d0-46a3-b76e-435808efff02@linux.alibaba.com>
In-Reply-To: <74fd3fd1-97d0-46a3-b76e-435808efff02@linux.alibaba.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 19 Jan 2026 11:17:12 +0800
X-Gm-Features: AZwV_QginFqBQArXq2rn6NQNo6CY6DV85PfDMsi4G0hCBNm7nTXd3hYpAKKCKlg
Message-ID: <CAMgjq7Bw9Ascd5FdTg=wf8dHtQN2n=cJPqREsatBJPoDLJVG=Q@mail.gmail.com>
Subject: Re: [PATCH v2] mm/shmem, swap: fix race of truncate and swap entry split
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: linux-mm@kvack.org, Hugh Dickins <hughd@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Chris Li <chrisl@kernel.org>, Baoquan He <bhe@redhat.com>, 
	Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 11:04=E2=80=AFAM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
> On 1/19/26 12:55 AM, Kairui Song wrote:
> > From: Kairui Song <kasong@tencent.com>
> >
> >                               if (!swaps_freed) {
> > +                                     /*
> > +                                      * If found a large swap entry cr=
oss the end border,
> > +                                      * skip it as the truncate_inode_=
partial_folio above
> > +                                      * should have at least zerod its=
 content once.
> > +                                      */
> > +                                     order =3D shmem_confirm_swap(mapp=
ing, indices[i],
> > +                                                                radix_=
to_swp_entry(folio));
> > +                                     if (order > 0 && indices[i] + ord=
er > end)
> > +                                             continue;
>
> The latter check shoud be 'indices[i] + 1 << order > end', right?

Yes, you are right, it should be 1 << order, thanks!

