Return-Path: <stable+bounces-227457-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IA6LloOvWkz6QIAu9opvQ
	(envelope-from <stable+bounces-227457-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 10:07:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BB92D7C00
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 10:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B376131D7D1A
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 08:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D52374E67;
	Fri, 20 Mar 2026 08:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=klassert.de header.i=@klassert.de header.b="yX0mvro0"
X-Original-To: stable@vger.kernel.org
Received: from fs1-de.slnx.de (fs1-de.slnx.de [116.202.84.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C37364933;
	Fri, 20 Mar 2026 08:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.84.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773996192; cv=none; b=elAOc7EwXoxz7eYGl4ET0CzkpGC7ULiWPk4QAOEo2TV991iD0aEcPuhotLPQgghBEMe38HBJt9maBd4KXWpSiSgJJCj92FLmXSoE6Kr1r+IQrRxnQDhwbxnvGzmwx42EPgwmboWN9U8AfvAhvgYvQsrgm+odEioIYjSjc95jRho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773996192; c=relaxed/simple;
	bh=vtFVL9zMHQPk9UCOHXE78wRqptwzKdlhUB9DYYixB60=;
	h=MIME-Version:From:To:Subject:Cc:Content-Type:Message-ID:Date:
	 Content-Type; b=RhqSkDMkRq0Mu35fVD05G24dwM4tH5Z86hJcLfovA/m3cnMb6FVb3cMH35Ixll85etlE+r6vXZH6XC05VaQJMV/GlVoQshRiHD0i4tYQg3xcryLBpQZqnRDeg/LlgS+g/CB2wAxp0Hqxo8tLugbxXfPYib0OOeCNeeayd6PrHu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=klassert.de; spf=pass smtp.mailfrom=klassert.de; dkim=pass (2048-bit key) header.d=klassert.de header.i=@klassert.de header.b=yX0mvro0; arc=none smtp.client-ip=116.202.84.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=klassert.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=klassert.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=klassert.de; s=mx-de;
	t=1773995533; bh=vtFVL9zMHQPk9UCOHXE78wRqptwzKdlhUB9DYYixB60=;
	h=From:To:Subject:Cc:Date:From;
	b=yX0mvro0iEjb4MfK6s325rbCzq7H8RtRJb2Bxrlr6hQSMKfMpNSiu4PQyYC3n5Ez7
	 /uUp2Vc+X17M9RbPujtoDEXGb7c+SFt6Ujchk7uFCsKYgwDP2cqVOtazztbQEbyP1J
	 Kh4xsbh45wSrY6/pASuop8QNpxAtUns3IXNMPP22q1ZI4JBt4ff/C7TZbsmy5BDMM7
	 sVlRsVmbOEXicE0+o10X0jhk313ELbtAAjsAFX+qlptZVxOmdeBMfIFrMe0sR6JdUK
	 AFFELi8+jldrKVGL51wWRInkledFEidIIcv/ZeydZsRT1QSwl1/2lwU2yYIOgoSw7L
	 L+jhOo46KCiuA==
Received: from nbg3-de (nbg3-de.slnx.de [IPv6:2a01:4f8:1c1a:f020::1])
	by fs1-de.slnx.de (Postfix) with ESMTPSA id 9108314604BC;
	Fri, 20 Mar 2026 08:32:12 +0000 (UTC)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: <steffen-ai@klassert.de>
To: "Qi Tang" <tpluszz77@gmail.com>
Subject: Re: [PATCH net] xfrm: hold skb->dev across async IPv6 transport reinject
Cc: <steffen.klassert@secunet.com>, <netdev@vger.kernel.org>, 
	<herbert@gondor.apana.org.au>, <davem@davemloft.net>, 
	<edumazet@google.com>, <kuba@kernel.org>, 
	<pabeni@redhat.com>, <horms@kernel.org>, 
	<stable@vger.kernel.org>, <steffen@klassert.de>
Content-Type: text; charset="UTF-8"
Message-ID: <189e7f89b082031f.2492293c508f2522.8ac0d063cc181f1a@nbg3-de>
Date: Fri, 20 Mar 2026 08:32:12 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [6.49 / 15.00];
	MULTIPLE_UNIQUE_HEADERS(6.65)[Content-Type];
	BROKEN_CONTENT_TYPE(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[klassert.de,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[klassert.de:s=mx-de];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227457-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,body];
	FAKE_REPLY(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen-ai@klassert.de,stable@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[klassert.de:+];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 17BB92D7C00
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

Subject: Re: [PATCH net] xfrm: hold skb->dev across async IPv6 transport reinject
In-Reply-To: <20260320073023.21873-1-tpluszz77@gmail.com>
To: Qi Tang <tpluszz77@gmail.com>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com, herbert@gondor.apana.org.au, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, stable@vger.kernel.org

The fix looks correct. A few comments:

1. The approach of holding a netdev reference at enqueue time and
   releasing it after async reinject properly addresses the UAF window.
   The ordering in xfrm_trans_reinject() is key - caching the dev
   pointer before calling finish() avoids touching skb->cb after a
   callback that may consume/free the skb.

2. One minor note: the net tree generally prefers netdev_hold() /
   netdev_put() for reference tracking, but dev_hold() / dev_put()
   is functionally equivalent here.

3. The BUILD_BUG_ON() in xfrm_trans_queue_net() will catch any cb
   size overflow, so that's covered.

No functional issues observed.

Reviewed-by: Steffen Klassert <steffen.klassert@secunet.com>

Model: openai-codex/gpt-5.3-codex


