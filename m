Return-Path: <stable+bounces-264728-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ncw5Crh9MWrzkgUAu9opvQ
	(envelope-from <stable+bounces-264728-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:45:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C4B6926DC
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:45:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=LvFZFuOk;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264728-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264728-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4C5923038BF1
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186B6477993;
	Tue, 16 Jun 2026 16:32:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53B74502F;
	Tue, 16 Jun 2026 16:32:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781627552; cv=none; b=fEtFxYnICS8+cf7XpHfb6dnV6I4N7MfCrh6/XolFPtr3oU8hXXF6AvdKARG3IQM+QgDHEctJrA0Yx2YP5H8y0VNP9w7wFDShtLs05P41YZ4lwQZJhA/544MYvcj0cvQibii9guGfoUmVVPjr6HSn3cz+aPw8PVLlq5HR31KB9eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781627552; c=relaxed/simple;
	bh=5bYjoi2PlNhuyADBsRt0iJ5jGgK89HwF5Br39vihBWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ol5Coi/VODGpihpAUEYTRY8iucSpifx/gHWP08s9gDbuEq03j9TJ7vblZ+Ph9lmqUaEY9bjZKpeCUtULfQgKIu/FMLem3yvB/f9TO1K4o6DoeRVApRKwvQAFMQZG3G3ds6LnFgy4oyQyWItgTRr1/NsMuKJy+Sdt1eXA+Am8CB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LvFZFuOk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9848C1F00A3A;
	Tue, 16 Jun 2026 16:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781627551;
	bh=76Jt9NjE2aADoKkztSOFkp8Cb06OJcQcfsaQ756kZmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LvFZFuOkCYRT8UZA8lOb0D6c8gpgfuwCYylHVpCSBfojQU25aQFk0P+uWEhk2GQI4
	 HUs3lRrbWrRrSkQ3Y+BkJNF3XMsZkVtj5yQPbsLbyVwyc4yaHc/JpB+jXxuhuH7V7d
	 pAHL7O33cEe7QOeY+P0ltDY4AWRG9uqFa7mYSdEw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.12 192/261] mmc: core: Fix host controller programming for fixed driver type
Date: Tue, 16 Jun 2026 20:30:30 +0530
Message-ID: <20260616145053.960237881@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145044.869532709@linuxfoundation.org>
References: <20260616145044.869532709@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264728-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:kamal.dasu@broadcom.com,m:shawn.lin@rock-chips.com,m:ulf.hansson@linaro.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,broadcom.com:email,linaro.org:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,rock-chips.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 18C4B6926DC

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kamal Dasu <kamal.dasu@broadcom.com>

commit 5a52c5701a67d5176eb1afbf1bdaf7d6dfeec597 upstream.

When using the fixed-emmc-driver-type device tree property, the MMC core
correctly selects the driver strength for the card but fails to program
the host controller accordingly. This causes a mismatch where the card
uses the specified driver type while the host controller defaults to
Type B (since ios->drv_type remains zero).

Split the driver type programming logic to handle both fixed and dynamic
driver type selection paths. For fixed driver types, program the host
controller with the selected drive_strength value. For dynamic selection,
use the existing drv_type as before.

This ensures both the eMMC device and host controller use matching driver
strengths, preventing potential signal integrity issues.

Fixes: 6186d06c519e ("mmc: parse new binding for eMMC fixed driver type")
Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/core/mmc.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1348,7 +1348,9 @@ static void mmc_select_driver_type(struc
 
 	card->drive_strength = drive_strength;
 
-	if (drv_type)
+	if (fixed_drv_type >= 0 && drive_strength)
+		mmc_set_driver_type(card->host, drive_strength);
+	else if (drv_type)
 		mmc_set_driver_type(card->host, drv_type);
 }
 



