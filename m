Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DAB775D0A
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbjHILdS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233944AbjHILdS (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:33:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D879AE3
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:33:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 702BA6343F
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:33:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E91C433C7;
        Wed,  9 Aug 2023 11:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580796;
        bh=SSGgfeWRBw4viNWaVLFyUeNBNiuwW+6nx2DqUtaeA2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uHFuBMvD7cmSacGsG5bcDrNzKXK2RA/+lKzytP6Ou83/Vhnh9qjEiYpazlHNJHL0M
         VJPn8KIPFd5lDH1McDhjWxF0Zwc5QKoO8c7SM2cHDezdNQacb3DtF00lWIHJrvvVyL
         hCWEuujaE/fCylV4fjfDS+RmqGcVT6ESdWjiA5oY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 5.4 153/154] drivers: core: fix kernel-doc markup for dev_err_probe()
Date:   Wed,  9 Aug 2023 12:43:04 +0200
Message-ID: <20230809103641.898239320@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.887175326@linuxfoundation.org>
References: <20230809103636.887175326@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

commit 074b3aad307de6126fbac1fff4996d1034b48fee upstream.

There are two literal blocks there. Fix the markups, in order
to produce the right html output and solve those warnings:

	./drivers/base/core.c:4218: WARNING: Unexpected indentation.
	./drivers/base/core.c:4222: WARNING: Definition list ends without a blank line; unexpected unindent.
	./drivers/base/core.c:4223: WARNING: Block quote ends without a blank line; unexpected unindent.

Fixes: a787e5400a1c ("driver core: add device probe log helper")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/core.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3409,13 +3409,15 @@ define_dev_printk_level(_dev_info, KERN_
  * This helper implements common pattern present in probe functions for error
  * checking: print debug or error message depending if the error value is
  * -EPROBE_DEFER and propagate error upwards.
- * It replaces code sequence:
+ * It replaces code sequence::
  * 	if (err != -EPROBE_DEFER)
  * 		dev_err(dev, ...);
  * 	else
  * 		dev_dbg(dev, ...);
  * 	return err;
- * with
+ *
+ * with::
+ *
  * 	return dev_err_probe(dev, err, ...);
  *
  * Returns @err.


