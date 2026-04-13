Return-Path: <stable+bounces-237279-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8D9JLEsf3WmSaAkAu9opvQ
	(envelope-from <stable+bounces-237279-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:52:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 727863F0150
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6E19C301D08A
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5201317152;
	Mon, 13 Apr 2026 16:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PlMhg4a1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C823161BF;
	Mon, 13 Apr 2026 16:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099047; cv=none; b=WsG0ZLeWkp8N2Iw77snFkKZiWlCmoKqJca4qMB4ryDsqB/f1AA2DWV3dabalpyTyUW8i9CXd/u5Mfvmd08IwhYqua61IZFV+tKKZAQ7TczsPDD4SaWRXT5Ra0zcpVPZd5kKC2vXVCkmYKDbftKEzIrRjD9KXkb7Bx7onzQcQu5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099047; c=relaxed/simple;
	bh=lZSiwHXuoeLICzl2whdjXADWDrPibZpvqsAI13fUoLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q0dgY/UsHELzS+LmJ93MpZrzcjpo1e+E7CKg5FH2m2AJVsecy1u40CegCwLnDTilMVh7Djaa2Pz3tWhsk172OZE5vsV8lC9LTD3GlBAAZATs5Kn1apnf3kQ34pUmgWqdpy26RUFQvL4V2oPj5kJzNFatKZOfKVLe9uJZ/xZNonA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PlMhg4a1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E63DC2BCAF;
	Mon, 13 Apr 2026 16:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099047;
	bh=lZSiwHXuoeLICzl2whdjXADWDrPibZpvqsAI13fUoLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PlMhg4a1GQkic6qgFYjYAc/fBj42pVOWoU3bdlOhe6k3qa3fxkbk7v0D+7ID17yrx
	 jXnW5r80flubCk28u9QmPuN09xsioJirsf16Fika9qDmtbsvrscKCcR8LVlEu6w+Z2
	 o3H0j2SIB2HYO5r46IO+xf///ZD8xam/sOpqAnxQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 190/491] usb: gadget: f_tcm: Fix NULL pointer dereferences in nexus handling
Date: Mon, 13 Apr 2026 17:57:15 +0200
Message-ID: <20260413155826.181635886@linuxfoundation.org>
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
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,gmail.com,synopsys.com];
	TAGGED_FROM(0.00)[bounces-237279-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,synopsys.com:email]
X-Rspamd-Queue-Id: 727863F0150
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/function/f_tcm.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -1032,6 +1032,13 @@ static void usbg_cmd_work(struct work_st
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
 		transport_init_se_cmd(se_cmd,
@@ -1162,6 +1169,13 @@ static void bot_cmd_work(struct work_str
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
 		transport_init_se_cmd(se_cmd,



