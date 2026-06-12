Return-Path: <stable+bounces-262977-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 20A8NqSCLGq5RwQAu9opvQ
	(envelope-from <stable+bounces-262977-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 13 Jun 2026 00:05:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B70F67CA5B
	for <lists+stable@lfdr.de>; Sat, 13 Jun 2026 00:05:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=collabora.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262977-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262977-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C4E3E300939D
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 22:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25CE3939B5;
	Fri, 12 Jun 2026 22:05:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A188B35675D;
	Fri, 12 Jun 2026 22:05:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781301916; cv=none; b=AwxRAI86fDLLgemdZbRYKRO5oRXgq5ZvtTdREpfaXNe3naJzE8E0TklMRhVppsQdO13n0aO4+OONS1/4TJNjNOj05aRsXh9LlbOjLCwbMA0kTwxNYBMEq2IAtkn8JF32FpZINOBhQqD0eSNogGlNFWX3ZfYoJlXYfyw+sxdJs6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781301916; c=relaxed/simple;
	bh=7vjS1+99tVVub53wedPQVGlLD4jWThsbSsnqQv5gwV4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YgdG0KwIy9YPeMaUJ9we2ab/P8dVHrKdSD76DjfzlIJjMY7H2+bH6oAuI4TZMZqXvAI0pJCSqonhRYHSmevqS/uYiyd7+WkvfroyMndSb92kewHJ2ZV5D17hP4TUB+FA+ve7cEwrt2PXovIGNOxeekGPjumw5LTF5rCwPFj3qa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7FC1F00A3D;
	Fri, 12 Jun 2026 22:05:15 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id ACD3A180CEA; Sat, 13 Jun 2026 00:05:13 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, WenTao Liang <vulab@iscas.ac.cn>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260611005322.53096-1-vulab@iscas.ac.cn>
References: <20260611005322.53096-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH v2] power: supply: charger-manager: fix refcount leak
 in is_full_charged()
Message-Id: <178130191369.340022.1341060494195173604.b4-ty@collabora.com>
Date: Sat, 13 Jun 2026 00:05:13 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[collabora.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262977-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sre@kernel.org,m:vulab@iscas.ac.cn,m:linux-pm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sebastian.reichel@collabora.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebastian.reichel@collabora.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,collabora.com:email,collabora.com:mid,collabora.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B70F67CA5B


On Thu, 11 Jun 2026 08:53:21 +0800, WenTao Liang wrote:
> In is_full_charged(), power_supply_get_by_name() is called to
> obtain a reference to the fuel_gauge power supply. If the
> voltage check (uV >= desc->fullbatt_uV) succeeds, the function
> returns true directly without releasing the reference, leaking
> the refcount.
> 
> Fix this by setting a flag and jumping to the out label where
> power_supply_put() properly drops the reference.
> 
> [...]

Applied, thanks!

[1/1] power: supply: charger-manager: fix refcount leak in is_full_charged()
      commit: 4373cfa38ead58f980362c841b0d0bdf8c4d956c

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


