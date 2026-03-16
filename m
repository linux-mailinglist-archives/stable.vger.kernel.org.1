Return-Path: <stable+bounces-225684-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id lTUkC8dbuGl0cgEAu9opvQ
	(envelope-from <stable+bounces-225684-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 20:36:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 942AF29FD54
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 20:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E698301BECB
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 19:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE133DBD40;
	Mon, 16 Mar 2026 19:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDY+GIlB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338C33254A9
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 19:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773689794; cv=none; b=Kqu9QkjqSUKoQ1XlPAdANvdQn1F+6ILrYCXcSgM3NdLF/vRUIkqOuQ1GSLoJ7eAqYnCGkPAVLjyewk8Imjh0uhbq6smZE2AO8PqyI/mniUERj2LXvboRsNtIhqgk8nGMkMC1YM2xBY50NY9uKpeA4Zl4r11a/hearrhHLi00Z6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773689794; c=relaxed/simple;
	bh=1WvW4SmZuDJcawVfq9bzMViy1QTXUqgI3d7qcag3lC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tpHLxJmUhBQNCi4vfdcqwNcAFN97W24yDMdLzU+h1UJW7Mf2RkCfo+bdOorxXTCF7w2OYqRMOkyZM3EbOAZegpByLTY3UUyvD6fKpK/L5I49sCsJTkshqk9ysigrtGt898l/bEqnGSewurvSMqTjY/EXLGwNxf06j8f3hGI3/cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDY+GIlB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C24C19421;
	Mon, 16 Mar 2026 19:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773689793;
	bh=1WvW4SmZuDJcawVfq9bzMViy1QTXUqgI3d7qcag3lC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gDY+GIlBs+3KR4qAd81Tac4BYqDROUaRnMUPjrORgKhfs6pj+kernwj+McgefUI7a
	 Mn9EeD8vg/S9beU61tRpAmns+GoyqQbGA4nkeZtxwSAkxHKHM1SmFb2W3vZLJdSlyi
	 VVNapp5oFv+2EedXCNwZ1XSehI2uIMJM5suy6PeUJL5d9BNiJvE7fEHslZPxC6rN/V
	 sdkEnM++up1yBh0/9LDbiyrEquvh9yms59ie7nv8CWAwSuKJeSq6kmM7btGDXaiBcP
	 jkA6tFH8DUaQH/m6vlBFCaH6c5h5gBanX1C5G5BSVnu6xpURin973dgFBfrD6Syhnh
	 7lY0HdD+8ZrYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiasheng Jiang <jiashengjiangcool@gmail.com>,
	stable <stable@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] usb: gadget: f_tcm: Fix NULL pointer dereferences in nexus handling
Date: Mon, 16 Mar 2026 15:36:31 -0400
Message-ID: <20260316193631.1358381-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031605-reviver-creme-dff6@gregkh>
References: <2026031605-reviver-creme-dff6@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,synopsys.com,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-225684-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 942AF29FD54
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
index 6ad205046032c..cca19b465e885 100644
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


