Return-Path: <stable+bounces-220237-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIuYFqg0o2mX+QQAu9opvQ
	(envelope-from <stable+bounces-220237-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:32:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 913B81C5E90
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1DEF130927C3
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2828371455;
	Sat, 28 Feb 2026 17:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFqvBve9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DD037144B;
	Sat, 28 Feb 2026 17:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300141; cv=none; b=f543UkjV13YiFYOCakvzrDQFgdaCWNUBS1nu85aeiUAUTawJyFdExwnWlgIIl4P1HbHbRd6vKP2FFHzj/x6FXoB9ZZIpr/ZyZgrtQEKYBuOw8G6EgalNSID0aeeuLZaaHPXh4Ze3/PROIZ2ZLUD7mdhtszOAY4aj4dCGeDF/Rbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300141; c=relaxed/simple;
	bh=CrjC/KEYRFs2Rg659n4xEZHkQ8osnrjx1QCXppF2yaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KpbjNAhSc8IvRsClWHXrk71fE3JD91sWUnvG7qVawcx4oxY30RsnqcpYinUTG0WvAxEPOJbtDJ0M8k0/9LPXk/O11efS/MxtEfvJNvfTgpNHK+ykSGb9U+UAcj09NZdNbYFaj7p49Ks+4375Yn5LfDxQcqRITBlaenJlCNstM2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFqvBve9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C45C116D0;
	Sat, 28 Feb 2026 17:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300141;
	bh=CrjC/KEYRFs2Rg659n4xEZHkQ8osnrjx1QCXppF2yaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BFqvBve9xmjtnybtmgp9IUmAwXktUCR8xLmEF9/fQEEGnthYiL63G+G9BDNGfUNC9
	 M+XpOAejOC+XkDZzUI3BYb+oybHvS87yODZvXmnWUL4qGRo8GGa97cc/QekRT3lyfs
	 /Xg903rMgBHeDSEvTHc4vIG/IIAB+V/cZ/y49HZQ09XIHi5jUBkWhH/ByIetBkTJYX
	 3NUDiJ+6oNU6tCW92T9m1WEqZb/lm0sKe5M0x3rHjpo1lqaZISpsPse5+FGg+7VQ3g
	 iec7UTNgDhii4Tpru2nQ2pVol0GEzwSJbHx68Mq8vt4rxMeZVxRTWU37ayYhwcXJEd
	 ld4QCyxSbaMtA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tim Huang <tim.huang@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 159/844] drm/amdgpu: add support for HDP IP version 6.1.1
Date: Sat, 28 Feb 2026 12:21:12 -0500
Message-ID: <20260228173244.1509663-160-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220237-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 913B81C5E90
X-Rspamd-Action: no action

From: Tim Huang <tim.huang@amd.com>

[ Upstream commit e2fd14f579b841f54a9b7162fef15234d8c0627a ]

This initializes HDP IP version 6.1.1.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Tim Huang <tim.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index fa2a22dfa0487..f9e0e80c4c186 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -3059,6 +3059,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(6, 0, 0):
 	case IP_VERSION(6, 0, 1):
 	case IP_VERSION(6, 1, 0):
+	case IP_VERSION(6, 1, 1):
 		adev->hdp.funcs = &hdp_v6_0_funcs;
 		break;
 	case IP_VERSION(7, 0, 0):
-- 
2.51.0


