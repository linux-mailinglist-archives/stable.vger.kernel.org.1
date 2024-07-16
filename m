Return-Path: <stable+bounces-60202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C88932DDA
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 18:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 183561F21835
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C69119B3E3;
	Tue, 16 Jul 2024 16:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ana6Z2uR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD531DDCE;
	Tue, 16 Jul 2024 16:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721146191; cv=none; b=E5evVwvROF/aL1oL+DSctxnDOi2yVXBWYsr4Qclay60CqNd1vjHVmmT3o50LM5fo71cvtSlchnNpZKMU11O/MbRkPC6r7hvxzAgVFdCsFXjV+725bM/uXIuNxlDrEGmd5tC46gx/Ekcwntp1CapxKwaZDvlgngurup29lDIfM5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721146191; c=relaxed/simple;
	bh=NGg73cMUeAFa8hdvGyZ/FmFSLbBSlB/b5V8/ObkNifI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AYvKnA2GZIed8MCD7LHVVNsXhbl7aox4BFXO5t97zfxeBe7lF7ZRLOr/RqC9EsuMkEcLxJ7OfEoi+r1DCcfA5jxnyN2zHSe5BbVYvum/ZZ4zLp7KBJ4wjw2LFOX6ndx87U9x7HLL6wHuMfg3uNtjDdlJ4bpvcY0wawnMKJTD0bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ana6Z2uR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A89C116B1;
	Tue, 16 Jul 2024 16:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721146191;
	bh=NGg73cMUeAFa8hdvGyZ/FmFSLbBSlB/b5V8/ObkNifI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ana6Z2uRz/9i+xbmhIc/DeX6IBamHMIAasUuVwfKo2dL09AUvUTUW3IPMsAgUbk5v
	 vOCcYFVhoAEx1pGb0kxGh3Xv8KzU2a9iJEd9ePFsF47eJzEoQEfsgj8APR7YAqn3rA
	 sW6KMePh8B1SG8bivA4L0DV5RzCoTmIdKo4124oU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aleksandr Mishin <amishin@t-argos.ru>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 085/144] octeontx2-af: Fix incorrect value output on error path in rvu_check_rsrc_availability()
Date: Tue, 16 Jul 2024 17:32:34 +0200
Message-ID: <20240716152755.809774004@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716152752.524497140@linuxfoundation.org>
References: <20240716152752.524497140@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aleksandr Mishin <amishin@t-argos.ru>

[ Upstream commit 442e26af9aa8115c96541026cbfeaaa76c85d178 ]

In rvu_check_rsrc_availability() in case of invalid SSOW req, an incorrect
data is printed to error log. 'req->sso' value is printed instead of
'req->ssow'. Looks like "copy-paste" mistake.

Fix this mistake by replacing 'req->sso' with 'req->ssow'.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 746ea74241fa ("octeontx2-af: Add RVU block LF provisioning support")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20240705095317.12640-1-amishin@t-argos.ru
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index bac42e0065c6c..bc8187e3f3393 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -1553,7 +1553,7 @@ static int rvu_check_rsrc_availability(struct rvu *rvu,
 		if (req->ssow > block->lf.max) {
 			dev_err(&rvu->pdev->dev,
 				"Func 0x%x: Invalid SSOW req, %d > max %d\n",
-				 pcifunc, req->sso, block->lf.max);
+				 pcifunc, req->ssow, block->lf.max);
 			return -EINVAL;
 		}
 		mappedlfs = rvu_get_rsrc_mapcount(pfvf, block->addr);
-- 
2.43.0




