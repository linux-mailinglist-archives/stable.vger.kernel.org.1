Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F3E73E893
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjFZS1Q (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjFZS0r (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:26:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095BA2958
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:26:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81EE760F4B
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:26:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A97C433C0;
        Mon, 26 Jun 2023 18:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803983;
        bh=sUs2utKDvapCLAe4fzU8pdGLi0gtV78znY3+ecpyQZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ORVtoCld2dVxoRj+x4MnmRe92VJJiMb6WS4/QQMCOTI6o6IOF+a83x8ZBzg0Pgh1T
         8mdYclm2tFDV8aMARPsdAeJ29ozsH5iwSANvOX2jQe9CpYDsWoOFCvmP0nzF6UGrRQ
         eqOrT/hQ3pBf4BXTOXKLGUcUABa3f1A4vn9GtSTY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 32/41] media: cec: core: dont set last_initiator if tx in progress
Date:   Mon, 26 Jun 2023 20:11:55 +0200
Message-ID: <20230626180737.477064702@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180736.243379844@linuxfoundation.org>
References: <20230626180736.243379844@linuxfoundation.org>
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

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

[ Upstream commit 73af6c7511038249cad3d5f3b44bf8d78ac0f499 ]

When a message was received the last_initiator is set to 0xff.
This will force the signal free time for the next transmit
to that for a new initiator. However, if a new transmit is
already in progress, then don't set last_initiator, since
that's the initiator of the current transmit. Overwriting
this would cause the signal free time of a following transmit
to be that of the new initiator instead of a next transmit.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/cec/cec-adap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/cec/cec-adap.c b/drivers/media/cec/cec-adap.c
index a42043379d676..2f49c4db49b35 100644
--- a/drivers/media/cec/cec-adap.c
+++ b/drivers/media/cec/cec-adap.c
@@ -1032,7 +1032,8 @@ void cec_received_msg_ts(struct cec_adapter *adap,
 	mutex_lock(&adap->lock);
 	dprintk(2, "%s: %*ph\n", __func__, msg->len, msg->msg);
 
-	adap->last_initiator = 0xff;
+	if (!adap->transmit_in_progress)
+		adap->last_initiator = 0xff;
 
 	/* Check if this message was for us (directed or broadcast). */
 	if (!cec_msg_is_broadcast(msg))
-- 
2.39.2



