Return-Path: <stable+bounces-254778-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFEsLGkLGGpzbAgAu9opvQ
	(envelope-from <stable+bounces-254778-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 11:31:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 291F35EF9F7
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 11:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B34730DC1D1
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 09:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80333ADBA5;
	Thu, 28 May 2026 09:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QDDZmzOS"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6BF3A2E12
	for <stable@vger.kernel.org>; Thu, 28 May 2026 09:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779960463; cv=none; b=px3TmCb1J7XfM32ECwJUQX5mVVnha0+U52bZyUdU94Ws2vvOXMHCqjmx5Xt5Y7d5KBSjOuTnLE4PnzG+AuevrNDeZsThkBStAcWRrZe81Qbxqsd9jBTC+Xks2KFx0AnCiM1kCm6+VaQTImvqmmIJI4q19AN0JIEUN9B8IQTpDnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779960463; c=relaxed/simple;
	bh=XdBSUg9eFlABJMaUoqozr7F+IqqtjOkM6/VxB0P+ZWc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oh45930F3ci+mhyyA2TTs9FO1thfacw+ybjMAN1H/dBedFMs6bJd2M9P0GOVt4I9wDjQfbgSSYiExRLHIlMKxg9c5GF5jfoCxnGkQGjVvOOt6VtLP9akFNtAeaXHhvNQYELTaGj39ERtqaQzuI5b9fIdvj/ssGWpJCqp6JNhTvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QDDZmzOS; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0A93E4E42D77;
	Thu, 28 May 2026 09:27:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D479160495;
	Thu, 28 May 2026 09:27:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3E5DC10888054;
	Thu, 28 May 2026 11:27:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779960458; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=XdBSUg9eFlABJMaUoqozr7F+IqqtjOkM6/VxB0P+ZWc=;
	b=QDDZmzOSM6P0VJbKo7CzRTESxAINRNqzZ/PLcih2H1KXTDGYUODIdon72wOry2DHIif01z
	OK8cMrqBO/d2576mPe4Sk+OiVRC85r8dRvnDw6VU2YsCmRYL6lGBE1nlShGGpWicFVnQ24
	xAwMjTLlZkgMIAkum6TKboxGE4EW1OQBsmd0DeRNDh+htqgijW30P5y5O6pKIL+lDXa1KJ
	o2MJq/G5YcSZL2qBFMd2gK32s08fqI0y/eKe2OrtZzE3kQH1DAuHOVapg9PFj7tavplrGv
	pz4C+I2vcAbNetEZSDl7tSBJDymtRCfHPE0epMzLdFxMWjfTWB+sM6tqyyhzUQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: <broonie@kernel.org>,  <xtydtc@gmail.com>,  <vigneshr@ti.com>,
  <linux-spi@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <stable@vger.kernel.org>
Subject: Re: [PATCH] spi: spi-mem: avoid mutating op template in
 spi_mem_supports_op()
In-Reply-To: <20260527173736.2243004-1-s-k6@ti.com> (Santhosh Kumar K.'s
	message of "Wed, 27 May 2026 23:07:36 +0530")
References: <20260527173736.2243004-1-s-k6@ti.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Thu, 28 May 2026 11:27:36 +0200
Message-ID: <87h5nrg9yv.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,ti.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254778-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miquel.raynal@bootlin.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,ti.com:email]
X-Rspamd-Queue-Id: 291F35EF9F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


> spi_mem_supports_op() accepts a const struct spi_mem_op pointer but
> casts away const internally to call spi_mem_adjust_op_freq(). This
> mutates the caller's op template, which causes stale max_freq values
> when callers reuse persistent templates - subsequent calls won't
> re-apply the device frequency cap since spi_mem_adjust_op_freq()
> skips non-zero values.
>
> Fix by operating on a stack-local copy instead.
>
> Fixes: a4f8e70d75dd ("spi: spi-mem: add spi_mem_adjust_op_freq() in spi_mem_supports_op()")
> Cc: Tianyu Xu <xtydtc@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
> ---

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>


