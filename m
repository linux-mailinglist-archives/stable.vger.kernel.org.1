Return-Path: <stable+bounces-99083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFC59E7007
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B6A116CF28
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 14:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C68206F3E;
	Fri,  6 Dec 2024 14:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ax8pyEd1"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7B821A0B
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 14:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733495325; cv=none; b=pkbPxYwThssmQ5d/S6pozXK3aum9VSshrw01jyOGyOnLYq14IwiNriMovW2143TWqMaEOJWSAn027LxZU7dvLtFoSORYJsytMmA1THexLcUwd9deoq5FOYi++ONSIk3Miy8RzTXR2/bHCD+7w+abBk480btWtLOyDaq90eROcI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733495325; c=relaxed/simple;
	bh=XhX2ZQdCCZuz9Ph7uA5JfB1Xp1G8lJhcSAqHnXUhIBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rAKorumDqMpev4GB2lDVi3qD/vjzg0kHl/rwRLqBoEbZPrMszEMS6U+gr7lG61LGmyXUlp2qiLwVtssI2/gW0KdxYubjiu97tTXKfE8NTHr8pRux2HnpMeyLWE9VMgVTe8riEC/rp5Oq5F5xarseMO78I+yjhMgjGJhTsMq8PDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ax8pyEd1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733495322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s4vMfwGH4rmj4T5SDjqpaQ0vlQVTTVo3RrQSsivYqTs=;
	b=ax8pyEd1ts6UBEqz/QZxix8MWgauXFmtvNFDMh0JXsxQEQW//KvPqW9xvpFPBS6n0vnTMg
	JzI0nO0UXcKRcAj4voTub1pmp43i9TYo0TEzW85Qapb1hMGSMgbd10Im0HhMtkKJFJj0Vf
	RFQcIqKEv/ApaeEtVTRB/SC1VMGoBvA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-dNlhEnVaM9WRD4qADXkiAg-1; Fri,
 06 Dec 2024 09:28:39 -0500
X-MC-Unique: dNlhEnVaM9WRD4qADXkiAg-1
X-Mimecast-MFC-AGG-ID: dNlhEnVaM9WRD4qADXkiAg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF6FB1956071;
	Fri,  6 Dec 2024 14:28:36 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.103])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 4651D300019E;
	Fri,  6 Dec 2024 14:28:31 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  6 Dec 2024 15:28:14 +0100 (CET)
Date: Fri, 6 Dec 2024 15:28:08 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>, stable@vger.kernel.org,
	Fangrui Song <i@maskray.me>, Nathan Chancellor <nathan@kernel.org>,
	Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v5 01/16] x86/stackprotector: Work around strict Clang
 TLS symbol requirements
Message-ID: <20241206142807.GC31748@redhat.com>
References: <20241105155801.1779119-1-brgerst@gmail.com>
 <20241105155801.1779119-2-brgerst@gmail.com>
 <20241206115154.GA32491@redhat.com>
 <CAMzpN2g8eenLASqXA36LwP=Zr+8Z1cO7Cpz0ijiUdOr_+7G-3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMzpN2g8eenLASqXA36LwP=Zr+8Z1cO7Cpz0ijiUdOr_+7G-3A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 12/06, Brian Gerst wrote:
>
> On Fri, Dec 6, 2024 at 6:52 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > On 11/05, Brian Gerst wrote:
> > >
> > > --- a/arch/x86/kernel/vmlinux.lds.S
> > > +++ b/arch/x86/kernel/vmlinux.lds.S
> > > @@ -468,6 +468,9 @@ SECTIONS
> > >  . = ASSERT((_end - LOAD_OFFSET <= KERNEL_IMAGE_SIZE),
> > >          "kernel image bigger than KERNEL_IMAGE_SIZE");
> > >
> > > +/* needed for Clang - see arch/x86/entry/entry.S */
> > > +PROVIDE(__ref_stack_chk_guard = __stack_chk_guard);
> >
> > Don't we need the simple fix below?
> >
> > without this patch I can't build the kernel with CONFIG_STACKPROTECTOR=n.
...

> Which compiler are you using?  It builds fine with GCC 14 and clang 18.

gcc version 5.3.1 20160406 (Red Hat 5.3.1-6) (GCC)
GNU ld version 2.25-17.fc23

See also my reply to Ard

Oleg.


