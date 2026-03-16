Return-Path: <stable+bounces-225704-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eApqLLBtuGn5dgEAu9opvQ
	(envelope-from <stable+bounces-225704-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 21:53:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 172C92A0677
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 21:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96A623099EA6
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 20:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01783359A92;
	Mon, 16 Mar 2026 20:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enug4uUK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B979A359A76
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 20:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773694260; cv=none; b=fE+FxvXzGmPI9NKsGL51eW3nRTQ3Zb1GVs5x64+18RZ5xLO4oYwM8ahsza/6e9hqE0tUWNFlFhN+4OVPmMyKgxjBUBwWgD/jk32kZ7ks0aEO0T0qyIOth3JMJzcpr69IpTfCzWlRgcgmi8F+vkAsiBj7S+F7C8jfS/WMa5AfIv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773694260; c=relaxed/simple;
	bh=fknB5/QWMIp4r1VDDPRz2wxvEele2tf69ttYEbrruWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QLjSBYTw5mLk57NiS5dXX2b1uxBtOqsXxjc1D1tzzSOvatWuhpOmoCMZvnaABdgL6OLtO13O+cY3UtzE6fDvt8PSXmupEQQswrbPVZYaB1EyEmjnDmg8wgpJUzIDgDPIjjgXRIIWOXug9scVjWXFnn6gEWmFyyb/+58YBYAP3DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enug4uUK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F7EC19421;
	Mon, 16 Mar 2026 20:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773694260;
	bh=fknB5/QWMIp4r1VDDPRz2wxvEele2tf69ttYEbrruWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=enug4uUKsJWmla5W7tXW+sGFQDstxS3DEEzPRYFLY/SjE5ten3SsLgln26MAWhsBX
	 qSITgXBSW2pC+huj50fvYZERSgbsPGDAFMT45ssC8Bjmha4Tot5kmahcUKrTZ6TMfc
	 SxLQscOqK+NstFKUt1+WfCJdrQT7YIooEAeiCoOwPth7NkY6ySI69tek53OcZhB3Du
	 Z+vmnFZ21xa/S3cVqnKa8Jxpe0HGHxN6H3OUeiE/5d+0SdxltrREflta1j8QgeHBSM
	 7c9oGVvCjejIiitb0JAFo4unnT5LzG+XAOytxgt9HrYyIABbXw5pv96EsC7P96WSNE
	 0u4VkMFB2eFvA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiasheng Jiang <jiashengjiangcool@gmail.com>,
	stable <stable@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] usb: gadget: f_tcm: Fix NULL pointer dereferences in nexus handling
Date: Mon, 16 Mar 2026 16:50:57 -0400
Message-ID: <20260316205057.1402393-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031608-obsessive-immortal-4f4c@gregkh>
References: <2026031608-obsessive-immortal-4f4c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,synopsys.com,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-225704-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 172C92A0677
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiasheng Jiang <jiashengjiangcool@gmail.com>

[ Upstream commit b9fde507355342a2d64225d582dc8b98ff5ecb19 ]

The `tpg->tpg_nexus` pointer in the USB Target driver is dynamically
managed and tied to userspace configuration via ConfigFS. It can be
NULL if the USB host sends requests before the nexus is fully
established or immediately after it is dropped.

Currently, functions like `bot_submit_command()` and the data
transfer paths retrieve `tv_nexus = tpg->tpg_nexus` and immediately
dereference `tv_nexus->tvn_se_sess` without any validation. If a
malicious or misconfigured USB host sends a BOT (Bulk-Only Transport)
command during this race window, it triggers a NULL pointer
dereference, leading to a kernel panic (local DoS).

This exposes an inconsistent API usage within the module, as peer
functions like `usbg_submit_command()` and `bot_send_bad_response()`
correctly implement a NULL check for `tv_nexus` before proceeding.

Fix this by bringing consistency to the nexus handling. Add the
missing `if (!tv_nexus)` checks to the vulnerable BOT command and
request processing paths, aborting the command gracefully with an
error instead of crashing the system.

Fixes: c52661d60f63 ("usb-gadget: Initial merge of target module for UASP + BOT")
Cc: stable <stable@kernel.org>
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Reviewed-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://patch.msgid.link/20260219023834.17976-1-jiashengjiangcool@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/f_tcm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index 55a81ad6837b6..2325d04db263d 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -1032,6 +1032,13 @@ static void usbg_cmd_work(struct work_struct *work)
 	se_cmd = &cmd->se_cmd;
 	tpg = cmd->fu->tpg;
 	tv_nexus = tpg->tpg_nexus;
+	if (!tv_nexus) {
+		struct usb_gadget *gadget = fuas_to_gadget(cmd->fu);
+
+		dev_err(&gadget->dev, "Missing nexus, ignoring command\n");
+		return;
+	}
+
 	dir = get_cmd_dir(cmd->cmd_buf);
 	if (dir < 0) {
 		__target_init_cmd(se_cmd,
@@ -1160,6 +1167,13 @@ static void bot_cmd_work(struct work_struct *work)
 	se_cmd = &cmd->se_cmd;
 	tpg = cmd->fu->tpg;
 	tv_nexus = tpg->tpg_nexus;
+	if (!tv_nexus) {
+		struct usb_gadget *gadget = fuas_to_gadget(cmd->fu);
+
+		dev_err(&gadget->dev, "Missing nexus, ignoring command\n");
+		return;
+	}
+
 	dir = get_cmd_dir(cmd->cmd_buf);
 	if (dir < 0) {
 		__target_init_cmd(se_cmd,
-- 
2.51.0


