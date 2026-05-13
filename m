Return-Path: <stable+bounces-246875-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBx+NDeVBGqrLgIAu9opvQ
	(envelope-from <stable+bounces-246875-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:13:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF4A535DA5
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBBA23180C41
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 14:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBD9306754;
	Wed, 13 May 2026 14:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcsxgjMT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B07212FAD
	for <stable@vger.kernel.org>; Wed, 13 May 2026 14:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778681375; cv=none; b=m1BfZ96vVRu2shhhRfE4DPy8POm1DzTxTGm2MSlpxmrCsqw7shdeyUkVh78FQyS/33aCX+0ZvdUBGammU/0Q5+Sjh5UWlCCYZqGdIG4RUtyrtnVNpWeJEGWXcz+xeuX+mSWa7fPaAo36V57AzIMVi0MDcX3ZxeWAjDLSj0/Bzt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778681375; c=relaxed/simple;
	bh=tYPk9Bes9ZD3LV3DkXmlU7F59VCmVLjgPL7ZAe2kA/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nY2l/jFGFyycDOH5rLZuXZzZSa/KrMz027uNY4vJSVH2RZ1PYdhCoPGNuAu+AmVJ5JrbL73aZsR5hY/qXpj3yO6594TosYFD8haEPJmbgxIG5+Y66USAMAGw/pRQrefDnue8wsIwavseXxQ0SUkRghGvVB9fB6ocg7R9bddMjak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcsxgjMT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 211D2C19425;
	Wed, 13 May 2026 14:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778681374;
	bh=tYPk9Bes9ZD3LV3DkXmlU7F59VCmVLjgPL7ZAe2kA/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hcsxgjMT/JzGCHvcNMBenugDe1MiTwIgWJwa+WnEyPtQp5oXmFycjnOIEt9W1i5Ap
	 ZOQRBj6Hcb5NLw2KPgqNVpd9vNnU1FNeK1qIjdHQuAa+8bLaZ+LRsQNNF9NXpT5gUs
	 tbLZZ5TfvIWdwfOjPx8Qe+FF2V/G4OXpjx4aiG9FWNi6s5z356fNg7/WnotQL8DNAg
	 FiaqFrpr0TfdtGIIvUbQEn93dQgJNlou7o69PDqGgA01wFAOx1glyHN8Ru80e1m3RT
	 kBLLODd4C9ms4i6twzVm7hrI3/dNybTQAbp+nxDSom8X3BC8Rb9iwU+4pqUijCI9BA
	 A5KmFEsnFKYXg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Mark Lentczner <mark@glyphic.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] ALSA: seq: Notify client and port info changes
Date: Wed, 13 May 2026 10:09:31 -0400
Message-ID: <20260513140932.3747146-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051221-campus-grafting-01b1@gregkh>
References: <2026051221-campus-grafting-01b1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5DF4A535DA5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246875-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email,glyphic.com:email]
X-Rspamd-Action: no action

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit b8e49e24cdba27a0810a0988e810e2c68f2033cb ]

It was supposed to be notified when a sequencer client info and a port
info has changed (via SNDRV_SEQ_EVENT_CLIENT_CHANGE and
SNDRV_SEQ_EVENT_PORT_CHANGE event, respectively), and there are
already helper functions.  But those aren't really sent from the
driver so far, except for the recent support of UMP, simply due to the
lack of implementations.

This patch adds the missing notifications at updating the client and
the port info.  The formerly added notification for UMP is dropped
because it's handled now in the port info side.

Reported-by: Mark Lentczner <mark@glyphic.com>
Link: https://lore.kernel.org/CAPnksqRok7xGa4bxq9WWimVV=28-7_j628OmrWLS=S0=hzaTHQ@mail.gmail.com
Link: https://patch.msgid.link/20241128074734.32165-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: 92429ca999db ("ALSA: seq: Fix UMP group 16 filtering")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/seq/seq_clientmgr.c  | 7 +++++++
 sound/core/seq/seq_ump_client.c | 2 --
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 9e59a97f47472..80b73bb199edd 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1329,6 +1329,10 @@ static int snd_seq_ioctl_set_client_info(struct snd_seq_client *client,
 		client->midi_version = client_info->midi_version;
 	memcpy(client->event_filter, client_info->event_filter, 32);
 	client->group_filter = client_info->group_filter;
+
+	/* notify the change */
+	snd_seq_system_client_ev_client_change(client->number);
+
 	return 0;
 }
 
@@ -1452,6 +1456,9 @@ static int snd_seq_ioctl_set_port_info(struct snd_seq_client *client, void *arg)
 	if (port) {
 		snd_seq_set_port_info(port, info);
 		snd_seq_port_unlock(port);
+		/* notify the change */
+		snd_seq_system_client_ev_port_change(info->addr.client,
+						     info->addr.port);
 	}
 	return 0;
 }
diff --git a/sound/core/seq/seq_ump_client.c b/sound/core/seq/seq_ump_client.c
index e956f17f37928..27c4dd9940ffb 100644
--- a/sound/core/seq/seq_ump_client.c
+++ b/sound/core/seq/seq_ump_client.c
@@ -272,8 +272,6 @@ static void update_port_infos(struct seq_ump_client *client)
 						new);
 		if (err < 0)
 			continue;
-		/* notify to system port */
-		snd_seq_system_client_ev_port_change(client->seq_client, i);
 	}
 }
 
-- 
2.53.0


