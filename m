Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E1273E951
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbjFZSeq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbjFZSei (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:34:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585FF13D
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:34:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA99060F24
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:34:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 072F3C433C8;
        Mon, 26 Jun 2023 18:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804468;
        bh=kIsf8AbSmXSzhxQYkllhPv2Z+84eoqLgyPp+vctmyI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YrBcpANNytinjnb0A2SPCLwaUHFSGPg6A2sWEvRaTi//qzYDH260EI91BwA6Wo9UX
         +RlGQXJ5pUaUK9ShJ6HUQo2EYAsvpT0bjOkEP/AkqgQ9tVoE8VOKhtSwGPf7dyU7CG
         gYHSk4cs4pbBzy/55G+nt2aLAY5yASY3LyTQBd4o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Andrey Smetanin <asmetanin@yandex-team.ru>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 166/170] vhost_net: revert upend_idx only on retriable error
Date:   Mon, 26 Jun 2023 20:12:15 +0200
Message-ID: <20230626180807.916601652@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180800.476539630@linuxfoundation.org>
References: <20230626180800.476539630@linuxfoundation.org>
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

From: Andrey Smetanin <asmetanin@yandex-team.ru>

[ Upstream commit 1f5d2e3bab16369d5d4b4020a25db4ab1f4f082c ]

Fix possible virtqueue used buffers leak and corresponding stuck
in case of temporary -EIO from sendmsg() which is produced by
tun driver while backend device is not up.

In case of no-retriable error and zcopy do not revert upend_idx
to pass packet data (that is update used_idx in corresponding
vhost_zerocopy_signal_used()) as if packet data has been
transferred successfully.

v2: set vq->heads[ubuf->desc].len equal to VHOST_DMA_DONE_LEN
in case of fake successful transmit.

Signed-off-by: Andrey Smetanin <asmetanin@yandex-team.ru>
Message-Id: <20230424204411.24888-1-asmetanin@yandex-team.ru>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Andrey Smetanin <asmetanin@yandex-team.ru>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vhost/net.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 4c538b30fd76d..4418192ab8aaa 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -934,13 +934,18 @@ static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
 
 		err = sock->ops->sendmsg(sock, &msg, len);
 		if (unlikely(err < 0)) {
+			bool retry = err == -EAGAIN || err == -ENOMEM || err == -ENOBUFS;
+
 			if (zcopy_used) {
 				if (vq->heads[ubuf->desc].len == VHOST_DMA_IN_PROGRESS)
 					vhost_net_ubuf_put(ubufs);
-				nvq->upend_idx = ((unsigned)nvq->upend_idx - 1)
-					% UIO_MAXIOV;
+				if (retry)
+					nvq->upend_idx = ((unsigned)nvq->upend_idx - 1)
+						% UIO_MAXIOV;
+				else
+					vq->heads[ubuf->desc].len = VHOST_DMA_DONE_LEN;
 			}
-			if (err == -EAGAIN || err == -ENOMEM || err == -ENOBUFS) {
+			if (retry) {
 				vhost_discard_vq_desc(vq, 1);
 				vhost_net_enable_vq(net, vq);
 				break;
-- 
2.39.2



