Return-Path: <stable+bounces-210077-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBEED33B38
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 18:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DA0E308558F
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 17:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8A5349AEB;
	Fri, 16 Jan 2026 17:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="piUo0hT7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EEA335542;
	Fri, 16 Jan 2026 17:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768583331; cv=none; b=Q/Qk7/CSsDlKIpM/R1srlieLH/1WOUbCH7UELCJyhryemcT1Haf4lo6IuaRueqWvA2+CnTbv41Q08AcKVDD0SFSFtqnMuHKOK59Zc4OWdSfTC/95A41nC870aEWyDCGgs67BzNsPNDpocnkCymLRlRrCukcD48oSu3wlDZiO98U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768583331; c=relaxed/simple;
	bh=l6jjbv4Gw+UHgNCx8/s2+5TGa+hKcw0BUb634x4fIrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X/bYUXmBdK99Nj8EV/K91FgcIDktVWXE79QLti8srHf1NcqURykJ56ooxKouq8hRnEDus/eYvxxr7aOGVe+/X0iLqiqu4upzHYH/SspStEDBf8qNpkFJkxuQETWkeMRHEgJvNM3fQ9rFM3Oz0SbL6mcr8V2sTU/PhVHOEt9N9Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=piUo0hT7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0673C116C6;
	Fri, 16 Jan 2026 17:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768583330;
	bh=l6jjbv4Gw+UHgNCx8/s2+5TGa+hKcw0BUb634x4fIrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=piUo0hT73W877r9lz+N9S8SpvHaiPUkdIQBAwVYw7rdXsPQeNl30jd0g0uWuxkDSA
	 PPH0ofYVMi6w+SpfyGY5zHCHQgL5uB4h85dA3nj4kazMZPEECiwQjmZQIKrNCsymc2
	 S1BNLexUUddLsbsCgMc7krxMbj6e9FPixQv7pA92cIbfr+4Hym/YALJYcMDk1bTfzW
	 DoUSf6t98laO8FTKoRE3R+CQPOp7zHxn1hrWaTOU1jB1c6spd1RP9JzcWvVWvb56Wq
	 7uJ2zIWiMaTj0lg/f18NJ/n/XVy999UkH4s70V4/mZtHvc4wuXJSUYANxPXOOledbF
	 3Zed/NjyhZYSA==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	stable@vger.kernel.org,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 1/4] nvmem: Drop OF node reference on nvmem_add_one_cell() failure
Date: Fri, 16 Jan 2026 17:08:43 +0000
Message-ID: <20260116170846.733558-2-srini@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260116170846.733558-1-srini@kernel.org>
References: <20260116170846.733558-1-srini@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

If nvmem_add_one_cell() failed, the ownership of "child" (or "info.np"),
thus its OF reference, is not passed further and function should clean
up by putting the reference it got via earlier of_node_get().  Note that
this is independent of references obtained via for_each_child_of_node()
loop.

Fixes: 50014d659617 ("nvmem: core: use nvmem_add_one_cell() in nvmem_add_cells_from_of()")
Cc: stable@vger.kernel.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
---
 drivers/nvmem/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 387c88c55259..ff68fd5ad3d6 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -831,6 +831,7 @@ static int nvmem_add_cells_from_dt(struct nvmem_device *nvmem, struct device_nod
 		kfree(info.name);
 		if (ret) {
 			of_node_put(child);
+			of_node_put(info.np);
 			return ret;
 		}
 	}
-- 
2.51.0


