Return-Path: <stable+bounces-260125-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wQ3YGI9OIGr+0gAAu9opvQ
	(envelope-from <stable+bounces-260125-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 17:55:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EBF63976F
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 17:55:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YY71HQL3;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260125-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260125-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2A643260130
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 15:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD69E3D7D6C;
	Wed,  3 Jun 2026 15:14:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57403CF69C
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 15:14:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499691; cv=none; b=RmRkJXNE41HDFNAxSZmYeKGSTjLTRXFrvWW8bcELyD6ZyMuxAM6nF780ZfKnfMhUAvZpdAm2BuY4ZZErRatqFEVGfWGVb5eQiPP+3LVEOqs4IWBkaCiEE3IkLd3kH/4Km5LErcw+imKL1/bMauYfvJZNOwlvGkxkq12Z2XhL7xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499691; c=relaxed/simple;
	bh=x2CyR83K8Ui/zDUZ89B7pi39PinAtPOk+fTNyDbzn4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bD13P6fS0tlWhjfFm+4uvwZ4mqMxq9XVfRg8ctTIGGKAFNMpRjlLVy2cpt7kHlXgkSxSDB0XD1hRmD4bVdhh0suyBTcUSIny0cXBm72tB2fYrHUBuWAw9ZD5EXaPUUrFj8eU0/DT6tMimcBVtNR7b8OZ3fC2aLvpeVltq0mhTS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YY71HQL3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC941F00899;
	Wed,  3 Jun 2026 15:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499690;
	bh=4Kj4voNkYXV/vTBaXRccNGRUErzTkLYlawm8sg0S9go=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YY71HQL3X8uxZd8gqUTntArVVdKl5vCKaLcTmatL/DbEvJi3ttGx1rOzYWRbUzJtD
	 qeAWNha0I/hJ8AAWZuF5msbqWPH6vRuu4CcCgS9sRkGl6+i5rP1IQ7Knbn0orXchL0
	 vHCFndUXWsrN9tuJWNMdVVPvBbl2lv9qJk68hpsvMYSTSz6PAEvZ0FL5Mak5cae2Di
	 s8fnCLU2GFBhOTEQxYmFKxm53R5vNFLmchjL7zusVsuBJVzqyUcezwhOPdCwNd220w
	 +qYEc8wyJULxZZ4zdjE2J4xY4fOaFmrQ8PHZcAH6cxXHD4aqGbkOR4jUXOQdmchrEs
	 MN0eI8ykj+2Ww==
From: Sasha Levin <sashal@kernel.org>
To: kuba@kernel.org,
	edumazet@google.com,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Rajani Kantha <681739313@139.com>
Subject: Re: [PATCH 6.12.y 0/2] Backport 2 commits to fix skbs flush pending
Date: Wed,  3 Jun 2026 11:14:15 -0400
Message-ID: <20260603111500.item041@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529092952.2555-1-681739313@139.com>
References: <20260529092952.2555-1-681739313@139.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260125-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,139.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:edumazet@google.com,m:stable@vger.kernel.org,m:sashal@kernel.org,m:681739313@139.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 32EBF63976F

Queued for 6.6.y and 6.12.y, thanks.

-- 
Thanks,
Sasha

