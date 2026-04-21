Return-Path: <stable+bounces-240153-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FZ+Jpt652mZ9QEAu9opvQ
	(envelope-from <stable+bounces-240153-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 15:24:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B3E43B4B4
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 15:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EA3B303AF11
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 13:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26ED23CF039;
	Tue, 21 Apr 2026 13:20:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDA535A38A
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 13:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776777653; cv=none; b=aFnV0zpxMLKHdFEkH45RhWJcH5/UD8OuZRGi3adZY+zqHAMVkUFid5Rw4uObZwd3LR9u69v7oVN3BSsQTbCYaDGycEKWj4mLI7APU5Gu/Oqpe618NTNLSNideHO1ys87VClIZsYKm7P+EkCbhfl4VWuZ4XBoelga4SkcydUHUos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776777653; c=relaxed/simple;
	bh=wPYMwnikED87qo4n8PdD8k2EhQRriCpbTvJp6XvxhFk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YIdDjcXTL328b5w/zwSXNK3ewnX2izrZ0k+uQd8f50ORU016nzaDrdnKBpGHFh4Rv6Y6su8VdTz8H5Aet1tgtg8mumxuxuu3/5QF+eYYt7DCAUS1RZpMGLjkvcFPAYv1x4y3uAb6tY5wj+fHNrpS7xXF8BUhB9hkEiFmjZqZUBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [193.43.11.2])
	(Authenticated sender: kovalevvv)
	by air.basealt.ru (Postfix) with ESMTPSA id 8B7BE2338E;
	Tue, 21 Apr 2026 16:20:48 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	lvc-project@linuxtesting.org,
	kovalev@altlinux.org
Subject: [PATCH 5.10.y] ALSA: usb-audio: fix null pointer dereference on pointer cs_desc
Date: Tue, 21 Apr 2026 16:20:47 +0300
Message-Id: <20260421132047.38233-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[altlinux.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-240153-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[kovalev@altlinux.org,stable@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[altlinux.org:mid,altlinux.org:email,suse.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ust.hk:email]
X-Rspamd-Queue-Id: 01B3E43B4B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
  (see upstream commit 9ec730052fa2) ]
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 sound/usb/clock.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index 197a6b7d8ad6..3d5d4f3aafce 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -646,11 +646,17 @@ static int set_sample_rate_v2v3(struct snd_usb_audio *chip, int iface,
 		struct uac3_clock_source_descriptor *cs_desc;
 
 		cs_desc = snd_usb_find_clock_source_v3(chip->ctrl_intf, clock);
+
+		if (!cs_desc)
+			return 0;
 		bmControls = le32_to_cpu(cs_desc->bmControls);
 	} else {
 		struct uac_clock_source_descriptor *cs_desc;
 
 		cs_desc = snd_usb_find_clock_source(chip->ctrl_intf, clock);
+
+		if (!cs_desc)
+			return 0;
 		bmControls = cs_desc->bmControls;
 	}
 
-- 
2.50.1


