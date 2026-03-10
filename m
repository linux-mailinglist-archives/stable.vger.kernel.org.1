Return-Path: <stable+bounces-223922-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEubLeT9r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-223922-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:17:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7806B24A54C
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 831143058E3D
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADE7381AE3;
	Tue, 10 Mar 2026 11:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kv8XdZTJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECA02D978B;
	Tue, 10 Mar 2026 11:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141058; cv=none; b=T35LWoOXS5AyhjHtuoRpHlj+qdPKT1Ei/1ir+1jyvCpQJ/TCI7/JHj1oSK8OF/RC8o4AA436nmVwd6UkfKeuqm9LSm4UaBbw69P0YiceYi16c7JXBgdSLMNPsj2IXfs3b3QKdq1xeA4+TPAM1jHnLsvgGQkMxPzyuBCeYfR5PVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141058; c=relaxed/simple;
	bh=yf6CP9idBcqUvKI2eLU+Da2f8zXENPJNntZ4ZxjTZNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=go3cZDSdYjDV8iBrZSdgvm8xcAXFUGjaeDwla+rIXsjwPZvVrbffNJveiB70qnIPMEy+Qf6U/T6hgapGPnpneYQ61hdy5SzI63zOKrCO20IkZMdLtjBUTaIVhl0EetOH/Ml5OvAIwVp5PugTM/JYKHWoX2sa2maedoXx5AWTpwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kv8XdZTJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFCFC2BCAF;
	Tue, 10 Mar 2026 11:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141057;
	bh=yf6CP9idBcqUvKI2eLU+Da2f8zXENPJNntZ4ZxjTZNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kv8XdZTJ5xupqPbfS71VhgAofR2hhcrGIZTCsUFAxGAs/YJYejPW3YwYPPcnsJB15
	 F1BD1MT5lY0CYnFvy/+J0gWSu6dnXh2iHffJvJ4GFd1k3z81+Pu8IWNHW0f88MAUIG
	 KQiGQ1xypS/SJSWx240tVSOuMd0B2YiSt35vv1eXpnk5KbhPQhv9PB4JPeaHX0F11a
	 8dDF2x6tvuj0uxSMe+4dmc8sskUeQxl7Mvc/7QNO8WtwyKPnKU2ezBzgUHXizN0q/1
	 KnDYitYQnw2atOUNGbHSWFOw7ZlCuL/zPj9wdUyhBeFci8/BD5HUAT41l4f6c6EWr8
	 0wZBb25bF3cfQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 057/311] ALSA: usb-audio: Cap the packet size pre-calculations
Date: Tue, 10 Mar 2026 07:01:44 -0400
Message-ID: <9609886cff64ed2d9d5c127634939b3efb60a12b.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7806B24A54C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223922-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url,suse.de:email]
X-Rspamd-Action: no action

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 7fe8dec3f628e9779f1631576f8e693370050348 ]

We calculate the possible packet sizes beforehand for adaptive and
synchronous endpoints, but we didn't take care of the max frame size
for those pre-calculated values.  When a device or a bus limits the
packet size, a high sample rate or a high number of channels may lead
to the packet sizes that are larger than the given limit, which
results in an error from the USB core at submitting URBs.

As a simple workaround, just add the sanity checks of pre-calculated
packet sizes to have the upper boundary of ep->maxframesize.

Fixes: f0bd62b64016 ("ALSA: usb-audio: Improve frames size computation")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=221076
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20260225085233.316306-2-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/endpoint.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 1eaf52d1ae9c7..bd035ab414531 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -1374,6 +1374,9 @@ int snd_usb_endpoint_set_params(struct snd_usb_audio *chip,
 		return -EINVAL;
 	}
 
+	ep->packsize[0] = min(ep->packsize[0], ep->maxframesize);
+	ep->packsize[1] = min(ep->packsize[1], ep->maxframesize);
+
 	/* calculate the frequency in 16.16 format */
 	ep->freqm = ep->freqn;
 	ep->freqshift = INT_MIN;
-- 
2.51.0


