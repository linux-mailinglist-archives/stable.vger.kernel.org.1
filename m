Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E3278AE2B
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbjH1K6A (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbjH1Krh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:47:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092541A1
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:47:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8445564327
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:47:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A558C433C9;
        Mon, 28 Aug 2023 10:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219645;
        bh=oRzADrJgrecM1FrM3+s5dqs71drOoWBxKckHygGSIns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MvozwqZRXApC5ymaN6f/yMm+0nV8bPy7oJFkoJl0mf4WojSnMxusIwOd1IwNIng+K
         dx6Ag5aginK6k/6GNOuwhGXAJYaPwMBSAzAXbIRk5ConXRMTKX+tXa8oE7QDPzpF1t
         JJoK0TdvgfJMEpZY40C4ctgd/f1FnN6xIJZCc/Js=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 21/84] libceph, rbd: ignore addr->type while comparing in some cases
Date:   Mon, 28 Aug 2023 12:13:38 +0200
Message-ID: <20230828101149.921590943@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101149.146126827@linuxfoundation.org>
References: <20230828101149.146126827@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilya Dryomov <idryomov@gmail.com>

[ Upstream commit 313771e80fd253d4b5472e61a2d12b03c5293aa9 ]

For libceph, this ensures that libceph instance sharing (share option)
continues to work.  For rbd, this avoids blocklisting alive lock owners
(locker addr is always LEGACY, while watcher addr is ANY in nautilus).

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Stable-dep-of: 588159009d5b ("rbd: retrieve and check lock owner twice before blocklisting")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/rbd.c       | 8 ++++++--
 include/linux/ceph/msgr.h | 9 ++++++++-
 net/ceph/mon_client.c     | 6 ++++--
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 63491748dc8d7..7b8731cddd9ea 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3979,8 +3979,12 @@ static int find_watcher(struct rbd_device *rbd_dev,
 
 	sscanf(locker->id.cookie, RBD_LOCK_COOKIE_PREFIX " %llu", &cookie);
 	for (i = 0; i < num_watchers; i++) {
-		if (!memcmp(&watchers[i].addr, &locker->info.addr,
-			    sizeof(locker->info.addr)) &&
+		/*
+		 * Ignore addr->type while comparing.  This mimics
+		 * entity_addr_t::get_legacy_str() + strcmp().
+		 */
+		if (ceph_addr_equal_no_type(&watchers[i].addr,
+					    &locker->info.addr) &&
 		    watchers[i].cookie == cookie) {
 			struct rbd_client_id cid = {
 				.gid = le64_to_cpu(watchers[i].name.num),
diff --git a/include/linux/ceph/msgr.h b/include/linux/ceph/msgr.h
index 9e50aede46c83..7bde0af29a814 100644
--- a/include/linux/ceph/msgr.h
+++ b/include/linux/ceph/msgr.h
@@ -61,11 +61,18 @@ extern const char *ceph_entity_type_name(int type);
  * entity_addr -- network address
  */
 struct ceph_entity_addr {
-	__le32 type;
+	__le32 type;  /* CEPH_ENTITY_ADDR_TYPE_* */
 	__le32 nonce;  /* unique id for process (e.g. pid) */
 	struct sockaddr_storage in_addr;
 } __attribute__ ((packed));
 
+static inline bool ceph_addr_equal_no_type(const struct ceph_entity_addr *lhs,
+					   const struct ceph_entity_addr *rhs)
+{
+	return !memcmp(&lhs->in_addr, &rhs->in_addr, sizeof(lhs->in_addr)) &&
+	       lhs->nonce == rhs->nonce;
+}
+
 struct ceph_entity_inst {
 	struct ceph_entity_name name;
 	struct ceph_entity_addr addr;
diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index c4cf2529d08ba..ef5c174102d5e 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -96,9 +96,11 @@ int ceph_monmap_contains(struct ceph_monmap *m, struct ceph_entity_addr *addr)
 {
 	int i;
 
-	for (i = 0; i < m->num_mon; i++)
-		if (memcmp(addr, &m->mon_inst[i].addr, sizeof(*addr)) == 0)
+	for (i = 0; i < m->num_mon; i++) {
+		if (ceph_addr_equal_no_type(addr, &m->mon_inst[i].addr))
 			return 1;
+	}
+
 	return 0;
 }
 
-- 
2.40.1



