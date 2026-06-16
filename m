Return-Path: <stable+bounces-266519-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VWr9FdmeMWrRoQUAu9opvQ
	(envelope-from <stable+bounces-266519-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 21:07:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3E5694C26
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 21:07:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=nsKK3MB5;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266519-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-266519-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B41BF3049E15
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D7F3DDDBA;
	Tue, 16 Jun 2026 19:06:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BE8318EDA;
	Tue, 16 Jun 2026 19:06:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781636817; cv=none; b=oAuv6aEAJ5f+UplMND3ThBJI/QA2WgNn7f2WmQxAhu93fbiCUUIlvHzziOTVF++gCj97nxonIehQ+QdmFXWOI8aRYy0GZoxK3V7Ax1F4vLyOHcnaNGbIMEHis8Utu8jVC4rNtWdXcSyafBoiWJf2yqGZOYzVZgvhviQvoa8vISk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781636817; c=relaxed/simple;
	bh=spMDwq/ME5z569hTGXRny1qB05hU1HD/39J6VIQuESI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LyBJkA2x+HwSWkoN8pCXjbRONKWfj/Xfxp+xJiwMagw4spH6wRGD4KHhVi4Rt5QPfEED9irjhAKNfMgWZm+8tthW/nYVfeF1DkceMXpnaTDoqFiw+gaNtUKXtakf8J/4cgNp+GefcD0BtLG0KoeO943LzAQd0F+YJ2UirpxLayY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nsKK3MB5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2101C1F000E9;
	Tue, 16 Jun 2026 19:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781636816;
	bh=wK0sirdrVwwv5jGJEkSqZ9Qp7J1cXUqRQcDZiWgL4yI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nsKK3MB5nmmD+x9QV8+1iLj8bCHFPhFvbY7Uszdnopx9R9KEMtfD2+GxDVn1ng/JT
	 xXHJinXRYbA4KEPxEAf7muLitKMXNDife/e5Q0TfDlUUS2Ry2XzB7eoPbiqkGUFRPj
	 wo4QPwk0pJ+7KGbPTeeQQ3tQYW3+BYPfBbclQLo4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>,
	Sasha Levin <sashal@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 5.10 310/342] usb: typec: ucsi: Dont update power_supply on power role change if not connected
Date: Tue, 16 Jun 2026 20:30:06 +0530
Message-ID: <20260616145102.909504547@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145048.348037099@linuxfoundation.org>
References: <20260616145048.348037099@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266519-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:stable@kernel.org,m:myrrhperiwinkle@qtmlabs.xyz,m:sashal@kernel.org,m:senozhatsky@chromium.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,qtmlabs.xyz:email,chromium.org:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9F3E5694C26

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/typec/ucsi/ucsi.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -775,6 +775,12 @@ static void ucsi_handle_connector_change
 	    role != prev_role) {
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



