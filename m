Return-Path: <stable+bounces-232327-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sI0LG9D/y2koNQYAu9opvQ
	(envelope-from <stable+bounces-232327-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:09:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F7336E061
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5A7530F49B2
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789722D77F5;
	Tue, 31 Mar 2026 17:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oyT8i6t8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE132D4B40;
	Tue, 31 Mar 2026 17:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976464; cv=none; b=hINEiukTfR7n0KX/eduJdtn2Qh5vpDJN+sjFTpi8k/V/V4+0N2JOpIYdZAaLvTn9gkv4CL8BoxoluzF2RupwZTvtWNxFuVUkpPebO1J+dgbFmz3v8BBKH9FILgorElg0em1InDDccR/wAHYgaYunK0GTp+9ej6pop0kKcFcoS74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976464; c=relaxed/simple;
	bh=XfA+yUbG12p7sTAzySZ1HBAH14S35AdY4OB0TkhwNpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tU4GtMj4yVsNBg7fsYrteDHZaJcRNHZesTVGYVCjK3Ahh0BglxKLxsW+V1X7qaTLk8gGgXXTGVZ2HGfOvv+oY4iZ6IqSJFxrrNocUapR4EfDBdq2sWdptEGlw13gfNQ0HH08l3ojFtTLVhziVyYOwnI37MU+gfXQA1ne+nqyuYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oyT8i6t8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE90C19423;
	Tue, 31 Mar 2026 17:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976464;
	bh=XfA+yUbG12p7sTAzySZ1HBAH14S35AdY4OB0TkhwNpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oyT8i6t8ZWNPrFwVuorv2vVsB/Du1gnDvjkSg9HcCOMCDSlEaRscWHDuGnxCkMiN4
	 v3o8MMwG33oxEo8CKGTlV5vXzzGaie9MbXK/pc99OOV0GbDZV0B0V4g0X/VGVpogaV
	 NpThMJQV5Z9IaEhLHvL8wb5KgmH2UIwJf+Nw7InI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David McFarland <corngood@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 103/309] platform/x86: intel-hid: disable wakeup_mode during hibernation
Date: Tue, 31 Mar 2026 18:20:06 +0200
Message-ID: <20260331161757.278144617@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161753.468533260@linuxfoundation.org>
References: <20260331161753.468533260@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232327-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,linux.intel.com,kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 10F7336E061
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David McFarland <corngood@gmail.com>

[ Upstream commit e02ea3ae8ee40d5835a845884c7b161a27c10bcb ]

Add a freeze handler which clears wakeup_mode. This fixes aborted hibernation on
Dell Precision 3880.

  Wakeup event detected during hibernation, rolling back

This system sends power button events during hibernation, even when triggered by
software.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218634
Fixes: 0c4cae1bc00d ("PM: hibernate: Avoid missing wakeup events during hibernation")
Signed-off-by: David McFarland <corngood@gmail.com>
Link: https://patch.msgid.link/20260205231629.1336348-1-corngood@gmail.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel/hid.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/hid.c b/drivers/platform/x86/intel/hid.c
index f2b309f6e458a..c5e80887d0cb0 100644
--- a/drivers/platform/x86/intel/hid.c
+++ b/drivers/platform/x86/intel/hid.c
@@ -432,6 +432,14 @@ static int intel_hid_pl_suspend_handler(struct device *device)
 	return 0;
 }
 
+static int intel_hid_pl_freeze_handler(struct device *device)
+{
+	struct intel_hid_priv *priv = dev_get_drvdata(device);
+
+	priv->wakeup_mode = false;
+	return intel_hid_pl_suspend_handler(device);
+}
+
 static int intel_hid_pl_resume_handler(struct device *device)
 {
 	intel_hid_pm_complete(device);
@@ -446,7 +454,7 @@ static int intel_hid_pl_resume_handler(struct device *device)
 static const struct dev_pm_ops intel_hid_pl_pm_ops = {
 	.prepare = intel_hid_pm_prepare,
 	.complete = intel_hid_pm_complete,
-	.freeze  = intel_hid_pl_suspend_handler,
+	.freeze  = intel_hid_pl_freeze_handler,
 	.thaw  = intel_hid_pl_resume_handler,
 	.restore  = intel_hid_pl_resume_handler,
 	.suspend  = intel_hid_pl_suspend_handler,
-- 
2.51.0




