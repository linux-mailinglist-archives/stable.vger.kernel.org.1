Return-Path: <stable+bounces-211905-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0kLMFdJeeWkXwwEAu9opvQ
	(envelope-from <stable+bounces-211905-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 01:56:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FD19BC86
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 01:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F81F3013A54
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 00:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AC31B3B19;
	Wed, 28 Jan 2026 00:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTT93C3h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B521A2545
	for <stable@vger.kernel.org>; Wed, 28 Jan 2026 00:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769561805; cv=none; b=mJGuhrv+Y4F9Ah4F+ijuiMTo9nDbEI9n8dX/Y3zMR/Se7nnrURY81bKnyr4CgVb/GPc8HF8oCEIjezhcLIEX4Yu5IoPv77to0s04gsdPL8bVEBwV1mSRgVI79iTJWreDmSwdAzp10g9LS4FGNU+VRMNxsQ1Bww0+Uxp01+32wpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769561805; c=relaxed/simple;
	bh=uOZ9m7ZgmNY2wQvHTB+OroELYROsiskuxkMDB6vi90U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IQbBOcXO9OnnJG3p+TIzNJMK9i0pbo+TkHCJu9IZAQwxj0Y9Wtn88GRWQdUbh3vz3X+fKqr464ksEbgEKrBmbJdyCKtk9BxoKvXoTDrr+YKrqwhYSxjDShchhw06rCxh4YpOI4dtjs7JhraECN/n3OSL7eLsjsSFBY1fVm0I4kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTT93C3h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59ABAC116C6;
	Wed, 28 Jan 2026 00:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769561804;
	bh=uOZ9m7ZgmNY2wQvHTB+OroELYROsiskuxkMDB6vi90U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YTT93C3h5v9A6Zi23TylnFB+4pLCF5kgOpVOt7DeeVb1/wmExax6Lo+Yap6LVrm+r
	 0z6/r9u9eKrVRvD4zjGITbVUAsJMAlregGXETbwLJ2xlB3rzU2qfkVwtZ6ZbZ8hbLu
	 3FMVu/uQsVn0DVHpAuUIPD44Rvpie4+w8iQ5Pqp9cNkOCFQRguR3jxRn/gjttwo0Va
	 uAjfS3aYlmsRkK9K+QBG4U/BORuLwtG7Z/lX9L9HWeWZe17HNlHeclWbBshSLMsUjB
	 5FQ2BmLHTzVDSzphmCgfdX1T+t6WI7zQwckFSOKRtkEcbAbsYkmXJlKtkT0JkXvGfD
	 foaXLZXWFKVGQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ALSA: scarlett2: Fix buffer overflow in config retrieval
Date: Tue, 27 Jan 2026 19:56:42 -0500
Message-ID: <20260128005642.2300891-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026012703-refresh-segment-c671@gregkh>
References: <2026012703-refresh-segment-c671@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-211905-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 98FD19BC86
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
index fa2bfa102ab56..ddb8f8d625841 100644
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


