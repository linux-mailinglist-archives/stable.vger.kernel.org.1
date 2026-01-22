Return-Path: <stable+bounces-211291-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MG6jJw1ocmmrjwAAu9opvQ
	(envelope-from <stable+bounces-211291-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 19:10:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4F26C09B
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 19:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11F7F3004207
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 18:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31886372B35;
	Thu, 22 Jan 2026 18:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="eVyGKPbU"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409B8361DC3
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 18:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769105405; cv=pass; b=R745FSsBb24+1Q1PT4Ft8IBuT5dqarBf/ijm9jIeO78O4Vgmbq8JW5gVP/wF2SIDsYiaqu3DWhtSRXz88XKfluxw3ZFNUAzlgfHWvtKt9yXQjEtXBeGvOLSijc0NyIo6Mjesr3pjzjKgzu4+B6oa5V/I3EbLPaMJzC5BFMinP/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769105405; c=relaxed/simple;
	bh=Ilqdx+/ykMBSFbeY8n+vM8S5InCnEJwZ3/TPDE2mMYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uKRrprTnxlyVbTWrwat1C9p0EULVp23syi3KYqrl8mjH+JefiVDGVt1tXl+fU10ZKdAtWA1zYjWS/zie6qGXoBkcR63u52WLnFzxvysJ+/bvOsyeL1W2B0TTV6zTkYfxCLDaYZTNqEOYSAWYl5RNpwdseNGfIecoTLF3XIbP2W4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=eVyGKPbU; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6581234d208so2532601a12.3
        for <stable@vger.kernel.org>; Thu, 22 Jan 2026 10:09:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769105383; cv=none;
        d=google.com; s=arc-20240605;
        b=G95DzPEyJubAahtTiG2mELX4wck/SBUm6uRIG3n6JKeJpBw/YeXx3qbGM8pDNiozLq
         CnIhtvUjjNiOC/JYkK12IhcBldSW9SE2nanFd1avlJ7S83Bg5M0zXIuoz0q1UimCAf3F
         jsd0GP3bWL6MvOydkhx1a9ZJJHWNfw0bsIOlSQRihGc03FYsVNcP+SGFwDlWoXyI9qUh
         pllKd6qFfMNReK+NvC9ea1v1SbBIz1t0HplakRLZ7/XvMckLbGbJlIrOxE07DwAgN5VP
         HPYFQFWOSSWh1rvJeh3QCuRlNMtTDPb3v2oQATo+KWVfmvy8ZKxJm/tfD58EC6tnVCT1
         1Gtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LbjBnPVhpRbR+iDPKNRkBtw2lZYOaBG/Duh0jODc6ZA=;
        fh=wNt9wsmn24ppyHtMm/JsmzPr0ypdSnr3timhZZ9vXkI=;
        b=cbejQxUcfXoFBJYkuKb59F3bgEntNnLG8eV13rGgDUkWJfbDMVKJ3eiDc3rv8GDePJ
         z1ZzclZRrAg4znuebQRiRTi7P11bYuCqr2UmWZYiMptL1zP2CvUE/89jNNOUyEHJupMm
         KolYUN91LGf5O60adyX5VSXf+i9K4MCHTeMmVt6avTkwnrdZqLFeBeVmONd1pBP4LTsF
         hqq85I9G4SBvZd9w/4kkxHYWK8ZhMQJuHkBseXXxpCLHqVsG2RHoigqXgSn9h5Z2Dz3I
         XZhJ16mmrbshF0vVyVjo5hsYrsVqWvBZjbZ+bgGaEgbjAbxEp4AEUOaGihOXPMosGLjq
         U2Fw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1769105383; x=1769710183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LbjBnPVhpRbR+iDPKNRkBtw2lZYOaBG/Duh0jODc6ZA=;
        b=eVyGKPbUlmJeHhNPVJuv/F1ALiJ5wlhl3wy5/WYrsRAAVr2yTCYJ4na4sjixHFmKXj
         Uht54A9yeIdGBdtI2xi61OKmjhpXiddOuKQysKlzmC1eXCdbISNc/GS8N6F1QFTj3KEx
         f13YlG1gm7+ZyYIO7GJIV7KRiLzrpUEL1H8H8aHEvZY+R5b9R0aZM/xo9xkv6jQNJzjN
         sISRSWlRKK1JXdGg5bBA8+vCkOMpJJD4bc4A8UHbjIv8QOaYRYCimRmVUi1Cnxeduapp
         L6b3qpsnbfRAGsWyeUTdBtvE9lXxb6zk0URLbFZaRXUt70eqe/y8773gNk3CPFErBxaC
         QwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769105383; x=1769710183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LbjBnPVhpRbR+iDPKNRkBtw2lZYOaBG/Duh0jODc6ZA=;
        b=mZJI7AXTiK21spEkDG18bjMSLgJShJCdZyJid/d08uMBXi4X2ZsSrLGxr4nUhL+6HF
         kqfcRM6ws6agNKSsKDuZWh4an1pOmVk4JbSKv1v9yVUkli6yN1R46TlAG1JmqZNBt2U/
         LpHaVVJ3m7NeYqphvel3NVWGSl/bKK10hYUIVwWaOlhGQWE/ofKLRJf4G83dfCbkoM3y
         HTdeFZiWtnRJK+pGSCdKL/aGXkuIUP2KguURpHR6YyRPkU52g69629JAfDctJbPQcawJ
         91DPmCsRtBgEffa8qo1r0Jl7j3TjB5GSTSmaWmNP2Q+Hd9WtFeZnkn7W4ibeNXh90BUz
         vpAQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/nij0mmPJ8SZwrY5ONMNCNtpLFQgv28V4fkwF2WhzL3JoVWDtQAXS8GZb75XMTtIiBuddYbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIP2IUV1QeylPIQILHKf7cxUco+n/Z1d1waaGDgiJxLychgPvm
	bVsJAp3N/ndUtVoVjkQWRDuESzJJKmBBFFMqRRSpgdIypxHb6O6FMC/RH+abmvYA8t+J/KetpMI
	+1dJR7MduVBxSwUmQBw916fE7pEwwCNUY7MUicn/Kyw==
X-Gm-Gg: AZuq6aLw/8TKIdDteamolukdvl6VzRTA12DEKbBKn7QFtl+xsvthoowW4z+sdc+gBBI
	Q6tlog+u/6y0l1BBEFATDQbqtRCsDuPXxBqmRwdaoYKY3u1/YcE++CmCl7RrfcgIGltbcGxA6u9
	bjSzrj0JyLb0dYVvsSHmxIlmajLIQtK1b6ZV7FXP/D++YdqRkPkGDA8bXaKHllhUcBQenoRiAl3
	UrzhMpRZgIvJ0sAh/SGC4uK5cKgrpffWkRNcpsAuAEiogBRGIjzv0bcLO+5EMs2csYl2Zg2Urxa
	OI5Wb1jOmWbBHBTm93qz6h5FEw==
X-Received: by 2002:a05:6402:1e92:b0:64d:3b22:a5c2 with SMTP id
 4fb4d7f45d1cf-658487baf12mr292541a12.25.1769105382740; Thu, 22 Jan 2026
 10:09:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122132740.176468-1-ranxiaokai627@163.com>
In-Reply-To: <20260122132740.176468-1-ranxiaokai627@163.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 22 Jan 2026 13:09:06 -0500
X-Gm-Features: AZwV_Qi9TMnkjzXXfx8I6-lM4eliGE6Ihf3Eq84jRCQeznE2azuug8e_3kMlNnw
Message-ID: <CA+CK2bAMBxZMBGS6DLaEO7M92vutW5UhfJNSwk+okdVu=EYu+g@mail.gmail.com>
Subject: Re: [PATCH RESEND v3] kho: init alloc tags when restoring pages from
 reserved memory
To: ranxiaokai627@163.com
Cc: pratyush@kernel.org, surenb@google.com, akpm@linux-foundation.org, 
	kent.overstreet@linux.dev, rppt@kernel.org, graf@amazon.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	ran.xiaokai@zte.com.cn, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[soleen.com,reject];
	R_DKIM_ALLOW(-0.20)[soleen.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211291-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[soleen.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pasha.tatashin@soleen.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,soleen.com:email,soleen.com:dkim]
X-Rspamd-Queue-Id: DD4F26C09B
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 8:28=E2=80=AFAM <ranxiaokai627@163.com> wrote:
>
> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>
> Memblock pages (including reserved memory) should have their allocation
> tags initialized to CODETAG_EMPTY via clear_page_tag_ref() before being
> released to the page allocator. When kho restores pages through
> kho_restore_page(), missing this call causes mismatched
> allocation/deallocation tracking and below warning message:
>
> alloc_tag was not set
> WARNING: include/linux/alloc_tag.h:164 at ___free_pages+0xb8/0x260, CPU#1=
: swapper/0/1
> RIP: 0010:___free_pages+0xb8/0x260
>  kho_restore_vmalloc+0x187/0x2e0
>  kho_test_init+0x3c4/0xa30
>  do_one_initcall+0x62/0x2b0
>  kernel_init_freeable+0x25b/0x480
>  kernel_init+0x1a/0x1c0
>  ret_from_fork+0x2d1/0x360
>
> Add missing clear_page_tag_ref() annotation in kho_restore_page() to
> fix this.
>
> Fixes: fc33e4b44b27 ("kexec: enable KHO support for memory preservation")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> ---
>
> v2 -> v3:
>  - also call clear_page_tag_ref() for non-compound order-0 tail pages
>
>  kernel/liveupdate/kexec_handover.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec=
_handover.c
> index d4482b6e3cae..96767b106cac 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -255,6 +255,14 @@ static struct page *kho_restore_page(phys_addr_t phy=
s, bool is_folio)
>         if (is_folio && info.order)
>                 prep_compound_page(page, info.order);
>
> +       /* Always mark headpage's codetag as empty to avoid accounting mi=
smatch */
> +       clear_page_tag_ref(page);
> +       if (!is_folio) {
> +               /* Also do that for the non-compound tail pages */
> +               for (unsigned int i =3D 1; i < nr_pages; i++)
> +                       clear_page_tag_ref(page + i);
> +       }
> +

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Pasha

>         adjust_managed_page_count(page, nr_pages);
>         return page;
>  }
> --
> 2.25.1
>
>
>

