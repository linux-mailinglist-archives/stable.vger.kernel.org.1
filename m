Return-Path: <stable+bounces-270290-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M5ZPChC0RWqmEAsAu9opvQ
	(envelope-from <stable+bounces-270290-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 02:42:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 956A46F2AAE
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 02:42:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="JS2n8/Yr";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270290-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270290-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65DF9312B708
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 00:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42309298CAF;
	Thu,  2 Jul 2026 00:38:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110B327A12F
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 00:38:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782952732; cv=none; b=Cy+3ETKPXIa+K5y9xQYXjy6bH0f3lWUJZkFH+LSFRnJE5KyD0Bt4p/KDes6hG7DIIjFI2hoP4gB3h7DjYaQNMGp+ewgPlOa0fogrGGDKL5EqYXqKlqoi+iz1ufjNzRkcMyy536z4tXilTavEvMQi/+QmZ/kqMG71peDDXnncu2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782952732; c=relaxed/simple;
	bh=tRGWOi+X7kf9P3os+1zncWoJM9F1KIiTCXhZMqOWVaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gh1tXKPcYsbCM6X33w2e76NVGDXGYlOu+gumbtIVWJaQ83YF9VwJ7//hSeDAZX3aMd61k2rG4mgM1QiFnbKePYGZL/w+1AzwBbU+5g6iO5PylNDkYm71/rjXjmQc9zCkvS59eQURt9aiKm1p1BwWd5sndBySqfvyKc1YCIeScTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JS2n8/Yr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A8CA1F00A3F;
	Thu,  2 Jul 2026 00:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782952730;
	bh=K2MvIxzJYyDxUHUyAWrPFvGMONjWCoIf+Y80Y08dkHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JS2n8/YrYo1cgjGgyK3Smo3rv5av2X3Q2tg6yuI1ZufWx0ETT8LmnQxORX80KZD16
	 qGMsE7JaYzGu9lOU9krOnbZtKWMVvZBpLTENb2LJhJo7FnecCFO+yMKucpQ9/oV3hs
	 6R2/6jwJwSbgUhUgL9iFIne0+peYgEQtm/QLXcG0HX2Gzxd6BnuayXHaq/JFYLPvER
	 1g58/IyoRtklcxOiWeA3SmzQfOIBTKS3WaktNPBvBs57xno0dnrdm89LkqakjiTkHu
	 N9kjuUXRqJOWvCaIF/nmeUYCvpllJtnUF7T2iQOgbOvQdNtSwkfck9US9kN/4shXBq
	 c6RblpgT7Riww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	tudor.ambarus@linaro.org,
	pratyush@kernel.org,
	mwalle@kernel.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	alvinzhou@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>,
	Cheng Ming Lin <linchengming884@gmail.com>
Subject: Re: [PATCH 6.12.y 1/2] mtd: spi-nor: macronix: Add post_sfdp fixups for Quad Input Page Program
Date: Wed,  1 Jul 2026 20:38:32 -0400
Message-ID: <stable-reply-mtd-macronix-612-20260701193800@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260701024204.2730472-1-linchengming884@gmail.com>
References: <20260701024204.2730472-1-linchengming884@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270290-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:tudor.ambarus@linaro.org,m:pratyush@kernel.org,m:mwalle@kernel.org,m:miquel.raynal@bootlin.com,m:richard@nod.at,m:vigneshr@ti.com,m:linux-mtd@lists.infradead.org,m:alvinzhou@mxic.com.tw,m:chengminglin@mxic.com.tw,m:linchengming884@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,bootlin.com,nod.at,ti.com,lists.infradead.org,mxic.com.tw,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 956A46F2AAE

> Although certain Macronix NOR flash support the Quad Input Page Program
> feature, the corresponding information in the 4-byte Address Instruction
> Table of these flash is not properly filled. As a result, this feature
> cannot be enabled as expected.

Both patches queued for 6.12.y, thanks.

-- 
Thanks,
Sasha

