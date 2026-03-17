Return-Path: <stable+bounces-225880-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFh+FvFDuWmK+QEAu9opvQ
	(envelope-from <stable+bounces-225880-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:07:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD462A9831
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23B64301E975
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CED3BADA4;
	Tue, 17 Mar 2026 12:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Kebxndlk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B253AE1B2
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 12:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773749071; cv=none; b=Ilzkh3ENSa5dIQKni12DcrvyiLGZknen1Elv05oAdp8H1tNfaCQVhAJQFlmSMCJKPpy2tjD7YN5HxKDi447s3iBjoH81zooKgXXvDKW/HldyWVIJkrJIHmdHbi0+Y//ZIOSQjK5WKqkIGPE19PuoG1BMynBWiCskBE/dnwbpeDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773749071; c=relaxed/simple;
	bh=t13qaC7HQwrMUIkH1afTESAu4DiiPok1fH4h2DUXiDA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ltlS9AuuqY1ep1Pgcx9nNm2f5bkcalJBucAuw3ebcRbOSnNusrUD9eQxdw36wNY5D4wXwPeoUhQdaXUGeTv2AO6uDuS7IWEzJCxDJuXzix0geJOvax+Bchb/2nNHuCIPKOIP8jhijhxnbWumsZPJTtYoyMMeX/dsgY4f6N0dvsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Kebxndlk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA37CC4CEF7;
	Tue, 17 Mar 2026 12:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773749070;
	bh=t13qaC7HQwrMUIkH1afTESAu4DiiPok1fH4h2DUXiDA=;
	h=Subject:To:Cc:From:Date:From;
	b=KebxndlkzviDWQBd24iKfQU/jzk6st7Ie03kIcF8CVQwb4ncNXbp3sU05Ri4eNFG2
	 d22kpU6I46bWowYWpSNNfWtthuRjzRYTIqsmIOdGgS3WWtRs56gZ9gaaKA6nvGda6U
	 maKFyxPzuuSYoOgd9AY9HiciDQ90fbiuYCigoisc=
Subject: FAILED: patch "[PATCH] pmdomain: bcm: bcm2835-power: Fix broken reset status read" failed to apply to 5.10-stable tree
To: mcanal@igalia.com,florian.fainelli@broadcom.com,ulf.hansson@linaro.org,wahrenst@gmx.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 13:04:13 +0100
Message-ID: <2026031713-dish-reseal-2bd6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225880-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[igalia.com,broadcom.com,linaro.org,gmx.net];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,igalia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linaro.org:email]
X-Rspamd-Queue-Id: CDD462A9831
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 550bae2c0931dbb664a61b08c21cf156f0a5362a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031713-dish-reseal-2bd6@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 550bae2c0931dbb664a61b08c21cf156f0a5362a Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Date: Thu, 12 Feb 2026 11:49:44 -0300
Subject: [PATCH] pmdomain: bcm: bcm2835-power: Fix broken reset status read
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

bcm2835_reset_status() has a misplaced parenthesis on every PM_READ()
call. Since PM_READ(reg) expands to readl(power->base + (reg)), the
expression:

    PM_READ(PM_GRAFX & PM_V3DRSTN)

computes the bitwise AND of the register offset PM_GRAFX with the
bitmask PM_V3DRSTN before using the result as a register offset, reading
from the wrong MMIO address instead of the intended PM_GRAFX register.
The same issue affects the PM_IMAGE cases.

Fix by moving the closing parenthesis so PM_READ() receives only the
register offset, and the bitmask is applied to the value returned by
the read.

Fixes: 670c672608a1 ("soc: bcm: bcm2835-pm: Add support for power domains under a new binding.")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/pmdomain/bcm/bcm2835-power.c b/drivers/pmdomain/bcm/bcm2835-power.c
index 1d29addfe036..0450202bbee2 100644
--- a/drivers/pmdomain/bcm/bcm2835-power.c
+++ b/drivers/pmdomain/bcm/bcm2835-power.c
@@ -580,11 +580,11 @@ static int bcm2835_reset_status(struct reset_controller_dev *rcdev,
 
 	switch (id) {
 	case BCM2835_RESET_V3D:
-		return !PM_READ(PM_GRAFX & PM_V3DRSTN);
+		return !(PM_READ(PM_GRAFX) & PM_V3DRSTN);
 	case BCM2835_RESET_H264:
-		return !PM_READ(PM_IMAGE & PM_H264RSTN);
+		return !(PM_READ(PM_IMAGE) & PM_H264RSTN);
 	case BCM2835_RESET_ISP:
-		return !PM_READ(PM_IMAGE & PM_ISPRSTN);
+		return !(PM_READ(PM_IMAGE) & PM_ISPRSTN);
 	default:
 		return -EINVAL;
 	}


