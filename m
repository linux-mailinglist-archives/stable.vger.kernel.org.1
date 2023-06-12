Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD01E72BFFC
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbjFLKsj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbjFLKsV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:48:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEED46B8
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:33:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB3A2623DC
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:33:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D41F9C433D2;
        Mon, 12 Jun 2023 10:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686565989;
        bh=M2JNQO6GQXoICVxasJ24bal03qE385kkBDhU/Vog4jY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jjjaetICY/P8xNTVYJDmdmT9rXaBhrUBsaBrDHlkQmGNJ0CbhpSmC39cH0EcY6unl
         ZkxYwaMeXeq0wfYEBVsf8odvLAWM//gnrv1VNSe4VRWa+1TGn41z6586/2ZwiJ5tDC
         Fqo2VwNcqjkiT2fYzGf72+HwF3Pu/UGj06OxCbHI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev
Subject: [PATCH 5.10 09/68] i40iw: fix build warning in i40iw_manage_apbvt()
Date:   Mon, 12 Jun 2023 12:26:01 +0200
Message-ID: <20230612101658.851760361@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101658.437327280@linuxfoundation.org>
References: <20230612101658.437327280@linuxfoundation.org>
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

Not upstream as this function is no longer around anymore.

The function i40iw_manage_apbvt() has the wrong prototype match from the
.h file to the .c declaration, so fix it up, otherwise gcc-13 complains
(rightfully) that the type is incorrect.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/i40iw/i40iw.h |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/infiniband/hw/i40iw/i40iw.h
+++ b/drivers/infiniband/hw/i40iw/i40iw.h
@@ -422,9 +422,8 @@ void i40iw_manage_arp_cache(struct i40iw
 			    bool ipv4,
 			    u32 action);
 
-int i40iw_manage_apbvt(struct i40iw_device *iwdev,
-		       u16 accel_local_port,
-		       bool add_port);
+enum i40iw_status_code i40iw_manage_apbvt(struct i40iw_device *iwdev,
+					  u16 accel_local_port, bool add_port);
 
 struct i40iw_cqp_request *i40iw_get_cqp_request(struct i40iw_cqp *cqp, bool wait);
 void i40iw_free_cqp_request(struct i40iw_cqp *cqp, struct i40iw_cqp_request *cqp_request);


