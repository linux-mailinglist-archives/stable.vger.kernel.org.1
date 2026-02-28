Return-Path: <stable+bounces-220303-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJVzGME0o2nP+QQAu9opvQ
	(envelope-from <stable+bounces-220303-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:32:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D99491C5ED0
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66D77337D23A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CAD38CFF8;
	Sat, 28 Feb 2026 17:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrXLm8y2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A33938CFF0;
	Sat, 28 Feb 2026 17:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300207; cv=none; b=tbSBYLdbs+lu5mB1MrWLdk7YVFcsk19eYgkwNoBCaqaupb49Ln+0g+f2mfV92PnTwMjZ3BBvSAlPA54LpRVxCXcJvhs/bs6Vbx/AMZf0jaKGB+Vbty5QQTJY+B1mJvMpvXhlnjRPgEbqI6ND5ktXtIgdL5SRKq6hh3qM0/EfSu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300207; c=relaxed/simple;
	bh=uokOkRCSMVLxsGu3rqxKfmFg2fGZyt7kKmsiD3KiJqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SCYPXG+6ZehORA9leiAAh5JRFW3zWgDljpRaxj/t7y6YubmhlKkYwWGWq7hnPuUyRJRkbJakLbSezfseYkc59/XayMTpxQxfNBVjsDho+khCPsxAx2QCMLrpcgLNCMu715KIIk6WxClWpgXUjzjnSnCaCa+V5Sqlu5+mewjqyPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrXLm8y2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174CBC19423;
	Sat, 28 Feb 2026 17:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300206;
	bh=uokOkRCSMVLxsGu3rqxKfmFg2fGZyt7kKmsiD3KiJqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lrXLm8y2/GtRcoh60QQKXwLxKBEHT98Of7Yz9or3NLqUrzO8oeFGme3Z/Ji9BRI+S
	 99KdACBB+TPL1fBbMBp7DppPi84i/0oFf46Pz1TecVJNE2/MYS8BweU4B3dkUNybed
	 69vGfV2rMr1JeLqtCeEnP95HzG82AXp4xzdAVi/T2DrSlRr+PINbUaNiUFiI2WmhjZ
	 xFpqqILpnQ9x/i+v6iVq5RIT4PLOSVeOmiL77JEFQLdKThuYZo5dhZaPHvu50rTwDj
	 m20TKDHNXfUpK73Zmu1SNDZlxeOXt7d1oFP1qE9u0BPSbuDn4lykulF3aD4zJi/IP0
	 qyA57hoiZ6a3g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jinzhou Su <jinzhou.su@amd.com>,
	Yang Wang <kevinyang.wang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 225/844] drm/amd/pm: Fix null pointer dereference issue
Date: Sat, 28 Feb 2026 12:22:18 -0500
Message-ID: <20260228173244.1509663-226-sashal@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220303-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D99491C5ED0
X-Rspamd-Action: no action

From: Jinzhou Su <jinzhou.su@amd.com>

[ Upstream commit 1197366cca89a4c44c541ddedb8ce8bf0757993d ]

If SMU is disabled, during RAS initialization,
there will be null pointer dereference issue here.

Signed-off-by: Jinzhou Su <jinzhou.su@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index f51fa265230b3..2a0e826d0317d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -618,6 +618,9 @@ int amdgpu_smu_ras_send_msg(struct amdgpu_device *adev, enum smu_message_type ms
 	struct smu_context *smu = adev->powerplay.pp_handle;
 	int ret = -EOPNOTSUPP;
 
+	if (!smu)
+		return ret;
+
 	if (smu->ppt_funcs && smu->ppt_funcs->ras_send_msg)
 		ret = smu->ppt_funcs->ras_send_msg(smu, msg, param, read_arg);
 
-- 
2.51.0


