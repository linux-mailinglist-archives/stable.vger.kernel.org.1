Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650E47831F4
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjHUUAf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjHUUAe (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:00:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D224128
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:00:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5672616BF
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:00:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59B8C433C8;
        Mon, 21 Aug 2023 20:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648032;
        bh=MdyfqOmuPWnzpiLIVcpYZXTnGpDOPwAR9VD1c3p+1ng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=esPuXyCcrjQVdsphSjtki5QmJIKdIZjrHZ5azgwi2c28819C1l21CkFHpiJ5gO1KV
         HGTaAZsbMkfBLyc13dB83uodx4NOs/UoXP6EsDeJgCaLj/iQ0OrVu0h213DbtBqy07
         RYfx57IYp+05o92Xmhs2btcINw5eIO7/NORnzmi0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Danilo Krummrich <dakr@redhat.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 005/234] drm/scheduler: set entity to NULL in drm_sched_entity_pop_job()
Date:   Mon, 21 Aug 2023 21:39:28 +0200
Message-ID: <20230821194128.985994967@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Danilo Krummrich <dakr@redhat.com>

[ Upstream commit 96c7c2f4d5bd94b15fe63448c087f01607b56f4a ]

It already happend a few times that patches slipped through which
implemented access to an entity through a job that was already removed
from the entities queue. Since jobs and entities might have different
lifecycles, this can potentially cause UAF bugs.

In order to make it obvious that a jobs entity pointer shouldn't be
accessed after drm_sched_entity_pop_job() was called successfully, set
the jobs entity pointer to NULL once the job is removed from the entity
queue.

Moreover, debugging a potential NULL pointer dereference is way easier
than potentially corrupted memory through a UAF.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
Link: https://lore.kernel.org/r/20230418100453.4433-1-dakr@redhat.com
Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 6 ++++++
 drivers/gpu/drm/scheduler/sched_main.c   | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index e0a8890a62e23..3e2a31d8190eb 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -448,6 +448,12 @@ struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_entity *entity)
 			drm_sched_rq_update_fifo(entity, next->submit_ts);
 	}
 
+	/* Jobs and entities might have different lifecycles. Since we're
+	 * removing the job from the entities queue, set the jobs entity pointer
+	 * to NULL to prevent any future access of the entity through this job.
+	 */
+	sched_job->entity = NULL;
+
 	return sched_job;
 }
 
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index aea5a90ff98b9..cdd67676c3d1b 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -42,6 +42,10 @@
  *    the hardware.
  *
  * The jobs in a entity are always scheduled in the order that they were pushed.
+ *
+ * Note that once a job was taken from the entities queue and pushed to the
+ * hardware, i.e. the pending queue, the entity must not be referenced anymore
+ * through the jobs entity pointer.
  */
 
 #include <linux/kthread.h>
-- 
2.40.1



