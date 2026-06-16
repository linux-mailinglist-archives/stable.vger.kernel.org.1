Return-Path: <stable+bounces-263802-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0zXeOj5mMWr/iQUAu9opvQ
	(envelope-from <stable+bounces-263802-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:05:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C9C690C01
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:05:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=ihsymsQt;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263802-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-263802-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 37A2F30275B7
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CD536C592;
	Tue, 16 Jun 2026 15:05:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A0336E46F;
	Tue, 16 Jun 2026 15:05:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781622329; cv=none; b=BGL9DCMJGUbp/yzA+3MI8ypPxw2qXC6SAjhuKbiZPExxB1Ox+/V6W6+NJfi+kmIFAZ/HwMu+YWDe4zcyAvbK1uzEU7MVM7i5iXhk9mS2KZmWmgvETGF+ZWpfpJ4ZRoYcamoJIdsupYvfZDxPjklZ/aMjpcrAed1H7PowChntbBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781622329; c=relaxed/simple;
	bh=/sgoGBQ83jJTEVWOqmB95R8Vr1DxsdRrB1N7DlMZVmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qx0wXZpyZXDBxL5gTBR9dsukiit3hXP7xafPJOt/B0cQOHDolHNVUIrm7qWjxCgQLCOLqS2SVt4w+/ea6t7fqhG3MkaGxGdIc2G6raj0H/dJ4lOUUOtdCLQTzxcA+2eYUEtlOq5D/NOyYklh/LDp2cnepBH8/JP1sondg6YFaMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ihsymsQt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46AD61F00A3A;
	Tue, 16 Jun 2026 15:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781622328;
	bh=NRJ75pINHJxLr6Sl1FQzO4c3srqj/rK9TpWsu0Pxups=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ihsymsQteZOBqYFOd/6MjpdnpmKfq0nBZPhmPH5zs0VLsqVe8dKjdblWxWA6bA1B4
	 Rs2ORKqfZCrWeXY5VQQFHtDxPhhVKJB1QjWZJ+VDl4D7KKMhcXqm6K0qTGnMItogFa
	 3pMZFbvm/tMoQ2ekBdOpjnLCHgCUQk40eED3Igco=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chengfeng Ye <cyeaa@connect.ust.hk>,
	Takashi Iwai <tiwai@suse.de>,
	Vasiliy Kovalev <kovalev@altlinux.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 002/342] ALSA: usb-audio: fix null pointer dereference on pointer cs_desc
Date: Tue, 16 Jun 2026 20:24:58 +0530
Message-ID: <20260616145048.461969387@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145048.348037099@linuxfoundation.org>
References: <20260616145048.348037099@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263802-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:cyeaa@connect.ust.hk,m:tiwai@suse.de,m:kovalev@altlinux.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,suse.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 80C9C690C01

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chengfeng Ye <cyeaa@connect.ust.hk>

commit b97053df0f04747c3c1e021ecbe99db675342954 upstream.

The pointer cs_desc return from snd_usb_find_clock_source could
be null, so there is a potential null pointer dereference issue.
Fix this by adding a null check before dereference.

Signed-off-by: Chengfeng Ye <cyeaa@connect.ust.hk>
Link: https://lore.kernel.org/r/20211024111736.11342-1-cyeaa@connect.ust.hk
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Fixes: 1dc669fed61a ("ALSA: usb-audio: UAC2: support read-only freq control")
[ kovalev: bp to fix CVE-2021-47211; added Fixes tag; the null
  check was added into both UAC2 and UAC3 branches since the
  older kernel still has the clock source lookup split between
  snd_usb_find_clock_source() and snd_usb_find_clock_source_v3()
  (see upstream commit 9ec730052fa2); return -ENXIO instead of 0
  to match upstream behavior, where the caller reaches the clock
  validation path and returns -ENXIO ]
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/clock.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index 197a6b7d8ad6f9..8759e20c419ed5 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -646,11 +646,17 @@ static int set_sample_rate_v2v3(struct snd_usb_audio *chip, int iface,
 		struct uac3_clock_source_descriptor *cs_desc;
 
 		cs_desc = snd_usb_find_clock_source_v3(chip->ctrl_intf, clock);
+
+		if (!cs_desc)
+			return -ENXIO;
 		bmControls = le32_to_cpu(cs_desc->bmControls);
 	} else {
 		struct uac_clock_source_descriptor *cs_desc;
 
 		cs_desc = snd_usb_find_clock_source(chip->ctrl_intf, clock);
+
+		if (!cs_desc)
+			return -ENXIO;
 		bmControls = cs_desc->bmControls;
 	}
 
-- 
2.53.0




