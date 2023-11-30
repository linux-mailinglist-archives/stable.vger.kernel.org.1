Return-Path: <stable+bounces-3337-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB047FF524
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 17:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 758CF2816B7
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 16:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061D054F8F;
	Thu, 30 Nov 2023 16:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gEAAbkQI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4D8524C2;
	Thu, 30 Nov 2023 16:26:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B59C433C7;
	Thu, 30 Nov 2023 16:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701361575;
	bh=0lqWnkp47QLvj7i0Aqe69x39WcgdOtla8M+/xg/K9sA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gEAAbkQIpjXjXXmtjayh+jtBOxz5dqKfRQeDuA9sN0khhMZjkeVOXnGwAm1SDZxlV
	 u9AsCvmd/qEyHJYfC8OasNjA/I0PLFv+15TWHLSTFqfJ4XqKmjhCVg3L+a3bGvXtw+
	 S7exsAU/SCDM14OLm2QqeFFbBdh6+fInUrC2u5s0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.6 076/112] platform/x86: hp-bioscfg: move mutex_lock() down in hp_add_other_attributes()
Date: Thu, 30 Nov 2023 16:22:03 +0000
Message-ID: <20231130162142.740489339@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231130162140.298098091@linuxfoundation.org>
References: <20231130162140.298098091@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

commit 5736aa9537c9b8927dec32d3d47c8c31fe560f62 upstream.

attr_name_kobj's memory allocation is done with mutex_lock() held, this
is not needed.

Move allocation outside of mutex_lock() so unlock is not needed when
allocation fails.

Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/20231113200742.3593548-2-harshit.m.mogalapalli@oracle.com
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

--- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
@@ -592,13 +592,11 @@ static int hp_add_other_attributes(int a
 	int ret;
 	char *attr_name;
 
-	mutex_lock(&bioscfg_drv.mutex);
-
 	attr_name_kobj = kzalloc(sizeof(*attr_name_kobj), GFP_KERNEL);
-	if (!attr_name_kobj) {
-		ret = -ENOMEM;
-		goto err_other_attr_init;
-	}
+	if (!attr_name_kobj)
+		return -ENOMEM;
+
+	mutex_lock(&bioscfg_drv.mutex);
 
 	/* Check if attribute type is supported */
 	switch (attr_type) {



