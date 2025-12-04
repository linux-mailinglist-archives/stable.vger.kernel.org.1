Return-Path: <stable+bounces-200061-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAE9CA4F33
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 19:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 985373075FBA
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 18:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862F31684BE;
	Thu,  4 Dec 2025 18:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlvLWs2o"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E101B6527
	for <stable@vger.kernel.org>; Thu,  4 Dec 2025 18:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764871615; cv=none; b=VeciqG6h59nftlOKXivFKd9GrScEY34puK51w5giJFjxZmVwvH1KfQRu+Wh/+6KE/Pc+7HObyKbXNNVgdTwZ2SfHXaV6kv6V5tDCtZHKx5S10RQV7BlDMf/hc4vKrsfDfrWO2/jBMJRY9mYn+2pzZlsuiNAD21BfJpmMzMGAR38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764871615; c=relaxed/simple;
	bh=Rrdp+Zf9csQrPT16ROUyOy+alatztNf+KHjGfCRhUpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PLVTo57j1SRjwXsHEt+3z9jgYggStF2syPlvS+KEWxHEO9xTQCFBcGm0FHXts4qTOxyTMf4MukbdvNFRvLVkslyeaL5AOJEIGf/qmTO6pegq8ZXcNs6/K6ZYkh7MeRJiQ1nH03wjbRm03JdLvOhBf/b/DHWABT3RDFfmC9TGpRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlvLWs2o; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ed9c19248bso10432461cf.1
        for <stable@vger.kernel.org>; Thu, 04 Dec 2025 10:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764871612; x=1765476412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rrdp+Zf9csQrPT16ROUyOy+alatztNf+KHjGfCRhUpY=;
        b=mlvLWs2oAs8twkhd3Rng+ZiWWbt1jx2Twlo7ZtCJ+4JM7CFWcB+8gP3DdRQxP7WZ8Z
         ZLur0dZ9S8e60MiymR/SpBImHZLXT0g//rFOW3UfNTxrJRpBuXsGT3I0UEv4mSaWcf6K
         Dml49fYz4xdmhMkiwvlkM3Yj5NBFJ+R19A3zO7dX2lpl1uXK7mkxaAsTMkMb/lrDEpuN
         JHRiCoivYfELQ+alMqvlB2XQ7zDrW/2SN0bKrAvfTdK0rp7DxCI0Xgw0i15dWAToZlyU
         5hYga04h5zqkk4dZdgCLvGohw9Ih0xI6ADfwakwE9NdWzT+6zFo0AQsGuobJcIpTXiwg
         Q6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764871612; x=1765476412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rrdp+Zf9csQrPT16ROUyOy+alatztNf+KHjGfCRhUpY=;
        b=hoopNt/cHsdxf483vig7a0wl7WvSFiwTcxmD+7tJk2+1hf4YyiDHKZHdY4XktXufJC
         GzpDy/vAl2KAtirwW69O9ZZ6g4s85mEh4hho/yNj5ZWwOB82uAhvfePX5Nbou14kbb0t
         sUPUvQscMeRfODMEZD9rrfO8e7SQCcDZGtBVtdv8bnQiTiGaBbXGe6kyIJQ9N/SDiPKF
         U7cZ1HnStyt2ZdNv4f/e44XWK4Kx/5AL67OluqPScADwKwtZgHNs/QGupidwKOEeBHiI
         LWDbVbsrcCBdVvyQb4x4++ngh3GoEDXZ3egpeGGonit0iymDBoOnKwr0zR1DVkHTC91v
         9c2g==
X-Forwarded-Encrypted: i=1; AJvYcCUHB1wCogJ8bJf0/n7J4bcaWqIqagwNrUFUFCOk5JWPkBqhID6HowQuwmpv601zDqK947e36Z0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu+9Mu7eoHEJYioJJwJFVKV7toUwxXtpojGEoMWerGJ8bZOPQd
	WRkFCwLHLNiCESYRrlHYqsQum3tqQeJxTMfX2aiNw6xx8ujYOrOvhQNhanJ32HEWcadhsipfdeq
	R4VBuK6fx82jyjN0dDGW7Dqmmmr8Wk9U=
X-Gm-Gg: ASbGncuP5vcq5rz14tDELMtoPId+LmYn4fMMBqJ0zwGLNfGQQHdpxKjJT1v076QZ+Qr
	Z3ow+LZv2E1/yBhYUBjKOVfcj7677fD4+j1vtW/hR391qUtHyUP5Ows2YNk1pbfyHYHaRFuI+Ah
	7vSM3PkKRILKCoHO4TIFT47Q0NN1lN0BmKXzIwE8V2NULvrHxq3Zn/BvgGlOqPBuDqKni4qpkmT
	JPT0PvjvqFvRJJqJrzGajAmQPyTD+/+2P1IF03QKxB29BS9D5RxcngoLBkg8mAKL0DYzQ==
