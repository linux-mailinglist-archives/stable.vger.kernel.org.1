Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419FD7036B0
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243714AbjEORMu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243728AbjEORMd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:12:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE724E709
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:10:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54FAF62B56
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:10:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45CB2C433D2;
        Mon, 15 May 2023 17:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170635;
        bh=FTcfyVX6iAMFIPu9PnkPVTRVyZyFNdaaTJJkKS9KDDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U+Zu0RyJOvrkYYgnYN/BeP1JWgMa3VZ0tBQLgTUvppMWU7uI5LVsUG4xMCAcWBE/9
         ij+o339qgn009GNDATgJ8cxwQLhTO+jMEXltKGVwv3qL5CRMUNKFNXG9T9GJON7fJY
         6f+6+q876BIQiYs89It6vLapCSXxZJNDL8h9UrT4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jianmin Lv <lvjianmin@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 194/239] irqchip/loongson-eiointc: Fix incorrect use of acpi_get_vec_parent
Date:   Mon, 15 May 2023 18:27:37 +0200
Message-Id: <20230515161727.555794545@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
References: <20230515161721.545370111@linuxfoundation.org>
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

From: Jianmin Lv <lvjianmin@loongson.cn>

[ Upstream commit 64cc451e45e146b2140211b4f45f278b93b24ac0 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-loongson-eiointc.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index 7e601a5f7d9f8..768ed36f5f663 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -279,9 +279,6 @@ static void acpi_set_vec_parent(int node, struct irq_domain *parent, struct acpi
 {
 	int i;
 
-	if (cpu_has_flatmode)
-		node = cpu_to_node(node * CORES_PER_EIO_NODE);
-
 	for (i = 0; i < MAX_IO_PICS; i++) {
 		if (node == vec_group[i].node) {
 			vec_group[i].parent = parent;
@@ -317,8 +314,16 @@ static int __init pch_pic_parse_madt(union acpi_subtable_headers *header,
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
@@ -347,6 +352,7 @@ int __init eiointc_acpi_init(struct irq_domain *parent,
 	int i, ret, parent_irq;
 	unsigned long node_map;
 	struct eiointc_priv *priv;
+	int node;
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -388,8 +394,12 @@ int __init eiointc_acpi_init(struct irq_domain *parent,
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
-- 
2.39.2



