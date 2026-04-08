Return-Path: <stable+bounces-234963-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKDqEG+j1ml9GwgAu9opvQ
	(envelope-from <stable+bounces-234963-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:50:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4326B3C1B8C
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 243A03003830
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147443D75C3;
	Wed,  8 Apr 2026 18:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vplhUvYp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD2E2727F3;
	Wed,  8 Apr 2026 18:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674216; cv=none; b=VISN9mpFaCf/GTBt2OwS+ZdHuPe1AG/QwG9Refdqk3hPNDYc8uHqenayxBBVncqFzooCylqtLn6xZrek8GoSRTmzA9B244PanneGS6dh3GxI/ApxhFiY7pzw8t2yBD+/Us+fvHARrM/EzHYvCU6hHcdMvF343FEaaePJ2VaaR6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674216; c=relaxed/simple;
	bh=woszEe/owto8wA0bnEMtz6ROUAItgE0OfMA1vuDQTp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fe454W8nEO/9V4cYiCQKdiM0Yv/Pfxt1cC65DeroyfKRPq4wB/Arprl5XmsxnJNpPtSVXjO/ekWILEwvnT/OnQLMjTB7+Ww3HUqUTU84P3HfR6T/85wzF971RU9aX5MNVs/L5PZAg4d22XvXuY+1wBPABhNX4mvI/Lh1AFLesD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vplhUvYp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1C7C19421;
	Wed,  8 Apr 2026 18:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674216;
	bh=woszEe/owto8wA0bnEMtz6ROUAItgE0OfMA1vuDQTp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vplhUvYpAtxwUoKycExMwbYzSyG/K8sS7qmA/t3mxb6zlrlhQhSwVK/6q8EoOreV5
	 ld/PL9WL3bxDCQd+T0VDSPkpmkkJ1UUCJ4EnWYO0RhfA0fgEocZ9wnOkJKQTr7Ewaj
	 xMlJD8KSR7HPbqfjtUcT64HH/8EU4PpWlLXOLnfM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Beno=C3=AEt=20Sevens?= <bsevens@google.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 012/311] HID: wacom: fix out-of-bounds read in wacom_intuos_bt_irq
Date: Wed,  8 Apr 2026 20:00:12 +0200
Message-ID: <20260408175939.871235987@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175939.393281918@linuxfoundation.org>
References: <20260408175939.393281918@linuxfoundation.org>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-234963-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,suse.com:email,wacom.com:email]
X-Rspamd-Queue-Id: 4326B3C1B8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benoît Sevens <bsevens@google.com>

[ Upstream commit 2f1763f62909ccb6386ac50350fa0abbf5bb16a9 ]

The wacom_intuos_bt_irq() function processes Bluetooth HID reports
without sufficient bounds checking. A maliciously crafted short report
can trigger an out-of-bounds read when copying data into the wacom
structure.

Specifically, report 0x03 requires at least 22 bytes to safely read
the processed data and battery status, while report 0x04 (which
falls through to 0x03) requires 32 bytes.

Add explicit length checks for these report IDs and log a warning if
a short report is received.

Signed-off-by: Benoît Sevens <bsevens@google.com>
Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/wacom_wac.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 9b2c710f8da18..da1f0ea85625d 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1208,10 +1208,20 @@ static int wacom_intuos_bt_irq(struct wacom_wac *wacom, size_t len)
 
 	switch (data[0]) {
 	case 0x04:
+		if (len < 32) {
+			dev_warn(wacom->pen_input->dev.parent,
+				 "Report 0x04 too short: %zu bytes\n", len);
+			break;
+		}
 		wacom_intuos_bt_process_data(wacom, data + i);
 		i += 10;
 		fallthrough;
 	case 0x03:
+		if (i == 1 && len < 22) {
+			dev_warn(wacom->pen_input->dev.parent,
+				 "Report 0x03 too short: %zu bytes\n", len);
+			break;
+		}
 		wacom_intuos_bt_process_data(wacom, data + i);
 		i += 10;
 		wacom_intuos_bt_process_data(wacom, data + i);
-- 
2.53.0




