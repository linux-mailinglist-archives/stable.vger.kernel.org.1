Return-Path: <stable+bounces-267548-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Jl26NaHrN2qcVgcAu9opvQ
	(envelope-from <stable+bounces-267548-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 15:48:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE496AAF6E
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 15:48:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=C4CN4vgE;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267548-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267548-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 477E2300729E
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 13:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB24B36682A;
	Sun, 21 Jun 2026 13:48:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16B025B2F4;
	Sun, 21 Jun 2026 13:47:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782049680; cv=none; b=uutv8V3XSEUQwTmw++zgs68v96qWC/a7454+5sV7WNEA+idL1qtND8fyHxFSV+49UNQc33GmnlG/gsl5veMO3EtpuT3kncNo14Id3wg8VLU8oJuxKTK6jPs0rxz7Wii7J4RKe/ewN2n1MYO5yHWg0KPwm0mrqSJmT7QnocxYTiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782049680; c=relaxed/simple;
	bh=M458LoN8QZhqyhBARrCTEOqQee58V5gjjh6Md3VyKJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A7KtXUi0oWtzbE3dKORGnAahRpViTUCeTKxEqdEfK/TzoHfMKnHA2uMClWMcDzS6NCUYUPfyYQhAyipizdtw1aJZ3ruez36zMYeL2r0orh2Y8ebet9N2kgr07KFAfAV5bfe72Ejl4BNiOpuis+cDxhvikXX0oJIZJKw2T0iJjd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4CN4vgE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FFB31F00A3F;
	Sun, 21 Jun 2026 13:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782049677;
	bh=2jxR1WwgEoatBQ7xflfDZUIze5ZiTfoay/yY1hYZq7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C4CN4vgE8QRkiqJXnDPEvFZuVJrHkYap3/0pMyTXHIk6bo7CDZ1E+M/nWb1Tfex0a
	 9u7RyABJ0nd5cNCh0LLQvSZQG2I/kCKmiraJiws7xdO2IKNsYA6CkGOvTwmJw8dA7w
	 CoUdG/7LdLQEDuljvB3gI04jgAu+NU2Al1X5Iy3e3vQvIpvh8MZ/zGSDbEdSHGEWZi
	 b5j37u1F9bYv/NOe1ww/J7jc8qE6MTuacUsam8bhjd1VmYEQH0GmzQeXAtZ1XAHcCZ
	 L0aKZQfBa4DTafjiEOgwdffQmnI8nfH4nzncNZXCqHxfTJHaTnWapAlS5z2y5OM8De
	 NAxOSf6zPO0dA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	Kirti Wankhede <kwankhede@nvidia.com>,
	Yan Zhao <yan.y.zhao@intel.com>,
	Nikolay Kuratov <kniv@yandex-team.ru>,
	Jiacheng Shi <billsjc@sjtu.edu.cn>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 5.10 5.15] vfio/iommu_type1: replace kfree with kvfree
Date: Sun, 21 Jun 2026 09:47:43 -0400
Message-ID: <20260621133722.0005.sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260619150206.1719815-1-kniv@yandex-team.ru>
References: <20260619150206.1719815-1-kniv@yandex-team.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267548-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:kwankhede@nvidia.com,m:yan.y.zhao@intel.com,m:kniv@yandex-team.ru,m:billsjc@sjtu.edu.cn,m:alex.williamson@redhat.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6FE496AAF6E

> commit 2bed2ced40c97b8540ff38df0149e8ecb2bf4c65 upstream.
>
> Variables allocated by kvzalloc should not be freed by kfree.
> Because they may be allocated by vmalloc.
> So we replace kfree with kvfree here.

Queued for 5.10 and 5.15, thanks.

-- 
Thanks,
Sasha

