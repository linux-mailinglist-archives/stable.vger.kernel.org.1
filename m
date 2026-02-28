Return-Path: <stable+bounces-220544-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFhPCfg5o2mU+gQAu9opvQ
	(envelope-from <stable+bounces-220544-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:54:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C421C6644
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B007933C08E0
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C003D245C;
	Sat, 28 Feb 2026 17:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPZPSa+h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B1B3D2452;
	Sat, 28 Feb 2026 17:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300427; cv=none; b=SIXah/L+4WzsCPN61+hXgXwnfvRXdR2l+indB+c1v/zDJZ4EZflohsRZauju/7l92k1IX7dQ2G1ZKY5qLBJnSWu+q39UQm6r+VCeBop6d08DhY0mb2chDOjp04NxmByAFNqOyShJ0LLGs8VKBXhSJgvAdEm7xhd72yIgPkMDI2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300427; c=relaxed/simple;
	bh=dLPGJNofiRNB53LoWfuvKRZy9fh8nZFlbeV2LQiNivc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p1oQbHN9x9X/wKbPoBYZpgBaPqBjEzxS+vZDlHD9PRXb8YE5nTzqqkVqR/tJXi1tRq2Hb5ZZwHRq6scS5HpNROU2z3QrnQ4KK4dlNyKQ2eKnI2HspmaL7HvF9mtsT89tr1UHder/9LI7bi8kFzNVceaCKH7RPZT4ozHYt8vwylA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPZPSa+h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C5BC116D0;
	Sat, 28 Feb 2026 17:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300427;
	bh=dLPGJNofiRNB53LoWfuvKRZy9fh8nZFlbeV2LQiNivc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XPZPSa+hPDPro9iRvtV+yl2Mxx8Ir0G30tVjNlSge69z1An9pIUZYQGO0148H3azO
	 9Vqk3Y2mLhLL7Eskrp2bDYIOzm6z8c4m6Qbnho2tThgmJegZP3Vpw+0GSzSyabp0kH
	 pohbsmMJQ6XDk6DGul3XQeLbjV7PHcRDQEYpaspRAgACgnMz+2FUyKD9dm0NK93X5C
	 2tcxzrNZcRbYf8MVCKByblMCm0g4HfJaikEWQZ/xKIf2BCtw7HDyr4L2wM179m0XI1
	 /XEY1RAeKvf3dDTul6tL0XUmVCXFyV6D0CFGtzlFMS7bUvpKSA2aiD0/bzoRTx3ZoH
	 qnfEJ8sQucwQA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiri Pirko <jiri@nvidia.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 465/844] dma-mapping: avoid random addr value print out on error path
Date: Sat, 28 Feb 2026 12:26:18 -0500
Message-ID: <20260228173244.1509663-466-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220544-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 92C421C6644
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

[ Upstream commit 47322c469d4a63ac45b705ca83680671ff71c975 ]

dma_addr is unitialized in dma_direct_map_phys() when swiotlb is forced
and DMA_ATTR_MMIO is set which leads to random value print out in
warning. Fix that by just returning DMA_MAPPING_ERROR.

Fixes: e53d29f957b3 ("dma-mapping: convert dma_direct_*map_page to be phys_addr_t based")
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Link: https://lore.kernel.org/r/20260209153809.250835-2-jiri@resnulli.us
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/direct.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
index da2fadf45bcd6..62f0d9d0ba02e 100644
--- a/kernel/dma/direct.h
+++ b/kernel/dma/direct.h
@@ -88,7 +88,7 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
 
 	if (is_swiotlb_force_bounce(dev)) {
 		if (attrs & DMA_ATTR_MMIO)
-			goto err_overflow;
+			return DMA_MAPPING_ERROR;
 
 		return swiotlb_map(dev, phys, size, dir, attrs);
 	}
-- 
2.51.0


