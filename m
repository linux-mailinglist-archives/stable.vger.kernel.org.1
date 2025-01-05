Return-Path: <stable+bounces-106754-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FECAA01845
	for <lists+stable@lfdr.de>; Sun,  5 Jan 2025 07:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04945162AC9
	for <lists+stable@lfdr.de>; Sun,  5 Jan 2025 06:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4703595A;
	Sun,  5 Jan 2025 06:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CmmbI6i1"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571B81BDC3
	for <stable@vger.kernel.org>; Sun,  5 Jan 2025 06:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736057043; cv=none; b=grXIlyjpN8hy0m9NZHhN5h6mpYDfJD3Ikcuq4Xln17jB6o/PaI2d8w5cj3H1eqRZZ1nqSYOpT6I9FtjNJVAtTFbV+CT0RfOorR6fqUBqT6QssddbMuw4oPZw6f7GhPJ2xbYWrMN4isQuP6EGE8+YJtth8pu42X+QGWpedWV1r14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736057043; c=relaxed/simple;
	bh=9k1yjyi7W8w4GTtLWCbJ+fjErUI1KokvnLDEYz4Hg5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwsHgXjy8gJAtYGXrKKpQ3MEk05JP60Th+BZfYDp/B6YE/QY3RqScgnVsGOrN4fcB3JZyQUTNN42V7M735jfgS6NjZv6+Uc7wLUpqF7081ctGqMYhQGeNs/W1VNUNMgj3nmfkio24UlJ66TwjsryEi0n6K9+niy0H/bhVNVJK2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CmmbI6i1; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-aa67f31a858so2398613866b.2
        for <stable@vger.kernel.org>; Sat, 04 Jan 2025 22:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736057040; x=1736661840; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=adQpZCzVwsUxJMH9Sl7u3Cnr0pIQV9APs23asxuPzjE=;
        b=CmmbI6i1dOMqirdhfUX9aljcnEdb1bHeQnZPFqUgN1fdi1tVsIf45P3Hh02Swh3peH
         Y8QGiAFouETH54kEnPiHBz/MPvkYHXfh6bgmDlVJbRC9xK2Kl8Zxt9Q7mcc6Icd7BOre
         stzHNDJ1x+VaQoPhL7DQkkiTDP8ewF7seqkT6zFkP6A+OnaIER0DlGp4cBNNHtq0Ne/d
         1Q1/U5iXKv5RnMvAfRHHQmnkEja+pIxk6sp8WtTUX4zJOGlm4em96+TbQPoFNxUxPZxC
         8v3J+GLgHvKpCLyejv4rjr1wQ4X6Yspr9g7ylLhJF2AL57nsFIBN1CFaQZdxw2feLvQq
         rIPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736057040; x=1736661840;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=adQpZCzVwsUxJMH9Sl7u3Cnr0pIQV9APs23asxuPzjE=;
        b=iyLTNXbKYI0iNu4qoImEIRo+q6eM+mt7FOtkVAJ4Jyg7zy+PAew8ahVVj7yUAjb1/y
         UNlY5lApoSxkjUrZPSwSl3KPpDTPc1BgjE0rZn/NVliRB+wMKA+qZdsbKU/NqNUkXx4Q
         dKX6mOd5EhlzIfj7H2+LOrI0nBTULQ2xnKzRl8C7snEvxLH7jP2Otw0SvmjqoRNpGmUb
         hfKP2VHRzWekJvow3mkPJZGb6EE9ErSb+i1bmHLKY7+T1JHzElqp1xLnVeOE1UCD2wXN
         NCMZToMTd0tOmQ1P0sLUFj6aXNujbcYKjQEVIzq4n+VB5Wg2mHqZZ4NEMzCM2rc2kmPB
         vchw==
X-Gm-Message-State: AOJu0YwbzBjSZiR8QRXkxS/G0Ghm1QfRoMN50/RYttmwoVKCXwelis2w
	kh+ASowCyeG6jBQoFvfMFQ8gRGisbcpWiBioZuxMV+qSi93TvPFtQyYyNAfO3M8=
X-Gm-Gg: ASbGncvMK9iG3p1ypq1C7mDtZFy3L8Of6E9SEEcwmw0pfTsjcjY0DyBXI+eoObbZp0b
	t5N0cAEsTrmj4MZhwrBQupWJX8VFO01MroIGGdgxhneJe81yzEQIaab05vtEz4Q5lFUWD5hHWYX
	mWNGNrd9wzJK6GO1R4H0EaWRguXhrbZXv88uutncDnEAUoxjR4Og0o6iU5lUfPnyLXzvwu3zyFN
	7jykoSG3hg/aYNNmTY5YoBbDU4QFA3tmxGZ6m0LD+fg/kR+JgpVcvXO56AYmB6qrvBGlXOGdV6w
	8uDs+zNf79uItumJLW3RVtXMep+7g69gOrnqLlZ/eW8yFk1ExQ==
X-Google-Smtp-Source: AGHT+IGClYInbuwyZWqu+tI/m1itPwDRjWX0jkhm8FqnMnP0zHChaoUy5ruEuD4xyAoAVLWQkyQ1gw==
X-Received: by 2002:a17:906:f582:b0:aaf:c19b:6ca0 with SMTP id a640c23a62f3a-aafc19b6d75mr412596666b.5.1736057039635;
        Sat, 04 Jan 2025 22:03:59 -0800 (PST)
Received: from u94a (2001-b011-fa04-129f-b2dc-efff-fee8-7e7a.dynamic-ip6.hinet.net. [2001:b011:fa04:129f:b2dc:efff:fee8:7e7a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72ad3393d5fsm24946303b3a.154.2025.01.04.22.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 22:03:59 -0800 (PST)
Date: Sun, 5 Jan 2025 14:03:50 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Levi Zim <rsworktech@outlook.com>
Cc: stable@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Tao Lyu <tao.lyu@epfl.ch>, Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH stable 6.6] bpf: support non-r10 register spill/fill
 to/from stack in precision tracking
Message-ID: <fz5bo35ahmtygtbwhbit7vobn6beg3gnlkdd6wvrv4bf3z3ixy@vim77gb777mk>
References: <20241126073710.852888-1-shung-hsi.yu@suse.com>
 <MEYP282MB2312C3C8801476C4F262D6E1C6162@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MEYP282MB2312C3C8801476C4F262D6E1C6162@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>

Hi Levi,

On Sat, Jan 04, 2025 at 11:02:43AM +0800, Levi Zim wrote:
[...]
> Hi,
> 
> I think there's some problem with this backport.
> 
> My eBPF program fails to load due to this backport with a "BPF program is
> too large." error. But it could successfully load on 6.13-rc5 and a kernel
> built directly from 41f6f64e6999 ("bpf: support non-r10 register spill/fill
> to/from stack in precision tracking").

Can confirm. I think it's probably because missed opportunity of state
pruning without patches from the same series[1].

Given it's a regression, I'll sent a revert patch and try to figure out
the rest later.

Thanks for the report!

Shung-Hsi

1: https://lore.kernel.org/all/20231205184248.1502704-1-andrii@kernel.org/

> To reproduce, run  ./tracexec ebpf log -- /bin/ls
> 
> Prebuilt binary: https://github.com/kxxt/tracexec/releases/download/v0.8.0/tracexec-x86_64-unknown-linux-gnu-static.tar.gz
> Source code: https://github.com/kxxt/tracexec/
> 
> Best regards,
> Levi
[...]

