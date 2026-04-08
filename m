Return-Path: <stable+bounces-233803-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ABJA3wF1mnbAQgAu9opvQ
	(envelope-from <stable+bounces-233803-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 09:36:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC603B8605
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 09:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5150C310AA37
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 07:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76403806D2;
	Wed,  8 Apr 2026 07:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Li2S5y0k"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1163803D4;
	Wed,  8 Apr 2026 07:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775633361; cv=none; b=VCbegZnnLElLvrNZVP2orem53/k/Bvfj8wdi1hQtycw3Si7RfNuRpQWzmKVtu0UgC0Noyj/AI3i+hJo8CRAbWyOftlv04/GelJLa0YjVYYnWdov2bVEKGk85ZRtODdE29o0EwblrIlsBivs1i+t6r9f+gU1TjO7t2gxRUF9Hd8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775633361; c=relaxed/simple;
	bh=JBMyJgrxswXMHHOOoQfxlHGWkE8Y8DUq0RYrllJqtFk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=gegTMTM+97IFKebcd8FgUwr76L3qNxML3cfIq5rkiAY39uhCU/T/04nyYsf1pTTin6qJpw7IDCyBBGK82Oo+JdEu2g3vKLyEEwaJPUHDylzAAaYupg/Xp3T/dLqJcVA5OhgpOB7O+e+YIwl0tPwQEgGR4Txa7B+fzmT+Jz7GPZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Li2S5y0k; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1775633326; x=1776238126; i=markus.elfring@web.de;
	bh=JBMyJgrxswXMHHOOoQfxlHGWkE8Y8DUq0RYrllJqtFk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Li2S5y0k8r8TPKYqugEeYBkm0wKy4jMuzv2JHCi1XiCi6PD26XVxHLhERPVI0heB
	 aVKr2d6f3wo/UTidfeoThGd53fhthe2nC/7KFkYtIDktjJQL70BLeTh1MiMUczdc0
	 diBh4rp2TBbU3fjs6MgHTMQ/RTcjDloQYzTi0IzCX4eWu6gzzr8JuIAcd1Qtcsjkl
	 GJ6GX0ts4hDS4OTbgFqH800R23GmlLfOuPilc+J28VMQ5eqSCcxO9sH68jeubpjUD
	 dMfhvO+rXyckmBU4wB+gSUF8+06vVcE6MJi4cCf0UiGBe4S75uqqgvFRkKmjkzFnu
	 +kQRNiTtsIg9k6Za+w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MIL0Q-1wDjNy2N3k-003mIF; Wed, 08
 Apr 2026 09:28:46 +0200
Message-ID: <ac7176be-8ab8-449b-b4f7-4e5af0379e80@web.de>
Date: Wed, 8 Apr 2026 09:28:34 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: vulab@iscas.ac.cn, imx@lists.linux.dev, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Georgi Djakov <djakov@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
Cc: kernel@pengutronix.de, stable@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Fabio Estevam <festevam@gmail.com>
References: <20260408031004.309483-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] interconnect: imx: fix use-after-free in
 imx_icc_node_init_qos()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260408031004.309483-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:a+/9ZVtkN5tdsblsJWxaTm5i+Qpmy4+r1RjEmTjqJox2o6D+mRB
 X0gLzf47+mI89l69lRdhe+2g6xC7kxgtHOonJ78p6EOP5xe4c2E5aHeS/HuvfvC5yRJ6WTf
 pnbNhlEZn2BeLd9NZlqYux+4kNy883XGG/ejuRp1JmLiC3y+z98j7F53eUp9iuHH6rJkoTS
 RMqJqCQGCgItr3hj7qTFQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:a7lNGxMd7xI=;s95fBgV3Au1wbIkJzs84aH5BnnD
 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
 th
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233803-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[pengutronix.de,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[web.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[web.de];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:url]
X-Rspamd-Queue-Id: 7FC603B8605
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Move of_node_put(dn) after the last use of dn, and add a missing put
> in the error path to avoid both use-after-free and reference leak.

How do you think about to increase the application of scope-based resource management?
https://elixir.bootlin.com/linux/v7.0-rc7/source/include/linux/of.h#L138
https://elixir.bootlin.com/linux/v7.0-rc7/source/drivers/interconnect/imx/imx.c#L117-L160

Regards,
Markus

