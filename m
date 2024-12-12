Return-Path: <stable+bounces-103229-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 204319EF706
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 978CC189A947
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573CA20969B;
	Thu, 12 Dec 2024 17:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XAB5p45q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136B94F218;
	Thu, 12 Dec 2024 17:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734023933; cv=none; b=pvSb4qgQjWoAo5dXH0NW38XFv4iqijWGUcDxTSZt0uCJAHyuFA+xL5IDvv34f3LeAgRq6XRzqTTQODAPtJYlETAHmeBRqyQtGwP03dOSnGohbHCbbM3JXHLOmFFeJknMwrkgT70afb9/xomkJDAlN16MCDbF9APQpxAKRKckmPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734023933; c=relaxed/simple;
	bh=y6xWyawzO89VlN4T6+zlWksW2r7H2Zkp/ebWsdujaUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Upg65wMuOkGush4XByDmOspFA6rywyKesAh+EGQHHWsnrJSOT8UthcNludIt6I6DZsIHsK/FmVvxKKMB34j+2JsHX/fXhsoY8cb9lAffirGqanyhuzzSX13MevX6lmypPAmrDw91rzFoybbCAPOJmvxpsdk8O5e5lsnRly71N8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XAB5p45q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0073BC4CED0;
	Thu, 12 Dec 2024 17:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734023932;
	bh=y6xWyawzO89VlN4T6+zlWksW2r7H2Zkp/ebWsdujaUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XAB5p45qrlxMAZbTEDC+vkZrkLNCWMfyPXXdQ87L8rPQJzyWNXuZuPokcuRPDl5h/
	 Cia0JTPeiW1wUrNfho5KoY7+Meyej00w9s3H1Gl6zc5kn+2tRlVFqihnq/nZEltKuP
	 7xgPxDrLV4SYP46BjZCuC/uoil6lopbQf/yzK+80=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Steven Price <steven.price@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 131/459] drm/panfrost: Remove unused id_mask from struct panfrost_model
Date: Thu, 12 Dec 2024 15:57:49 +0100
Message-ID: <20241212144258.677985433@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144253.511169641@linuxfoundation.org>
References: <20241212144253.511169641@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Price <steven.price@arm.com>

[ Upstream commit 581d1f8248550f2b67847e6d84f29fbe3751ea0a ]

The id_mask field of struct panfrost_model has never been used.

Fixes: f3ba91228e8e ("drm/panfrost: Add initial panfrost driver")
Signed-off-by: Steven Price <steven.price@arm.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241025140008.385081-1-steven.price@arm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panfrost/panfrost_gpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
index 107ad2d764ec0..bff8cddfc7698 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
@@ -158,7 +158,6 @@ static void panfrost_gpu_init_quirks(struct panfrost_device *pfdev)
 struct panfrost_model {
 	const char *name;
 	u32 id;
-	u32 id_mask;
 	u64 features;
 	u64 issues;
 	struct {
-- 
2.43.0




