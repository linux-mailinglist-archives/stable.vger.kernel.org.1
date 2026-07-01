Return-Path: <stable+bounces-270252-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RFm/EUGIRWpzBgsAu9opvQ
	(envelope-from <stable+bounces-270252-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 23:36:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BBF6F1DE0
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 23:36:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="jT/tvibM";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270252-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-270252-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89B5E30182B2
	for <lists+stable@lfdr.de>; Wed,  1 Jul 2026 21:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEAA3B7753;
	Wed,  1 Jul 2026 21:31:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22FE34DB52;
	Wed,  1 Jul 2026 21:31:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782941473; cv=none; b=JjfT/gjqjG16DDb98e8Kcf262+2HEvv/YcrpSScoLdLsMhP50FiIpZvtOfLKiykzFeuEGiSmvQ07HEO42jviPsTwqZWCqxOybhKVxSsAoqpSUvKOVy6vlEqKHXWdkqoQaj208VKhvgGN0NoH6uMBj+iCsvBAEf7pAgnzFjLY7rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782941473; c=relaxed/simple;
	bh=BavMPbJC6SPhFucwGcjMaqoDqJIMp/+q1TALMp3G/1I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G2C5aesVVfw1pb0Vka+S34l1z6I8CQzoTkWPwCSVQv4+2pjtxNmyiADCa6QGgMq5ry642ihYN6ZZB6LnWVuRh0Ah5uQTDjCOtncSsXFgck6OyriAcwKNbiuF+dYCWUw6oj9v4Ucjx7NFQdT39bz/XVjDo0CdWQsQtrttzUlR74I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jT/tvibM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4EA01F000E9;
	Wed,  1 Jul 2026 21:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782941471;
	bh=jofe61Y2KudCbIyKulWKELRw4tMt3nodxyxcXMP3OOM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jT/tvibMgCayxBTWzluVaPlDE7+S3HATB+/e+Yw6wh3qenjL4YJbs+02Y9/d045Do
	 rVFNXXTTFyEUN7Udw+A8C/bICuXml7TBjbo9Z4P7AnRbr62KqXO38a2+Gwq1i2pL4v
	 NIGKWEryr0c9M9X9jo59JGQW9EwRfvc5sR36rt56bjcr1215ugBlNlOTOi8n0CdNEO
	 rbBtDLVcO5kugkaqvIQBVDN1ARNVddVloQEdg3Wrnw2f+v5aY3OJni6lAZ3hyg02Pv
	 e5GOL3n5Dn5k9ApT+Aj49sUgE6edrPZdEXBHsVAbuwvdpGmp4BUPk4CgHCZDFkKMZ0
	 3OHGLNltZkb7A==
Date: Wed, 1 Jul 2026 22:31:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Crt Mori <cmo@melexis.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Pengpeng Hou
 <pengpeng@iscas.ac.cn>, David Lechner <dlechner@baylibre.com>, Nuno Sa
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: temperature: Build mlx90635 with
 CONFIG_MLX90635
Message-ID: <20260701223106.5ac21c5d@jic23-huawei>
In-Reply-To: <CAKv63uupUcUGXwXJQL957YtUmP+OZ5makvGROvFuvS8BWF-sPQ@mail.gmail.com>
References: <20260624081309.77805-1-pengpeng@iscas.ac.cn>
	<20260625054259.76774-1-pengpeng@iscas.ac.cn>
	<ajzOA3MGaCqrgCDp@ashevche-desk.local>
	<CAKv63uupUcUGXwXJQL957YtUmP+OZ5makvGROvFuvS8BWF-sPQ@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:cmo@melexis.com,m:andriy.shevchenko@intel.com,m:pengpeng@iscas.ac.cn,m:dlechner@baylibre.com,m:nuno.sa@analog.com,m:andy@kernel.org,m:linux-iio@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jic23@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-270252-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[melexis.com:email,jic23-huawei:mid,intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 96BBF6F1DE0

On Thu, 25 Jun 2026 09:54:58 +0200
Crt Mori <cmo@melexis.com> wrote:

> Thanks for spotting this Pengpeng Hou; it's strange that nobody
> noticed until now. I would like to apologize to everyone for this
> mistake.
> 
> Acked-by: Crt Mori <cmo@melexis.com>
Applied to the fixes-togreg branch of iio.git

Thanks

Jonathan

> 
> On Thu, 25 Jun 2026 at 08:43, Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> >
> > On Thu, Jun 25, 2026 at 01:42:59PM +0800, Pengpeng Hou wrote:  
> > > drivers/iio/temperature/Kconfig has a dedicated MLX90635 option, but
> > > the Makefile currently builds mlx90635.o under CONFIG_MLX90632.
> > >
> > > This means enabling CONFIG_MLX90635 alone does not carry its provider
> > > object into the build, while enabling CONFIG_MLX90632 unexpectedly also
> > > builds mlx90635.o.
> > >
> > > Gate mlx90635.o on the matching generated Kconfig symbol.  
> >
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
> >
> >  


