Return-Path: <stable+bounces-264538-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uvAYKYB2MWrZjwUAu9opvQ
	(envelope-from <stable+bounces-264538-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:14:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFCD691DA2
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:14:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=p6po6iP8;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264538-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-264538-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 67EE5303F3EB
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B600466B5D;
	Tue, 16 Jun 2026 16:14:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E5144BCB8;
	Tue, 16 Jun 2026 16:14:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626455; cv=none; b=tuYC5xZAQDUGCvcZQQY5j+0H6h6/46ueJanM2tjhnzt/pjiof3llRGLRWqEeqMTwFHFUhzq8o5PEsArnCDnYsWlsykaW55sO19IrmpTbHD/0QJH7LCgeteoM8DRx8yKu5wXeXSX8wFv/Fih+VXMRVvhJn9ACiIjhDsrA5W8BVH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626455; c=relaxed/simple;
	bh=bGJ3mvSaZYW0DHtae7qG346lD7yEs/EaL6H57Yqdsew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m5rH5NwIMcUa+dGDEGKLUktWhKNSdz6EOS/e5EiCpT3St0unLqh//apiDy6D68Ma6ok6TJhMmHRjvHkPtrOUrOIns8AzmR4ApGHy70t1aApqynW63NkXETcHdJlgogeNAq9CipGSQlZP8ZG2DTXmGblJdqja12CRnfEC4tkDaow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p6po6iP8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28CE71F000E9;
	Tue, 16 Jun 2026 16:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781626454;
	bh=6vxqq9fxFwYOOE0ynnBrq8TRFw36cimmnqvDyUD1olk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=p6po6iP8wTppnB12zP5I0tfDV9KUtMj5PCfmlBGazDH7CBSfG6UTmJ2skQvar/edm
	 aTjYjLSHPH2A9toVUU9BWTcm8z7zeDFYIs49lO82ZwmgCt5V1+jL3ZiOEBGq+mM+gP
	 nw/kLVH0JL8CbaQGZJttFRBG5EuhgIjwElGkNles=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 6.18 281/325] slimbus: qcom-ngd-ctrl: Avoid ABBA on tx_lock/ctrl->lock
Date: Tue, 16 Jun 2026 20:31:17 +0530
Message-ID: <20260616145112.724897144@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145057.827196531@linuxfoundation.org>
References: <20260616145057.827196531@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264538-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:bjorn.andersson@oss.qualcomm.com,m:srini@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,msgid.link:url,vger.kernel.org:from_smtp,qualcomm.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3FFCD691DA2

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>

commit 55f2ea9ff83cc27a85526b14bc9b32f96a08d6ec upstream.

During the SSR/PDR down notification the tx_lock is taken with the
intent to provide synchronization with active DMA transfers.

But during this period qcom_slim_ngd_down() is invoked, which ends up in
slim_report_absent(), which takes the slim_controller lock. In multiple
other codepaths these two locks are taken in the opposite order (i.e.
slim_controller then tx_lock).

The result is a lockdep splat, and a possible deadlock:

  rprocctl/449 is trying to acquire lock:
  ffff00009793e620 (&ctrl->lock){+.+.}-{4:4}, at: slim_report_absent (drivers/slimbus/core.c:322) slimbus

  but task is already holding lock:
  ffff00009793fb50 (&ctrl->tx_lock){+.+.}-{4:4}, at: qcom_slim_ngd_ssr_pdr_notify (drivers/slimbus/qcom-ngd-ctrl.c:1475) slim_qcom_ngd_ctrl

  which lock already depends on the new lock.

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&ctrl->tx_lock);
                                lock(&ctrl->lock);
                                lock(&ctrl->tx_lock);
   lock(&ctrl->lock);

The assumption is that the comment refers to the desire to not call
qcom_slim_ngd_exit_dma() while we have an ongoing DMA TX transaction.
But any such transaction is initiated and completed within a single
qcom_slim_ngd_xfer_msg().

Prior to calling qcom_slim_ngd_exit_dma() the slim_controller is torn
down, all child devices are notified that the slimbus is gone and the
child devices are removed.

Stop taking the tx_lock in qcom_slim_ngd_ssr_pdr_notify() to avoid the
deadlock.

Fixes: a899d324863a ("slimbus: qcom-ngd-ctrl: add Sub System Restart support")
Cc: stable@vger.kernel.org
Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
Link: https://patch.msgid.link/20260530204421.116824-9-srini@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1471,15 +1471,12 @@ static int qcom_slim_ngd_ssr_pdr_notify(
 	switch (action) {
 	case QCOM_SSR_BEFORE_SHUTDOWN:
 	case SERVREG_SERVICE_STATE_DOWN:
-		/* Make sure the last dma xfer is finished */
-		mutex_lock(&ctrl->tx_lock);
 		if (ctrl->state != QCOM_SLIM_NGD_CTRL_DOWN) {
 			pm_runtime_get_noresume(ctrl->ctrl.dev);
 			ctrl->state = QCOM_SLIM_NGD_CTRL_DOWN;
 			qcom_slim_ngd_down(ctrl);
 			qcom_slim_ngd_exit_dma(ctrl);
 		}
-		mutex_unlock(&ctrl->tx_lock);
 		break;
 	case QCOM_SSR_AFTER_POWERUP:
 	case SERVREG_SERVICE_STATE_UP:



