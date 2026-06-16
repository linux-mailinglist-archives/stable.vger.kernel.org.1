Return-Path: <stable+bounces-265141-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0dPuC9WEMWrilQUAu9opvQ
	(envelope-from <stable+bounces-265141-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:16:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB46E692EF8
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:16:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=S5gE7l2I;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265141-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265141-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8346630CC7E5
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED8247AF66;
	Tue, 16 Jun 2026 17:07:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E1947A0B0;
	Tue, 16 Jun 2026 17:07:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781629679; cv=none; b=XICfhSUYfI6FOFBfIq5s5/bn86hZlE+GTobSU0tQR2K4FsIDn0XMDwKB0AfTz59InyU9oCPGCmCfd42qtndzMV93VlZYAY42lA00Gaf9diLlqzdr9cvO7woH6YPRvYz7C8UeYV3AV5UfUcH1o9txgd1yp4RnpYfhSt5BoAkbBDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781629679; c=relaxed/simple;
	bh=lb4QxJtYn6Kd+KAiJ4pzpVEYjGXkCaNXm7Q3lUIq/+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WPfHP7qwysjjc/AuUIighVo+jXfivlvMyRYncGhYFYQ10O3cTXy7RN5anhEU6PFyKT+fRTmiZtKVaYdBnn7zroQ+KQUQbsLK2Bww7RxVsVh3fQ+LKAxP13ti7W7i1URf/JaQN6Vkl1iY87S881A46mQF5B2AdKO1CmCutGejeBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S5gE7l2I; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B6CD1F00A3E;
	Tue, 16 Jun 2026 17:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781629678;
	bh=GI+2P0FNVAjj7u7k3e6zObksRfgrfEW0uSUBfA4+n8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S5gE7l2Irimz4ioUYc5aztN25lsvP51YOSMLxuto+SICLM8G+JUBM5ZLA+iSmO+VY
	 Y2lD6c42o373kGRziwY08/nPS6VBhaM8IGxhaxYVMhafJi2dl7XeWuPbTmsk9/hK4f
	 cByOChqhPdD2RMgnSK15Ubto0gFfPcA3qtssQSfQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hongfei Ren <lcrhf@outlook.com>,
	stable@kernel.org,
	Cryolitia PukNgae <cryolitia.pukngae@linux.dev>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 6.6 331/452] Input: atkbd - skip deactivate for HONOR BCC-Ns internal keyboard
Date: Tue, 16 Jun 2026 20:29:18 +0530
Message-ID: <20260616145134.758640956@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
References: <20260616145117.796205997@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,outlook.com,kernel.org,linux.dev,gmail.com];
	TAGGED_FROM(0.00)[bounces-265141-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:lcrhf@outlook.com,m:stable@kernel.org,m:cryolitia.pukngae@linux.dev,m:dmitry.torokhov@gmail.com,m:dmitrytorokhov@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:email,msgid.link:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AB46E692EF8

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cryolitia PukNgae <cryolitia.pukngae@linux.dev>

commit fb402386af4cdce108ff991a796386de55439735 upstream.

After commit 9cf6e24c9fbf17e52de9fff07f12be7565ea6d61 ("Input: atkbd -
do not skip atkbd_deactivate() when skipping ATKBD_CMD_GETID"), HONOR
BCC-N, aka HONOR MagicBook 14 2026's internal keyboard stops
working. Adding the atkbd_deactivate_fixup quirk fixes it.

DMI: HONOR BCC-N/BCC-N-PCB, BIOS 1.04 04/07/2026

Fixes: 9cf6e24c9fbf17e52de9fff07f12be7565ea6d61 ("Input: atkbd - do not skip atkbd_deactivate() when skipping ATKBD_CMD_GETID")
Reported-by: Hongfei Ren <lcrhf@outlook.com>
Link: https://github.com/colorcube/Linux-on-Honor-Magicbook-14-Pro/issues/1#issuecomment-4562679891
Tested-by: Hongfei Ren <lcrhf@outlook.com>
Cc: stable@kernel.org
Signed-off-by: Cryolitia PukNgae <cryolitia.pukngae@linux.dev>
Link: https://patch.msgid.link/20260605-honor-v1-1-78e05e491193@linux.dev
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/keyboard/atkbd.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -1952,6 +1952,13 @@ static const struct dmi_system_id atkbd_
 		},
 		.callback = atkbd_deactivate_fixup,
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HONOR"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "BCC-N"),
+		},
+		.callback = atkbd_deactivate_fixup,
+	},
 	{ }
 };
 



