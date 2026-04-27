Return-Path: <stable+bounces-241292-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MG8XJhBG72m2/gAAu9opvQ
	(envelope-from <stable+bounces-241292-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 13:18:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC01647197B
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 13:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DFB71302304E
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 11:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A72B3B7B7F;
	Mon, 27 Apr 2026 11:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=innora.ai header.i=@innora.ai header.b="jlexiK9V"
X-Original-To: stable@vger.kernel.org
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555CB3B777D
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 11:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777288680; cv=none; b=TOl6Qdwy9wzA4xawCmQEkKsTxnU6+HT60pGOWd6kJebNPAcyiIQbokN6Oh/qhyHNuS+01ibNx2DgrNNyUPpNfteJ8OWKJ8RPPo/GY1eRn1esBQzEP3r5YpaRqqjFTCkpZptKyE3l/gtRqJZ8IOyQ6MLmIQyQVuyU/90ODbVB1vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777288680; c=relaxed/simple;
	bh=g5NNe6gF4OXSnwcJlSWtKzcnfdVY2mQrcldMyOKeUOA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q8rSWAPw7DYdhHm0meqtnaCX0nTNZGWT1b2SEc6LScaKx7JJmLtOkW76/+r1m4GaZYohVGHUNCZ4DopaLcx8BcYGorVk+TpCUikC4wCJkl/zf3fsdBMiK08Efh+7UtYRu4/9+kSvwQutC8JImOIQf/BQZqvS4J4DQVpf+rvWC3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=innora.ai; spf=pass smtp.mailfrom=innora.ai; dkim=pass (2048-bit key) header.d=innora.ai header.i=@innora.ai header.b=jlexiK9V; arc=none smtp.client-ip=185.70.43.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=innora.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=innora.ai
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innora.ai;
	s=protonmail2; t=1777288670; x=1777547870;
	bh=FmfuV6p5cZWjbgVuJpb7PqBFGvks9LcqmK99A5kkTwE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=jlexiK9Vu2D3i9D2SLwtF/LYKunWeSm4a6z0cqdV3JH1xztS4GNEQXGGWSKYuKu2u
	 eyftdZhoLSL3FL/MIA6e56HmqxcJKv3nfjqGgURVhjQNcHgJRpar19Q7pJwOaLBWBX
	 KQfTVLeDsO0D1/1xiz9+KOiLTPENr+Bd/hZEhITBAjwrJrsoGPCBFggqeNDiQr+Bsf
	 O4MEPTDy5hTySs0V2qc/t+SPQQ5ni1PcNOYF46063wgDle2uYVeJwCgIDiE+rikYeQ
	 0oWJ0r3bpomYOZN/F72toiiFezJZErJyNAijHtkiBoXQWmAOJ8+QJfErvCXkFNJnIw
	 5VmsVcUGI/FmA==
Date: Mon, 27 Apr 2026 11:17:45 +0000
To: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev
From: Feng Ning <feng@innora.ai>
Cc: Luka Gejak <luka.gejak@linux.dev>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v6] staging: rtl8723bs: fix heap buffer overflow in cfg80211_rtw_add_key()
Message-ID: <20260427111738.33069-1-feng@innora.ai>
In-Reply-To: <2026042626-tabloid-suitor-33c5@gregkh>
References: <20260413113224.5201-1-feng@innora.ai> <2026042626-tabloid-suitor-33c5@gregkh>
Feedback-ID: 140578448:user:proton
X-Pm-Message-ID: 9e717287eba13d6fd05d95c3707f90afcb0a57ef
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: EC01647197B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[innora.ai,reject];
	R_DKIM_ALLOW(-0.20)[innora.ai:s=protonmail2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241292-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[feng@innora.ai,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[innora.ai:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,innora.ai:email,innora.ai:dkim,innora.ai:mid,linux.dev:email]

The cfg80211 framework allows userspace to specify a key sequence
counter (NL80211_KEY_SEQ) of up to 16 bytes via NL80211_CMD_NEW_KEY
netlink messages, but ieee_param.crypt.seq is a fixed 8-byte buffer.
When cfg80211_rtw_add_key() copies the sequence counter via memcpy()
without checking seq_len, a heap buffer overflow of up to 8 bytes
occurs, overwriting bytes following seq within the same ieee_param
structure (key_len and the trailing key[] flexible array).

Cap the copy length at the buffer size using min_t().

Reviewed-by: Luka Gejak <luka.gejak@linux.dev>
Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Feng Ning <feng@innora.ai>
---
Changes v5 -> v6:
  - Restore the changelog that was lost in v5 (per Greg KH feedback)
  - Add Cc: stable@vger.kernel.org (user-reachable heap overflow)
  - Tighten wording about which fields are clobbered (avoid implying
    a specific layout when padding may exist)
  - No code changes from v5; v4..v6 are byte-identical at the code
    level, so Luka Gejak's Reviewed-by from v4 is carried over

Changes v4 -> v5:
  - Rebase onto staging-next (line numbers and surrounding hashes
    refreshed; the hunk itself is unchanged)
  - No code changes from v4

Changes v3 -> v4:
  - Resend as plain text without PGP signature and public-key
    attachment (per Luka Gejak feedback)
  - No code changes from v3

Changes v2 -> v3:
  - Move the changelog below the cut line (per gregkh patch-bot)
  - No code changes from v2

Changes v1 -> v2:
  - Reformat as a proper kernel patch with Fixes: tag and
    Signed-off-by; address comments from the initial submission
  - No code changes from v1

 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/st=
aging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 7cb0c6f22..4fba53c2d 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -883,8 +883,11 @@ static int cfg80211_rtw_add_key(struct wiphy *wiphy, s=
truct net_device *ndev,

 =09param->u.crypt.idx =3D key_index;

-=09if (params->seq_len && params->seq)
-=09=09memcpy(param->u.crypt.seq, (u8 *)params->seq, params->seq_len);
+=09if (params->seq_len && params->seq) {
+=09=09size_t seq_copy =3D min_t(size_t, params->seq_len,
+=09=09=09=09       sizeof(param->u.crypt.seq));
+=09=09memcpy(param->u.crypt.seq, (u8 *)params->seq, seq_copy);
+=09}

 =09if (params->key_len && params->key) {
 =09=09param->u.crypt.key_len =3D params->key_len;
--
2.43.0


