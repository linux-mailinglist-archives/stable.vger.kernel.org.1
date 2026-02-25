Return-Path: <stable+bounces-218334-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKSKIMZRnmmbUgQAu9opvQ
	(envelope-from <stable+bounces-218334-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:35:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E1118F090
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E2225306CDAA
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FD11EB5E1;
	Wed, 25 Feb 2026 01:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jbnNO6Nw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC0418DB2A;
	Wed, 25 Feb 2026 01:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983140; cv=none; b=uquR/7xBO1Be8gO8I6pUxNJ9nLwCxfDkbp50k4oMxoY3Mr+rTnymKDFUyclKHV9OOyxfp1Z9ShJRYnuWnTV5qQ0FntbJkmu2XCB45XukYAx9Q4wTJBGunlFx7/Iv5dG93EwZT0UE0H1LjwA5NE6Yqh+jDPQNcPimvXZIvXNkdd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983140; c=relaxed/simple;
	bh=euh9su5Sdnj6hPb58bdQGNoZiJo+d0H/xEZiPb7DouM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hc/RmwV6zF/goKj6hafzoxw6v4beKDJmxxBFAPpTbfsLoca5yCTNG6vkw6uVFsrW+HL0oRffTdiIUZWcHs/5HL4CX++AnABYx0sXU9A6gKBCa48pDobmP/6s2tuKiem6dQdDaiCB7Z1JKaL0qRj0eO/JqpvcsJYOWwChYl0+9k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jbnNO6Nw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07FFBC116D0;
	Wed, 25 Feb 2026 01:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983140;
	bh=euh9su5Sdnj6hPb58bdQGNoZiJo+d0H/xEZiPb7DouM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jbnNO6NwJUtnHjlS+LwcBIjKFdX9wp6rq4SzbwQMFzcpfMRTRifheThxCybVU2is0
	 JhgGdf41uSaFqkUxov2lp/8HTfxATBQ9Q5VfIIIeGfA/XrXbruEiTy3RDiuqBxkEGv
	 7DJ9WLd0YLw+ML8TCcBj/yF81+pio9tmTWoytiRI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Lizhi Hou <lizhi.hou@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 294/781] accel/amdxdna: Stop job scheduling across aie2_release_resource()
Date: Tue, 24 Feb 2026 17:16:43 -0800
Message-ID: <20260225012406.921350988@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-218334-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,amd.com:email]
X-Rspamd-Queue-Id: 29E1118F090
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lizhi Hou <lizhi.hou@amd.com>

[ Upstream commit f1370241fe8045702bc9d0812b996791f0500f1b ]

Running jobs on a hardware context while it is in the process of
releasing resources can lead to use-after-free and crashes.

Fix this by stopping job scheduling before calling
aie2_release_resource() and restarting it after the release completes.
Additionally, aie2_sched_job_run() now checks whether the hardware
context is still active.

Fixes: 4fd6ca90fc7f ("accel/amdxdna: Refactor hardware context destroy routine")
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Link: https://patch.msgid.link/20260130003255.2083255-1-lizhi.hou@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/amdxdna/aie2_ctx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index 42d876a427c59..2c36ed7e9639c 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -315,6 +315,9 @@ aie2_sched_job_run(struct drm_sched_job *sched_job)
 	struct dma_fence *fence;
 	int ret;
 
+	if (hwctx->status != HWCTX_STAT_READY)
+		return NULL;
+
 	if (!mmget_not_zero(job->mm))
 		return ERR_PTR(-ESRCH);
 
@@ -693,7 +696,10 @@ void aie2_hwctx_fini(struct amdxdna_hwctx *hwctx)
 	aie2_hwctx_wait_for_idle(hwctx);
 
 	/* Request fw to destroy hwctx and cancel the rest pending requests */
+	drm_sched_stop(&hwctx->priv->sched, NULL);
 	aie2_release_resource(hwctx);
+	hwctx->status = HWCTX_STAT_STOP;
+	drm_sched_start(&hwctx->priv->sched, 0);
 
 	mutex_unlock(&xdna->dev_lock);
 	drm_sched_entity_destroy(&hwctx->priv->entity);
-- 
2.51.0




