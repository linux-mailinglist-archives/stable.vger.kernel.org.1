Return-Path: <stable+bounces-185690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D3CBDA501
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 17:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67AF85864EC
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 15:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DEE2FF16E;
	Tue, 14 Oct 2025 15:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTiEE37Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A7F3002DE
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 15:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760454749; cv=none; b=rmR/MYmOktAi+3URuDZCcT12x+Y4IGU0EEKr/56CYjuuha07PChMLHI18lTawHLwP3Ta6tzN3PJJLL269IJvXbH2Ho6sxcOW1NMnEKY3ioufh43zBDrsUt4wC771ttZAh27fMxIfCkEa/YjckQKNE6+AbdN2/Mk12k+C483W5iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760454749; c=relaxed/simple;
	bh=Kb1HqT99tJf1ah/kkEqIDgi2F2mX6Eei3t+yrCu7h+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IlSeMQCFM1jVdBrr4W2a5OdCrwRxDRtS5Yr5Jj+EEYO+1GN/K7ptbA0jTYyBJgbT0yPlTycO9Z7oeMWRmBfNiYFNq39ZdGOkux0cX7gP9ytE09Hf4KN+4cMHz2gH9yV6vCeLwzszL7kGzWcv6f7NWuGggvDZMS1+30vpPTS2rWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTiEE37Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC670C116D0;
	Tue, 14 Oct 2025 15:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760454748;
	bh=Kb1HqT99tJf1ah/kkEqIDgi2F2mX6Eei3t+yrCu7h+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QTiEE37ZEPSVpOxI/I8so0AkpmcwR2N5xjOevXUytZ06gIPmpHKbSEsyJNCvIzucy
	 C1hJVJyWQjw3aM210fkwXxuFA/7pL5Ws73KJYLp0AwrMtr3JevPPcX/fZXKxf2TjQY
	 HefI18dxz7JuizihfgHHPF7smbWe91pxGvqqr5NnCz68EsNDFJZyAJ7XZjBGMBl1T5
	 flOESDC+Cif3MUj5ArYoQop7UN4VHquWBq57DHBF/86ItbOXWiYN1fSdG/u9qnJtU0
	 KiUNjgCmMICdnpP7/5v8lDhM2vdKdaJ6MOc74N3vQf7VI9KAb3rDA4/lBEG4vsXGvg
	 JZWFnVawCdbhg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ekansh Gupta <quic_ekangupt@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] misc: fastrpc: Add missing dev_err newlines
Date: Tue, 14 Oct 2025 11:12:25 -0400
Message-ID: <20251014151226.111084-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101329-freestyle-unfair-5d44@gregkh>
References: <2025101329-freestyle-unfair-5d44@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ekansh Gupta <quic_ekangupt@quicinc.com>

[ Upstream commit a150c68ae6369ea65b786fefd0b8aa0b075c041a ]

Few dev_err calls are missing newlines. This can result in unrelated
lines getting appended which might make logs difficult to understand.
Add trailing newlines to avoid this.

Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20240705075900.424100-3-srinivas.kandagatla@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 8b5b456222fd ("misc: fastrpc: Save actual DMA size in fastrpc_map structure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/fastrpc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index fc021e265edc0..83f0f516a230b 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -325,7 +325,7 @@ static void fastrpc_free_map(struct kref *ref)
 			err = qcom_scm_assign_mem(map->phys, map->size,
 				&src_perms, &perm, 1);
 			if (err) {
-				dev_err(map->fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d",
+				dev_err(map->fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d\n",
 						map->phys, map->size, err);
 				return;
 			}
@@ -816,7 +816,7 @@ static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
 		map->attr = attr;
 		err = qcom_scm_assign_mem(map->phys, (u64)map->size, &src_perms, dst_perms, 2);
 		if (err) {
-			dev_err(sess->dev, "Failed to assign memory with phys 0x%llx size 0x%llx err %d",
+			dev_err(sess->dev, "Failed to assign memory with phys 0x%llx size 0x%llx err %d\n",
 					map->phys, map->size, err);
 			goto map_err;
 		}
@@ -1222,7 +1222,7 @@ static bool is_session_rejected(struct fastrpc_user *fl, bool unsigned_pd_reques
 		 * that does not support unsigned PD offload
 		 */
 		if (!fl->cctx->unsigned_support || !unsigned_pd_request) {
-			dev_err(&fl->cctx->rpdev->dev, "Error: Untrusted application trying to offload to signed PD");
+			dev_err(&fl->cctx->rpdev->dev, "Error: Untrusted application trying to offload to signed PD\n");
 			return true;
 		}
 	}
@@ -1286,7 +1286,7 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 							&src_perms,
 							fl->cctx->vmperms, fl->cctx->vmcount);
 			if (err) {
-				dev_err(fl->sctx->dev, "Failed to assign memory with phys 0x%llx size 0x%llx err %d",
+				dev_err(fl->sctx->dev, "Failed to assign memory with phys 0x%llx size 0x%llx err %d\n",
 					fl->cctx->remote_heap->phys, fl->cctx->remote_heap->size, err);
 				goto err_map;
 			}
@@ -1340,7 +1340,7 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 						(u64)fl->cctx->remote_heap->size,
 						&src_perms, &dst_perms, 1);
 		if (err)
-			dev_err(fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d",
+			dev_err(fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d\n",
 				fl->cctx->remote_heap->phys, fl->cctx->remote_heap->size, err);
 	}
 err_map:
-- 
2.51.0


