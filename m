Return-Path: <stable+bounces-219645-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IErH5AOn2neYgQAu9opvQ
	(envelope-from <stable+bounces-219645-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 16:00:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF791991C0
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 16:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 98A2D3017061
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 14:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1EA3D4117;
	Wed, 25 Feb 2026 14:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="Ss8OHbY6"
X-Original-To: stable@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F79738E127
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 14:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772031297; cv=none; b=tbRfIlR3fbJWA/DdyoQoeskEzLaggbdFntufbUetPQHC1qwvq8az7G2Q3SlJEsDbc4zM/gK95p3E7t5q+k72nYRbDxKCY7jIJBkvBnizob/yniTZIaBAAMYkMxOajBDWoIRnTyAHIEWOem5DqkTBe/LbLA9LJ3s+ae1wTqzyh2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772031297; c=relaxed/simple;
	bh=f9gtquX/pXI0BghwN1uwO3/gwwWphET7BCJKcJhI4fY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=t7jw5oWPOJk0npiNX2VTYq9cSgav+u212kwD0ublqUi4Hs1IDxuDM0gsoG3pjVn5gBKM/1KKiy+D3RO4VrU1Kc4reaHhHbzSSYH+zvtnjrLnlFQEvGfZjWX7b3U6zSaD5n82eIngX5M2cOgfz0aIc8JuAInewKrb/rO/pkufVgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=Ss8OHbY6; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id C8F5A240103
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 15:54:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1772031294; bh=WRtsRDO/gsyHidTTtsMDAqc6db+YRswhAYjQbcM80Jw=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:From;
	b=Ss8OHbY6L5JHaw2GVyjGqy8BNxd7NKtNzIdUNF3ds/GJby6CU4ICbrNuwynNMzbU3
	 ZIX0XS8gync7Hn3roDMJ9SRCQR86fEfhaMvr1Ut7tACSUQmiyemEZ9USI46ZhpfUuK
	 EIcABNoUt7jVeCk/palIWhqwIan3Om87GmI+YtPirU1UfmZSRGzJl0XWKLhJIDzrAP
	 QW8BBhFZxBhu22OD79zX/rSLrp0hbWr/ZdcyTfpja1PzgqKrm+0hJahW2zx07FZ+lY
	 GNj21zQ4SnFx7Ux+r1JAunKG0SNNbN3w7UTsbItNYCMgfgoDE7PsgSKOviWr0PLKs6
	 Kh7n+zgvTZJjA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4fLd0s44ssz9rxG;
	Wed, 25 Feb 2026 15:54:53 +0100 (CET)
From: Panagiotis Foliadis <pfoliadis@posteo.net>
Date: Wed, 25 Feb 2026 14:54:54 +0000
Subject: [PATCH] ALSA: hda/intel: increase default bdl_pos_adj for Nvidia
 controllers
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-nvidia-audio-fix-v1-1-cfbbcfb04972@posteo.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MywqAIBAAf0X23IJtD6FfiQ6ma+3FQimC8N+Tj
 jMw80LmJJxhUi8kviXLESu0jQK327gxiq8MpGnURB3GW7xYtJeXA4M8aMZgBr/2bBxBzc7EVf/
 LeSnlA06RLd5iAAAA
X-Change-ID: 20260223-nvidia-audio-fix-76f75db4e7c2
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Charalampos Mitrodimas <charmitro@posteo.net>, 
 Panagiotis Foliadis <pfoliadis@posteo.net>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772031293; l=1440;
 i=pfoliadis@posteo.net; s=20260221; h=from:subject:message-id;
 bh=f9gtquX/pXI0BghwN1uwO3/gwwWphET7BCJKcJhI4fY=;
 b=cqejy/SVJlORJMKJuV5XZSRgoBJy69x4YgcKve7CbcUbsUMVElcxpbC/Gd/yFue/DYc3QZMM8
 rh6X4j2dmfEAUSsBts+/RF7wopVBH/2NYRyCgbMonbVOUB/HDI2cB7r
X-Developer-Key: i=pfoliadis@posteo.net; a=ed25519;
 pk=qQknvoFAg4AxPHIZdU7+befQmFNi/JfQaur0XrbY00I=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[posteo.net,none];
	R_DKIM_ALLOW(-0.20)[posteo.net:s=2017];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[posteo.net:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219645-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pfoliadis@posteo.net,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[posteo.net:mid,posteo.net:dkim,posteo.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EDF791991C0
X-Rspamd-Action: no action

The default bdl_pos_adj of 32 for Nvidia HDA controllers is
insufficient on GA102 (and likely other recent Nvidia GPUs) after S3
suspend/resume. The controller's DMA timing degrades after resume,
causing premature IRQ detection in azx_position_ok() which results in
silent HDMI/DP audio output despite userspace reporting a valid
playback state and correct ELD data.

Increase bdl_pos_adj to 64 for AZX_DRIVER_NVIDIA, matching the value
already used by Intel Apollo Lake for the same class of timing issue.

Cc: stable@vger.kernel.org
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221069
Suggested-by: Charalampos Mitrodimas <charmitro@posteo.net>
Signed-off-by: Panagiotis Foliadis <pfoliadis@posteo.net>
---
 sound/hda/controllers/intel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/hda/controllers/intel.c b/sound/hda/controllers/intel.c
index 6fddf400c4a3d67042e421b81ac3a13607a24bcd..3f434994c18db64019d3b4cfff8a7cc8764b5f26 100644
--- a/sound/hda/controllers/intel.c
+++ b/sound/hda/controllers/intel.c
@@ -1751,6 +1751,8 @@ static int default_bdl_pos_adj(struct azx *chip)
 		return 1;
 	case AZX_DRIVER_ZHAOXINHDMI:
 		return 128;
+	case AZX_DRIVER_NVIDIA:
+		return 64;
 	default:
 		return 32;
 	}

---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260223-nvidia-audio-fix-76f75db4e7c2

Best regards,
-- 
Panagiotis Foliadis <pfoliadis@posteo.net>


