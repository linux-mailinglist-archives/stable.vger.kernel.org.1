Return-Path: <stable+bounces-67651-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C2F951C51
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 15:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEADD1C23031
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 13:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788411B29A3;
	Wed, 14 Aug 2024 13:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blww45Ki"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA30D1B1433;
	Wed, 14 Aug 2024 13:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723643642; cv=none; b=f0ACczXsdB52u2Z1mFda3qkMNds/mdJqlje3gv4NhO5a7veTLD70ThJcGeTAKtdM0/Rj42rkKhFOGeyKwjrxb/N65LyNbCgacayNa+IKtw0cBa5gJVYgxuJSPcKX7hG4Yy2vPEMok/fr5ib98nwZ6Gm3xOqPUxHIPs+ZDbpDRQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723643642; c=relaxed/simple;
	bh=pVmwF7G2P8agT0vOSGb5CBnNzfqC5aZAhldqlokDAlQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=uoaUBzdKN9ecOn+/iHV76kAuJVHWfJUGO0XYT8fh97qFUOwz2OkYTUcIyUnqx1SGi9SIoPMrtyhvrcH6ZDGqzQ85rrpwCMPPTOEFyxkTjUEMWzBv2ZdSskjikCs/CKmPsrafeM7NWaoGi6J1wpO/1jvg+xMoVB5gtByhvSntemc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blww45Ki; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4519383592aso40926351cf.3;
        Wed, 14 Aug 2024 06:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723643639; x=1724248439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utWJHul5Du4R9rd2S0MY4SOzJbviKmWuhT4Hw98IBd8=;
        b=blww45KiB24dmYr0j/pFBxsgcJc/9QvL7zyZVHncfHv1wkVxE39WVxEo6xYAfWTNPy
         /0a5NFRpwYSxNuOjjNRy4P6Fah9K+knWwZVaiRjIimHGpRem6iUt+CI0IbeSgCM5COiB
         ALKMdpbcPnfkZVgJDBAbb1thjlC3S4mOedZfok0ahpCyZliD6h6RM/E+rxWvevs6Mz/l
         OtXoqNj7DphYwGBcE2H9vvb8HHT5VrtvPQ2H9Dz9eZ5GL7mTRsPuZdpuxa+96t/b7SYQ
         UPU91OCNrP5r6ryYmBPvidLfCTjs8Zt6+Qpc+B1hx7Q3VqER93rqWGzi14Ga7S5nx+fq
         OOAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723643639; x=1724248439;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=utWJHul5Du4R9rd2S0MY4SOzJbviKmWuhT4Hw98IBd8=;
        b=A3a1ceBiJhxt4cgExW6JXL/OwKqZMtGCknLtk6y0cSz4zWJn7PL5l6gyxSeaR5JeB1
         YQXG1gdzUeKEmuczwvUDRwpYh2L8vwe1lUe2P4fnl59Ity2Y0R1xlGdAPTV+RekRYcmk
         OXZBB9rKug3K/wLsZ+uHTE1a3nAIzC4PD0W0LpVE5Yd+mjKtko40EsjwFtg+4hmJScXp
         7OD1u9RPWBjNjMJcxR88hG4PghP3m9rOtMv8FZ6iixSA+wtNVgeW6+Gnrn0H64JY7j2F
         IeLU8ouXPK6yeK5ChV/nT1dt7er44ykQimv1JmkuSmGn3a9aNHfZVB16N4MvI47i0dVK
         sRwg==
X-Forwarded-Encrypted: i=1; AJvYcCXQR50FzAszaxfYS2s2Wt5+pqsizewzdo61dUsw4jJcnpcW2YzWXrN6y97/tb3LeA3e6DBCbqBRBQaHym13QRyZbH0kr3CvkEWVKVxAjAAqSOSPcvmCFRtyKEpW9rZu
X-Gm-Message-State: AOJu0YxLkeojg1G++wO+LCJF2DaLtQ0Xs6qnJrBYWKEEFUZpeTASfhca
	g4+v7gT2SFq3VJbFNFqpsZ56pZXb2Y2g24WrnGNtvqn7j1sT4Mpp
