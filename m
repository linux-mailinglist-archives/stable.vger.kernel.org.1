Return-Path: <stable+bounces-124070-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA10A5CD65
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 19:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 600153B23EB
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 18:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEFC2638B5;
	Tue, 11 Mar 2025 18:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a7M7tmFC"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F62E2638AA
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 18:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741716704; cv=none; b=JUFytO6aUCkdeaA0EDZAHGXC9yGNXyBKsk14EqAHRh9pt5p7hCl1J0R/98DBq9pCWhIRuGVFrA2cQzVPbIoKTu2/2dTZ1h7EcVCAU+6sKyF2jLMG9NmDocOQ2QeWOT8jUAA4PA/yxkcujfhUvMIJBT/1XLECFtdwi0mrCitGga0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741716704; c=relaxed/simple;
	bh=bE6PkRpllkCxKlej02vHSlOzbCcwwgn/UGaMPH9i/L8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLG3VGGKQHCLJYaLQkXkD+q2OsAq0Nbp5DO49Tw0hUj5xs5O2ZT6gKQ4J9qHwtMUAXRxoMcL7y2T0Wuf3te+2W+bIXqqJBG76HCwB7xES2BpA1yu2zpqg3tCj8XbOIJUGD09PbSN+7lnVICzqsfRWLmgLIeAY3V00uybYBf3ldk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a7M7tmFC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741716701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TzrnYIEosGlaSeyPR0KJldsPFTrK0e57CDLAtUE1YhI=;
	b=a7M7tmFCDuq6IuwY+XAQ7JwrywfNxYrp++Esfmzv7MX1Zgygnt5L4AJcWxnRKU1PMUlDvW
	PHmD6ovrvR9wqF6k+hUrwAkAYFJSy7aHTdVF4Octgybwr1sPz0uHK1atTciSn0TRtIA7OU
	o11KeKqe5u05A+4Uzhk3lxsTI+3+KcU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-8FHXh_3OPY6-5jtrBpPWMw-1; Tue,
 11 Mar 2025 14:11:37 -0400
X-MC-Unique: 8FHXh_3OPY6-5jtrBpPWMw-1
X-Mimecast-MFC-AGG-ID: 8FHXh_3OPY6-5jtrBpPWMw_1741716696
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 56C18180025A;
	Tue, 11 Mar 2025 18:11:35 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.22.90.58])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id AED7118001F6;
	Tue, 11 Mar 2025 18:11:29 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 11 Mar 2025 19:11:04 +0100 (CET)
Date: Tue, 11 Mar 2025 19:10:57 +0100
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
Message-ID: <20250311181056.GF3493@redhat.com>
References: <CAMzpN2iUi_q_CfDa53H8MEV_zkb8NRtXtQPvOwDrEks58=3uAg@mail.gmail.com>
 <CAMj1kXF8PZq4660mzNYcT=QmWywB1gOOfZGzZhi1sQxQacUX=g@mail.gmail.com>
 <20250310214402.GBZ89dIo_NLF4zOSKh@fat_crate.local>
 <CAMj1kXEK0Kgx-C8sOvWJ9rkmC0ioWDEb+tpM9BTeWVwOWyGNog@mail.gmail.com>
 <20250311102326.GAZ9APHqe5aSQ1m5ND@fat_crate.local>
 <CAMj1kXHTLz4onmR5iyowptRE38RCK4jNT3BoURBkq2FoDOMTxQ@mail.gmail.com>
 <20250311112112.GEZ9AcqM2ceIQVUA0N@fat_crate.local>
 <20250311131356.GGZ9A3FNOxp32eGAgV@fat_crate.local>
 <20250311143724.GE3493@redhat.com>
 <20250311174626.GHZ9B28rDrfWKJthsN@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311174626.GHZ9B28rDrfWKJthsN@fat_crate.local>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 03/11, Borislav Petkov wrote:
>
> On Tue, Mar 11, 2025 at 03:37:25PM +0100, Oleg Nesterov wrote:
> > sorry for the off-topic noise, but what about the
> >
> > 	[PATCH] x86/stackprotector: fix build failure with CONFIG_STACKPROTECTOR=n
> > 	https://lore.kernel.org/all/20241206123207.GA2091@redhat.com/
> >
> > fix for the older binutils? It was acked by Ard.
> >
> > Should I resend it?
>
> Can you pls explain how you trigger this?
>
> I just did a
>
> # CONFIG_STACKPROTECTOR is not set
>
> build here and it was fine.
>
> So there's something else I'm missing.

See the "older binutils?" above ;)

my toolchain is quite old,

	$ ld -v
	GNU ld version 2.25-17.fc23

but according to Documentation/process/changes.rst

	binutils               2.25             ld -v

it should be still supported.

Oleg.


