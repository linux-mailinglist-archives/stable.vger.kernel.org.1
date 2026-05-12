Return-Path: <stable+bounces-246193-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLu1AGtsA2rF5gEAu9opvQ
	(envelope-from <stable+bounces-246193-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:07:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 942E7526D12
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 631EC323867E
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA6B3EDE53;
	Tue, 12 May 2026 17:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XpaJ5Dk5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBC43EDE41;
	Tue, 12 May 2026 17:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608598; cv=none; b=VS7Gvrf90A7iUQ5ztgDtim2ZdffZWeP3+WF5mZt7q89p5W4sXoJssb4rgyLpZtltFaRkCcIGqH62ED7LGhUIouQ2jv7E8ULOO/K7mGsuHvydIqLdfpqF1m58/M528agQvDznHxxV8jLA7kf/5YXcudNp3WOcTT7chgZDqHnMhns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608598; c=relaxed/simple;
	bh=MGcbVKOZLbjKRze1FCAT3wHRkJpYFC06AfXMb8/xTGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ftmi/zF2y6IO9F1lVtYHI/uAmf+SsHjgCxtaCehwg5+s7Z8xGYykuj/bi8jL2KANmxaihojbifLFmzE2kPTuQ11HmLLScFrUjRzrYan2LSCmBYSSyqWm4TPlvzFU5g4ibxafM7dz3jiUlprRWjWswqosrMRXfBXvT5gXGaIDF10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XpaJ5Dk5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5481EC2BCB0;
	Tue, 12 May 2026 17:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608597;
	bh=MGcbVKOZLbjKRze1FCAT3wHRkJpYFC06AfXMb8/xTGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XpaJ5Dk5Y3bInf9/6zGGiz5y3bGuChfZS9+u9tSaDvIbNceYe7OVOa3uvyqtyHxJ0
	 B4AsOp7bzIR3W/+rjg+pLuvUwvNrSfXTlWhG6+rlnzzKakgW/WkD5LydSw8snCXNLz
	 dyl482YzWZftDGXqhf045f/xVObHUtZ479MGahSM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tommaso Soncin <soncintommaso@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.18 141/270] ASoC: amd: yc: Add HP OMEN Gaming Laptop 16-ap0xxx product line in quirk table
Date: Tue, 12 May 2026 19:39:02 +0200
Message-ID: <20260512173941.420098347@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173938.452574370@linuxfoundation.org>
References: <20260512173938.452574370@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 942E7526D12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246193-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tommaso Soncin <soncintommaso@gmail.com>

commit d63c219b7ff39f897da10c160a2edef76320f16c upstream.

Add a DMI quirk for the HP OMEN Gaming Laptop 16-ap0xxx line fixing the
issue where the internal microphone was not detected.

Cc: stable@vger.kernel.org
Signed-off-by: Tommaso Soncin <soncintommaso@gmail.com>
Link: https://patch.msgid.link/20260429160858.538986-1-soncintommaso@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/amd/yc/acp6x-mach.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -55,6 +55,13 @@ static const struct dmi_system_id yc_acp
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "OMEN Gaming Laptop 16-ap0xxx"),
+		}
+	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Dell Inc."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Dell G15 5525"),
 		}
@@ -655,6 +662,13 @@ static const struct dmi_system_id yc_acp
 		}
 	},
 	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "8E35"),
+		}
+	},
+	{
 		.driver_data = &acp6x_card,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "MECHREVO"),



