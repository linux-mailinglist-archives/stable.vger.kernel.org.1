Return-Path: <stable+bounces-227456-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHqTEo0HvWkO5gIAu9opvQ
	(envelope-from <stable+bounces-227456-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 09:38:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E602E2D74CD
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 09:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EE2D30AA14E
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 08:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F276136492D;
	Fri, 20 Mar 2026 08:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="lKO9XwMD"
X-Original-To: stable@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68AC35C1B4;
	Fri, 20 Mar 2026 08:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773995837; cv=none; b=UJsuAvyqDO4AIOu3hKQQDF3pZtGFcmIeSYraLOCjNQ3AZvyRM4ITdUlOlRIJIrRgECKsWaShcqEgMm/wO457tHwEWPIfnNuoJLl98o8j7V7FmoOjirD6yG8yv9xU+Zp6cdfEwCu6ThHehYO6/tGXcmU/kBaOSrTShXVUr+2Tn2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773995837; c=relaxed/simple;
	bh=HfA1vB/S9IsWsK2YWq0TcwkKewtBxNecFrxnoGAcRe0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbSh/0hDU+dEWDZvIL3Opifi96lbE4D5C/QdP3vdNsDxAoCR2siJeS1rTvHFOG1QmE74lsYpRfi2esvsKoAZzd7T2jYaE68EGuncsXhjAZr6XuvavUvc6xEuscbbWwvVtk5OdlhEWPH4Oa4WDxKbnLSyma0lkRBnKHkDCLG3Bl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=lKO9XwMD; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id B1E432088E;
	Fri, 20 Mar 2026 09:37:07 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iF_JxUP15nQt; Fri, 20 Mar 2026 09:37:07 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id E09B420844;
	Fri, 20 Mar 2026 09:37:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com E09B420844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1773995826;
	bh=HfA1vB/S9IsWsK2YWq0TcwkKewtBxNecFrxnoGAcRe0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=lKO9XwMDXrWOgvhykTV6JD1hSy2YHKljnTcOJMsFI2ylFwJ6E0UmpWUv1IcVM4/ts
	 dAGSwL/OETaHQWIvlligqMMyUl5QC5PVAIZtqickjJgdVNzpUMM2dgHUvLpnqIxWl4
	 kPzc//eAHGipD6DzrUDl/FYAqgxd0BuBaN5Ah5W51qe5nJtCw4j0hKfM9JxtVXbefe
	 bWJcPcA8MsL5QmZ8i64JwHdoCCKYvZm9nnHTRPfdVZoBxjh8gb4EKNEy/8m/eBd+RE
	 xeDB5RXToGtYUyUjFVkaAG6cgcmpebJffvPtwjCH1g+yTJxnIEGqAs/bxKCd0E7AXD
	 fqIvk1zHzlFCQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Mar
 2026 09:37:06 +0100
Received: (nullmailer pid 635546 invoked by uid 1000);
	Fri, 20 Mar 2026 08:37:05 -0000
Date: Fri, 20 Mar 2026 09:37:05 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Qi Tang <tpluszz77@gmail.com>
CC: Qi Tang <tpluszz77@gmail.com>, <netdev@vger.kernel.org>,
	<herbert@gondor.apana.org.au>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<stable@vger.kernel.org>, <steffen@klassert.de>
Subject: Re: [PATCH net] xfrm: hold skb->dev across async IPv6 transport
 reinject
Message-ID: <ab0HMcKhqmoDtT0k@secunet.com>
References: <189e7f89b082031f.2492293c508f2522.8ac0d063cc181f1a@nbg3-de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <189e7f89b082031f.2492293c508f2522.8ac0d063cc181f1a@nbg3-de>
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,apana.org.au:email];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,gondor.apana.org.au,davemloft.net,google.com,kernel.org,redhat.com,klassert.de];
	TAGGED_FROM(0.00)[bounces-227456-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E602E2D74CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Please ignore this. It was sent accidentally to the list.

Sorry.

On Fri, Mar 20, 2026 at 08:32:12AM +0000, steffen-ai@klassert.de wrote:
> Subject: Re: [PATCH net] xfrm: hold skb->dev across async IPv6 transport reinject
> In-Reply-To: <20260320073023.21873-1-tpluszz77@gmail.com>
> To: Qi Tang <tpluszz77@gmail.com>
> Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com, herbert@gondor.apana.org.au, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, stable@vger.kernel.org

...

