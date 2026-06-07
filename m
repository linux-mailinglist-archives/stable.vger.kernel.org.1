Return-Path: <stable+bounces-261832-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JYBhLVZPJWocGwIAu9opvQ
	(envelope-from <stable+bounces-261832-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 13:00:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A895865037B
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 13:00:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=WsUqhSG8;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261832-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-261832-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8AC763004D2C
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 11:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A5D370ADB;
	Sun,  7 Jun 2026 11:00:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC3036D506;
	Sun,  7 Jun 2026 11:00:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780830021; cv=none; b=eklmvt2L9CjVySkNHkXXhtQSdYX/gTa/vsXePiU4PX8kRGI6Wen3wJqtzBhVhg35WH30nNkPqd+6Ij9ajUxOlMCqEvO1ZftRP/ZJ5laAgJYfLGb/8ZdOqtPqBl6KSq+wqPeFJkxuYL4oSwQGO2xIDHVUJkYbOXWvdKRRgX61dCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780830021; c=relaxed/simple;
	bh=9i9zGR8gqaEih7MWfq3WWqKIJtAJ/ZoD6zDXjSnURdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=okNzNXzNqaQ1xgZB7F9zLEzdUoziOWRpX/bdk8BMc6S3KUk/JhuKE7HS1pjiAsnyeCOBMJLCUwjh7kpNJ+pKPq5QEEpUGhwyhAgw2iaWoZjoqHagK6qI28KapgWUN30brdXfmtN9R+qvP4zqVxIAB4vz7siZw56wUP1nGzThVpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WsUqhSG8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD771F00898;
	Sun,  7 Jun 2026 11:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780830016;
	bh=1MPD2OJMlQcNLM9pue61Y1lfz0HsRgvz0x5D5auRItU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WsUqhSG8BBvKxNULwOF/9nh4HMWrep1S+k9XwOSNH04FUDCUCoVr4TNGQugDrsNDg
	 wQeQzODbwzF9gWgxT83ZEOSsRi7RoVGORDjIELS0udgDBgis7wz664wOrQflWtIXzx
	 QmK7Q3AwvsEbyG83aDWobW2Dw+qjj79JpcE3xmfk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Geoffrey D. Bennett" <g@b4.vu>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 273/307] ALSA: scarlett2: Return ENOSPC for out-of-bounds flash writes
Date: Sun,  7 Jun 2026 12:01:10 +0200
Message-ID: <20260607095737.742924558@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.647295505@linuxfoundation.org>
References: <20260607095727.647295505@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261832-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:g@b4.vu,m:tiwai@suse.de,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,b4.vu:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,vger.kernel.org:from_smtp,msgid.link:url,suse.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A895865037B

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Geoffrey D. Bennett" <g@b4.vu>

[ Upstream commit 74641bfcbf4e698b770b1b62a74e73934843e90e ]

When writing to flash, return ENOSPC instead of EINVAL if the requested
write would exceed the size of the flash segment.

Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/3a4af07b0329bed5ffb6994594e4f7bd202aad0f.1727971672.git.g@b4.vu
Stable-dep-of: a69b677e47a8 ("ALSA: scarlett2: Allow flash writes ending at segment boundary")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/mixer_scarlett2.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/usb/mixer_scarlett2.c
+++ b/sound/usb/mixer_scarlett2.c
@@ -9550,7 +9550,7 @@ static long scarlett2_hwdep_write(struct
 		     SCARLETT2_FLASH_BLOCK_SIZE;
 
 	if (count < 0 || *offset < 0 || *offset + count >= flash_size)
-		return -EINVAL;
+		return -ENOSPC;
 
 	if (!count)
 		return 0;



