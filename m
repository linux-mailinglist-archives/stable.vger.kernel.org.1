Return-Path: <stable+bounces-258751-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGrKFSorG2r//ggAu9opvQ
	(envelope-from <stable+bounces-258751-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:23:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 18332611A41
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5D3BF3014379
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E1A279DC9;
	Sat, 30 May 2026 18:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rPljWMLk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4955217555;
	Sat, 30 May 2026 18:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780165416; cv=none; b=mumqmju551aID9y9XNNy3aG2S0PmoM+grHUh3OipYvsM3NojBwg01xtB3WLG/LlsLhg5KI/oFx3r9Nxs+U9x1ipm55aj/pijoHmG/9gh+Sw8aLtdV3TRp6xieCPXvucAEf0QtQ/Qx8hzsBSn/7Q+DBiKvLiGTFFKgdZCs6q/WzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780165416; c=relaxed/simple;
	bh=FiI+gSChpHdU7c5B6InDMyGN7axw/dmIw7Ib7DoY4PE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lHN4yANg9LTP0jPGQXzZMcWuz6vCE3oyigZvJENj0rY4gobMdmfb/osPtQxYrJeLVgDriZuPJTyyxoj9qjw4ksqpfCkK4FY6E7NRZckktuApsDMWTTUGBslUcFB+mxBG59dz/99N/qTL8eH7AErAioHb94qABfgxaiY2PhD52XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rPljWMLk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA711F00893;
	Sat, 30 May 2026 18:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780165415;
	bh=gAOOBFggUXr0Glxf0SP7jZGPeZf95oXToiPLB4GqOCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rPljWMLkATu5v2/qtB8Kgs0O1g0UeSLn+oAK1TIaD3w2AzkaCW8SiPZZMaLakFTC6
	 wkCmUrwWqjPiX02/h71RQN8L2QbGn7FDfv7C14bJFm+hjom8/gbUwCJADFUk0k3yF8
	 +Zcptluz63vsICQOVRYv6vqzn3d1athiXvH206Ko=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Angel4005 <ooara1337@gmail.com>,
	Ricardo Ribalda <ribalda@chromium.org>,
	Hans de Goede <hansg@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Ron Economos <re@w6rz.net>,
	"Pavel Machek (CIP)" <pavel@nabladev.com>,
	Brett A C Sheffield <bacs@librecast.net>,
	Mark Brown <broonie@kernel.org>,
	"Barry K. Nathan" <barryn@pobox.com>,
	Peter Schneider <pschneider1968@googlemail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Vijayendra Suman <vijayendra.suman@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 072/589] media: uvcvideo: Use heuristic to find stream entity
Date: Sat, 30 May 2026 17:59:13 +0200
Message-ID: <20260530160226.496219768@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160224.570625122@linuxfoundation.org>
References: <20260530160224.570625122@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-258751-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,chromium.org,kernel.org,w6rz.net,nabladev.com,librecast.net,pobox.com,googlemail.com,toradex.com,nvidia.com,broadcom.com,oracle.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable,cisco];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 18332611A41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ricardo Ribalda <ribalda@chromium.org>

[ Upstream commit 758dbc756aad429da11c569c0d067f7fd032bcf7 ]

Some devices, like the Grandstream GUV3100 webcam, have an invalid UVC
descriptor where multiple entities share the same ID, this is invalid
and makes it impossible to make a proper entity tree without heuristics.

We have recently introduced a change in the way that we handle invalid
entities that has caused a regression on broken devices.

Implement a new heuristic to handle these devices properly.

Reported-by: Angel4005 <ooara1337@gmail.com>
Closes: https://lore.kernel.org/linux-media/CAOzBiVuS7ygUjjhCbyWg-KiNx+HFTYnqH5+GJhd6cYsNLT=DaA@mail.gmail.com/
Fixes: 0e2ee70291e6 ("media: uvcvideo: Mark invalid entities with id UVC_INVALID_ENTITY_ID")
Cc: stable@vger.kernel.org
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Reviewed-by: Hans de Goede <hansg@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Tested-by: Ron Economos <re@w6rz.net>
Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>
Tested-by: Brett A C Sheffield <bacs@librecast.net>
Tested-by: Mark Brown <broonie@kernel.org>
Tested-by: Barry K. Nathan <barryn@pobox.com>
Tested-by: Peter Schneider <pschneider1968@googlemail.com>
Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Tested-by: Shuah Khan <skhan@linuxfoundation.org>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
Tested-by: Miguel Ojeda <ojeda@kernel.org>
Tested-by: Vijayendra Suman <vijayendra.suman@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 34e3f04340a23..20a18caf77176 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -442,13 +442,26 @@ static struct uvc_entity *uvc_entity_by_reference(struct uvc_device *dev,
 
 static struct uvc_streaming *uvc_stream_by_id(struct uvc_device *dev, int id)
 {
-	struct uvc_streaming *stream;
+	struct uvc_streaming *stream, *last_stream;
+	unsigned int count = 0;
 
 	list_for_each_entry(stream, &dev->streams, list) {
+		count += 1;
+		last_stream = stream;
 		if (stream->header.bTerminalLink == id)
 			return stream;
 	}
 
+	/*
+	 * If the streaming entity is referenced by an invalid ID, notify the
+	 * user and use heuristics to guess the correct entity.
+	 */
+	if (count == 1 && id == UVC_INVALID_ENTITY_ID) {
+		dev_warn(&dev->intf->dev,
+			 "UVC non compliance: Invalid USB header. The streaming entity has an invalid ID, guessing the correct one.");
+		return last_stream;
+	}
+
 	return NULL;
 }
 
-- 
2.53.0




