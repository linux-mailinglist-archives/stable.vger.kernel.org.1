Return-Path: <stable+bounces-78212-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D69CD9894C8
	for <lists+stable@lfdr.de>; Sun, 29 Sep 2024 12:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ECCC1F22412
	for <lists+stable@lfdr.de>; Sun, 29 Sep 2024 10:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A179B1531F8;
	Sun, 29 Sep 2024 10:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boEBA0Qb"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1CA143C49;
	Sun, 29 Sep 2024 10:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727605279; cv=none; b=CVeUo3vK5sUy3ui/UETlp+PQ8HHEF8rbjeCGFD9JcnJPsIl7qwMNYH7jYlK4G5cMQ1sVDbrDnan01PSvnXfUj2BVIayMIZfRnK46RofwVvtfxl4sOGCK3blcDFmOQpLlmvz3F+YM2hv5YDBu+Owz2pzGW0yzFXV1vrBNcpSng10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727605279; c=relaxed/simple;
	bh=hPtnaW9AxYGdsgYJ++T1Vj846oduxLU672fnSDCjmQ0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=W/XF+Ti2vMdHT1T8qQHpXt/9F/yhgggQRjaKkGb84cp0S+ti7DaM5uwY1qOZVXbKNY3QDL+Ih3X6u1/HquVAL8T/Slsgd2EnLqqilFEpxVWlqKPPfzNBGscvTOYTKmRHSfrkM6Ylr/lcMhrAtNtzp/EJ+nI/MdmusECJ2BgseCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=boEBA0Qb; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6cb2e5d0104so26046926d6.3;
        Sun, 29 Sep 2024 03:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727605277; x=1728210077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzDn66nvfxb/RF8p67v+9ji03REicd7HmvitNQOUA40=;
        b=boEBA0QbBDKs/Sy8Ww93KwoPMppcpdk0OnANUrwWQF0JwXDw9CdF6rfVX3BrwoCd5f
         wAS51r8goc8sKsE+tPZS8UTtrfFrfZzNNhlEmsmfQsx3lAd6wOv9SKm5PjDZgPLId+DP
         PisN0ogiDkGuMwASY82TCSROJtiuUG7BlBPZIQ1QGiYM+4blUhLgnf40vjplROAjr0rT
         RTQhJhkIn+kjMUg/tzq7QaXe2f1vxz3p29iT9juK57P9UILforLSL1rwA3OOGcmfroxf
         Ylr2P0XE/ZcE0PuTQnwAglMlfEx/TAiDpIYp6VhlOZiAX64Pr5mVkZ1ugCkB+aKbl6M1
         ONwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727605277; x=1728210077;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NzDn66nvfxb/RF8p67v+9ji03REicd7HmvitNQOUA40=;
        b=MHAtSvvQEb7gTVbQ3fwcu9xGOqg0pZaupHe5m36PB1ayroOjSaEWQDityCh3Awa2hC
         dkYHAG879Oau6gpA9OrpHORF13w5L9UkrSaCc/D5w6mKSGuFGirmWAQopo+Tq3T3e/lg
         KmlW4DLhEPt1PlejWnpvRBtsnlsKvXSK5VYQRFppZud92HOJ7OWKrGEDeIk8OvE7pZbC
         dZi38YHy++paJ4NHLaT3tR/YF/dP8AenYzoJHZ91QYdabcM0yBM12t2++3Y7xBZJY2HA
         KQgXSDj21bx4Jw3xjpZboLWy2bq4nZwfHEIAUifeRKuGkP954KJTGK0Pg1gRe8ayjww3
         Euzg==
X-Forwarded-Encrypted: i=1; AJvYcCUcq/opxKLQ/nLOeiQIYeWGDwsMJEztYWDFd55Owij6JRy/XAswwvGOgmBXllPRys6h/fh4+ZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKSV/6fpVTshLVfEeTCHCcyvM31wP+u12aY0ZVK2Uyb/UNkZxJ
	kll2d0sg+4+GYSJpzRkwNGSkYNXxLETRF9/npm04q5+0AUi08BU5
X-Google-Smtp-Source: AGHT+IFemweOiq+ZasIJspHRQ1Hu7H7VreQRyNeGeOYAOiVgnv8JKeAclQ3KHlauwLndqKX4wMUiNA==
X-Received: by 2002:a05:6214:5f0d:b0:6c5:3122:ffac with SMTP id 6a1803df08f44-6cb3b6497ccmr94720016d6.45.1727605276660;
        Sun, 29 Sep 2024 03:21:16 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b5ff1basm28983886d6.12.2024.09.29.03.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 03:21:15 -0700 (PDT)
Date: Sun, 29 Sep 2024 06:21:15 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 stable@vger.kernel.org, 
 greearb@candelatech.com, 
 fw@strlen.de, 
 dsahern@kernel.org, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <66f92a1b7e5d0_13018c29434@willemb.c.googlers.com.notmuch>
In-Reply-To: <ZvkZ0Ex0k6_G6hNo@shredder.mtl.com>
References: <20240929061839.1175300-1-willemdebruijn.kernel@gmail.com>
 <ZvkZ0Ex0k6_G6hNo@shredder.mtl.com>
Subject: Re: [PATCH net] vrf: revert "vrf: Remove unnecessary RCU-bh critical
 section"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Ido Schimmel wrote:
> On Sun, Sep 29, 2024 at 02:18:20AM -0400, Willem de Bruijn wrote:
> > From: Willem de Bruijn <willemb@google.com>
> > 
> > This reverts commit 504fc6f4f7f681d2a03aa5f68aad549d90eab853.
> > 
> > dev_queue_xmit_nit is expected to be called with BH disabled.
> > __dev_queue_xmit has the following:
> > 
> >         /* Disable soft irqs for various locks below. Also
> >          * stops preemption for RCU.
> >          */
> >         rcu_read_lock_bh();
> > 
> > VRF must follow this invariant. The referenced commit removed this
> > protection. Which triggered a lockdep warning:
> 
> [...]
> 
> > 
> > Fixes: 504fc6f4f7f6 ("vrf: Remove unnecessary RCU-bh critical section")
> > Link: https://lore.kernel.org/netdev/20240925185216.1990381-1-greearb@candelatech.com/
> > Reported-by: Ben Greear <greearb@candelatech.com>
> > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > Cc: stable@vger.kernel.org
> 
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Tested-by: Ido Schimmel <idosch@nvidia.com>
> 
> Thanks Willem!

Thanks for testing immediately and sharing the below context, Ido!

> The reason my script from 504fc6f4f7f6 did not trigger the problem is
> that it was pinging the address inside the VRF, so vrf_finish_direct()
> was only called from the Rx path.
> 
> If you ping the address outside of the VRF:
> 
> ping -I vrf1 -i 0.1 -c 10 -q 192.0.2.1
> 
> Then vrf_finish_direct() is called from process context and the lockdep
> warning is triggered. Tested that it does not trigger after applying the
> revert.


