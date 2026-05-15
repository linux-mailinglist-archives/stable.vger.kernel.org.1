Return-Path: <stable+bounces-248127-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AH5WA4RHB2p6wAIAu9opvQ
	(envelope-from <stable+bounces-248127-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:19:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B50CA553031
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7F4330F3E7A
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0D53BFE4C;
	Fri, 15 May 2026 16:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vn2LondH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE4635AC09;
	Fri, 15 May 2026 16:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860942; cv=none; b=CrIUYgRlghUy1IXjg4WXe/9XAvM/2SKqRdjSRZ+UjwcSiJzhQtHaNcT0n8HlHR1ThCn8AeLfrRbLBQBVgLgSsu9RVif54XmliifSKLccjkxEjXQ/u0WKtwBMObZbgq9k4l68zIJpR+2K7NpJ9ylpCF9Ad8tKb/Mh9ep2V+sIeHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860942; c=relaxed/simple;
	bh=LwTfH/mUUMh3HCPORWFYAQTwlWxruDrnOJijDKN0cVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XC0G/j9azFMepXVONQDwhJs2+TtuVSjifYnNFS5v8YiI5zTJ/xyBh/Flb0CZUfeHbsK8p/ZD+Anm58VL7QEolEvD1is4aKGmAR4+2wGG+Uxt+IwvdCGUGqK9Zy5uQf1CQL1bNqRv1CLfvqyVjH+eYih5ta9YDPQwhVzLQOsdDwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vn2LondH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5CBEC2BCB0;
	Fri, 15 May 2026 16:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778860942;
	bh=LwTfH/mUUMh3HCPORWFYAQTwlWxruDrnOJijDKN0cVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vn2LondHaUT3X9pfTprSpzsDT/IwsFREb/MfiXKLZbXd70E5y20lfPTdSwDZM+dSp
	 r6cxo/JoObRBkf9jDNRIETHLUIUEOWbJoK1cNwigs8oNNpwMWfdGkCv2IHbClwDfSf
	 JnLPqH/aFDjwmRotyFDTYW4HZ406Qr3BWgZhxxgo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.6 138/474] ALSA: caiaq: Dont abort when no input device is available
Date: Fri, 15 May 2026 17:44:07 +0200
Message-ID: <20260515154718.016519877@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
References: <20260515154715.053014143@linuxfoundation.org>
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
X-Rspamd-Queue-Id: B50CA553031
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-248127-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,suse.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit b32ae47a2b0a1fb4bd4942242847966d9b178222 upstream.

The previous fix to handle the error from setup_card() caused a
regression for the models that have no dedicated input device;
snd_usb_caiaq_input_init() just returns -EINVAL, and we treat it as a
fatal error although it should be ignored.

As a regression fix, change the error code to -ENODEV, and ignore this
error in the callee, to continue probing.

Fixes: 28abd224db4a ("ALSA: caiaq: Handle probe errors properly")
Cc: <stable@vger.kernel.org>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=221423
Link: https://patch.msgid.link/20260427145642.6637-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/caiaq/device.c |    2 +-
 sound/usb/caiaq/input.c  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/sound/usb/caiaq/device.c
+++ b/sound/usb/caiaq/device.c
@@ -366,7 +366,7 @@ static int setup_card(struct snd_usb_cai
 
 #ifdef CONFIG_SND_USB_CAIAQ_INPUT
 	ret = snd_usb_caiaq_input_init(cdev);
-	if (ret < 0) {
+	if (ret < 0 && ret != -ENODEV) {
 		dev_err(dev, "Unable to set up input system (ret=%d)\n", ret);
 		return ret;
 	}
--- a/sound/usb/caiaq/input.c
+++ b/sound/usb/caiaq/input.c
@@ -804,7 +804,7 @@ int snd_usb_caiaq_input_init(struct snd_
 
 	default:
 		/* no input methods supported on this device */
-		ret = -EINVAL;
+		ret = -ENODEV;
 		goto exit_free_idev;
 	}
 



