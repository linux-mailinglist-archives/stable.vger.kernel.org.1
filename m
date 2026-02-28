Return-Path: <stable+bounces-220247-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCnYOpkuo2me+AQAu9opvQ
	(envelope-from <stable+bounces-220247-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:06:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0081C569F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F02993178DAE
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4044375231;
	Sat, 28 Feb 2026 17:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1Bmultm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DBD375229;
	Sat, 28 Feb 2026 17:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300151; cv=none; b=maKCkyZKyOE950iGOJtXfgi88jk537ynSYklZCTMYq7mXQi8sjazptdHE8pyJ2Z9BPeaWIgN7uAhzqR++xRgi7pPob/lo+RtS/pcW0T2bHDutedazzIsuKQze+xq5XurmO69g1vVkrAaNbvxNeHvgCIZZCPBzliV8gEW28fV/HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300151; c=relaxed/simple;
	bh=302aLvXgp/oPLp+JscT6TVUhg+SAs0ZqBWkDb0adyH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r3ydlGLukaemaKOcrde/RuCbRxARQHVhPYELHDEQhPyM9Hh4S539OchGz7njaon3JHdktrnJEArEW+MY7c1MGRetRvToXVNHgruEwvO8GkPFpHVveDqd+HbiMZnzWivQU6fKU60b0MmK4kWtG/2R1+09DAK/UXEbPPGV87hHi30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1Bmultm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52466C116D0;
	Sat, 28 Feb 2026 17:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300151;
	bh=302aLvXgp/oPLp+JscT6TVUhg+SAs0ZqBWkDb0adyH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s1Bmultm0oXTeJJtQCg5QkzgRPI2L81Noya1ItfWddDDAReQGzf0NJY5Tv4gBjOwT
	 bG+EJdn6Df0jke6b38/6FIxt2ffvg1n2SXX3dkmkJAMdxa+gnBYn1EsVJRT1jo6ijn
	 DwzhQtSMy2sUGgcpVqsTKz6hGFDrf8oOgoUbquW4WQWa1bj7BP1IwwSteXje/SsJtU
	 rRrZE77FLquVqjhzk/X9/X0XrNmnR1cx/riaXb4Ip7mx+Hy1tLhFTWERWltAgYROGL
	 SDXuHF2ZhQf2se54Y1wur+0NSNQhmI/pSwOU3kMCFfc6qKnubrTqpFzfl6Z7/Df9g7
	 cGqMIISSp01tQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>,
	Charlene Liu <charlene.liu@amd.com>,
	Matthew Stewart <matthew.stewart2@amd.com>,
	Dan Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 169/844] drm/amd/display: only power down dig on phy endpoints
Date: Sat, 28 Feb 2026 12:21:22 -0500
Message-ID: <20260228173244.1509663-170-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220247-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4C0081C569F
X-Rspamd-Action: no action

From: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>

[ Upstream commit 0839d8d24e6f1fc2587c4a976f44da9fa69ae3d0 ]

This avoids any issues with dpia endpoints

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Signed-off-by: Matthew Stewart <matthew.stewart2@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index f04cbdb3d3814..1ce61f0570201 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -287,6 +287,8 @@ void dcn401_init_hw(struct dc *dc)
 			for (i = 0; i < dc->link_count; i++) {
 				struct dc_link *link = dc->links[i];
 
+				if (link->ep_type != DISPLAY_ENDPOINT_PHY)
+					continue;
 				if (link->link_enc->funcs->is_dig_enabled &&
 						link->link_enc->funcs->is_dig_enabled(link->link_enc) &&
 						hws->funcs.power_down) {
-- 
2.51.0


