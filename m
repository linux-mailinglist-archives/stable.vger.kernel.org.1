Return-Path: <stable+bounces-239148-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mP/oAQ055mlutgEAu9opvQ
	(envelope-from <stable+bounces-239148-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:32:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C05B42D2BE
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE4DE338EA2A
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 14:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2ED6481A84;
	Mon, 20 Apr 2026 13:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glNVQOo1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947C0481641;
	Mon, 20 Apr 2026 13:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691902; cv=none; b=jmSMZWBEtkaSoBsuCW5MQMKttK0StPxjCtRSZeSAqMYlxucDpY+Rw/+OvLSwMOpW8LdXbVFafj5n9bbQZtGZRoFgFbRj9lpQ/LFbkx0AnAK9+W0+qzAzGc3hJIK/NngRi0aVz+4NN/HAbVVagfDI1ORFinum8YmI5pRLXBAJ4Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691902; c=relaxed/simple;
	bh=mSTM9qhdsn06O03QutiFicvxTnR9JI/JThqJdOnEs1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sQ9Pg43xb1f+KDEWLhX+IZbN/wfhDoeQLTrdG0le40KnePJwBPNTmkEYtaqsQUaa85W1w0Y9YFnl2PocK1JJ7cz1lh8TYG5IzKM4iYGYPNIv0bex1HoWlPkqj1V2GDKv+kbTi60BTmpLz+Wg0qRLY0+sDLGAr70lEeIdRjqqyz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glNVQOo1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D1DC19425;
	Mon, 20 Apr 2026 13:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691902;
	bh=mSTM9qhdsn06O03QutiFicvxTnR9JI/JThqJdOnEs1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=glNVQOo14nVVyBdGpSRh0pp0dco/tPsgA0uXqRVEbC9WDxKBOD8BuXpGGThzQGboq
	 /wHy9DUC9Tgp7CZKbkqnTnfU9BAeuzHV4ifI6WjeZT1XbFL4C12cSRBu5ZKjQj39jt
	 lJHOBJreAkqfYBekvJtl7pQ3Lx9gd8SgUBGXLQdnuie26PrNtB764Rybk5oahoPBiU
	 JPy0+Bx/sPJEDoMYWxtFQkyVFd3wEwyT7WK8npW5EXUXjBi0e7moCekKA9IGR2h2yf
	 OUPc4LSP53tNcczgEnWN5YeV8mjXDbVu0373R9UXO0RTgOQ1HhUtzxl243GuDhybx7
	 h5jDzuluPE93g==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: =?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	daniel.baluta@nxp.com,
	perex@perex.cz,
	tiwai@suse.com,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18] ASoC: SOF: topology: reject invalid vendor array size in token parser
Date: Mon, 20 Apr 2026 09:20:54 -0400
Message-ID: <20260420132314.1023554-260-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420132314.1023554-1-sashal@kernel.org>
References: <20260420132314.1023554-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.23
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.intel.com,kernel.org,nxp.com,perex.cz,suse.com,alsa-project.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-239148-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 6C05B42D2BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Cássio Gabriel <cassiogabrielcontato@gmail.com>

[ Upstream commit 215e5fe75881a7e2425df04aeeed47a903d5cd5d ]

sof_parse_token_sets() accepts array->size values that can be invalid
for a vendor tuple array header. In particular, a zero size does not
advance the parser state and can lead to non-progress parsing on
malformed topology data.

Validate array->size against the minimum header size and reject values
smaller than sizeof(*array) before parsing. This preserves behavior for
valid topologies and hardens malformed-input handling.

Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://patch.msgid.link/20260319-sof-topology-array-size-fix-v1-1-f9191b16b1b7@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Error: Failed to generate final synthesis

 sound/soc/sof/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index b6d5c8024f8cf..4c8dba285408a 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -736,7 +736,7 @@ static int sof_parse_token_sets(struct snd_soc_component *scomp,
 		asize = le32_to_cpu(array->size);
 
 		/* validate asize */
-		if (asize < 0) { /* FIXME: A zero-size array makes no sense */
+		if (asize < sizeof(*array)) {
 			dev_err(scomp->dev, "error: invalid array size 0x%x\n",
 				asize);
 			return -EINVAL;
-- 
2.53.0


