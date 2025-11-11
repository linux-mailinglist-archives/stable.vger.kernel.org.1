Return-Path: <stable+bounces-193792-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B4917C4A908
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 02:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 93EF34F6CFA
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D93A2C026E;
	Tue, 11 Nov 2025 01:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hRa09VxG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF644263F28;
	Tue, 11 Nov 2025 01:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762824017; cv=none; b=eQ5iRYcqvVfFFlmzcXwpP7jEmnTU4TZOebLg75jpSXWjyA2QIhuO1ZSXrVzy+Qg3VmBBoa8t7VO0XgqHs1DB9vS098cvSLCSPRnMKMmNBju8KjlyYcSKamEcZmVHEjr93dMmaH3tDVS2GVGS0n/VyN2lmal4sd9xv/KYwb73eHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762824017; c=relaxed/simple;
	bh=oO1+po3YEyCmHUFNrEpyMh3OdTWyO5hlQlnVJaTwiQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VDUR2PdWvY9Mrwuw9JbbLjDC69CETN7HnfYV34SOf7fOQc5S19a8U/nXwMHJqIy5gHvdYzrHpym7BQaLWGA//+MLND/6UP9FeTPKKZ3GnBAUC1S/yVgizoaM3JkNrSk9Kc3aO34tIOK1ih3skt3HzTPYctYXgyIvrhTFnQQDw1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hRa09VxG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C569C16AAE;
	Tue, 11 Nov 2025 01:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762824017;
	bh=oO1+po3YEyCmHUFNrEpyMh3OdTWyO5hlQlnVJaTwiQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hRa09VxG7DyVPV8A33a96417Di6cEDvVkZmmASqZXJAtQW0DNsd7hK/1y6VjV3r7M
	 HmVXA66PX+xnpFe3kjYnOHqYo3p0nCdP6RxT+iBq/CiJ+5FvkNF4C83WRcKI9pDplO
	 IIHLav/NqFfNJhgUVDq0Lx/CMIZAeznDk/qSsXH8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhanjun Dong <zhanjun.dong@intel.com>,
	Stuart Summers <stuart.summers@intel.com>,
	John Harrison <John.C.Harrison@Intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 421/849] drm/xe/guc: Increase GuC crash dump buffer size
Date: Tue, 11 Nov 2025 09:39:51 +0900
Message-ID: <20251111004546.620000097@linuxfoundation.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111004536.460310036@linuxfoundation.org>
References: <20251111004536.460310036@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhanjun Dong <zhanjun.dong@intel.com>

[ Upstream commit ad83b1da5b786ee2d245e41ce55cb1c71fed7c22 ]

There are platforms already have a maximum dump size of 12KB, to avoid
data truncating, increase GuC crash dump buffer size to 16KB.

Signed-off-by: Zhanjun Dong <zhanjun.dong@intel.com>
Reviewed-by: Stuart Summers <stuart.summers@intel.com>
Signed-off-by: John Harrison <John.C.Harrison@Intel.com>
Link: https://lore.kernel.org/r/20250829160427.1245732-1-zhanjun.dong@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_guc_log.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_log.h b/drivers/gpu/drm/xe/xe_guc_log.h
index f1e2b0be90a9f..98a47ac42b08f 100644
--- a/drivers/gpu/drm/xe/xe_guc_log.h
+++ b/drivers/gpu/drm/xe/xe_guc_log.h
@@ -17,7 +17,7 @@ struct xe_device;
 #define DEBUG_BUFFER_SIZE       SZ_8M
 #define CAPTURE_BUFFER_SIZE     SZ_2M
 #else
-#define CRASH_BUFFER_SIZE	SZ_8K
+#define CRASH_BUFFER_SIZE	SZ_16K
 #define DEBUG_BUFFER_SIZE	SZ_64K
 #define CAPTURE_BUFFER_SIZE	SZ_1M
 #endif
-- 
2.51.0




