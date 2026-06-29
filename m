Return-Path: <stable+bounces-269608-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qXRqOTTCQWqKuAkAu9opvQ
	(envelope-from <stable+bounces-269608-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 02:54:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 613966D55F3
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 02:54:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BxhvvnVq;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269608-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-269608-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68028300D97D
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 00:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEEE13635E;
	Mon, 29 Jun 2026 00:54:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A5735893
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 00:54:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782694448; cv=none; b=qJzDFUQ+cLaBMqGV9bOUKDVlWYTGL6pSOmGH6nv5/z+mO8bjNlVn+sOzSqOOdPyV53h5Ua26Gqft50RGAwq10lTiuHEg6qTMXJpSpjfUs9DQoe8k/tR8cMgxYTAVSHhf6a6s2j49bsAFG5d+A9o7K9+jA15/cxLxdCbr9jJWkhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782694448; c=relaxed/simple;
	bh=beZ3mgZrxrlS/0ByvUQ65pYfTkAhJLUHsPsYioey+XY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F8hycslEdk7e5cU12KiYrn6SAIYYYZoVzxxP/zzizF5FerXAHvu06DAr0ME4ZiGADxeP91MdveHTfw/yW6CZOiNrxfO3x6Qr97WydnupomFXK1bRbqzQdAtwh2sAcxgGrkwO8lXQoo2jJpkIsOP5TmrnzpgeUBeVNS5CLQzKJao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxhvvnVq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA591F000E9;
	Mon, 29 Jun 2026 00:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782694447;
	bh=gVEBQQ3Ih68cKsVxljEnf7h6tlE5psA3qhQaUm1QrxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BxhvvnVqnme4Rx9S7hySq+PuqWGIAZ52kArdjcKcUAlIsAkhoSNZnCep8tlw0WVMk
	 3linyT7Xsazmi0MpVRsd/tHyDM07OMKsMm5yCmDAEyZkdnHUYMe58V/aYtIt+Q50Ar
	 MzFQc3eHFoKB116rqHu4G1KAIqMgix569qBqkrmJu50nQDSLTqkKHp35y7kMD0aDSD
	 scZGiZ82GPKi0JZmsIBryK3vRys8CqzrJjyZXcAr9reD4bzr8ua4unHHJ1Fq3L59re
	 Zardu8b5XCnZKOV/RbS9vO1kQEyakOvvFZDOaeEcrwOALDhjhvlmEksyOMF7y3weVM
	 fFwIFuKmx5dGQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	alexander.deucher@amd.com,
	ray.wu@amd.com,
	superm1@kernel.org,
	"Sun peng (Leo) Li" <sunpeng.li@amd.com>,
	Ivan Lipski <ivan.lipski@amd.com>,
	Dan Wheeler <daniel.wheeler@amd.com>,
	Peter Jung <admin@ptr1337.dev>
Subject: Re: [PATCH 7.1.y] drm/amd/display: Fix ISM dc_lock deadlock during suspend
Date: Sun, 28 Jun 2026 20:54:03 -0400
Message-ID: <stable-reply-item001-amd-ism-71-20260628203053@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260628140148.59923-1-admin@ptr1337.dev>
References: <20260628140148.59923-1-admin@ptr1337.dev>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269608-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:amd-gfx@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:alexander.deucher@amd.com,m:ray.wu@amd.com,m:superm1@kernel.org,m:sunpeng.li@amd.com,m:ivan.lipski@amd.com,m:daniel.wheeler@amd.com,m:admin@ptr1337.dev,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 613966D55F3

> From: Ray Wu <ray.wu@amd.com>
>
> [ Upstream commit 3714fe242592e3699ac5e2c19d68b275a210be7d ]
>
> CachyOS users reported a regression in shutdown/reboot behavior on 7.1
> kernels: the display turns off, but the machine does not power down.
> Reverting ISM fixes the regression, and this upstream fix addresses the
> same ISM dc_lock/workqueue deadlock in the suspend/shutdown paths.

Queued for 7.1, thanks.

-- 
Thanks,
Sasha

