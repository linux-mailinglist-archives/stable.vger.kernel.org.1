Return-Path: <stable+bounces-149151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B383ACB141
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9A4D402C87
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750172253BC;
	Mon,  2 Jun 2025 14:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rNdfdhiK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D062C327B;
	Mon,  2 Jun 2025 14:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748873059; cv=none; b=Ba4jUpFdz4elwCPe3hTkVnZIMyw/mZNmo6ZDWA9MM8l0zvdFB5E1nIUhQ1LXp3vFw4OPUEiDtL99rzTV8GkKzsJ2Q7DNIYwH1fkPXR6N2fX+fk04UNpwbAu6EyDV5+/5qwHzBzflQRUdeqxzobtzezUzYZpJgiIuwbMpgI43au4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748873059; c=relaxed/simple;
	bh=a5YEk8S/yNaHvGtemdrdw1d6yQKl4leeRP8Y761wMp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gWDXr1ewY7Dd3PaUu6Wfds4uRu2BKzgKJzU/+fMiO4U5m5Vtz67oqsFBy1eOOZ+IjiEkIX7ow8Q27QK6idOJuqYCj/OIqhak8bYQBhf9RMK6nhFW7587uHTCQXVOA+QO9zjR5HYMjS8FOb6RsBt4Edr/FvEz3/YZvHyXqeUKDew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rNdfdhiK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EDBCC4CEEB;
	Mon,  2 Jun 2025 14:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748873059;
	bh=a5YEk8S/yNaHvGtemdrdw1d6yQKl4leeRP8Y761wMp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rNdfdhiKBc2316tUGM2ZAJFCxXS8yZ+smbn4zQ0y1zy8BSvA/RI2ZZa7VhX8k4y7h
	 NRARBxPbYMxra5TkBGKfVaMobwDAxK1Wvclb1ipwDNN/xeswTu3xhcTR11Nf26mVYj
	 40u46iiTate2c7sZnxLkzmLcwetLDlmjc74FO+PU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dongli Zhang <dongli.zhang@oracle.com>,
	Jason Wang <jasowang@redhat.com>,
	Mike Christie <michael.christie@oracle.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 025/444] vhost-scsi: protect vq->log_used with vq->mutex
Date: Mon,  2 Jun 2025 15:41:29 +0200
Message-ID: <20250602134341.944266241@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134340.906731340@linuxfoundation.org>
References: <20250602134340.906731340@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dongli Zhang <dongli.zhang@oracle.com>

[ Upstream commit f591cf9fce724e5075cc67488c43c6e39e8cbe27 ]

The vhost-scsi completion path may access vq->log_base when vq->log_used is
already set to false.

    vhost-thread                       QEMU-thread

vhost_scsi_complete_cmd_work()
-> vhost_add_used()
   -> vhost_add_used_n()
      if (unlikely(vq->log_used))
                                      QEMU disables vq->log_used
                                      via VHOST_SET_VRING_ADDR.
                                      mutex_lock(&vq->mutex);
                                      vq->log_used = false now!
                                      mutex_unlock(&vq->mutex);

				      QEMU gfree(vq->log_base)
        log_used()
        -> log_write(vq->log_base)

Assuming the VMM is QEMU. The vq->log_base is from QEMU userpace and can be
reclaimed via gfree(). As a result, this causes invalid memory writes to
QEMU userspace.

The control queue path has the same issue.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Mike Christie <michael.christie@oracle.com>
Message-Id: <20250403063028.16045-2-dongli.zhang@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vhost/scsi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 8d8a22504d71f..724dd69c86489 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -560,6 +560,9 @@ static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
 	int ret;
 
 	llnode = llist_del_all(&svq->completion_list);
+
+	mutex_lock(&svq->vq.mutex);
+
 	llist_for_each_entry_safe(cmd, t, llnode, tvc_completion_list) {
 		se_cmd = &cmd->tvc_se_cmd;
 
@@ -593,6 +596,8 @@ static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
 		vhost_scsi_release_cmd_res(se_cmd);
 	}
 
+	mutex_unlock(&svq->vq.mutex);
+
 	if (signal)
 		vhost_signal(&svq->vs->dev, &svq->vq);
 }
@@ -1301,8 +1306,11 @@ static void vhost_scsi_tmf_resp_work(struct vhost_work *work)
 		resp_code = VIRTIO_SCSI_S_FUNCTION_REJECTED;
 	}
 
+	mutex_lock(&tmf->svq->vq.mutex);
 	vhost_scsi_send_tmf_resp(tmf->vhost, &tmf->svq->vq, tmf->in_iovs,
 				 tmf->vq_desc, &tmf->resp_iov, resp_code);
+	mutex_unlock(&tmf->svq->vq.mutex);
+
 	vhost_scsi_release_tmf_res(tmf);
 }
 
-- 
2.39.5




