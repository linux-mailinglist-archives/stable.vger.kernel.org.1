Return-Path: <stable+bounces-265587-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xDHLCdOLMWobmQUAu9opvQ
	(envelope-from <stable+bounces-265587-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:45:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BB28B69374C
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:45:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=osmC2wdP;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265587-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-265587-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 31C4B303BA8F
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC2B3C65F2;
	Tue, 16 Jun 2026 17:45:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5283E2F12AE;
	Tue, 16 Jun 2026 17:45:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781631952; cv=none; b=UNOQPth2L+kAeKrFht4f4Iz4hnDgOS6FXFgxDTheX1LEIFH5zlItknSIPyrmd+zOkU7UAmlrVgxv+YFe45mP64R3LxBONK7E4kdHIfrxTwARW7t41Dy35hUweIFV+NHBflG9Rm5heaZqXSm2w7BuhbMptUVOmR0gzrLYY+T7L0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781631952; c=relaxed/simple;
	bh=k1DyQI1kwHdf48gyO7nHFeXRldKbuedt5bIR4f8HFI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hLoPg8B1/rTSYRrLFg/NP+1qAv9dui+Z3udRRTwraOpcJGYgch34QekJNgpgoUtxqFMuiDXKjr+/1577EQYwGR6TBb3EzHwvMnTYRjUR/TBwisSmKql8a4Cw7UMry8wD6uZ+hWT7Qr876Nf5oYO/wg9Wzhv6q3aU98C7is3T/Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=osmC2wdP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F71C1F000E9;
	Tue, 16 Jun 2026 17:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781631951;
	bh=mYP68NT1eZl3uy0crsopTcDSBR3Qy+DkimxzsJtURHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=osmC2wdPBJ/Xz5m/s+I5KbRGh68wWt/qDxSr717x9LssHH9Lgc/RnFXT8b6uhU9ba
	 bToFhJ0HH2FGmXAdwY10y8zViy1xcyCanxU9VqZBIRNJyfCTRE3qr7N5jpSGaSyqvR
	 GZ+xtj4qb5o7mPxSIjcF+yJUsHBtVTu2gTfr9irw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Bommarito <michael.bommarito@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 6.1 318/522] thunderbolt: Validate XDomain request packet size before type cast
Date: Tue, 16 Jun 2026 20:27:45 +0530
Message-ID: <20260616145140.730322272@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265587-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:michael.bommarito@gmail.com,m:mika.westerberg@linux.intel.com,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,linux.intel.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,intel.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BB28B69374C

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Bommarito <michael.bommarito@gmail.com>

commit a504b9f2797b739e0304d537e8aa4ce883ecce39 upstream.

tb_xdp_handle_request() casts the received packet buffer to
protocol-specific structs without verifying that the allocation
is large enough for the target type.  A peer can send a minimal
XDomain packet that passes the generic header length check but is
shorter than the struct accessed after the cast, causing out-of-
bounds reads from the kmemdup allocation.

Plumb the packet length through xdomain_request_work and validate
it against the expected struct size before each cast.

Fixes: 8e1de7042596 ("thunderbolt: Add support for XDomain lane bonding")
Fixes: cdae7c07e3e3 ("thunderbolt: Add support for XDomain properties")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/thunderbolt/xdomain.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -54,6 +54,7 @@ static const char * const state_names[]
 struct xdomain_request_work {
 	struct work_struct work;
 	struct tb_xdp_header *pkg;
+	size_t pkg_len;
 	struct tb *tb;
 };
 
@@ -732,6 +733,7 @@ static void tb_xdp_handle_request(struct
 	struct xdomain_request_work *xw = container_of(work, typeof(*xw), work);
 	const struct tb_xdp_header *pkg = xw->pkg;
 	const struct tb_xdomain_header *xhdr = &pkg->xd_hdr;
+	size_t pkg_len = xw->pkg_len;
 	struct tb *tb = xw->tb;
 	struct tb_ctl *ctl = tb->ctl;
 	struct tb_xdomain *xd;
@@ -763,7 +765,7 @@ static void tb_xdp_handle_request(struct
 	switch (pkg->type) {
 	case PROPERTIES_REQUEST:
 		tb_dbg(tb, "%llx: received XDomain properties request\n", route);
-		if (xd) {
+		if (xd && pkg_len >= sizeof(struct tb_xdp_properties)) {
 			ret = tb_xdp_properties_response(tb, ctl, xd, sequence,
 				(const struct tb_xdp_properties *)pkg);
 		}
@@ -817,7 +819,8 @@ static void tb_xdp_handle_request(struct
 		tb_dbg(tb, "%llx: received XDomain link state change request\n",
 		       route);
 
-		if (xd && xd->state == XDOMAIN_STATE_BONDING_UUID_HIGH) {
+		if (xd && xd->state == XDOMAIN_STATE_BONDING_UUID_HIGH &&
+		    pkg_len >= sizeof(struct tb_xdp_link_state_change)) {
 			const struct tb_xdp_link_state_change *lsc =
 				(const struct tb_xdp_link_state_change *)pkg;
 
@@ -869,6 +872,7 @@ tb_xdp_schedule_request(struct tb *tb, c
 		kfree(xw);
 		return false;
 	}
+	xw->pkg_len = size;
 	xw->tb = tb_domain_get(tb);
 
 	schedule_work(&xw->work);



