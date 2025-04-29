Return-Path: <stable+bounces-137342-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2772AAA12DB
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C67A4C135B
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 16:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA23253956;
	Tue, 29 Apr 2025 16:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vGfgE/9K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0B625394B;
	Tue, 29 Apr 2025 16:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745945782; cv=none; b=SN34t+DJ/26zU/f6r8LIjw23ZIz8BLr0d4MO0RBDumnRLd1m0tTw5pHScr6UclaRHhBpFiVMkrIdeheDKhPqdzpi3cx/e74JCoTxw38550YU4oERmd9ujmIMC/05ZhyMNcjM3yYOZfvAQAY9YIQozXvqV5PKkPGtOyECGo4s8tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745945782; c=relaxed/simple;
	bh=VD+LTbvyIr6IMHWSLQIWFWbwK4ecDHWpm/y9/6lxlNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a7aeWPAk2SGzjKYEoVWLlvOeQB9XoPescW8TETH8vqQj2dpk3GqcAG0nTiwIqWC/9WmWMlv+jbl01cAQiuFKjZX7fYF4ZgEPJJUsuuOpCwVI4mazgibo3qULaqno5prScDFIinsCsG0Zn3u6GxOwJ5WwgSDRAc/qJtF+yRihD6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vGfgE/9K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C700FC4CEE9;
	Tue, 29 Apr 2025 16:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745945782;
	bh=VD+LTbvyIr6IMHWSLQIWFWbwK4ecDHWpm/y9/6lxlNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vGfgE/9KgTDvFzsHLgAWXDc+5FKYNfTiUk+5pqAnPkaLIFyy7jInbwC5RCycVS3vt
	 vE7qc/4fL4m+f0rhSG3IX4spATAL/UdgjfVYfV/6ZPLuegSA9xBvdII2dzrx35gB4x
	 ong+h5oj10WrDRFu6mrtZfLkw4ZddKn6Q/uqv2SI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mike Christie <michael.christie@oracle.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 047/311] vhost-scsi: Add better resource allocation failure handling
Date: Tue, 29 Apr 2025 18:38:04 +0200
Message-ID: <20250429161122.950679036@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161121.011111832@linuxfoundation.org>
References: <20250429161121.011111832@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Christie <michael.christie@oracle.com>

[ Upstream commit 3ca51662f8186b569b8fb282242c20ccbb3993c2 ]

If we can't allocate mem to map in data for a request or can't find
a tag for a command, we currently drop the command. This leads to the
error handler running to clean it up. Instead of dropping the command
this has us return an error telling the initiator that it queued more
commands than we can handle. The initiator will then reduce how many
commands it will send us and retry later.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Message-Id: <20241203191705.19431-4-michael.christie@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Stable-dep-of: b18268713547 ("vhost-scsi: Fix vhost_scsi_send_bad_target()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vhost/scsi.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 7aeff435c1d87..ad7fa5bc0f5fc 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -630,7 +630,7 @@ vhost_scsi_get_cmd(struct vhost_virtqueue *vq, struct vhost_scsi_tpg *tpg,
 
 	tag = sbitmap_get(&svq->scsi_tags);
 	if (tag < 0) {
-		pr_err("Unable to obtain tag for vhost_scsi_cmd\n");
+		pr_warn_once("Guest sent too many cmds. Returning TASK_SET_FULL.\n");
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -929,6 +929,24 @@ static void vhost_scsi_target_queue_cmd(struct vhost_scsi_cmd *cmd)
 	target_submit(se_cmd);
 }
 
+static void
+vhost_scsi_send_status(struct vhost_scsi *vs, struct vhost_virtqueue *vq,
+		       int head, unsigned int out, u8 status)
+{
+	struct virtio_scsi_cmd_resp __user *resp;
+	struct virtio_scsi_cmd_resp rsp;
+	int ret;
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.status = status;
+	resp = vq->iov[out].iov_base;
+	ret = __copy_to_user(resp, &rsp, sizeof(rsp));
+	if (!ret)
+		vhost_add_used_and_signal(&vs->dev, vq, head, 0);
+	else
+		pr_err("Faulted on virtio_scsi_cmd_resp\n");
+}
+
 static void
 vhost_scsi_send_bad_target(struct vhost_scsi *vs,
 			   struct vhost_virtqueue *vq,
@@ -1216,8 +1234,8 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
 					 exp_data_len + prot_bytes,
 					 data_direction);
 		if (IS_ERR(cmd)) {
-			vq_err(vq, "vhost_scsi_get_cmd failed %ld\n",
-			       PTR_ERR(cmd));
+			ret = PTR_ERR(cmd);
+			vq_err(vq, "vhost_scsi_get_tag failed %dd\n", ret);
 			goto err;
 		}
 		cmd->tvc_vhost = vs;
@@ -1254,11 +1272,15 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
 		 * EINVAL: Invalid response buffer, drop the request
 		 * EIO:    Respond with bad target
 		 * EAGAIN: Pending request
+		 * ENOMEM: Could not allocate resources for request
 		 */
 		if (ret == -ENXIO)
 			break;
 		else if (ret == -EIO)
 			vhost_scsi_send_bad_target(vs, vq, vc.head, vc.out);
+		else if (ret == -ENOMEM)
+			vhost_scsi_send_status(vs, vq, vc.head, vc.out,
+					       SAM_STAT_TASK_SET_FULL);
 	} while (likely(!vhost_exceeds_weight(vq, ++c, 0)));
 out:
 	mutex_unlock(&vq->mutex);
-- 
2.39.5




