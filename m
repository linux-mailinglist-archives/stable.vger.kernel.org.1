Return-Path: <stable+bounces-89431-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3242F9B8093
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 17:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB1C6288D40
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 16:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396921BD020;
	Thu, 31 Oct 2024 16:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PI/VjL3R"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236F713AA2E
	for <stable@vger.kernel.org>; Thu, 31 Oct 2024 16:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730393337; cv=none; b=t4z75AahoVIE3Tqtbf8COHG1AfzoRIuH35ceXP/2w1N3aV/ZqskUYSwg8EeXXtWX72c3s1yvIobmObyuEf1ZvOXtZBTQYMLO0w/hQ4wBePfNDxQMFASGQ47IoMc408pkmtKUGZ4fv1JlGZwVDKsmzMOT48R1tn+Uj8yS9Lu3lus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730393337; c=relaxed/simple;
	bh=DyWph8UUJAkQclrw0BMcHAWESaNV8zNxbZmG/7+Hbk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UPOpnP5adZr+j3SP+9qR8uwnsXX+uNGzgaSCoeyRwDYXaDpQvsNvdyUdrTOWRQMWium5mia6bWyM5I3h7NrCffB0a0IpK2Yk5ALVc7kkCzJ0D43yj15iT6kX0bowlpywNTIHGDWAaAZxvPtca12o9x7I0vP1uYi/CTVA+jkGxas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PI/VjL3R; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e2903a48ef7so1049155276.2
        for <stable@vger.kernel.org>; Thu, 31 Oct 2024 09:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730393334; x=1730998134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCGIRPOYY6VkyMbSOzu8Bu46cDZwcKzHLqJf7pVc9Bc=;
        b=PI/VjL3RWBuqHKME5Npp0/dRYasW0vQeUlJRWfFa74rH5L5aEyk7t3jAyXIkdjUnSQ
         I69vCcN4RNhf2PvrYrlR4TDYdxgbQx5AdqxdJExnq1afnuF3DvaeAF5GGec8vJLxJYJq
         C77cQpuW1j16/EfJM/PLOHA//0IP+27fgBZHfCUU2zNxq5Fl0nDFBPqUpvg3u4FyTxWV
         WC11MgqZb1jFWD4/p/zySgsHRt+3Xa054hskmhQ1l6Wlxg2Ji30ANle+3q9OmYub9fdH
         Z3VuEwG5kGkE+FrE84/7ZebHZF30GMqawkaeXKY/+pLpxO1LPCafZCjiVeZkP2090kCe
         nCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730393334; x=1730998134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CCGIRPOYY6VkyMbSOzu8Bu46cDZwcKzHLqJf7pVc9Bc=;
        b=W7ZAcostMX+vdHdDFGtOcU19bsgBnohI1nQ90wjQ8BJRieTzpq/Jv7vSbBaRA+R3k0
         1l+f/Q1y3h9DNXUNGX4v04WWeznpMncc+7ovm92uU4xwVp2SCDym2oE2se1RvM3hax7u
         US4WDjcO28AZS01+aYsg9eUGLYKjxIDvzLYEtFC1PuWFVDrGH21K5sGx1toqdlBbWI9C
         k11JD7bIIbBKoWKlJ7JlZCNWMhm8Yi/q8vRzWUWR2SW5UGPSzDfNFfKdvmFRPNy07ylx
         CAoTeX4MDgwZrPLF9t+AZYYJOYOBeiZgy3iSr+R6S9mC8yup7J9u3zdwVdgqOiBqxEjN
         oTqA==
X-Forwarded-Encrypted: i=1; AJvYcCXzuChTBwxa3cawXNDW6qTYbEQN+3Bv/6HUCHA74BhiIXt0pneP0Lvkx/0nREOUR3xIbs1dhd4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Z5UPqbTsYxm4GxfzuweEwVME1+q9eZmbiIatBwPZ3Ecs7uE/
	v/8KyjViXO1AuCzIMjauKPTpKvKVP19x0o/+4uumQYtwd8SRhh7Gn+rM85N0jOpfeV0+zQRxEWC
	NjxJmpEnjsBxU3igPAU8FER1BT8A+jh1AFFuN
X-Google-Smtp-Source: AGHT+IFhxc21ZHz4vbc2RJxBu7ImVfd1dY7qdM5KSOEx184gZpnveCCVXiqO6RQl2JdhFA5FqtGx/OQa9HaAkqcLcjo=
X-Received: by 2002:a05:6902:b08:b0:e25:d900:a0f8 with SMTP id
 3f1490d57ef6-e30e5b57747mr2920629276.43.1730393334042; Thu, 31 Oct 2024
 09:48:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031031517.3AE43C4CECE@smtp.kernel.org>
In-Reply-To: <20241031031517.3AE43C4CECE@smtp.kernel.org>
From: James Houghton <jthoughton@google.com>
Date: Thu, 31 Oct 2024 09:48:16 -0700
Message-ID: <CADrL8HXPjHDRAUmzLnSS0fqsw3Rt921EYm2KyEUqW-sPn15o5Q@mail.gmail.com>
Subject: Re: [merged mm-hotfixes-stable] mm-multi-gen-lru-use-pteppmdp_clear_young_notify.patch
 removed from -mm tree
To: Andrew Morton <akpm@linux-foundation.org>
Cc: mm-commits@vger.kernel.org, weixugc@google.com, stevensd@google.com, 
	stable@vger.kernel.org, seanjc@google.com, rientjes@google.com, 
	pbonzini@redhat.com, oliver.upton@linux.dev, dmatlack@google.com, 
	axelrasmussen@google.com, yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 8:15=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
>
> The quilt patch titled
>      Subject: mm: multi-gen LRU: use {ptep,pmdp}_clear_young_notify()
> has been removed from the -mm tree.  Its filename was
>      mm-multi-gen-lru-use-pteppmdp_clear_young_notify.patch
>
> This patch was dropped because it was merged into the mm-hotfixes-stable =
branch
> of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Hi Andrew,

I posted a fixup for this patch here[1]. It fixes builds for some
configs but is otherwise a no-op. Could you apply it? (Do you need
anything from me before you can apply it?)

[1]: https://lore.kernel.org/linux-mm/20241025192106.957236-1-jthoughton@go=
ogle.com/

