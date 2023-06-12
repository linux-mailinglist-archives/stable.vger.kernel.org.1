Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B1572C0B2
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbjFLKyJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235965AbjFLKxr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:53:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2706587
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:38:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFEE2612E1
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:38:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D323DC433EF;
        Mon, 12 Jun 2023 10:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566338;
        bh=tfWdPRvcclp8G4QZU+xabn493pIUaeMFIIBQDGdFWEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Oanpwo82XIxBAPKWSl+HnG6Kv2ewjBjuidUAxi3aK7d5NBSCGS6hjDx0ATP0LlaSk
         3LJ7DVM4EOe6rHMzhyFVcDHvH86yAtmYnfyW50S98G3AAMITbOGN0A1RlYbTpHDm1n
         qWsF8Doou5bLUMZ6EnAyPoqoqOssD1DRID9fNBwg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shannon Nelson <shannon.nelson@amd.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 86/91] vhost_vdpa: support PACKED when setting-getting vring_base
Date:   Mon, 12 Jun 2023 12:27:15 +0200
Message-ID: <20230612101705.712493507@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101702.085813286@linuxfoundation.org>
References: <20230612101702.085813286@linuxfoundation.org>
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

From: Shannon Nelson <shannon.nelson@amd.com>

[ Upstream commit beee7fdb5b56a46415a4992d28dd4c2d06eb52df ]

Use the right structs for PACKED or split vqs when setting and
getting the vring base.

Fixes: 4c8cf31885f6 ("vhost: introduce vDPA-based backend")
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Message-Id: <20230424225031.18947-4-shannon.nelson@amd.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vhost/vdpa.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 299a995326185..9ca8b92d92ae4 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -392,7 +392,14 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 		if (r)
 			return r;
 
-		vq->last_avail_idx = vq_state.split.avail_index;
+		if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED)) {
+			vq->last_avail_idx = vq_state.packed.last_avail_idx |
+					     (vq_state.packed.last_avail_counter << 15);
+			vq->last_used_idx = vq_state.packed.last_used_idx |
+					    (vq_state.packed.last_used_counter << 15);
+		} else {
+			vq->last_avail_idx = vq_state.split.avail_index;
+		}
 		break;
 	}
 
@@ -410,9 +417,15 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 		break;
 
 	case VHOST_SET_VRING_BASE:
-		vq_state.split.avail_index = vq->last_avail_idx;
-		if (ops->set_vq_state(vdpa, idx, &vq_state))
-			r = -EINVAL;
+		if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED)) {
+			vq_state.packed.last_avail_idx = vq->last_avail_idx & 0x7fff;
+			vq_state.packed.last_avail_counter = !!(vq->last_avail_idx & 0x8000);
+			vq_state.packed.last_used_idx = vq->last_used_idx & 0x7fff;
+			vq_state.packed.last_used_counter = !!(vq->last_used_idx & 0x8000);
+		} else {
+			vq_state.split.avail_index = vq->last_avail_idx;
+		}
+		r = ops->set_vq_state(vdpa, idx, &vq_state);
 		break;
 
 	case VHOST_SET_VRING_CALL:
-- 
2.39.2



