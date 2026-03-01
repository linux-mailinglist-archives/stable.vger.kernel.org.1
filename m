Return-Path: <stable+bounces-221320-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KH+dBp+Wo2l7HQUAu9opvQ
	(envelope-from <stable+bounces-221320-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:30:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 764781CAD25
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6493C3037999
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253C225F78F;
	Sun,  1 Mar 2026 01:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNcrN7My"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB522264C7;
	Sun,  1 Mar 2026 01:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772327973; cv=none; b=K0bX4f+XRACDDMqQ5dw5JiXZQb8jaHz0W4RXn1jQgchENoS+aZJ1qUfmI+lwrrVY3kQ5gc3hv6KYn9aS4KxCDENCGmB/6L4fy7WzzqeRk8BMM/E9IbHkuHIqR0xID36tn5Ulsq03V86FKUiGyZGcjCiDzMqV/azbGNrHkixKVFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772327973; c=relaxed/simple;
	bh=7hAM4cWsdPbJiVVKB68GSk8EaT3P7S6dUTSO9J20Tns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MQnZMBoYm3l8QDFYbPuc2XfwkRF0ZPKzOkWVHmx55BA0WHUDXqadTFMI6F8Kt+wDkqY3Uxlq5ZYPZmCwjbKJ3gU4z0D22joC/XGspEZQi7Xb6Ba3Sq+Ruvh/OYfT4mcUOmzOs298Eoouiuzo+vRC6aknGYCeZFOvw1aX432NKRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNcrN7My; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F99CC19421;
	Sun,  1 Mar 2026 01:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772327973;
	bh=7hAM4cWsdPbJiVVKB68GSk8EaT3P7S6dUTSO9J20Tns=;
	h=From:To:Cc:Subject:Date:From;
	b=nNcrN7MyHY0IQwCwzMIU+oEd0FscDTabYcvXicmzKNZN8vbrjZCqPeR0P33tUTOjh
	 hyJ1sFIhQMwtljJvfk4sQVn+is8SkO8OolmmTOIYPrGnSr7VfLVXh65Jvc0ZF50I8o
	 0xRKh6ogvo7neYUX6gGcBbIq3Xj8a3g+c5Dw+G89bv4TVM+VoUpnMSaeoI+mghzAs1
	 VNpR0/LFOj4V/bsWjHhMe0FjRdSNxSoxISKCyIFZgjffWmdMNrrOxESXUOuXHkshAO
	 NkylkCtjhiPBD+2JgdjkN4Kc5GLFN4ipreMCloRe4DN6obW3KInhU1RbzGaw/+nKgz
	 U/q6+beSC18RQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gnoack@google.com
Cc: Jiri Kosina <jkosina@suse.com>,
	linux-input@vger.kernel.org
Subject: FAILED: Patch "HID: prodikeys: Check presence of pm->input_ep82" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:19:31 -0500
Message-ID: <20260301011932.1674619-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-221320-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 764781CAD25
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From cee8337e1bad168136aecfe6416ecd7d3aa7529a Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Date: Fri, 9 Jan 2026 11:58:08 +0100
Subject: [PATCH] HID: prodikeys: Check presence of pm->input_ep82
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fake USB devices can send their own report descriptors for which the
input_mapping() hook does not get called.  In this case, pm->input_ep82 stays
NULL, which leads to a crash later.

This does not happen with the real device, but can be provoked by imposing as
one.

Cc: stable@vger.kernel.org
Signed-off-by: Günther Noack <gnoack@google.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
---
 drivers/hid/hid-prodikeys.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-prodikeys.c b/drivers/hid/hid-prodikeys.c
index 74bddb2c3e82e..6e413df38358a 100644
--- a/drivers/hid/hid-prodikeys.c
+++ b/drivers/hid/hid-prodikeys.c
@@ -378,6 +378,10 @@ static int pcmidi_handle_report4(struct pcmidi_snd *pm, u8 *data)
 	bit_mask = (bit_mask << 8) | data[2];
 	bit_mask = (bit_mask << 8) | data[3];
 
+	/* robustness in case input_mapping hook does not get called */
+	if (!pm->input_ep82)
+		return 0;
+
 	/* break keys */
 	for (bit_index = 0; bit_index < 24; bit_index++) {
 		if (!((0x01 << bit_index) & bit_mask)) {
-- 
2.51.0





