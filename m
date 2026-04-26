Return-Path: <stable+bounces-241166-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJ14J1Pz7Wk7pQAAu9opvQ
	(envelope-from <stable+bounces-241166-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 13:13:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D074698AE
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 13:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B337C3015E10
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 11:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C42135AC01;
	Sun, 26 Apr 2026 11:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gom058It"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0C831E849
	for <stable@vger.kernel.org>; Sun, 26 Apr 2026 11:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777201994; cv=none; b=LP7bNxuDSgDdsMivgqBMv+Sx8KnTCpE1IFkJ2uIhuznWWEtTceouiwvjzYCAa7R2WJlwaG+/br85WYXhPovoGLwNqP25PfjODTJWzVnLabnIedmhxvCidgx5cSKV/xl6Juc8XhI+dQxvf25wI71LfALU65LQTRGj7adUBL5azqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777201994; c=relaxed/simple;
	bh=B/9eEE6B2PxEEwz8XP6be4i93RoXNRJ69P6xJrqTv8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dkfprj2hc7A7YHz1lwpZmyhGF8duI8PfhUOlyQp2jzpQT3nmggCJEiZKJfgrmKw8BdJIfUw6Oww44jaHLthNgXoZ3fm2egSUrqgc8zVJVR43SVp3chOFN8qmiiOrNZcQYlmDp3kSkFLo9ZbvY6MyqynbBcKEGKAu4X7jwREA4CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gom058It; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b7d3ecc10dso14524045ad.2
        for <stable@vger.kernel.org>; Sun, 26 Apr 2026 04:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777201992; x=1777806792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/9JOiMw/TUHAEKpVZ4imVP6XP0XS06uXgFI4h8oSnkI=;
        b=Gom058ItaKEUp44LK88/QOzEZ3tBt0+pP947dNm0XyjNSKD4T4PM38sMi2CNydiiG9
         jGUNISgx2/veeYZY1FL9g3vEwIt2nuIKj+nWvTTj0/4uXpCmpBrn8Kad2EkbcQAGPJPv
         1zQD9fEaBipUI2+KTxcq0lr6zqkzQLtZi5YnofGcztXEKchiU9vO42O9HCD041yftk6G
         e6PvnN4XW2bJ223YV84CMk/yHP0GCBCf88PJP370h4OdZngMrFvnfJCf+1+rcHV/7HeC
         FL3u7guZl4XHS1h2A9zQsyPMMucWTNNx+r2kAztBOVH/EH4+KkrouqKcaOF6L5eokINq
         VMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777201992; x=1777806792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9JOiMw/TUHAEKpVZ4imVP6XP0XS06uXgFI4h8oSnkI=;
        b=H5dvE4EVzKz5ZYZsYF+7FESjI3vT8T5QhyI52+916bMvhslSWQf8z0j77HCxPm5E4G
         VGsC+7b2zcrML3EdNKz9ibnZ5ODATUWxDRWxBrmsPUwVOY6/o+hdI+lsU5XdwTQ++Lrg
         oY5/5V3v0batMe4J328cpOyfL/hSouh1vYMXXaTC5l6vWl0QsCxgLVRZZYYeCWGwBC1c
         NMRjjnyPufmV6z5tjG7hxfcOvcKnrHA+erS5ZkAPbp/oPqxpfUlYYmJJ6+7FinoGv2CU
         DHIa+HP2kf0r7KFsXZD61ReBR7XL086vlLRCd0YM4cT6sOD0ZuqUK0SWBNW5/Xnd3AjF
         foQQ==
X-Forwarded-Encrypted: i=1; AFNElJ97IfgfF5VJrK3XDime5senMldOobMsD5GnCAemka1Y0b4QXBYeraITnleLArC9ukI9WKg+2Zo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0FpLI1OIMdj5yNmBO0NJF9Xw9cZnTWlWS3FLfP+eTY9Yo2FrR
	U5jadwD23wefWbq1CS2zUBz8gBwwxA6E/9YitqBg0HGMg/dasu2STHRi
X-Gm-Gg: AeBDieuMgygoCcoblVmgRkaNhJrOq9HN/g30oRqKzkLsXKsE7XIIvLL2Cvbm5GPtSlJ
	Viea9vfkSt5qYr1Ex7GqAagUt3k/YcZNENZ+H6pLo40v0h3ZVpHCI8WY3aclpeWNalqKgKaayZI
	yTQG7/Vsz0+oXydjb4qdRvZqQEggTYCWyMEcPnu9jJrXHI3ODWUYD9RiwJxsK3hdtbeLqcRBo/W
	ejGE+rp95AfuZGkJRh5qYo2nPz8xDH4+G1hP826Flhuh8u2yAUpQ8l6r217O+Y5ejhaoQxDKc6R
	XCHT3/MRjmnfX1vl59IyylEj0WkitK8ieAidTsL03Vzor882HV05sPe+QULVUs8/ooL6+GfZe+8
	F53RAC8+JrrhdGV1vMF/Lws2ku8ldWeN8he6U+vR4Ajn+hQgwFuS7uP0P4UCFa+/prSth3cPMdM
	Mi/IBeg9u535Eg8F8YhqPuyvpwN8u+QIMHh6ahmQWscaZuL90SfNyCfyYVFw==
X-Received: by 2002:a17:903:2654:b0:2b4:5d51:ce96 with SMTP id d9443c01a7336-2b5f9f4e6damr310434855ad.24.1777201992565;
        Sun, 26 Apr 2026 04:13:12 -0700 (PDT)
Received: from fedora ([61.74.238.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab32cfasm351390385ad.69.2026.04.26.04.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 04:13:12 -0700 (PDT)
From: SeungJu Cheon <suunj1331@gmail.com>
To: clemens@ladisch.de,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	me@brighamcampbell.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	SeungJu Cheon <suunj1331@gmail.com>
Subject: [PATCH] sound: ua101: fix division by zero at probe
Date: Sun, 26 Apr 2026 20:12:39 +0900
Message-ID: <20260426111239.103296-1-suunj1331@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E3D074698AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,brighamcampbell.com,linuxfoundation.org,lists.linux.dev,gmail.com];
	TAGGED_FROM(0.00)[bounces-241166-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[suunj1331@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Add a missing sanity check for bNrChannels in detect_usb_format()
to prevent a division by zero in playback_urb_complete() and
capture_urb_complete().

USB core does not validate class-specific descriptor fields such
as bNrChannels, so drivers must verify them before use. If a
device provides bNrChannels = 0, frame_bytes becomes zero and is
later used as a divisor in the URB completion handlers, leading
to a kernel crash.

Fixes: 63978ab3e3e9 ("sound: add Edirol UA-101 support")
Cc: stable@vger.kernel.org
Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
---
Testing:
- dummy_hcd + raw_gadget emulating a UA-101 with bNrChannels=0.

 sound/usb/misc/ua101.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/usb/misc/ua101.c b/sound/usb/misc/ua101.c
index 49b3dd8d827d..d129b42eb979 100644
--- a/sound/usb/misc/ua101.c
+++ b/sound/usb/misc/ua101.c
@@ -974,6 +974,13 @@ static int detect_usb_format(struct ua101 *ua)
 
 	ua->capture.channels = fmt_capture->bNrChannels;
 	ua->playback.channels = fmt_playback->bNrChannels;
+	if (!ua->capture.channels || !ua->playback.channels) {
+		dev_err(&ua->dev->dev,
+			"invalid channel count: capture %u, playback %u\n",
+			ua->capture.channels, ua->playback.channels);
+		return -EINVAL;
+	}
+
 	ua->capture.frame_bytes =
 		fmt_capture->bSubframeSize * ua->capture.channels;
 	ua->playback.frame_bytes =
-- 
2.52.0


