Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D580C726EA9
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbjFGUvx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbjFGUvp (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:51:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7591FD5
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:51:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E59563189
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:51:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AADFC433EF;
        Wed,  7 Jun 2023 20:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171097;
        bh=5ZZzrT3xglQj+dU7J45cCHzPNRY2VFGPwEGPXZSExQQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sClp3aJEtYkNMLAdSul9WJn4UVuqH4lSWFC7pbZ9uynoE7sjlR+Qh9KJWhk+K94mB
         TCIrav0xRYlEZdF/TZ31YCEV+YRxdx/5jmFwnCIDik27IN/IVH3Dsl1eNy28z1Si3z
         QAMCtNkIzxNi2ig5kpjHIPdGQHE8tAkFbkLcWELk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH 5.10 110/120] media: ti-vpe: cal: avoid FIELD_GET assertion
Date:   Wed,  7 Jun 2023 22:17:06 +0200
Message-ID: <20230607200904.390199540@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200900.915613242@linuxfoundation.org>
References: <20230607200900.915613242@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

commit d7a7d721064c548042b019cd0d4d62e0bb878d71 upstream.

FIELD_GET() must only be used with a mask that is a compile-time
constant:

drivers/media/platform/ti-vpe/cal.h: In function 'cal_read_field':
include/linux/compiler_types.h:320:38: error: call to '__compiletime_assert_247' declared with attribute error: FIELD_GET: mask is not constant
include/linux/bitfield.h:46:3: note: in expansion of macro 'BUILD_BUG_ON_MSG'
   46 |   BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),  \
      |   ^~~~~~~~~~~~~~~~
drivers/media/platform/ti-vpe/cal.h:220:9: note: in expansion of macro 'FIELD_GET'
  220 |  return FIELD_GET(mask, cal_read(cal, offset));
      |         ^~~~~~~~~

The problem here is that the function is not always inlined. Mark it
__always_inline to avoid the problem.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/ti-vpe/cal.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/platform/ti-vpe/cal.h
+++ b/drivers/media/platform/ti-vpe/cal.h
@@ -215,7 +215,7 @@ static inline void cal_write(struct cal_
 	iowrite32(val, cal->base + offset);
 }
 
-static inline u32 cal_read_field(struct cal_dev *cal, u32 offset, u32 mask)
+static __always_inline u32 cal_read_field(struct cal_dev *cal, u32 offset, u32 mask)
 {
 	return FIELD_GET(mask, cal_read(cal, offset));
 }


