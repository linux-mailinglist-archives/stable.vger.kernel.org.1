Return-Path: <stable+bounces-271273-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XqI7DK6cRmqNaAsAu9opvQ
	(envelope-from <stable+bounces-271273-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:15:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E55A6FB29E
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:15:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="YL9p/yTZ";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271273-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-271273-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5F4C132D755B
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDB2353A94;
	Thu,  2 Jul 2026 16:51:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A01C3446A7;
	Thu,  2 Jul 2026 16:51:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783011116; cv=none; b=KnnUnlXHwPGXKI8exD8FBSio9uFauoLhnOWuW4sw5OEwLLNfNxuud3joukjRy59HsAl+72SUvnS0VBzO/Ib2n36RTPnRx+4Hmo+34HsZQtozjsFyhADMm0eR063HBHpHBmfURJSMnIQAkoXLvkNbXGzzkVOh3EIORM3HpGso9eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783011116; c=relaxed/simple;
	bh=NjBZ6Z2r+clJctz8erHKTF4Ka5Wk6HtYYvG3eCMQF+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CNtVuRcU+xittRr4dVzlAkNpSHCLMvIok9h70jUP7QPWG9DMNNpN5I1laBafgYaBVhImFhwO6amanPb51tUxW4Ov/ZFjsrEksq6XJ7eIwwq83b7O9J5KrqsB840RE0USxN2cMpyI0coZ9sJwXoYxRoqJ5/kbrH3DcHG35VW253w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YL9p/yTZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB941F000E9;
	Thu,  2 Jul 2026 16:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783011115;
	bh=ULFol8AyfFszNRZONJ584phv8LHlBeWB96ieeAzjEIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YL9p/yTZCCtcgTevmsRQB1br++x+pzjRBoDKAcp9aX2j6XZ8IcRXLd2es21fGkqvt
	 B1jzpgojQra7wbUMILFFIKefPsNhdR6r+7SFkyHGjbKVItmHuWkO4LhGxMhgxGvJH7
	 V4/yXTfRf7InDNd9XRo7shCoshJvOrFejy8KRjpk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Steffen Persvold <spersvold@gmail.com>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 6.6 162/175] fbdev: modedb: Fix misaligned fields in the 1920x1080-60 mode
Date: Thu,  2 Jul 2026 18:21:03 +0200
Message-ID: <20260702155119.203881913@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155115.766838875@linuxfoundation.org>
References: <20260702155115.766838875@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271273-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,gmx.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:spersvold@gmail.com,m:deller@gmx.de,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,gmx.de:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1E55A6FB29E

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steffen Persvold <spersvold@gmail.com>

commit d894c48a57d78206e4df9c90d4acfaf39394806a upstream.

The 1920x1080@60 modedb entry has one too many initializers before
its sync field: a stray "0" occupies the sync slot, which shifts the
remaining values by one field. The entry therefore decodes as
sync = 0, vmode = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT (0x3,
i.e. FB_VMODE_INTERLACED | FB_VMODE_DOUBLE), and flag =
FB_VMODE_NONINTERLACED, instead of the intended sync = positive H/V,
vmode = non-interlaced.

fb_find_mode() then returns a 1920x1080 mode flagged as interlaced +
doublescan with active-low syncs. Drivers that honour var->vmode and
var->sync when programming display timing enable doublescan and the
wrong sync polarity, corrupting the output.

Drop the stray initializer so sync and vmode hold their intended
values (positive H/V sync, non-interlaced), matching the adjacent
1920x1200 entry.

Fixes: c8902258b2b8 ("fbdev: modedb: Add 1920x1080 at 60 Hz video mode")
Cc: stable@vger.kernel.org
Signed-off-by: Steffen Persvold <spersvold@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/core/modedb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/video/fbdev/core/modedb.c
+++ b/drivers/video/fbdev/core/modedb.c
@@ -258,7 +258,7 @@ static const struct fb_videomode modedb[
 		FB_VMODE_DOUBLE },
 
 	/* 1920x1080 @ 60 Hz, 67.3 kHz hsync */
-	{ NULL, 60, 1920, 1080, 6734, 148, 88, 36, 4, 44, 5, 0,
+	{ NULL, 60, 1920, 1080, 6734, 148, 88, 36, 4, 44, 5,
 		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
 		FB_VMODE_NONINTERLACED },
 



