Return-Path: <stable+bounces-224334-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IwfBkkDsGkWegIAu9opvQ
	(envelope-from <stable+bounces-224334-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:40:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AA524B49A
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9036230C0247
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CED38A725;
	Tue, 10 Mar 2026 11:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KU8edZIF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAB03ED122;
	Tue, 10 Mar 2026 11:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142028; cv=none; b=VUDSjBLvZk6Wm/CVknQCnXtUMTg3OzkwWwamFS1Cwx3umtJ+gjHSWR4z9MFKilbnzVoxrM95TUYj11SZPkAFGyA3KTNgyWkoSue2qJleFyh0aIwyry55aOXJltA/80nzFGNXAkKIdWj9YGue+jgCw5fdfR86uIcs76cAIIStn3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142028; c=relaxed/simple;
	bh=xn4v+M+jkqF4yIq1etXfzU7aNVZDvzAgyV8iRUv1cxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L4q3Fi0fPIcUrJRp0Wumk9nlED2BmxwhOgsdcymg5PQJ9mNKui3KqlVzx35oqxRZJHNXyH2U6QSRsJZooi49IUUM6/LzPqwpCH9wbCtKSYG+aCFcQS4mkrNy44Ovoe4BkJoNbymjqwAGOgR4ckWEw3ljEAwsybS50CLlJgX7IVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KU8edZIF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA95C19423;
	Tue, 10 Mar 2026 11:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773142028;
	bh=xn4v+M+jkqF4yIq1etXfzU7aNVZDvzAgyV8iRUv1cxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KU8edZIFVq8202RvWcC4hKohGhFVGtat+UCtnaVK+l6zQA/P73jHvrKiuFlJgIu+T
	 9yocSAHF2PpwMcTxstZUjCvwBehTRdaQk5XZQY6xbuuvN6XNDNJI0roAmwGKYOtGZE
	 fL7RFh6mCBGQmVGTTRBweDHe5J7F+6JqAsxv63k6mdP2gGZ1XbBd0dFnu9EwtYoVNP
	 0qFIEGjdR4nMUgQ1jsglQYQ1F1LJc+obhl6E+RwgMD71eg4qMeBMmYWhAiRxYaN0Ka
	 cad8yWvmMlxFuXtuNId0CZ4ZygoUMxCCtLWeffqi9Zu+bPfgq+su6XHZRkeahEh4Vf
	 57YgJD9Bo+Sgg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Rong Zhang <i@rong.moe>,
	Takashi Iwai <tiwai@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.18 155/314] ALSA: doc: usb-audio: Add doc for QUIRK_FLAG_SKIP_IFACE_SETUP
Date: Tue, 10 Mar 2026 07:16:54 -0400
Message-ID: <0e955388d937755fb1c7de917fb353ce07916d10.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 74AA524B49A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224334-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.de:email,linuxfoundation.org:email,msgid.link:url]
X-Rspamd-Action: no action

From: Rong Zhang <i@rong.moe>

commit 93992667d0ab695ac30ceec91a516fd4bf725d75 upstream.

QUIRK_FLAG_SKIP_IFACE_SETUP was introduced into usb-audio before without
appropriate documentation, so add it.

Fixes: 38c322068a26 ("ALSA: usb-audio: Add QUIRK_FLAG_SKIP_IFACE_SETUP")
Cc: stable@vger.kernel.org
Signed-off-by: Rong Zhang <i@rong.moe>
Link: https://patch.msgid.link/20260302173300.322673-1-i@rong.moe
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
 
-- 
2.51.0


