Return-Path: <stable+bounces-100066-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B12B9E8483
	for <lists+stable@lfdr.de>; Sun,  8 Dec 2024 11:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 644DD2818AA
	for <lists+stable@lfdr.de>; Sun,  8 Dec 2024 10:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CA51459F6;
	Sun,  8 Dec 2024 10:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XeSrbMub"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18E5130499
	for <stable@vger.kernel.org>; Sun,  8 Dec 2024 10:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733653034; cv=none; b=l7r1IkNMsiS7uz9utdvCtt3O/byTT10bd3o2btEmO/5qxjqbltdnqPQOwe6lUAHKizEzXop05M9BpDWK101X2BKSV3qnLM801UwyGmaYgrYPdoYtRLmYohft8aL98/r/UvuljaH6oi6GEK5te1Gp3ZucAF37mynvI66G2VZz8go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733653034; c=relaxed/simple;
	bh=iSk7qBPcuDjKWe/dJvRrHB51dAqOTbdPSdfEakWI4CM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PMxdoZTbXWuA9JpTSLEeQnntpW6vkNAO41PuxbXldA53rh4IfgDAeZC2P21K4wrh9xORfO9rvvSRGdfTCDVsbszS++R4FheklCHNt1Zc7hW00OqSm/lrNcgxN+pQuyCUgitko8Pr24KCSux9kirh9lZNRfVpOIxqsmGUahqbS2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XeSrbMub; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733653030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iSk7qBPcuDjKWe/dJvRrHB51dAqOTbdPSdfEakWI4CM=;
	b=XeSrbMub/eoZ61p1cjzJ8n3TvLn0I6PWqHpBvEB3TOGAqP0H8AHJxcU7QXPlSa2iZlUn6W
	Q84gH3cUaL918yy2kFTa2rTzR2mFezCbHNHQIYNgDT4ODzyc/7lbU8KkaiX7VuTWrrIQ1v
	Gyv53lo+veR5PzUPb1USks/KIRlsXpc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-JW1XUDD1MIKI-gSGAxYkBg-1; Sun, 08 Dec 2024 05:17:09 -0500
X-MC-Unique: JW1XUDD1MIKI-gSGAxYkBg-1
X-Mimecast-MFC-AGG-ID: JW1XUDD1MIKI-gSGAxYkBg
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-aa6732a1af5so42784966b.3
        for <stable@vger.kernel.org>; Sun, 08 Dec 2024 02:17:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733653028; x=1734257828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iSk7qBPcuDjKWe/dJvRrHB51dAqOTbdPSdfEakWI4CM=;
        b=ktGmFWAyZTwk2BZ/pdW5+qJecRvI4zVcOK3072NLf/Ii3Z6qiJEw56xAnxD07P3Qp1
         VPy+DsMz28KQDFa8eROvvM99oBQubzUS3cfTwpT3DFAac8mHDXVNa+h7nUAOw5He5zKL
         t1QovG3DMXy7jIrQSWDGKqx+OhPGN18XUHiex9nsiShqmzP5kyOQypVi3x8PRBUnBrR1
         G+eCxKnDFqQxk7sKopHh+KiWsreUkPb8+cE6MLIIKbHBvPbwKaY6FPIRgoOqKU9QqCjx
         rD6C3xtIhPnjUg1aBsDpgAG/mcPyvguCBdMHyBsv3fstLg5au12gK3YtnOhn1uXajPIO
         Sscw==
X-Forwarded-Encrypted: i=1; AJvYcCVpO4tGbhfSPFhKkur3ep9IAaCT9BvA4AoXVRTwKD0lSVFw3NX1RcK5J8OjT1Pa3eC4OYmvSro=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlZwZobQ0fB2NIyV+wAqlmAUVaYA2Ggkh00HWrN3oUUJbRBnHP
	VhnS+m+gI6cVtYnd9gW8SPqcZ460yh5TSGtxWtFsy2ZIxy+gHvdDoahpz/10QiCWOeca4/zmIHO
	79AVBbwC5Y4xjX2r5nGWMABEYIxFalwRtiJMsJlu9QNedY+6f/dci5KZO2Wu6yn+LZWOtL20Q8t
	9VqixKQNXJCmgmdYp/3Hxz9tSx6bIF
