Return-Path: <stable+bounces-212113-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEFAKUcvemlq3wEAu9opvQ
	(envelope-from <stable+bounces-212113-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:46:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F9DA45EF
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 855E63105309
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAE426E6F9;
	Wed, 28 Jan 2026 15:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gUesSpx7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DF0242D86;
	Wed, 28 Jan 2026 15:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614438; cv=none; b=KFu6gKJ0qmzMPHdUAT7Bg3NhrJ2tJZnv6v1AGtGXO029Jcev65cf15vvp5HbBZeW/yljMJxkJz8rqSRWKMA8O1aYjRgPvfRmmDgwnCxQEwPslpyAxtXthKb05hsxp6bf8/l5nJonUmAbuxo0xzIa5XD1FjrH6NVSFsq1dfK3xLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614438; c=relaxed/simple;
	bh=+uw8L3/YAuJrIaGSNkNW8PRmsL5hwDrkREROGYMTQyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hq6NXgwfnMJMMRGvTnPrGFEVuXFPLZ7kdKDu1PU3fl6/SGtlaSXtQcQsGk6jE1rJnqMdK4cKvE6YxnC76QXEDWWhgtJxiCU9RYFua5jslxJxlRTWXN5j3SyL62bfMetqdcfOS6KedqS7aDFoLRh82/OeiNPX2TNC3Qo8L3a0o+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gUesSpx7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 623DBC4CEF1;
	Wed, 28 Jan 2026 15:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769614438;
	bh=+uw8L3/YAuJrIaGSNkNW8PRmsL5hwDrkREROGYMTQyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gUesSpx7gyJpP7YWqnrOy0fjWs8kJK7Ngwi+H5xfkDiuhGzBZIXtKeEKME46s/4fh
	 0X1pIo0HozoilzkfpmgqOhVSTZxHCtsCjwLHWoEnwWRu3VgY0UwR2sOLPsJ5+04MM1
	 TfNf0rc1wx4X1brlve6g0S1gScFGZXfXjASwqI6g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Marnix Rijnart <marnix.rijnart@iwell.eu>
Subject: [PATCH 6.6 135/254] serial: 8250_pci: Fix broken RS485 for F81504/508/512
Date: Wed, 28 Jan 2026 16:21:51 +0100
Message-ID: <20260128145349.676749065@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.698118637@linuxfoundation.org>
References: <20260128145344.698118637@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-212113-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 29F9DA45EF
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marnix Rijnart <marnix.rijnart@iwell.eu>

commit 27aff0a56b3c77ea1a73641c9b3c4172a8f7238f upstream.

Fintek F81504/508/512 can support both RTS_ON_SEND and RTS_AFTER_SEND,
but pci_fintek_rs485_supported only announces the former.

This makes it impossible to unset SER_RS485_RTS_ON_SEND from
userspace because of uart_sanitize_serial_rs485(). Some devices
with these chips need RTS low on TX, so they are effectively broken.

Fix this by announcing the support for SER_RS485_RTS_AFTER_SEND,
similar to commit 068d35a7be65 ("serial: sc16is7xx: announce support
for SER_RS485_RTS_ON_SEND").

Fixes: 4afeced55baa ("serial: core: fix sanitizing check for RTS settings")
Cc: stable <stable@kernel.org>
Signed-off-by: Marnix Rijnart <marnix.rijnart@iwell.eu>
Link: https://patch.msgid.link/20260112000931.61703-1-marnix.rijnart@iwell.eu
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1563,7 +1563,7 @@ static int pci_fintek_rs485_config(struc
 }
 
 static const struct serial_rs485 pci_fintek_rs485_supported = {
-	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND,
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND,
 	/* F81504/508/512 does not support RTS delay before or after send */
 };
 



