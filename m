Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2257A7EFB
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235643AbjITMWi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235549AbjITMWi (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:22:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B385C2
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:22:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F59C433C8;
        Wed, 20 Sep 2023 12:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212552;
        bh=yC/H/WrEu44MKxrtfnGCGgFmZN4WNW3Ye4hyihrEKd0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=POQ423CpO4w7lofJ/8sUE3cHtRIhYN/sQ7gqxYhywtqNl4IO4mZjgQg231i8zGHTZ
         p+mrCcl32apxce52S/k1Da+k4vZgki2gy488/taaptVC3i65f4cauohv3OaRnShZw4
         +m8zHh8DVf8XiZdmrvdAOQM8dGdMAKfQMKVDdTPk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 43/83] media: pci: cx23885: replace BUG with error return
Date:   Wed, 20 Sep 2023 13:31:33 +0200
Message-ID: <20230920112828.380149127@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112826.634178162@linuxfoundation.org>
References: <20230920112826.634178162@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

[ Upstream commit 2e1796fd4904fdd6062a8e4589778ea899ea0c8d ]

It was completely unnecessary to use BUG in buffer_prepare().
Just replace it with an error return. This also fixes a smatch warning:

drivers/media/pci/cx23885/cx23885-video.c:422 buffer_prepare() error: uninitialized symbol 'ret'.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/cx23885/cx23885-video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/cx23885/cx23885-video.c b/drivers/media/pci/cx23885/cx23885-video.c
index a380e0920a21f..86e3bb5903712 100644
--- a/drivers/media/pci/cx23885/cx23885-video.c
+++ b/drivers/media/pci/cx23885/cx23885-video.c
@@ -412,7 +412,7 @@ static int buffer_prepare(struct vb2_buffer *vb)
 				dev->height >> 1);
 		break;
 	default:
-		BUG();
+		return -EINVAL; /* should not happen */
 	}
 	dprintk(2, "[%p/%d] buffer_init - %dx%d %dbpp 0x%08x - dma=0x%08lx\n",
 		buf, buf->vb.vb2_buf.index,
-- 
2.40.1



