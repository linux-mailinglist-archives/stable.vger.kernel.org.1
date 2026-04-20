Return-Path: <stable+bounces-239874-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDUvBV1b5mmtvAEAu9opvQ
	(envelope-from <stable+bounces-239874-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:59:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 999CB430503
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AEAEE30E7E90
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B4034402B;
	Mon, 20 Apr 2026 16:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vQnjfZGO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582B033F586;
	Mon, 20 Apr 2026 16:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776701437; cv=none; b=pfTxROBHkUfQ/c/hZ8nAXa8k0dKP22kGNYkiQJsKQsonqAWF5bWK8XYiajlYuD2nlFiU//IsAggPJklKWv7nOnEXj1fs8SeiJmfqJDZJ3nP1dRksAaGB3hI/mymHRDAbJuveMY7FxTazz4zvtY1HZGTc3/4Kh/ENYI0XDyJzxWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776701437; c=relaxed/simple;
	bh=oXpMQP34sNUjOxk/tSrSSjAHrsXeEuTND+iTCM0G6/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=htNkKQTla4JTfdk2GF/866aIZdZXk21ujKAG9RaG0z/gBoOEcLnIFxelFZL912pF3uhJ+FOSql9HuXRrL2chghYgLMwL6a+sCg59tD9uXLELsg4jeQ5hUsa5u1D+1v3ZIbuIFyeuLGskz+YPnuJvd4ZB65lZpR4kpTEfQVEPVpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vQnjfZGO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3682C19425;
	Mon, 20 Apr 2026 16:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776701437;
	bh=oXpMQP34sNUjOxk/tSrSSjAHrsXeEuTND+iTCM0G6/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vQnjfZGO43qkGvLlbFyNPz7cQIYWuCebmAvEBv9PaoZ/Ag3yTuqEznpZwUvv3mPru
	 36cKUW+2DcQCfBnT6qDLReAs7SKqlmrd3Fhm45OY2AuDtfqFbv/VkSOYMbV209K5CQ
	 XzevB0pk3WnL9LhUztLLCX+q9sGQ3KjB10GyZixw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Daniel=20Br=C3=A1t?= <danek.brat@gmail.com>,
	stable <stable@kernel.org>
Subject: [PATCH 6.12 112/162] usb: storage: Expand range of matched versions for VL817 quirks entry
Date: Mon, 20 Apr 2026 17:42:24 +0200
Message-ID: <20260420153931.097345494@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153927.006696811@linuxfoundation.org>
References: <20260420153927.006696811@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-239874-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,weissschuh.net:email]
X-Rspamd-Queue-Id: 999CB430503
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Brát <danek.brat@gmail.com>

commit 609865ab3d5d803556f628e221ecd3d06aed9f30 upstream.

Expands range of matched bcdDevice values for the VL817 quirk entry.
This is based on experience with Axagon EE35-GTR rev1 3.5" HDD
enclosure, which reports its bcdDevice as 0x0843, but presumably other
vendors using this IC in their products may set it to any other value.

Signed-off-by: Daniel Brát <danek.brat@gmail.com>
Cc: stable <stable@kernel.org>
Link: https://patch.msgid.link/20260402172433.5227-1-danek.brat@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/storage/unusual_devs.h |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/usb/storage/unusual_devs.h
+++ b/drivers/usb/storage/unusual_devs.h
@@ -2350,10 +2350,11 @@ UNUSUAL_DEV(  0x2027, 0xa001, 0x0000, 0x
 		US_FL_SCM_MULT_TARG ),
 
 /*
- * Reported by DocMAX <mail@vacharakis.de>
- * and Thomas Weißschuh <linux@weissschuh.net>
+ * Reported by DocMAX <mail@vacharakis.de>,
+ * Thomas Weißschuh <linux@weissschuh.net>
+ * and Daniel Brát <danek.brat@gmail.com>
  */
-UNUSUAL_DEV( 0x2109, 0x0715, 0x9999, 0x9999,
+UNUSUAL_DEV( 0x2109, 0x0715, 0x0000, 0x9999,
 		"VIA Labs, Inc.",
 		"VL817 SATA Bridge",
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,



