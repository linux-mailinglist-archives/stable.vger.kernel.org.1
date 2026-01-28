Return-Path: <stable+bounces-212588-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBpuGMw7emlB4wEAu9opvQ
	(envelope-from <stable+bounces-212588-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:39:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF356A5F51
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0551313B3E4
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA6F286D4B;
	Wed, 28 Jan 2026 16:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sjBjqWlO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F0D308F05;
	Wed, 28 Jan 2026 16:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769616022; cv=none; b=U6Y4Z2NYKKU1I/E4Ed3ALQCOApelmaAoPFv3gUe6ltpX5lX5WORr5xD3MkbTrAX/I2/DVcfHn9gipDMr2nePo/iEs4OJ7Ytve1GgkY70n8BUUL++j+S/GmG+ExFcPNFsfR0OO2wrjH+GuNeGtz/pmOYwkF7k5T0Kdr7Ep1XGIyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769616022; c=relaxed/simple;
	bh=+cyi7o2aQ2NDt45hRnvA9NcZQ/TSfaeEMi0ZH6rItoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R+C/+5YqMhFSDg1baf0nK205w9Uu3z8f5QxKPbRlp/l8bmoQA9n8SUoJPlJwMNSQpIUM6DGEodg/YvtVXhyvwK9J68Gk8AW7XhUeuq6XKgvy/xjKqvIy/EySqX2fBqivzvZrRfCo+QbsyLOV2YdxdJidxSGnz3RUiciayDsthZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sjBjqWlO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E002C4CEF1;
	Wed, 28 Jan 2026 16:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769616021;
	bh=+cyi7o2aQ2NDt45hRnvA9NcZQ/TSfaeEMi0ZH6rItoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sjBjqWlOrsiSLVrf5tS1eR2Hw0l58oiS2sKMqkmjEqUQTrHKg2PboA/5uEfxAIfH2
	 DoLAKfL9CB8HQHq4QYsEFUspTE6tASAlsPkcUZ5OUNE2A0kOfM4WZWQ8/tFxw8yDqE
	 bVhZdMTVhJddgrQDRMSMr/O9qe1nrAUlZP+wfbio=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 6.18 184/227] slimbus: core: fix runtime PM imbalance on report present
Date: Wed, 28 Jan 2026 16:23:49 +0100
Message-ID: <20260128145351.066463014@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
References: <20260128145344.331957407@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212588-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: AF356A5F51
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -489,21 +489,23 @@ int slim_device_report_present(struct sl
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



