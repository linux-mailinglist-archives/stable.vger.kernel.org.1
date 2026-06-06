Return-Path: <stable+bounces-260841-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XJ5KJ6mDI2p+uwEAu9opvQ
	(envelope-from <stable+bounces-260841-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 06 Jun 2026 04:19:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F7064C373
	for <lists+stable@lfdr.de>; Sat, 06 Jun 2026 04:19:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MwWW0TgN;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260841-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260841-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF5003011123
	for <lists+stable@lfdr.de>; Sat,  6 Jun 2026 02:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A391218845;
	Sat,  6 Jun 2026 02:19:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D12C1A2392
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 02:19:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780712345; cv=none; b=kDEq/E2CkxjYQ2602H9FRXGv3bnxPDv0baxvi7Vc2/3VUUMDfQ/88BwEJ4J7/5TWNrW/63GZdvPXIbkh788TMkEu1/MvApgpoUygJGVrc6zgabTTt1ECr3AiQHvTiTEA/wRCrPfqR8ZdMHEeKbScILITF44+wvYwyoGXX5c74N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780712345; c=relaxed/simple;
	bh=p55uUSuFfrg1nrYmRxkwWylhXZ/W4NmuW8IjkYenLuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=llofjoWEQEURtZ9mLkRA4+I3RZKaE42dluDtBubN6hvdBrXGUwQSTB0uLI7AaguRN6ZUzug8qAQWBUfGgKBfy2PUZEQfnYwpPK4HLBW53flfD3YtqNpiKh2JXYT6bHQDCY2YZh4O5t7UB6qaXGdNztEg6EYeevNXBXAQcJUU2Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwWW0TgN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478261F00893;
	Sat,  6 Jun 2026 02:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780712343;
	bh=P2rf2eBw3gJiiiKpC8xgf/ce8oL8sS4+HCwGsd1S6/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MwWW0TgNi409YQWAHZP/FXvzX+Ldgu2+PjeCv9LTI1uejKEmVxav0HITSHqY84KUF
	 F0P+gEk6ciLLaHwR5TF5EDu0CZxM/oXpX9G/J/2WULhNc1lJIBp9i+Mv1tIa1SOMTx
	 d+oQY7yiznX/jPBGnJunBCZb/b4Ym8Q17p2mFo6weWLmTCxfHwSFR2xo24Ll0LjRUl
	 70p6pw5ZvPzvKVS/4dII03lBLv+M14FgsQBq3bzJxQ3xyDKZItO/z8sUzahDfKFrvl
	 AkwE7oxe0Fuj2yP93PLddiLUVwRzedu0DfKiL3yHxEpHQccWNPtvowRfYQkN5rlKA7
	 3CqR7cgvvGUoQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Kelley <mikelley@microsoft.com>,
	Deepak Rawat <drawat.floss@gmail.com>,
	"Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
	Wei Liu <wei.liu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] drm/hyperv: Remove support for Hyper-V 2008 and 2008R2/Win7
