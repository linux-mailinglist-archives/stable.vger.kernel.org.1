Return-Path: <stable+bounces-133679-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD80A926D1
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5F9F8A684C
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACC424BBFD;
	Thu, 17 Apr 2025 18:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ozgotAjq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EA81CAA81;
	Thu, 17 Apr 2025 18:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744913809; cv=none; b=QIkoSbZ062HzZPR35ApCHkxib2TX2UrMuH/dGySmdYH40O/hgEaS/e/0mdq7NPcRhgQLn32B1EGKWEnPdjx1E45jPglhIGoymSmYUIWiNY1k3Zce9WyNcCh0P5oDgKaU1AvGXZ2jB15ZeCSE2JmPYYze20BiHOscQX+r/tFhIcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744913809; c=relaxed/simple;
	bh=2YoPahkv8HtX2kgVSolNY4lRUJmrci8fgTIoBsYDHxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T978g3RISIjVWcaTWYMeIvHgClaVqpj/hnCXCaZVnefkFMJzTNTQaNCcg6bOPQeLCeE9cMIUqUOjxdqpHIdqSdNLUVBucmBARw9Tclf+OQL8cw2wfUALNwuSXI8t/+ALZd9gGlgv8tfOUchKWJkrCoBuPpqClVRXkIB8wTmwtL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ozgotAjq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10EC2C4CEEA;
	Thu, 17 Apr 2025 18:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744913809;
	bh=2YoPahkv8HtX2kgVSolNY4lRUJmrci8fgTIoBsYDHxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ozgotAjq4xFCbBUKuhBllLeb/50rDil9ToF01js6gpVbWSo46ZAV8BWRwd93s+b3g
	 La8rC15OUbF6WIoMGKab/v0lSD3j6NNqGTGJvMldXy4URP/LPydWkrCQ5faKrHt/8f
	 qCSjSAug0WAo9fDEDwccNC3XhmnJ8QfNmTojohko=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 011/414] drm/xe: Restore EIO errno return when GuC PC start fails
Date: Thu, 17 Apr 2025 19:46:09 +0200
Message-ID: <20250417175111.859584300@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175111.386381660@linuxfoundation.org>
References: <20250417175111.386381660@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rodrigo Vivi <rodrigo.vivi@intel.com>

[ Upstream commit 88ecb66b9956a14577d513a6c8c28bb2e7989703 ]

Commit b4b05e53b550 ("drm/xe/guc_pc: Retry and wait longer for GuC PC
start"), leads to the following Smatch static checker warning:

        drivers/gpu/drm/xe/xe_guc_pc.c:1073 xe_guc_pc_start()
        warn: missing error code here? '_dev_err()' failed. 'ret' = '0'

Fixes: c605acb53f44 ("drm/xe/guc_pc: Retry and wait longer for GuC PC start")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/intel-xe/1454a5f1-ee18-4df1-a6b2-a4a3dddcd1cb@stanley.mountain/
Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
Link: https://lore.kernel.org/r/20250328181752.26677-1-rodrigo.vivi@intel.com
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
(cherry picked from commit 3f2bdccbccdcb53b0d316474eafff2e3462a51ad)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_guc_pc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/xe/xe_guc_pc.c b/drivers/gpu/drm/xe/xe_guc_pc.c
index 467d8a2879ecb..4933b8b672ec4 100644
--- a/drivers/gpu/drm/xe/xe_guc_pc.c
+++ b/drivers/gpu/drm/xe/xe_guc_pc.c
@@ -1019,6 +1019,7 @@ int xe_guc_pc_start(struct xe_guc_pc *pc)
 		if (wait_for_pc_state(pc, SLPC_GLOBAL_STATE_RUNNING,
 				      SLPC_RESET_EXTENDED_TIMEOUT_MS)) {
 			xe_gt_err(gt, "GuC PC Start failed: Dynamic GT frequency control and GT sleep states are now disabled.\n");
+			ret = -EIO;
 			goto out;
 		}
 
-- 
2.39.5




