Return-Path: <stable+bounces-240072-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oO95Mt0s52lg5AEAu9opvQ
	(envelope-from <stable+bounces-240072-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 09:53:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 605B3437DF7
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 09:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4330B301EC59
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 07:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A1B387585;
	Tue, 21 Apr 2026 07:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="deiTA/zq"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D993446B7;
	Tue, 21 Apr 2026 07:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776757959; cv=none; b=BmM1UtlQyR6AxfAQ7W2tYeTBsXRoNrav81NCmwd8Dc3IOhPtleZHRAib3YIeT3ZcDcnjDmNoBdEfzS+7LSeV7oH6yN67/Xm0DU7YU9PJmDGwldwEWRp9ceA/yp3nI4vLE7mu4QSu6brYLj5+vuXA2dYr5WUXlmUVLIDjAnWE2/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776757959; c=relaxed/simple;
	bh=1UJdStWuXc+3P6vByY9wa8GVOgl0OgdrU4BHWgXWlrc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jtMcAOz38wrdmzGyX1x0EMyNZ0PHL1+IMyn4kKm0vuyjmVbW9hI8RMf2S058VnUdMRWWf+5xoxtVisraty+84YcSFe+OzgBOf2xnq19WgySje+G4dUl6ShieQzqGpj1IpMdPThf0dNLmqhyJzKbv/Hg3nYKD4St3yCIZI/CRbGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=deiTA/zq; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 322E4C5C9A8;
	Tue, 21 Apr 2026 07:53:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E7DB7600D2;
	Tue, 21 Apr 2026 07:52:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DE1E910460A02;
	Tue, 21 Apr 2026 09:52:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776757954; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=1UJdStWuXc+3P6vByY9wa8GVOgl0OgdrU4BHWgXWlrc=;
	b=deiTA/zq9+xnKePVLAxop9BBN2NUkb67CAWuKL2Svmbf66rzR7fvRlfOSZAQNIdf7a8MTo
	I2DZMsoiaNmYbIiMw3kl+95j8AQPbW0z7O76zMkvPylYlGWiFXcPZLNPWIasnTAOTAGxOB
	KOxXPnlwULLTzpl2hXhfPd1UmT1xecTcXGNyGQCP7afVWITQ+LAGGjSmuOJt4wlFB6ttWg
	OiX7+OqRo1m1PKL5uF6uWbUYCYriU1dCXXp/PXSGVb4T7OTIOAQ6RHhjB8lt3CcC1xtuQA
	h9JrUFjl9ZmhMystswXLe9FrmeC1y/8hF2x6REQ0yw4loTOlLAv0zREF9/1wOQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
Cc: alex.aring@gmail.com,  stefan@datenfreihafen.org,
  andrew+netdev@lunn.ch,  davem@davemloft.net,  edumazet@google.com,
  kuba@kernel.org,  pabeni@redhat.com,  linux-wpan@vger.kernel.org,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
  stable@vger.kernel.org,  Shitalkumar Gandhi
 <shitalkumar.gandhi@cambiumnetworks.com>
Subject: Re: [PATCH] ieee802154: ca8210: fix cas_ctl leak on spi_async failure
In-Reply-To: <20260421073259.2259783-1-shitalkumar.gandhi@cambiumnetworks.com>
	(Shitalkumar Gandhi's message of "Tue, 21 Apr 2026 13:02:59 +0530")
References: <20260421073259.2259783-1-shitalkumar.gandhi@cambiumnetworks.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Tue, 21 Apr 2026 09:52:30 +0200
Message-ID: <87340o7nsx.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240072-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[gmail.com,datenfreihafen.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,cambiumnetworks.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miquel.raynal@bootlin.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cambiumnetworks.com:email,bootlin.com:email,bootlin.com:dkim,bootlin.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 605B3437DF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

On 21/04/2026 at 13:02:59 +0530, Shitalkumar Gandhi <shital.gandhi45@gmail.=
com> wrote:

> ca8210_spi_transfer() allocates cas_ctl with kzalloc_obj(GFP_ATOMIC)
> and relies entirely on the SPI completion callback
> ca8210_spi_transfer_complete() to free it.

[...]

> Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
> ---

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

