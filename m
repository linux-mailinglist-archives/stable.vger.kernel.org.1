Return-Path: <stable+bounces-54929-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A65B9913B49
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 15:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6619F1F2126F
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 13:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E781953B9;
	Sun, 23 Jun 2024 13:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JiTTRBK1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E81919539C;
	Sun, 23 Jun 2024 13:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719150313; cv=none; b=EB/0mBfqR+0TsfOcIQEaU4TcQ/AMLCPAiLISJTigZv5w2nTjLId/FlLHXAJKsEN3Hq8jITQa17zt8LHurNQ6U2hs4FQYSy6PUO7aFXcpSEYOBwBL9u481mdgJDEzBuSU1jvSpZGSXGwRkPxBoAm+d+qL8lpPK8nfQLJYzbd9xfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719150313; c=relaxed/simple;
	bh=jfD2PNEkrS+fDZi07jI99v1JjwCHIEfQ7QfBaONYNzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gRZT2XxQ+ju4cS174vKceM0z+u9Wp7gzbeK/I/KBQhRqE6c7UvH7yAaLghy5p/Vq+eR9/L89+482NDuDbqSrx3yxDKlBaG7amRigYUOyCPzMBUTWtkfKyl/5HEHwWybJbMLx5C/9xCcPqAzLe3RWIkJGrf/mO+awhZTmWE58cL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JiTTRBK1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E58CC2BD10;
	Sun, 23 Jun 2024 13:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719150313;
	bh=jfD2PNEkrS+fDZi07jI99v1JjwCHIEfQ7QfBaONYNzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JiTTRBK17kgmf/uzmPIlwtKGQTJRpVdm9K1h3hG4hI3xD0m7clabuH3julzm5WWnI
	 jVOqM+Qzq51sRnsrjVaKi4+jUEVSV1jDIYLG7p67U8J39LNnZMsbxpNgA36ZhD4zQR
	 D9i+PwjWX/Y9YaLf5gXrBOpDIE3hu59UM3RJIdNRJN6IjCb1APnH9pvdEKej1hhYyB
	 QczxNKmzoVJwnFwiF4UnV8rWEVyaw4IBhcEE9nAOUQ6F8iAoSUNymTWUFvExPTrZxu
	 HKCvKDI5b7quhPXTzZADLLfA6vr5jRmwPFEqy6xuR+XOs1wGwikmphugXoQYmveo1Q
	 5xWQzgSXbOiXg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chunguang Xu <chunguang.xu@shopee.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 15/16] nvme: avoid double free special payload
Date: Sun, 23 Jun 2024 09:44:44 -0400
Message-ID: <20240623134448.809470-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240623134448.809470-1-sashal@kernel.org>
References: <20240623134448.809470-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.35
Content-Transfer-Encoding: 8bit

From: Chunguang Xu <chunguang.xu@shopee.com>

[ Upstream commit e5d574ab37f5f2e7937405613d9b1a724811e5ad ]

If a discard request needs to be retried, and that retry may fail before
a new special payload is added, a double free will result. Clear the
RQF_SPECIAL_LOAD when the request is cleaned.

Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 94a0916f9cb78..e969da0a681b4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -938,6 +938,7 @@ void nvme_cleanup_cmd(struct request *req)
 			clear_bit_unlock(0, &ctrl->discard_page_busy);
 		else
 			kfree(bvec_virt(&req->special_vec));
+		req->rq_flags &= ~RQF_SPECIAL_PAYLOAD;
 	}
 }
 EXPORT_SYMBOL_GPL(nvme_cleanup_cmd);
-- 
2.43.0


