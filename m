Return-Path: <stable+bounces-260897-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iSutGo0tJGpt3wEAu9opvQ
	(envelope-from <stable+bounces-260897-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 06 Jun 2026 16:24:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BBB64DB53
	for <lists+stable@lfdr.de>; Sat, 06 Jun 2026 16:24:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Sulk+WdK;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260897-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-260897-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2777E3010BC7
	for <lists+stable@lfdr.de>; Sat,  6 Jun 2026 14:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED23F383C94;
	Sat,  6 Jun 2026 14:24:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D00263C9F
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 14:24:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780755848; cv=none; b=fk5pV0kEYthRPe4ZzqZIHTDHwUrx0wQBEvlFBINVBayQVsSLKxqBz8ILDDpgT/jUsQT2Lxo00cxJj6kgYGvi6EhsDB+xvUqr7ddsx3tJvyjoLBBsV1m3vvsrFH4q8KXLI2LbcE+R04Z+scK04lNQr+bGyRQcFWrkfGuBoKf4Z1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780755848; c=relaxed/simple;
	bh=DjzyiQZV6AZcnnhs2sZ+mvfY+UeKqoYVh0VBZwCMHVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j+gYmjCr+8I6t2T1udo6/HIKa/tzMSz/WwlZcVLan7zunHmT68D0RzwycZIpyztSE4nRG1q8NNzfvjr0bTa++yAbC85LWV1XhG+MIIt9EZWGBU2KdIMhZ+eYlXxh5CLvS4bONvNjK4e+hWVHTcFDPgfGioncA4Yh2fLYWucBAtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sulk+WdK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB5C1F00893;
	Sat,  6 Jun 2026 14:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780755847;
	bh=v9ncNWBsdlWjv3Iw4J1GxZylzIybcnuwAoe1gZeEV8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Sulk+WdKiiT1URvKZImHK74L4k9LRL8pkWtjWlXCMbkdJdqdn5cMJY8XI16GPVScx
	 TwQBK8FtIZN9MKduAlUFxEftfUT4QWzcF/TPTSOzrT9BgR+cNS8CcGtD0DOUK68hUk
	 G25rf2HG6CtZVxDVtq3HouR7A56z4trBanm373kYZnVt+TgjKJBwfPXed+V5E/g0DK
	 nDlwa2Xg/cmwnNw3C/D9EAZLJL7FvaJ4l35jKhpSdYiteaohs72BvJP2fbLDBOIkuY
	 aq8d4/dv+TyO/+xPl3r5InUhvGP/zOTxyKMQ/99zSyrEMxyhQRFJIaWoK0iQ1X4Dr6
	 F78J2xLewbi0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>,
	stable <stable@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] usb: typec: ucsi: Don't update power_supply on power role change if not connected
Date: Sat,  6 Jun 2026 10:24:04 -0400
Message-ID: <20260606142405.3108014-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060559-detective-buckskin-3910@gregkh>
References: <2026060559-detective-buckskin-3910@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260897-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:myrrhperiwinkle@qtmlabs.xyz,m:stable@kernel.org,m:senozhatsky@chromium.org,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,vger.kernel.org:from_smtp,chromium.org:email,qtmlabs.xyz:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E4BBB64DB53

From: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>

[ Upstream commit d98d413ca65d0790a8f3695d0a5845538958ab84 ]

We only need to update the power_supply on power role change if the port
is connected, because otherwise the online status should be the same for
both cases.

Cc: stable <stable@kernel.org>
Fixes: 7616f006db07 ("usb: typec: ucsi: Update power_supply on power role change")
Signed-off-by: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
Reported-and-tested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Link: https://patch.msgid.link/20260519-ucsi-fix-2-v1-2-6f1239535187@qtmlabs.xyz
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/ucsi/ucsi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 60339c74669417..2f7b45eeca4abe 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -772,6 +772,12 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 	if (con->status.change & UCSI_CONSTAT_POWER_DIR_CHANGE) {
 		typec_set_pwr_role(con->port, role);
 
+		/* Some power_supply properties vary depending on the power direction when
+		 * connected
+		 */
+		if (con->status.flags & UCSI_CONSTAT_CONNECTED)
+			ucsi_port_psy_changed(con);
+
 		/* Complete pending power role swap */
 		if (!completion_done(&con->complete))
 			complete(&con->complete);
-- 
2.53.0


