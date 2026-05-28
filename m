Return-Path: <stable+bounces-254871-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FRcCf8qGGrneggAu9opvQ
	(envelope-from <stable+bounces-254871-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:46:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9150E5F17AA
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 034D93054F43
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 11:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDA73E3DA6;
	Thu, 28 May 2026 11:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qeE8jlCD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348973DDDD4
	for <stable@vger.kernel.org>; Thu, 28 May 2026 11:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779968595; cv=none; b=B5sv09LQxI9PVRcJzM4zxEoodBLz314R9T3/7z3YPfs6Zo5/9YTNqsVgM9i56A49R1ylV8MWcrxXuXiXFupeG5uxLfZK+9xpS32NAnkIbtQcYbWhI5oS8fd4mJ9WTqS4fc9VV7VxszroPwwm56jKO6lOS3CxLnYSltpXMW+rMcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779968595; c=relaxed/simple;
	bh=sSwaOEJn0918MaWPlGWFVegec2xOE2WeWW+XHVIItcc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PXISONy9Sc/2inmL65MTE2C74grvO6a2uggsEX/bhkJYvc78VQSXvTNLlNKGXoRO+ZUh1ytCyyYLftBriUyOsm6zA9/qU5Of3o1qghNhJ1is0DK+fo20tB8+BvCrXWWZxAFZ5hfwnR+jU/GHkSPBpnErHAsIIQCz7yAkRw2TC+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qeE8jlCD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40CDB1F000E9;
	Thu, 28 May 2026 11:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779968593;
	bh=tJ+TXj1iou2D2q1eeLe0TYkZthl4elPAHyPZIa3WL9s=;
	h=Subject:To:Cc:From:Date;
	b=qeE8jlCDmjaFDcZ4gpNXguZxrnf89wBpUCQsJv1kjKHsqeP6XLAm7iRCghlfsWXAO
	 IOPcP0WfPW13jjeymzsfXnDYBniblsGcZeq1T3+WHTmZTNpZR4ol3RmQEi0T3EiShh
	 DAvUIQBVG0CBxN3pk7L1SvJcx05mOV7Oj61Fv0u0=
Subject: FAILED: patch "[PATCH] i2c: tegra: make tegra_i2c_mutex_unlock() return void" failed to apply to 7.0-stable tree
To: sauravsc@amazon.com,andi.shyti@kernel.org,jonathanh@nvidia.com,stable@vger.kernel.org,treding@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 May 2026 13:42:20 +0200
Message-ID: <2026052820-freewill-rural-eb35@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254871-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,gregkh:email,nvidia.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9150E5F17AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 7.0-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.0.y
git checkout FETCH_HEAD
git cherry-pick -x 30792d12842901f5276f466a960962d5bfa15cc8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052820-freewill-rural-eb35@gregkh' --subject-prefix 'PATCH 7.0.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 30792d12842901f5276f466a960962d5bfa15cc8 Mon Sep 17 00:00:00 2001
From: Saurav Sachidanand <sauravsc@amazon.com>
Date: Thu, 7 May 2026 22:11:45 +0000
Subject: [PATCH] i2c: tegra: make tegra_i2c_mutex_unlock() return void

tegra_i2c_mutex_unlock() returning an error that overwrites the transfer
result causes silent loss of I2C transfer errors. If the transfer failed
but the unlock succeeded, the error was lost and the function incorrectly
reported success.

Rather than propagating the unlock error (which is not actionable by the
caller - the I2C message may have been sent regardless), convert the
function to return void and WARN on the unexpected condition. If the
unlock fails, subsequent lock attempts will fail anyway, making the error
visible on the next transfer.

Fixes: 6077cfd716fb ("i2c: tegra: Add support for SW mutex register")
Signed-off-by: Saurav Sachidanand <sauravsc@amazon.com>
Cc: <stable@vger.kernel.org> # v7.0+
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/20260507221145.62183-3-sauravsc@amazon.com

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index c24b8de0a9c7..479a1667e88d 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -589,25 +589,22 @@ static int tegra_i2c_mutex_lock(struct tegra_i2c_dev *i2c_dev)
 	return ret;
 }
 
-static int tegra_i2c_mutex_unlock(struct tegra_i2c_dev *i2c_dev)
+static void tegra_i2c_mutex_unlock(struct tegra_i2c_dev *i2c_dev)
 {
 	unsigned int reg = i2c_dev->hw->regs->sw_mutex;
 	u32 val, id;
 
 	if (!i2c_dev->hw->has_mutex)
-		return 0;
+		return;
 
 	val = readl(i2c_dev->base + reg);
 
 	id = FIELD_GET(I2C_SW_MUTEX_GRANT, val);
-	if (id && id != I2C_SW_MUTEX_ID_CCPLEX) {
-		dev_warn(i2c_dev->dev, "unable to unlock mutex, mutex is owned by: %u\n", id);
-		return -EPERM;
-	}
+	if (WARN(id && id != I2C_SW_MUTEX_ID_CCPLEX,
+		 "unable to unlock mutex, mutex is owned by: %u\n", id))
+		return;
 
 	writel(0, i2c_dev->base + reg);
-
-	return 0;
 }
 
 static void tegra_i2c_mask_irq(struct tegra_i2c_dev *i2c_dev, u32 mask)
@@ -1700,7 +1697,7 @@ static int tegra_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 			break;
 	}
 
-	ret = tegra_i2c_mutex_unlock(i2c_dev);
+	tegra_i2c_mutex_unlock(i2c_dev);
 	pm_runtime_put(i2c_dev->dev);
 
 	return ret ?: i;


