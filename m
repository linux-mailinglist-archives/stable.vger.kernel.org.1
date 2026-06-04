Return-Path: <stable+bounces-260512-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G3ZAAIWJIWqCIQEAu9opvQ
	(envelope-from <stable+bounces-260512-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 16:19:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8660D640C54
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 16:19:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Ci+WFpfe;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260512-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260512-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA964309BFE4
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 14:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09635290DBB;
	Thu,  4 Jun 2026 14:13:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC0E43C061
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 14:13:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780582394; cv=none; b=ZJO/kQcEI8Ac6GEv+Z+8mTBtWkfAUhgg4D+VGXvU+1e/9Rdb8JgAgGtKJzKZAclZehwpOtRbWeH9csEMVr9Zp+Jd/HVaLV0Jk6p4IdRjMZ+gxQ+mpd7XyLfi7WHjGvIqsTJIM+pcVtJOiIXxFVTB34c4FAZEGDjWpo4TPG825mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780582394; c=relaxed/simple;
	bh=rlwz4rDaorvqYTObeylNlXMGxZ3xn6G5OMicLXRqugY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ecADRoj+tlTgJZtG3UB37xzn1/1pgTyQ94IP3ALOsHrbVEn4F/nRuGI0l9Fx5H0MhoVDVx/OAYGvrR8NcR4vloc1xcKPQD+n6A1qiWvGTYsGlJQT6a5ztCyb82629++21N/Mh+KuciKDIAZVrasQesm8rT69FwI94S386REPKbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ci+WFpfe; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EAD21F00893;
	Thu,  4 Jun 2026 14:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780582393;
	bh=8PwqBX0IceUQbzAJv4wzvBtODRkrrNpAJz8gyBc59vM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ci+WFpfeS4x0zsJXNdb9k1l12KQxvEpUqFdUOLSP6C+vkpRX5Hn2MSyZ0A2ck4Cw1
	 6BIIf9cIzSwwQ0Yua1Tgx0pNc/tvAa68B9zbFPmovQFveitTN/t/qhXgO+xUY97VTA
	 t4ruXBur8PolEE8MxUjrBgbg0P3TVImryznQpBRpoDkKPSC7DsAjrOi03McpYpGGO4
	 fglpKKL+q15WcT2nPSjXXfPkE/rOxNVJSntDePoLP7o1JFbJlMl1lERpQLGb26AgPg
	 IUGaHZjKQ5Tzm37TPbQjLlwDAFRdzyiCgc9zfUPxsFfKN9br38wJtbIb+fxYNimyH+
	 J1Htjk/Mpn12g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] USB: serial: cypress_m8: fix memory corruption with small endpoint
Date: Thu,  4 Jun 2026 10:13:11 -0400
Message-ID: <20260604141311.3549793-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060437-pampers-nutrient-e02f@gregkh>
References: <2026060437-pampers-nutrient-e02f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260512-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:johan@kernel.org,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8660D640C54

From: Johan Hovold <johan@kernel.org>

[ Upstream commit e1a9d791fd66ab2431b9e6f6f835823809869047 ]

Make sure that the interrupt-out endpoint max packet size is at least
eight bytes to avoid user-controlled slab corruption or NULL-pointer
dereference should a malicious device report a smaller size.

Fixes: 3416eaa1f8f8 ("USB: cypress_m8: Packet format is separate from characteristic size")
Cc: stable@vger.kernel.org	# 2.6.26
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/serial/cypress_m8.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/serial/cypress_m8.c b/drivers/usb/serial/cypress_m8.c
index 1e0c028c5ec95f..e766b78f88634e 100644
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


