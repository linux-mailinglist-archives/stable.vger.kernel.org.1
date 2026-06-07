Return-Path: <stable+bounces-261376-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yNZHAgxJJWpkGAIAu9opvQ
	(envelope-from <stable+bounces-261376-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:33:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DFA64FC99
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:33:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=ArLABt+Z;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261376-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261376-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5DD4A3028F72
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E1B31E842;
	Sun,  7 Jun 2026 10:31:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12F62D3A69;
	Sun,  7 Jun 2026 10:31:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780828312; cv=none; b=ZWL0L93t9emvdLJUFOWWHbD2mKFwBhjc5ujASnPtX5d190PtXT6rmlJasGpgdfJf89q9TBFdJIGNQhJ0hkzZZ2ZED6CGDZmC6Iy2OQxxW1b2+KaEUOi8nOEVX38X3LWl/QNwWIwVzFUDbwm7ZtBQbRqwRl3zmB/GA4Z2ISWwIbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780828312; c=relaxed/simple;
	bh=7IFVO1+oV+PEuUddPC3Q+Jnn6xIzGlIO4ESAiWTHxkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NGgtduuLwTXColqs90Ljt+D17zuxsl1GchPMQYsbTXEs2d81P5ClifVFBuOLooDjdXRW8ZIP2I0ueZbc3AT1moAwa8GtJSB9mBychmkD5O0T6HOuvEc9hloFEHnVjP019hQGvsCG7s02BK1bUSMh61ZX8UFqNZXYUzAiedRM0R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ArLABt+Z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7FCF1F00893;
	Sun,  7 Jun 2026 10:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780828311;
	bh=bZ6SgO30G2c1vkT9HSwk41HpgMZ3qK6z4Vgt//JVTxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ArLABt+ZQ6YJVbmdcLs/YSvwuplvwMYnelgPCE3qt3j4z06L6PrxCRR9luu22+/CG
	 YmWnB5CUJqtwkrxvU0mBVhG8BV1tFcA5Ax3HVLNlRTr6ta8Oc9ZJjcppuZl2VyGKGA
	 cuAHyMvur5g2YmGTxXJQ16VMp4VlbqokJzmsg9lU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	stable <stable@kernel.org>,
	Badhri Jagan Sridharan <badhri@google.com>
Subject: [PATCH 6.12 128/307] usb: typec: tcpm: validate VDO count in Discover Identity ACK handlers
Date: Sun,  7 Jun 2026 11:58:45 +0200
Message-ID: <20260607095732.459516122@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.647295505@linuxfoundation.org>
References: <20260607095727.647295505@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261376-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:heikki.krogerus@linux.intel.com,m:stable@kernel.org,m:badhri@google.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 81DFA64FC99

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 8fbc349e8383125dd2d8de1c1e926279d398ab17 upstream.

Properly validate the count passed from a device when calling
svdm_consume_identity() or svdm_consume_identity_sop_prime() as the
device-controlled value could index off of the static arrays, which
could leak data.

Assisted-by: gkh_clanker_t1000
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: stable <stable@kernel.org>
Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
Link: https://patch.msgid.link/2026051350-plated-salute-0efe@gregkh
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/typec/tcpm/tcpm.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1639,6 +1639,9 @@ static void svdm_consume_identity(struct
 	u32 vdo = p[VDO_INDEX_IDH];
 	u32 product = p[VDO_INDEX_PRODUCT];
 
+	if (cnt <= VDO_INDEX_PRODUCT)
+		return;
+
 	memset(&port->mode_data, 0, sizeof(port->mode_data));
 
 	port->partner_ident.id_header = vdo;
@@ -1659,6 +1662,9 @@ static void svdm_consume_identity_sop_pr
 	u32 product = p[VDO_INDEX_PRODUCT];
 	int svdm_version;
 
+	if (cnt <= VDO_INDEX_CABLE_1)
+		return;
+
 	/*
 	 * Attempt to consume identity only if cable currently is not set
 	 */
@@ -1682,7 +1688,7 @@ static void svdm_consume_identity_sop_pr
 	switch (port->negotiated_rev_prime) {
 	case PD_REV30:
 		port->cable_desc.pd_revision = 0x0300;
-		if (port->cable_desc.active)
+		if (port->cable_desc.active && cnt > VDO_INDEX_CABLE_2)
 			port->cable_ident.vdo[1] = p[VDO_INDEX_CABLE_2];
 		break;
 	case PD_REV20:



