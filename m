Return-Path: <stable+bounces-60583-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3151693717F
	for <lists+stable@lfdr.de>; Fri, 19 Jul 2024 02:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E3D9B21AD1
	for <lists+stable@lfdr.de>; Fri, 19 Jul 2024 00:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590531362;
	Fri, 19 Jul 2024 00:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SOiFiC5G"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C664510E6
	for <stable@vger.kernel.org>; Fri, 19 Jul 2024 00:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721348887; cv=none; b=dVwoT3PsjLR6rlMeiQaf1RmYmpG+NAc7V5Y1D465CxYfvp/y/gYdvU9k1ea9nD2la8PTTgJ+C69sZPMDIkeBn+D0VzL3FZhE13/5TcX/2swQekOG+tg/Du6F+S0CX/rkcUpIQHKORcbanAWTqKcNAQHmz/pC4GJzlEEYW02lAfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721348887; c=relaxed/simple;
	bh=d/mu7cP5jjh4/mMkeiQeWWPOvB/ezlKKGiah4w7cxnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Udl/v9qFnsgBId+SP+ocuTfVrptUz2Sw8dNC0uzQlqQ+HbpuJ2Sh9jSSDJK69kExS0q2DeMr6LV7gzhpRoyJviN2kI5Q9CAzJjpXK49f0difdWoliAlQeDiPjE63uTfi5CpSkO47miC/7CQQBqn7Oj0uNmyd2o8qO8Br95CM9ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SOiFiC5G; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-44e534a1fbeso63391cf.1
        for <stable@vger.kernel.org>; Thu, 18 Jul 2024 17:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721348885; x=1721953685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/mu7cP5jjh4/mMkeiQeWWPOvB/ezlKKGiah4w7cxnw=;
        b=SOiFiC5GZSpWieeDEJViQIuMuLItkipn39/xE10j1uHkfAdrFAcqa3Jf3JmyzbvN+y
         EYdG/QB66ILyRXn84skqewqHq9t+5lh5+nReRG9rRXYzj1edTC1M1ICmTJEFyEam+sr1
         jXGSs51LvldvXmp4PCfyg3XVt3hiZr10ULLAMp3HX15VXzUfyMIGPmK9tPBDHJVPAeyb
         kxRplOYRRhuN+xQ9ZbSA47zzveHFV6lCleyu0p82n4yciPOhsVPa5JrDqmkOP2I+uxdb
         QtqEUuUl5FtBMLFlMtkLjSbfMSdYL4NKbPn7rkxeGG1U0CmGfLqdv9usa/Rmqa6ukw3v
         vSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721348885; x=1721953685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d/mu7cP5jjh4/mMkeiQeWWPOvB/ezlKKGiah4w7cxnw=;
        b=ixWNcSFDJGaqXe2eEG4eQH2MhmablUVMLGo2WIkSB4yV07B6WpIsX2p0vIfeBygrns
         eH160b100AD9Q2bX4p9D3fk4Q155+o88mjn4BdyIHRifB4UUELd3wbjUnxmVSV92MXKb
         v2YleNoMmJHXsAc8io3zvjuLTAjs8nuRmWHU7/Dfjr1V7g5LxY1kTdaFYlu2Xy69seor
         p6/9YhFp/Og6nA6/9slsrY0epKFwXFaB8GBOR6vXSkmMoELkdUb5ibLLDw5AKzBoBDXJ
         uyzJyve+vBsEP/eqzLM5pm9rekJbh+IxP85vO9PRaZJ8qSCygvwUzxY3bHLRYIQKeP3+
         Phxw==
X-Forwarded-Encrypted: i=1; AJvYcCVuIv2HgAhAAl5Ex7qCvr4/MMqhS+/BvJxN2nAF6gsrkERFPgpyHrH6zGHF8dVisachpy6rS0cXT4BhDqcJTtt+Ls342/hm
X-Gm-Message-State: AOJu0YzW76mezOx2atrHZN6KSo9NRAbne7kU9RaTsbM7zD6MLtsrXWrT
	MlqIiz+vz4ovo5yN0uSTtqWI3wnaYpOGpToKHMFGHSX6q78zy9TOunnE3n8UnAOyZ6FH+FCnDrz
	fTXC1DGPf8Ybhci+4FAORSurRCkQwkQV52JYU
X-Google-Smtp-Source: AGHT+IHUkPwwLyEnDU3Hrb7amWYbKCA9FWJ11CAI2pEwICjFFna9AffeJSpzThNFzs2JvY0VDMW9yOx4FTbfDn4t5hA=
X-Received: by 2002:a05:622a:2295:b0:43f:ff89:dfb9 with SMTP id
 d75a77b69052e-44f9ac6c683mr1506831cf.6.1721348884454; Thu, 18 Jul 2024
 17:28:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718190221.2219835-1-pkaligineedi@google.com> <6699a042ebdc5_3a5334294df@willemb.c.googlers.com.notmuch>
In-Reply-To: <6699a042ebdc5_3a5334294df@willemb.c.googlers.com.notmuch>
From: Bailey Forrest <bcf@google.com>
Date: Thu, 18 Jul 2024 17:27:53 -0700
Message-ID: <CANH7hM6RA1-OLzu8dyz9b7oz+tiOmD0W7NAxyD9=c7qvj=+TZQ@mail.gmail.com>
Subject: Re: [PATCH net] gve: Fix an edge case for TSO skb validity check
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Praveen Kaligineedi <pkaligineedi@google.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, willemb@google.com, 
	shailend@google.com, hramamurthy@google.com, csully@google.com, 
	jfraker@google.com, stable@vger.kernel.org, 
	Jeroen de Borst <jeroendb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 4:07=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> This however loops skb->len / gso_size. While the above modulo
> operation skips many segments that span a frag. Not sure if the more
> intuitive approach could be as performant.

Yes, the original intention of the code was to loop over nr_frags,
instead of (skb->len / gso_size).

But perhaps that's premature optimization if it makes the code
significantly harder to follow.

