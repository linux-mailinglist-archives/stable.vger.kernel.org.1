Return-Path: <stable+bounces-135261-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3870EA98842
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 13:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 766B718906E6
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 11:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56723276021;
	Wed, 23 Apr 2025 11:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WHLLeDsn"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3A827584D
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 11:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745406665; cv=none; b=AMRYQoaR4XzPz7fmGaDfmbGrb5paWsJgCFFZXAwZm5zxSlLBLlhbok2S9vzENY8b0LXqJXK8f2ammUfEI6hTjyL3DBVnxosTE5OyvbYM0uOiZ3LLP/YVWlpEWdYJoUrhwJzFQ/Tmq5su4joCuLVDJiFpoSvp18aEEUG8Vk5JGuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745406665; c=relaxed/simple;
	bh=7kxs5fONHBDrEEMpfHF6Me5LwhXZkaU4RpiH+9S3EE4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Nn9ZQfalgn1z9L3Lwkt3oNbW+X2Y7fGbvYSgViW4Gm7xvLs3SzU0URDug2LhDsVAQnUlt1Y2Tk/BBeG4UA3vADULyyZLwlIuRHEGngj062G9eE3ZzR24qBcd+9op+jGt4i5oxnugVAWf6joza5ZF274MHGwtwT8JRH87tFxIqWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WHLLeDsn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745406660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q4lg4wZ0wblbf41bBwsUniFt++jBlLXVgcLDNP8JKtI=;
	b=WHLLeDsnqbJ0vReaU/jSlExdWniSuwSLvqrStzNh+bhR0sJWF3ojIm3SGZGvEeIUA2Ithb
	V+/Rx84+eC2VO8+PL/FedG0tqUXhh/4jze54MFeqnj8LEiqHCZBQ74Qf6Nh6UQZ421OKZ0
	rRgiDgwB5vwWZL5iOo32VakDsbKyLvw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-l0E6DSaRNjKHasabmbIslw-1; Wed,
 23 Apr 2025 07:10:54 -0400
X-MC-Unique: l0E6DSaRNjKHasabmbIslw-1
X-Mimecast-MFC-AGG-ID: l0E6DSaRNjKHasabmbIslw_1745406652
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 262A919560A6;
	Wed, 23 Apr 2025 11:10:52 +0000 (UTC)
Received: from [10.22.80.44] (unknown [10.22.80.44])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4A9AA19560B1;
	Wed, 23 Apr 2025 11:10:50 +0000 (UTC)
Date: Wed, 23 Apr 2025 13:10:45 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: John Stultz <jstultz@google.com>
cc: LongPing Wei <weilongping@oppo.com>, dm-devel@lists.linux.dev, 
    guoweichao@oppo.com, snitzer@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] dm-bufio: don't schedule in atomic context
In-Reply-To: <CANDhNCrpSApv55_0LN816nNaGhPWiWZNODr-_1egjPpgGGb1-A@mail.gmail.com>
Message-ID: <116e97a7-ea27-8c01-cbeb-09e10188d77a@redhat.com>
References: <16733109-69f6-e347-e1af-02af6223ca8d@redhat.com> <20250417030737.3683876-1-weilongping@oppo.com> <CANDhNCrpSApv55_0LN816nNaGhPWiWZNODr-_1egjPpgGGb1-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463811712-295574454-1745406651=:1915902"
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811712-295574454-1745406651=:1915902
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 22 Apr 2025, John Stultz wrote:

> On Wed, Apr 16, 2025 at 8:07 PM LongPing Wei <weilongping@oppo.com> wrote:
> > diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
> > index 9c8ed65cd87e..3088f9f9169a 100644
> > --- a/drivers/md/dm-bufio.c
> > +++ b/drivers/md/dm-bufio.c
> > @@ -2424,8 +2426,13 @@ static void __scan(struct dm_bufio_client *c)
> >
> >                         atomic_long_dec(&c->need_shrink);
> >                         freed++;
> > -                       cond_resched();
> > -               }
> > +
> > +                       if (unlikely(freed % SCAN_RESCHED_CYCLE == 0)) {
> > +                               dm_bufio_unlock(c);
> > +                               cond_resched();
> > +                               dm_bufio_lock(c);
> > +                       }
> > +       }
> >         }
> >  }
> 
> I realize this has been queued by the maintainer, but in
> cherry-picking it for the Android kernel, I noticed there's a
> whitespace oddity with the closing bracket indentation. Might deserve
> a followup fix.
> 
> thanks
> -john

OK. I rebased the dm-6.15 branch and fixed this commit.

Mikulas
---1463811712-295574454-1745406651=:1915902--


