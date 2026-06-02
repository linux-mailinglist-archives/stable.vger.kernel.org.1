Return-Path: <stable+bounces-259870-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RVOOJKcfH2rygwAAu9opvQ
	(envelope-from <stable+bounces-259870-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 20:23:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C5363109D
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 20:23:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lrs7P6Gc;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-259870-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-259870-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D62F33027940
	for <lists+stable@lfdr.de>; Tue,  2 Jun 2026 18:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB943395AC0;
	Tue,  2 Jun 2026 18:21:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3643947A4
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 18:21:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780424509; cv=none; b=gWlldc/t+Vpz9exwG89EuhwO1bc7/KBQ/yR1hKHbbYOTDe30PyCgynLPkF9fkGTGrJlj2/OtsyIrCS9oyreEFmVbk3WcJvoH3bwJ52IqvRk1oU+eYHk8VMPWZrSciRUq2XH0nPwDTqoGlgdJfBjfipgjvgi84pC2CQAYeQoWcls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780424509; c=relaxed/simple;
	bh=GI6hjdP/5HmA4fKqJ5A165UD/zmfoUqQgcXUXppDea0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V2hTOgKBZ1qFYOIkBg26Bu9Fx59nZtpAd1wNT1Z9CfiQR3ckxrYzacOTl0meXdV3dol+AqRkZyhPg8xcBkdvyCGkZR/B1BBn+MfKud3o1TSeSlOQp6OiOpKmemW/MznOHw3lBpGxB6QFK8wmwx/a6l1hfGnjrAylLmBm3h78H0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrs7P6Gc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BDF61F0089B;
	Tue,  2 Jun 2026 18:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780424505;
	bh=GI6hjdP/5HmA4fKqJ5A165UD/zmfoUqQgcXUXppDea0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lrs7P6GcOS5yZo1uewm4Wa7DCimGEhqvMxpgPgF5ZmgoBcL1ONYs1KimyusopX9gD
	 qLlsajvYrZ6NrzuTjerQ0Q8X2IOD0lQ5TyK/L8wVGikatZW4h1gaZ8u+Pj5md66r16
	 kwnZk0xEOioavlx9cv7Snr+xG42VknuB+7j5hoCcxakWh5DBTBcFAv9JVhkT7KZnpJ
	 md4UCrq0Mmgo3uKlgpamcdqWjCFGozQQnazg8b8clwnoSH9NQafRHMC/VjlwMNq+wW
	 Tq9gFL7hnlGVrjwXVxQXDWN5IDYtsd8xJ1mj/VdI6m+iqokHF4l7wHnZCjttgk7RWg
	 ZcNwYzVdk4lMA==
From: Sasha Levin <sashal@kernel.org>
To: Mahmoud Nagy Adam <mngyadam@amazon.de>,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	nagy@khwaternagy.com
Subject: Re: Backport "net/sched: cls_fw: fix NULL dereference of "old" filters before change()"
Date: Tue,  2 Jun 2026 14:21:23 -0400
Message-ID: <20260602180900.cls-fw-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <lrkyqmrxe16vj.fsf@dev-dsk-mngyadam-1c-cb3f7548.eu-west-1.amazon.com>
References: <lrkyqmrxe16vj.fsf@dev-dsk-mngyadam-1c-cb3f7548.eu-west-1.amazon.com>
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
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259870-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:mngyadam@amazon.de,m:stable@vger.kernel.org,m:sashal@kernel.org,m:gregkh@linuxfoundation.org,m:nagy@khwaternagy.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 55C5363109D

On Sun, Jun 01, 2026 at 07:57:04PM +0200, Mahmoud Nagy Adam wrote:
> Backport "net/sched: cls_fw: fix NULL dereference of "old" filters before change()"

Now queued from mainline (65782b2db732) to 6.18.y, 6.12.y, 6.6.y, 6.1.y,
5.15.y and 5.10.y.

Thanks,
Sasha

