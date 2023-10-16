Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12EE67CAC16
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbjJPOtT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbjJPOtS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:49:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FB5B9
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:49:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69AFC433C8;
        Mon, 16 Oct 2023 14:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697467755;
        bh=VzLtqRqUP5mnz63e2uZ8sM32d1Zgr/dYpqsfSvKDUI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pw4Di8NBaaqTSwSVEGUcPJf6WMZyEQz1ACSWtWLrHjmNBYf02xlia+qPBOErdRbEt
         voAWJL8njTPMTkQET2VxmLeJIv8hPZgnIdrN+yCeV3irS5giu4F0DPiVK3XYAiGWnz
         9EJtF+9SOAvrkGAXawMDh4Pfa37jW8HSwCOTcjt4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Moshe Shemesh <moshe@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 059/191] devlink: Hold devlink lock on health reporter dump get
Date:   Mon, 16 Oct 2023 10:40:44 +0200
Message-ID: <20231016084016.779892459@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Moshe Shemesh <moshe@nvidia.com>

[ Upstream commit aba0e909dc20eceb1de985474af459f82e7b0b82 ]

Devlink health dump get callback should take devlink lock as any other
devlink callback. Otherwise, since devlink_mutex was removed, this
callback is not protected from a race of the reporter being destroyed
while handling the callback.

Add devlink lock to the callback and to any call for
devlink_health_do_dump(). This should be safe as non of the drivers dump
callback implementation takes devlink lock.

As devlink lock is added to any callback of dump, the reporter dump_lock
is now redundant and can be removed.

Fixes: d3efc2a6a6d8 ("net: devlink: remove devlink_mutex")
Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Link: https://lore.kernel.org/r/1696510216-189379-1-git-send-email-moshe@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/devlink/health.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/net/devlink/health.c b/net/devlink/health.c
index 194340a8bb863..8c6a2e5140d4d 100644
--- a/net/devlink/health.c
+++ b/net/devlink/health.c
@@ -58,7 +58,6 @@ struct devlink_health_reporter {
 	struct devlink *devlink;
 	struct devlink_port *devlink_port;
 	struct devlink_fmsg *dump_fmsg;
-	struct mutex dump_lock; /* lock parallel read/write from dump buffers */
 	u64 graceful_period;
 	bool auto_recover;
 	bool auto_dump;
@@ -125,7 +124,6 @@ __devlink_health_reporter_create(struct devlink *devlink,
 	reporter->graceful_period = graceful_period;
 	reporter->auto_recover = !!ops->recover;
 	reporter->auto_dump = !!ops->dump;
-	mutex_init(&reporter->dump_lock);
 	return reporter;
 }
 
@@ -226,7 +224,6 @@ EXPORT_SYMBOL_GPL(devlink_health_reporter_create);
 static void
 devlink_health_reporter_free(struct devlink_health_reporter *reporter)
 {
-	mutex_destroy(&reporter->dump_lock);
 	if (reporter->dump_fmsg)
 		devlink_fmsg_free(reporter->dump_fmsg);
 	kfree(reporter);
@@ -609,10 +606,10 @@ int devlink_health_report(struct devlink_health_reporter *reporter,
 	}
 
 	if (reporter->auto_dump) {
-		mutex_lock(&reporter->dump_lock);
+		devl_lock(devlink);
 		/* store current dump of current error, for later analysis */
 		devlink_health_do_dump(reporter, priv_ctx, NULL);
-		mutex_unlock(&reporter->dump_lock);
+		devl_unlock(devlink);
 	}
 
 	if (!reporter->auto_recover)
@@ -1246,7 +1243,7 @@ int devlink_nl_cmd_health_reporter_diagnose_doit(struct sk_buff *skb,
 }
 
 static struct devlink_health_reporter *
-devlink_health_reporter_get_from_cb(struct netlink_callback *cb)
+devlink_health_reporter_get_from_cb_lock(struct netlink_callback *cb)
 {
 	const struct genl_dumpit_info *info = genl_dumpit_info(cb);
 	struct devlink_health_reporter *reporter;
@@ -1256,10 +1253,12 @@ devlink_health_reporter_get_from_cb(struct netlink_callback *cb)
 	devlink = devlink_get_from_attrs_lock(sock_net(cb->skb->sk), attrs);
 	if (IS_ERR(devlink))
 		return NULL;
-	devl_unlock(devlink);
 
 	reporter = devlink_health_reporter_get_from_attrs(devlink, attrs);
-	devlink_put(devlink);
+	if (!reporter) {
+		devl_unlock(devlink);
+		devlink_put(devlink);
+	}
 	return reporter;
 }
 
@@ -1268,16 +1267,20 @@ int devlink_nl_cmd_health_reporter_dump_get_dumpit(struct sk_buff *skb,
 {
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
 	struct devlink_health_reporter *reporter;
+	struct devlink *devlink;
 	int err;
 
-	reporter = devlink_health_reporter_get_from_cb(cb);
+	reporter = devlink_health_reporter_get_from_cb_lock(cb);
 	if (!reporter)
 		return -EINVAL;
 
-	if (!reporter->ops->dump)
+	devlink = reporter->devlink;
+	if (!reporter->ops->dump) {
+		devl_unlock(devlink);
+		devlink_put(devlink);
 		return -EOPNOTSUPP;
+	}
 
-	mutex_lock(&reporter->dump_lock);
 	if (!state->idx) {
 		err = devlink_health_do_dump(reporter, NULL, cb->extack);
 		if (err)
@@ -1293,7 +1296,8 @@ int devlink_nl_cmd_health_reporter_dump_get_dumpit(struct sk_buff *skb,
 	err = devlink_fmsg_dumpit(reporter->dump_fmsg, skb, cb,
 				  DEVLINK_CMD_HEALTH_REPORTER_DUMP_GET);
 unlock:
-	mutex_unlock(&reporter->dump_lock);
+	devl_unlock(devlink);
+	devlink_put(devlink);
 	return err;
 }
 
@@ -1310,9 +1314,7 @@ int devlink_nl_cmd_health_reporter_dump_clear_doit(struct sk_buff *skb,
 	if (!reporter->ops->dump)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&reporter->dump_lock);
 	devlink_health_dump_clear(reporter);
-	mutex_unlock(&reporter->dump_lock);
 	return 0;
 }
 
-- 
2.40.1



