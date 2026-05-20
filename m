Return-Path: <stable+bounces-249947-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBcLM8bKDWqn3QUAu9opvQ
	(envelope-from <stable+bounces-249947-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:52:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B622590383
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E4A6327DA8A
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4ECA3ED136;
	Wed, 20 May 2026 14:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k72y2WiC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFF53EA95A;
	Wed, 20 May 2026 14:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779287504; cv=none; b=YjzXGcXO8eNvJs6Jws2xaDI9HeyWWrjYY55pTVrY0UKZcTaTcQsrXN69xiOnRWhbQfEWMH5tN8YjYApsP6Vv4aXs8JY2m0M59IJUyGGtXDdb2aHAXf3D52snG4Os5pG16VLS31RreN8wt0B8bRiALGV8LjWgBq6guf2aIOd6ySg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779287504; c=relaxed/simple;
	bh=aeHMrpM9qjacICJxQ8n3RNfoEEZtvD+4Sro00xbKqVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JjSlSrHi5H12K6m6nTxNri8MO2ne3Df3qG15yy4SKNmagtZCXJVT518ojIdmX2OtuvdnGXab1zyzp8geiOzDhkluukLXHz49g3bgka/FY3MygbYyRw9ODrHUKpvnYtC2Saxm3CefZKX7pzbEfxs4fSehwV85dObgull15NjsHO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k72y2WiC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E889F1F000E9;
	Wed, 20 May 2026 14:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779287502;
	bh=XNPVaTgAOBRWiuQRxqOD0YIY/1T+B4hVhjqMJKBQjQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k72y2WiCUnyzlmEFELXPKm9jGzxFI7t9r/rBbVS352YhmARy2sbg03posR9UBxYzB
	 PrSEagPjxersT4jiBZz/B4Q8t6FmynTbUDtEfZZSZrSwmXU9RvRzmquf9sVHTmd6nc
	 YuX0Eg/s6nRhGqbr/aZndhlrPRU6FBHXGdgPBnVuB3lifVsNOsx8LpeHR8m8Lj5cCA
	 DnkS+YTOK7e9n26GtHuFydqZ/JWs25oW5GGo0AMNGdYc+ZMjcNN6CF02rZfOtRKuUw
	 vWxPWn40MrF4w2ftRUvKDMSwgU8cADARoEUUcQX+ZpjmOlAKZl/wZraqDDyVXN/Z6W
	 JdqMm6AuXU/cg==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	broonie@kernel.org,
	alvalan9@foxmail.com,
	ranjani.sridharan@linux.intel.com,
	liam.r.girdwood@intel.com,
	mateuszx.redzynia@intel.com
Subject: Re: [PATCH 6.6.y v2 0/3] ASoC: SOF: Intel: hda: Fix NULL pointer dereference in v6.6
Date: Wed, 20 May 2026 10:31:36 -0400
Message-ID: <stable-reply-0001-asoc-sof-hda-6.6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <tencent_5129AC5B71AC600A1B0C69236AF83EA22509@qq.com>
References: <tencent_5129AC5B71AC600A1B0C69236AF83EA22509@qq.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249947-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,linux.intel.com,foxmail.com,intel.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4B622590383
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> v1->v2: add two prerequisite patches.
>
> This series backports a fix for a NULL pointer dereference in
> hda_dai_get_ops() to the 6.6.y stable branch.
>
>   Patch 1/3: daa09d0615ce ("ASoC: SOF: Intel: hda-dai: remove dspless special case")
>   Patch 2/3: 2065610b5ddd ("ASoC: SOF: Intel: hda-dai: add support for dspless mode beyond HDAudio")
>   Patch 3/3: 16c589567a95 ("ASoC: SOF: Intel: hda: Fix NULL pointer dereference")
>
> All three patches apply cleanly to v6.6.140 without adjusting the context.

Queued all three for 6.6, thanks.

--
Thanks,
Sasha

