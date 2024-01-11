Return-Path: <stable+bounces-10483-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F38182AB26
	for <lists+stable@lfdr.de>; Thu, 11 Jan 2024 10:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D4741C23CDF
	for <lists+stable@lfdr.de>; Thu, 11 Jan 2024 09:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FED8111A5;
	Thu, 11 Jan 2024 09:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R0TJmT7I"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608C81119D
	for <stable@vger.kernel.org>; Thu, 11 Jan 2024 09:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704966326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=18eURhzPqjh6OO9ktQkfsRySWY9tUDGvnWhEFURW+fY=;
	b=R0TJmT7IYVl9F/kmZVMl78PLkMz6P8sd7ha4J0lQ3sZTJGbFrkCf7GffeObmk4M5M10UeD
	8i7zIFGlwlll1if3cCbr7T+amgrRK/4tTNg9wC9zn+Ay/MjfPRmb/V3T319QetRPO/4THH
	mN+roznuud+tCvF59mNdEZA8zeBkGeQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-Jlw286c0PP-D2DFUFaQ_Xg-1; Thu, 11 Jan 2024 04:45:25 -0500
X-MC-Unique: Jlw286c0PP-D2DFUFaQ_Xg-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-781314b6298so99777285a.1
        for <stable@vger.kernel.org>; Thu, 11 Jan 2024 01:45:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704966324; x=1705571124;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=18eURhzPqjh6OO9ktQkfsRySWY9tUDGvnWhEFURW+fY=;
        b=IulBQeHI1eWnG0IqTeifqFtTgrAVNmvo3DOYOqs709Nb5I0/X8RxymHVz1nuoUoBVM
         dNGp3qgKxuGDhA0+PXqVsS3IzBcKxMV6P8sR/DvUybTsLuvusrp8kfCZKEjkeZd3jFtI
         Yy4NSitmRGsa88Z/1ytE/vWicYWzcC3gABldzoPYJ2lhoAP7GQ+adOwUjUVC/rfSZxHV
         IGIlFdtEqQj9+yv0IvVq3zNm1Ig4hajzhulev9j5dmDfOmbk7TgZEpqb2EtAD+ha1vvx
         ww1aek23+EcJYW21Pl0FAdhVer4N3voYs+rUawbQJf5lSpoY38GKB53EUPyPo7iU4OYc
         GVBQ==
X-Gm-Message-State: AOJu0YzkaKuZqelXhKAskqkWLgQ7NSOWRJ30PmMoo7uJB9jNDBoN7gCK
	f9KPdJxnOl6izgw3yDese2qHf80kssL9cc6UgzfUffxpC4rK9jc8HLwLlpWbaTajQmeeRpMCuKd
	KEjsM3T4GOCDB7zEwCnnBZ+izALcGB7jC
X-Received: by 2002:a05:620a:4726:b0:781:d519:12b8 with SMTP id bs38-20020a05620a472600b00781d51912b8mr2198469qkb.2.1704966324425;
        Thu, 11 Jan 2024 01:45:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsCflr1cnBg8FbDO4MmTrvarkaVOthrTYfY/uZOhpa7zT35UnHSVpI8slHFl4ak53EWIvl9w==
X-Received: by 2002:a05:6122:4104:b0:4b6:e3fa:7599 with SMTP id ce4-20020a056122410400b004b6e3fa7599mr1396985vkb.0.1704964487656;
        Thu, 11 Jan 2024 01:14:47 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ch7-20020a05622a40c700b00429970654b6sm281418qtb.33.2024.01.11.01.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 01:14:47 -0800 (PST)
Message-ID: <42cf5ca70c940b3e68c8ad0e4bab6f14f87d4486.camel@redhat.com>
Subject: Re: [PATCH v5 RESEND 0/5] Regather scattered PCI-Code
From: Philipp Stanner <pstanner@redhat.com>
To: Johannes Berg <johannes@sipsolutions.net>, Bjorn Helgaas
 <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, Randy Dunlap
 <rdunlap@infradead.org>, NeilBrown <neilb@suse.de>, John Sanpe
 <sanpeqf@gmail.com>,  Kent Overstreet <kent.overstreet@gmail.com>, Niklas
 Schnelle <schnelle@linux.ibm.com>, Dave Jiang <dave.jiang@intel.com>,
 Uladzislau Koshchanka <koshchanka@gmail.com>,  "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, David Gow <davidgow@google.com>, Kees Cook
 <keescook@chromium.org>, Rae Moar <rmoar@google.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, "wuqiang.matt" <wuqiang.matt@bytedance.com>, Yury
 Norov <yury.norov@gmail.com>, Jason Baron <jbaron@akamai.com>, Thomas
 Gleixner <tglx@linutronix.de>, Marco Elver <elver@google.com>, Andrew
 Morton <akpm@linux-foundation.org>, Ben Dooks <ben.dooks@codethink.co.uk>, 
 dakr@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-arch@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 11 Jan 2024 10:14:43 +0100
In-Reply-To: <43478eb70cf5f1120316739803c7622ab5f9e16a.camel@sipsolutions.net>
References: <20240111085540.7740-1-pstanner@redhat.com>
	 <43478eb70cf5f1120316739803c7622ab5f9e16a.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-01-11 at 10:03 +0100, Johannes Berg wrote:
> On Thu, 2024-01-11 at 09:55 +0100, Philipp Stanner wrote:
> > Second Resend. Would be cool if someone could tell me what I'll
> > have to
> > do so we can get this merged.
>=20
> I don't even know who'd merge it, but um doesn't seem appropriate...

UM isn't a recipent, I'd guess it's some mail filter which might make
it appear that way :)
The lists I sent this to are
linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
linux-arch@vger.kernel.org, stable@vger.kernel.org

Anyways, PCI is for sure who should merge this, since it's 100% about
PCI.

> >=20
> > @Stable-Kernel:
> > You receive this patch series because its first patch fixes leaks
> > in
> > PCI.
>=20
> Too early for that, stable just ignores stuff before it hits
> mainline.

I know, they're in CC because of the "Fixes: "

P.

>=20
> johannes
>=20


