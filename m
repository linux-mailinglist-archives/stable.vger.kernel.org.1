Return-Path: <stable+bounces-244825-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDW4KKNR/mntpAAAu9opvQ
	(envelope-from <stable+bounces-244825-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 23:12:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 382704FBCB6
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 23:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB57A303524E
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 21:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B221C42314F;
	Fri,  8 May 2026 21:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nh43N0dz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C1341C2F6;
	Fri,  8 May 2026 21:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778274712; cv=none; b=MAxiMqquJkebCGC+404fr5CM0yVwaxR3sPyytLAjFeZBIUyprJzkTBVOgK3cu6N+gaen0L6eNB27SJiiM9unwTM9T97TUxZfovjekVA39lqXvcTPpCniuSo4cRea+K/4EytX1DnsHGcHT9KUQjETS7rN0lu5EynGVheOBAgnOfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778274712; c=relaxed/simple;
	bh=CgBnBDmdkqvx8nTgl5Mp3KpqinE1WaOcJGs2i3jhD10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q0l0DrTBF+PTqJrrJPavFpwB3Iv9fUs1rIaK3loQo/Y7m5/oMHRC7vhSUiKv1r4wo7cjSrAkke0LG+xA9278YrY1l7v5zJZ1hDWMvgZOdMDSDlKuxPFZZXZMUwXlmf6s2PddQKDTINo5k4EVnhQ0e3nkADU9YDLR+2mc/ExKRkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nh43N0dz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1CAFC2BCB0;
	Fri,  8 May 2026 21:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778274712;
	bh=CgBnBDmdkqvx8nTgl5Mp3KpqinE1WaOcJGs2i3jhD10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nh43N0dz8PHuBTkQmma420H1eyihOXkbglB+IaF81WJIm74qn2gZyQNK189fCbfOW
	 o7xIk+VEKHp1fpKlc6PIvwSuSRKB6qNVpLZvSEfbzfJtK/iOBQCYZM5foZiIMOVKKB
	 SZ246dr9gmguxkCi21S/7hXzN62IIQRKkGgdgT/v19zcx+HPSw5cJxE9ZyTl4QS3Ul
	 zgiN+3IutVhy2LfM3MMYv4KX34T5XABIzXYtSgr4xQ4PEUMCetIoRkzk5dhok2W+E4
	 3zqPxeR8JypLjxYmGodzNUtP8emJ0bpnrZO9fBWKt4DBv0JWibkhqoCzcheFXVZmsw
	 hfeUJDrife11g==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	dev@pp3345.net
Cc: Sasha Levin <sashal@kernel.org>,
	patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	ray.wu@amd.com,
	Wayne.Lin@amd.com,
	mario.limonciello@amd.com,
	aurabindo.pillai@amd.com,
	timur.kristof@gmail.com,
	jdhillon@amd.com,
	hersenwu@amd.com,
	Roman.Li@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Fang Wang <32840572@qq.com>
Subject: Re: [PATCH 6.6.y] drm/amd/display: Do not skip unrelated mode changes in DSC validation
Date: Fri,  8 May 2026 17:11:39 -0400
Message-ID: <1e7ec2f7bb732f43-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <tencent_CCDB1B23FED831830856396BB4DF59D1B106@qq.com>
References: <tencent_CCDB1B23FED831830856396BB4DF59D1B106@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 382704FBCB6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux.dev,vger.kernel.org,amd.com,gmail.com,ffwll.ch,lists.freedesktop.org,qq.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[25];
	TAGGED_FROM(0.00)[bounces-244825-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

> Subject: [PATCH 6.6.y] drm/amd/display: Do not skip unrelated mode changes in DSC validation
>
> commit aed3d041ab061ec8a64f50a3edda0f4db7280025 upstream.

Now queued for 6.6 and 6.1, thanks.

--
Thanks,
Sasha

