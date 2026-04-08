Return-Path: <stable+bounces-233776-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNbtBUn61Wn4/gcAu9opvQ
	(envelope-from <stable+bounces-233776-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 08:48:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 380A43B7B55
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 08:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 61E32301371A
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 06:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780DF22370A;
	Wed,  8 Apr 2026 06:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HeY4DRMm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3842D0614
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 06:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775630910; cv=none; b=o+EAQA+dhiuP4LeHEWXgsl15nE6eAHltX/iALdcGL7rvaVf097G7H2MhzSA0oYF5Qbzd3eI+mKRYULLTWsQocm3H3XKS4zIVHqVrFPNzUbrWDyjXt7p97cX4vgpVj9iPx6Os6ADy303AT7vEyaqwFBc9xx1vLxRY5ruhUAQ1y4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775630910; c=relaxed/simple;
	bh=jj4vsHhmyvWklZBA0ReybHPq5xTd0EAC4C0F2VS5aEU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Y34mUboP4lsT63Lr2V7DMHJar0+08NsQHAtYjEGzZnJfviioCJ4VmIAj/RPNPPHIjdjGjpiiGytz9SseRhzowclOuZyW06L3iIciw7i+oWGPVuSPFbp3CwDqw8vUvHHE9AWAqaAjTiu34ujWLewag5cvZ5yOx0RdgXjzQd6S6cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HeY4DRMm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 586B8C19424;
	Wed,  8 Apr 2026 06:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775630909;
	bh=jj4vsHhmyvWklZBA0ReybHPq5xTd0EAC4C0F2VS5aEU=;
	h=Subject:To:Cc:From:Date:From;
	b=HeY4DRMmcsfaWNiZSFYDxJOMJR5uteVGAJIIDXkqgASOnd6RJ77razi3OeFwCHLo9
	 smniKD1dTBt3VExrLgLlC3v+IjU2a01JKeEjyt9HSe9fKxfJoUPvRFM+d/j69d3/aB
	 JkX24l0rmxexrPtD1JckuCmdDH+UsEIKUQVOoE50=
Subject: FAILED: patch "[PATCH] spi: cadence-qspi: Fix exec_mem_op error handling" failed to apply to 6.1-stable tree
To: emanuele.ghidoli@toradex.com,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 08 Apr 2026 08:48:19 +0200
Message-ID: <2026040819-resend-amiss-2b5d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233776-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,gregkh:email,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,toradex.com:email]
X-Rspamd-Queue-Id: 380A43B7B55
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 59e1be1278f064d7172b00473b7e0c453cb1ec52
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026040819-resend-amiss-2b5d@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 59e1be1278f064d7172b00473b7e0c453cb1ec52 Mon Sep 17 00:00:00 2001
From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Date: Fri, 13 Mar 2026 14:52:31 +0100
Subject: [PATCH] spi: cadence-qspi: Fix exec_mem_op error handling

cqspi_exec_mem_op() increments the runtime PM usage counter before all
refcount checks are performed. If one of these checks fails, the function
returns without dropping the PM reference.

Move the pm_runtime_resume_and_get() call after the refcount checks so
that runtime PM is only acquired when the operation can proceed and
drop the inflight_ops refcount if the PM resume fails.

Cc: stable@vger.kernel.org
Fixes: 7446284023e8 ("spi: cadence-quadspi: Implement refcount to handle unbind during busy")
Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Link: https://patch.msgid.link/20260313135236.46642-1-ghidoliemanuele@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 5fb0cb07c110..2ead419e896e 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1483,14 +1483,6 @@ static int cqspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	if (refcount_read(&cqspi->inflight_ops) == 0)
 		return -ENODEV;
 
-	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
-		ret = pm_runtime_resume_and_get(dev);
-		if (ret) {
-			dev_err(&mem->spi->dev, "resume failed with %d\n", ret);
-			return ret;
-		}
-	}
-
 	if (!refcount_read(&cqspi->refcount))
 		return -EBUSY;
 
@@ -1502,6 +1494,14 @@ static int cqspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 		return -EBUSY;
 	}
 
+	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
+		ret = pm_runtime_resume_and_get(dev);
+		if (ret) {
+			dev_err(&mem->spi->dev, "resume failed with %d\n", ret);
+			goto dec_inflight_refcount;
+		}
+	}
+
 	ret = cqspi_mem_process(mem, op);
 
 	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM)))
@@ -1510,6 +1510,7 @@ static int cqspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	if (ret)
 		dev_err(&mem->spi->dev, "operation failed with %d\n", ret);
 
+dec_inflight_refcount:
 	if (refcount_read(&cqspi->inflight_ops) > 1)
 		refcount_dec(&cqspi->inflight_ops);
 


