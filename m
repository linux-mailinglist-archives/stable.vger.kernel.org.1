Return-Path: <stable+bounces-220220-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCMsAs4xo2kE+QQAu9opvQ
	(envelope-from <stable+bounces-220220-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:19:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 932E51C5AC3
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8921431997DD
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD5F4DD6F8;
	Sat, 28 Feb 2026 17:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3TNGuRm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806124DD6F0;
	Sat, 28 Feb 2026 17:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300125; cv=none; b=W3KY9B+gANWIces/zdEUUpeUnwGWPKHhJ5GezuW15Jg2tYTLx5CB/QlNV/EYqZJfPNP2SfTFXUpefsTuFRZ2hCcKi83WVkzGyL1vBNEyZw1Iz5P5H1mIKBFvMukDxUOMqDTlYUYtAFjlX+lxqqTlmgEnZMpPfZxvtFY9Upz4UhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300125; c=relaxed/simple;
	bh=W8BP5h1dYiVSU+0St47+879EwoKOsmZLFs0bgq2p2TM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iriEenHKollN8aKQ3Z59+uXs5s+aG2OKxFlMkjYFLG3aXIBlyugXkYw+wSq0aaQodV9nUVs8MMKM75TURJ2ONxmrv5Da7GKGMYdzuhgjh+hTjhsPeMFz5cDzXvmk5CKSgyxtSkxyv0okfirWUKBg+/v/sviEjusFQKEk3bsneog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3TNGuRm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A66C116D0;
	Sat, 28 Feb 2026 17:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300125;
	bh=W8BP5h1dYiVSU+0St47+879EwoKOsmZLFs0bgq2p2TM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q3TNGuRm1ptd4xAB5PZm2tH441EowlwI6g+3rg5lR3NuhT/GuAvlGAe4IvtK+b3Eg
	 WPCEHfZ03fNa/9Xdk4wevpi/AR10xTSVJRoiVvGRHQkqZHMDSo6z+mBJ7S+rkry7Ak
	 5qwX9U1PCEabcwJiZdkJeeBWtk393Nta4XKV7DLszK+zPrEo0OHoL3ZHj6Fh5v8hVn
	 fz3rLdGoyaMYoXUCl86j8RofGbhKwOMGdWUkKtFMUOWT+cMYnwoWVe3AEcjN1DSFIt
	 fqZZ4JG4eTRNmy5VdAq9Ghn1WaehKoIdbbLIT7Pq63lSOuDmJjs6YDpZeKYCuFVF+A
	 R0vPSugvZ8NyA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Charlene Liu <Charlene.Liu@amd.com>,
	Swapnil Patel <swapnil.patel@amd.com>,
	Chenyu Chen <chen-yu.chen@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 142/844] drm/amd/display: Fix DP no audio issue
Date: Sat, 28 Feb 2026 12:20:55 -0500
Message-ID: <20260228173244.1509663-143-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220220-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 932E51C5AC3
X-Rspamd-Action: no action

From: Charlene Liu <Charlene.Liu@amd.com>

[ Upstream commit bf5e396957acafd46003318965500914d5f4edfa ]

[why]
need to enable APG_CLOCK_ENABLE enable first
also need to wake up az from D3 before access az block

Reviewed-by: Swapnil Patel <swapnil.patel@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 12ce3789f5130..e1f5b1a34cde8 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -297,7 +297,6 @@ void dcn401_init_hw(struct dc *dc)
 			}
 		}
 	}
-
 	for (i = 0; i < res_pool->audio_count; i++) {
 		struct audio *audio = res_pool->audios[i];
 
-- 
2.51.0


