Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C270879B7BD
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239921AbjIKUzo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241602AbjIKPK5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:10:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D74E4B
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:10:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9C2C433CC;
        Mon, 11 Sep 2023 15:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445052;
        bh=0+MD1wqOsNnXJcAjJe/CqzyDow1gAhpMtRSSRoTdbMk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=baiQVdnq8jypUdeqM/l0+fQ9ALRSsInXNesdD/UQ/oo3Oa8VTKL3zMd4+N2MY1gy2
         nyj9UhRXxA2lsHwU+KvKqIK6wemP1JbT3gq9RmwalQrW62ialpHL17DbFn1K8Je4z8
         QUo/eT1gH8ziKhMu3dUre1huBWVSvvmY0r3l/nis=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Min Li <lm0963hack@gmail.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 170/600] Bluetooth: Fix potential use-after-free when clear keys
Date:   Mon, 11 Sep 2023 15:43:23 +0200
Message-ID: <20230911134638.628794490@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Min Li <lm0963hack@gmail.com>

[ Upstream commit 3673952cf0c6cf81b06c66a0b788abeeb02ff3ae ]

Similar to commit c5d2b6fa26b5 ("Bluetooth: Fix use-after-free in
hci_remove_ltk/hci_remove_irk"). We can not access k after kfree_rcu()
call.

Fixes: d7d41682efc2 ("Bluetooth: Fix Suspicious RCU usage warnings")
Signed-off-by: Min Li <lm0963hack@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d034bf2a999e1..26884447d72be 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1074,9 +1074,9 @@ void hci_uuids_clear(struct hci_dev *hdev)
 
 void hci_link_keys_clear(struct hci_dev *hdev)
 {
-	struct link_key *key;
+	struct link_key *key, *tmp;
 
-	list_for_each_entry(key, &hdev->link_keys, list) {
+	list_for_each_entry_safe(key, tmp, &hdev->link_keys, list) {
 		list_del_rcu(&key->list);
 		kfree_rcu(key, rcu);
 	}
@@ -1084,9 +1084,9 @@ void hci_link_keys_clear(struct hci_dev *hdev)
 
 void hci_smp_ltks_clear(struct hci_dev *hdev)
 {
-	struct smp_ltk *k;
+	struct smp_ltk *k, *tmp;
 
-	list_for_each_entry(k, &hdev->long_term_keys, list) {
+	list_for_each_entry_safe(k, tmp, &hdev->long_term_keys, list) {
 		list_del_rcu(&k->list);
 		kfree_rcu(k, rcu);
 	}
@@ -1094,9 +1094,9 @@ void hci_smp_ltks_clear(struct hci_dev *hdev)
 
 void hci_smp_irks_clear(struct hci_dev *hdev)
 {
-	struct smp_irk *k;
+	struct smp_irk *k, *tmp;
 
-	list_for_each_entry(k, &hdev->identity_resolving_keys, list) {
+	list_for_each_entry_safe(k, tmp, &hdev->identity_resolving_keys, list) {
 		list_del_rcu(&k->list);
 		kfree_rcu(k, rcu);
 	}
@@ -1104,9 +1104,9 @@ void hci_smp_irks_clear(struct hci_dev *hdev)
 
 void hci_blocked_keys_clear(struct hci_dev *hdev)
 {
-	struct blocked_key *b;
+	struct blocked_key *b, *tmp;
 
-	list_for_each_entry(b, &hdev->blocked_keys, list) {
+	list_for_each_entry_safe(b, tmp, &hdev->blocked_keys, list) {
 		list_del_rcu(&b->list);
 		kfree_rcu(b, rcu);
 	}
-- 
2.40.1



