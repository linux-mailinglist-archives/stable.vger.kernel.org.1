Return-Path: <stable+bounces-219644-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIpEAR8Nn2neYgQAu9opvQ
	(envelope-from <stable+bounces-219644-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 15:54:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C93119906A
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 15:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9AE530E82FC
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 14:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1893D333D;
	Wed, 25 Feb 2026 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="BurMvEHW"
X-Original-To: stable@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A005A2D2385
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 14:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772031233; cv=none; b=dNikK3qOiQmMTkYj8x7VeIQHyJa6EA33qB+T6MauQGJ7ZW258uaBoW25YCyxzhlH11Ti9AJ95mG+NkMIp379QE7XXd7L8ECbYZWOt7r9ZupRtUZqjtlz2AG5kzKqO0ai8wwYFbDC2t0YCmszsyQ6hLgVf9bWZvOlVB/PT/3eSAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772031233; c=relaxed/simple;
	bh=f9gtquX/pXI0BghwN1uwO3/gwwWphET7BCJKcJhI4fY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lSzK7Etmu8lV85Avnxu1i41HTOr46HYTuaPENCO+NXMQKvU5vgs3lYn7hU4l8e66JbIEwPvn7do/e+1Iw8LayuyPruuG6hFDO8L+LIygXwvWKe5ZHUZZFXE/CTNo0GlOy+prnHZCbsU+AlDmHMJJ4mn6X2blIKVN+0Gh8FDwlCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=BurMvEHW; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 8BC0B240028
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 15:53:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1772031223; bh=WRtsRDO/gsyHidTTtsMDAqc6db+YRswhAYjQbcM80Jw=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:From;
	b=BurMvEHWR3lOnETlJ0aJJTaDag8mLkHxg10t/ipL0nKHbylCfXH68TnkS4hZkWagY
	 dbTo8aCU0Yfn7Q5+mmYHjPau/LZnoQGTJsztu8hUVsdkd/MTq2ewezFQwiOXUmP6kJ
	 6oBd8uJMNlEOs9FI+WI+iVDU0/I7MA0WNeJtL2gkLjojWKIOBQull3xXwDxVzI+lmZ
	 Q+xMPLAg2TLJq/VqG8oN9czTq+J/YWLVE40tKETusmTLjitNy/TjFB0pkFWVAkeUYQ
	 cJe/9t51s/U+Z8TOQyr/FoN5eIqwQpkpB/Kw1lOrHTqlTg4voALDWvFT4HGeQUUVPb
	 gwTrHRRAKpx/Q==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4fLczV2CVTz6twx;
	Wed, 25 Feb 2026 15:53:42 +0100 (CET)
From: Panagiotis Foliadis <pfoliadis@posteo.net>
Date: Wed, 25 Feb 2026 14:53:43 +0000
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
Message-Id: <20260225-nvidia-audio-fix-v1-1-b1383c37ec49@posteo.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MywqAIBAAf0X23IJtD6FfiQ6ma+3FQimC8N+Tj
 jMw80LmJJxhUi8kviXLESu0jQK327gxiq8MpGnURB3GW7xYtJeXA4M8aMZgBr/2bBxBzc7EVf/
 LeSnlA06RLd5iAAAA
X-Change-ID: 20260223-nvidia-audio-fix-76f75db4e7c2
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Charalampos Mitrodimas <charmitro@posteo.net>, 
 Panagiotis Foliadis <pfoliadis@posteo.net>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772031222; l=1440;
 i=pfoliadis@posteo.net; s=20260221; h=from:subject:message-id;
 bh=f9gtquX/pXI0BghwN1uwO3/gwwWphET7BCJKcJhI4fY=;
 b=Alti5cjpXFhS5G//sXE8RJro4PVJ1FZ1rA05z2qwnbXA4M+F1FTrs6v2oJ3VWdJv0KKZ5bwSA
 0I4oqcMK60aDKv22ijxX29c54fYCddrlRlBSsqUaImi7KfWYLI3kEnv
X-Developer-Key: i=pfoliadis@posteo.net; a=ed25519;
 pk=qQknvoFAg4AxPHIZdU7+befQmFNi/JfQaur0XrbY00I=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[posteo.net,none];
	R_DKIM_ALLOW(-0.20)[posteo.net:s=2017];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219644-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[posteo.net:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pfoliadis@posteo.net,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 5C93119906A
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


