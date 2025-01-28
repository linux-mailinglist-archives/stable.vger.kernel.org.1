Return-Path: <stable+bounces-110978-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4D4A20DB9
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 16:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2927D1655E8
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 15:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB2C1D7992;
	Tue, 28 Jan 2025 15:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JExYNesF"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952E51D63C3
	for <stable@vger.kernel.org>; Tue, 28 Jan 2025 15:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738079699; cv=none; b=jZEl285haueJXLEg6/EqwmhYyULbIRPgga5gupzefwacCGChubYfLlNSMzOvJ+rU9claKPUMIBNWKM/moIqovvnL6zUOoI6tqQpd8EtEYoseVihwO31QthsZEiEc09jKFmHA+kt+mGoaFxHkkCeFq0tSqtlGU/M5uoErwSkovQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738079699; c=relaxed/simple;
	bh=ggpM2k9PDQk6/H8zY3iHjqOT8TBaewkRFFLQCjQKBAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7UpRif19hZo+EFEvM+Pv2J6i7iOgf0Z5prOBGKJWkgQ8HrTmWLcwYvXt6iC0ZljuOeWnvzQJXmcUI1OYx4FxYI77NncZmYGlanN3fjWfw20sVaQqY5XDJxhghFNkghkdtD+XPNElnmqrOspp/ERbWaXlFbCAjCFyb4oWl5sx1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JExYNesF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738079695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C95ku0MuhkG03MXVzeMTxA5H+ymY03VNMJ8Dz5j0JFA=;
	b=JExYNesFJOQQcBmJXV5+h47+d7RJXra76LVCmBsmV66U7ptnZaLdc1xMFSr8Wlv04t3wxS
	xVj+fQYcPEkRVNJsmlT7sW1LAlVGstS/xT4+2pI8t5gZMsBLIyvpJGSbr1g57UQj2e1hbf
	79bCMlbq4hBjVhrsScfHVVUjulL3kH0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-161-vL9C7_GxNieR4EuN-Tg0fw-1; Tue,
 28 Jan 2025 10:54:53 -0500
X-MC-Unique: vL9C7_GxNieR4EuN-Tg0fw-1
X-Mimecast-MFC-AGG-ID: vL9C7_GxNieR4EuN-Tg0fw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1611C18009DD;
	Tue, 28 Jan 2025 15:54:50 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.70])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 5279D3003FD1;
	Tue, 28 Jan 2025 15:54:40 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 28 Jan 2025 16:54:23 +0100 (CET)
Date: Tue, 28 Jan 2025 16:54:12 +0100
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
Message-ID: <20250128155402.GA17054@redhat.com>
References: <20250128145806.1849977-1-eyal.birger@gmail.com>
 <20250128154424.GB24845@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128154424.GB24845@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 01/28, Oleg Nesterov wrote:
>
> can't review, I know nothing about seccomp_cache, but
>
> On 01/28, Eyal Birger wrote:
> >
> > +static bool seccomp_is_const_allow(struct sock_fprog_kern *fprog,
> > +				   struct seccomp_data *sd)
> > +{
> > +#ifdef __NR_uretprobe
> > +	if (sd->nr == __NR_uretprobe
> > +#ifdef SECCOMP_ARCH_COMPAT
> > +	    && sd->arch != SECCOMP_ARCH_COMPAT
> > +#endif
>
> it seems you can check
>
>             && sd->arch == SECCOMP_ARCH_NATIVE
>
> and avoid #ifdef SECCOMP_ARCH_COMPAT

Although perhaps you added this ifdef to avoid the unnecessary
sd->arch check if !CONFIG_COMPAT ...

Oleg.


