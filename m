Return-Path: <stable+bounces-249781-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SO7tF0JvDWp9xQUAu9opvQ
	(envelope-from <stable+bounces-249781-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 10:22:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAF3589A66
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 10:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AABB3029257
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 08:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6155B3A75AF;
	Wed, 20 May 2026 08:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KKgYZ1gv"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BEE3A545A;
	Wed, 20 May 2026 08:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779264709; cv=none; b=tNfamEQxsHpLcxcPSPLlKcgORErExOC1Dm8kDNae1MfLcShVXJV39vJkBZ46K6KUnezYKFLXsuqpIB6Rnp7x94Gf7lH3xvf9dL5loOezdiQds7LJJMvAIGePVs/Rf8dkxnuz4b3nNiSKdzI0GsLbiAVN2kspn4xYopkZzpy7I7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779264709; c=relaxed/simple;
	bh=Fdxm3Vn1AOFhUkYyB44/D2Qh3Bnq7xCWi1/UeH17wX4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hBtBH/TzgyCWHGxPf0r99DtSZrPlE2ubZFJ4sCB3ckef9nbqk/0I2supHd9dD3J7oO0ktT/D4TGERnaZDmgdMa/OPSvqXda4uBUCzji75flZsVVh9TVDDBHVE3ar5/6B4s8Tp8i0IGLCmItsf4LNULeQq7QkMWq/P79jq4w5VEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KKgYZ1gv; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 0D50AC2B9FB;
	Wed, 20 May 2026 08:12:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 70E466070E;
	Wed, 20 May 2026 08:11:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E2F4B107E9D89;
	Wed, 20 May 2026 10:11:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779264699; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=DdZv3J2pCE/mvIb6zkVmZxOxqGg0ys9/r9v2yQA8PjE=;
	b=KKgYZ1gvW6m4Xlq+HRrCKY9ejhnura8Ve//r/VOSTko+5kMC61kLF98xFjwu3TxpRt2LpU
	vzTHB0WTQHDPml6chbEAsSrxP13i0vUZN+QAeUAwM125kIEBMmTCS2Kb+6TShkQwDFsElC
	k5TqlwLHLDbDH+Gmyf3AKHa07k5bHviOFe8L4PlhiMGeKV3V+ledm0jR8QBIQSUiBGuYnd
	dmWa1eFiHWaL5P88xV92AhcebXzeS5B3TV7qxGTDyEG6qGPh1x9vDkkTw+zPQ6ZyM+mXkI
	Q+2uTaTuBfVyvtG406wl9McJF6wJsa0WcqrKv14cDTiECULWwxQWwIdbZ8gHIg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
Cc: Alexander Aring <alex.aring@gmail.com>,  Stefan Schmidt
 <stefan@datenfreihafen.org>,  Simon Horman <horms@kernel.org>,  Andrew
 Lunn <andrew+netdev@lunn.ch>,  "David S . Miller" <davem@davemloft.net>,
  Eric Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,
  Paolo Abeni <pabeni@redhat.com>,  linux-wpan@vger.kernel.org,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
  stable@vger.kernel.org,  Shitalkumar Gandhi
 <shitalkumar.gandhi@cambiumnetworks.com>
Subject: Re: [PATCH wpan v2] ieee802154: ca8210: fix pointer truncation in
 kfifo on 64-bit
In-Reply-To: <20260520050707.38055-1-shitalkumar.gandhi@cambiumnetworks.com>
	(Shitalkumar Gandhi's message of "Wed, 20 May 2026 10:37:07 +0530")
References: <20260520050707.38055-1-shitalkumar.gandhi@cambiumnetworks.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 20 May 2026 10:11:32 +0200
Message-ID: <878q9esdor.fsf@bootlin.com>
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
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249781-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,datenfreihafen.org,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org,cambiumnetworks.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miquel.raynal@bootlin.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: AFAF3589A66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

> @@ -2540,8 +2540,10 @@ static ssize_t ca8210_test_int_user_read(
>  			!kfifo_is_empty(&priv->test.up_fifo)
>  		);
>  	}
> +	unsigned int copied;

Why is this declaration in the middle of the code? It should be at the
top,no?

Thanks,
Miqu=C3=A8l

