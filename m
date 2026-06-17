Return-Path: <stable+bounces-266819-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id s6QSOWa5Mmoo4gUAu9opvQ
	(envelope-from <stable+bounces-266819-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 17:12:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD7F69AD5A
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 17:12:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bS533rhb;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266819-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-266819-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C9A33131795
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 15:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98748481243;
	Wed, 17 Jun 2026 15:04:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84627480DD9;
	Wed, 17 Jun 2026 15:04:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708689; cv=none; b=I+oTAAtHBE2MS9J1h4VvzYAJDalQiJ6+/MQyxZ0/tbp1Pf1TxqjARjMDcEbd+Z0VFldN0CRCT1YaF7qxRVnV0ueKzVqz8x/LxcvZYX2/QMqpU84JJ8HdjXrBMeCRCRBhe/gT8jY8Y8xRPqQ4acDk4Fhld0PpgI2kSQOQd49rOJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708689; c=relaxed/simple;
	bh=WOAParVT6NWGmlFHWCKXqVZK8KqXAbfZkknyu5XU/no=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RhNDbI10wlPL/Ufc2uCTkVkwvxEAIrcpRNAVYFpcOxjKImoUq74it6KN712b6fYWVVzhBoQTcyJ8BaJRFgrGJSTIvGd0F3GCMQiBWImpbDpks+sYSsIreyqvyiQnpK1+xqYYdVRAEHfQJPuX86MNbp/JU1AnSzrAbLa26HiFM34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bS533rhb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5D41F00A3A;
	Wed, 17 Jun 2026 15:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781708688;
	bh=WOAParVT6NWGmlFHWCKXqVZK8KqXAbfZkknyu5XU/no=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=bS533rhbInHnGCn86WVWZ8VqTbgdd0o/mYMi519tUWUReswL1I5tmDI+elEXu3/J5
	 ygkmZSOgcxiTGWqvbONuk31Ve6jmsdUPBJ/gVHNfqeJHbht2y/+ViiIyFvCIWrfFSy
	 T6W0z9AUO7M62cCrwEqJ7PRau1p9basUCXUdVlPZLuin8zQWzEA1hzb6mw3xfrUW08
	 gVBREmwB+BA4vYB5n9V4+y5Ce/BEsRSIjhCE+T8a0SAKcYnNnjxP4xiOq+EJ7XIbQ3
	 vMG76FesBwleYraLHKRjL93thHUBIBFXLl6amLTjlG+3zt4kPrlTxVeax5YNCq55mf
	 eBdAqXaQZOvVw==
From: Thomas Gleixner <tglx@kernel.org>
To: Conor Dooley <conor@kernel.org>, Marek Szyprowski
 <m.szyprowski@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, Teddy
 Astie <teddy.astie@vates.tech>, stable@vger.kernel.org, x86@kernel.org
Subject: Re: [tip: timers/core] time/jiffies: Register jiffies clocksource
 before usage
In-Reply-To: <20260617-flounder-pebble-fe4c19e1be81@spud>
References: <87y0gn3fve.ffs@fw13>
 <178135728754.1650852.1266320590541376793.tip-bot2@tip-bot2>
 <CGME20260616184701eucas1p13c7aff447073832095aa4adfb85935f0@eucas1p1.samsung.com>
 <813164f9-d036-4858-80ad-f3af9bee9c77@samsung.com>
 <20260617-flounder-pebble-fe4c19e1be81@spud>
Date: Wed, 17 Jun 2026 17:04:45 +0200
Message-ID: <87y0gdcinm.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266819-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:conor@kernel.org,m:m.szyprowski@samsung.com,m:linux-kernel@vger.kernel.org,m:linux-tip-commits@vger.kernel.org,m:teddy.astie@vates.tech,m:stable@vger.kernel.org,m:x86@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[tglx@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,fw13:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7CD7F69AD5A

On Wed, Jun 17 2026 at 15:17, Conor Dooley wrote:
> On Tue, Jun 16, 2026 at 08:47:00PM +0200, Marek Szyprowski wrote:
> Same here:

Fix is queued

