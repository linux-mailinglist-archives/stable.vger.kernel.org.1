Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3406D72BF96
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjFLKpZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjFLKpJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:45:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2817859CD
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:29:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08E1061500
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:29:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D14CC433D2;
        Mon, 12 Jun 2023 10:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686565791;
        bh=vfjv2kynwe9F8iphwJjPyAH/i4yW5V1N13gFEty/Zbs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LMz2h/UOXr1ib+shDiqP5S1mqiVAkMH3WsFcgATQ85tTnQIJFZx4SL8zQaMJb5l58
         xgyzeWZmIuVXSI4rQbd5rDPFGPQkzjxny6q1vzHCsyp+dDsGYc7CNQs+iuUxvnYUGd
         kmh2uaSikxkoncpoHDoXiQ91cVRdCibHG2pMpBQ8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Min Li <lm0963hack@gmail.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 4.19 17/23] Bluetooth: Fix use-after-free in hci_remove_ltk/hci_remove_irk
Date:   Mon, 12 Jun 2023 12:26:18 +0200
Message-ID: <20230612101651.727346851@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101651.138592130@linuxfoundation.org>
References: <20230612101651.138592130@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

commit c5d2b6fa26b5b8386a9cc902cdece3a46bef2bd2 upstream.

Similar to commit 0f7d9b31ce7a ("netfilter: nf_tables: fix use-after-free
in nft_set_catchall_destroy()"). We can not access k after kfree_rcu()
call.

Cc: stable@vger.kernel.org
Signed-off-by: Min Li <lm0963hack@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bluetooth/hci_core.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2517,10 +2517,10 @@ int hci_remove_link_key(struct hci_dev *
 
 int hci_remove_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 bdaddr_type)
 {
-	struct smp_ltk *k;
+	struct smp_ltk *k, *tmp;
 	int removed = 0;
 
-	list_for_each_entry_rcu(k, &hdev->long_term_keys, list) {
+	list_for_each_entry_safe(k, tmp, &hdev->long_term_keys, list) {
 		if (bacmp(bdaddr, &k->bdaddr) || k->bdaddr_type != bdaddr_type)
 			continue;
 
@@ -2536,9 +2536,9 @@ int hci_remove_ltk(struct hci_dev *hdev,
 
 void hci_remove_irk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type)
 {
-	struct smp_irk *k;
+	struct smp_irk *k, *tmp;
 
-	list_for_each_entry_rcu(k, &hdev->identity_resolving_keys, list) {
+	list_for_each_entry_safe(k, tmp, &hdev->identity_resolving_keys, list) {
 		if (bacmp(bdaddr, &k->bdaddr) || k->addr_type != addr_type)
 			continue;
 


