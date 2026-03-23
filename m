Return-Path: <stable+bounces-228265-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SA4rBhxLwWlbSAQAu9opvQ
	(envelope-from <stable+bounces-228265-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:15:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6452F40C5
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BFE013174F0C
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C93F3B9616;
	Mon, 23 Mar 2026 14:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M0HU9FXO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D523B95F2;
	Mon, 23 Mar 2026 14:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274627; cv=none; b=jXtCrxvBFIUCDTYlVPw+XmqVcpIrPcJVCFR4ixUnEbN5XWcLuNAYdO24dIQRUXvdLbWzyKu6SA+CdzN8yVqlWKkCTZX18Fbb0iaqvSoBXLvg6KXHMkgkfK2J9MpFhuGQ+nI7kP3Y+GP5xkpVrbfyEkXF6I42L1V67ivjvM3j3yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274627; c=relaxed/simple;
	bh=+HNobCyjw9Qu6tkhltCztx/6Oy0sssVbZVkcwczxKOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=obPZ39Ch8XrRWpd0kz2iNdazIHEMurY2LG87IuvRlXQCUatnW0DYQyGWXtzo0us/+PdRe7XiqkVA3uITTHaJ9mdJ1TEDLwFMqLVnhdnWAtWuU98rgSFyGsBed9FsEv5/1O6RgPEUJ2fysHdPCyog7ZBsqVgUuQvWzVyTyb05wOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M0HU9FXO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF806C4CEF7;
	Mon, 23 Mar 2026 14:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274627;
	bh=+HNobCyjw9Qu6tkhltCztx/6Oy0sssVbZVkcwczxKOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M0HU9FXOLfMUUx7hl24UN3OmDB8jgfKe+hii4Ay6s8eU+35CO2ifVe6a7yJl4MM2o
	 lG1SYZFxhEL/1//+WbwhCj2bW4dXbZTl2436xcmvz5udyfwLZ2ydFm4Zt6V6YjQ7hJ
	 3/pTc6MFBXNJdwsQQwSkL1Oacjn4HiaagAzG6XHg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Jander <david@protonic.nl>,
	Johan Hovold <johan@kernel.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.18 057/212] spi: fix statistics allocation
Date: Mon, 23 Mar 2026 14:44:38 +0100
Message-ID: <20260323134505.572354121@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134503.770111826@linuxfoundation.org>
References: <20260323134503.770111826@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-228265-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,protonic.nl:email]
X-Rspamd-Queue-Id: 7E6452F40C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit dee0774bbb2abb172e9069ce5ffef579b12b3ae9 upstream.

The controller per-cpu statistics is not allocated until after the
controller has been registered with driver core, which leaves a window
where accessing the sysfs attributes can trigger a NULL-pointer
dereference.

Fix this by moving the statistics allocation to controller allocation
while tying its lifetime to that of the controller (rather than using
implicit devres).

Fixes: 6598b91b5ac3 ("spi: spi.c: Convert statistics to per-cpu u64_stats_t")
Cc: stable@vger.kernel.org	# 6.0
Cc: David Jander <david@protonic.nl>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260312151817.32100-3-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi.c |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2914,6 +2914,8 @@ static void spi_controller_release(struc
 	struct spi_controller *ctlr;
 
 	ctlr = container_of(dev, struct spi_controller, dev);
+
+	free_percpu(ctlr->pcpu_statistics);
 	kfree(ctlr);
 }
 
@@ -3057,6 +3059,12 @@ struct spi_controller *__spi_alloc_contr
 	if (!ctlr)
 		return NULL;
 
+	ctlr->pcpu_statistics = spi_alloc_pcpu_stats(NULL);
+	if (!ctlr->pcpu_statistics) {
+		kfree(ctlr);
+		return NULL;
+	}
+
 	device_initialize(&ctlr->dev);
 	INIT_LIST_HEAD(&ctlr->queue);
 	spin_lock_init(&ctlr->queue_lock);
@@ -3347,13 +3355,6 @@ int spi_register_controller(struct spi_c
 		if (status)
 			goto del_ctrl;
 	}
-	/* Add statistics */
-	ctlr->pcpu_statistics = spi_alloc_pcpu_stats(dev);
-	if (!ctlr->pcpu_statistics) {
-		dev_err(dev, "Error allocating per-cpu statistics\n");
-		status = -ENOMEM;
-		goto destroy_queue;
-	}
 
 	mutex_lock(&board_lock);
 	list_add_tail(&ctlr->list, &spi_controller_list);
@@ -3366,8 +3367,6 @@ int spi_register_controller(struct spi_c
 	acpi_register_spi_devices(ctlr);
 	return status;
 
-destroy_queue:
-	spi_destroy_queue(ctlr);
 del_ctrl:
 	device_del(&ctlr->dev);
 free_bus_id:



