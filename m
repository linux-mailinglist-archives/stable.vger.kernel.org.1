Return-Path: <stable+bounces-210560-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABvsDGrMb2mgMQAAu9opvQ
	(envelope-from <stable+bounces-210560-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 19:41:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9675149A79
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 19:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D912C98D3E8
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 15:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC5D441024;
	Tue, 20 Jan 2026 15:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zhrbxwPY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDD42EBDD9
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 15:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768921236; cv=none; b=X8/KOwyHpv6KS+lp8bmhMc4XRRA0bn8anH9ANHeAlDTBeQxj5SWE405AjVCXi6ghxXhlCkPRredUZ1vQrkgVboXfXQ4lu0d0BEo9y6OS2vtN2qj03RxW0Ds9X6ow9howCY8wLB/HnXpXom9AI7lPCNuUwO+kKjDeBV8xDyVZ2rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768921236; c=relaxed/simple;
	bh=ssqIdPnyoIlqHAGGutdO12Nc2rVGP4JucDbpYnD9hcw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=S2pR5Y8AEoG9RU0snmQvSklQgW0kGqm0/2GdMNNgtTMZ+f+XcbYdmLJB7CxZKm3RFe6HpS4x3u4LD0+w9XszdlSvJfyl6rJkuJSA+YqFGYBH4Os7qnwwKvLtKj62z/A1hWlEDd5RPWQ78uax2dh+buK4bXHpwvkehJO14+wWpP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zhrbxwPY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15C6C16AAE;
	Tue, 20 Jan 2026 15:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768921236;
	bh=ssqIdPnyoIlqHAGGutdO12Nc2rVGP4JucDbpYnD9hcw=;
	h=Subject:To:Cc:From:Date:From;
	b=zhrbxwPYP+ZORIhh9blvFkt0DfaJCd9lboZVN/ngD7xwuJgYN+8Xuz0hKlEA3OcPC
	 mlia78BtI8HSpDsisVQ7Gqp3tZ1lMFUB17oxJbhBpYUEOwLrieZj804syFzkwCfce2
	 Z3rPhj6LEBwxA/dasAOxDqh0bBAZZ71R2a7u8mQ8=
Subject: FAILED: patch "[PATCH] drm/amdkfd: fix a memory leak in device_queue_manager_init()" failed to apply to 5.10-stable tree
To: lihaoxiang@isrc.iscas.ac.cn,Oak.Zeng@amd.com,alexander.deucher@amd.com,felix.kuehling@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 20 Jan 2026 16:00:23 +0100
Message-ID: <2026012022-crouton-kilogram-6b06@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.54 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210560-lists,stable=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,gregkh:email]
X-Rspamd-Queue-Id: 9675149A79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 80614c509810fc051312d1a7ccac8d0012d6b8d0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026012022-crouton-kilogram-6b06@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 80614c509810fc051312d1a7ccac8d0012d6b8d0 Mon Sep 17 00:00:00 2001
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Date: Thu, 8 Jan 2026 15:18:22 +0800
Subject: [PATCH] drm/amdkfd: fix a memory leak in device_queue_manager_init()

If dqm->ops.initialize() fails, add deallocate_hiq_sdma_mqd()
to release the memory allocated by allocate_hiq_sdma_mqd().
Move deallocate_hiq_sdma_mqd() up to ensure proper function
visibility at the point of use.

Fixes: 11614c36bc8f ("drm/amdkfd: Allocate MQD trunk for HIQ and SDMA")
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Oak Zeng <Oak.Zeng@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit b7cccc8286bb9919a0952c812872da1dcfe9d390)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index d7a2e7178ea9..8af0929ca40a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2919,6 +2919,14 @@ static int allocate_hiq_sdma_mqd(struct device_queue_manager *dqm)
 	return retval;
 }
 
+static void deallocate_hiq_sdma_mqd(struct kfd_node *dev,
+				    struct kfd_mem_obj *mqd)
+{
+	WARN(!mqd, "No hiq sdma mqd trunk to free");
+
+	amdgpu_amdkfd_free_gtt_mem(dev->adev, &mqd->gtt_mem);
+}
+
 struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev)
 {
 	struct device_queue_manager *dqm;
@@ -3042,19 +3050,14 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev)
 		return dqm;
 	}
 
+	if (!dev->kfd->shared_resources.enable_mes)
+		deallocate_hiq_sdma_mqd(dev, &dqm->hiq_sdma_mqd);
+
 out_free:
 	kfree(dqm);
 	return NULL;
 }
 
-static void deallocate_hiq_sdma_mqd(struct kfd_node *dev,
-				    struct kfd_mem_obj *mqd)
-{
-	WARN(!mqd, "No hiq sdma mqd trunk to free");
-
-	amdgpu_amdkfd_free_gtt_mem(dev->adev, &mqd->gtt_mem);
-}
-
 void device_queue_manager_uninit(struct device_queue_manager *dqm)
 {
 	dqm->ops.stop(dqm);


