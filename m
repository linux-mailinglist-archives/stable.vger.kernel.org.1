Return-Path: <stable+bounces-263363-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kW0bD8YhMGpkOgUAu9opvQ
	(envelope-from <stable+bounces-263363-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 18:01:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB6068808B
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 18:01:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=e584rPKS;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263363-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-263363-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 769D43031A2F
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 15:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36A73CF041;
	Mon, 15 Jun 2026 15:52:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D044071D6
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:52:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538756; cv=none; b=t4hpK/L4Py/KjwIKq35XUvMxf8qDBrYaC1nzA+klQ8lOO8dpihg+rhbQUkODrFIax9lZtipH2/qpFPkD4sbbqXXv68riGaXO50yT57Ubo+v/IHATR3o2NXDnJPzhx3HAyTPl45jfX/4HjpXMfeXby2orFc6rBcdt3MGrTow8AMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538756; c=relaxed/simple;
	bh=/SVwXyFZ8yo3H6+jvIpkZ/LM/IR0f737r/Stl9DT5p8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=W++yE8Xsp1GyeprjBRZtS6aFpKZYSWWeFS0VEcRmKM4UlmA2R63Max498zNDE93yHb3LgJgJiNMBe0H/iySZoGtoVe3bUQhPPDUoG2StsE1PFJQS3vxe2B6aUqc8yQNVSRx02XbY6BrfA2N25ds/ZFmBqEsOvkxfXdzMmKJLbZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e584rPKS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5613F1F000E9;
	Mon, 15 Jun 2026 15:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781538755;
	bh=tmitxOdM9HwekJT6FN+H1uYzn3NBTeHw+91fV3mzk9Q=;
	h=Subject:To:Cc:From:Date;
	b=e584rPKSskG2ElY3mkRIVg+3nX1CUqdkI4x43a0SfLQSGZutW3kD1+3qW3nP7+KaF
	 p6Wku4vV9sbq34MjJ8+Cmnd9Xp55aD3hhCrH2g1VCIIIIWNEiMhrb3w3YHfyesmL6K
	 pNeydagK+SuLzBSQynARPvuOpsbuszce3kvWNCB4=
Subject: FAILED: patch "[PATCH] slimbus: qcom-ngd-ctrl: Fix probe error path ordering" failed to apply to 6.6-stable tree
To: bjorn.andersson@oss.qualcomm.com,dmitry.baryshkov@oss.qualcomm.com,gregkh@linuxfoundation.org,mukesh.ojha@oss.qualcomm.com,srini@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 17:46:42 +0200
Message-ID: <2026061542-agency-national-2795@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263363-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:bjorn.andersson@oss.qualcomm.com,m:dmitry.baryshkov@oss.qualcomm.com,m:gregkh@linuxfoundation.org,m:mukesh.ojha@oss.qualcomm.com,m:srini@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:from_mime,gregkh:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4DB6068808B


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 2c22ff152d380ec3d3af099fa05d0ac5ca9b4c1e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061542-agency-national-2795@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2c22ff152d380ec3d3af099fa05d0ac5ca9b4c1e Mon Sep 17 00:00:00 2001
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Date: Sat, 30 May 2026 21:44:16 +0100
Subject: [PATCH] slimbus: qcom-ngd-ctrl: Fix probe error path ordering

qcom_slim_ngd_ctrl_probe() first registers the SSR callback then
allocates the PDR context, as such the error path needs to come in
opposite order to allow us to unroll each step.

Fixes: 16f14551d0df ("slimbus: qcom-ngd: cleanup in probe error path")
Cc: stable@vger.kernel.org
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
Link: https://patch.msgid.link/20260530204421.116824-4-srini@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 47ba9fb34d25..6b91a6f11cb6 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1660,22 +1660,21 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 	if (IS_ERR(ctrl->pdr)) {
 		ret = dev_err_probe(dev, PTR_ERR(ctrl->pdr),
 				    "Failed to init PDR handle\n");
-		goto err_pdr_alloc;
+		goto err_unregister_ssr;
 	}
 
 	pds = pdr_add_lookup(ctrl->pdr, "avs/audio", "msm/adsp/audio_pd");
 	if (IS_ERR(pds) && PTR_ERR(pds) != -EALREADY) {
 		ret = dev_err_probe(dev, PTR_ERR(pds), "pdr add lookup failed\n");
-		goto err_pdr_lookup;
+		goto err_pdr_release;
 	}
 
 	return of_qcom_slim_ngd_register(dev, ctrl);
 
-err_pdr_alloc:
-	qcom_unregister_ssr_notifier(ctrl->notifier, &ctrl->nb);
-
-err_pdr_lookup:
+err_pdr_release:
 	pdr_handle_release(ctrl->pdr);
+err_unregister_ssr:
+	qcom_unregister_ssr_notifier(ctrl->notifier, &ctrl->nb);
 
 	return ret;
 }


