Return-Path: <stable+bounces-251558-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOipN/cbDmpT6AUAu9opvQ
	(envelope-from <stable+bounces-251558-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:39:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC52599E30
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B068C3347042
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C502367DF;
	Wed, 20 May 2026 17:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I0Q8ICpI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38632046BA;
	Wed, 20 May 2026 17:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298292; cv=none; b=ox2caLsWNZBYJVuUhFFHb0s/DxFAJ1g7y6o4q5c5km1FDlTHzdG0NTkiINzIXjn0MDgGbeK1GrX9Spb/qDK8jkFEQb+JeRiVTtKFPN5IuwNYtNLhK0QLILpABOlUpxMkz7x5FLPw+NrEV9tWCpL0WEeIqh7aEVBGjqI5YiVbMxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298292; c=relaxed/simple;
	bh=SGDsd97z2bLGE1E/zV0arJhHaYhJ71G4wcGK3wufcF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ac/mZDIN1O+17lzWjAkX+RN0CEdYNm9mgy0L0AvaeW4J2DPnZLJKkRARM5NfNmKaqooDUgtLPivFuVzSRRvSa6xF2k5MNXYUBS1MA73zDxmIsRkkS5xASlRnRywJ15YSJM1CnUKD78jgOFF7B0rLpLP+wo0/Z+8nx/tFjEIkHbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I0Q8ICpI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 253A41F000E9;
	Wed, 20 May 2026 17:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298291;
	bh=tg5M/ww5Cp0hqv6SiTQwiu5Jkb8YgfHvFqaZMm5hnHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I0Q8ICpIPL982okXHs5szgj2EJqR1owizpNhkH+z4D3jHGipiWqSRxJeVvz2ft199
	 8tgbKc966ONQQh3XqPPYwnbe3/Vyp+zawPt9o2J6nDvZdZB0giCs4ztc7+9FV2U2YY
	 ycUHzjmeLDsosbKHUrG5Y6BLHzoFoaiCuATBxIbA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Panagiotis Petrakopoulos <npetrakopoulos2003@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 314/957] ALSA: scarlett2: Add missing sentinel initializer field
Date: Wed, 20 May 2026 18:13:17 +0200
Message-ID: <20260520162141.342037116@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-251558-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,suse.de,kernel.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,suse.de:email]
X-Rspamd-Queue-Id: 4CC52599E30
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

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
index 48d77030a63d8..a75a4610663e9 100644
--- a/sound/usb/mixer_scarlett2.c
+++ b/sound/usb/mixer_scarlett2.c
@@ -2262,7 +2262,7 @@ static const struct scarlett2_device_entry scarlett2_devices[] = {
 	{ USB_ID(0x1235, 0x820c), &clarett_8pre_info, "Clarett+" },
 
 	/* End of list */
-	{ 0, NULL },
+	{ 0, NULL, NULL },
 };
 
 /* get the starting port index number for a given port type/direction */
-- 
2.53.0




