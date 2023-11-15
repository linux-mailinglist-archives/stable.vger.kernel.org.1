Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9D77ED432
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344562AbjKOU5S (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235068AbjKOU5O (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:57:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17284B0
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:57:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD0BC4E77B;
        Wed, 15 Nov 2023 20:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081828;
        bh=eq1aHyWHf/S3PS1Pq3BYB5zO9rJJoEav2+2RWEOuVBo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TRNNYJbAJUGQgbt0WlyjRd9kmaD/3jOiCciJGB5llyeqd2rYWdGlU5wBJY2keMHtT
         V3ClYr2s1jWDWFEyJfkpxmLGqzdBv7IIjgXF3L5PzO376rIW4iAdnNd3ky7s2O9EbO
         MvIamNloymY+s5/hDwMh75KMf4iiyc0OVpVCsRYw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yang Yingliang <yangyingliang@huawei.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 151/191] pcmcia: ds: fix refcount leak in pcmcia_device_add()
Date:   Wed, 15 Nov 2023 15:47:06 -0500
Message-ID: <20231115204653.558180109@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115204644.490636297@linuxfoundation.org>
References: <20231115204644.490636297@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yang Yingliang <yangyingliang@huawei.com>

[ Upstream commit 402ab979b29126068e0b596b641422ff7490214c ]

As the comment of device_register() says, it should use put_device()
to give up the reference in the error path. Then, insofar resources
will be freed in pcmcia_release_dev(), the error path is no longer
needed. In particular, this means that the (previously missing) dropping
of the reference to &p_dev->function_config->ref is now handled by
pcmcia_release_dev().

Fixes: 360b65b95bae ("[PATCH] pcmcia: make config_t independent, add reference counting")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
[linux@dominikbrodowski.net: simplification, commit message rewrite]
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pcmcia/ds.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pcmcia/ds.c b/drivers/pcmcia/ds.c
index 72114907c0e4d..341305496b06b 100644
--- a/drivers/pcmcia/ds.c
+++ b/drivers/pcmcia/ds.c
@@ -578,8 +578,14 @@ static struct pcmcia_device *pcmcia_device_add(struct pcmcia_socket *s,
 
 	pcmcia_device_query(p_dev);
 
-	if (device_register(&p_dev->dev))
-		goto err_unreg;
+	if (device_register(&p_dev->dev)) {
+		mutex_lock(&s->ops_mutex);
+		list_del(&p_dev->socket_device_list);
+		s->device_count--;
+		mutex_unlock(&s->ops_mutex);
+		put_device(&p_dev->dev);
+		return NULL;
+	}
 
 	return p_dev;
 
-- 
2.42.0



