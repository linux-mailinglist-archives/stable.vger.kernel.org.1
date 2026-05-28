Return-Path: <stable+bounces-256385-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOsoD66tGGpymAgAu9opvQ
	(envelope-from <stable+bounces-256385-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 23:03:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B18775FA28C
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 23:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCC7B31613DA
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFA0330B32;
	Thu, 28 May 2026 20:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gSK+z2Oc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4722BE621;
	Thu, 28 May 2026 20:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780001552; cv=none; b=leDdc82yUcijGw5Gae2yEFTNFMcSuF5jfNSfs8GtHjxBAqxVfNGoV0sD7CYdhK/TN+j56ajsxnZkk6KNV7EBUv3GGHezPFsfO9Lylmm+Hh9JQBxEigJvuTRhyXA3ArlcLbbTEG27qPimWGMs4uE7S/KC8xO0OF1oBxOoUZgQw+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780001552; c=relaxed/simple;
	bh=iaCMspkGa++66tqzHYJ3VMKAaGLpU7Ck4/yr2hkz2Ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EhS/GJ85kH57OMab2dkuJ69Bs488SDXOm9T0NfVDpxznfG6bx8vUCvfsd7PTWCJmtzBTt6Il0VlxTxhzzatN2omjcN8/IyOYpyCpDTvV5n+7q2xgcIJuTrv4V0ZE1DOa9/3Imlrrg0PBABdZeB7emrllXZU73vYaHcB1DMtsT98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gSK+z2Oc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9EBF1F000E9;
	Thu, 28 May 2026 20:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780001551;
	bh=5cKyA2GE2eFyFvSMbl4e9TZQt3WOxoK6n31I17lPMKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gSK+z2Ocq8ls8A+HqqICsVFTz+7RErk7710LlHpk00IzXn1mjgAg/S58dGn6Wfvrt
	 5b37h+iTJhker/0QCnPmFQYrbCgNPl158lyjt0819kvPOm7RFHdykHwSoDEsUUhOhn
	 bWOg+ESsGAxYyP6lfvbHjn67Mrr6PtqCw13jUIHU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 168/186] ALSA: seq: ump: Use guard() for locking
Date: Thu, 28 May 2026 21:50:48 +0200
Message-ID: <20260528194933.500111810@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194928.941004471@linuxfoundation.org>
References: <20260528194928.941004471@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256385-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,suse.de:email]
X-Rspamd-Queue-Id: B18775FA28C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 6487e363714c28c4b62ac149e7d907cfeeedb3ad ]

We can simplify the code gracefully with new guard() macro and co for
automatic cleanup of locks.

Only the code refactoring, and no functional changes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/r/20240227085306.9764-19-tiwai@suse.de
Stable-dep-of: 60a1969fae62 ("ALSA: seq: Serialize UMP output teardown with event_input")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/seq/seq_ump_client.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/sound/core/seq/seq_ump_client.c b/sound/core/seq/seq_ump_client.c
index 55923ee6c97ae..389516f09f099 100644
--- a/sound/core/seq/seq_ump_client.c
+++ b/sound/core/seq/seq_ump_client.c
@@ -106,21 +106,19 @@ static int seq_ump_process_event(struct snd_seq_event *ev, int direct,
 static int seq_ump_client_open(struct seq_ump_client *client, int dir)
 {
 	struct snd_ump_endpoint *ump = client->ump;
-	int err = 0;
+	int err;
 
-	mutex_lock(&ump->open_mutex);
+	guard(mutex)(&ump->open_mutex);
 	if (dir == STR_OUT && !client->opened[dir]) {
 		err = snd_rawmidi_kernel_open(&ump->core, 0,
 					      SNDRV_RAWMIDI_LFLG_OUTPUT |
 					      SNDRV_RAWMIDI_LFLG_APPEND,
 					      &client->out_rfile);
 		if (err < 0)
-			goto unlock;
+			return err;
 	}
 	client->opened[dir]++;
- unlock:
-	mutex_unlock(&ump->open_mutex);
-	return err;
+	return 0;
 }
 
 /* close the rawmidi */
@@ -128,11 +126,10 @@ static int seq_ump_client_close(struct seq_ump_client *client, int dir)
 {
 	struct snd_ump_endpoint *ump = client->ump;
 
-	mutex_lock(&ump->open_mutex);
+	guard(mutex)(&ump->open_mutex);
 	if (!--client->opened[dir])
 		if (dir == STR_OUT)
 			snd_rawmidi_kernel_release(&client->out_rfile);
-	mutex_unlock(&ump->open_mutex);
 	return 0;
 }
 
-- 
2.53.0




