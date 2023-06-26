Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD5173E999
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbjFZShv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbjFZShu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:37:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3423AAC
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:37:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD8AD60F3E
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:37:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C685BC433C8;
        Mon, 26 Jun 2023 18:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804669;
        bh=fu9TykgKigfM0LbtTAtm/eDYH/TVPGk6gMDOb/KrQ5A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qDjYErKgJpcYm7I813hJCZ119iRqPulKxxqF9Tx8WOf4fjuOJJhOVDHszbOjrs3P7
         lcUMB/5+oOcxX+c7RkvLpZV9/7mlTwUlkN+A1WUN3SMQfejwFj50Y/SJEDkVomAgt2
         8UDVgUv1lCJB4yfqpXZJiWB4QHqAbJ5P4I3mM+wk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Min Li <lm0963hack@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 55/60] drm/radeon: fix race condition UAF in radeon_gem_set_domain_ioctl
Date:   Mon, 26 Jun 2023 20:12:34 +0200
Message-ID: <20230626180741.817165267@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180739.558575012@linuxfoundation.org>
References: <20230626180739.558575012@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Min Li <lm0963hack@gmail.com>

[ Upstream commit 982b173a6c6d9472730c3116051977e05d17c8c5 ]

Userspace can race to free the gobj(robj converted from), robj should not
be accessed again after drm_gem_object_put, otherwith it will result in
use-after-free.

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Min Li <lm0963hack@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/radeon/radeon_gem.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/radeon_gem.c
index b2b076606f54b..e164b3c7a234f 100644
--- a/drivers/gpu/drm/radeon/radeon_gem.c
+++ b/drivers/gpu/drm/radeon/radeon_gem.c
@@ -384,7 +384,6 @@ int radeon_gem_set_domain_ioctl(struct drm_device *dev, void *data,
 	struct radeon_device *rdev = dev->dev_private;
 	struct drm_radeon_gem_set_domain *args = data;
 	struct drm_gem_object *gobj;
-	struct radeon_bo *robj;
 	int r;
 
 	/* for now if someone requests domain CPU -
@@ -397,13 +396,12 @@ int radeon_gem_set_domain_ioctl(struct drm_device *dev, void *data,
 		up_read(&rdev->exclusive_lock);
 		return -ENOENT;
 	}
-	robj = gem_to_radeon_bo(gobj);
 
 	r = radeon_gem_set_domain(gobj, args->read_domains, args->write_domain);
 
 	drm_gem_object_put_unlocked(gobj);
 	up_read(&rdev->exclusive_lock);
-	r = radeon_gem_handle_lockup(robj->rdev, r);
+	r = radeon_gem_handle_lockup(rdev, r);
 	return r;
 }
 
-- 
2.39.2



