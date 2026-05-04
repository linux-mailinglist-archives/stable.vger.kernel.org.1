Return-Path: <stable+bounces-243836-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GD+iM2uv+Gn2xgIAu9opvQ
	(envelope-from <stable+bounces-243836-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:38:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EF34BFCE2
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4AA6630CB0AC
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850483DFC69;
	Mon,  4 May 2026 14:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vGYfmDIr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484B13D905D;
	Mon,  4 May 2026 14:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904902; cv=none; b=qFDj+pePbf0NEfAe2lA5J9nSi/JXO2qhxsFge3XxfWf3K9mCkBeGKvefIfk5h00sc9zAYOEcobQZyZVLIb3LvopyFzAUXd5nFQiyAk6jGqxrD7y2DWJGFk10vvQqHJeHQABGsDpGT0o1m7EBrnc23Q7k7IkrrOrybrP5Gnowm38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904902; c=relaxed/simple;
	bh=4Up+mBn7xOXaYPGTmWcNSTAFy7GkAUmW7NMwYVWF+fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rzm4b24qr3a3iJjxXJtJTIT9veZcUXJMLkA6zUEdg7mYL0h+iRnbF6HmrkLDoDM7vqpg6zfIqmDlM3f6CTDFjhiewJhC8qpTyPGwmKb0Kx8G7suBnFewZQ7eG+hswB/98nnLpUMb4a3EQyh/gctVJtM2UIT8wGkNKnBP3KsKqsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vGYfmDIr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1BD7C2BCC4;
	Mon,  4 May 2026 14:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777904902;
	bh=4Up+mBn7xOXaYPGTmWcNSTAFy7GkAUmW7NMwYVWF+fo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vGYfmDIrTaC7S/FfT4v5y1tF4WMZJ2V7ZRETVYIp5Y4434HkLzpaqHoNA5SeCAJnE
	 Iv306XyNh3FQXvnPwTqbkzUIGz1yHX/9z+nNruEv34ohP5MvGzws4eyjAP6lUMpAT1
	 35nIWlacCt+QoQuxiaVZSIWdYMcARtxqW+RYRtZc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.12 209/215] ALSA: caiaq: Dont abort when no input device is available
Date: Mon,  4 May 2026 15:53:48 +0200
Message-ID: <20260504135138.453526947@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135130.169210693@linuxfoundation.org>
References: <20260504135130.169210693@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 55EF34BFCE2
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-243836-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,suse.de:email]

6.12-stable review patch.  If anyone has any objections, please let me know.

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
 



