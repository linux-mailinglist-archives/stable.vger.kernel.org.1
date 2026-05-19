Return-Path: <stable+bounces-249562-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNa9Mg5NDGqWeAUAu9opvQ
	(envelope-from <stable+bounces-249562-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 13:44:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E2C57DE76
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 13:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BC40630028BC
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 11:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634A34963B7;
	Tue, 19 May 2026 11:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qtmlabs.xyz header.i=@qtmlabs.xyz header.b="pZ9+DDUN"
X-Original-To: stable@vger.kernel.org
Received: from s1.g1.infrastructure.qtmlabs.xyz (s1.g1.infrastructure.qtmlabs.xyz [107.172.1.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7321A4968EA;
	Tue, 19 May 2026 11:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=107.172.1.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779190918; cv=none; b=Ty3n7XL9XzvM8nsT1xDwnoVviGYuWC2EKl+wgLcIFcguprWPf9BNE0BJin360UxsP5+v9u60CSiyzzWeUVHpC7zGmgB4Z1GOvDj2B9x7JIWxqzBdMkHXMTSqgQQUrR+XWhYydm9ay9idnjIhaaOS0O520hck+9UvZbqcd4ASuH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779190918; c=relaxed/simple;
	bh=YjUy2YDdRmRqudKJsGT2J8c3flweY8fiADAo4FpfS6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=swi1z9lSFjCvnb1y+ls9HVhfSGQQy6FkGLaEIEDeQ/NjcLfmqikm6ljREkx6GCtT3KppOOX+MEY9OqHk6q+9Pa6iJrAKmnT6tKkGQmS4R8c1SL2r8n52PTwTrVwYwLAfMae4CC3nkcq8D2TKcWr+p2/fs1C6iP0s6mJmD1ldLmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtmlabs.xyz; spf=pass smtp.mailfrom=qtmlabs.xyz; dkim=pass (2048-bit key) header.d=qtmlabs.xyz header.i=@qtmlabs.xyz header.b=pZ9+DDUN; arc=none smtp.client-ip=107.172.1.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtmlabs.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qtmlabs.xyz
From: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qtmlabs.xyz; s=dkim;
	t=1779190915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t6F5wUe5+M16cP+CoQiPBEbtaaRqMELGGUG6lgqwbMs=;
	b=pZ9+DDUNXeWlTPPvXVtp3OyCmlmAxrSxFFtLmBNxFlaf2irIPamGMbgTZ01gWj68DspBiV
	Cw9DdDqs+P1dvMBbfKGJnmLE4heFE6sgKeWKvdpxIXpjs8ww0yiBfXUCWoG0NBKy/6YbHh
	pMFmhQD9NlQO9eNe2/UWgSalEgd5CptdpUdiwJqPgy1Ge6RCEK9PxfRTxEJnbPnXksfq6D
	ccGSCantQu3VC/j+fDmxz8qznvf1d6y4VV4V464LE27tT3i9edIroSx//EOI8Lmnr3K1LH
	8MniuG6gQR30YwdVLaazOAtIPu+nICiGiI7MIfgHwpV3skB7xFwC6NWKSxhiKg==
Authentication-Results: s1.g1.infrastructure.qtmlabs.xyz;
	auth=pass smtp.mailfrom=myrrhperiwinkle@qtmlabs.xyz
Date: Tue, 19 May 2026 18:41:40 +0700
Subject: [PATCH 2/2] usb: typec: ucsi: Don't update power_supply on power
 role change if not connected
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-ucsi-fix-2-v1-2-6f1239535187@qtmlabs.xyz>
References: <20260519-ucsi-fix-2-v1-0-6f1239535187@qtmlabs.xyz>
In-Reply-To: <20260519-ucsi-fix-2-v1-0-6f1239535187@qtmlabs.xyz>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>, stable@vger.kernel.org
X-Spamd-Bar: -------
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qtmlabs.xyz,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qtmlabs.xyz:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249562-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qtmlabs.xyz:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[myrrhperiwinkle@qtmlabs.xyz,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,qtmlabs.xyz:email,qtmlabs.xyz:mid,qtmlabs.xyz:dkim]
X-Rspamd-Queue-Id: 93E2C57DE76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We only need to update the power_supply on power role change if the port
is connected, because otherwise the online status should be the same for
both cases.

Cc: stable@vger.kernel.org
Fixes: 7616f006db07 ("usb: typec: ucsi: Update power_supply on power role change")
Signed-off-by: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
---
 drivers/usb/typec/ucsi/ucsi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index e19b656609e4..c59c4d8ee076 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1308,7 +1308,12 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 
 	if ((change & UCSI_CONSTAT_POWER_DIR_CHANGE) && role != prev_role) {
 		typec_set_pwr_role(con->port, role);
-		ucsi_port_psy_changed(con);
+
+		/* Some power_supply properties vary depending on the power direction when
+		 * connected
+		 */
+		if (UCSI_CONSTAT(con, CONNECTED))
+			ucsi_port_psy_changed(con);
 
 		/* Complete pending power role swap */
 		if (!completion_done(&con->complete))

-- 
2.54.0


