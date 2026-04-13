Return-Path: <stable+bounces-236973-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Hy5Kfsi3WkYaQkAu9opvQ
	(envelope-from <stable+bounces-236973-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:08:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DC33F0CFE
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAE8C311830B
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A781B280CFB;
	Mon, 13 Apr 2026 16:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dnVhRXn6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFB1307AC7;
	Mon, 13 Apr 2026 16:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098264; cv=none; b=aWNYpo7voAKCsu50mrWWG5goIlZsioS9hiwniTelKMUx3hEVSwJuTKLFrMGGXup8ivaASVCp/P7DUDX9UrR9NPD6QgFSc/BtxGBhog9PsUSPQVgFsA7DkULNQgpYeDIDZNUUJ9ECao4Y4UkxKBHMwwNV9DD76HOvFlkyTbQhQxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098264; c=relaxed/simple;
	bh=kUOqr+py7jsvSIUfEZLUFlm4qJQAJvvSUH9e5N17k48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=INB1UjgbdTM0dAeVolZicG9RsF36y7YY6E3W01kfxSGV4ddBniBpqfA2p1gZc8S+a/t2ORlj1mUJIBEelzZv7OP0OXC9SSTbwZBufWSnR4LrnkRuT4TDBtAvFsWVhKb2DnTAZSH7I0FPvC4vK3ff1Z4yBo1T5Ka/sRlQXR5Rvlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dnVhRXn6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02DB8C2BCAF;
	Mon, 13 Apr 2026 16:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776098264;
	bh=kUOqr+py7jsvSIUfEZLUFlm4qJQAJvvSUH9e5N17k48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dnVhRXn6FZRWkO6gTEBW4ZHdNuoO6g7XdfnXownTdDgiAyvy7kqi0qi9LDptv15c6
	 iXalV+/C9MIWVoYQMEkIxb6GUFh6QPJ1PcG0wNOGK3+q2fF1Q8yPUshsSgkXIzoiep
	 RXhSeFt3Lq1GQg7IwD4SX6u1burWL1r9Jvb/UZw0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christoffer Sandberg <cs@tuxedo.de>,
	Werner Sembach <wse@tuxedocomputers.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5.15 457/570] Input: i8042 - add TUXEDO InfinityBook Max 16 Gen10 AMD to i8042 quirk table
Date: Mon, 13 Apr 2026 17:59:48 +0200
Message-ID: <20260413155847.589349403@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-236973-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,tuxedo.de,tuxedocomputers.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.990];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 00DC33F0CFE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoffer Sandberg <cs@tuxedo.de>

commit 5839419cffc7788a356428d321e3ec18055c0286 upstream.

The device occasionally wakes up from suspend with missing input on the
internal keyboard and the following suspend attempt results in an instant
wake-up. The quirks fix both issues for this device.

Signed-off-by: Christoffer Sandberg <cs@tuxedo.de>
Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Link: https://patch.msgid.link/20260223142054.50310-1-wse@tuxedocomputers.com
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/serio/i8042-acpipnpio.h |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/input/serio/i8042-acpipnpio.h
+++ b/drivers/input/serio/i8042-acpipnpio.h
@@ -1181,6 +1181,13 @@ static const struct dmi_system_id i8042_
 	},
 	{
 		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "X6KK45xU_X6SP45xU"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	{
+		.matches = {
 			DMI_MATCH(DMI_BOARD_NAME, "WUJIE Series-X5SP4NAG"),
 		},
 		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |



