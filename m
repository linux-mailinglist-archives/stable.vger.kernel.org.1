Return-Path: <stable+bounces-211893-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKfyJ1MpeWkIvwEAu9opvQ
	(envelope-from <stable+bounces-211893-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 22:08:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 937C29A9A9
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 22:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6AFC63006212
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 21:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F68129B79B;
	Tue, 27 Jan 2026 21:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kAHubap6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035A5298CC0
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 21:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769548107; cv=none; b=Tg8swWfXGcrzFjSC1acqBgZ6ie9pDhYpZqQLgf38SrIUF+5/Ud6T4xlUnru1oX2qo8TLXksfIND0Q8GHauWX88+37cJKMe2EBERhUAYY2/qMRHG230vKE7G7Hr1qCtT63GmMCvSYLV4NHzSKyQJwMPmEbOxlTKSkSg6CEDq+TMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769548107; c=relaxed/simple;
	bh=flEYR9I3tOefFnMdxN07pu+TilH8Kr8DXvvyicubKao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u6CJ1jwuUTsHq9mYg8CvJGLqRIESlaixq4ndl9cMj3p8RFu7MXhHFlUwXSRwsHEb67XGi30pCq9e9zVBTXLVs7BMzsVxNgZ8QP9cbGjOGfGQkn/iTZbF4lJhFY2b/5Z6p8hY7q/510vHlazNa8Jv69HJjlecnK0N0MQGXj3NP/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kAHubap6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6547FC116C6;
	Tue, 27 Jan 2026 21:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769548106;
	bh=flEYR9I3tOefFnMdxN07pu+TilH8Kr8DXvvyicubKao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kAHubap6QBUgl3O6vcJGTk/zCVkg41QHhyXprJgKVVpRBMV/9sw9hz6ZfvmhWED+R
	 wDl+43UikW7rhxGW3XsX6H5+WBbpfh8dJymwtkIlS8gAFFmLA9jCRqROhbQjLAeuBX
	 B7Tt1fcpMeuMZE4aI0hy7feAqDNYT9u5ULcSveoevCuwlWDmRccrP3YWQYqr8OKb8g
	 Ab+Ma8K+aFkJxprzz9DvxTOFR6BjSk/Ne539ZYYOjAOfjspESAr/CjWkMrByba4SNH
	 gAoMlmPsUM+UR+tldbBejLyRQt55pec3c0rKeJfxMrie0MGyeODXnHd63GbU86vlSO
	 MyRIbPT2HHYpQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ALSA: scarlett2: Fix buffer overflow in config retrieval
Date: Tue, 27 Jan 2026 16:08:23 -0500
Message-ID: <20260127210823.2165565-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026012702-happier-luckily-8c7d@gregkh>
References: <2026012702-happier-luckily-8c7d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211893-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 937C29A9A9
X-Rspamd-Action: no action

From: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>

[ Upstream commit 6f5c69f72e50d51be3a8c028ae7eda42c82902cb ]

The scarlett2_usb_get_config() function has a logic error in the
endianness conversion code that can cause buffer overflows when
count > 1.

The code checks `if (size == 2)` where `size` is the total buffer size in
bytes, then loops `count` times treating each element as u16 (2 bytes).
This causes the loop to access `count * 2` bytes when the buffer only
has `size` bytes allocated.

Fix by checking the element size (config_item->size) instead of the
total buffer size. This ensures the endianness conversion matches the
actual element type.

Fixes: ac34df733d2d ("ALSA: usb-audio: scarlett2: Update get_config to do endian conversion")
Cc: stable@vger.kernel.org
Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
Link: https://patch.msgid.link/20260117012706.1715574-1-samasth.norway.ananda@oracle.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[ add 32-bit handling block ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer_scarlett2.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/usb/mixer_scarlett2.c b/sound/usb/mixer_scarlett2.c
index 316f1abefd51d..6112c3fb8ba68 100644
--- a/sound/usb/mixer_scarlett2.c
+++ b/sound/usb/mixer_scarlett2.c
@@ -1408,11 +1408,16 @@ static int scarlett2_usb_get_config(
 		err = scarlett2_usb_get(mixer, config_item->offset, buf, size);
 		if (err < 0)
 			return err;
-		if (size == 2) {
+		if (config_item->size == 16) {
 			u16 *buf_16 = buf;
 
 			for (i = 0; i < count; i++, buf_16++)
 				*buf_16 = le16_to_cpu(*(__le16 *)buf_16);
+		} else if (config_item->size == 32) {
+			u32 *buf_32 = (u32 *)buf;
+
+			for (i = 0; i < count; i++, buf_32++)
+				*buf_32 = le32_to_cpu(*(__le32 *)buf_32);
 		}
 		return 0;
 	}
-- 
2.51.0


