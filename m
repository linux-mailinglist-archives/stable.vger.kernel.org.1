Return-Path: <stable+bounces-261240-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xeWzGJNGJWoCFwIAu9opvQ
	(envelope-from <stable+bounces-261240-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:23:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9C464F9A3
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:23:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=k7eGCQk9;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261240-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261240-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 576EB300382E
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116E13246F4;
	Sun,  7 Jun 2026 10:23:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8284322C88;
	Sun,  7 Jun 2026 10:23:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780827789; cv=none; b=WsygZh+8GNjV+lhrv9dPGyyFhszzIVN286Spx1cTdYLsgpx4jKc49TKC1XdF3WGCa4SzWqU9GwyHxAy8DaCri19ZupfjpiJw6aB5NGwfVVc/eFuz+jtfakfxi1w8qkYL0tN6/8cijmp94gZUzgaJshMEbk24QQ20ZwvPWpJamVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780827789; c=relaxed/simple;
	bh=vEWsiuyI59lh/ujg4essS9FBLCEZ28g9KoJXkvRDjQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rTt8xf0tdcf+vSOSz43RzOdrkunSiSCDaYR59q+vw0xAUUfXw/cv00BzBW5xwB/ckYex4FqteXqlocv0wje3c+4cAm+XZSvHBpTRDZOxv6mwAVYw3G9UnN4T0fjHEXyYtPxvk2S5Qz/XhQHGtzZBfIoM71AF5A7iKZarmdVkOFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k7eGCQk9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70B61F00893;
	Sun,  7 Jun 2026 10:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780827788;
	bh=KiRWXIk0rfhiFQ1VYZpKY28k/OrUw51A0LMa3ZgaeEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k7eGCQk9cYstSNMAgO6RyxZgGxgilnY/Wu/rRI7QhQHnOv9tXuhZBrNBk9nApI0nQ
	 tr8YvFOL46jamrMvh+vnzEHURQRFfnS3bzSYPW73rDGumS3LbrepHC2os+ibupg2wX
	 7f08DZJlJRu4O9XkBIqHPhnALSSZpsV97sKhNd2k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	stable <stable@kernel.org>,
	Badhri Jagan Sridharan <badhri@google.com>
Subject: [PATCH 7.0 122/332] usb: typec: tcpm: validate VDO count in Discover Identity ACK handlers
Date: Sun,  7 Jun 2026 11:58:11 +0200
Message-ID: <20260607095732.587984545@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095728.031258202@linuxfoundation.org>
References: <20260607095728.031258202@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-261240-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:heikki.krogerus@linux.intel.com,m:stable@kernel.org,m:badhri@google.com,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,intel.com:email,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C9C464F9A3

7.0-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1708,6 +1708,9 @@ static void svdm_consume_identity(struct
 	u32 vdo = p[VDO_INDEX_IDH];
 	u32 product = p[VDO_INDEX_PRODUCT];
 
+	if (cnt <= VDO_INDEX_PRODUCT)
+		return;
+
 	memset(&port->mode_data, 0, sizeof(port->mode_data));
 
 	port->partner_ident.id_header = vdo;
@@ -1728,6 +1731,9 @@ static void svdm_consume_identity_sop_pr
 	u32 product = p[VDO_INDEX_PRODUCT];
 	int svdm_version;
 
+	if (cnt <= VDO_INDEX_CABLE_1)
+		return;
+
 	/*
 	 * Attempt to consume identity only if cable currently is not set
 	 */
@@ -1751,7 +1757,7 @@ static void svdm_consume_identity_sop_pr
 	switch (port->negotiated_rev_prime) {
 	case PD_REV30:
 		port->cable_desc.pd_revision = 0x0300;
-		if (port->cable_desc.active)
+		if (port->cable_desc.active && cnt > VDO_INDEX_CABLE_2)
 			port->cable_ident.vdo[1] = p[VDO_INDEX_CABLE_2];
 		break;
 	case PD_REV20:



