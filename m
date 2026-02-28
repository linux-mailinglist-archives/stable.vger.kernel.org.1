Return-Path: <stable+bounces-220524-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMmfNOZMo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220524-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:15:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F32C41C818A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0C3C5313C9E4
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E4D481AB2;
	Sat, 28 Feb 2026 17:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bvj2UH7O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8738E3CCA1C;
	Sat, 28 Feb 2026 17:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300407; cv=none; b=tODYUT1XgBE1mreFUnShJj55p4LidHn5Lc2EXqRUTzqx4QagWJvbDdoNq8o38XZQrAaylaWL6ZjWJMh8BAQWGiJ/aba8maezIdw4cWwm93dt5c51gCjd0Z2wFi2Te0PScBWZD7XsNFeeGuUH3jTeCYcbb9hJRjykvdla9JyWhkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300407; c=relaxed/simple;
	bh=Bd41o2rswMZE6Q+rHhQPOTZy5oI39Vt0D1sCOpwwBwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qUIns29tFiQAGYPousu/UT7PKh4Fzw5gGcqLP8lKysNoT1AhkqJKZ4fzPl65Ca1ZtjduyAy+vF7eTJ8pYHWEfgQOs+sDKMMNkdnteHghxKoLbxc5QDLXxEL+4fVUnc+aeUCyVQ3dUVPqqSS13BhjF7cBQodT2USdHfzYWuAbUwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bvj2UH7O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D486DC116D0;
	Sat, 28 Feb 2026 17:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300407;
	bh=Bd41o2rswMZE6Q+rHhQPOTZy5oI39Vt0D1sCOpwwBwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bvj2UH7OrIoDjYQoKd4ydUAF7kflg/RU7G8gSA3fCZ4XBI62jsuh2Xaepd7KfJwJX
	 KRFs0yXb3j5m0Lr1kqxSxff/NaNybPvMgpEM1RvXYiOKy6AQEyQCJSM3arxS7bTNfw
	 4hO4HParqNi7KU1AD8q8gF+tFlyGkM7M4zrV0KiaQmAMi/K3GBNAwVyGM647ijmyVx
	 I8dO6rZ855O9HNZjSwQmz46wSjPJ/lqZEsWsuSWh/JP2ZFUfKpRZNhC05Z8E8mFJRr
	 FP1Alj/NANWPT6oJxbeSynxo81sJ5f3X2CSXgrNteiwxbhoUU554Rrud/BalhxkhTv
	 WS/Tzo9T5i7jQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maciej Grochowski <Maciej.Grochowski@sony.com>,
	Jon Mason <jdmason@kudzu.us>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 445/844] ntb: ntb_hw_switchtec: Fix shift-out-of-bounds for 0 mw lut
Date: Sat, 28 Feb 2026 12:25:58 -0500
Message-ID: <20260228173244.1509663-446-sashal@kernel.org>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220524-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F32C41C818A
X-Rspamd-Action: no action

From: Maciej Grochowski <Maciej.Grochowski@sony.com>

[ Upstream commit 186615f8855a0be4ee7d3fcd09a8ecc10e783b08 ]

Number of MW LUTs depends on NTB configuration and can be set to zero,
in such scenario rounddown_pow_of_two will cause undefined behaviour and
should not be performed.
This patch ensures that rounddown_pow_of_two is called on valid value.

Signed-off-by: Maciej Grochowski <Maciej.Grochowski@sony.com>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index f15ebab138144..0536521fa6ccc 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -1202,7 +1202,8 @@ static void switchtec_ntb_init_mw(struct switchtec_ntb *sndev)
 				       sndev->mmio_self_ctrl);
 
 	sndev->nr_lut_mw = ioread16(&sndev->mmio_self_ctrl->lut_table_entries);
-	sndev->nr_lut_mw = rounddown_pow_of_two(sndev->nr_lut_mw);
+	if (sndev->nr_lut_mw)
+		sndev->nr_lut_mw = rounddown_pow_of_two(sndev->nr_lut_mw);
 
 	dev_dbg(&sndev->stdev->dev, "MWs: %d direct, %d lut\n",
 		sndev->nr_direct_mw, sndev->nr_lut_mw);
@@ -1212,7 +1213,8 @@ static void switchtec_ntb_init_mw(struct switchtec_ntb *sndev)
 
 	sndev->peer_nr_lut_mw =
 		ioread16(&sndev->mmio_peer_ctrl->lut_table_entries);
-	sndev->peer_nr_lut_mw = rounddown_pow_of_two(sndev->peer_nr_lut_mw);
+	if (sndev->peer_nr_lut_mw)
+		sndev->peer_nr_lut_mw = rounddown_pow_of_two(sndev->peer_nr_lut_mw);
 
 	dev_dbg(&sndev->stdev->dev, "Peer MWs: %d direct, %d lut\n",
 		sndev->peer_nr_direct_mw, sndev->peer_nr_lut_mw);
-- 
2.51.0


