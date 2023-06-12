Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A7F72C09B
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbjFLKxg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbjFLKxU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:53:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEDDAD28
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:38:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C5F5623EE
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:38:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F800C4339B;
        Mon, 12 Jun 2023 10:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566280;
        bh=lZmncEOXhR/DL4JLuP5p/9gz+poKWYx+qwIB+KuYEiw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XrMTdweYLvngrqrUAWstvqQJ3yK6Y5q8c8dlmm9QMUcTGDXSnQeWyG0X8SmpizpQ5
         SyEbXynN+MH69n/PdwO/XToUUcHbZhcAaAJRIW2DAPK0SgXIgfQq75As1cSWyBRJO2
         gxYyxOPtWtvG5Qw6URI71C7FJJsMKJ75PnJ0JG/w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Min Li <lm0963hack@gmail.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 5.15 63/91] Bluetooth: Fix use-after-free in hci_remove_ltk/hci_remove_irk
Date:   Mon, 12 Jun 2023 12:26:52 +0200
Message-ID: <20230612101704.698793684@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101702.085813286@linuxfoundation.org>
References: <20230612101702.085813286@linuxfoundation.org>
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
@@ -2697,10 +2697,10 @@ int hci_remove_link_key(struct hci_dev *
 
 int hci_remove_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 bdaddr_type)
 {
-	struct smp_ltk *k;
+	struct smp_ltk *k, *tmp;
 	int removed = 0;
 
-	list_for_each_entry_rcu(k, &hdev->long_term_keys, list) {
+	list_for_each_entry_safe(k, tmp, &hdev->long_term_keys, list) {
 		if (bacmp(bdaddr, &k->bdaddr) || k->bdaddr_type != bdaddr_type)
 			continue;
 
@@ -2716,9 +2716,9 @@ int hci_remove_ltk(struct hci_dev *hdev,
 
 void hci_remove_irk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type)
 {
-	struct smp_irk *k;
+	struct smp_irk *k, *tmp;
 
-	list_for_each_entry_rcu(k, &hdev->identity_resolving_keys, list) {
+	list_for_each_entry_safe(k, tmp, &hdev->identity_resolving_keys, list) {
 		if (bacmp(bdaddr, &k->bdaddr) || k->addr_type != addr_type)
 			continue;
 


