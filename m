Return-Path: <stable+bounces-109640-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71157A18237
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 17:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1559168DDE
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 16:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CC61F4E4A;
	Tue, 21 Jan 2025 16:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hzf3XFA6"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F0B1F471C
	for <stable@vger.kernel.org>; Tue, 21 Jan 2025 16:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737477928; cv=none; b=nhSUew+tyhhNGwJU9OhlEQzFjm3Qo/9yTJYMjqevf2edZppykWkszjyrmOV+xiCqyRcuwKlakftP7RiYFqi4czE16wkc67uQBdpMx499Dxu0M1Tn8HiOMOAKi0rFKhUA3uMeJfhnKGm3t76HAbD4+yKoCBbC6O3x6iJvu5z/vEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737477928; c=relaxed/simple;
	bh=XO/Ymj0ibVxkJr0ihO0VzEhAo9m9O2dsS+oq11HBXQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FrEMxaRG7MD0Xsya4+/fQDsGVVSR1xQNMPAqAFCp68HOYSfT05WS46dvRMLSMUkdKf5t8RBdtfau3lYA1itkxdlRuHIMMgRA3HDArv9eCg9viiKutNrm1RUzFvflL4GhMrSKKHcgWxDmvHtubSc1uI2ga501/CBYzfR/xkteCcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hzf3XFA6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737477925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TLVsHBbZSrA/NKOjlCOjlNdrdUsp4BXx8cgZinvUkW0=;
	b=Hzf3XFA6S8soKdjajYdvKkQnOnC2f0RWa1L9Of+D1GOsYLs2DfLRgceiaMAGCQB7XYg8vu
	dGUxApvtPHxLIFwLVHjqlgqMAQ0aGq7M9mJmcupaYI3mKGF6pH/Z81H9HjL1CD1YzCCjCl
	PnZ2pyJpkcSNkGZmsp2o+FO3QHblekI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-262-sO44-CrMMTaemhFpBg_rog-1; Tue,
 21 Jan 2025 11:45:17 -0500
X-MC-Unique: sO44-CrMMTaemhFpBg_rog-1
X-Mimecast-MFC-AGG-ID: sO44-CrMMTaemhFpBg_rog
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 403171956066;
	Tue, 21 Jan 2025 16:45:12 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.31])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 11A5019560A7;
	Tue, 21 Jan 2025 16:45:02 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 21 Jan 2025 17:44:46 +0100 (CET)
Date: Tue, 21 Jan 2025 17:44:35 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Eyal Birger <eyal.birger@gmail.com>,
	Kees Cook <kees@kernel.org>, luto@amacapital.net, wad@chromium.org,
	ldv@strace.io, mhiramat@kernel.org, andrii@kernel.org,
	alexei.starovoitov@gmail.com, cyphar@cyphar.com,
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
	peterz@infradead.org, tglx@linutronix.de, bp@alien8.de,
	daniel@iogearbox.net, ast@kernel.org, andrii.nakryiko@gmail.com,
	rafi@rbk.io, shmulik.ladkani@gmail.com, bpf@vger.kernel.org,
	linux-api@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] seccomp: passthrough uretprobe systemcall without
 filtering
Message-ID: <20250121164435.GA17215@redhat.com>
References: <20250117005539.325887-1-eyal.birger@gmail.com>
 <202501181212.4C515DA02@keescook>
 <CAHsH6GuifA9nUzNR-eW5ZaXyhzebJOCjBSpfZCksoiyCuG=yYw@mail.gmail.com>
 <8B2624AC-E739-4BBE-8725-010C2344F61C@kernel.org>
 <CAHsH6GtpXMswVKytv7_JMGca=3wxKRUK4rZmBBxJPRh1WYdObg@mail.gmail.com>
 <Z4-xeFH0Mgo3llga@krava>
 <20250121111631.6e830edd@gandalf.local.home>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121111631.6e830edd@gandalf.local.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 01/21, Steven Rostedt wrote:
>
> I think this may have been mentioned, but is there a way that the kernel
> could know that this system call is being monitored by seccomp, and if so,
> just stick with the interrupt version? If not, enable the system call?

Consider

	int func_to_uretprobe()
	{
		seccomp(SECCOMP_SET_MODE_STRICT/whatever);
		return 123;
	}

by the time it is called, the kernel can't know that this function will
call seccomp/install-the-filters/etc, so prepare_uretprobe() can't know
if it is safe to use uretprobe or not.

Oleg.


