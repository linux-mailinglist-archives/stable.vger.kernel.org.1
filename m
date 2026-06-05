Return-Path: <stable+bounces-260804-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oSjqIAgnI2oAjgEAu9opvQ
	(envelope-from <stable+bounces-260804-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 21:44:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1817C64B06E
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 21:44:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Bjpc0fWV;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260804-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260804-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 507BB3096B4E
	for <lists+stable@lfdr.de>; Fri,  5 Jun 2026 19:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B7F43E9C4;
	Fri,  5 Jun 2026 19:37:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865CA404BCE
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 19:37:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688278; cv=none; b=EU8J3vthp1NHADIKJPysN73rv6rMwxckGR2apkbV94yk7gU0iRPfDgIfjZfRylU8Qk+5JaBXhej+iOM+uH0+qKS4hcn2K+nx7RUvB21ZbmKckbKkl+T53e4VXbFFrU128H52BhwGnnO8+ia2NhiZqY5NvfrLMuf7K5jVKHYuIoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688278; c=relaxed/simple;
	bh=RsB2D6PxRqvXfiucJQ0rsB7SdrO5hZVKG+osTdli/Rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N67WR3nFtYdGZNMysQIcqSmQVccc1MkEBGQ8h1K/kspzRQLyik0ciMhO+4/cCglX4wJ/8+2YWKcdrlzwVi8O3tESQMcg/3+V+q0LNdXUBPS41m+e6Cf09h/MeJYgaAD6DQicT/taXsQaM265RS7oeYZoDZzoCoNmHMKJgmHGKo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bjpc0fWV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A701F0089A;
	Fri,  5 Jun 2026 19:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688277;
	bh=D8l4osT6iPo6pG/N/mOQl3hQoFF2eVN/rdNPxcBJSds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bjpc0fWVoytwJuqApJ81sIMXDSqsryhheRZzVYKg5Y9/awB/xRLo4jSathziRSQlH
	 SFNao9vRpPFMlRrKUzgrB17gvFIVEkJRGIyfFPdy7m0am8DX0AANGtFnvFDAJhE9rt
	 bPajTAppu8/pVsm1v95/7PD7DuWZ5Df7ndn7DkQPsKDMPFP5AokA6ve1hGi+w9A91i
	 N62WCOTXVU8n0VBjKvYlhM3lGyUMjbVHBD/onDrBw70hKDz0DlduFHj5gc8eov47xJ
	 1LvU/88epaok5PzUqOSX+EMSsEj37OJAayASQEf5bGC3byk9Rg1nbScr4P7hSiHKRT
	 SORsrWyAzTF5g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jordan Walters <jaggyaur@gmail.com>
Subject: Re: [PATCH 6.1.y] Bluetooth: hci_core: Fix UAF in hci_unregister_dev()
Date: Fri,  5 Jun 2026 15:37:30 -0400
Message-ID: <20260605-stable-reply-0023@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604015614.123281-1-jaggyaur@gmail.com>
References: <20260604015614.123281-1-jaggyaur@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260804-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:jaggyaur@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1817C64B06E

> [PATCH 6.1.y] Bluetooth: hci_core: Fix UAF in hci_unregister_dev()

Same as on the 6.6.y posting -- I can't take this as-is, a v2 is needed.

-- 
Thanks,
Sasha

