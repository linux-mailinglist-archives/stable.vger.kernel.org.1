Return-Path: <stable+bounces-242047-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2I21EZQL82mSwwEAu9opvQ
	(envelope-from <stable+bounces-242047-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 09:58:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D1549EF87
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 09:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47C31301F327
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 07:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786113FB067;
	Thu, 30 Apr 2026 07:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="sfeCanKi"
X-Original-To: stable@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291009443;
	Thu, 30 Apr 2026 07:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777535885; cv=none; b=P6WekeArd6Xda9zij3N+Db/OraYCI9MBBk2pReF9ckvnANz8TMgKd/tWAaepJ4d3r2C4vAQAa+wZyiGlNDQHMr6IKL9bxeOpDestxciSP80HaoU20Zdsvzu6qcmOWLV9TTTPU6RwzJr36CfmCggFYPHR/TjBb+FcDZ/hhTnp6Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777535885; c=relaxed/simple;
	bh=r5C8Cg1mYU9s9UUlveXWoyy7PAxw7sktLyLjMTpD2zg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nw5Cnlwq4oXbunOKWOCL/5fiS65+GgPuncw15Pflss3vZkddyHei/sVuKb6A2xH3wrSQ12iF4X6UooiAhHgOFZL00laPE6giI4iP0Gf0AGcDyrUlVEcR8Lyq2CAIVEC8341sqgjSk6Zilf4XYofDaasuDTpIae8HYjz8JTiJGU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=sfeCanKi; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 39EC220892;
	Thu, 30 Apr 2026 09:58:01 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vMTW1Sh5fsaM; Thu, 30 Apr 2026 09:58:00 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id B2A2D207D1;
	Thu, 30 Apr 2026 09:58:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com B2A2D207D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1777535880;
	bh=tsqKCY7Dtt+su3qgJymaCiSR+uTrjT1EvUwHf1dIJps=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=sfeCanKiVT5KuEZpijgsGqv008TFZ/1aLIcey5zXKIPKMxpdrRpGeu6WgMboov98g
	 FEcQjWrj+aYeaFeHXyDfe41AsWcDYZxci7bTBSDeH4YbuQ4j8arppkqH0b6MwuYwNy
	 QYrqM8bHC3pWfB7EMFbAQ2xr3iW8IkoaYVU1ECpfedgEhujdx71HHKSllwpW8iXTDx
	 o5kwTZs7bZDlctFxFigXPQOdWCZPd+Y9UHchY08KO/DwwuWtV74eVzhGf3qx79LmvV
	 uQwAewT0KLsPWCoIxWnxtTfSpJiCdChbZxa4EYH6MqcZtKBt3xkcNp+N0xSdE3VQLy
	 UqaHh2RaItK5w==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 09:57:59 +0200
Received: (nullmailer pid 2406770 invoked by uid 1000);
	Thu, 30 Apr 2026 07:57:58 -0000
Date: Thu, 30 Apr 2026 09:57:58 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Michal Kosiorek <mkosiorek121@gmail.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sabrina
 Dubroca <sd@queasysnail.net>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH ipsec v2] xfrm: defensively unhash xfrm_state lists in
 __xfrm_state_delete
Message-ID: <afMLhlpCluCkdSV7@secunet.com>
References: <afHEWqYEiA07An7W@secunet.com>
 <20260429085451.93944-1-mkosiorek121@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260429085451.93944-1-mkosiorek121@gmail.com>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Queue-Id: 97D1549EF87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242047-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:dkim,secunet.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[secunet.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

On Wed, Apr 29, 2026 at 10:54:51AM +0200, Michal Kosiorek wrote:
...
> 
> Fixes: fe9f1d8779cb ("xfrm: add state hashtable keyed by seq")
> Fixes: 7b4dc3600e48 ("[XFRM]: Do not add a state whose SPI is zero to the SPI hash.")
> Reported-by: Michal Kosiorek <mkosiorek121@gmail.com>
> Tested-by: Michal Kosiorek <mkosiorek121@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Michal Kosiorek <mkosiorek121@gmail.com>

Applied, thanks Michal!


