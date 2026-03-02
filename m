Return-Path: <stable+bounces-222656-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDuRJf/JpWnEFgAAu9opvQ
	(envelope-from <stable+bounces-222656-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 18:33:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5741DDDD4
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 18:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99DAF304D953
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 17:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F33C42669A;
	Mon,  2 Mar 2026 17:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="lXy/W5cr"
X-Original-To: stable@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BB8314D07;
	Mon,  2 Mar 2026 17:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772472809; cv=pass; b=CNaMfHedjKw0WFzs9j+hH25iNef7X6gRvPg4+sGKPajAAaCEeXi7uCm/w2IdVOm3zLNWuYstV22NV6CItqExd8mtsRtLC9S2MLlZZ0jC+/RBzesX5oB4EfmQlmvIGUcHZWPUIF1A0CFjKWpsD93lBbE2u/6L7VVqx8rkurIXFYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772472809; c=relaxed/simple;
	bh=j79qPFKWwqwJ0znWaR7jdEQM5IVfUxAVTqaH6kwY++8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aTU1f9aCMR6SfuAIkrlWPfklfQVMA/FlBSSYzF0XEr0wf3ZRsNhmP2/ymOBnLmGJhUMxPQ7cc0OV6I1r4oJAZ4qp+PnYVQOtiP6bUQ1xxJYcPdn1wksxEB1xU0nQuTEMnNCaB16azKSUkpYszRHUcPGAIG+51tgIL4upsCRz8Is=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=lXy/W5cr; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1772472790; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TjGhzM2q+NMha7IBR/oJbS9IEhVzAkDPrLc+XSCf4Dzdfrsc4392T+pYSKs8/ap0iCaC8CWYzSL9Anowz759QRwRp5Ytmzj4bFpYyHTTZfMqu6a/aq7VeFKw2+tSAd0NLu+d9IPhEJKrPKyVZSjDqvx/jE1H1pOK1D4S85wZ6co=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772472790; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/RhZ1MKZIfeNYwmeIDoI3c60SA/6GXTORzAyE/giRgg=; 
	b=KV+qU50lvNJxYgfJva+kYzezGQ3H8GfQhrybjWmOrwbfgvMZPMFtoZSyxUVRAnqTnJyZXQcqDfeDpL6mQyDpDPBFKLFbp8KnXDfzi0n9VZZVdJEtRDUWMO/DTLv3B3atLWC5nnfA9u7FCmYAKZ1iuG4bAETrp8SdZgtDc9lXtvY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772472790;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=/RhZ1MKZIfeNYwmeIDoI3c60SA/6GXTORzAyE/giRgg=;
	b=lXy/W5crwPXlHDn1JwRWKfCQnk8SDS/c3Sgs89dec/Sg7en6NySeY/x2Ly4mrnty
	KPoKKCRc3WQISYp9isybjBG2gKlxMrP14oolauftvGPZSeOQRx6nNbW+u30nPJqtbSY
	hdVXY8QAetA+0yDb6udn1Z0A1EexZj2lcv5M/sC3HFLCxXf37ydp9OWY2vlzx0PrXtH
	OFxK1ewJE9gAbEnjZNKt6UnLSZWt00jhfXd7ag6sgYCS5bp25Dr6mwokbEpvJvydDWB
	8tljX1sofQQ49t5npiq3DcsXU89goHeYfkETALVzmq/Cj+3MP6vZIKzUPSXDUt50gTz
	pHPF1dlctA==
Received: by mx.zohomail.com with SMTPS id 1772472789305724.3722919046961;
	Mon, 2 Mar 2026 09:33:09 -0800 (PST)
From: Rong Zhang <i@rong.moe>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Rong Zhang <i@rong.moe>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Cryolitia PukNgae <cryolitia@uniontech.com>,
	Arun Raghavan <arunr@valvesoftware.com>,
	linux-sound@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: doc: usb-audio: Add doc for QUIRK_FLAG_SKIP_IFACE_SETUP
Date: Tue,  3 Mar 2026 01:32:59 +0800
Message-ID: <20260302173300.322673-1-i@rong.moe>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Queue-Id: 0F5741DDDD4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[rong.moe,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[rong.moe:s=zmail2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222656-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i@rong.moe,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[rong.moe:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,rong.moe:dkim,rong.moe:email,rong.moe:mid]
X-Rspamd-Action: no action

QUIRK_FLAG_SKIP_IFACE_SETUP was introduced into usb-audio before without
appropriate documentation, so add it.

Fixes: 38c322068a26 ("ALSA: usb-audio: Add QUIRK_FLAG_SKIP_IFACE_SETUP")
Cc: stable@vger.kernel.org
Signed-off-by: Rong Zhang <i@rong.moe>
---
This is separated from https://lore.kernel.org/r/20260301213726.428505-7-i@rong.moe/
(thanks Takashi Iwai)
---
 Documentation/sound/alsa-configuration.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/sound/alsa-configuration.rst b/Documentation/sound/alsa-configuration.rst
index 0a4eaa7d66ddd..55b845d382368 100644
--- a/Documentation/sound/alsa-configuration.rst
+++ b/Documentation/sound/alsa-configuration.rst
@@ -2372,6 +2372,10 @@ quirk_flags
           audible volume
         * bit 25: ``mixer_capture_min_mute``
           Similar to bit 24 but for capture streams
+        * bit 26: ``skip_iface_setup``
+          Skip the probe-time interface setup (usb_set_interface,
+          init_pitch, init_sample_rate); redundant with
+          snd_usb_endpoint_prepare() at stream-open time
 
 This module supports multiple devices, autoprobe and hotplugging.
 

base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
-- 
2.51.0


