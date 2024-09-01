Return-Path: <stable+bounces-71868-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 572C496781E
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 18:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CC981F20EC6
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 16:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A97183CA3;
	Sun,  1 Sep 2024 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wKYsVjcp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AB744C97;
	Sun,  1 Sep 2024 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725208081; cv=none; b=hNIqjGQaPr8X/stmU26D3CNs2oQn+9G45zAjp7js1ag/JHX3tN/tAO/Jm3YZosCajdjy2Hk5u+0naIIyGk+zN3q/FQBrStL4MxwqNRrBPW+YTxAaoucuZ3Wd/zwob/DfPu89QbRqQQJSQ7p1okQHn+rknilw5VRs5lMvE/r0WWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725208081; c=relaxed/simple;
	bh=RKJ3XHwUXQ+CmqcZpe63lAx82aj8utuPy6sX5fuvBQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UAFfhg0AB5ey0w033dCgti/0CGOKbfIOvgiY4r+BEIk3hUDC7/EgpzfsQLnu0HAQCCFozJSk/r1wLM5GVbliCdSiMCfMG/XHhGvMcFiGAVz5eqz03wh/WxzDx6UNJWy6Xi8K04/OL1wc67pHpx3JIURbo2d1QmjyKJgw8hKB34k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wKYsVjcp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A25CC4CEC3;
	Sun,  1 Sep 2024 16:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725208081;
	bh=RKJ3XHwUXQ+CmqcZpe63lAx82aj8utuPy6sX5fuvBQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wKYsVjcpW0j1zXe7H8m97AW/Iq5SmvEcuUXHEY8B7O3KAXbkorZ0naUYU9cRDq31d
	 ly1fKg/A2ryzaqpbog+RVmVbCQIDNjQmcq3J+DgAuOsLHsMMcmo9+r/8d8hTcGyAz0
	 NKH/+myjogO2Crgl34eKsKgS6cpPIK54yNQKOMx8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 36/93] ovl: pass string to ovl_parse_layer()
Date: Sun,  1 Sep 2024 18:16:23 +0200
Message-ID: <20240901160808.718507154@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160807.346406833@linuxfoundation.org>
References: <20240901160807.346406833@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 7eff3453cbd7e0bfc7524d59694119b5ca844778 ]

So it can be used for parsing the Opt_lowerdir.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Link: https://lore.kernel.org/r/20240705011510.794025-2-chengzhihao1@huawei.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: ca76ac36bb60 ("ovl: fix wrong lowerdir number check for parameter Opt_lowerdir")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/params.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index 488f920f79d28..17b9c1838182d 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -369,10 +369,9 @@ static void ovl_add_layer(struct fs_context *fc, enum ovl_opt layer,
 	}
 }
 
-static int ovl_parse_layer(struct fs_context *fc, struct fs_parameter *param,
-			   enum ovl_opt layer)
+static int ovl_parse_layer(struct fs_context *fc, const char *layer_name, enum ovl_opt layer)
 {
-	char *name = kstrdup(param->string, GFP_KERNEL);
+	char *name = kstrdup(layer_name, GFP_KERNEL);
 	bool upper = (layer == Opt_upperdir || layer == Opt_workdir);
 	struct path path;
 	int err;
@@ -586,7 +585,7 @@ static int ovl_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	case Opt_datadir_add:
 	case Opt_upperdir:
 	case Opt_workdir:
-		err = ovl_parse_layer(fc, param, opt);
+		err = ovl_parse_layer(fc, param->string, opt);
 		break;
 	case Opt_default_permissions:
 		config->default_permissions = true;
-- 
2.43.0




