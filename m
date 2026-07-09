Return-Path: <stable+bounces-272775-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ExdIJa70TmqiXgIAu9opvQ
	(envelope-from <stable+bounces-272775-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 03:09:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B64C472B96B
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 03:09:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=FvnL71Ih;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272775-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-272775-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 202293027257
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 01:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB705391E77;
	Thu,  9 Jul 2026 01:04:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3626938D006
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 01:04:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783559094; cv=none; b=HYMszyMRyNU3YH5E7/8TTYjaqJkjerBBwthpAjScIcqLQ9niU7M7TTeF45k2f0tqRRIhuDFUeWO9R7WjjH8rgE2Wnyr6wXHQ7GqMHWmF/qsJC2GYgM8hntTwJIAl/gg4BgoO5qZ0r3pslzjv32uxd6yMAelEXCVTzd8Pq9MqgOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783559094; c=relaxed/simple;
	bh=Z5VFbOAC3Ri9cdhb1eEpKXC/ALDLW01UUeaO1oW0G7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TWwCrcbST5VIxBzeqkEIiSxw4c2bY7SNsO66vLGziEE9gXDaZ2izThi+0zkbTqc4k0IBqo43vt0k4sgMrV8mvc/44/fkECa39RsRfBTmVIa4YgCKeTjp2L1PIO4X2df5bQKcFfN6he+x3u1oRoXtKhcqhO/VX3FHouBMQp+ZKlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FvnL71Ih; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4131F00A3A;
	Thu,  9 Jul 2026 01:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783559092;
	bh=rDPsuXfb71P8QMlyL1xkCgIVz6MR5hXJfhNhODbBLGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FvnL71IhHQsPiLbaRfS+L3S54P3kl/LVZ+HR8g779cYTnWMXzFh/QmYj0IXFH4p9z
	 2he5aP5Yt1t+Oz+m/lqVaUqsa8KLOglI5SyqDloeTrzmAEZJK4N51eefBADP9KCoVq
	 SZDAHsDP8SNVAV/va1dGScMPsD9mjwSDhqVrJWOc/y1cXpzSDI0jnLlTEVsTLatgLY
	 B8lv5uXlU6rhokr2fFyZt3M9rzbq+FWq4mK0OZBizqI48iELuwfl0ptmETkoFt4A1e
	 sZx7jHRCo66YO65TzWVQoBVXO1SEmDW002MwFTyC0kAxJPMLq5tveClFcQG0M8tliy
	 5Mgnl+zKmzfVg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Darshit Shah <darnshah@amazon.de>
Subject: Re: [PATCH RESEND 5.10.y 5.15.y 6.1.y] KVM: Replace guest-triggerable BUG_ON() in ioeventfd datamatch with get_unaligned()
Date: Wed,  8 Jul 2026 21:04:46 -0400
Message-ID: <20260708194323.agent5-0002@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260708163100.92583-1-darnshah@amazon.de>
References: <20260708163100.92583-1-darnshah@amazon.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-272775-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:darnshah@amazon.de,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B64C472B96B

> From: Sean Christopherson <seanjc@google.com>
>
> commit f1edbed787ba67988ed34e0132ca128b052b6ce8 upstream.
>
> Drop a BUG_ON() that has been reachable since it was first added, way back
> in 2009, and instead use get_unaligned() to perform potentially-unaligned
> accesses.

Queued for 6.1, 5.15, and 5.10, thanks.

-- 
Thanks,
Sasha