X-Google-Smtp-Source: AGHT+IG26aHZQ4o0SHh+Y2TSRBi05r/HN4WM3gUgtjuZvwpzGsDAKYKOBtBVn8mEfs/ixoJC6h9VXA==
X-Received: by 2002:a05:622a:5b0a:b0:44f:ddad:c21c with SMTP id d75a77b69052e-4535ba7aee4mr25549581cf.13.1723643639434;
        Wed, 14 Aug 2024 06:53:59 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4531c1a7f28sm41705531cf.10.2024.08.14.06.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 06:53:58 -0700 (PDT)
Date: Wed, 14 Aug 2024 09:53:58 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Christian Heusel <christian@heusel.eu>, 
 Adrian Vladu <avladu@cloudbasesolutions.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Greg KH <gregkh@linuxfoundation.org>, 
 "willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>, 
 "alexander.duyck@gmail.com" <alexander.duyck@gmail.com>, 
 "arefev@swemel.ru" <arefev@swemel.ru>, 
 "davem@davemloft.net" <davem@davemloft.net>, 
 "edumazet@google.com" <edumazet@google.com>, 
 "jasowang@redhat.com" <jasowang@redhat.com>, 
 "kuba@kernel.org" <kuba@kernel.org>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "pabeni@redhat.com" <pabeni@redhat.com>, 
 "stable@vger.kernel.org" <stable@vger.kernel.org>, 
 "willemb@google.com" <willemb@google.com>, 
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Message-ID: <66bcb6f68172f_adbf529471@willemb.c.googlers.com.notmuch>
In-Reply-To: <ad4d96b7-d033-4292-86df-91b8d7b427c4@heusel.eu>
References: <20240726023359.879166-1-willemdebruijn.kernel@gmail.com>
 <20240805212829.527616-1-avladu@cloudbasesolutions.com>
 <2024080703-unafraid-chastise-acf0@gregkh>
 <146d2c9f-f2c3-4891-ac48-a3e50c863530@heusel.eu>
 <2024080857-contusion-womb-aae1@gregkh>
 <60bc20c5-7512-44f7-88cb-abc540437ae1@heusel.eu>
 <0d897b58-f4b8-4814-b3f9-5dce0540c81d@heusel.eu>
 <20240814055408-mutt-send-email-mst@kernel.org>
 <c746a1d2-ba0d-40fe-8983-0bf1f7ce64a7@heusel.eu>
 <PR3PR09MB5411FC965DBCCC26AF850EA5B0872@PR3PR09MB5411.eurprd09.prod.outlook.com>
 <ad4d96b7-d033-4292-86df-91b8d7b427c4@heusel.eu>
Subject: Re: [PATCH net] net: drop bad gso csum_start and offset in
 virtio_net_hdr
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Christian Heusel wrote:
> On 24/08/14 10:10AM, Adrian Vladu wrote:
> > Hello,
> > 
> > The 6.6.y branch has the patch already in the stable queue -> https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=3e713b73c01fac163a5c8cb0953d1e300407a773, and it should be available in the 6.6.46 upcoming minor.
> > 
> > Thanks, Adrian.
> 
> Yeah it's also queued up for 6.10, which I both missed (sorry for that!).
> If I'm able to properly backport the patch for 6.1 I'll send that one,
> but my hopes are not too high that this will work ..

There are two conflicts.

The one in include/linux/virtio_net.h is resolved by first backporting
commit fc8b2a6194693 ("net: more strict VIRTIO_NET_HDR_GSO_UDP_L4
validation")

We did not backport that to stable because there was some slight risk
that applications might be affected. This has not surfaced.

The conflict in net/ipv4/udp_offload.c is not so easy to address.
There were lots of patches between v6.1 and linus/master, with far
fewer of these betwee v6.1 and linux-stable/linux-6.1.y.

We can also avoid the backport of fc8b2a6194693 and construct a custom
version for this older kernel. All this is needed in virtio_net.h is

+               case SKB_GSO_UDP_L4:
+               case SKB_GSO_TCPV4:
+               case SKB_GSO_TCPV6:
+                       if (skb->csum_offset != offsetof(struct tcphdr, check))

and in __udp_gso_segment

+       if (unlikely(skb_checksum_start(gso_skb) !=
+                    skb_transport_header(gso_skb)))
+               return ERR_PTR(-EINVAL);
+

The Fixes tag points to a commit introduced in 6.1. 6.6 is queued up,
so this is the only release for which we have to create a custom
patch, right?

Let me know if you will send this, or I should?


