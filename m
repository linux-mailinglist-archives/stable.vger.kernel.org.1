Return-Path: <stable+bounces-226743-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GATsEJSUuWkJKwIAu9opvQ
	(envelope-from <stable+bounces-226743-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:51:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEF02B03CC
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E86A2328920C
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC9B2FFDEA;
	Tue, 17 Mar 2026 17:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="15XllwnX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EED2D5940;
	Tue, 17 Mar 2026 17:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768010; cv=none; b=eg8HOqsJWQ2m0ruJadtTSw1abWOAFkbMY7ceGzMQ5C2JRpFZaoCIzmKmPRQr4vv1/5tPcz/959qU4nnEptyBSiGCMYs+fBt2YplTkTlWLe6q8uNyIGrhufbBCjhmJxZVKEnk/n+VIKnSBd4buy+JtUI4NSsZJFctDB8mY2E9oPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768010; c=relaxed/simple;
	bh=azwFhMgl+Ps0g7fsy1LQoOfJR74rXC0TNSqXVYpf424=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RTXmgOT/VyN2WI9epE/CRBRaPO8w+oVd/4ZZGiD/Ex+sjDPcJi3LcBjtVPhODflgZT0qULW34DlbvPMlrk+NJCalBsPlrnAbar/eBb/YqJmkZkVQKGRnxr1EPAXlgoStqSnlX2iSInpVuuBoD9iZH8c0CHezWJiY4/nd57ovGbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=15XllwnX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C96EC19424;
	Tue, 17 Mar 2026 17:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773768010;
	bh=azwFhMgl+Ps0g7fsy1LQoOfJR74rXC0TNSqXVYpf424=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=15XllwnXXRVXMqM+IktQIrSujSC+X1gCEQe0LAM4OQDXqEEIG/gpyxWCmPUWCetIh
	 iIqqm/A0WdYwLC5FxZevFg6Ltgv1WZZ4ouyI99aCI40HEJwfU1tfh6AZu/XC6JIHcO
	 oFr9W0V0KYNAY03Fzb6FPU3LDATgamZew7G+swRw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Xu Yang <xu.yang_2@nxp.com>,
	Arnaud Ferraris <arnaud.ferraris@collabora.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 6.18 179/333] Revert "tcpm: allow looking for role_sw device in the main node"
Date: Tue, 17 Mar 2026 17:33:28 +0100
Message-ID: <20260317163005.993001694@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226743-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,intel.com:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Queue-Id: ADEF02B03CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xu Yang <xu.yang_2@nxp.com>

commit 6b275bfaa16be3fb1689fa6794e445ecd127a1b4 upstream.

This reverts commit 1366cd228b0c67b60a2c0c26ef37fe9f7cfedb7f.

The fwnode_usb_role_switch_get() returns NULL only if no connection is
found, returns ERR_PTR(-EPROBE_DEFER) if connection is found but deferred
probe is needed, or a valid pointer of usb_role_switch.

When switching from a NULL check to IS_ERR_OR_NULL(), usb_role_switch_get()
returns NULL and overwrites the ERR_PTR(-EPROBE_DEFER) returned by
fwnode_usb_role_switch_get(). This causes the deferred probe indication to
be lost, preventing the USB role switch from ever being retrieved.

Fixes: 1366cd228b0c ("tcpm: allow looking for role_sw device in the main node")
Cc: stable <stable@kernel.org>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Tested-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://patch.msgid.link/20260309074313.2809867-2-xu.yang_2@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/typec/tcpm/tcpm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -7877,7 +7877,7 @@ struct tcpm_port *tcpm_register_port(str
 	port->partner_desc.identity = &port->partner_ident;
 
 	port->role_sw = fwnode_usb_role_switch_get(tcpc->fwnode);
-	if (IS_ERR_OR_NULL(port->role_sw))
+	if (!port->role_sw)
 		port->role_sw = usb_role_switch_get(port->dev);
 	if (IS_ERR(port->role_sw)) {
 		err = PTR_ERR(port->role_sw);



