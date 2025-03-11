Return-Path: <stable+bounces-124093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C09D8A5CF48
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 20:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DD4C17BEDF
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 19:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DC52641C0;
	Tue, 11 Mar 2025 19:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YckTgluc"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC22D2AF06
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 19:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741721094; cv=none; b=HXHzSVxCGD2nOkxmBcAwoF9DRydhSq+7S7uUqe0w1p5HcYi07uw1aK2qY+g8iSjqgdynLNhB7k99BDtqiJotMfcpvFXgWgx6YWgHP2SLALjwI9Psr/RCjEon60iHSAqjdUPeGJkc3q5t1h/a6II/T5GCqSsEln71ALZ9po8B5bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741721094; c=relaxed/simple;
	bh=l48ePkX07jt/Dy2NQli1RjdHXntbwEXbAp0TLcnmM4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpRZW93rHW4hlMIzo+RxWd51heGSbE59FeyBi4xNgLTLfV4IMLx3awD3hsKdt0Bmc2lSB3j/+zYG9oKxuADVb/KPDcqroIAXpAj87/sCLjjcAMrlPd2ubKSZa+eC5cuORhaf0wuaYDkofW2rzDwHBHjN9KbHcOsrc+vTWqGw0tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YckTgluc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741721090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KcYxt6lKlQkGEaI+wYIlW5PAOr/JWvJEjCeftUnJOe4=;
	b=YckTgluczb8VV8HUFSTrvz0Ax5HwydSX/cozKeNK1J8Yx8oC2gCJyP7wzC4XX6UskzSjlj
	HNFDU2QMzdOYGIJ3sSi4jRaLVFk5M2cVOyPX+Q7wtVR/2Y8c57Fx251DV7eb6rFfu9azXT
	RB+MFBm4ggLyIohnX1vAezGz4Rw5Oek=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-7F1u8v5PNvK6JRj9bi_e3g-1; Tue,
 11 Mar 2025 15:24:46 -0400
X-MC-Unique: 7F1u8v5PNvK6JRj9bi_e3g-1
X-Mimecast-MFC-AGG-ID: 7F1u8v5PNvK6JRj9bi_e3g_1741721084
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9807919560A3;
	Tue, 11 Mar 2025 19:24:43 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.22.90.58])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 17A6618001EF;
	Tue, 11 Mar 2025 19:24:38 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 11 Mar 2025 20:24:12 +0100 (CET)
Date: Tue, 11 Mar 2025 20:24:06 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb@kernel.org>, Brian Gerst <brgerst@gmail.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>, stable@vger.kernel.org,
	Fangrui Song <i@maskray.me>, Nathan Chancellor <nathan@kernel.org>,
	Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH] x86/stackprotector: fix build failure with
 CONFIG_STACKPROTECTOR=n
Message-ID: <20250311192405.GG3493@redhat.com>
References: <20250310214402.GBZ89dIo_NLF4zOSKh@fat_crate.local>
 <CAMj1kXEK0Kgx-C8sOvWJ9rkmC0ioWDEb+tpM9BTeWVwOWyGNog@mail.gmail.com>
 <20250311102326.GAZ9APHqe5aSQ1m5ND@fat_crate.local>
 <CAMj1kXHTLz4onmR5iyowptRE38RCK4jNT3BoURBkq2FoDOMTxQ@mail.gmail.com>
 <20250311112112.GEZ9AcqM2ceIQVUA0N@fat_crate.local>
 <20250311131356.GGZ9A3FNOxp32eGAgV@fat_crate.local>
 <20250311143724.GE3493@redhat.com>
 <20250311174626.GHZ9B28rDrfWKJthsN@fat_crate.local>
 <20250311181056.GF3493@redhat.com>
 <20250311190159.GIZ9CIp81bEg1Ny5gn@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311190159.GIZ9CIp81bEg1Ny5gn@fat_crate.local>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 03/11, Borislav Petkov wrote:
>
> On Tue, Mar 11, 2025 at 07:10:57PM +0100, Oleg Nesterov wrote:
> > See the "older binutils?" above ;)
> >
> > my toolchain is quite old,
> >
> > 	$ ld -v
> > 	GNU ld version 2.25-17.fc23
> >
> > but according to Documentation/process/changes.rst
> >
> > 	binutils               2.25             ld -v
> >
> > it should be still supported.
>
> So your issue happens because of older binutils? Any other ingredient?

Yes, I think so.

> I'd like for the commit message to contain *exactly* what we're fixing here so
> that anyone who reads this, can know whether this fix is needed on her/his
> kernel or not...

OK. I'll update the subject/changelog to explain that this is only
needed for the older binutils and send V2.

Oleg.


