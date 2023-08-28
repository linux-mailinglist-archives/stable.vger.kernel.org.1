Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44EFE78AC4E
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjH1Ki5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjH1KiV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:38:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E792C5
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:38:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0714F615E1
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:38:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB21C433C7;
        Mon, 28 Aug 2023 10:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219090;
        bh=ZTw0b3VnDnMRzgf7NIg5APorRhd6+sZwXkM09Fqu4EE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uM3iV5Ttk6twX0i/RHKUtka0qC6GAqsIleJ45d1bhjg25O3OLE5GngWKraZB61wCn
         NYVP4Qw2C+7CLwbFLpoJu+/IBwstV03raKdzpvR2SNiVpexG8a7Kot8p0wel9XQzmL
         HwDrvnU3bQV+8eV+1BuIFaWqWVo3ZZerMLbk8VS0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Evan Green <evgreen@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 041/158] interconnect: Add helpers for enabling/disabling a path
Date:   Mon, 28 Aug 2023 12:12:18 +0200
Message-ID: <20230828101158.718283942@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.322319621@linuxfoundation.org>
References: <20230828101157.322319621@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Georgi Djakov <georgi.djakov@linaro.org>

[ Upstream commit 7d374b20908338c9fbb03ea8022a11f3b3e0e55f ]

There is a repeated pattern in multiple drivers where they want to switch
the bandwidth between zero and some other value. This is happening often
in the suspend/resume callbacks. Let's add helper functions to enable and
disable the path, so that callers don't have to take care of remembering
the bandwidth values and handle this in the framework instead.

With this patch the users can call icc_disable() and icc_enable() to lower
their bandwidth request to zero and then restore it back to it's previous
value.

Suggested-by: Evan Green <evgreen@chromium.org>
Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Link: https://lore.kernel.org/r/20200507120846.8354-1-georgi.djakov@linaro.org
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
Stable-dep-of: d2d69354226d ("USB: dwc3: qcom: fix NULL-deref on suspend")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/interconnect/core.c     | 39 ++++++++++++++++++++++++++++++++-
 drivers/interconnect/internal.h |  2 ++
 include/linux/interconnect.h    | 12 ++++++++++
 3 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 25dd8a19139a7..112298100d370 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -91,6 +91,7 @@ static struct icc_path *path_init(struct device *dev, struct icc_node *dst,
 		hlist_add_head(&path->reqs[i].req_node, &node->req_list);
 		path->reqs[i].node = node;
 		path->reqs[i].dev = dev;
+		path->reqs[i].enabled = true;
 		/* reference to previous node was saved during path traversal */
 		node = node->reverse;
 	}
@@ -182,9 +183,12 @@ static int aggregate_requests(struct icc_node *node)
 	if (p->pre_aggregate)
 		p->pre_aggregate(node);
 
-	hlist_for_each_entry(r, &node->req_list, req_node)
+	hlist_for_each_entry(r, &node->req_list, req_node) {
+		if (!r->enabled)
+			continue;
 		p->aggregate(node, r->tag, r->avg_bw, r->peak_bw,
 			     &node->avg_bw, &node->peak_bw);
+	}
 
 	return 0;
 }
@@ -449,6 +453,39 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
 }
 EXPORT_SYMBOL_GPL(icc_set_bw);
 
+static int __icc_enable(struct icc_path *path, bool enable)
+{
+	int i;
+
+	if (!path)
+		return 0;
+
+	if (WARN_ON(IS_ERR(path) || !path->num_nodes))
+		return -EINVAL;
+
+	mutex_lock(&icc_lock);
+
+	for (i = 0; i < path->num_nodes; i++)
+		path->reqs[i].enabled = enable;
+
+	mutex_unlock(&icc_lock);
+
+	return icc_set_bw(path, path->reqs[0].avg_bw,
+			  path->reqs[0].peak_bw);
+}
+
+int icc_enable(struct icc_path *path)
+{
+	return __icc_enable(path, true);
+}
+EXPORT_SYMBOL_GPL(icc_enable);
+
+int icc_disable(struct icc_path *path)
+{
+	return __icc_enable(path, false);
+}
+EXPORT_SYMBOL_GPL(icc_disable);
+
 /**
  * icc_get() - return a handle for path between two endpoints
  * @dev: the device requesting the path
diff --git a/drivers/interconnect/internal.h b/drivers/interconnect/internal.h
index 5853e8faf223a..5c923c444f444 100644
--- a/drivers/interconnect/internal.h
+++ b/drivers/interconnect/internal.h
@@ -14,6 +14,7 @@
  * @req_node: entry in list of requests for the particular @node
  * @node: the interconnect node to which this constraint applies
  * @dev: reference to the device that sets the constraints
+ * @enabled: indicates whether the path with this request is enabled
  * @tag: path tag (optional)
  * @avg_bw: an integer describing the average bandwidth in kBps
  * @peak_bw: an integer describing the peak bandwidth in kBps
@@ -22,6 +23,7 @@ struct icc_req {
 	struct hlist_node req_node;
 	struct icc_node *node;
 	struct device *dev;
+	bool enabled;
 	u32 tag;
 	u32 avg_bw;
 	u32 peak_bw;
diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
index d70a914cba118..1e0dd0541b1ed 100644
--- a/include/linux/interconnect.h
+++ b/include/linux/interconnect.h
@@ -29,6 +29,8 @@ struct icc_path *icc_get(struct device *dev, const int src_id,
 			 const int dst_id);
 struct icc_path *of_icc_get(struct device *dev, const char *name);
 void icc_put(struct icc_path *path);
+int icc_enable(struct icc_path *path);
+int icc_disable(struct icc_path *path);
 int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw);
 void icc_set_tag(struct icc_path *path, u32 tag);
 
@@ -50,6 +52,16 @@ static inline void icc_put(struct icc_path *path)
 {
 }
 
+static inline int icc_enable(struct icc_path *path)
+{
+	return 0;
+}
+
+static inline int icc_disable(struct icc_path *path)
+{
+	return 0;
+}
+
 static inline int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
 {
 	return 0;
-- 
2.40.1



