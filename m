Return-Path: <stable+bounces-267652-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aO2gEuoGOWp4lgcAu9opvQ
	(envelope-from <stable+bounces-267652-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 11:56:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CABA46AE794
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 11:56:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WZLmUgAc;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267652-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267652-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C50E0303A92E
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 09:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38E73A48D9;
	Mon, 22 Jun 2026 09:55:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118BF39A808
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 09:55:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782122150; cv=none; b=VcFLRN4ipNeIOfRXwiTYotmd8H40Aj2JOXN7pEIZ2pRBUgIppmnrqu05OwIHZ/ajOfepmyHeImDBxA9Jyq8Ij2dVM+iP0o8kTCGB8cDvOEnVgrfI55IxWTIik9VLGvzbQZmBhFNP1kRdlTLREFDMqpqZaNgdOoqvvbGmMXmrOno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782122150; c=relaxed/simple;
	bh=HDB6j8e5qUiMR8lbBtwzfDilGrSweIwDWioQIiqYgA8=;
	h=Date:Message-ID:From:To:Cc:Subject; b=N8rpW7CX2fS+ba5E40HM0879x3hAon96/bKj8fS43m16+6FFWX/urZyfT8nb+Vs3W+FvJhC2aTrNTnhSjegbm6suONAhRYFme+akG6zZ9LSCPtThXQzSoIrXo+MpnnEMZi/FFtPvnG88u2neTmx1JEovA0DSph6opa1JwuYGbYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZLmUgAc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905B41F00A3A;
	Mon, 22 Jun 2026 09:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782122147;
	bh=iTFKPSyhCXqiQRjtlZa4vx3+4u7YEeob48ZhJWuBUg8=;
	h=Date:From:To:Cc:Subject;
	b=WZLmUgAcZIlNUYXZE5RPBvo2iIjjNidgbp9GvEQbC+9Agynv5maXd9FRC0rvfEh16
	 sGkBGIbznKOCCW7MwOQhHvXEsl8bpIU763pAzlyB0ioZRl3Q6+2w5ks2CaVw73gGHO
	 KWxqeOIo6RfnCIkT/GVK+Z1eHq1Oy1/60swtk/QrIu2QVJ/3gz6FfOAtY3U69iWEOQ
	 kX0Fo+q3EzUlja70rpAroo6e+aT9fOpYa0Wc6JQvB0UEy8UVkdnpBt6J7vFPw+rXkB
	 gtphwjclCfya5qK4QBit1LwdFEmbZ/+wMWCEfF7Rk6QnKqYA2lfNeg5C+9iaVIq8Ag
	 rhljv6a6/cGnw==
Date: Mon, 22 Jun 2026 11:55:44 +0200
Message-ID: <20260622094345.511524619@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: stable@vger.kernel.org
Cc: Waiman Long <longman@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch v6.1.y 0/5] debugobjects: Various backports
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267652-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:longman@redhat.com,m:bigeasy@linutronix.de,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[tglx@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CABA46AE794

This series contains the necessary backports to apply the recent important
debugobject fixes to the linux-6.1.y series.

I leave 5.15/5.10 for people who are into kernel necrophilia as they need
much more care and effort.

Thanks,

	tglx

