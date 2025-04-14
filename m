Return-Path: <stable+bounces-132515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F086A882DE
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 15:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED9043AA958
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26370292925;
	Mon, 14 Apr 2025 13:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrPY+ZhE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AC429291F;
	Mon, 14 Apr 2025 13:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637312; cv=none; b=aFBOcqQNrFCuQro/DXXT+EZw0dQF3zI764Wb7EcdoTisLe+QEZ/RHLeU1eld+grpiAsazykdos38Ogr+cZkldG7ryc7qGDQvNacJshMMfAsfNnA1VhefDHR3HDwB1i5ENOt+kGz/RYcUsGQPlz0xwChd1lqfXnOl7g51RTDbP7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637312; c=relaxed/simple;
	bh=gmCfe1COb9qkb2Vi9dOY8JKW+Czq0eYOsx8yhYbnm9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YYNid10yZKwRSDSWmQOvV74bF55/kUWruydXkFRsg1hPb5rpfOOcG4+FWsinmoocZuBp0AlKjRaRuFN+947t++XfWdaxbZINvXgXjp25MQNvWeLsiM/UcDO+qBo7IKqbt29SDgw8Mls8uAD8Cz53xcEoMwpnrWQco/TDPGAoE5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrPY+ZhE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59594C4CEE2;
	Mon, 14 Apr 2025 13:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637312;
	bh=gmCfe1COb9qkb2Vi9dOY8JKW+Czq0eYOsx8yhYbnm9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OrPY+ZhEW3+DOvf6b+ZXBq2xujvtr9QOi/DMVIw5HBIwks8O/GOTQwuDKhkfjqLkR
	 bIBXr6kgaw66fsgpWnCWNWzj6LFjK3lPWMmV3qqAvGzcf2Pgs3w87OhLue2XR1+TT2
	 xBUID10piJdhzeMr0l2f4uCibxGmYOeapH0pI9W41Xrpk9ZxL2fOFwufbXAPhVew7E
	 HKoZncVuhLoDtFCTLL6nW4KKkcNAp33V1TrcthpbI9G1vDZP4QeOMX5lyODTL1eOZ2
	 suRTDPhsiLBnwu292PbOvLM9qw2eTcO9GclnRoIXJmQ/Tpyd+VgivbrS8LFh4NK9sg
	 ksg5dOO3zNn1g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <wagi@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.13 27/34] nvmet-fc: put ref when assoc->del_work is already scheduled
Date: Mon, 14 Apr 2025 09:27:21 -0400
Message-Id: <20250414132729.679254-27-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132729.679254-1-sashal@kernel.org>
References: <20250414132729.679254-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.11
Content-Transfer-Encoding: 8bit

From: Daniel Wagner <wagi@kernel.org>

[ Upstream commit 70289ae5cac4d3a39575405aaf63330486cea030 ]

Do not leak the tgtport reference when the work is already scheduled.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/fc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index a3a6dfe98d6fc..0dfffb3f39b06 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1103,7 +1103,8 @@ static void
 nvmet_fc_schedule_delete_assoc(struct nvmet_fc_tgt_assoc *assoc)
 {
 	nvmet_fc_tgtport_get(assoc->tgtport);
-	queue_work(nvmet_wq, &assoc->del_work);
+	if (!queue_work(nvmet_wq, &assoc->del_work))
+		nvmet_fc_tgtport_put(assoc->tgtport);
 }
 
 static bool
-- 
2.39.5


