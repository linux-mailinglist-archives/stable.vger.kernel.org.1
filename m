Return-Path: <stable+bounces-211762-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MrQDOy4eGlzsQEAu9opvQ
	(envelope-from <stable+bounces-211762-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 14:09:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5452C94ABA
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 14:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6DA5D3002F6C
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 13:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9384334C9AC;
	Tue, 27 Jan 2026 13:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WYLZdj0l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D1B25FA05
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 13:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769519334; cv=none; b=nAzNdGG4m2XfLnfuiNhlTi+zRmSyE+OV1/C0WZPYOoux/JrkD3IgUo/oX6BoHGwQ1lLgC4v5+v0MxLSdN5duCRq324g/eyqbSOZ9Spaiw+0vdYQJGHM6a4wqcgKyWxf8Wqr3SN8zA1QWawQOUiQzhXCJbM+ifdkzYNye5smVbnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769519334; c=relaxed/simple;
	bh=/7DCYx7+RPAYJcoVkyF+paeh7FDLvut6mxYBJ4BzbVM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dsb9tnygJpC7xj9BISQ9ai4Qo+SrruHNOIqKDJVqYZBJPIglDlSvjG+vQokaablHWsaPp4xb/YF4/olYXyVCNZMrPK+p+sO4SR877JGB8bOzn3qU6qf9OVwRL5E1wI5nY2cdlPncl4NMaeImkqsQ5N3DQRhx3PUpUzq2e689QDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WYLZdj0l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E8BC116C6;
	Tue, 27 Jan 2026 13:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769519334;
	bh=/7DCYx7+RPAYJcoVkyF+paeh7FDLvut6mxYBJ4BzbVM=;
	h=Subject:To:Cc:From:Date:From;
	b=WYLZdj0lUPwF1ROK56Toc6WHU/u+9rDO7xuh0ZqDx8Qn7egRaAsUdLTCFYfBWYTdh
	 HqGV2iYHb/KovbO1YfqXAaCPHxJ4Cxi8DWnLZTgC8JHZ4GOjSbhwZx2hlUs6kHHLEn
	 IEz+qcVWa2j8zeN9BXB2RFMmkrZ53C+/VEyW+IS0=
Subject: FAILED: patch "[PATCH] of: platform: Use default match table for /firmware" failed to apply to 5.15-stable tree
To: robh@kernel.org,sudeep.holla@arm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 27 Jan 2026 14:08:50 +0100
Message-ID: <2026012750-reshoot-angler-7553@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211762-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email]
X-Rspamd-Queue-Id: 5452C94ABA
X-Rspamd-Action: no action


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 48e6a9c4a20870e09f85ff1a3628275d6bce31c0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026012750-reshoot-angler-7553@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 48e6a9c4a20870e09f85ff1a3628275d6bce31c0 Mon Sep 17 00:00:00 2001
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Tue, 13 Jan 2026 19:51:58 -0600
Subject: [PATCH] of: platform: Use default match table for /firmware

Calling of_platform_populate() without a match table will only populate
the immediate child nodes under /firmware. This is usually fine, but in
the case of something like a "simple-mfd" node such as
"raspberrypi,bcm2835-firmware", those child nodes will not be populated.
And subsequent calls won't work either because the /firmware node is
marked as processed already.

Switch the call to of_platform_default_populate() to solve this problem.
It should be a nop for existing cases.

Fixes: 3aa0582fdb82 ("of: platform: populate /firmware/ node from of_platform_default_populate_init()")
Cc: stable@vger.kernel.org
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Link: https://patch.msgid.link/20260114015158.692170-2-robh@kernel.org
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index f77cb19973a5..a6dca3a005aa 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -569,7 +569,7 @@ static int __init of_platform_default_populate_init(void)
 
 		node = of_find_node_by_path("/firmware");
 		if (node) {
-			of_platform_populate(node, NULL, NULL, NULL);
+			of_platform_default_populate(node, NULL, NULL);
 			of_node_put(node);
 		}
 


