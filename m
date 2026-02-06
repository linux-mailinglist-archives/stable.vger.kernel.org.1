Return-Path: <stable+bounces-214735-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEK+NFxohmm4MwQAu9opvQ
	(envelope-from <stable+bounces-214735-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 23:17:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB38F103B12
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 23:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1D38E30072B6
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 22:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0262BE03D;
	Fri,  6 Feb 2026 22:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DT9pKHVj"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD8A35975
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 22:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770416213; cv=pass; b=dH1355PRuU/+orbgx+OudDb9y2oMDgogXV74w2mc2u3h6K2buoZEaNJzTzKlpxN7Mw3LWy7gbBjayApZazsTcnVIJOC1ZECLxcizBd0C4/DeVTWRP6HTMFWrAZcLJh0YgCzp+KAIpyAoC10GToVCeLBkQAjNDm7dm8i9Bsimz14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770416213; c=relaxed/simple;
	bh=eNp2MGw5gBEJp5hsS/8aiEcuoANQxV7ocHcGAxYINjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UuyL19RVPYh+foIKFKcZ2OanGDTK+oy86Ow+d3NtgfZfyCCmGGhlxaSfhHQoV91V2JEzcR1x2E5rT3CaiCgw/oeBsiZnYG9vtDynHfEeS8McmfJs2xCW/c+s3h2oCfHqHANIRvlRdcNxvBs5itMUzA+fB8d0F6NLxI+scaJjHKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DT9pKHVj; arc=pass smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d19d3c7208so1544614a34.0
        for <stable@vger.kernel.org>; Fri, 06 Feb 2026 14:16:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770416212; cv=none;
        d=google.com; s=arc-20240605;
        b=lo5dfcTGeSTeg4X6dXPPJcJIrRMx26A2p7T2IqZqQA2V7dh9te2zSNhZzsN1AU8hP/
         c8Tg+LtfWsPALiBu2Wg9FCJAoOCsBCV9Mgs0evPgdgBM/LQLmbb67DaaWvQ66ZVWHsAk
         qLzO1g6/BBG25gzILdKH5sJD+LX2Iew4jjXDXAHY20X/3MfkHBr5EA5ntPstvqb5lAsi
         V/+C+5ajDP4Z0+p/dDNAqVflY7+6++cJanGhiqByMEL3ukNfUiofbynuaXg9gFW7uaMB
         HVJcAvt3koQjH95kZ36jEoBS6rlQZH6wTZNmrTIeFbVyKYJRfaVUtKIQqpbgFGR91Tzi
         GAxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TYOL7E/u17FU0GgtA23D0PWn1tX2SHWaEdS0MvMslVk=;
        fh=ozCx2I7iWuzxz11kbuCq8toCPWwb27eIpH/Wa61wukE=;
        b=QxQtWGQ34qL9L3IR4z3YGV4diTaWG3tjVWZtAxYXlGCQ8vUQQn/5kzHPfLaCwxUoHb
         bnlXd1w6V1KdorlSQgoH1Z4rTOcQumV7CHv7WfGISd2rBIaj1cSRPaT0/pJaMAc3X/b1
         QFAckFXZKPwrjXOxBW3N9TRD24Bm/aSsCeJ4nzGOJsPzXmSfVVLgQOtW8aeT+729wZDJ
         EWWykR9jAy1lcD8VonePkr8si8x/OCWUBgiQmFbeP5Sbu8MOeGlbittOm43OvuBUKZAk
         5p/4+eGbqbiQ1RSAioqzkEeZqwgf/TVgaRG649dke3rP1Ih0dt2DFMmkbtAMfJRQqzfo
         X4JA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770416212; x=1771021012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TYOL7E/u17FU0GgtA23D0PWn1tX2SHWaEdS0MvMslVk=;
        b=DT9pKHVj6d1gl2GITwMJpjFpXNWTSLeqq65Elu5yywiLSqtZMoIZE+0jiYir6WwC3V
         2NXG49N77jth0YqoTPiHgpip7UoDzmp2IylsOJJTV4cjKbgP6EH92lWowIfjQpr81pYP
         R4ht1YO6EOQXp9TgdcvI7VGi7QuzC+5H8pl3vrm9F3EgeGwBa6YiqqCEKphbHKXEn9W+
         J7FImZhiS0xVUHzQslVu+8/vlCeAoFQsZOn+RBdS6dONVSiKSOiaiE2g3Us2K8eSHkYE
         i65/lw2UcaoSta2XuOoqTKIV2w4SQNKkh7eU2cZ/ArhGmEuekbICwZc0uxhGzOTbZJos
         +BjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770416212; x=1771021012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TYOL7E/u17FU0GgtA23D0PWn1tX2SHWaEdS0MvMslVk=;
        b=uUi7MF3G+K4RFbGh+r/RN/fWr1PxjljQf3ZTPIq0+usiy67wTMP0I5HyXu4NVPePlH
         aC82jkOGQYqjx64bYVYtghLuPStFpvJ6yvzKhuXAj/HuWhcDRbPZ0x3B++9WNzAISuIF
         cpi+/d75TA/BGaZhi7LVeimMQda6dnvOFSX0tJRFd9jUzHjIzJfc1yWXkj0bHlyabaYo
         v/QbF+Y8RGTl+ZSaTtpF70sllWR/6Oc4T5mNU6/Q9Bau3fIzNmYia1RNZo7H+XcaefA0
         ts3tfw73Ek/n/iXIGKOM3e4x82CBWcpQx/xfNb8JU6OtOH+tjGVYZohye3t5m+jcu/ql
         0L/g==
X-Forwarded-Encrypted: i=1; AJvYcCWoLaxsRdWiMeignVVA8NnR/dNev/jT0sg9hSwX6e7PGNr6K5RdDC4gN3ubaRO6iL76MQzwzQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YznsPiP+HqcSlk9T/5YYdkWdz2NyNwOUUt1FzQZt1N+wlenFEuB
	eaQTcfqct/dObrNLmzpXi9Flb79MS7+ybBY8EJM7Qa5nxcmw3vRQJgs6/701lk3JTcRAqy3cDGS
	m4ZlvS8dSKDoNB6pmn42E8vVllArbgs0=
X-Gm-Gg: AZuq6aJ7snAFiYcwvGCXv5MbsMOQOGTwjNypcyOt6lkDeNwfyehJSZMyiZhwX4ZEmAF
	BNjinfG61ZjOhJNN9qmm9tyjYpKp7TX5PT7IC9Is1Wv8zrNtU2CHUKcxz3pE4PzXp4GBrmAsOJj
	7gUyHsoQDve06ztnSp4UMSs5JX5GTWfc+DkBe+0Vd3pwwJj81U97AW6/KcD8V4EC6yY3EAbiEUN
	l0pg+sE5r25a9Ll4RnodR+Bio2P7j10/8WuT5VLL2oUsarMpHziGkrsMIwUPw3qxLXGQAK6rQ==
X-Received: by 2002:a05:6830:2813:b0:7d1:4608:a2cc with SMTP id
 46e09a7af769-7d46440d800mr2362725a34.12.1770416212221; Fri, 06 Feb 2026
 14:16:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCs03XcXt5GDae7d74ynC6P6G2gLw3ZrwAYvSQ3PwP0mGXA@mail.gmail.com>
 <20260206174017.128673-1-mikhail.v.gavrilov@gmail.com> <3BB6BA1D-3756-4FC6-B00D-79DF49D75C51@nvidia.com>
 <CABXGCsOMzrQTsByYraNby_MXnTuYBNt2vbWu65KCGX6bmi11iQ@mail.gmail.com>
 <F36AF979-5BE3-4399-9420-F41A475EA87D@nvidia.com> <B6CDB0B7-CB9A-492E-90DA-F8D7E3B037E1@nvidia.com>
 <7C7CDFE7-914C-46CE-A127-B7D34304C166@nvidia.com> <4C3D8E3E-D9D6-4475-A122-FA0D930D7DAD@nvidia.com>
In-Reply-To: <4C3D8E3E-D9D6-4475-A122-FA0D930D7DAD@nvidia.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Sat, 7 Feb 2026 03:16:40 +0500
X-Gm-Features: AZwV_Qhquj3d2ADjld2_kKiioGwgM-D9iJpddB_7DMyoioUMQfiflE1Knsnij1U
Message-ID: <CABXGCsP2z6sbf_FYZjdxyLhfJZEaxz0_WrEeteS50GLyU=KQGA@mail.gmail.com>
Subject: Re: [PATCH] mm/page_alloc: clear page->private in split_page() for
 tail pages
To: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz, 
	chrisl@kernel.org, kasong@tencent.com, hughd@google.com, 
	stable@vger.kernel.org, David Hildenbrand <david@kernel.org>, surenb@google.com, 
	Matthew Wilcox <willy@infradead.org>, mhocko@suse.com, hannes@cmpxchg.org, 
	jackmanb@google.com, Kairui Song <ryncsn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214735-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,suse.cz,kernel.org,tencent.com,google.com,vger.kernel.org,infradead.org,suse.com,cmpxchg.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikhailvgavrilov@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DB38F103B12
X-Rspamd-Action: no action

On Sat, Feb 7, 2026 at 1:49=E2=80=AFAM Zi Yan <ziy@nvidia.com> wrote:
>
> It seems that I reproduced it locally after enabling KASAN. And page owne=
r
> seems to tell that it is KASAN code causing the issue. I added the patch
> below to dump_page() and dump_stack() when a freeing page=E2=80=99s priva=
te
> is not zero. It is on top of 6.19-rc7.
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index cbf758e27aa2..2151c847c35d 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1402,6 +1402,10 @@ __always_inline bool free_pages_prepare(struct pag=
e *page,
>  #endif
>                 }
>                 for (i =3D 1; i < (1 << order); i++) {
> +                       if ((page + i)->private) {
> +                               dump_page(page + i, "non zero private");
> +                               dump_stack();
> +                       }
>                         if (compound)
>                                 bad +=3D free_tail_page_prepare(page, pag=
e + i);
>                         if (is_check_pages_enabled()) {
>
> Kernel dump below says the page with non zero private was allocated
> in kasan_save_stack() and freed in kasan_save_stack().
>
> So fix kasan instead? ;)
>

Hi Zi,
Thanks for the deep investigation!
So the actual culprit is KASAN's kasan_save_stack() leaving non-zero
page->private.
That explains why it only reproduces with KASAN enabled.
Looking at the code, kasan_save_stack() doesn't seem to use
page->private directly - it goes through stack_depot. Is stack_depot
the actual culprit?
Happy to help investigate further if needed.
Regarding the fix location - even if we fix KASAN/stack_depot,
split_page() clearing page->private still seems like the right
defensive fix.
The contract for split_page() is that it produces independent usable
pages, and page->private being clean is part of that.
Other code could potentially leave stale values too.
I can share my .config if still needed, but it sounds like you've
already reproduced it.

--=20
Best Regards,
Mike Gavrilov.

