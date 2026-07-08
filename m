Return-Path: <stable+bounces-272704-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GVIFBUN/TmqeNwIAu9opvQ
	(envelope-from <stable+bounces-272704-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 18:48:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FF4728DDF
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 18:48:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=fPL1PxN2;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272704-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-272704-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 133EF301A35E
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 16:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C893E43713A;
	Wed,  8 Jul 2026 16:43:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D472437101
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 16:43:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783529022; cv=none; b=JkDY4G4suoFjXG3TtsXjJQNeYewL5B0TW7PCzlK03bIewy8herfRqJcH58oORAz9wjGQNXhrUTXGColox+4VesNk2oLxXKktpE/pcvGgosh4XoIdhLAlp1ncTytci8UXFnQ4oSDLAuHZ7nbHt5KmX5RXexa2sUs5scnk/d4/hYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783529022; c=relaxed/simple;
	bh=rrsy5rZcgZYTt6KNgG39NW9tODSHtlZTRAi63zGagz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qOjsvJG53DG4+fwNWalgXd3AC10ru05ZCSnbMDALxk14Br4pjJZ7n0TzWpSAdQ/LKX3YiiNqzz6XnJm3aseynuPAhW5vyaQ5APSTkxwCTjx6MrwcvHa8A7Ce6Tl1reTZjuKIyLXeivjrUNhGbnvKl88L1Q074iykUGbDlKpFWYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fPL1PxN2; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783529019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rrsy5rZcgZYTt6KNgG39NW9tODSHtlZTRAi63zGagz4=;
	b=fPL1PxN2Xxu6Ac4F/D9rJs2jV+6PNvQ93WtKQL72TOzLMt8rwEuq9Qgar/9iLDufL17bNu
	LxVxI82CJ/BItiSL6YwotNR/Rzv67GWA8+HESfT9gc1Vjh7OY/mIwpOWPrT32kzutU/qcO
	1GEihSX8weHN7/SS0UMmGY1j9ZjhzJA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-gsy3nbAHNmGURkpLqZwUnQ-1; Wed,
 08 Jul 2026 12:43:34 -0400
X-MC-Unique: gsy3nbAHNmGURkpLqZwUnQ-1
X-Mimecast-MFC-AGG-ID: gsy3nbAHNmGURkpLqZwUnQ_1783529012
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B63621955DD4;
	Wed,  8 Jul 2026 16:43:32 +0000 (UTC)
Received: from fedora (unknown [10.44.33.83])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B7C9B195604C;
	Wed,  8 Jul 2026 16:43:29 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  8 Jul 2026 18:43:32 +0200 (CEST)
Date: Wed, 8 Jul 2026 18:43:27 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Wongi Lee <qw3rtyp0@gmail.com>, Jungwoo Lee <jwlee2217@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>, stable@vger.kernel.org,
	x86@kernel.org
Subject: Re: [tip: timers/urgent] posix-cpu-timers: Prevent UAF caused by
 non-leader exec() race
Message-ID: <ak5-L-1SzGPEc0_i@redhat.com>
References: <178324479651.744054.11944477307374142373.tip-bot2@tip-bot2>
 <ak51mpHPzsQrGFmv@localhost.localdomain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak51mpHPzsQrGFmv@localhost.localdomain>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-272704-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS(0.00)[m:frederic@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-tip-commits@vger.kernel.org,m:qw3rtyp0@gmail.com,m:jwlee2217@gmail.com,m:tglx@kernel.org,m:stable@vger.kernel.org,m:x86@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[oleg@redhat.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oleg@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 07FF4728DDF

On 07/08, Frederic Weisbecker wrote:
>
> > There is a similar problem vs. posix_cpu_timer_set(). For regular posix
> > timers it just transiently returns -ESRCH to user space, but for the use
> > case in do_cpu_nanosleep() it's the same UAF just that the k_itimer is
> > allocated on the stack.
>
> do_cpu_nanosleep() only targets current and since it's on the stack, no
> other task can access it. And the current task can't be exiting/exec'ing
> while calling posix_cpu_timer_set() on that stack timer.

I thought the same initially, but it seems that this is not true...

I can never understand this API, but it seems that
sys_clock_nanosleep() can target the !current processes/threads ?

Or why else we have clock_getcpuclockid() ?

Oleg.


