Return-Path: <stable+bounces-245798-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFyjM5c6A2qh1wEAu9opvQ
	(envelope-from <stable+bounces-245798-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:35:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDBA522A13
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0BFA6309CA6F
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29783AFAF1;
	Tue, 12 May 2026 14:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u/XEBHIw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962DF3AB48C
	for <stable@vger.kernel.org>; Tue, 12 May 2026 14:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778596050; cv=none; b=rzK/GLF0U5z/Zqp+YinQL5jWEdla01odexO0VGq0A6kCANOYWGn3ClWvHlMA6Qzwow7A5EeW8HEppAGBUisDnxRNdmvFZWejDm2CZ/YPljr/ZyaPft91XQ49MSheskcookx9av7RYIR+ayi25jxAck9SyVLtTfc2IS79jvk18zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778596050; c=relaxed/simple;
	bh=HZUKOb6Es6laZiNBTYsFYSLcYxe8w0kw8y7rcSdBulI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WyPxYLdsXQmeR4HI5bm9A4AxUr0EvxjtcJqnWclG7KKoWBZNXu8WD/i6RLmLZyl0R/WSqvYG5tk0SlDmZ2x/GpyZeKqCK4izVzseV3h83ylWHXeHFhORoZidxgrr80/p7Ua4nzxsLQiXAy7BmsbuMRBerIykelvgvgtdCvhUL1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u/XEBHIw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE31C2BCF5;
	Tue, 12 May 2026 14:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778596050;
	bh=HZUKOb6Es6laZiNBTYsFYSLcYxe8w0kw8y7rcSdBulI=;
	h=Subject:To:Cc:From:Date:From;
	b=u/XEBHIwx7W8KjFVviGVMpORe7l7+ZV7zhqtGLpnl4PdK0sj0JFdNL+q8C4yqnJFU
	 TItUH7RWHeFw2zMk85K625DaNSuKE7vKzt3Mif4aX6J3JhbfMfRX56dMSb13aw2T/8
	 mqV9YT3JCU3BGl4UvpJeYc65M6tC+nbO0bqA93dY=
Subject: FAILED: patch "[PATCH] power: supply: cw2015: Free allocated workqueue" failed to apply to 6.12-stable tree
To: krzysztof.kozlowski@oss.qualcomm.com,andriy.shevchenko@linux.intel.com,sebastian.reichel@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 16:27:24 +0200
Message-ID: <2026051224-helium-chive-b18f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9CDBA522A13
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245798-lists,stable=lfdr.de];
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
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,msgid.link:url,intel.com:email,collabora.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x db254b0b232358ab1aeadebe8d147c99a3569559
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051224-helium-chive-b18f@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From db254b0b232358ab1aeadebe8d147c99a3569559 Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Thu, 5 Mar 2026 22:45:41 +0100
Subject: [PATCH] power: supply: cw2015: Free allocated workqueue

Use devm interface so allocated workqueue will be freed during device
removal and error paths, thus fixing a memory leak.

Change is not equivalent in the workqueue itself: use non-legacy API
which does not set (__WQ_LEGACY | WQ_MEM_RECLAIM).  The workqueue is
used to read updated data from the battery, thus there is no point to
run it for memory reclaim.

Cc: stable@vger.kernel.org
Fixes: b4c7715c10c1 ("power: supply: add CellWise cw2015 fuel gauge driver")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://patch.msgid.link/20260305-workqueue-devm-v2-2-66a38741c652@oss.qualcomm.com
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

diff --git a/drivers/power/supply/cw2015_battery.c b/drivers/power/supply/cw2015_battery.c
index a05dcc4a48f2..286524d2318c 100644
--- a/drivers/power/supply/cw2015_battery.c
+++ b/drivers/power/supply/cw2015_battery.c
@@ -694,7 +694,8 @@ static int cw_bat_probe(struct i2c_client *client)
 			 "No monitored battery, some properties will be missing\n");
 	}
 
-	cw_bat->battery_workqueue = create_singlethread_workqueue("rk_battery");
+	cw_bat->battery_workqueue = devm_alloc_ordered_workqueue(&client->dev,
+								 "rk_battery", 0);
 	if (!cw_bat->battery_workqueue)
 		return -ENOMEM;
 


