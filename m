Return-Path: <stable+bounces-220728-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIALD8REo2li+wQAu9opvQ
	(envelope-from <stable+bounces-220728-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:40:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3861C73DC
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F22531DBEDD
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0003FF1DE;
	Sat, 28 Feb 2026 17:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PE7pk5ET"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A125C3FF1D8;
	Sat, 28 Feb 2026 17:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300609; cv=none; b=Cgf/86q67bM1cLQvK1+Mw+plreDaafFhOVyHcdgUt3GTFhTBWbj1hcHD8nqbGn1teH2/+M1nsjptk2dFiSEvAjGirj7u3FKqnKc8YuS5+GIxVJckN87HGe1k092LBN7CrLvZcVxdgQ0LWQdy822T6MFHLFVYUk07Vf/XooLF6qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300609; c=relaxed/simple;
	bh=nZpfEUnxRBoAUgmH/6AuFk06MuwRjlxeNi9sgiulmN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jGl4QFA7wrn4kiC95mU90Q+892BO7H9nnLcGG8BqicaoaGebQ0+B1v3QPMCB1/RF7FZ3F5erTQx3+plZkefGcuis0oUb1jZE6cZ729hO5Wab19spzE5/8Sok80yaWs87gSENZ4k5OxsLZhXMfnPOpxNumhPMi3uts3NrdTer37s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PE7pk5ET; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0BBDC19423;
	Sat, 28 Feb 2026 17:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300609;
	bh=nZpfEUnxRBoAUgmH/6AuFk06MuwRjlxeNi9sgiulmN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PE7pk5ETbXMe2eVQ3zer8mLQRg+Sh1nlua1q2hETH1SeNCYJF/Nlxz+6YAvMISAB1
	 sVvYw5jXdt4KC8VVNmWmjKOLbT5iaheHHu9s0VQUICQhBaTtauR8K6eFgx5OSAmr9x
	 MbVKjZSOeYSAR2aFwztJycgJjiTme3/zMVhHGNmOF0P4zD4Jmr4WP0uGY/3QXBGGhF
	 5CgLlDMiXyVwM8+9cDnEmgbvMsA1/0dSiZu47bL7fQvymnwFcyAb2eQaiLiulCNxMZ
	 Vzgqe2PEEKGFrZNJMsjvBGgegdrvVl5LtnpSOEbm0uHKnKwm3rxtrGhBi1jqoe/7sn
	 7gnTtP/0NiAMA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	stable@kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 649/844] drm/bridge: anx7625: Fix invalid EDID size
Date: Sat, 28 Feb 2026 12:29:22 -0500
Message-ID: <20260228173244.1509663-650-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220728-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: CC3861C73DC
X-Rspamd-Action: no action

From: Loic Poulain <loic.poulain@oss.qualcomm.com>

[ Upstream commit 1d5362145de96b5d00d590605cc94cdfa572b405 ]

DRM checks EDID block count against allocated size in drm_edid_valid
function. We have to allocate the right EDID size instead of the max
size to prevent the EDID to be reported as invalid.

Cc: stable@kernel.org
Fixes: 7c585f9a71aa ("drm/bridge: anx7625: use struct drm_edid more")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Link: https://patch.msgid.link/20251218151307.95491-1-loic.poulain@oss.qualcomm.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 6f3fdcb6afdb9..4e49e4f28d552 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -1801,7 +1801,7 @@ static const struct drm_edid *anx7625_edid_read(struct anx7625_data *ctx)
 		return NULL;
 	}
 
-	ctx->cached_drm_edid = drm_edid_alloc(edid_buf, FOUR_BLOCK_SIZE);
+	ctx->cached_drm_edid = drm_edid_alloc(edid_buf, edid_num * ONE_BLOCK_SIZE);
 	kfree(edid_buf);
 
 out:
-- 
2.51.0


