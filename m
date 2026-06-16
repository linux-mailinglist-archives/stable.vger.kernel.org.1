Return-Path: <stable+bounces-264988-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PbU3NeWAMWphlAUAu9opvQ
	(envelope-from <stable+bounces-264988-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:59:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BCA692A2A
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:59:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=fCRfb03X;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264988-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-264988-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 765EA303B177
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E383646AF1E;
	Tue, 16 Jun 2026 16:55:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EDA169AD2;
	Tue, 16 Jun 2026 16:55:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628939; cv=none; b=YTdIOIFZraOuV9wNKXOq+Hwj69gczBthTDo4qrtZXpMWCskNKqj4ARrPPHvU8TFvfElu8bji1rWHfs30tp20Z/jNSLabyl3NDy0TWB/4DkWBoiOkJnwJpiWZVX01Dg2vfvBpLr6P68SS2/knocOXc/e3Oo+jaCk3riv+axTRa9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628939; c=relaxed/simple;
	bh=StS3bzZGLOTLHbhtScqUlwvHJS79dvZGqNSEHnxiZAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RmR2vTe2oXdrjZtBbkmU8BKwvwgF7fczBkYZZJu0v/P5g2zUD/TJ/jxP61wMllxCA+3ZZmjWyFoYXWspWQsaWhgCFnzxjg3ToG/U/kAfQ2SjnMb9ySY7++oj1h+wEovPIm5MygFo8ETk+SfeRABuvsQjDIFgAte2Pd8k4QZmBKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fCRfb03X; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA82D1F000E9;
	Tue, 16 Jun 2026 16:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781628938;
	bh=z34dSYW8Ioov80/niWCa16JS8xUwHWX++dfqeTZwhgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fCRfb03Xn1B0O5xodlWMhP3R+xnC2RoCZ4v4kxB/1XY5P1pgy1XavaKrRDvrl9Spl
	 eAy9J63tr1GmtztxcK66SOV2oE/U9Zihyz1Fqhw++0Uah4EbZ3rrp6O0L8EaIk9xc5
	 TDZjOThSpHidtEfKNMuIYxeIt8CgeEci1k+3gUh0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johan Hovold <johan@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 191/452] USB: serial: cypress_m8: fix memory corruption with small endpoint
Date: Tue, 16 Jun 2026 20:26:58 +0530
Message-ID: <20260616145127.870165606@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264988-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:johan@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 80BCA692A2A

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit e1a9d791fd66ab2431b9e6f6f835823809869047 upstream.

Make sure that the interrupt-out endpoint max packet size is at least
eight bytes to avoid user-controlled slab corruption or NULL-pointer
dereference should a malicious device report a smaller size.

Fixes: 3416eaa1f8f8 ("USB: cypress_m8: Packet format is separate from characteristic size")
Cc: stable@vger.kernel.org	# 2.6.26
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
[ johan: adjust context for 6.18 ]
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/serial/cypress_m8.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/serial/cypress_m8.c b/drivers/usb/serial/cypress_m8.c
index 4c625e77da3a8f..f567617c8f2314 100644
--- a/drivers/usb/serial/cypress_m8.c
+++ b/drivers/usb/serial/cypress_m8.c
@@ -448,6 +448,14 @@ static int cypress_generic_port_probe(struct usb_serial_port *port)
 		return -ENODEV;
 	}
 
+	/*
+	 * The buffer must be large enough for the one or two-byte header (and
+	 * following data), but assume anything smaller than eight bytes is
+	 * broken.
+	 */
+	if (port->interrupt_out_size < 8)
+		return -EINVAL;
+
 	priv = kzalloc(sizeof(struct cypress_private), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
-- 
2.53.0