X-Gm-Gg: ASbGncsZu+hKomBMcQFyim3F7+4f/BhN+SpQe4CpVLhuYYTlHhvVWTe3CgJXGYNu14H
	tYWU69Dfs9y9ZLUXNKDySWRF97SDBZPzCiq6eaGPJA5xoTH8=
X-Received: by 2002:a17:906:18b1:b0:aa4:9ab1:1985 with SMTP id a640c23a62f3a-aa63a2c6626mr776043666b.51.1733653027972;
        Sun, 08 Dec 2024 02:17:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFamKd09koQ2FZaKjQGaKQqbUfNzFN6quC7hLeEwoA1mVdlNypn6b1pc9Ybo1wSkeUjYV+Mp+R+DMrikNj2bp4=
X-Received: by 2002:a17:906:18b1:b0:aa4:9ab1:1985 with SMTP id
 a640c23a62f3a-aa63a2c6626mr776041466b.51.1733653027380; Sun, 08 Dec 2024
 02:17:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118222828.240530-1-max.kellermann@ionos.com>
 <CAOi1vP8Ni3s+NGoBt=uB0MF+kb5B-Ck3cBbOH=hSEho-Gruffw@mail.gmail.com>
 <c32e7d6237e36527535af19df539acbd5bf39928.camel@kernel.org>
 <CAKPOu+-orms2QBeDy34jArutySe_S3ym-t379xkPmsyCWXH=xw@mail.gmail.com>
 <CA+2bHPZUUO8A-PieY0iWcBH-AGd=ET8uz=9zEEo4nnWH5VkyFA@mail.gmail.com>
 <CAKPOu+8k9ze37v8YKqdHJZdPs8gJfYQ9=nNAuPeWr+eWg=yQ5Q@mail.gmail.com>
 <CA+2bHPZW5ngyrAs8LaYzm__HGewf0De51MvffNZW4h+WX7kfwA@mail.gmail.com>
 <CAO8a2SiRwVUDT8e3fN1jfFOw3Z92dtWafZd8M6MHB57D3d_wvg@mail.gmail.com>
 <CAO8a2SiN+cnsK5LGMV+6jZM=VcO5kmxkTH1mR1bLF6Z5cPxH9A@mail.gmail.com>
 <CAKPOu+8u1Piy9KVvo+ioL93i2MskOvSTn5qqMV14V6SGRuMpOw@mail.gmail.com>
 <CAO8a2SizOPGE6z0g3qFV4E_+km_fxNx8k--9wiZ4hUG8_XE_6A@mail.gmail.com>
 <CAKPOu+_-RdM59URnGWp9x+Htzg5xHqUW9djFYi8msvDYwdGxyw@mail.gmail.com>
 <CAO8a2ShGd+jnLbLocJQv9ETD8JHVgvVezXDC60DewPneW48u5A@mail.gmail.com> <CAKPOu+-d=hYUYt-Xd8VpudfvMNHCSmzhSeMrGnk+YQL6WBh95w@mail.gmail.com>
In-Reply-To: <CAKPOu+-d=hYUYt-Xd8VpudfvMNHCSmzhSeMrGnk+YQL6WBh95w@mail.gmail.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Sun, 8 Dec 2024 12:16:56 +0200
Message-ID: <CAO8a2ShQHCRWBGWs4rk69Gvm-NoKHyZPKJmmsazKeY3UZHeEdw@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph/mds_client: give up on paths longer than PATH_MAX
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Patrick Donnelly <pdonnell@redhat.com>, Jeff Layton <jlayton@kernel.org>, 
	Ilya Dryomov <idryomov@gmail.com>, Venky Shankar <vshankar@redhat.com>, xiubli@redhat.com, 
	ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, dario@cure53.de, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Illya, this patch is tested and it has my review by.

On Thu, Dec 5, 2024 at 10:24=E2=80=AFAM Max Kellermann <max.kellermann@iono=
s.com> wrote:
>
> On Wed, Dec 4, 2024 at 1:51=E2=80=AFPM Alex Markuze <amarkuze@redhat.com>=
 wrote:
> > It's already in a testing branch; what branch are you working on?
>
> I found this on branch "wip-shirnk-crash":
> https://github.com/ceph/ceph-client/commit/6cdec9f931e38980eb007d9704c5a2=
4535fb5ec5
> - did you mean this branch?
>
> This is my patch; but you removed the commit message, removed the
> explanation I wrote from the code comment, left the (useless and
> confusing) log message in, and then claimed authorship for my work.
>


