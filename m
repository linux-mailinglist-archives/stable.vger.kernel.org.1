Return-Path: <stable+bounces-260115-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pKwBEUVKIGpY0QAAu9opvQ
	(envelope-from <stable+bounces-260115-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 17:37:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A4B639460
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 17:37:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BkTTTfZz;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260115-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-260115-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2EDF33294D63
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 15:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430843D5647;
	Wed,  3 Jun 2026 15:14:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB6E3A8FF6
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 15:14:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499682; cv=none; b=g3hCSGI4zf/Qqiftj7HDCMvs9n8GwUuBFigWYBpAr0jUbGEVYyApJmZRtyXUY4P3phfZhNO51nGAhhvagZl/Zfsc4bzYZUsI9ygKju8l4uCZV1Fm5V70jPGUaMcKDOcuCJ4PfxbZ+Z2boyZMRKPj2+tWuF4GhNptrHLdR7C+FH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499682; c=relaxed/simple;
	bh=hiv6JrGJ+w+A4aShddBGl4vrAW7YJaog81zYB9+ZoZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b1fyXKlO2LbYR9im1D6pCO/Aon3K2X1OhZSn9mPHU6oiNKAfpM7wChVHALob6okGTObITe1sGdgB08WHlgw6rDsrjGM25LYSjlXSyvbSqCoHhL9ROEU1GgF6Gow9mEWwa4JdVOHNqNkEGOKP6nfIvXcoo/285XwBg0Bf3rnp2D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkTTTfZz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D01C1F00898;
	Wed,  3 Jun 2026 15:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499680;
	bh=c9wec6HOAcXQM89KrClVf0Yh4yj9+WR23XvId5JFm4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BkTTTfZzn5pH8qi7t8wDZoLfg9sVi7GrAfb/sLTw4SBDPK/jrkdXFyZgikPw6famk
	 KzAMQFXChe9bC4cqdhS3TbgBxd/B5OyetvscffhmwCN20FPg1n4wHbuvlJCETFzts9
	 0b8AkWtiXVWjYW3UNqO6v1L8SelUAcPdM03nhFRlR9RrMw94Ig1Kh4s3pUYgw/QIlo
	 PeQQYhYfOFmYuV1JPj/W+LeeX+t58UORMAXKknKwy2cFDZ6zIIDdIEe8xChC965xU7
	 /Xq5Ytuq2bZ+uR7koQYBxJelRn5cglEeioL9w4Oyoot2bRI8TUcvGC7HWi6tEIBIxC
	 JJZGs0HkoR//w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	=?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	Suraj Kandpal <suraj.kandpal@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>
Subject: Re: [PATCH 5.15.y 1/4] drm/i915/psr: Add defininitions for INTEL_WA_REGISTER_CAPS DPCD register
Date: Wed,  3 Jun 2026 11:14:05 -0400
Message-ID: <20260603111500.item011@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529080317.343937-1-jouni.hogander@intel.com>
References: <20260529080317.343937-1-jouni.hogander@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260115-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:jouni.hogander@intel.com,m:suraj.kandpal@intel.com,m:tursulin@ursulin.net,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 10A4B639460

Queued for 7.0.y, 6.6.y, 6.18.y, 6.12.y, 6.1.y, and 5.15.y, thanks.

-- 
Thanks,
Sasha

