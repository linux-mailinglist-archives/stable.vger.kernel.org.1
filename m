Return-Path: <stable+bounces-273329-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aAL5N6NeUWpcDQMAu9opvQ
	(envelope-from <stable+bounces-273329-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 23:05:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A03C773E9D4
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 23:05:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=FGuILRac;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273329-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-273329-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0434303D2CC
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 21:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5ACE390C8D;
	Fri, 10 Jul 2026 21:03:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763E632F765;
	Fri, 10 Jul 2026 21:03:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783717414; cv=none; b=L2Kw8Z3rX0munePuq9XgA+hSjhWROoFobVvcAVPgNls4SW57/OLgsOqpcs4BuHwXIZ7ZC19iKYKb4pxxONPPjvUQCkDKaG5vuaIO2JErt7+ZWH35ZzOelVvLXiu94gSlZVIWVKDCunt5o3Jg4RYf94dDnm3CPm9/6Lr2onkz8Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783717414; c=relaxed/simple;
	bh=CkADtwdJpmG/vS/uZrLjC/j+8vbncjtmmFpejgqtU1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hjIdlzOOHnxzFGF8PnWjBq5hrt9MXsTsXGum27LQMtTlbSEhVay0wpnkSOqK2C2m7a4rR+mkCSXPqKRf+NNReGWwYWkAWZZlxFNgoMDbWaCl9oE7HWpytkDHyY68m7pd5oHPeTtKflESRotcE4nFNHqLU4trF55j9flWamzH95Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGuILRac; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C201F00A3E;
	Fri, 10 Jul 2026 21:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783717413;
	bh=cvDWPxsDpnJ/Xke/LJ565LR7Bobm8vcz5FQE0fe9EYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FGuILRac47Di2j1Q7cS2/q8Yag+hk2QHyJUqwMK+yeHLNFRd7QI6urFonDy+Fi9m2
	 fOJFJeJvq9Eg9TW7on9zR71hnV8oUjyso11wh8jBz8kqQ3Ta3Co8dpZy9kzJEXSSR1
	 F0QIv9lYalPT4YaibiGfmWVw10FvQX/8bSAHwPVGHMM0J/41KDyPPx90E12F+yn2sB
	 rkofHckKqOFwklpYBTgnMr/sWSIG4Tw6BX6e4fA8EuDAZFCbt/hDg3UVGNIPjsKsla
	 VDV9/ndTX1pyEZEojbnWBl5f7Qt1P8jYQm4Z5IShiVRkq2/hDW6OR9edLtcs9H81Iw
	 93dJEClFpFIQw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-hardening@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 6.18 0/4] Backport the one-arg k*alloc_obj() APIs
Date: Fri, 10 Jul 2026 17:03:06 -0400
Message-ID: <20260710163023.agent5-0010@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260709043301.142931-1-ebiggers@kernel.org>
References: <20260709043301.142931-1-ebiggers@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:linux-hardening@vger.kernel.org,m:kees@kernel.org,m:ebiggers@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-273329-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A03C773E9D4

On Thu, Jul 09, 2026 at 12:32:57AM -0400, Eric Biggers wrote:
> After this is applied, dd015b566d50 and 696c030e1e34 will be clean
> cherry-picks, so please cherry-pick those afterwards.

Queued both fscrypt follow-ups for 6.18, thanks.

-- 
Thanks,
Sasha

