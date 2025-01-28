Return-Path: <stable+bounces-110976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 297C8A20D5D
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 16:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C61641882AB3
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 15:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9784F1D5ADD;
	Tue, 28 Jan 2025 15:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b45NRoBB"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AF91D63C3
	for <stable@vger.kernel.org>; Tue, 28 Jan 2025 15:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738079113; cv=none; b=dSWfPR46zfBuGRkubr/yo0KhF9vgzEDKD7AHLMSeobbFG06I+/aydTlFDxbdOuF+QyD3ePW84Lg0lce7ftLXiTBatHzzf0IoUxm6UcwvPwk1PIMDwS52EhqQv84iO81OuPI3v+3DRCGdahuUt7e2ZNbP+U2OIU6E5IpMq8Jxwfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738079113; c=relaxed/simple;
	bh=noXyBqI87BE5bKgzA/bkBi5QPBLeFamw8wGuZmVJ96I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQEVUyPQ1gh8KhmN0QsSyEbMvfKu021fl0VZ65sGeI0lT3vcjurnuR7rP++fw9m3cVpAC13KLsICo+x0DmsWVsPGzOYoexGlSiy4lEomi1iWqN4iSECBOrLew9iS0Tt1c7tfn+Q5l2bGGLDcm2ceOv45bZ2mUBumQNNoLtjyEew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b45NRoBB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738079110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J1t6D/PIMIyABHQaylKfMHsHw7I0DV8eA6V4Mnp8hC4=;
	b=b45NRoBBnyudRWbaaBD4kD90N/2sJgiItWdwghv601R+0MzPrfO/b3trpDFKKfALvC7leg
	2kB4CkmY159FYEeQqxIqzJyNLdkmuUZ9AFKJisGa9TYsNw5ft1YLsWDhl6AOlyuB6BlKx0
	VT3L1iKbHPHZX374mtvbAu/jUMj2tFI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-_UDh5xabOfuNR0SA5QAVhQ-1; Tue,
 28 Jan 2025 10:45:05 -0500
X-MC-Unique: _UDh5xabOfuNR0SA5QAVhQ-1
X-Mimecast-MFC-AGG-ID: _UDh5xabOfuNR0SA5QAVhQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F7CB19560B3;
	Tue, 28 Jan 2025 15:45:02 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.70])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 88BFC30001BE;
	Tue, 28 Jan 2025 15:44:52 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 28 Jan 2025 16:44:35 +0100 (CET)
Date: Tue, 28 Jan 2025 16:44:25 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Eyal Birger <eyal.birger@gmail.com>
Cc: kees@kernel.org, luto@amacapital.net, wad@chromium.org,
	mhiramat@kernel.org, andrii@kernel.org, jolsa@kernel.org,
	alexei.starovoitov@gmail.com, olsajiri@gmail.com, cyphar@cyphar.com,
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
	peterz@infradead.org, tglx@linutronix.de, bp@alien8.de,
	daniel@iogearbox.net, ast@kernel.org, andrii.nakryiko@gmail.com,
	rostedt@goodmis.org, rafi@rbk.io, shmulik.ladkani@gmail.com,
	bpf@vger.kernel.org, linux-api@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] seccomp: passthrough uretprobe systemcall without
 filtering
Message-ID: <20250128154424.GB24845@redhat.com>
References: <20250128145806.1849977-1-eyal.birger@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128145806.1849977-1-eyal.birger@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

can't review, I know nothing about seccomp_cache, but

On 01/28, Eyal Birger wrote:
>
> +static bool seccomp_is_const_allow(struct sock_fprog_kern *fprog,
> +				   struct seccomp_data *sd)
> +{
> +#ifdef __NR_uretprobe
> +	if (sd->nr == __NR_uretprobe
> +#ifdef SECCOMP_ARCH_COMPAT
> +	    && sd->arch != SECCOMP_ARCH_COMPAT
> +#endif

it seems you can check

            && sd->arch == SECCOMP_ARCH_NATIVE

and avoid #ifdef SECCOMP_ARCH_COMPAT

Oleg.


