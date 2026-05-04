Return-Path: <stable+bounces-243400-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yICfDU6r+Gn2xgIAu9opvQ
	(envelope-from <stable+bounces-243400-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:21:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C354BF26B
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 957AE306AE2B
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C304D3D5667;
	Mon,  4 May 2026 14:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wy6bUJee"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F9D1ADC83;
	Mon,  4 May 2026 14:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903786; cv=none; b=agQKURZQjFYsmUVZKYdmjTzcouNLP+FCAPKyMsAZ3+a2cF+yl6fpZCVFdoIEtpkg/2u/BNqce/A06tcQAWWwLHAKjAtoJlgAlmiOPy+RDUX1kcCqExhbnf3nWJRqiLGNNmB/LkNVjZ5jmCPtijmvSqW2wP3zR1wTGbS0W6r2toY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903786; c=relaxed/simple;
	bh=7oNOXYOsfDm3W8wKK/nEtjNw7sGZFxUkVRObXIir2vY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kRWFVIng34nvIVkTrWpLnJVfHuzdROAn5J7H/UPJ//LXID2Pl99B3Mdd7kSjxR3Mc5NK+cvrqgmVwNm0TlhnHfgZKN+iWdjbBRSJumhD1T0TOD32Q2LfmUxlG5gllzO8O6FK+Z1PdHYi8O+U/wZemkrDuxq6pA3gZtpSdnk1tp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wy6bUJee; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1848EC2BCB8;
	Mon,  4 May 2026 14:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903786;
	bh=7oNOXYOsfDm3W8wKK/nEtjNw7sGZFxUkVRObXIir2vY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wy6bUJeeUj0fh0MwNIhjnJo77fqB7efA653JtlASPBpYG3NmrDoCuwghagQmCmeKI
	 sLGWYTUUre6jXJPywRy5GbKKltZV5pP8wC0Nu3t7S7h8h9HMNg9LwUwuJRNYdk/ZrS
	 OlZ/NC0SkCEc9FHdoW19JBTRLHnCxaRP1AEtDBPg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.18 062/275] ALSA: aoa: i2sbus: fix OF node lifetime handling
Date: Mon,  4 May 2026 15:50:02 +0200
Message-ID: <20260504135145.237178851@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.929052779@linuxfoundation.org>
References: <20260504135142.929052779@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 42C354BF26B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243400-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,suse.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,suse.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cássio Gabriel <cassiogabrielcontato@gmail.com>

commit 4ec93f070eda6b765b62efcaed9241c3b3b0b6ad upstream.

i2sbus_add_dev() keeps the matched "sound" child pointer after
for_each_child_of_node() has dropped the iterator reference. Take an
extra reference before saving that node and drop it after the
layout-id/device-id lookup is complete.

The function also stores np in dev->sound.ofdev.dev.of_node without
taking a reference for the embedded soundbus device. Since i2sbus
overrides the embedded platform device release callback, balance that
reference explicitly in the local error path and in i2sbus_release_dev().

Fixes: f3d9478b2ce4 ("[ALSA] snd-aoa: add snd-aoa")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
Link: https://patch.msgid.link/20260330-aoa-i2sbus-ofnode-lifetime-v1-1-51c309f4ff06@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/aoa/soundbus/i2sbus/core.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/sound/aoa/soundbus/i2sbus/core.c
+++ b/sound/aoa/soundbus/i2sbus/core.c
@@ -84,6 +84,7 @@ static void i2sbus_release_dev(struct de
 	for (i = aoa_resource_i2smmio; i <= aoa_resource_rxdbdma; i++)
 		free_irq(i2sdev->interrupts[i], i2sdev);
 	i2sbus_control_remove_dev(i2sdev->control, i2sdev);
+	of_node_put(i2sdev->sound.ofdev.dev.of_node);
 	mutex_destroy(&i2sdev->lock);
 	kfree(i2sdev);
 }
@@ -147,7 +148,6 @@ static int i2sbus_get_and_fixup_rsrc(str
 }
 
 /* Returns 1 if added, 0 for otherwise; don't return a negative value! */
-/* FIXME: look at device node refcounting */
 static int i2sbus_add_dev(struct macio_dev *macio,
 			  struct i2sbus_control *control,
 			  struct device_node *np)
@@ -178,8 +178,9 @@ static int i2sbus_add_dev(struct macio_d
 	i = 0;
 	for_each_child_of_node(np, child) {
 		if (of_node_name_eq(child, "sound")) {
+			of_node_put(sound);
 			i++;
-			sound = child;
+			sound = of_node_get(child);
 		}
 	}
 	if (i == 1) {
@@ -205,6 +206,7 @@ static int i2sbus_add_dev(struct macio_d
 			}
 		}
 	}
+	of_node_put(sound);
 	/* for the time being, until we can handle non-layout-id
 	 * things in some fabric, refuse to attach if there is no
 	 * layout-id property or we haven't been forced to attach.
@@ -219,7 +221,7 @@ static int i2sbus_add_dev(struct macio_d
 	mutex_init(&dev->lock);
 	spin_lock_init(&dev->low_lock);
 	dev->sound.ofdev.archdata.dma_mask = macio->ofdev.archdata.dma_mask;
-	dev->sound.ofdev.dev.of_node = np;
+	dev->sound.ofdev.dev.of_node = of_node_get(np);
 	dev->sound.ofdev.dev.dma_mask = &dev->sound.ofdev.archdata.dma_mask;
 	dev->sound.ofdev.dev.parent = &macio->ofdev.dev;
 	dev->sound.ofdev.dev.release = i2sbus_release_dev;
@@ -327,6 +329,7 @@ static int i2sbus_add_dev(struct macio_d
 	for (i=0;i<3;i++)
 		release_and_free_resource(dev->allocated_resource[i]);
 	mutex_destroy(&dev->lock);
+	of_node_put(dev->sound.ofdev.dev.of_node);
 	kfree(dev);
 	return 0;
 }



