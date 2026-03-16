Return-Path: <stable+bounces-225712-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKNCH1OEuGltfAEAu9opvQ
	(envelope-from <stable+bounces-225712-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 23:29:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D38E82A1795
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 23:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EC483075965
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 22:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE91D37267F;
	Mon, 16 Mar 2026 22:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/GWtKJI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CE7146D5A
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 22:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773700098; cv=none; b=pOEMMmgnWnu5hVv/hZt3GyUR283IshyOpnOVqBSfpjQjdvCmZKG3DZEvahWh3WvsliXEL0yooUvSrGIZvVe4iYPwa/Pm4id/BxVkOUxIl0aqI6eavk3ZUPylqjDw2sNaNYmUe03QEyeVyrrhTMyGkpyOzeNDPlypaRn1oGLBGns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773700098; c=relaxed/simple;
	bh=ysRmrZlYKrG9j7Zj0WVXoZKWwuWFDO123+CFUMCoOZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j1qk8Mb/0ik/KPV61R1O/hC16lvJ13Hesc3+uOJdQRxyKt8CHr3xP6Is0jcf0tgflR6U2vIhga07dAO8X4ysmC0Kfb4kT77uwT0xP5doMqVr4C3g+z4VszbTZdUv524O9K/g0w4p88DRhkDJvc0JCF5K+9rSBISDbNzU4wshFTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/GWtKJI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83FFAC19421;
	Mon, 16 Mar 2026 22:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773700098;
	bh=ysRmrZlYKrG9j7Zj0WVXoZKWwuWFDO123+CFUMCoOZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N/GWtKJIKpwtbOTFNKKl5vycCwPpyJkk/O6hEgdH9iSufwW8HhG1YkYpAmXisWo9Q
	 rO+xuGGzy/UClMI/VKtY4B1u4+V8Lh8KFaOWEzOjniEBBCc8HXdZE4nsm0wQgkhw34
	 0nzMMbZAOtrusTp1DSc6JIvCD66Ar5TaPzpHkVl7lX37Qc23HbVmBygHhaaj+TD3GV
	 xgZ1MXm/nRajBWGiJzAmzlpmC99ha2FBQo1K0Kav+EicEWM0UPT7GCcRswySTWyeJY
	 MBm4eFnzv48Bc0L+d7msqHor/32GA1ivuNR4umpspYeduQGvfvR/YmcPjVjSwpTWP/
	 c4jZJvp5wHRIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xu Yang <xu.yang_2@nxp.com>,
	stable <stable@kernel.org>,
	Arnaud Ferraris <arnaud.ferraris@collabora.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] usb: roles: get usb role switch from parent only for usb-b-connector
Date: Mon, 16 Mar 2026 18:28:15 -0400
Message-ID: <20260316222815.1434974-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031630-flier-referee-3151@gregkh>
References: <2026031630-flier-referee-3151@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225712-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D38E82A1795
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
---
 drivers/usb/roles/class.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
index 821b813370256..ae5aff85252fe 100644
--- a/drivers/usb/roles/class.c
+++ b/drivers/usb/roles/class.c
@@ -108,9 +108,14 @@ static void *usb_role_switch_match(struct fwnode_handle *fwnode, const char *id,
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
-- 
2.51.0


