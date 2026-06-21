Return-Path: <stable+bounces-267545-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bzN6DZLrN2qVVgcAu9opvQ
	(envelope-from <stable+bounces-267545-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 15:48:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F046AAF5D
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 15:48:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XDRAWRil;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267545-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267545-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D078C300CC13
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 13:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B76035028D;
	Sun, 21 Jun 2026 13:47:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFFE62809;
	Sun, 21 Jun 2026 13:47:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782049674; cv=none; b=aqS29DMQlk0LO3JffLufmEzfvrbA00RPcOPETHuVpodr9Bsq+H918mQVnM3YTRLcGTUf4jqhWnmXYm6wA/Qjv9VzIZaEqTkD+QlgHtWk7pxACskc3SGxN+Ia/TJ1TmtRx/dUrbSSCo2X3sY4tzbKUT5eA2u6+eN2ztEG61dxGl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782049674; c=relaxed/simple;
	bh=4qRiunIixzSUm2c/epCCCUghgm1hs1SpOluiNikjXGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cwo7tczFpk/GOumi5qOzH9SauNWA7CBWm4N5/6fHlRgcR2YwtMzMF4HhfjwQ0WRQ5P9ALlkiG6k5/Z3GNeLijzEeSp5+dqwOp+JOEefpTOIguBL6VBO2zApwf+xN9aX69CBJLMtBN5/0lTpmODDSQMMywqq5bLPo9J7VAlFDztU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDRAWRil; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C4A71F00A3D;
	Sun, 21 Jun 2026 13:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782049673;
	bh=ow1LSmRuQ0I4nJ5kJTePCFnDvx4l3BvtVLs9xM0KEJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XDRAWRil2YMxxUZo1f1Honwpn9/53A5kb02/hR1mwZ/6ZKOruFAlBld42oTJcnt37
	 V3iIKz6/iA/AwR9kEnmjsTWaG6tbom/E++ETSZ58IOxKj/y4Ucnavp1ITl/r+Qw+PP
	 2FvSSr+y5FrBqxRB3CxAkO0Q0WRc/+2ZESEsPnzz0kOWHeETc6aiTyI8YD7Idw7gdM
	 xQG3BPiMr8t23O8oWiNDGl5dDuRew3dJk4UalKDxBLmmh6SfHOsUaK5WYPYCL4qLST
	 RstdHoLlBkJnnbOFgSs40NfJBh2Z8L0CecfBykG8X9mS9Y7j7AS+LU50t4dSd9GKxt
	 1v/ZaNV6C42eg==
From: Sasha Levin <sashal@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Soheil Hassas Yeganeh <soheil@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Sasha Levin <sashal@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jaeyoung Chung <jjy600901@snu.ac.kr>,
	Quentin Schulz <foss+kernel@0leil.net>
Subject: Re: [PATCH 6.12.y 0/7] eventpoll: backport a6dc643c69311677c574a0f17a3f4d66a5f3744b
Date: Sun, 21 Jun 2026 09:47:40 -0400
Message-ID: <20260621133722.0002.sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260619-6-12-cve-2026-46242-v1-0-e15a6de43c11@cherry.de>
References: <20260619-6-12-cve-2026-46242-v1-0-e15a6de43c11@cherry.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:dave@stgolabs.net,m:akpm@linux-foundation.org,m:soheil@google.com,m:edumazet@google.com,m:pabeni@redhat.com,m:sashal@kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:quentin.schulz@cherry.de,m:torvalds@linux-foundation.org,m:jjy600901@snu.ac.kr,m:foss+kernel@0leil.net,m:foss@0leil.net,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-267545-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable,kernel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A4F046AAF5D

> Backport a6dc643c6931 ("eventpoll: fix ep_remove struct eventpoll /
> struct file UAF") to 6.12.y. So the patch applies cleanly, [6 prerequisite
> commits] ...

Queued the full 7-patch series for 6.12, thanks.

-- 
Thanks,
Sasha

