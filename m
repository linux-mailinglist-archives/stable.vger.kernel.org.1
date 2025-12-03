Return-Path: <stable+bounces-198183-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC67FC9E7DA
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 10:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93AE03A2649
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 09:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381142D94A5;
	Wed,  3 Dec 2025 09:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QA9mr1MG"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776092D5A16
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 09:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764754385; cv=none; b=pFKSSoNY660+dsI0O6SXajodxZpInFhZ5hR/trK0s5I61uL8v0dWc9Y87kQOn8QN36Vos3UwXaOsDVJ9nHbuPrKbyL8fGjB1YLnigkgrNgK1oSd0b1Nt8kbThGixJtrVGgoiBjwj5wvl82GsBIkn2/Xu6AToMz2umsRM7AlA0Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764754385; c=relaxed/simple;
	bh=2DYv1agfJ9n9VkMlSI73M4Hj1+2Hc+Ie0drsSYly99A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jwi0vrOIdSA2ambJsFc3EjpekGjzpshiinXT+P47EJv5KY0vFuW53QqFlkNkUSCQsEKIy4cCOscjfhug2rEIEHtxqW/iIx5QNx9Q4NnSDXwmzaEGpO/QoERN5SLa6DEJU92Hw9SyxNBUNAkiltYvC4iHLBd8QsnSIw96BYSAkw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QA9mr1MG; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4eda26a04bfso71355731cf.2
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 01:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764754382; x=1765359182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRC3rnLtuEd2lfCxmjxDFYLmH8sArIj9NispACXVl1w=;
        b=QA9mr1MGohrOXc5L0WiPLt1zW3CE3bFjxtV2QwvIqwSqLJ2IdHkKTDEVQwbXTatHyi
         vOw/VIbOgf0CUDFEGtsKMp2XpGIweeq/02RxLT9K4Df70B+xB25+BUYUZCSbUwUQ1BQt
         ay7C4Il3jLheTX7z63DMoq/HkmWm+jNIvGEfgQ+3Rv1zN7kONShSrld6wErWWIyc/wAz
         CKIq3m76M+xk4wc1d4VaqRKswOBTCkCbfjVS3rvooq5AL3oyZ0xnYp4SevM/lcEnQHn2
         wTWXDBKEVOLjFVlcoBgWOf4+KNcFoih8cFdZD73N3KWyQnOTvqKq4GrLxIxqVrQqBBhi
         E+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764754382; x=1765359182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VRC3rnLtuEd2lfCxmjxDFYLmH8sArIj9NispACXVl1w=;
        b=bxjP62ApZi7aYov/XRVbRnee5zdyOaldCZ6FQZ/E/y+ZC45g1iG2Y49LHw72cO+OiV
         mlIsg96i2i+fuuLmmZxOrQmVHDikTXgg5JwiLk5kXlMDoxS2ndLeg2a9g74tUD9Nf2C4
         qrFzuy/4CYZ0Xe5Zl6Vh266og1jVufnLQzDf9cW5mLB1BAJ6hRni2ddPelv1ndZyDOOG
         /wXuCgHNxu0fMHR9UW3cHXROENvqal33SZu0+z0IxkJq53JJY7hGx8qaKzvBOJo0M6yT
         bvFfsTIWauAZHhn7lfGXK9ki9Kk9a5XR/T1hEDgv8Kj/7RPo2WreseuO7oC/8hFNV8Fc
         rsTw==
X-Forwarded-Encrypted: i=1; AJvYcCVv5NYZg9ZvT6ha7fq/bSj6YLd080PpCBe5zxeuN6kGbr2VuH/IE9JVbXLkUtmrVyn40UfMwyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFe2R62VUmN+5K04AJjXV/oWIyOVtTzA9cgmxTIH0cHuXvmAep
	brv1nxeDpcXNKMToiOaE4v9jGfGNpYUj9YxPKK4orFABsSGdqyD9OxpYgpOvHLbYuBxBPSUzM/o
	EIZTm1EKeuf6l25mn1dE1Ltl/PEim++r4vY5P7liq
