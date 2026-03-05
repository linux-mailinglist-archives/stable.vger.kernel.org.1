Return-Path: <stable+bounces-223170-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKFXL3wHqWlW0QAAu9opvQ
	(envelope-from <stable+bounces-223170-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 05:33:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D80F20AD44
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 05:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9263300B47E
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 04:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C98217704;
	Thu,  5 Mar 2026 04:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A9TET4XN"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5DB1A6828
	for <stable@vger.kernel.org>; Thu,  5 Mar 2026 04:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772685120; cv=pass; b=h/rFXyUIgqlSGXFfgIRorbLDIi0CzjoG+sRShaunEnImv56Y+o6xd0gU6enOHMZIk43O+DUv8Yc4Q4ZQ69hzc68UtGzQD1FlQz4kleTxqImwlV2zTeQpzXOAHoH2NeUK7OnCZdramTNDejobajPkhllruLTsuLhMyHq6+u2zxRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772685120; c=relaxed/simple;
	bh=07AH0O8rOQrtYR1vEgFaL79Z/GhmvxKal7S6yeZHNhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LrzTIz+TzWN0bjt9QawRbXFZx1Sf7fH8E75MYKJ4P6rt9ggmA3aCOXKId6PYTezWzlOJW3Va2saORY3gkHUw0HH2K4eksesmoGFQQwfCKOu6+s9T0sfYNsHLRCUpzbFkj/qSemWszJQHaXcUDKVKHTEs95qPddNynmBs6HLhwfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A9TET4XN; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-660d2e4846cso2139047a12.2
        for <stable@vger.kernel.org>; Wed, 04 Mar 2026 20:31:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772685118; cv=none;
        d=google.com; s=arc-20240605;
        b=hPpNXRn9f1gvTBKE/wLYu5af0xrvwxJfnYTevZgvAi0oHB9TqO8wU1l1qSupe8jSrT
         3PPt2eDOXKagrkvJ5Bxg2dp/hXxsmknhFrMdoXj3mziUygh3Yd78U4Ik0KymC6+IvgW+
         0fjXgNii3U/YPvRy/CGWRbuykYp15bakFeEl030ICOWACclIztOK+gF4IYGuVnluBmau
         iQJ0OjavZq580iqSqAzvwNEIeMIS4UWVboaRD/WN6KxD4qPL37TRst3TvS5WrwVjV4Vx
         LVqFFrLMtg/djSFjBa3chqNNR/sbS9HNYnyWWQ/aWf6p/LGbvkbK+yCrkjWB8TOiezOt
         o7+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=07AH0O8rOQrtYR1vEgFaL79Z/GhmvxKal7S6yeZHNhg=;
        fh=xkzb+PjEavBabuwqeKdMffi8DwcCaFSUt8W+OYp5uaE=;
        b=hsi9iteuoN73SCg7jGfMv2va8DAwed3z84fnCT40W51WNvNlHhSlDlj9zKz9wsLn9y
         N0Fb7Pd8thk+78mbgE4tOAGUHxlpqe/Rjy5wMKZYTv0dxRo967Lj4zDl+u4sPacRekd4
         IuOlQANR7bXE0IDE3atZ3Bz5YOtswscuc3xrWwwzv0uDEQoLmwUnUOQHEp8bNdiBIxux
         NMeLfrnEcS3jFBzP+MysIyu0UGANe5d6lVN9M0axkXxhwY/Ttk0xaOogd2qnsXcsV78B
         4PKMyLvQggr+CDcdWhd6GiK8QU5uOz0Hxwt4DHoNbR2g41NVdS0xobtDhfXHTUMVVHSN
         8b+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772685118; x=1773289918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07AH0O8rOQrtYR1vEgFaL79Z/GhmvxKal7S6yeZHNhg=;
        b=A9TET4XN/1s6mND+cDcX6MuAc8eHUrwrz45imJoynt7Uc3+kj464Cbr9G3aGidjRWK
         XGFKcQdPxGze2CiL8tRkE4KzoMVvKI/HxG2r1SgdbmJk076d24E9BmuwYQ+msm34Wace
         xa9cM1X2O+nTKK8HJkDWGYBrW9A688cRiAQFa//tF5bxxnIAIWUZ/AARTzI/6m0uPy1q
         gEuhEkgQbF6zVanZ3gDhyUBTFlDDAad4hgKqJwoibhlgugqC6zI0GPVQ9AKItaRuQTPL
         tAmjQRThs4eu//hfIZfLdeY5WoIVi1snXcj8AnUXq82nlTrdZz+t7dxxtHR8UuqLSMee
         P6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772685118; x=1773289918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=07AH0O8rOQrtYR1vEgFaL79Z/GhmvxKal7S6yeZHNhg=;
        b=vwEyW+Y1QTfMJDW0E8UgMlXWNlojZ/TIRLDqig2/WquHXG0fZ2oMMfBSRCPVc2QB2K
         DGvgPDmtgaV/QiWQDgKZ2sPxc4XVZ8Z+7znI30v0fgRQVvLwlntKWmCYNR3FYz/5+FLW
         b4nouzk2/69y40xanCWBjzJQ8ZH1sPkNbf/k9r9V4i3NG38JCtZpepROdJUVkFO/IWCC
         Wo0AVlO+vpY/UwUc0kR15Xxs3hcOc6pf5Y3DuOOtxxSXxEJa3aGeDk60uGM0gmxymGqM
         KAOL6b34Lhc+i7Zahcp/Q72gKAnzjt7nmthxtD6hFl5JQaGjYbaZI2MKCvfdayA5I+tV
         bJEA==
X-Forwarded-Encrypted: i=1; AJvYcCUu6lbvssXyFSuM7HRNSiNu5xFk+/RKCUMGbgxtHTfWkEkkVMdiaXp4msINrHmoFkG51qMZstw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb2s4nky26+pN1cqMgXB5k7NlU77/TNiSRBVtd4Et0jQ3tNiqf
	e8ZSdNWrDHfqNEK1cguhvVkX8fogM88sbbWzTecUNakE/fIY+Fdxj/oSHVgTT3BOnF107tjDCw5
	AU9GympHe/aZMDri/Txxd6SQc58Kny+fmPAfZGYYc
X-Gm-Gg: ATEYQzxLbHG5DUGgybxYvqw+H9SDcz9yFjtlqixQCWOA9a+Q8KDdCSsR/XbF7X7ZMiE
	mi88sGptGWxPbQ2dQVB/9hMEqqXzQxaJj5XaAyhHvxJmXmCCNZMI5o+gY2UTgf1TRXkubM6xg4b
	Oky4L3x86EDUsNmIzql3G+7dZB5y4NfPOWNtQPbRCM6QHlzyifJVzOs9dBpnzbZqp7pTtwihfCd
	bS1eLoIMk5+qXrMx6UMnFBW8QeLrMNTs/HRWTtIm3yIrjzgD8q/ryE4lY+WghGIZpVc5bqAnHAh
	C6EqkcSMSNfoS3tDB8PpfP91IB6172U+An0Q3rqAc8XU4fp9CMopRpnPz1pmWzMcmUqbpA==
X-Received: by 2002:a17:906:208f:b0:b94:898:7bd2 with SMTP id
 a640c23a62f3a-b940898a1f9mr26074666b.39.1772685117464; Wed, 04 Mar 2026
 20:31:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303063751.2531716-1-pjaroszynski@nvidia.com>
 <CADrL8HXaTz-TS9rYiQkZ6NoRWhHm0t4Tv0t=TtDXS4purLnDJg@mail.gmail.com> <aadTuvCBxiVimDZA@box>
In-Reply-To: <aadTuvCBxiVimDZA@box>
From: James Houghton <jthoughton@google.com>
Date: Wed, 4 Mar 2026 20:31:20 -0800
X-Gm-Features: AaiRm53dJeRWd8Nji1GYa5e5Z900_RBsGxiHxN9h3vB4MZepaklzjxRsMiu3r_c
Message-ID: <CADrL8HUHQDta2mv4TG=f3nYPx5-S5nrywGxQwx78KSe67yjYVw@mail.gmail.com>
Subject: Re: [PATCH] arm64: contpte: fix set_access_flags() no-op check for
 SMMU/ATS faults
To: Piotr Jaroszynski <pjaroszynski@nvidia.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-mm@kvack.org, Alistair Popple <apopple@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>, Breno Leitao <leitao@debian.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1D80F20AD44
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223170-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jthoughton@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,nvidia.com:email]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 1:40=E2=80=AFPM Piotr Jaroszynski
<pjaroszynski@nvidia.com> wrote:
>
> On Mon, Mar 02, 2026 at 11:19:46PM -0800, James Houghton wrote:
> > This is similar (sort of) to a HugeTLB page fault loop I stumbled upon
> > a while ago[1]. (I wonder if there have been more cases like this.)
>
> I see that your commit 3c0696076aad ("arm64: mm: Always make sw-dirty
> PTEs hw-dirty in pte_modify") from that discussion was picked up and
> it's very relevant for the hugetlb exposure question. With your patch,
> do we have a guarantee that sw-dirty implies hw-dirty in all cases? If
> yes, then there should be no exposure for that path. But it still makes
> sense to make it more explicit.

At the time, I was unsure that the patch made it *impossible* for
Linux to ever write sw-dirty hw-clean PTEs, but, after that patch,
such a write would have to somehow avoid pte_modify(). That seems
unlikely; that was satisfactory for me at the time.

I thought (and still think) that explicitly fixing the HugeTLB path
would be a good idea. I think that patch wasn't taken because it
wasn't necessary to fix the bug I was staring at.

So if you want to take the patch to the HugeTLB path[2] or improve it
in a v2 here, please do!

Thanks!

[2] https://lore.kernel.org/all/20231204172646.2541916-2-jthoughton@google.=
com/

> > [1] https://lore.kernel.org/all/20231204172646.2541916-1-jthoughton@goo=
gle.com

