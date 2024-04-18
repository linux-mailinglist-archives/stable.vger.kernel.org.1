Return-Path: <stable+bounces-40169-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5256E8A976C
	for <lists+stable@lfdr.de>; Thu, 18 Apr 2024 12:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0A3A1F2366F
	for <lists+stable@lfdr.de>; Thu, 18 Apr 2024 10:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D3E54FAB;
	Thu, 18 Apr 2024 10:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VcC210eU"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1F1433C7
	for <stable@vger.kernel.org>; Thu, 18 Apr 2024 10:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713436366; cv=none; b=uOfRRcHJQWuG563/1PBmSTPfsao6qG1ts59P+EfhJe9xol6vk/497yOctfw7BWd0BnAdvc6nnE+TlD8SlzWcPBAOGd98M5gVr0Oe7nicXOa/eDfGpcLopDsk9antYYSb3FVUL96sIgrGkt2ZfncLfz6KApvPr5O7fZFfhuJT7Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713436366; c=relaxed/simple;
	bh=qDA7ncPskclNtcNdD4qPnFycTHKFsiKsJmDSnUI8qtY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cYJN1LyTLkI+Obb/m/Zxa88QTt7nCpeqX82O3Bhv6jlCm2ra3rCG1lDSC2fMWH6jgte9XAXbxCsvgmDPpLvL82aXhU/Rx7n/Y9pcmjoxwuGvLAg45r8fR5F+PVB/vc6mt47rMCXoe6uso87lOqkMWK24unJvBwggq0YR5wKaFB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VcC210eU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713436363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YXR9F/npCdkSOpAXUaKTWQ5tHjvfF/kvK+EEn8u6+ic=;
	b=VcC210eUKuENLyZefkwtcn9FnmEcYcSTJdBlH4U9/6JAPQ98MdoPEtT/ZnlM6Y+4Xos01i
	Zoyl+bnumT0JaTiLBqAv7S0IRz20OlrbKXemaLYfJd8s7h1xJ5f3UngT1bt/jp5fQLtvrM
	NnNBLpPKgT/eRdmPPfMV+TokqdStRtc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-sTDpaVALOOWqUT-eu42Y0g-1; Thu, 18 Apr 2024 06:32:41 -0400
X-MC-Unique: sTDpaVALOOWqUT-eu42Y0g-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-348973b648fso127302f8f.0
        for <stable@vger.kernel.org>; Thu, 18 Apr 2024 03:32:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713436360; x=1714041160;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YXR9F/npCdkSOpAXUaKTWQ5tHjvfF/kvK+EEn8u6+ic=;
        b=brIk2CZYVimQ6gqMAjkEOOXLj959PLQr/C8Tbkb7ib8dSbfMhIhkUwz5J7xBw4Ubty
         UOuFTxkd7C7lBFJKOXI/244iIy2aZzL4NnVA0Undp9hAU4BZ1wfbMnenVQYL9LgP4cQP
         mu1XePpummnYaQ2UFOqAUpvjMdjtQYushvv16KUFIirvJxrasAQ4UJgnoLLu9s/nDqdA
         IB4O5t7u9M0diLYL27EfpZzB0O1qWaF69dKuFRsHp8L1oRseRgP3nMAtfOA0e2zHTOrF
         CgRQfnl7bO9CL7VaSVqkYaiCVgELQkItkmupgpJGV5jsNy6CrEA2vcPQi0ABdEig0Cj+
         w+Yw==
X-Forwarded-Encrypted: i=1; AJvYcCUSlXPyvXN2s+l+317qBby2stw9vkUxWdS+93ZFhQtcfTjfld6gEHcbne+OTPEzBP4lGgSE+sEbfMzRdoKrwWdqB04POPYa
X-Gm-Message-State: AOJu0YyuuppysPxD0ChxR6LrvB+TbadJNftMsVwfk09JprOLXM18sbA5
	y7/PlvNbhI8jli6xFGp3OW9WVJM2YHfmsDO/6J0/FdB7Ii2c+S4NqYHeYqflcB2zjxzBdyhySA3
	4Ya0TWhl33oEqIpp/7nSNqMQMNJeeWABGDeVD+ty2xiwILGr6NTRXFA==
X-Received: by 2002:a05:600c:1c91:b0:418:9a5b:d51 with SMTP id k17-20020a05600c1c9100b004189a5b0d51mr1791828wms.0.1713436360729;
        Thu, 18 Apr 2024 03:32:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHg2H/1atXrATgPKNqMD5yHr4CuTsUiPGp8df/cWohFlVSB12daqy1BxY2y2j6KQJEDLY+KCA==
X-Received: by 2002:a05:600c:1c91:b0:418:9a5b:d51 with SMTP id k17-20020a05600c1c9100b004189a5b0d51mr1791812wms.0.1713436360336;
        Thu, 18 Apr 2024 03:32:40 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-236-143.dyn.eolo.it. [146.241.236.143])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b00418a6d62ad0sm6011177wmq.34.2024.04.18.03.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 03:32:39 -0700 (PDT)
Message-ID: <0a17d6745d5c6d4bb635cfac1029e90c1ac2c676.camel@redhat.com>
Subject: Re: [PATCH net v2] udp: don't be set unconnected if only UDP cmsg
From: Paolo Abeni <pabeni@redhat.com>
To: Yick Xie <yick.xie@gmail.com>, willemdebruijn.kernel@gmail.com, 
	willemb@google.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Thu, 18 Apr 2024 12:32:38 +0200
In-Reply-To: <20240416190330.492972-1-yick.xie@gmail.com>
References: <20240416190330.492972-1-yick.xie@gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Wed, 2024-04-17 at 03:03 +0800, Yick Xie wrote:
> If "udp_cmsg_send()" returned 0 (i.e. only UDP cmsg),
> "connected" should not be set to 0. Otherwise it stops
> the connected socket from using the cached route.
>=20
> Fixes: 2e8de8576343 ("udp: add gso segment cmsg")
> Signed-off-by: Yick Xie <yick.xie@gmail.com>
> Cc: stable@vger.kernel.org

Minor: the patch subj is IMHO a bit confusing, what about removing the
double negation?

preserve connect status with UDP-only cmsg

> ---
> v2: Add Fixes tag
> v1: https://lore.kernel.org/netdev/20240414195213.106209-1-yick.xie@gmail=
.com/
> ---
>  net/ipv4/udp.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index c02bf011d4a6..420905be5f30 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c

What about ipv6? why this fix does not apply there, too?

Thanks!

Paolo


