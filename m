Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F8C72BF69
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbjFLKoE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbjFLKns (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:43:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8B45585
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:28:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE809614F0
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:28:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3CDFC433D2;
        Mon, 12 Jun 2023 10:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686565712;
        bh=sRuvSVjdUbLYSNb7nubet0wDbUGFIx/qOAgwbh2ZTwY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lfOH5AywOptUcDYPDijgccKNOUKz5rMUDOwudyh1bufBbbGu9576u7xA9nJ9mJ+M0
         0y858CMm3zNd5rJbcjxtfv/jvwdlZWwZqwvSWbs6UltgiuX0W2WaizZ/IDHIH85pMM
         EEu4WzA4+UDIB25gBx8geUzT0/Ti7Hgcm6rSswg8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev
Subject: [PATCH 4.14 01/21] i40iw: fix build warning in i40iw_manage_apbvt()
Date:   Mon, 12 Jun 2023 12:25:56 +0200
Message-ID: <20230612101651.113244891@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101651.048240731@linuxfoundation.org>
References: <20230612101651.048240731@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
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
@@ -414,9 +414,8 @@ void i40iw_manage_arp_cache(struct i40iw
 			    bool ipv4,
 			    u32 action);
 
-int i40iw_manage_apbvt(struct i40iw_device *iwdev,
-		       u16 accel_local_port,
-		       bool add_port);
+enum i40iw_status_code i40iw_manage_apbvt(struct i40iw_device *iwdev,
+					  u16 accel_local_port, bool add_port);
 
 struct i40iw_cqp_request *i40iw_get_cqp_request(struct i40iw_cqp *cqp, bool wait);
 void i40iw_free_cqp_request(struct i40iw_cqp *cqp, struct i40iw_cqp_request *cqp_request);