X-Gm-Gg: ASbGncvxP8Mmgh9fO/5WWesQ91BZsgkYxxSvXUtZT4srwvdWXRwoDPtO02v868pPDdy
	R7PZ0BAzHLKRO8w8YD0Vj3k520WtJOdbXwr3UHVfy9Npby7b+Cm3cWFsyTvrogABgK3CWI9g77I
	472KpVJqz8kr75y+gRvujfg/zGeKu5vLph+13DupVj6SAW1Cj2dH9TrdLnAlrT0gzs28ITITlZc
	gvX/nsTfc5ylBlxea7yFN/aKvHUC3+jJ7seq8IY8uUE4T54b19enCUJXQkCqJTvGqQOYT4=
X-Google-Smtp-Source: AGHT+IG9Q6pBViYhFWM/lqWF1UIHccIroB3GviAPLH4oj7ED4doZDLxHNZ7l61rAybvudv1AAVfY8oahZzoFPp+HqRM=
X-Received: by 2002:ac8:5952:0:b0:4ed:6e70:1ac4 with SMTP id
 d75a77b69052e-4f01760340fmr20016111cf.42.1764754381945; Wed, 03 Dec 2025
 01:33:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKrymDR1X3XTX_1ZW3XXXnuYH+kzsnv7Av5uivzR1sto+5BFQg@mail.gmail.com>
In-Reply-To: <CAKrymDR1X3XTX_1ZW3XXXnuYH+kzsnv7Av5uivzR1sto+5BFQg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 3 Dec 2025 01:32:51 -0800
X-Gm-Features: AWmQ_blkdfwgIvsjfItsYshwc_eABXQWA83bk8bwk4zEZ83IVLlfJGBJ8jXyprM
Message-ID: <CANn89iLb-0kDwYerdbhHRH_LN1B3_gSKYOgu8KENQsk7akX-WQ@mail.gmail.com>
Subject: Re: [PATCH net] atm: mpoa: Fix UAF on qos_head list in procfs
To: Minseong Kim <ii4gsp@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 12:57=E2=80=AFAM Minseong Kim <ii4gsp@gmail.com> wro=
te:
>
> The global QoS list 'qos_head' in net/atm/mpc.c is accessed from the
> /proc/net/atm/mpc procfs interface without proper synchronization. The
> read-side seq_file show path (mpc_show() -> atm_mpoa_disp_qos()) walks
> qos_head without any lock, while the write-side path
> (proc_mpc_write() -> parse_qos() -> atm_mpoa_delete_qos()) can unlink and
> kfree() entries immediately. Concurrent read/write therefore leads to a
> use-after-free.
>
> This risk is already called out in-tree:
>   /* this is buggered - we need locking for qos_head */
>
> Fix this by adding a mutex to protect all qos_head list operations.
> A mutex is used (instead of a spinlock) because atm_mpoa_disp_qos()
> invokes seq_printf(), which may sleep.
>
> The fix:
>   - Adds qos_mutex protecting qos_head
>   - Introduces __atm_mpoa_search_qos() requiring the mutex
>   - Serializes add/search/delete/show/cleanup on qos_head
>   - Re-checks qos_head under lock in add path to avoid duplicates under
>     concurrent additions
>   - Uses a single-exit pattern in delete for clarity
>
> Note: atm_mpoa_search_qos() still returns an unprotected pointer; callers
> must ensure the entry is not freed while using it, or hold qos_mutex.
>
> Reported-by: Minseong Kim <ii4gsp@gmail.com>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Minseong Kim <ii4gsp@gmail.com>
> ---

Thanks for the patch.

Unfortunately it got mangled when you mailed it :
https://patchwork.kernel.org/project/netdevbpf/patch/CAKrymDR1X3XTX_1ZW3XXX=
nuYH+kzsnv7Av5uivzR1sto+5BFQg@mail.gmail.com/

Documentation/process/submitting-patches.rst might be helpful,
especially the part about git send-email.

Thanks.

