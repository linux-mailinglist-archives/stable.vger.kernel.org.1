Return-Path: <stable+bounces-212182-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CsGIw02emnn4gEAu9opvQ
	(envelope-from <stable+bounces-212182-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:15:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DD4A5528
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA0EE316E054
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACF62DB784;
	Wed, 28 Jan 2026 15:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B6SS15uy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFC32D8760;
	Wed, 28 Jan 2026 15:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614663; cv=none; b=L5pOYE5nBF63YZ890upGIe39HhAWB4pQzX9IIE6i3nXFJ+0JDnA+V63BQcsooUPEc1QXA221Ch2V6sZA9R82k6QUHq6SVPUdfEePwD+MYDAUoOMf1mycmjbvoqJsCWn6lTSwqYBAO+KNqcW/cA7OS5j8qKZjKQxdauxcMlMU04A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614663; c=relaxed/simple;
	bh=1trXuZd451CI71XM3CycCQHgucChLjU9/r3QtVeagY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ormOanaIm44uqDloRERScHE7s1dCPBTvfQaV+AcrJ3Qsz7PoYvlftJC7sFMalnLW7p1GP5TuQHEzfM0fxv/dAsQ6Iywslk9NwuBnbYcuLMFGtJWXDAEoe/qw+tPyzUka4lCkaDu++sl6RV57FRRH3wcc8XLpnHrTlzqIZIuZInE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B6SS15uy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA661C116C6;
	Wed, 28 Jan 2026 15:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769614663;
	bh=1trXuZd451CI71XM3CycCQHgucChLjU9/r3QtVeagY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B6SS15uygJNAD4s66ewRTo9Jc1jhLTkZXp/IQrmVcMB15le3wuXI1KW08u83q9Jqq
	 SEvc9pxFu7lsEWBDgAHWlH/2cC4cQdiGgqkQHw6Q0u36IYYRJD2szsu1taG92CxOiU
	 EhLCXsioXaxohBM6I/RZNsAFhnH+YJ1Brl8EE30Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 6.6 203/254] slimbus: core: fix runtime PM imbalance on report present
Date: Wed, 28 Jan 2026 16:22:59 +0100
Message-ID: <20260128145352.099236788@linuxfoundation.org>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212182-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url]
X-Rspamd-Queue-Id: F1DD4A5528
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 0eb4ff6596114aabba1070a66afa2c2f5593739f upstream.

Make sure to balance the runtime PM usage count in case slimbus device
or address allocation fails on report present, which would otherwise
prevent the controller from suspending.

Fixes: 4b14e62ad3c9 ("slimbus: Add support for 'clock-pause' feature")
Cc: stable@vger.kernel.org	# 4.16
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20251126145329.5022-3-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/slimbus/core.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -496,21 +496,23 @@ int slim_device_report_present(struct sl
 	if (ctrl->sched.clk_state != SLIM_CLK_ACTIVE) {
 		dev_err(ctrl->dev, "slim ctrl not active,state:%d, ret:%d\n",
 				    ctrl->sched.clk_state, ret);
-		goto slimbus_not_active;
+		goto out_put_rpm;
 	}
 
 	sbdev = slim_get_device(ctrl, e_addr);
-	if (IS_ERR(sbdev))
-		return -ENODEV;
+	if (IS_ERR(sbdev)) {
+		ret = -ENODEV;
+		goto out_put_rpm;
+	}
 
 	if (sbdev->is_laddr_valid) {
 		*laddr = sbdev->laddr;
-		return 0;
+		ret = 0;
+	} else {
+		ret = slim_device_alloc_laddr(sbdev, true);
 	}
 
-	ret = slim_device_alloc_laddr(sbdev, true);
-
-slimbus_not_active:
+out_put_rpm:
 	pm_runtime_mark_last_busy(ctrl->dev);
 	pm_runtime_put_autosuspend(ctrl->dev);
 	return ret;