X-Google-Smtp-Source: AGHT+IG3fjIllf1M6OCTBTd4dSunSkyg52cMugpNYk6tQ4JIDEp/Anl2MiBIRm+2Hyasb11VlNQQzK6UXmCqQNXT5qw=
X-Received: by 2002:a05:622a:554:b0:4ee:2bfb:1658 with SMTP id
 d75a77b69052e-4f017655416mr83408181cf.45.1764871612155; Thu, 04 Dec 2025
 10:06:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120184211.2379439-1-joannelkoong@gmail.com>
 <20251120184211.2379439-3-joannelkoong@gmail.com> <5c1630ac-d304-4854-9ba6-5c9cc1f78be5@kernel.org>
 <CAJnrk1Zsdw9Uvb44ynkfWLBvs2vw7he-opVu6mzJqokphMiLSQ@mail.gmail.com>
 <f8da9ee0-f136-4366-b63a-1812fda11304@kernel.org> <CAJnrk1aJeNmQLd99PuzWVp8EycBBNBf1NZEE+sM6BY_gS64DCw@mail.gmail.com>
 <504d100d-b8f3-475b-b575-3adfd17627b5@kernel.org> <CAJnrk1a1XsA9u1W-b4GLcyFXvZP41z7kWbJsdnEh7khcoco==A@mail.gmail.com>
 <CAJfpegv7_UyTht-W9pimE-G6tZQ0nKU6fYo1K2hcoNSHYC3tpw@mail.gmail.com>
In-Reply-To: <CAJfpegv7_UyTht-W9pimE-G6tZQ0nKU6fYo1K2hcoNSHYC3tpw@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 4 Dec 2025 10:06:40 -0800
X-Gm-Features: AWmQ_bkfmaBxtqNiCodT9gGB1wJnTwkgc9tefeZRB6rVjqiHpy8rJCyBAd9v5hc
Message-ID: <CAJnrk1bUrL5z=K-yKGXRX8W0RtXrnnwiidrCyboLrr+9RFwnww@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] fs/writeback: skip inodes with potential writeback
 hang in wait_sb_inodes()
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	shakeel.butt@linux.dev, athul.krishna.kr@protonmail.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 1:28=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> On Wed, 26 Nov 2025 at 18:58, Joanne Koong <joannelkoong@gmail.com> wrote=
:
> >
> > On Wed, Nov 26, 2025 at 2:55=E2=80=AFAM David Hildenbrand (Red Hat)
> > <david@kernel.org> wrote:
> > > >
> > > >> having a flag that states something like that that
> > > >> "AS_NO_WRITEBACK_WAIT_ON_DATA_SYNC" would probable be what we woul=
d want
> > > >> to add to avoid waiting for writeback with clear semantics why it =
is ok
> > > >> in that specific scenario.
> > > >
> > > > Having a separate AS_NO_WRITEBACK_WAIT_ON_DATA_SYNC mapping flag
> > > > sounds reasonable to me and I agree is more clearer semantically.
> > >
> > > Good. Then it's clear that we are not waiting because writeback is
> > > shaky, but because even if it would be working, because we don't have=
 to
> > > because there are no such guarantees.
> > >
> > > Maybe
> > >
> > > AS_NO_DATA_INTEGRITY
> > >
> > > or similar would be cleaner, I'll have to leave that to you and Miklo=
s
> > > to decide what exactly the semantics are that fuse currently doesn't
> > > provide.
> >
> > After reading Miklos's reply, I must have misunderstood this then - my
> > understanding was that the reason we couldn't guarantee data integrity
> > in fuse was because of the temp pages design where checking the
> > writeback flag on the real folio doesn't reflect writeback state, but
> > that removing the temp pages and using the real folio now does
> > guarantee this. But it seems like it's not as simple as that and
> > there's no data integrity guarantees for other reasons.
> >
> > Changing this to AS_NO_DATA_INTEGRITY sounds good to me, if that
> > sounds good to Miklos as well. Or do you have another preference,
> > Miklos?
>
> Sure, sounds good.
>
> (Sorry about the delay, missed this.)

Is the reason we can't guarantee data integrity because the server
ultimately controls disk persistence whereby it can claim to have
written data even if it didn't? If so, it seems like NFS / the other
network-based filesystems would also have to set that
AS_NO_DATA_INTEGRITY mapping flag too to be consistent? Or is there
some other reason?

Thanks,
Joanne


>
> Thanks,
> Miklos

