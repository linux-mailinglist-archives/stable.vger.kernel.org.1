Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F957DD3EE
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236239AbjJaRGT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236211AbjJaRGG (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:06:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985B31FD5
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:03:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D761BC433C7;
        Tue, 31 Oct 2023 17:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698771818;
        bh=/FtEwPzhzzYGnd8EA12m70+E9HUXO7bWU7BvYHEjEqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q8g4LAaxEcJgd9VjYTN7eIEyaH0zJcbma2KhjpqAGZmDGTLtafyYYtlDQwFrO+ncx
         8FR1COXI3sD8S32XRPwdMV+Imdt5ZpSE1Bj5nphwlI/vKwKOqfTPJf6uX3c1dqZ3uA
         6do4PM9/KDWNULNtzJ/OkktdMr/JuDcnjQLmshWc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>,
        Javier Rodriguez <josejavier.rodriguez@duagon.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 10/86] mcb: Return actual parsed size when reading chameleon table
Date:   Tue, 31 Oct 2023 18:00:35 +0100
Message-ID: <20231031165918.942161370@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165918.608547597@linuxfoundation.org>
References: <20231031165918.608547597@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rodríguez Barbarin, José Javier <JoseJavier.Rodriguez@duagon.com>

[ Upstream commit a889c276d33d333ae96697510f33533f6e9d9591 ]

The function chameleon_parse_cells() returns the number of cells
parsed which has an undetermined size. This return value is only
used for error checking but the number of cells is never used.

Change return value to be number of bytes parsed to allow for
memory management improvements.

Co-developed-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
Signed-off-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
Signed-off-by: Javier Rodriguez <josejavier.rodriguez@duagon.com>
Signed-off-by: Johannes Thumshirn <jth@kernel.org>
Link: https://lore.kernel.org/r/20230411083329.4506-2-jth@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mcb/mcb-parse.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/mcb/mcb-parse.c b/drivers/mcb/mcb-parse.c
index c41cbacc75a2c..656b6b71c7682 100644
--- a/drivers/mcb/mcb-parse.c
+++ b/drivers/mcb/mcb-parse.c
@@ -128,7 +128,7 @@ static void chameleon_parse_bar(void __iomem *base,
 	}
 }
 
-static int chameleon_get_bar(char __iomem **base, phys_addr_t mapbase,
+static int chameleon_get_bar(void __iomem **base, phys_addr_t mapbase,
 			     struct chameleon_bar **cb)
 {
 	struct chameleon_bar *c;
@@ -177,12 +177,13 @@ int chameleon_parse_cells(struct mcb_bus *bus, phys_addr_t mapbase,
 {
 	struct chameleon_fpga_header *header;
 	struct chameleon_bar *cb;
-	char __iomem *p = base;
+	void __iomem *p = base;
 	int num_cells = 0;
 	uint32_t dtype;
 	int bar_count;
 	int ret;
 	u32 hsize;
+	u32 table_size;
 
 	hsize = sizeof(struct chameleon_fpga_header);
 
@@ -237,12 +238,16 @@ int chameleon_parse_cells(struct mcb_bus *bus, phys_addr_t mapbase,
 		num_cells++;
 	}
 
-	if (num_cells == 0)
-		num_cells = -EINVAL;
+	if (num_cells == 0) {
+		ret = -EINVAL;
+		goto free_bar;
+	}
 
+	table_size = p - base;
+	pr_debug("%d cell(s) found. Chameleon table size: 0x%04x bytes\n", num_cells, table_size);
 	kfree(cb);
 	kfree(header);
-	return num_cells;
+	return table_size;
 
 free_bar:
 	kfree(cb);
-- 
2.42.0



