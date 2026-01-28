Return-Path: <stable+bounces-212082-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCqjG90uemmO3wEAu9opvQ
	(envelope-from <stable+bounces-212082-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:44:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 081CBA454F
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F52230D14BB
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34C3155757;
	Wed, 28 Jan 2026 15:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wLIb0FUT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A437923EAB7;
	Wed, 28 Jan 2026 15:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614340; cv=none; b=LicR3aCIvFpqMSzDsjAYCO7f/pGsSYUQ97QoGo6Gi3DoBZ3GFRQXTcHBUEfflY6IwpQguO8kfHyXIE5UY1w+L4G9r+echSihFOnWCC7wKWtMTf7fUN3HHhFkBrVU7nikminbjgpPn8DyxM7BUcBf/dMMzbe7u9vdU8Afsr9y034=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614340; c=relaxed/simple;
	bh=/RGzKA2etX539CJGIWkEfiNGua5FjJ/9HulmGSa49aU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lw79lx8sW3UXp/gUFdJZfEwDJg8vWbJCVEoHXXCFDyhGDlQPgQVZou1K+DQ7OtMlkKlnMg9tA7ruKqTA6CpeKc15k+8QgD6T5Du4N9vb1De6EAmVmww+9O+6SLf5i9lqiIy5fgBoI0amDIbL98I6rXoiD2C87TLdLqBW+szZofA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wLIb0FUT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA44C4CEF1;
	Wed, 28 Jan 2026 15:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769614340;
	bh=/RGzKA2etX539CJGIWkEfiNGua5FjJ/9HulmGSa49aU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wLIb0FUTX86YplcVt2ZTtH5QL6hrxhPH2cYgGqVvZVpUJS8oDp8m98MEsXjZNnMp4
	 vVGK8S/GqkqF4HVUIuKmhYYy6kmdBddyVdEhGGMzvAJojCVXHSRXtBItMfSzH9+W0A
	 I7y30U6TkjAWtLR6qZtzFYKU8f8GPgXbG+tREWdY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Oak Zeng <Oak.Zeng@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.6 074/254] drm/amdkfd: fix a memory leak in device_queue_manager_init()
Date: Wed, 28 Jan 2026 16:20:50 +0100
Message-ID: <20260128145347.357963434@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.698118637@linuxfoundation.org>
References: <20260128145344.698118637@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212082-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 081CBA454F
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>

commit 80614c509810fc051312d1a7ccac8d0012d6b8d0 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c |   19 ++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2446,6 +2446,14 @@ static int allocate_hiq_sdma_mqd(struct
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
@@ -2567,19 +2575,14 @@ struct device_queue_manager *device_queu
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



