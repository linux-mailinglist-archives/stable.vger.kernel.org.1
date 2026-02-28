Return-Path: <stable+bounces-221209-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLqJN95Io2l//AQAu9opvQ
	(envelope-from <stable+bounces-221209-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:58:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 474B61C7A98
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAA7634B47CC
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A1F375254;
	Sat, 28 Feb 2026 17:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h24ttwsn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198AC375243;
	Sat, 28 Feb 2026 17:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301566; cv=none; b=m1r0q/SgUsBDqPuZ5cwjk8xls1WiJFShPnecDqihaEtC9Z8gS1POrX2XpQd3J4FUV36Utu6t22r31xY4qUf06QI+Hc/oQHW2H8dIWupcQj5+MsYSH+pb6usY6Qk7P5E5+zWMm5PUtAWYJ+65hAptToC5yREDJ3gNHeuSDBLrraA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301566; c=relaxed/simple;
	bh=0ke89qIkCP1Vx3mCNyJmsf87GelHhrDmZ1+IDmagLCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EOqqxb8rkePuTBSOYue5NVsyZYNlGSj9grZRKzFzo1P1s7h8JeY2+niao5LUmkOCDF2C3Op3dFA1cuoSYHuGJEE8b94flMYMPoiA2TmzafiaLbjdTZVLfyMP3x7r/1YC0R2v6DU3JVoQvg35cLm8U1P08N5loPleF7rpyk0HzSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h24ttwsn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4025EC19424;
	Sat, 28 Feb 2026 17:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301566;
	bh=0ke89qIkCP1Vx3mCNyJmsf87GelHhrDmZ1+IDmagLCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h24ttwsnNC3P7h/aKQEWtHhzvaY31oIzyjLBV0jh9+WHvT/nvpKnQn0OI6QPSwHUV
	 KUGKCS+sFVSffaaPLo7xfzMTr9rVUlLhKI6U5x4hKLUvhBG40Y/BF/Tnh7bwGMn7fS
	 Liw8RMqMno8hzQkeYe1kvk/AFe5TtsKq2m38M2nDJ/EGOYjFrF+aDl3NmEqw4ukvCg
	 TKBCV3GOiOGTnAlWYBBi9u81cc0AraGDzVXq6px05PwERE5LoOkjhtPPbquT3kZihM
	 EJi2TFTZnC6P1XhO1Cf8aBt+KPK/BfrXfu8q/mJbCGmgDfuLA816RVTDu+x4iCWteB
	 enfPpqriCY72w==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Koichiro Den <den@valinux.co.jp>,
	stable@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jon Mason <jdmason@kudzu.us>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 749/752] NTB: ntb_transport: Fix too small buffer for debugfs_name
Date: Sat, 28 Feb 2026 12:47:40 -0500
Message-ID: <20260228174750.1542406-749-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-221209-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 474B61C7A98
X-Rspamd-Action: no action

From: Koichiro Den <den@valinux.co.jp>

[ Upstream commit 6a4b50585d74fe45d3ade1e3e86ba8aae79761a5 ]

The buffer used for "qp%d" was only 4 bytes, which truncates names like
"qp10" to "qp1" and causes multiple queues to share the same directory.

Enlarge the buffer and use sizeof() to avoid truncation.

Fixes: fce8a7bb5b4b ("PCI-Express Non-Transparent Bridge Support")
Cc: <stable@vger.kernel.org> # v3.9+
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ntb/ntb_transport.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 71d4bb25f7fdd..4d00263ebc934 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1236,9 +1236,9 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 	qp->tx_max_entry = tx_size / qp->tx_max_frame;
 
 	if (nt->debugfs_node_dir) {
-		char debugfs_name[4];
+		char debugfs_name[8];
 
-		snprintf(debugfs_name, 4, "qp%d", qp_num);
+		snprintf(debugfs_name, sizeof(debugfs_name), "qp%d", qp_num);
 		qp->debugfs_dir = debugfs_create_dir(debugfs_name,
 						     nt->debugfs_node_dir);
 
-- 
2.51.0


