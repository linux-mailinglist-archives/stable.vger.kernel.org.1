Return-Path: <stable+bounces-223613-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oE7TJB+vrmkSHwIAu9opvQ
	(envelope-from <stable+bounces-223613-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 12:29:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 40869237EF6
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 12:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A880D301B78D
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 11:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06B239E191;
	Mon,  9 Mar 2026 11:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t8LK0OlW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744CA39B4BA
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 11:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773055771; cv=none; b=lfqo8/xlQ0P5JNj2wQM2e30tby08MdQ37/w/+rpOdKdw1o8SA9atTvj6R4PEZ/dLFsEx5GeHoAZ0wnWXNIK4fXSRcEf+Ndk91ZmpyYD8CSjNVC8wtEQ2bLWvY/bbi263uKdy44CFhQyi2upBTbbfbYpmmD6/5ohxUizBt8SWP+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773055771; c=relaxed/simple;
	bh=S1pSCU/Hwevk4H4NToMkxdK8zxREjfNP57fgBfkI3jE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KkcABa8+/y5uZS1/TkB7j80DnO7Z/Ln5N29EsMQid6ZG2AjNouKVpmn+7CR4VXdrRMg4F2sHgLjA8NHbcGx9hdYCqINNBdKY5o6txWmedJZYKIhpr7rJFRW5aLPaaChTc8nkforkG587TV+IPC4+J4jFlh6ZPiXdmipyPTc3CN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t8LK0OlW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC0EAC4CEF7;
	Mon,  9 Mar 2026 11:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773055771;
	bh=S1pSCU/Hwevk4H4NToMkxdK8zxREjfNP57fgBfkI3jE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t8LK0OlW3TeTPwiEFTNP9l3/OzpS4L9b3D/+AKJG94w5X0I6PbJeCco4XwURvVGDg
	 5xe0ZjeM2gUe8pDaV6sGPD/lIwWv3DQ5pPxsFoAiOdDfFJCGNnFLI4wkRn6Uc6iag4
	 OrGLiYJXKEdxeJBN3bOw1tEssmZ1t/fppBGpNxjV59AwFvaI5CsXi7Z1y1CN27jqpS
	 +arlAeWo5VwrOypORxEQUDcvJz2MMaC9xOWOAlV6HTHsl0snuFvUAr2T9LNEcVEizj
	 dESaWyybAafNplxAq804GBr53YTxMgTdQvG38xNl8xbR2BTk7DQthm+3AIYH8ToeiH
	 VghUAKcuCTS9w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daniel Hodges <git@danielhodges.dev>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] wifi: libertas: fix use-after-free in lbs_free_adapter()
Date: Mon,  9 Mar 2026 07:29:28 -0400
Message-ID: <20260309112928.819155-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026030918-bulge-october-6117@gregkh>
References: <2026030918-bulge-october-6117@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 40869237EF6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223613-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.984];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,danielhodges.dev:email,intel.com:email]
X-Rspamd-Action: no action

From: Daniel Hodges <git@danielhodges.dev>

[ Upstream commit 03cc8f90d0537fcd4985c3319b4fafbf2e3fb1f0 ]

The lbs_free_adapter() function uses timer_delete() (non-synchronous)
for both command_timer and tx_lockup_timer before the structure is
freed. This is incorrect because timer_delete() does not wait for
any running timer callback to complete.

If a timer callback is executing when lbs_free_adapter() is called,
the callback will access freed memory since lbs_cfg_free() frees the
containing structure immediately after lbs_free_adapter() returns.

Both timer callbacks (lbs_cmd_timeout_handler and lbs_tx_lockup_handler)
access priv->driver_lock, priv->cur_cmd, priv->dev, and other fields,
which would all be use-after-free violations.

Use timer_delete_sync() instead to ensure any running timer callback
has completed before returning.

This bug was introduced in commit 8f641d93c38a ("libertas: detect TX
lockups and reset hardware") where del_timer() was used instead of
del_timer_sync() in the cleanup path. The command_timer has had the
same issue since the driver was first written.

Fixes: 8f641d93c38a ("libertas: detect TX lockups and reset hardware")
Fixes: 954ee164f4f4 ("[PATCH] libertas: reorganize and simplify init sequence")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Hodges <git@danielhodges.dev>
Link: https://patch.msgid.link/20260206195356.15647-1-git@danielhodges.dev
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
[ del_timer() => timer_delete_sync() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/marvell/libertas/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/marvell/libertas/main.c b/drivers/net/wireless/marvell/libertas/main.c
index 1c56cc2742b07..459b30a1050d7 100644
--- a/drivers/net/wireless/marvell/libertas/main.c
+++ b/drivers/net/wireless/marvell/libertas/main.c
@@ -882,8 +882,8 @@ static void lbs_free_adapter(struct lbs_private *priv)
 {
 	lbs_free_cmd_buffer(priv);
 	kfifo_free(&priv->event_fifo);
-	del_timer(&priv->command_timer);
-	del_timer(&priv->tx_lockup_timer);
+	timer_delete_sync(&priv->command_timer);
+	timer_delete_sync(&priv->tx_lockup_timer);
 	del_timer(&priv->auto_deepsleep_timer);
 }
 
-- 
2.51.0


