Return-Path: <stable+bounces-233838-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iO+jORQ01mlZBwgAu9opvQ
	(envelope-from <stable+bounces-233838-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 12:55:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 424BB3BAFE2
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 12:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2D39F304655F
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 10:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FF43B47D1;
	Wed,  8 Apr 2026 10:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VeqUIsaX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86513398900
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 10:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775645537; cv=none; b=Y0HYulIiNvwJKd0PWNVWf3bFiQnBGn+K0eMzCWsDN0gCed0Pia4vsfTgojYaO0qnyqDsSrwzcLRY4TaEvINNQPQWDd3qJZVL/3kldFFhHxV0zReKa5FGgxmW2MyXTxnODz9R2E6SNx+4TWVVFWe656uxeQMyLxltcwFf9j/6ybs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775645537; c=relaxed/simple;
	bh=CWXyft5P4P1SpJrgm9DtP4FL89ODUQncQF1XBqUj8ZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HZGHKgrfNk9Q0Ty0LmS2k7iHfYu9NPulh++Pc7x7EoC9psgXKVAeWKcehfGXvfhRripiND6cAVYsWhQN4XIWObHvrCHjw6Lcm6VAFpLBgfMzfSgY+QIMcynD34sxDG7T3betEEYE++G2M2twZAfLYJbfijlLzuDSDbK56fWINmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VeqUIsaX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00EE7C19421;
	Wed,  8 Apr 2026 10:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775645537;
	bh=CWXyft5P4P1SpJrgm9DtP4FL89ODUQncQF1XBqUj8ZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VeqUIsaXtle8BZqvPCd8LRyFtih4idVbTDHtaymyE9wtgvjUPikyy2ejyQc3vq2xd
	 nF5twmdu8e+f8gc7t2cf79cT03BPCHAWsdea3izgeKm0WkKMwhzIJEQrZO77q6tj2X
	 nJSo6hG3AY9hegFouWb/R9y/JBqCXegNpFBVo4p3TvUbrvINwdU3/RG96L8dMaETaG
	 leQpi3p4A8W6ugQJTa55fGELzIJGSyHejyGSaUoI0eXziBWIuoPfcwijJwsa9rqpNy
	 jEx/vHO//rKqJA7/85Ogc/BEdMDKsQTRTLpjCwyd50PZKqITJU59U5SZSCW7ZOcprW
	 Sxew2EKECxAgw==
From: Sasha Levin <sashal@kernel.org>
To: Cengiz Can <cengiz.can@canonical.com>
Cc: stable@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5.10.y] nvmet-tcp: fix use-before-check of sg in bounds validation
Date: Wed,  8 Apr 2026 06:52:15 -0400
Message-ID: <20260408105215.946773-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260404212344.1808777-1-cengiz.can@canonical.com>
References: <20260404212344.1808777-1-cengiz.can@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233838-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 424BB3BAFE2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> The stable backport of commit 52a0a9854934 placed the bounds checks
> after the iov_len calculation.

Queued for 5.10, thanks.

