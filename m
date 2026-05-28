Return-Path: <stable+bounces-255696-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEUZEiOnGGp+lwgAu9opvQ
	(envelope-from <stable+bounces-255696-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:35:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA46D5F90D0
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AAE531D2DF3
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06062C11F9;
	Thu, 28 May 2026 20:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xMypXMpU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB9F2F8E83;
	Thu, 28 May 2026 20:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999631; cv=none; b=ITuyoRR3hNH+X6qB+NAyRhL+HGlAJcnN0DLSmUi36GykVr0GkBMwWGkJxGMZ3HkJXNc0yL+yWXH0uGB4azC4y1Njd6OY+PMyeqznpP6P3p4q4S26wRTwQNfv9qsV0C8K9PtqpTs+vopS97McuKkD2nHGIRXXLc2H+I5BmgaCT1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999631; c=relaxed/simple;
	bh=f27EIe4kn8YzUgm16ui5/lUKl3xq6iOegYjvQv6sPSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tzic0FJTN9lSdteNdBfiSVZpgdf2TgXj3dWLVZ09tJm5bapQvvm62JjmqCrA0j7DaIiaYU7g40Psqw9F0BohsJh80M3UH8YVNegq/ZCv/33UCWk71If6DxQbsujpq2o9cZ/LxEdw5bnX0bGeqK6mIAGE3zsy1Gl2YSmPidz6ROg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xMypXMpU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7DD1F000E9;
	Thu, 28 May 2026 20:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999630;
	bh=y0+tBP8vruElHWAZ5VPj/B65oPVmeRrxWJqN3eUHlLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xMypXMpUXT8vBt2OwOCrIZV01c8Srl6RSAwUav8uc+UTrNhPhydqoZ7tXwwf8+EVv
	 MidV1n/IjB+lSDi2SSsjxgzrT8y2DNjQKcblB1z84JK8WrFtwyzHghpbhlxsw38Epj
	 TcTcVLnjdUghnHz29X53QwOc2yn1sWcIjlSpXIEI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alex Hung <alex.hung@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Ivan Lipski <ivan.lipski@amd.com>,
	Dan Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.18 135/377] drm/amd/display: Validate GPIO pin LUT table size before iterating
Date: Thu, 28 May 2026 21:46:13 +0200
Message-ID: <20260528194642.277272463@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255696-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: AA46D5F90D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Harry Wentland <harry.wentland@amd.com>

commit 86d2b20644b11d21fe52c596e6e922b4590a3e3f upstream.

[Why&How]
The GPIO pin table parsers in get_gpio_i2c_info() and
bios_parser_get_gpio_pin_info() derive an element count from the VBIOS
table_header.structuresize field, then iterate over gpio_pin[] entries.
However, GET_IMAGE() only validates that the table header itself fits
within the BIOS image. If the VBIOS reports a structuresize larger than
the actual mapped data, the loop reads past the end of the BIOS image,
causing an out-of-bounds read.

Fix this by calling bios_get_image() to validate that the full claimed
structuresize is accessible within the BIOS image before entering the
loop in both functions.

Assisted-by: GitHub Copilot:claude-opus-4-6
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit ba5e95b43b773ae1bf1f66ee6b31eb774e65afe3)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -492,6 +492,10 @@ static enum bp_result get_gpio_i2c_info(
 			- sizeof(struct atom_common_table_header))
 				/ sizeof(struct atom_gpio_pin_assignment);
 
+	if (!bios_get_image(&bp->base, DATA_TABLES(gpio_pin_lut),
+			    le16_to_cpu(header->table_header.structuresize)))
+		return BP_RESULT_BADBIOSTABLE;
+
 	pin = (struct atom_gpio_pin_assignment *) header->gpio_pin;
 
 	for (table_index = 0; table_index < count; table_index++) {
@@ -680,6 +684,11 @@ static enum bp_result bios_parser_get_gp
 	count = (le16_to_cpu(header->table_header.structuresize)
 			- sizeof(struct atom_common_table_header))
 				/ sizeof(struct atom_gpio_pin_assignment);
+
+	if (!bios_get_image(&bp->base, DATA_TABLES(gpio_pin_lut),
+			    le16_to_cpu(header->table_header.structuresize)))
+		return BP_RESULT_BADBIOSTABLE;
+
 	for (i = 0; i < count; ++i) {
 		if (header->gpio_pin[i].gpio_id != gpio_id)
 			continue;



