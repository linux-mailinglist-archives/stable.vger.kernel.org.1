Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DE67039DB
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243388AbjEORq1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244593AbjEORqK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:46:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30697D06C
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:44:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB1ED62E96
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:44:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60ABC433EF;
        Mon, 15 May 2023 17:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172654;
        bh=qpEOTdeyMlWi488ZVlZ/KLBnO9pp+39CmG2/av42UN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0jL8oIisE+onV/O4gN5a5EOMeyFXxhNPYvLa5suABW/97145RNTvnXMEKs5nHLdOs
         KaSZzYgixRXZ7+RTZ8RmZ2HSJxI5uS2Sw365jgFMQ3GlMzsgzwSa1vO4AMNKazEENI
         uovxOOHA3oAE2yqgA/zAEOipsT6BOyxYYY+ZXw6c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Marco Pagani <marpagan@redhat.com>,
        Tom Rix <trix@redhat.com>, Xu Yilun <yilun.xu@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 196/381] fpga: bridge: fix kernel-doc parameter description
Date:   Mon, 15 May 2023 18:27:27 +0200
Message-Id: <20230515161745.682685035@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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

From: Marco Pagani <marpagan@redhat.com>

[ Upstream commit 7ef1a2c1c9dffa177ecc3ea50b7f5ee63a621137 ]

Fix the kernel-doc description for the "struct fpga_image_info *info"
parameter of the fpga_bridge_get() function.

Fixes: 060ac5c8fa7b ("fpga: bridge: kernel-doc fixes")
Signed-off-by: Marco Pagani <marpagan@redhat.com>
Reviewed-by: Tom Rix <trix@redhat.com>
Acked-by: Xu Yilun <yilun.xu@intel.com>
Link: https://lore.kernel.org/r/20230301140309.512578-1-marpagan@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/fpga/fpga-bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index 2deccacc3aa75..851debe32bf0f 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -115,7 +115,7 @@ static int fpga_bridge_dev_match(struct device *dev, const void *data)
 /**
  * fpga_bridge_get - get an exclusive reference to a fpga bridge
  * @dev:	parent device that fpga bridge was registered with
- * @info:	fpga manager info
+ * @info:	fpga image specific information
  *
  * Given a device, get an exclusive reference to a fpga bridge.
  *
-- 
2.39.2



