Return-Path: <stable+bounces-260792-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eK8jLG8mI2rjjQEAu9opvQ
	(envelope-from <stable+bounces-260792-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 21:41:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FB564B023
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 21:41:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=U6gZMHlb;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260792-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260792-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F1E430578BF
	for <lists+stable@lfdr.de>; Fri,  5 Jun 2026 19:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DBE4071CA;
	Fri,  5 Jun 2026 19:37:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6757F43E4A6
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 19:37:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688268; cv=none; b=oNwsqOgHy4t4vuk7R8l+kIIZ1DrnhW4bI13YrjjIrw3+TOtb/1Z1q/Hyur+3o/j3t8J710/g56U7+RGTUXyNq3eVQc4+daDDNGiMNe/c5NBOED0BQRPQ56cOB46oYu0pXejPXw2+yh+EQBnZkraL4mlC/452Npa664u5PgBSumA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688268; c=relaxed/simple;
	bh=exoEOWSgNDkiqV04c8dQtEg6APFoDReBp6cxdFAHYGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gOineya2GdyREA6Zzf0kqjOcYaeNzQY7C3CzbYrYOaDD00ydbNOcFd8W4ldnxDL+rByrb37NaI36d1RKrBUN9YDN8f9PT7PWAHpIr/GuhzEfcaeQds7SFJZl6S/1Xh5B6gbpd30QAXKfzACMyFeg7yjU/tih3f2idcj2wihOGWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6gZMHlb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59AD1F00898;
	Fri,  5 Jun 2026 19:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688267;
	bh=cDDMplL0vlNihLQFTdnsZN54PrCoHwjgL18pnIOyWsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U6gZMHlbwL/OEswGak+T/jAKabxjU2FpJq0V7Stw5zLKMRbWt07s9xwuIs7gs0o95
	 tD/etRNkmT+ZCFexHPedPpsrTwuP9pMBHuKTtblFfkdP11C3iRWAru9oKOA0+PH2qU
	 jk5GQRk+0oYxNo0gM/EVWjok/cCKRadV6r8FOnQqWG016k3Ajf7aeztsxQJduxXUd2
	 zXrah1asz3JA9mrDme7GNdWwSZ5u0gGYSquIVVBcnG//myptpHMqyd5LabfDmzyxxp
	 acbjtHBNF90972q+86ueBihqqU04PtJPs7nkkiXaEOY+upXmXU13mkqRWDjBKR1NBe
	 hraXtnbbjMLNQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	weichengc@nvidia.com
Subject: Re: [PATCH 6.12.y] xhci: tegra: Fix ghost USB device on dual-role port unplug
Date: Fri,  5 Jun 2026 15:37:20 -0400
Message-ID: <20260605-stable-reply-0013@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604121909.150108-1-weichengc@nvidia.com>
References: <2026060432-overnight-groin-0e8e@gregkh> <20260604121909.150108-1-weichengc@nvidia.com>
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
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260792-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:weichengc@nvidia.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 36FB564B023

> [PATCH 6.12.y] xhci: tegra: Fix ghost USB device on dual-role port unplug

Queued for 6.12.y, thanks.

-- 
Thanks,
Sasha

