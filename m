Return-Path: <stable+bounces-261478-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id a0nBIcNKJWoSGQIAu9opvQ
	(envelope-from <stable+bounces-261478-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:41:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBB164FE6E
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:41:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="Jr/308dm";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261478-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-261478-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7B633043FBC
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD41328610;
	Sun,  7 Jun 2026 10:38:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542812D3A69;
	Sun,  7 Jun 2026 10:38:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780828710; cv=none; b=agz2UdVChCqUtDlRrceYUzSYiK75TMFEwZmKnaI+66IDoqFoOXnsglM+gNyE6XO/aNeecarZz29GrBwWFNhaC4aRr31MkgSFz/rtEZjq74TZLgOxOdBFZseHPBvANq9/ZxnAWCMBsr9zWLGcuMkIvnNU68L5v94b+i2HEXqhD6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780828710; c=relaxed/simple;
	bh=BCJhY60iKyCgumRNYYrj2ZaT2NK0ZRvng2PqGJVOsqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s74G8GhflR61Y0AjP6Fkcdj08/VcZrsEw3kN4JABZLU1ZmNLAAbbvNdRoy5bbTZ2aww/QEYrMm7RkI/DMbAwhRz5bG5lNeufwR0T5TP/oMMhvKN6XZBWIgGNeNO2ev22llk6WpdssdtqIKJ1QDCELYma1Oplzxrcm/9x7/xLiw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Jr/308dm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6288E1F00893;
	Sun,  7 Jun 2026 10:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780828709;
	bh=bdFjrj36CS4UADTyGAxSwcBxBR86LqgvSIk+uEg8jPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jr/308dmMZpJrlfXEbxzEYS24zZVutbq7/xLTyst/7VbS9I4Lz6p9xrK96lAdy7QQ
	 ct45AR2BTAFplZRmk1RsKxBvVrDU+ACBWd2naT6R5c8ofDIQ45kkNhmmcGqTN0KsNX
	 +nKXscHoTO9OERR7DlxSbdTtYpW7//9YnyuRyqjY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 7.0 205/332] Input: elan_i2c - validate firmware size before use
Date: Sun,  7 Jun 2026 11:59:34 +0200
Message-ID: <20260607095735.595080279@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095728.031258202@linuxfoundation.org>
References: <20260607095728.031258202@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261478-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:dmitry.torokhov@gmail.com,m:dmitrytorokhov@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,msgid.link:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DFBB164FE6E

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

commit 76b0d0baa9ae9c60e726bbe1b6ff0bec2c993634 upstream.

Ensure that the firmware file is large enough to contain the expected
number of pages and the signature (which resides at the end of the
firmware blob) before accessing them to prevent potential out-of-bounds
reads.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/ae2dOgiFvXRm4BHo@google.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/mouse/elan_i2c_core.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -645,6 +645,11 @@ static ssize_t elan_sysfs_update_fw(stru
 		return error;
 	}
 
+	if (fw->size < data->fw_signature_address + sizeof(signature)) {
+		dev_err(dev, "firmware file too small\n");
+		return -EBADF;
+	}
+
 	/* Firmware file must match signature data */
 	fw_signature = &fw->data[data->fw_signature_address];
 	if (memcmp(fw_signature, signature, sizeof(signature)) != 0) {



