Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6118E77AB6E
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjHMVVy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjHMVVx (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:21:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C5110E3
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:21:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28D3A627CF
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:21:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 425E4C433C8;
        Sun, 13 Aug 2023 21:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691961714;
        bh=LTLTGtzwLFCfMwDPkwvOE59epzWiH/L6gcAyHUc0PlM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ngM3dDXXpzvvNjJUVP1L5qNNUHZgUF0BFoV6bb3G5dVUkWKYKLPFKqYs1SFvusM9T
         dYjiH2UbRw8lOLLcTOCHIphuyheT2VdS7IV+McE1lLsAxs3tsqo8vC1GZ3XVgNv0mw
         rBCwohJc38a7pAol2koIt+3aWTZFt4xKRQ1yz+1s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhu Wang <wangzhu9@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 25/26] scsi: core: Fix possible memory leak if device_add() fails
Date:   Sun, 13 Aug 2023 23:19:18 +0200
Message-ID: <20230813211703.922069272@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211702.980427106@linuxfoundation.org>
References: <20230813211702.980427106@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Zhu Wang <wangzhu9@huawei.com>

commit 04b5b5cb0136ce970333a9c6cec7e46adba1ea3a upstream.

If device_add() returns error, the name allocated by dev_set_name() needs
be freed. As the comment of device_add() says, put_device() should be used
to decrease the reference count in the error path. So fix this by calling
put_device(), then the name can be freed in kobject_cleanp().

Fixes: ee959b00c335 ("SCSI: convert struct class_device to struct device")
Signed-off-by: Zhu Wang <wangzhu9@huawei.com>
Link: https://lore.kernel.org/r/20230803020230.226903-1-wangzhu9@huawei.com
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/raid_class.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/scsi/raid_class.c
+++ b/drivers/scsi/raid_class.c
@@ -248,6 +248,7 @@ int raid_component_add(struct raid_templ
 	return 0;
 
 err_out:
+	put_device(&rc->dev);
 	list_del(&rc->node);
 	rd->component_count--;
 	put_device(component_dev);


