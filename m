Return-Path: <stable+bounces-250886-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNP4HEz1DWoz5AUAu9opvQ
	(envelope-from <stable+bounces-250886-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:54:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7589E594E31
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3FE163084C5F
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50993372ECB;
	Wed, 20 May 2026 17:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JPD05GWS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D602BE02A;
	Wed, 20 May 2026 17:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296565; cv=none; b=MkpUUBm2NMp1pNcAD9dkKUwE8t5FR+wBnXFsXKNVoDsrihwS3tw5/kAMSmwzZfEEpffK/lGUyIfVWatV5ZA4v9E+rHdRrgMwOmbbdG2xmtIfkbNPMzWpJyAvtRNtyu0yS9GCuuXr7AnMwU8D+mvKXA19ElWPaAm1t6rrLqWLY3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296565; c=relaxed/simple;
	bh=pb3n3QgUOdAOzj+TlDgRQfssl8ti7vwih2c5gXJZSCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ObT45rbj2n0BSgN8SVnKM5yRwdSG95qmxp8ePcqCoQK7dsrzGrNaUQ4XRdAGqGuxhCQm+OfQeSgDfz5dDpd6bHmzHasRAIauitjDP41CCZN1lW7Z39V7Lgq8ajta71zS6VLkLkiYRvB/IZGIUesJOPFxt+3/aC1p4ZqXEdKmPJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JPD05GWS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE92B1F00893;
	Wed, 20 May 2026 17:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779296561;
	bh=x/LT5sBpg7M7IuqjvQt4d9at2ahl6PiQ1STLuFkTOp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JPD05GWSFfgY2LQcb0xMm1vUqsnoBfcF3IAc8bg/mgY9Qw+v9vS9VSncnTe4amRn4
	 TdTzEN35hNNSlPICXvQ3NwSuwDPy51ymkLnIKl1TAREEqYtT4d41UiyE8w+zQqfHvi
	 ugx9wgpCSu7+Liju+68Cj8EJXqm4kF3HAYNVHjVk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Abdulkader Alrezej <alrazj.abdulkader@gmail.com>,
	Mieczyslaw Nalewaj <namiltd@yahoo.com>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0846/1146] net: dsa: realtek: rtl8365mb: fix mode mask calculation
Date: Wed, 20 May 2026 18:18:16 +0200
Message-ID: <20260520162207.381223893@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-250886-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,yahoo.com,redhat.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7589E594E31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mieczyslaw Nalewaj <namiltd@yahoo.com>

[ Upstream commit 0c078021d3861966614d5e594ee03587f0c9e74d ]

The RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_MASK macro was shifting
the 4-bit mask (0xF) by only (_extint % 2) bits instead of
(_extint % 2) * 4. This caused the mask to overlap with the adjacent
nibble when configuring odd-numbered external interfaces, selecting
the wrong bits entirely.

Align the shift calculation with the existing ...MODE_OFFSET macro.

Fixes: 4af2950c50c8 ("net: dsa: realtek-smi: add rtl8365mb subdriver for RTL8365MB-VC")
Signed-off-by: Abdulkader Alrezej <alrazj.abdulkader@gmail.com>
Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Link: https://patch.msgid.link/400a6387-a444-4576-af6d-26be5410bce3@yahoo.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/realtek/rtl8365mb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index 31fa94dac627d..c35cef01ec265 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -216,7 +216,7 @@
 		 (_extint) == 2 ? RTL8365MB_DIGITAL_INTERFACE_SELECT_REG1 : \
 		 0x0)
 #define   RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_MASK(_extint) \
-		(0xF << (((_extint) % 2)))
+		(0xF << (((_extint) % 2) * 4))
 #define   RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_OFFSET(_extint) \
 		(((_extint) % 2) * 4)
 
-- 
2.53.0




