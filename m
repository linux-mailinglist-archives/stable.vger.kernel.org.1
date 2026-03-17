Return-Path: <stable+bounces-226700-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yE8bE2ySuWl3KgIAu9opvQ
	(envelope-from <stable+bounces-226700-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:42:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 539232B0014
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7BC5F302D4B2
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A702DEA9D;
	Tue, 17 Mar 2026 17:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QZyhBBpo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645D52D5940;
	Tue, 17 Mar 2026 17:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767874; cv=none; b=XrUoGy+LWUNE20qoiTGKmDN2QYwWFOAyGEohKW/9l6ODSUOYW4PouEe79TmCw18r35mSbHs6lefUixoV5INtMl90wc1khvegZMQq0/0HYXZfiCTD+ZdVs9ROdbZAdE/LuY3W+QS0TzBFf2x1Wz7waVgZBWwzr34zE8Alo7+z+gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767874; c=relaxed/simple;
	bh=SsTFBgR/axyVDp7IldA14aRubu5qgVZwFKey+TdyAHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kLXus4UN1tLIJxpvDjqihLqZAkDSODji9Cb3jcIMt5nfRA20L2+bfhZVedWsJUJCmY+vIWR8jfyMj0Yiwe0pMUfdB8aiClf/Ft2gz5AfRRZF2Fyq2Lq9KExWh9B74VjTcALgyJRoDuZPzMxGgxhYueeVZXT5+He5iaq1Foj0lBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QZyhBBpo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E13C4CEF7;
	Tue, 17 Mar 2026 17:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773767874;
	bh=SsTFBgR/axyVDp7IldA14aRubu5qgVZwFKey+TdyAHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QZyhBBpo+avk13miNHgZHg4jqwhg4W9uWbnx+1JLOkYg1NcLUcPxAu6hbak4uOk5C
	 8yJ5fcQCJKgB5x5vvbVucvs6q0tLOw7sPD4fgCodyqF+57neiF1bukQJB6igiZ4lZX
	 PskQ6N8gVutoYCXMoCa0MG/JgO64X242DWjOthu4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Junzhong Pan <panjunzhong@linux.spacemit.com>,
	Xu Yang <xu.yang_2@nxp.com>
Subject: [PATCH 6.18 145/333] usb: gadget: uvc: fix interval_duration calculation
Date: Tue, 17 Mar 2026 17:32:54 +0100
Message-ID: <20260317163004.736430469@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-226700-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:email,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 539232B0014
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Junzhong Pan <panjunzhong@linux.spacemit.com>

commit 56135c0c60b07729401af9d329fa9c0eded845a6 upstream.

To correctly convert bInterval as interval_duration:
  interval_duration = 2^(bInterval-1) * frame_interval

Current code uses a wrong left shift operand, computing 2^bInterval
instead of 2^(bInterval-1).

Fixes: 010dc57cb516 ("usb: gadget: uvc: fix interval_duration calculation")
Cc: stable <stable@kernel.org>
Signed-off-by: Junzhong Pan <panjunzhong@linux.spacemit.com>
Reviewed-by: Xu Yang <xu.yang_2@nxp.com>
Link: https://patch.msgid.link/20260306-fix-uvc-interval-v1-1-9a2df6859859@linux.spacemit.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/function/uvc_video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index 7cea641b06b4..2f9700b3f1b6 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -513,7 +513,7 @@ uvc_video_prep_requests(struct uvc_video *video)
 		return;
 	}
 
-	interval_duration = 2 << (video->ep->desc->bInterval - 1);
+	interval_duration = 1 << (video->ep->desc->bInterval - 1);
 	if (cdev->gadget->speed < USB_SPEED_HIGH)
 		interval_duration *= 10000;
 	else
-- 
2.53.0




