Return-Path: <stable+bounces-196933-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D02C86CED
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 20:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D76E7355448
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 19:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966F3336EEA;
	Tue, 25 Nov 2025 19:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h5m7Wxyq"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35063358AD
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 19:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764098714; cv=none; b=nBdFojpcNB9UWA6W60GogS6KKH42EfeK1gmMOTeqREwDnTr0qmu9r0fvCKQs7t3WeqaRam3cqEc6R2XpGA4xQvAh4o8yHTiKPG4xU9tbpwMma7gCulw0QqAXKnVMpuN1vZ043DHYPbcnRdnxa/vg/u1j5j2a2Mzcz1oXQi1CPGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764098714; c=relaxed/simple;
	bh=r/g491KN6y1Hd9kVFXED0d7Cw9FIB3gaiR9STXWll8s=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+22LCEkcq/H4wCRWoWcpxUDntR3xoohqQQdSpLLIWVJfQT5nVZ9/MrLJahxQDyMb2WRotsQL6mn3xgYkOfheYstOV0RX+f5ab/aXJLsTLjEM2f7y1lYW+d/rGMW0VAkQLxbvu7XwlnL9QzQzqrHeS3qHsub05cAKrBqY5E+fl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h5m7Wxyq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764098702;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=j1eF6S5HS7qF6uLQimURn93SxQbOlIzI7l7P8RWkCyo=;
	b=h5m7WxyqJLxDe2ni7kQoDsiUsGISE7FJhwcaS9k8/txhQNw/aQJ5G1eXto1M1IVW7dbvgk
	pqDaTvCcodg/aPH1OVv6Ij1UNmUZ7Jz2T9SLK/Dcftn1CiakTvt8pR8JaHMCkGW6ImEsi+
	BmObcZz75Rwe9flHbd70wsTXPMHgW44=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-219-rofhpJqwMEq1DJxDWvGTvg-1; Tue,
 25 Nov 2025 14:24:58 -0500
X-MC-Unique: rofhpJqwMEq1DJxDWvGTvg-1
X-Mimecast-MFC-AGG-ID: rofhpJqwMEq1DJxDWvGTvg_1764098697
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D8CC71956058;
	Tue, 25 Nov 2025 19:24:56 +0000 (UTC)
Received: from localhost (unknown [10.22.65.17])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5E29B195608E;
	Tue, 25 Nov 2025 19:24:56 +0000 (UTC)
Date: Tue, 25 Nov 2025 14:24:55 -0500
From: Derek Barbosa <debarbos@redhat.com>
To: John Ogness <john.ogness@linutronix.de>, 
	Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Sherry Sun <sherry.sun@nxp.com>, Jacky Bai <ping.bai@nxp.com>, 
	Jon Hunter <jonathanh@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH printk v2 2/2] printk: Avoid scheduling irq_work on
 suspend
Message-ID: <bcooiesgor2qs6l44xotc6h4f4b5ktoodvuuapgsmpmlxb7sav@5xn5qh5csem2>
Reply-To: debarbos@redhat.com
References: <20251113160351.113031-1-john.ogness@linutronix.de>
 <20251113160351.113031-3-john.ogness@linutronix.de>
 <jvn24vsnd2utypz33k33n3ol3ihh44tcyhcbtjhfxnepuvb7hn@qhcikbtwioyk>
 <874iqxlv4e.fsf@jogness.linutronix.de>
 <jm64hv26zmnlyl6lu2zoodkaz5mxcykwo5kdbvv34kyyvc6ov7@vdtslu4slrux>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jm64hv26zmnlyl6lu2zoodkaz5mxcykwo5kdbvv34kyyvc6ov7@vdtslu4slrux>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Nov 13, 2025 at 02:15:09PM -0500, Derek Barbosa wrote:
> Hi John,
> 
> On Thu, Nov 13, 2025 at 06:12:57PM +0106, John Ogness wrote:
> > 
> > I assume the problem you are seeing is with the PREEMPT_RT patches
> > applied (i.e. with the 8250-NBCON included). If that is the case, note
> > that recent versions of the 8250 driver introduce its own irq_work that
> > is also problematic. I am currently reworking the 8250-NBCON series so
> > that it does not introduce irq_work.
> > 


Hi John,

Apologies for the late reply here. Just now got some results in.

Testing this patch series atop of Linus' tree resolves the suspend issue seen on
these large CPU workstation systems.

I see this has already landed in the maintainers tree at printk/linux.git.


Cheers,

-- 
Derek <debarbos@redhat.com>


