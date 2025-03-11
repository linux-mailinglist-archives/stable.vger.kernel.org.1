Return-Path: <stable+bounces-123228-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF036A5C405
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 15:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E999B177A73
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 14:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B5325C6FD;
	Tue, 11 Mar 2025 14:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CSnnYA8Y"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAFF256C6F
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 14:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741703916; cv=none; b=r4h+1GoRkISU7815+4qguMxTMBpoLyOxo4GxkUEBNce5Zjm9iL3ujBT/kZkqG3qr7zs5jr6mwg0AkOldmIyiM9rfyVwg9Ltbd7dI6T7l6bZe7w27/wbXyoP8KFAv0n6H/z63ZqNnXiglOLBxQVY8GpzrovwM33kWBDQhY59yuYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741703916; c=relaxed/simple;
	bh=m/eEMxP8Xj8yG2a7Hu4kR+mrcgF0OixHM7fnWN4XHvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3Ma1pXOo2rDELHFQfeb9rGNJa17WnqsPfaTdY6y46MdQaeTcgujVjDptN+Gxtjvw2kKLNr6e/3S0+VdVS8rhT3PWuzJHmaXnEqwdhWcLujD7a9aVlfceXZ0km1qaV34QyKyQa5vt3+itLWM8foz+gVqf1IOCcrvCYH9ZGVHnZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CSnnYA8Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741703913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cpTpvcWE2P9qSD301paokWQsARnj6IAdwHTa1z+B9WQ=;
	b=CSnnYA8YlNgYnWYCKm1spYXThH6ylv00cmwiySpOsZ/nWdibJLvQuwlFl+gQepKL9+RvYx
	NG27nQLZOP72ro2uCgY1CpyfdUw5SCOB2oM7GQ5UIiUgcwDsIJnsJdgseIVZF9OR6pVvHC
	s8VHBLMCRsH7ko8Zo2McAR8AbJ0i6bs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-423-H1IGM8NeOoSottojaFFw6w-1; Tue,
 11 Mar 2025 10:38:28 -0400
X-MC-Unique: H1IGM8NeOoSottojaFFw6w-1
X-Mimecast-MFC-AGG-ID: H1IGM8NeOoSottojaFFw6w_1741703897
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 27853180025B;
	Tue, 11 Mar 2025 14:38:03 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.22.90.58])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6848C18009AE;
	Tue, 11 Mar 2025 14:37:57 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 11 Mar 2025 15:37:31 +0100 (CET)
Date: Tue, 11 Mar 2025 15:37:25 +0100
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
Message-ID: <20250311143724.GE3493@redhat.com>
References: <20241206142152.GB31748@redhat.com>
 <CAMj1kXGo5yv56VvNMvYBohxgyoyDtZhr4d4kjRdGTDQchHW0Gw@mail.gmail.com>
 <CAMzpN2iUi_q_CfDa53H8MEV_zkb8NRtXtQPvOwDrEks58=3uAg@mail.gmail.com>
 <CAMj1kXF8PZq4660mzNYcT=QmWywB1gOOfZGzZhi1sQxQacUX=g@mail.gmail.com>
 <20250310214402.GBZ89dIo_NLF4zOSKh@fat_crate.local>
 <CAMj1kXEK0Kgx-C8sOvWJ9rkmC0ioWDEb+tpM9BTeWVwOWyGNog@mail.gmail.com>
 <20250311102326.GAZ9APHqe5aSQ1m5ND@fat_crate.local>
 <CAMj1kXHTLz4onmR5iyowptRE38RCK4jNT3BoURBkq2FoDOMTxQ@mail.gmail.com>
 <20250311112112.GEZ9AcqM2ceIQVUA0N@fat_crate.local>
 <20250311131356.GGZ9A3FNOxp32eGAgV@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311131356.GGZ9A3FNOxp32eGAgV@fat_crate.local>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 03/11, Borislav Petkov wrote:
>
> On Tue, Mar 11, 2025 at 12:21:12PM +0100, Borislav Petkov wrote:
> > Yap, that fixes the build:
>
> Lemme run randbuilds with that one, see what else breaks with it.

sorry for the off-topic noise, but what about the

	[PATCH] x86/stackprotector: fix build failure with CONFIG_STACKPROTECTOR=n
	https://lore.kernel.org/all/20241206123207.GA2091@redhat.com/

fix for the older binutils? It was acked by Ard.

Should I resend it?

Oleg.