Date: Fri,  5 Jun 2026 22:19:00 -0400
Message-ID: <20260606021901.2488724-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060454-destitute-bulb-134a@gregkh>
References: <2026060454-destitute-bulb-134a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260841-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:mikelley@microsoft.com,m:drawat.floss@gmail.com,m:parri.andrea@gmail.com,m:wei.liu@kernel.org,m:sashal@kernel.org,m:drawatfloss@gmail.com,m:parriandrea@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[microsoft.com,gmail.com,kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F1F7064C373

From: Michael Kelley <mikelley@microsoft.com>

[ Upstream commit ac6811a9b36f3ceb549d8b84bd8aeedf6026df02 ]

The DRM Hyper-V driver has special case code for running on the first
released versions of Hyper-V: 2008 and 2008 R2/Windows 7.  These versions
are now out of support (except for extended security updates) and lack
support for performance features that are needed for effective production
usage of Linux guests.

The negotiation of the VMbus protocol versions required by these old
Hyper-V versions has been removed from the VMbus driver.  So now remove
the handling of these VMbus protocol versions from the DRM Hyper-V
driver.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Deepak Rawat <drawat.floss@gmail.com>
Reviewed-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
Link: https://lore.kernel.org/r/1651509391-2058-5-git-send-email-mikelley@microsoft.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Stable-dep-of: 13d33b9ef670 ("drm/hyperv: validate resolution_count and fix WIN8 fallback")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/hyperv/hyperv_drm_proto.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
index c0155c6271bf89..76a182a9a76547 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
@@ -18,16 +18,16 @@
 #define SYNTHVID_VERSION(major, minor) ((minor) << 16 | (major))
 #define SYNTHVID_VER_GET_MAJOR(ver) (ver & 0x0000ffff)
 #define SYNTHVID_VER_GET_MINOR(ver) ((ver & 0xffff0000) >> 16)
+
+/* Support for VERSION_WIN7 is removed. #define is retained for reference. */
 #define SYNTHVID_VERSION_WIN7 SYNTHVID_VERSION(3, 0)
 #define SYNTHVID_VERSION_WIN8 SYNTHVID_VERSION(3, 2)
 #define SYNTHVID_VERSION_WIN10 SYNTHVID_VERSION(3, 5)
 
-#define SYNTHVID_DEPTH_WIN7 16
 #define SYNTHVID_DEPTH_WIN8 32
-#define SYNTHVID_FB_SIZE_WIN7 (4 * 1024 * 1024)
+#define SYNTHVID_WIDTH_WIN8 1600
+#define SYNTHVID_HEIGHT_WIN8 1200
 #define SYNTHVID_FB_SIZE_WIN8 (8 * 1024 * 1024)
-#define SYNTHVID_WIDTH_MAX_WIN7 1600
-#define SYNTHVID_HEIGHT_MAX_WIN7 1200
 
 enum pipe_msg_type {
 	PIPE_MSG_INVALID,
@@ -496,12 +496,6 @@ int hyperv_connect_vsp(struct hv_device *hdev)
 	case VERSION_WIN8:
 	case VERSION_WIN8_1:
 		ret = hyperv_negotiate_version(hdev, SYNTHVID_VERSION_WIN8);
-		if (!ret)
-			break;
-		fallthrough;
-	case VERSION_WS2008:
-	case VERSION_WIN7:
-		ret = hyperv_negotiate_version(hdev, SYNTHVID_VERSION_WIN7);
 		break;
 	default:
 		ret = hyperv_negotiate_version(hdev, SYNTHVID_VERSION_WIN10);
@@ -513,18 +507,15 @@ int hyperv_connect_vsp(struct hv_device *hdev)
 		goto error;
 	}
 
-	if (hv->synthvid_version == SYNTHVID_VERSION_WIN7)
-		hv->screen_depth = SYNTHVID_DEPTH_WIN7;
-	else
-		hv->screen_depth = SYNTHVID_DEPTH_WIN8;
+	hv->screen_depth = SYNTHVID_DEPTH_WIN8;
 
 	if (hyperv_version_ge(hv->synthvid_version, SYNTHVID_VERSION_WIN10)) {
 		ret = hyperv_get_supported_resolution(hdev);
 		if (ret)
 			drm_err(dev, "Failed to get supported resolution from host, use default\n");
 	} else {
-		hv->screen_width_max = SYNTHVID_WIDTH_MAX_WIN7;
-		hv->screen_height_max = SYNTHVID_HEIGHT_MAX_WIN7;
+		hv->screen_width_max = SYNTHVID_WIDTH_WIN8;
+		hv->screen_height_max = SYNTHVID_HEIGHT_WIN8;
 	}
 
 	hv->mmio_megabytes = hdev->channel->offermsg.offer.mmio_megabytes;
-- 
2.53.0


