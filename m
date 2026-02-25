Return-Path: <stable+bounces-218110-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHDwKLlQnmlIUgQAu9opvQ
	(envelope-from <stable+bounces-218110-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:30:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4069D18ECC8
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3807F310733B
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DE62517AC;
	Wed, 25 Feb 2026 01:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fZWsy4Z1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E177E4369A;
	Wed, 25 Feb 2026 01:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771982888; cv=none; b=OidQ0nG6m4O7Xy36XisO/p8hx3madMQczuq2+FKal/wKDpc96IkAZCvJM9SnsSW+XTUsUxVTBw1fkhMKlzUn3lbVFacSSkMiJiS8/6gzLyXUn07hnx+bWvI0v8mH+oTXHzpF020nLjSkxFknqTb/EDve417kBtLAGvzj3dHq6kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771982888; c=relaxed/simple;
	bh=QjQK4eK9kd8faFesxzxo9eTM+g8cOW6u4RFJn433v/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I1i5aBXNAtATa78ya2hmGjjlHrEoGEHmAEoaZckrv04bQFjPaAqQZMDutSIKQzMk50idA3c9Pe5tdTYjsOAUu7NWiaVCmbixJ5kvIpI3sav1e5PLSQgtAg2oYuk8UtNGpdrOE1pnQToGHnVDgQlpmaGP99QC7DaCYThiGv+NA9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fZWsy4Z1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3936C116D0;
	Wed, 25 Feb 2026 01:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771982887;
	bh=QjQK4eK9kd8faFesxzxo9eTM+g8cOW6u4RFJn433v/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fZWsy4Z1p+imMO4ubMfIva8iYHADQTBDToBIKS7e+VXeoogXV9iWVQ+Z41MvkmbNt
	 ITTK1/Ka8vMpaqG3/jgFlPwyvyvQ/QoDa8J78XPfsZlkBx8NehzxRCW4VmStmk+Uiz
	 fggzy/WQzmo8eRF1jgUALDNAXJzLMQLYt3cI9KGo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gui-Dong Han <hanguidong02@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 065/781] PM: sleep: wakeirq: harden dev_pm_clear_wake_irq() against races
Date: Tue, 24 Feb 2026 17:12:54 -0800
Message-ID: <20260225012401.298231161@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-218110-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,intel.com,kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 4069D18ECC8
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gui-Dong Han <hanguidong02@gmail.com>

[ Upstream commit 5c9ecd8e6437cd55a38ea4f1e1d19cee8e226cb8 ]

dev_pm_clear_wake_irq() currently uses a dangerous pattern where
dev->power.wakeirq is read and checked for NULL outside the lock.
If two callers invoke this function concurrently, both might see
a valid pointer and proceed. This could result in a double-free
when the second caller acquires the lock and tries to release the
same object.

Address this by removing the lockless check of dev->power.wakeirq.
Instead, acquire dev->power.lock immediately to ensure the check and
the subsequent operations are atomic. If dev->power.wakeirq is NULL
under the lock, simply unlock and return. This guarantees that
concurrent calls cannot race to free the same object.

Based on a quick scan of current users, I did not find an actual bug as
drivers seem to rely on their own synchronization. However, since
asynchronous usage patterns exist (e.g., in
drivers/net/wireless/ti/wlcore), I believe a race is theoretically
possible if the API is used less carefully in the future. This change
hardens the API to be robust against such cases.

Fixes: 4990d4fe327b ("PM / Wakeirq: Add automated device wake IRQ handling")
Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
Link: https://patch.msgid.link/20260203031943.1924-1-hanguidong02@gmail.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/power/wakeirq.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
index 8aa28c08b2891..c0809d18fc540 100644
--- a/drivers/base/power/wakeirq.c
+++ b/drivers/base/power/wakeirq.c
@@ -83,13 +83,16 @@ EXPORT_SYMBOL_GPL(dev_pm_set_wake_irq);
  */
 void dev_pm_clear_wake_irq(struct device *dev)
 {
-	struct wake_irq *wirq = dev->power.wakeirq;
+	struct wake_irq *wirq;
 	unsigned long flags;
 
-	if (!wirq)
+	spin_lock_irqsave(&dev->power.lock, flags);
+	wirq = dev->power.wakeirq;
+	if (!wirq) {
+		spin_unlock_irqrestore(&dev->power.lock, flags);
 		return;
+	}
 
-	spin_lock_irqsave(&dev->power.lock, flags);
 	device_wakeup_detach_irq(dev);
 	dev->power.wakeirq = NULL;
 	spin_unlock_irqrestore(&dev->power.lock, flags);
-- 
2.51.0




