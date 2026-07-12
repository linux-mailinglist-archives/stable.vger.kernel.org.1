Return-Path: <stable+bounces-273520-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QCL6C8z4U2rvgQMAu9opvQ
	(envelope-from <stable+bounces-273520-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 22:27:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2ECB745D53
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 22:27:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=H2OeG+SV;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273520-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273520-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81428300CE71
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 20:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C023B38BD;
	Sun, 12 Jul 2026 20:27:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAB023C368;
	Sun, 12 Jul 2026 20:27:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783888067; cv=none; b=KDZ/xEnRxVNCQFSnFpdsfrtq8U5kdAWyF8Hr72XdYB0tOK4NcGKY+36w/8sS9ncpv/rNAFFymC2B1r5HXYcZRN3noOmKKd4UG2Mw36Q8UUusykk7nDFfq4+SgfsHVcEZ+De8FcIsQK8TYqxW0gvUmibf/yNDQVV68Y6uZ0viNSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783888067; c=relaxed/simple;
	bh=cMQ7qKy85aI0Ey6pmR7ab44Po5nDh9ffT2own44a108=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VwPrxj5+f6X/POL8n099J6ZADrOO35oQT7QzQAW9MZQacJCOjuDpmc16SnPd56FqOAtfpaXo9amA9UIKuEx9Yd5uMiBt5/TAJDa0pu0urEnsUrqalQ6TeWq//ztlxAqI+7mlfCPc3p1iVC1f/McnNPyBeuNsNXqWmOGjbZOf8Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2OeG+SV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B8F1F00A3A;
	Sun, 12 Jul 2026 20:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783888065;
	bh=fpgKaZ+xtnuszV5MahSHFMgtA0JNZtFAhs6G5RrS3NQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H2OeG+SV9D0Y874MmRvzPmPlULvfcvikAF3jdQfdAlacr+LBOiGw04UIHATEs6uz/
	 6+eTEy1ZYi1Kg570ZWwq9X4qFceT4kp8kg2QK8LmEAuXUpQb8vBLfbl1QZ5NAgkK1Y
	 GQlJE8ig+Jw7/ZiP5uz2T0TFgTalaCEQ87OD520Q2LhzZ0+P8Uh6R7Ya4b0RMvXliQ
	 4ZIetnJxIByR9lHffxJdgkgLLkFar1KvQPWPvl+S8f4lZkHUG1Qimtl5T7FBCQyhbo
	 fW2UqXWCYFUtwOjs/vnSyHmi3/yHzTJ8euR5gEsA3br/so4bQm9MKSbecqf0guQO1k
	 o5jD7QgFpzF0g==
From: Sasha Levin <sashal@kernel.org>
To: herbert@gondor.apana.org.au,
	ebiggers@kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-crypto@vger.kernel.org,
	stable@vger.kernel.org,
	=?UTF-8?q?Muhammet=20Kaan=20KILIN=C3=87?= <muhammetkaankilinc@gmail.com>
Subject: Re: [PATCH v2 1/2] crypto: algif_skcipher - snapshot IV for async skcipher requests
Date: Sun, 12 Jul 2026 16:27:39 -0400
Message-ID: <20260712105304.agent5-0003@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260712022618.1665-2-muhammetkaankilinc@gmail.com>
References: <20260712022618.1665-2-muhammetkaankilinc@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-273520-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:herbert@gondor.apana.org.au,m:ebiggers@kernel.org,m:sashal@kernel.org,m:linux-crypto@vger.kernel.org,m:stable@vger.kernel.org,m:muhammetkaankilinc@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E2ECB745D53

> MSG_MORE chunked chaining is unaffected: it is carried by ctx->state via
> crypto_skcipher_export()/import(), independent of the IV snapshot.

This isn't true for cbc/ctr: their statesize is 0, so export/import carry
nothing. The chained IV propagates only through the req->iv writeback, which
this patch redirects into the freed snapshot - AIO + MSG_MORE cbc/ctr silently
produces wrong output.

-- 
Thanks,
Sasha

