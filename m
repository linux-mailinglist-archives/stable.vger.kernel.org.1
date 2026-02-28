Return-Path: <stable+bounces-220246-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MKOABUyo2kE+QQAu9opvQ
	(envelope-from <stable+bounces-220246-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:21:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 905D61C5B1A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DCB9031D3ABB
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC0A373C1B;
	Sat, 28 Feb 2026 17:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDorU3Un"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A36373C0F;
	Sat, 28 Feb 2026 17:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300150; cv=none; b=kwbvHPgQylXBRl7OgjCOP8siStLRCki8fphAGr1tJJjWwxUJ694NZD9rr/BSM5l6dgJ0r6F79ZOckGQSPqR85wCI9brEQRuP+mgIQxHTOUllJCdOhucikyF4mxNkMJtwrZPB77B6uP33qOkIBMqJEZLneLeyL4GID6xPbCq8Cl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300150; c=relaxed/simple;
	bh=cLAisaLoAcnoaoTX3ZrNJXG1gYgYHnAZhB+sh2Pe5r8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bVbCEk+JCNlNiYCpg8bzYwUG1+DVBjz/yfOUC8QRB/eYFySUAVea3G8ecS3mu8XUTXP5lT/8WXkztpR3FzgYppzeZvMcxardxIP4WTEHleU66dsQD6vq6jNHFjkTxsxKJLvVXrsqI3tBn/6CUXe6ZCzTuQqOa3dTzzklhEVyB1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDorU3Un; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EFF2C19424;
	Sat, 28 Feb 2026 17:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300150;
	bh=cLAisaLoAcnoaoTX3ZrNJXG1gYgYHnAZhB+sh2Pe5r8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LDorU3UnyUEDj8/NE2X1+ihuC7jIDtPMwm2KIvFQ+AoVTmtbItyJNoTKlZQQQFyDB
	 du7VmO9RlaiCCsiSMoC18gFpEB/A421/PVaP2jvo9dBVMCwvHRVqeoY6Uyk3rPegQ9
	 KQT9D4o+RryeOUC0EPtzFBJ3pQmfCy5ayVuwNgFefzyDg2p84MrJASccKq62fA4R2m
	 AvzjgyIrFRlXkxIISlRCxM+kmbam8vYCxiMqc96jZOE/VPKqGkJYPqT/L97IU85leQ
	 O6xIAvMIU0+W2HQ3yr+e4EjJe2vC2/1tYFnbEXyjd+5WTfmO7qdT6HrWixxHDpUjVX
	 ryX0po319N30A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: YuBiao Wang <YuBiao.Wang@amd.com>,
	Victor Skvortsov <Victor.Skvortsov@amd.com>,
	Gavin Wan <gavin.wan@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 168/844] drm/amdgpu: Skip loading SDMA_RS64 in VF
Date: Sat, 28 Feb 2026 12:21:21 -0500
Message-ID: <20260228173244.1509663-169-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220246-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 905D61C5B1A
X-Rspamd-Action: no action

From: YuBiao Wang <YuBiao.Wang@amd.com>

[ Upstream commit 39c21b81112321cbe1267b02c77ecd2161ce19aa ]

VFs use the PF SDMA ucode and are unable to load SDMA_RS64.

Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
Signed-off-by: Victor Skvortsov <Victor.Skvortsov@amd.com>
Reviewed-by: Gavin Wan <gavin.wan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 47a6ce4fdc744..292e2706286a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -1261,6 +1261,7 @@ bool amdgpu_virt_fw_load_skip_check(struct amdgpu_device *adev, uint32_t ucode_i
 		    || ucode_id == AMDGPU_UCODE_ID_SDMA5
 		    || ucode_id == AMDGPU_UCODE_ID_SDMA6
 		    || ucode_id == AMDGPU_UCODE_ID_SDMA7
+		    || ucode_id == AMDGPU_UCODE_ID_SDMA_RS64
 		    || ucode_id == AMDGPU_UCODE_ID_RLC_G
 		    || ucode_id == AMDGPU_UCODE_ID_RLC_RESTORE_LIST_CNTL
 		    || ucode_id == AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM_MEM
-- 
2.51.0


