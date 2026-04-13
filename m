Return-Path: <stable+bounces-237278-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOX6C0of3WmSaAkAu9opvQ
	(envelope-from <stable+bounces-237278-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:52:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C9F3F0147
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9E2F9301E019
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B2831715D;
	Mon, 13 Apr 2026 16:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mx99o+7x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADED31714F;
	Mon, 13 Apr 2026 16:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099044; cv=none; b=GU9Ql8wVVWndoFV3kxVzKMfMNyGbZU0CVv7uSqzC2zCLkDr2XAJWfSU822jckrwUKV5Oy1qp53Sdvppfflf762GfYiE6WjfKuWxaP0jvg9o2ob8ley3kB+nUnq5LbSVxQxvSrejrvzbheLq6hvd2WvLpK/3rkWh8y6SA74U7CR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099044; c=relaxed/simple;
	bh=OM4lhVePV1P8ccNdMp6dEkoEEru+snR+gezxMFo5lks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZDfQcBoXBYHPN/HLhS6jy9YmsxrkUz2jJxfDUE0aKp4Aeo53mBll36La9Hn3J1RA11zui2rDpbvMIHCGCWum1ROWKdZJyUfGXgwPmBvXUVJKpYjNZSuXkauPggkCsXBy51PYVD0qT6E6PovENl9hUZBsJq/4Wenrh7qUxv93/SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mx99o+7x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71116C2BCAF;
	Mon, 13 Apr 2026 16:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099044;
	bh=OM4lhVePV1P8ccNdMp6dEkoEEru+snR+gezxMFo5lks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mx99o+7xVBP/Qf8O0VVR+oyG40s0h+3T+zQ3zzUMwu+Prpn7MFGYfCpcpCLYkQCPI
	 IUyrncsNY/32xXJO3KNMo8E+gpAbhuZod+BOxqvq/2SZqv7LLmNOoaZoOoQTESnPDJ
	 FNPwOfVn1EekYD7KTlqYBnVj7bYwwhv+aMkZp3lA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Xu Yang <xu.yang_2@nxp.com>,
	Arnaud Ferraris <arnaud.ferraris@collabora.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 189/491] usb: roles: get usb role switch from parent only for usb-b-connector
Date: Mon, 13 Apr 2026 17:57:14 +0200
Message-ID: <20260413155826.144013004@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237278-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,msgid.link:url,intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D4C9F3F0147
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xu Yang <xu.yang_2@nxp.com>

[ Upstream commit 8345b1539faa49fcf9c9439c3cbd97dac6eca171 ]

usb_role_switch_is_parent() was walking up to the parent node and checking
for the "usb-role-switch" property regardless of the type of the passed
fwnode. This could cause unrelated device nodes to be probed as potential
role switch parent, leading to spurious matches and "-EPROBE_DEFER" being
returned infinitely.

Till now only Type-B connector node will have a parent node which may
present "usb-role-switch" property and register the role switch device.
For Type-C connector node, its parent node will always be a Type-C chip
device which will never register the role switch device. However, it may
still present a non-boolean "usb-role-switch = <&usb_controller>" property
for historical compatibility.

So restrict the helper to only operate on Type-B connector when attempting
to get the role switch from parent node.

Fixes: 6fadd72943b8 ("usb: roles: get usb-role-switch from parent")
Cc: stable <stable@kernel.org>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Tested-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://patch.msgid.link/20260309074313.2809867-3-xu.yang_2@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ replace fwnode_device_is_compatible() call with it's expansion ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/roles/class.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/usb/roles/class.c
+++ b/drivers/usb/roles/class.c
@@ -108,9 +108,14 @@ static void *usb_role_switch_match(struc
 static struct usb_role_switch *
 usb_role_switch_is_parent(struct fwnode_handle *fwnode)
 {
-	struct fwnode_handle *parent = fwnode_get_parent(fwnode);
+	struct fwnode_handle *parent;
 	struct device *dev;
 
+	if (fwnode_property_match_string(fwnode, "compatible", "usb-b-connector") < 0)
+		return NULL;
+
+	parent = fwnode_get_parent(fwnode);
+
 	if (!fwnode_property_present(parent, "usb-role-switch")) {
 		fwnode_handle_put(parent);
 		return NULL;



