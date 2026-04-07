Return-Path: <stable+bounces-233667-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kE0fOt0l1WnB1gcAu9opvQ
	(envelope-from <stable+bounces-233667-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 17:42:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3BE3B1330
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 17:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B081D30602AE
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 15:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CF53B635A;
	Tue,  7 Apr 2026 15:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VSakZNpo"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D11363C5F
	for <Stable@vger.kernel.org>; Tue,  7 Apr 2026 15:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775575614; cv=none; b=TV9z3egIT5vAGhvy4W/oMfBSJbe6ZCtoQvVzMEbyOFGT5CjiWbXzDZiG+E0MrLRAOVJ9/gU0xTgv2bSB91O2VkGWCz9IfMAB8NXF5oVZb4h2T9BKVJAStoSDbFwPOcs/FD/LU750zlqlYz4Ya7pXKD543fJZguVG08Ra352IETw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775575614; c=relaxed/simple;
	bh=FJ1vMZk1sphQYwviPOJZ5Kgr67vRtHDBF1aWJUBTMg0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=a8wcgdtaGD2vPNzS5q2m7JIr9Lr+avFUX34lxrgB11UOEvpyD77DGhn6VwhrpkwDWx3OMK0yzzWT2jXHejSWYFQiK0HiTCBXJ/QIDic1uL/wThcV3+7zkibVkRV59HVwb0QFOFYB0MR16Tu0Y0uejZQTS9xXOMymC/OHNAP2qns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VSakZNpo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1415DC116C6;
	Tue,  7 Apr 2026 15:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775575613;
	bh=FJ1vMZk1sphQYwviPOJZ5Kgr67vRtHDBF1aWJUBTMg0=;
	h=Subject:To:Cc:From:Date:From;
	b=VSakZNpoMpw05oV7+wDS3B6p38ykKLBj2Hysz9eP34nfFV+KszfCm7W6yAHXXsA2d
	 0d4n1Hj2hmxjTDq7XIAPIU3G+3VQQQlDO5aM6H2tty/hDhFLqmstXyu+cHTz2hz6W/
	 tjsEJnYA5qxmLG7hGronVxY3MoxgxsHV0swTu1UU=
Subject: FAILED: patch "[PATCH] iio: adc: aspeed: clear reference voltage bits before" failed to apply to 6.6-stable tree
To: billy_tsai@aspeedtech.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 07 Apr 2026 17:23:37 +0200
Message-ID: <2026040737-clavicle-childhood-d093@gregkh>
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
	TAGGED_FROM(0.00)[bounces-233667-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,gregkh:email,huawei.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,aspeedtech.com:email]
X-Rspamd-Queue-Id: 1C3BE3B1330
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 7cf2f6ed8e7a3bf481ef70b6b4a2edb8abfa5c57
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026040737-clavicle-childhood-d093@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7cf2f6ed8e7a3bf481ef70b6b4a2edb8abfa5c57 Mon Sep 17 00:00:00 2001
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Tue, 3 Mar 2026 10:38:26 +0800
Subject: [PATCH] iio: adc: aspeed: clear reference voltage bits before
 configuring vref

Ensures the reference voltage bits are cleared in the ADC engine
control register before configuring the voltage reference. This
avoids potential misconfigurations caused by residual bits.

Fixes: 1b5ceb55fec2 ("iio: adc: aspeed: Support ast2600 adc.")
Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index 4be44c524b4d..83a9885b9ae4 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -415,6 +415,7 @@ static int aspeed_adc_vref_config(struct iio_dev *indio_dev)
 	}
 	adc_engine_control_reg_val =
 		readl(data->base + ASPEED_REG_ENGINE_CONTROL);
+	adc_engine_control_reg_val &= ~ASPEED_ADC_REF_VOLTAGE;
 
 	ret = devm_regulator_get_enable_read_voltage(data->dev, "vref");
 	if (ret < 0 && ret != -ENODEV)


