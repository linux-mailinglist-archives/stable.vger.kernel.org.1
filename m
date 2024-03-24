Return-Path: <stable+bounces-29764-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A20888774
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 03:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D512A1C268DF
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 02:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172C513BAE6;
	Sun, 24 Mar 2024 23:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRHGS0jV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7661A12BF1C;
	Sun, 24 Mar 2024 22:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321057; cv=none; b=cqLgAXwRb3QbGEzRMAqGEMkRAm2RqkjuF2siUmmaTmgHnN+2rufiM7Z6Lb71iAg12HQffiEfgCT5fEeoKdB13RvWFDhhV47z2RdoFPGCwAFggjQi/f94pGjibWbRvtpazpGQRSH6B7BBgLCWMiyzDfSupnN3nvqYTNHgwiFCjog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321057; c=relaxed/simple;
	bh=XJu2PDosWvo6ftdrnpc97k6E/frxFjZouHIAs4sPWt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U7Mez7C3SK84Jdrj9t4m26iYhnzw43Gx47L9NE+4DgcrEVzR4wjlyt+D4ntwp0iHkbEMitfZQ7GscSUifq/YkC8XWd0eMFKEPBJq90FCf5AfQF0qYWezXK2ZpghQr2sWutCcaQG+OX/vpIZmmnUo/eJsXUihVojDuLrsSXU26h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRHGS0jV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE7BC43394;
	Sun, 24 Mar 2024 22:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321056;
	bh=XJu2PDosWvo6ftdrnpc97k6E/frxFjZouHIAs4sPWt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FRHGS0jVUwnREUYmWHlGjuizapYnUumpp3TZ+9Ms8+rFIK2gr9hiKmqpYeurzfucG
	 7HYEjkra3Z+pwo6+C0gX9hERR2wUiTuXDZk0KVsmcpFleTGvggRlXfo/T6sn52QCjG
	 bcVhzSEQOYicr7K13kVdt9NDo9qZgQ2sP6pcRtEyPHaDnzk7Aq6qNcz2Us9Tmtfjpf
	 mkSkV9kkVilafZjuIxRR6wntXjWn5iGKtbb10z3xibwD8oWayCB+0yciC6HYLEKhrJ
	 5f4UbDhQhCCxfU1RSmzuFm1306GRGuJ3CjMZ/NoH3ZXMA6TSJmbPvJE0/FH5l00FYQ
	 Kf8KHmRkhPjvQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 620/713] remoteproc: stm32: Fix incorrect type assignment returned by stm32_rproc_get_loaded_rsc_tablef
Date: Sun, 24 Mar 2024 18:45:46 -0400
Message-ID: <20240324224720.1345309-621-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>

[ Upstream commit c77b35ce66af25bdd6fde60b62e35b9b316ea5c2 ]

The sparse tool complains about the remove of the _iomem attribute.

stm32_rproc.c:660:17: warning: cast removes address space '__iomem' of expression

Add '__force' to explicitly specify that the cast is intentional.
This conversion is necessary to cast to addresses pointer,
which are then managed by the remoteproc core as a pointer to a
resource_table structure.

Fixes: 8a471396d21c ("remoteproc: stm32: Move resource table setup to rproc_ops")
Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Link: https://lore.kernel.org/r/20240117135312.3381936-3-arnaud.pouliquen@foss.st.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/remoteproc/stm32_rproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index 2c28635219ebf..10b442c6f6323 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -657,7 +657,7 @@ stm32_rproc_get_loaded_rsc_table(struct rproc *rproc, size_t *table_sz)
 	 * entire area by overwriting it with the initial values stored in rproc->clean_table.
 	 */
 	*table_sz = RSC_TBL_SIZE;
-	return (struct resource_table *)ddata->rsc_va;
+	return (__force struct resource_table *)ddata->rsc_va;
 }
 
 static const struct rproc_ops st_rproc_ops = {
-- 
2.43.0


