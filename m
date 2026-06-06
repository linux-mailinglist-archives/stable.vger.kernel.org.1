Return-Path: <stable+bounces-260894-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1Tq3DRMiJGoW3gEAu9opvQ
	(envelope-from <stable+bounces-260894-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 06 Jun 2026 15:35:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF0764DA6D
	for <lists+stable@lfdr.de>; Sat, 06 Jun 2026 15:35:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=iTb6TjhY;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260894-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260894-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BDEC304138D
	for <lists+stable@lfdr.de>; Sat,  6 Jun 2026 13:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA2E3B42D7;
	Sat,  6 Jun 2026 13:31:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A7A3B42C4;
	Sat,  6 Jun 2026 13:31:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780752693; cv=none; b=K7dAIqPrbtYW1leaibC94afVxnLK2lKxEEl9HnPEutscP+SGbnkcB+gFRsE951JwPzh8pnn5XJik3Gbvemcarw7S3yn09V17M4blY9WIgEpCZR8HDfgTs6PA+ITt1GquDc9Ckrm6rImI1S0u169qK8Z9BL2x0FgHI5dw8EjVxKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780752693; c=relaxed/simple;
	bh=iqdBp1SBe9s5B8xK7xryHGkN3EFOsiyJRhWFfYHWwXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uMiVy8RMAH4yGTte0yqBtbDmTHqg1/kZFRlrmL4jkyuw/3UtlmRJTQW+BnDsONaAAf/QntSRLu8fL1pY6EvAYHy2IBzgYg4FNMQdg6Oh0r2jyokxWeOc+kCD6fqPEb5bKP3siOa8t6BrUJgqSV/ovWg/DMBJfUAw9aVr/IR6qKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTb6TjhY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF481F00898;
	Sat,  6 Jun 2026 13:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780752691;
	bh=JzucgvGDuY3nnjHaY/HehPAaXtFO2Zl/ImV4s57IpW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iTb6TjhYhNX3iVBnTo8NfKWNj58ai9SMmFXPmNjl7Z50pMJ++zumPBAEE7Fgtk74m
	 GQnEYSyH6Nt8aZ2kWRgP1oqBy85SQxCphK392IfJh0sHsCuC3a0wQ7FOKjfC9/oM8q
	 o97Q3bCEnAqI8LxEAqaVH/RZxL58mtZL3fK71yWo+OniQ1MiVAer1kWuJzODkuzSWu
	 dU/XzlH2JL1ZRaR8yjgfOYDxvlHTMnMD67aTaZaYxeYOOqqfEUlJD5tKZOqyM5uzHQ
	 xNAxkF4Wba9I6KJ+WS1Zn7nIqUyH42n4bl8n196niwafb3RPFEFg0e9L9be3R3BuoZ
	 47HptsMs2J/Lg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	Dmitrii Chervov <fary.ru@gmail.com>
Subject: Re: [PATCH 6.12] iommu: Skip PASID validation for devices without PASID capability
Date: Sat,  6 Jun 2026 09:31:18 -0400
Message-ID: <20260606-stable-reply-0008@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604134753.57739-1-fary.ru@gmail.com>
References: <20260604134753.57739-1-fary.ru@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux.dev,vger.kernel.org,8bytes.org,arm.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-260894-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:iommu@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:joro@8bytes.org,m:will@kernel.org,m:robin.murphy@arm.com,m:fary.ru@gmail.com,m:faryru@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AFF0764DA6D

Queued for 6.12, thanks.

-- 
Thanks,
Sasha

