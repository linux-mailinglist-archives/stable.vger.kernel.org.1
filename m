Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D8C7037CF
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243778AbjEORYS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244167AbjEORXs (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:23:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50C4DC5A
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:22:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5F8562C65
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:22:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC453C433D2;
        Mon, 15 May 2023 17:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171354;
        bh=0M0FAuG3Qyhr2jqM0j3vbsgcmFZMleMWj3HaMudskG4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DtgqIYl9JteYGlo7hewWd+b4LXy7plGmcQK8ENtYRO7iTmxBMmswKCyNWs7bw8RvK
         9h+oaxGORMsMFIApN7bjDBYOWYtk0qt6JSAyQTDEsUv6MAkfdAjPZDIym5PRNKoWAS
         Lg876TEr0aVGnRyRbb5h5qO7uJCU449NCkoJ43Fg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jianmin Lv <lvjianmin@loongson.cn>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH 6.2 183/242] irqchip/loongson-eiointc: Fix returned value on parsing MADT
Date:   Mon, 15 May 2023 18:28:29 +0200
Message-Id: <20230515161727.361596443@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
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

commit 112eaa8fec5ea75f1be003ec55760b09a86799f8 upstream.

In pch_pic_parse_madt(), a NULL parent pointer will be
returned from acpi_get_vec_parent() for second pch-pic domain
related to second bridge while calling eiointc_acpi_init() at
first time, where the parent of it has not been initialized
yet, and will be initialized during second time calling
eiointc_acpi_init(). So, it's reasonable to return zero so
that failure of acpi_table_parse_madt() will be avoided, or else
acpi_cascade_irqdomain_init() will return and initialization of
followed pch_msi domain will be skipped.

Although it does not matter when pch_msi_parse_madt() returns
-EINVAL if no invalid parent is found, it's also reasonable to
return zero for that.

Cc: stable@vger.kernel.org
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230407083453.6305-2-lvjianmin@loongson.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/irqchip/irq-loongson-eiointc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -343,7 +343,7 @@ static int __init pch_pic_parse_madt(uni
 	if (parent)
 		return pch_pic_acpi_init(parent, pchpic_entry);
 
-	return -EINVAL;
+	return 0;
 }
 
 static int __init pch_msi_parse_madt(union acpi_subtable_headers *header,
@@ -355,7 +355,7 @@ static int __init pch_msi_parse_madt(uni
 	if (parent)
 		return pch_msi_acpi_init(parent, pchmsi_entry);
 
-	return -EINVAL;
+	return 0;
 }
 
 static int __init acpi_cascade_irqdomain_init(void)


