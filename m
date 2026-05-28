Return-Path: <stable+bounces-256175-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFtBKQasGGpolwgAu9opvQ
	(envelope-from <stable+bounces-256175-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:56:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BDB5F9E63
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 23E3C311E473
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC8B33F8C3;
	Thu, 28 May 2026 20:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MeX6/ncI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B671DE4E0;
	Thu, 28 May 2026 20:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000965; cv=none; b=sDShIMdjLafhAZ9DNwc5Kj/BGX/nuuBiX/yqzwo0v+Fph6B8ekG1foC9xrTQl5PCYFu4GMkcSAygo1ao8nzq6D5vD0P5AzzKcwo4zHEMn8i+nG7Oc8s/4B9oelrCNkgA6KvQ88ADP+O2fxrRbuNjBS2SkXwVIZy2mHXNfAFZZ90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000965; c=relaxed/simple;
	bh=IEcyFp+VqDTgZ48YKRoLr4f0IqlAvqAF8vaihudo4kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jkjq44x7vzfnTSLfGn+oXdGoRanXYxpp9Qd9bkh4K+hgNXd8fZgyh8mIHj/BCsOQDk5bYcmmaOvL6nbNYCUrXfW44rkWLTMai7RfK3VmUTLdzkY00/LAfQq6jzSnKb0r1bSzRX0NvgYmxW8ZE4+rTbS1wFI3GAeWt5yNylAiLJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MeX6/ncI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4621F000E9;
	Thu, 28 May 2026 20:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780000964;
	bh=0fcqXiki9qQMuBLmolbACJM36A3nK8JRrpC/xTmF/Dk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MeX6/ncIt+LJBxt8y6jJODnNjsFJKGzSN9kzFBE7wnj3m9j7+HV7++zP1Sf6vaJji
	 F2+ZGqDtYCJU+4+1JsqKYWdQcjgtIgT1NNS9J8a/bqMpn1Q5P+GM/4ANjL3Al7rJpF
	 o2w7pfXyggcXXWsvfDmFGLiuNZY741eosvyqQJvM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Robertus Diawan Chris <robertusdchris@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 232/272] ALSA: scarlett2: Add missing error check when initialise Autogain Status
Date: Thu, 28 May 2026 21:50:06 +0200
Message-ID: <20260528194635.665567173@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194629.379955525@linuxfoundation.org>
References: <20260528194629.379955525@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256175-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,suse.de,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: E3BDB5F9E63
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Robertus Diawan Chris <robertusdchris@gmail.com>

[ Upstream commit c0e4fffc0f474b7ed10adee4ab2bc1a66d36fc72 ]

When initialise new control with scarlett2_add_new_ctl() function for
Autogain Status, scarlett2_add_new_ctl() might throw an error. So, add
error check after initialise new control for Autogain Status.

This is reported by Coverity Scan with CID 1598781 as UNUSED_VALUE.

Fixes: 0a995e38dc44 ("ALSA: scarlett2: Add support for software-controllable input gain")
Signed-off-by: Robertus Diawan Chris <robertusdchris@gmail.com>
Link: https://patch.msgid.link/20260508033914.111596-1-robertusdchris@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer_scarlett2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/mixer_scarlett2.c b/sound/usb/mixer_scarlett2.c
index ef5945aa40e4a..d767a89e452d1 100644
--- a/sound/usb/mixer_scarlett2.c
+++ b/sound/usb/mixer_scarlett2.c
@@ -6956,6 +6956,8 @@ static int scarlett2_add_line_in_ctls(struct usb_mixer_interface *mixer)
 		err = scarlett2_add_new_ctl(
 			mixer, &scarlett2_autogain_status_ctl,
 			i, 1, s, &private->autogain_status_ctls[i]);
+		if (err < 0)
+			return err;
 	}
 
 	/* Add autogain target controls */
-- 
2.53.0




