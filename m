Return-Path: <stable+bounces-266248-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S0DoJWqZMWqInwUAu9opvQ
	(envelope-from <stable+bounces-266248-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:43:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E738694658
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:43:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=Vzh2OzJn;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266248-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-266248-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C13A0302F486
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFECC477982;
	Tue, 16 Jun 2026 18:43:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9144338C437;
	Tue, 16 Jun 2026 18:43:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781635430; cv=none; b=pkrNRdmF+6nW4Cd9uIGuw4EdHjr9ltDRz1+tl8iW8hSN2oCaWGlqkSLta42qWdKr7xmiVuh+wzC3bAjGgtyDoWG1dSNY9M9xhp+6U/C8Or3pLz1FPO+Kg7X8+rrleso8r9KqJFrIc0kAexYTzbL1WjxIrkVx6bO67eg+Fb98sZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781635430; c=relaxed/simple;
	bh=nLGIIPMBDgkq+E9J/1hsiIYb5J6P04uTBWXj32LjXQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hiCoWw0lLonXMGhpPVyeyABlZDOSwhu4IQBWz3MIxtosLmUfDpmmZ7yIvqcAF5pheQ413EWwmqPoicrdPr5tAG27+VBIKARAlUDEKK+x4XeEF0+sM6KuK6za4ZgRf5TmYoL5HoVHjkRLiZb3X1PiLMt6zLm0zeUnzJViEWAzBAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vzh2OzJn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2E71F000E9;
	Tue, 16 Jun 2026 18:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781635429;
	bh=JtvqrI7tgWhwQMGXGR7+yDwP7MkPu09k2i61khtqMn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vzh2OzJnsFQgOgwJFdbZm09cBpp6SWfKi8im2L1rCoO4CxQmdiBPW+XfNPPt1VoiR
	 C3aPJEdmK74HJ7jxNYQ47fv8TcMcSGU6yNXq1ENMYAd/PaaL1OPwSvCID4JLZH0rSO
	 F9WqtKKvz7kVi8zMbHK9Lfc+p9vH/uewV0SChr8w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pooja Katiyar <pooja.katiyar@intel.com>,
	Johan Hovold <johan@kernel.org>,
	stable <stable@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 5.10 046/342] usb: typec: ucsi: displayport: NAK DP_CMD_CONFIGURE without a payload VDO
Date: Tue, 16 Jun 2026 20:25:42 +0530
Message-ID: <20260616145050.408395050@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266248-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:pooja.katiyar@intel.com,m:johan@kernel.org,m:stable@kernel.org,m:heikki.krogerus@linux.intel.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,msgid.link:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4E738694658

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 167dd8d12226587ee554f520aed0256b7769cd5d upstream.

ucsi_displayport_vdm() handles a DP_CMD_CONFIGURE by copying the first
payload VDO from data[], but unlike the equivalent handler in
altmodes/displayport.c it does not check that count covers a VDO beyond
the header.  A header-only Configure VDM (count == 1) would read one u32
past the caller's array.

In the normal UCSI path the caller controls count, so this is hardening
for non-standard delivery paths.  NAK and bail when no configuration VDO
is present, matching the generic DP altmode driver's existing guard.

Assisted-by: gkh_clanker_t1000
Cc: Pooja Katiyar <pooja.katiyar@intel.com>
Cc: Johan Hovold <johan@kernel.org>
Cc: stable <stable@kernel.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://patch.msgid.link/2026051351-vividly-flattered-eb3d@gregkh
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/typec/ucsi/displayport.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/usb/typec/ucsi/displayport.c
+++ b/drivers/usb/typec/ucsi/displayport.c
@@ -211,6 +211,10 @@ static int ucsi_displayport_vdm(struct t
 				dp->header |= VDO_CMDT(CMDT_RSP_ACK);
 			break;
 		case DP_CMD_CONFIGURE:
+			if (count < 2) {
+				dp->header |= VDO_CMDT(CMDT_RSP_NAK);
+				break;
+			}
 			dp->data.conf = *data;
 			if (ucsi_displayport_configure(dp)) {
 				dp->header |= VDO_CMDT(CMDT_RSP_NAK);



