Return-Path: <stable+bounces-77770-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DD4986FFC
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 11:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B3A1B22F2B
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 09:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3E01AC45C;
	Thu, 26 Sep 2024 09:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iS31+wEp"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799B31AB6F2;
	Thu, 26 Sep 2024 09:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727342577; cv=none; b=bBa9tEkftBGqNDCIJAHDNV5ZT3p8eSi4mbTXJjn/PSEpgZRnJi1rds/1StRBIAnGhU7isccPUt475XfGN1/tf8v/Ikbjj0xXG/DUqVXZS3yX7/RC0y1ibqvnAmpsO15sN28bZc5qoYgD8MGdejD0jsGcsJxW2cuJdVA+SR2yBGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727342577; c=relaxed/simple;
	bh=WXMGo/VjG6N9HxCSkpebpXRk8ZJX8uCaKrQzAg3LTuI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=pF5wFZ4hlHuE4z8/ZjG7ADCrFlND0QKhtVtPvJdxWVOyB6gMmVYdW6i/6gbumS5p9sFCqcGWxz7paZ0a3G/vcNV+5PCG4v5t30blOLR4ENskmW6PziaA2HWUawBW15JhE7wS23GP3jPS2XaoLSTCSxXEVcgaZC0akCK0HRHP6cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iS31+wEp; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6cb2d2a7d48so5114766d6.3;
        Thu, 26 Sep 2024 02:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727342575; x=1727947375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AoWMnzkVzH2m1ZK3d8Jln/bop2jnSvjpVfa21UQ4tqo=;
        b=iS31+wEpSvZnST5ui2W4V+GyLmRSmrP7db1SQDEaKOBHKodmNsr68yGa8R3Xq5ybJq
         ggjYpsZ5tvFNtUj/RvpTGNAvP+0864qtpoMh1I6soBkl9hz2nHs6AvmSsHBbLZsvkm26
         SWa6ACgyIS8EvjH1YBOFVN7R4OMSt6tPi0K3euRx1G8EGXZ9+nZ4TEQYRIDq0vzp7PrL
         8CyFzfJ4GthXhJwHl14/7j+c+tmHELMPzyV/gdIhRssRsLPl2h7iFsL5BgEXhNCznOXE
         xJ7lsMMxgFMvgiunb4X2EQiyD6Z/3mQ4v+irA63rdVmGplK9/fTMl3GZ8hW4/USHpiQh
         Jr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727342575; x=1727947375;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AoWMnzkVzH2m1ZK3d8Jln/bop2jnSvjpVfa21UQ4tqo=;
        b=pcb3wW1Er2WLNse57atMPxbroBykbo/k0EIXjmyJ0gt5W/0iy/8QFlbjAh31oDjmZo
         WFfYX1QtqaX5eWl/oQCwXtiE6xTgArvpE5aXU37rvclAcuFhcp563ieYEVJrxI+kkVOy
         fh646SIONJ8FacRjL8BE3+jp5Y/RlAO9nYVIsh1J407HmMZkhKzA6sLHGSic5eR0kSvd
         jqTfei012pF59yAKvfSqhSeyuQ3Jb4Z4gr9C2Hp7M8fpxqMb8qGIXSDjL+EOCGtB5jJm
         PY2VRB2tDk9Rhxlsxad9ar1mIP0/vYb9e812D38FSl11k55OX8H6APmttHlic8vrtVqu
         JpAQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0qBSZ7sTHlnyu6eJqtBLaedqaB3vFyqWSY8cl4DOn2Vte80txIMqWOTNxbQYj4af5I0MRTT6X@vger.kernel.org, AJvYcCVAzxle/sYhF5KpMoMTeNhEpEPOGbB+APmIKY0fJjUXDHZgaCTT9oM1FygL4VplrCe9nShtma4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+1cJou6/UoPd8E3s31mrpHn431LPXLmsp5EdrLvxG3+HS13su
	aPBgcvpvX9wJFQ2yYcdXgbt5c1injMe8vuEZaHcBdOkXH+9zSIgb
X-Google-Smtp-Source: AGHT+IHtLB37qSDIJp+LXlz2EN6opY3uK6h6O2u3WusUvJ61gOa7yVIKhhZU9C822EsPpQ3G66civw==
X-Received: by 2002:a05:6214:4a87:b0:6c5:8a9c:9020 with SMTP id 6a1803df08f44-6cb1ddeec53mr78057106d6.42.1727342575188;
        Thu, 26 Sep 2024 02:22:55 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb2e738ec8sm7976306d6.8.2024.09.26.02.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 02:22:54 -0700 (PDT)
Date: Thu, 26 Sep 2024 05:22:53 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Felix Fietkau <nbd@nbd.name>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 stable@vger.kernel.org, 
 maze@google.com, 
 shiming.cheng@mediatek.com, 
 daniel@iogearbox.net, 
 lena.wang@mediatek.com, 
 herbert@gondor.apana.org.au, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <66f527eddcce1_857c5294b4@willemb.c.googlers.com.notmuch>
In-Reply-To: <daf225a9-8194-40c6-b797-8ab37de773a0@nbd.name>
References: <20240922150450.3873767-1-willemdebruijn.kernel@gmail.com>
 <daf225a9-8194-40c6-b797-8ab37de773a0@nbd.name>
Subject: Re: [PATCH net] gso: fix gso fraglist segmentation after pull from
 frag_list
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Felix Fietkau wrote:
> On 22.09.24 17:03, Willem de Bruijn wrote:
> > From: Willem de Bruijn <willemb@google.com>
> > 
> > Detect gso fraglist skbs with corrupted geometry (see below) and
> > pass these to skb_segment instead of skb_segment_list, as the first
> > can segment them correctly.
> > 
> > Valid SKB_GSO_FRAGLIST skbs
> > - consist of two or more segments
> > - the head_skb holds the protocol headers plus first gso_size
> > - one or more frag_list skbs hold exactly one segment
> > - all but the last must be gso_size
> > 
> > Optional datapath hooks such as NAT and BPF (bpf_skb_pull_data) can
> > modify these skbs, breaking these invariants.
> > 
> > In extreme cases they pull all data into skb linear. For UDP, this
> > causes a NULL ptr deref in __udpv4_gso_segment_list_csum at
> > udp_hdr(seg->next)->dest.
> > 
> > Detect invalid geometry due to pull, by checking head_skb size.
> > Don't just drop, as this may blackhole a destination. Convert to be
> > able to pass to regular skb_segment.
> > 
> > Link: https://lore.kernel.org/netdev/20240428142913.18666-1-shiming.cheng@mediatek.com/
> > Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
> > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > Cc: stable@vger.kernel.org
> 
> Reviewed-by: Felix Fietkau <nbd@nbd.name>

I will respin with initialization of uh->check

