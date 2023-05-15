Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D01703685
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243738AbjEORKu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243734AbjEORKW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:10:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03B67DBA
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:08:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C27C62103
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:08:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CDD6C433D2;
        Mon, 15 May 2023 17:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170526;
        bh=skQYMjmRef3pQ5yEGXaWwy4FSTWVgS6pCs51XXt4lWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PAeXxiFgyOlckysihmyDvuYfmV6hc6LZCcwsKkXHjDvN14tIZw/4M7LweSEHKOcNh
         fiQZW30Gp6NSDjo/hYJh4dUEeh5PfO4PAaC9iKfIh7NQwPd5MSqPFEvR47DEk6qN/f
         VQhTpRTjWHGFymdepZ4AIu7mg4uR4GhI+ejDOUz0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jianmin Lv <lvjianmin@loongson.cn>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH 6.1 159/239] irqchip/loongson-eiointc: Fix returned value on parsing MADT
Date:   Mon, 15 May 2023 18:27:02 +0200
Message-Id: <20230515161726.446849818@linuxfoundation.org>
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
@@ -312,7 +312,7 @@ pch_pic_parse_madt(union acpi_subtable_h
 	if (parent)
 		return pch_pic_acpi_init(parent, pchpic_entry);
 
-	return -EINVAL;
+	return 0;
 }
 
 static int __init
@@ -325,7 +325,7 @@ pch_msi_parse_madt(union acpi_subtable_h
 	if (parent)
 		return pch_msi_acpi_init(parent, pchmsi_entry);
 
-	return -EINVAL;
+	return 0;
 }
 
 static int __init acpi_cascade_irqdomain_init(void)


