Return-Path: <stable+bounces-153196-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B756ADD342
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 17:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19BE61898BE7
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 15:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AAB2F2C68;
	Tue, 17 Jun 2025 15:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OvAl+2I4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316DE2ECEA8;
	Tue, 17 Jun 2025 15:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175189; cv=none; b=ommo1LQBssCfjgp86P673P1iuMbKiW5YpzQmurq09h8j+QUNSzDHYElcNJ1OSOre0AEWuZ9bRwmNXrgz07ooxieZFHOoyc0N8RxRMrdXCSQ9IiLXlL2H08gTjX8K68LKZigVHTIjvL0AAInpooZz/XweIfmbvF/KkST3gG2/40U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175189; c=relaxed/simple;
	bh=lEhvI3hZ+uYl9FsrBle9peRbmbKDY0lXc4FEEUTBDS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s+7afF0P/xe3B1tT7u9lmPKamK8tPZkiUzV/Tsk0tziOggdq8f/Kkn2ybXBu8cifcJP+suhjdhfS25y01nmYrjdDXwdB+H3xsczPYvzUA4X1MoYCctzClBxylebr9wQzb5QT6vm/20L2q6vvq11q1DEDbralxKRVAade67lNHjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OvAl+2I4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65931C4CEF0;
	Tue, 17 Jun 2025 15:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750175188;
	bh=lEhvI3hZ+uYl9FsrBle9peRbmbKDY0lXc4FEEUTBDS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OvAl+2I4d83tdJFoT3w9VMwdJZFVYytQkw2xpdpECbExuMtUdidPxPlxTqAIoTYyz
	 Nk9QoXgBxs+8oEFhy7gIey/eIaIXHgOs2U5rvETzB/qT2ITCanfG2fRbRoNP9N6oCm
	 ZOemuhpppBBCP20MInuXXzyhAkbxrimGGmpnbkeE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 102/512] media: verisilicon: Free post processor buffers on error
Date: Tue, 17 Jun 2025 17:21:08 +0200
Message-ID: <20250617152423.730784025@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152419.512865572@linuxfoundation.org>
References: <20250617152419.512865572@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Detlev Casanova <detlev.casanova@collabora.com>

[ Upstream commit 11beb0fc346e00c412b3bfd19013206f6b655604 ]

During initialization, the post processor allocates the same number of
buffers as the buf queue.
As the init function is called in streamon(), if an allocation fails,
streamon will return an error and streamoff() will not be called, keeping
all post processor buffers allocated.

To avoid that, all post proc buffers are freed in case of an allocation
error.

Fixes: 26711491a807 ("media: verisilicon: Refactor postprocessor to store more buffers")
Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/verisilicon/hantro_postproc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/verisilicon/hantro_postproc.c b/drivers/media/platform/verisilicon/hantro_postproc.c
index 232c93eea7eea..18cad5ac92d8d 100644
--- a/drivers/media/platform/verisilicon/hantro_postproc.c
+++ b/drivers/media/platform/verisilicon/hantro_postproc.c
@@ -260,8 +260,10 @@ int hantro_postproc_init(struct hantro_ctx *ctx)
 
 	for (i = 0; i < num_buffers; i++) {
 		ret = hantro_postproc_alloc(ctx, i);
-		if (ret)
+		if (ret) {
+			hantro_postproc_free(ctx);
 			return ret;
+		}
 	}
 
 	return 0;
-- 
2.39.5




