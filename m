Return-Path: <stable+bounces-235895-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFf1D8Rv3GnAQwkAu9opvQ
	(envelope-from <stable+bounces-235895-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:23:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 138D63E7411
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0F523028C11
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 04:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238C538CFE4;
	Mon, 13 Apr 2026 04:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQzMq+2A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600EC38F948
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 04:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776053634; cv=none; b=Gk4VQ6mp5ZZkHpJT2ctG6gKhZyI9cBmTqGIK7SL6wZRmOXYeq00pKubH74F7xmyyY/+ClwzpbL83XNiKz7Bhm43s8+BY7w9V/6YhgECkzkDZ2RPIT5x9vbOWY3WQ9ST7YRGz3L1SrnAM4pG01guhjR91QPnMlH9rMfwWONR1sO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776053634; c=relaxed/simple;
	bh=80f8EOKGn8Nb95D6LOmn4oC8NH+mxI94QkrjDFd5e80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pCCK00V6yMg0DfXaygY7xv3IqXRf+mdcKQTOqp/7aUYgf3yPIh/a0W2i1zI9YkGuRlwJzFFI6ncOWPuyFvBA9CLBIZ1UaHpe0WOuRead2w4eOWutfYiUJOfW3aI2KdvkhAe7soHTiG5P6/Kya7my228PBBE8ibAqj2jyxRSIk4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQzMq+2A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5641CC2BCB0;
	Mon, 13 Apr 2026 04:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776053633;
	bh=80f8EOKGn8Nb95D6LOmn4oC8NH+mxI94QkrjDFd5e80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rQzMq+2ApAGSx8TKgD4pFXu/fj1wFjXDwZ5GtnVKrM4FNY9k8KjCmZGFf0k8DAE2O
	 wuHzG2JFH4Rh3DNlUz5215k+R9DxsPiWwG8ItuyMDk5R1r4AbhBtJ7/ZK6insLh7xj
	 dyKgenFdTZZvz4Kdp7ff+tDVxqB5E5vqYs8CkxGOMen0MBO6CIzNQMZGwD1t0TC1b5
	 ArjaA86kGrlBSdKzuxG/yEtzpbZSbjxS6LIL19wejTzYMZ6yLpQ4UbRT0Bjoi+pyh0
	 XRepY7jS/Ka3tuqlJBs4oBu4bRk2RZTxUIQFs3R63MohjvhijMIZsYV56k8+iY+t+I
	 ZqE4LFw5xJjMg==
From: Sasha Levin <sashal@kernel.org>
To: Alva Lan <alvalan9@foxmail.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH 6.6.y] ASoC: simple-card-utils: Don't use __free(device_node) at graph_util_parse_dai()
Date: Mon, 13 Apr 2026 00:13:52 -0400
Message-ID: <20260412120103.asoc-simple-card@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <tencent_EDD6D47C38490A59EFE3E8C0343684D27A0A@qq.com>
References: <tencent_EDD6D47C38490A59EFE3E8C0343684D27A0A@qq.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235895-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[foxmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 138D63E7411
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> [PATCH 6.6.y] ASoC: simple-card-utils: Don't use __free(device_node)
> at graph_util_parse_dai()

Queued for 6.6 and 6.12, thanks.

