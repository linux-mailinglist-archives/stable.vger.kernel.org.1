Return-Path: <stable+bounces-238876-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCeuGqUt5mliswEAu9opvQ
	(envelope-from <stable+bounces-238876-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:44:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3936A42C309
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E2A030A1930
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 13:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A732C3AC0ED;
	Mon, 20 Apr 2026 13:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4CvZx6X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A363AC0E3;
	Mon, 20 Apr 2026 13:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691289; cv=none; b=uuIVeT2SCEOU/X+WGSDwTZLaEIvkTVLKHPPeduVnG96+y7kWg7UhbqI1VGUK371YL+2UHCTeqkjcsQ4uBxJ8T4RFbhC6AxC4tKM6VkxCSZ3xb0aE5eM2EsLAacb2L8h1zRTg0saqEjQ7RlcGTSBKQ6wC2HrsljtEDhe2UrH0Nyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691289; c=relaxed/simple;
	bh=yYcfmB0Ne/LVmybWO2vnjRUm0yMJ8rrC46V32zZziss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YgcSi7mnIBWIRc8bgTd2NQeDBlaDS1Rq/wXPrMSsKxhUBuYSmk0fDEOdcUORnx38fvhFNbLWOVvfiBF5mVf1b3XSoXFLrcPCDGdhazup6xPooveEAn8eTKrj7ABSUbOa2vcasuQJr8instDfqdScRIEJoVwaiL1jKVy1+7+QGDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4CvZx6X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3FA9C2BCB4;
	Mon, 20 Apr 2026 13:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691289;
	bh=yYcfmB0Ne/LVmybWO2vnjRUm0yMJ8rrC46V32zZziss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O4CvZx6X7EfPxTjYRc68YfdnA0FB2HDpZ+hcA6mTrP9gEGCPtXuM7frKU9BQHXKBB
	 wWXe9McYxa0dKXxmI+s4cbElVLChdD4f9ya/dV8DnIp4jfFhfCozOiF4vlyXsv5iKT
	 dZOoGq1ydLMFlu3nn7zmPJhwrao17YqJ7UqR/PYLQk1u8TrOrjwi6GcLCYkvnGes3g
	 sQhbVVCKUQ2N9Pruh+MY2tNFXumXOcC/L/S07I5xecpPtfdWWJlAfcHeagUyZBTTlY
	 Qp25VZ1s/1hHPiLQ2xEZ9EYQEfFysHAQSk1V5DLRnImPxKjz/hBKgBgiy/9yR8cIv7
	 0RnFpgAbiOUkg==
From: Sasha Levin <sashal@kernel.org>
To: Rajani Kantha <681739313@139.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	netdev@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 6.6.y] nfc: nci: complete pending data exchange on device close
Date: Mon, 20 Apr 2026 09:21:10 -0400
Message-ID: <20260420-stable-reply-nfc-nci-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416081119.2197-1-681739313@139.com>
References: <20260416081119.2197-1-681739313@139.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238876-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[139.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3936A42C309
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026, Rajani Kantha wrote:
> Backport of 66083581945b ("nfc: nci: complete pending data exchange
> on device close") to 6.6.y.

Queued for 6.6, thanks.

--
Thanks,
Sasha

