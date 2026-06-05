Return-Path: <stable+bounces-260794-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lcnaJXMmI2rljQEAu9opvQ
	(envelope-from <stable+bounces-260794-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 21:41:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 673B964B02B
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 21:41:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=caB3VBts;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260794-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260794-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C67773058770
	for <lists+stable@lfdr.de>; Fri,  5 Jun 2026 19:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C75B43C05A;
	Fri,  5 Jun 2026 19:37:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6761D43E4BC
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 19:37:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688268; cv=none; b=JbqnwuOjmLRfXs2H58RWgRmGtXPhBivgyyB6zoDHdIJO9SeSbQSlabiHzaz0CXGo5HKzcSBLU6qWMDC1uG4tJQ9gcdWpTxMVhrNHtNEwA9AmddCY0r6M9fQfFIlqk6RCU4BY14jDxbxM7skiYlYoTxHdcTdd6DLONCRWZTO0RkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688268; c=relaxed/simple;
	bh=rs6CPCQWT2B1psmpR09sF+LZRODo/xEO4ioaOx76Zfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C8ZW0SiptxGGJwcMrESOvYINSCqp1bKErET5P17D1e+/RHIrUcoNl0n5kxkSHXbWjJ5gDSAXiBiGOXFpQTNyX62d6F59N6xNmtZ3s39BwZj4BVE3md9uPKZ0xtk+/ze+K74APzynKY1DAqb/4ZXgnxyy3PbNbaT2NlxwhHQ3eKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=caB3VBts; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B2B31F00899;
	Fri,  5 Jun 2026 19:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688265;
	bh=25jXhYyGn/b5r+ffFKCDAh22RuqSrtU7bTZ+K06iK70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=caB3VBtsvut5JNOdrY6E2wAPA2logye5sdbyW1WjAlCNyokjZJkW4JuIoC/8F2dFu
	 cN3eESi0t3MrmwyoiuXp7+H6oCjCdaRhluhtS3BpH6LDfm1qpTRJVa6eBAC9CV0KM3
	 4Df4gUf3n7rLwmGWJ1VlsC+cXJurAn/xCkFOqaefvlUUDIiUFVqU2s2Qoqt3Y0QMpE
	 y7MN/PkIEnGBhqHWxFEAN4Db/AIXNhTjqItWucrU2M8R4bX8sVcGufsy6ZjUxqI92S
	 D8iD3ONVHML1MTcCbQpK1vZZIPf23dcLBjb6H/b+rz3SmAn+6IShTDLHbCJGNDoB07
	 AKVUnnKuSEiDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Wei-Cheng Chen <weichengc@nvidia.com>
Subject: Re: [PATCH 7.0.y] xhci: tegra: Fix ghost USB device on dual-role port unplug
Date: Fri,  5 Jun 2026 15:37:18 -0400
Message-ID: <20260605-stable-reply-0011@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604120914.131945-1-weichengc@nvidia.com>
References: <2026060430-deluxe-finite-6c5b@gregkh> <20260604120914.131945-1-weichengc@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-260794-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 673B964B02B

> [PATCH 7.0.y] xhci: tegra: Fix ghost USB device on dual-role port unplug

Queued for 7.0.y, thanks.

-- 
Thanks,
Sasha

