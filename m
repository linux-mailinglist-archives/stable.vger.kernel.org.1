Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9F770356D
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243307AbjEOQ7B (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243337AbjEOQ6x (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:58:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610FB76B4
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:58:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E4BC62A44
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:58:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0DAC433D2;
        Mon, 15 May 2023 16:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169930;
        bh=3vij6U0ufvDorV8dwbJtqPUbB6k3SOEXRBsLswKss14=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gUMBk5m/s1XvhhK008zxJPJFzJtxQ7pzP0GqujwiYxoskRCOcHHfuYO7jak0OKNrJ
         KwTp3ICF1yD2uTtX2gfTvRz5KxBqvkXqhT6rN3b4zKvchLJZFZvX0ssE+UUaF7RSdj
         zL3/oEXpVrNESvpxmE5z9Tift6/F1ZeThJI1GfCk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jianmin Lv <lvjianmin@loongson.cn>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH 6.3 187/246] irqchip/loongson-eiointc: Fix incorrect use of acpi_get_vec_parent
Date:   Mon, 15 May 2023 18:26:39 +0200
Message-Id: <20230515161728.231239804@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
References: <20230515161722.610123835@linuxfoundation.org>
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

From: Jianmin Lv <lvjianmin@loongson.cn>

commit 64cc451e45e146b2140211b4f45f278b93b24ac0 upstream.

In eiointc_acpi_init(), a *eiointc* node is passed into
acpi_get_vec_parent() instead of a required *NUMA* node (on some chip
like 3C5000L, a *NUMA* node means a *eiointc* node, but on some chip
like 3C5000, a *NUMA* node contains 4 *eiointc* nodes), and node in
struct acpi_vector_group is essentially a *NUMA* node, which will
lead to no parent matched for passed *eiointc* node. so the patch
adjusts code to use *NUMA* node for parameter node of
acpi_set_vec_parent/acpi_get_vec_parent.

Cc: stable@vger.kernel.org
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230407083453.6305-3-lvjianmin@loongson.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/irqchip/irq-loongson-eiointc.c |   22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -280,9 +280,6 @@ static void acpi_set_vec_parent(int node
 {
 	int i;
 
-	if (cpu_has_flatmode)
-		node = cpu_to_node(node * CORES_PER_EIO_NODE);
-
 	for (i = 0; i < MAX_IO_PICS; i++) {
 		if (node == vec_group[i].node) {
 			vec_group[i].parent = parent;
@@ -349,8 +346,16 @@ static int __init pch_pic_parse_madt(uni
 static int __init pch_msi_parse_madt(union acpi_subtable_headers *header,
 					const unsigned long end)
 {
+	struct irq_domain *parent;
 	struct acpi_madt_msi_pic *pchmsi_entry = (struct acpi_madt_msi_pic *)header;
-	struct irq_domain *parent = acpi_get_vec_parent(eiointc_priv[nr_pics - 1]->node, msi_group);
+	int node;
+
+	if (cpu_has_flatmode)
+		node = cpu_to_node(eiointc_priv[nr_pics - 1]->node * CORES_PER_EIO_NODE);
+	else
+		node = eiointc_priv[nr_pics - 1]->node;
+
+	parent = acpi_get_vec_parent(node, msi_group);
 
 	if (parent)
 		return pch_msi_acpi_init(parent, pchmsi_entry);
@@ -379,6 +384,7 @@ int __init eiointc_acpi_init(struct irq_
 	int i, ret, parent_irq;
 	unsigned long node_map;
 	struct eiointc_priv *priv;
+	int node;
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -421,8 +427,12 @@ int __init eiointc_acpi_init(struct irq_
 				  "irqchip/loongarch/intc:starting",
 				  eiointc_router_init, NULL);
 
-	acpi_set_vec_parent(acpi_eiointc->node, priv->eiointc_domain, pch_group);
-	acpi_set_vec_parent(acpi_eiointc->node, priv->eiointc_domain, msi_group);
+	if (cpu_has_flatmode)
+		node = cpu_to_node(acpi_eiointc->node * CORES_PER_EIO_NODE);
+	else
+		node = acpi_eiointc->node;
+	acpi_set_vec_parent(node, priv->eiointc_domain, pch_group);
+	acpi_set_vec_parent(node, priv->eiointc_domain, msi_group);
 	ret = acpi_cascade_irqdomain_init();
 
 	return ret;


