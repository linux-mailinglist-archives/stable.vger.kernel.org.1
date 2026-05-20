Return-Path: <stable+bounces-253001-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6L0ED7YADmo95QUAu9opvQ
	(envelope-from <stable+bounces-253001-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:43:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C25375970F6
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7EFE2316EB66
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3C137DE8A;
	Wed, 20 May 2026 18:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dIziVw5V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F3D3F9F2A;
	Wed, 20 May 2026 18:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302144; cv=none; b=UyJoG3fdUkj/NZppHZexueJT0X4dZlOYbZywQ1CIAePtTj1KIwzl46/Ljg1DYuKJo6ZuylJBArjjQqr/fGhPG2fBA6Zn++4KkWdIClnAlNwR9Ay6GBB8AqTyxPtp+0C/fGg6xXuiYXKZpj0x0WQ+KsmuF9MPyh6a4I5wWiN3t64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302144; c=relaxed/simple;
	bh=C4COkLT9IcDlHS/K/L3z3G9rD1tOB7pDqUGdo+q8dIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pMDiA/fBN5yHa6Rj2duk3CErbHkdxh3K/kMhgLtn5z9kgBHPuU93LiCzJeKhHKlUgMLmT4erC3N3BIUsZqh6Oj5KGj89+KZsAW54mdTBf3+AcAqw2k6DoP0KJ0srWCiV47iKWbFrF4KyWf0x3OdI2X1bvxeqWNDMTtPVpWfwVjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dIziVw5V; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D74541F000E9;
	Wed, 20 May 2026 18:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779302143;
	bh=wAdF4ThUFNP2cmkKrhFX7s0EDS1WIkK8BBx1BlWv1Bc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dIziVw5V9ZIpGGAw+29wsK0vyy1MX/HVHY3R15msnbnDIAPreoA0E1sOV1okY6vIt
	 ow5uL/5z1xIdnkqouyuCvX3E++6vR7/Y5ws4bUbgra2XhaY82IpS8dMQrlTuVkfcX8
	 +ENGAWy0wOjCJczMwO4GilFUZ4iyqfv/RsAxuvxc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Panagiotis Petrakopoulos <npetrakopoulos2003@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 154/508] ALSA: scarlett2: Add missing sentinel initializer field
Date: Wed, 20 May 2026 18:19:37 +0200
Message-ID: <20260520162101.973903374@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162058.573354582@linuxfoundation.org>
References: <20260520162058.573354582@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-253001-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,suse.de,kernel.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,suse.de:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Queue-Id: C25375970F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Panagiotis Petrakopoulos <npetrakopoulos2003@gmail.com>

[ Upstream commit 2428cd6e8b6fa80c36db4652702ca0acd2ce3f08 ]

A "-Wmissing-field-initializers" warning was emitted when compiling the
module using the W=2 option. There is a sentinel initializer field
missing in the end of scarlett2_devices[]. Tested using a
Scarlett Solo 4th gen.

Fixes: d98cc489029d ("ALSA: scarlett2: Move USB IDs out from device_info struct")
Signed-off-by: Panagiotis Petrakopoulos <npetrakopoulos2003@gmail.com>
Link: https://patch.msgid.link/20260405222548.8903-1-npetrakopoulos2003@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer_scarlett2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/mixer_scarlett2.c b/sound/usb/mixer_scarlett2.c
index c4b29b3670cd4..8aa7414d0b2fa 100644
--- a/sound/usb/mixer_scarlett2.c
+++ b/sound/usb/mixer_scarlett2.c
@@ -1011,7 +1011,7 @@ static const struct scarlett2_device_entry scarlett2_devices[] = {
 	{ USB_ID(0x1235, 0x820c), &clarett_8pre_info, "Clarett+" },
 
 	/* End of list */
-	{ 0, NULL },
+	{ 0, NULL, NULL },
 };
 
 /* get the starting port index number for a given port type/direction */
-- 
2.53.0




