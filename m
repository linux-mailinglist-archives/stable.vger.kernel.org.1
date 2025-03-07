Return-Path: <stable+bounces-121410-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED55A56D76
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 17:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B96A217006E
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 16:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAE823A99D;
	Fri,  7 Mar 2025 16:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsAGhskp"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6D2238179
	for <stable@vger.kernel.org>; Fri,  7 Mar 2025 16:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741364511; cv=none; b=UHYWnRexMLprmDRBFp2oE4AM/OUlrtRJ0SQin4/mGOHAOhTGxHXuxlOrfmUg51yYqXQY0NAjm6tK8dG73YoDzi9mGqkSaHdCfp5+VCT50iiAfXJkT1dHoeAi/Jkqv2M2B6cJe/WjaizSL7BJdDhAml3dmmJExUvzxJwIszCRqXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741364511; c=relaxed/simple;
	bh=oTuucDDLWOSV13jSo64S+laIqQgBC97Xbt0jUS2kFmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DK5zpe/JQhQb5SNiwFmyUUOk9xcFR/0DMI3+TSlC1egWQQzxuouRrmTbPsirZGaeAFdw2udBH47QXj6aPtZOods+50wjEn4i2UZe0PuuCtIg+K038AdCsW3EGG72akiCTf6aeSbOoqlQJ/lE3WkwNf37y07K22UF8PIj4fR2L0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hsAGhskp; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2fc92215d15so507735a91.1
        for <stable@vger.kernel.org>; Fri, 07 Mar 2025 08:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741364509; x=1741969309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crb+YnHv21MUfrarjAdm1XTka4z0nhH9pKBGyObHkq8=;
        b=hsAGhskpZAD+0Xw7wGI4hZf/wCDg+r/C1lI/JEBIptZ9JKipPYROfpTZTxZEjKTRzH
         aXk716UbiEBqVnRwAonibW9D3DlzVIcD0YTSZHF58LaX8zdI8LeFWrI9Yz2s7U4IP1Cg
         Xjzj071TXDOgJDD/ChTDp4bHlvTfWnXPCk8ErG0c/NU8afoT3FBYgEONBACJquiKddXw
         Emp1sUiz/JFkGnXisAlPo6UnZXrYM4RYY4tAX0HixAKQUtoEIWXknuD2IP60spbi7rzT
         eBcRx5BkNH76vDaqwvNxlAhrrxyrSELLqcbIGx8svl/S8/r5NjStxTlbGBoX8cUUXYaZ
         S1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741364509; x=1741969309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crb+YnHv21MUfrarjAdm1XTka4z0nhH9pKBGyObHkq8=;
        b=VgR8JjiD4LIN2lbbKAwusJviwAJhXyz6wg8xfK90zUFBQFovpet803CMfg+oz45q4a
         XHUW4476VJRYEJbIH9UhCT/jn5LFwLIuWsXtykad+KVBq/B7ce1Xfetj8dpaGmnmgxlR
         7jgE64jBCwRFTFwK+3iHFr0/6UqooQ2f8ZW9msLnqJVJfhHjL2ry7JD9elNdH1A3VWXr
         OavhToHdx80XQlx0aW6JGYRbRNr9J4NfoJcFRGinPXw+GmL6z+HDtgPuL2ou8Bta8GKh
         9tkEW1L8IJrDTItq+H6YFPAbygu90Ho22PH8yiPGJEIQhuqCs0b/uea+VJ7s8tHPG5um
         WwmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQ+T51osw5SOHFAyaR+lLaKaFCApC7+WuvGmA8qU8M/vxxk48GabuFpA1aoGGIwraFmJG3Nwo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5hCj7tqdv6hcUVlyXUvNFiFm+QR3AY60p7/eecs+quJ2Pw17r
	fUzaSzwurx57Rfa48o1CPdnLyTCgfwQI4F/MUgNIEPlXJ/CyS7yKWXxM5XZINik9gu2N7c+G5UW
	ysOwO8nn6LePkLEai1mdPU3AzoCE=
X-Gm-Gg: ASbGnctWYzv5Ly3DtnI7fApXverB+eUzcJy7PDsNMMh+0QaiOrcXQy7bNWasQQo92Ot
	/sIgg1+o2eS6CIuaArrob6njdnfYfb7KMDNWpHzYfq5E2BVwj/gvWshviWKusLdwVY7zcdUDUyC
	T5E7yBrpkDOuQsLI2V8AnlEnDkVg==
X-Google-Smtp-Source: AGHT+IFUx8k3eGUpxn51o0J0EF0zgggw4iy9pgOhEpNfOo0BhQGAjD22YObHqKbexp4i3ay0EB8LSifNxbmA7PmiiPc=
X-Received: by 2002:a17:90b:4d8b:b0:2fc:1845:9f68 with SMTP id
 98e67ed59e1d1-2ff8f8fa207mr77856a91.6.1741364508798; Fri, 07 Mar 2025
 08:21:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72kaO+YcvaHJLRrRw1=KteApRnRM0iPuSwgFkaCf2BR01w@mail.gmail.com>
 <eotqeb6tyriytvnkjignfkjnie5wb7nzcwjimahxmgnbzxcpmw@mhpoanbqzmiz>
In-Reply-To: <eotqeb6tyriytvnkjignfkjnie5wb7nzcwjimahxmgnbzxcpmw@mhpoanbqzmiz>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 7 Mar 2025 17:21:36 +0100
X-Gm-Features: AQ5f1JoeoWOU_mG2K2dnFaQcR1GIH9yvxjoMgbGcWSBx2fm6uSJt6Rb7eEyvZW0
Message-ID: <CANiq72md_k9AK43tP9UOYyA9jAyC0y96e9Pqn5c8_-fqXh-Hyw@mail.gmail.com>
Subject: Re: Apply 3 commits for 6.13.y
To: Alyssa Ross <hi@alyssa.is>
Cc: Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	stable@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>, NoisyCoil <noisycoil@disroot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 10:48=E2=80=AFAM Alyssa Ross <hi@alyssa.is> wrote:
>
> Has anything come of these 6.12.y backports?  It sounds like we're
> otherwise about to have to disable features in NixOS's default kernel
> due to build regressions with Rust 1.85.0.

I will be sending it today (I will Cc you) -- it will be a fairly long
backport, so tests welcome!

Cheers,
Miguel

