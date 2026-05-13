Return-Path: <stable+bounces-246845-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFZAOp97BGpoKgIAu9opvQ
	(envelope-from <stable+bounces-246845-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 15:24:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B5A53401B
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 15:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F414D3046342
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 13:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7AE25B0B2;
	Wed, 13 May 2026 13:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="gEsE1YDk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KSRXIT59"
X-Original-To: stable@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C8325B091
	for <stable@vger.kernel.org>; Wed, 13 May 2026 13:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778677241; cv=none; b=fMOabMgB/fRZ2RyOv/8YYPXuHOf3n8xq1Dmjepwbwuk6kQmpPJ4sXc0Gk4G5KkQC5mHGqFFxypL1s/MqZ0c9N2LhTmbopZNbxrvu3ra/yLEW7BmYKTsqpNv6HBFrW9BFlxLWtD+UGTYwFCb8Z8b6s3odmJvn7oLPQyG4+jBW734=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778677241; c=relaxed/simple;
	bh=pOAjCEVsOt3sjNrSU2GVZODzb4uckoGbEXs9JNcIL88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XcT0b/QR/u8Wr00C71n4lvkEFPn0q+Ny53qaaN28PUlXM3pirHZ9EUZ+uYN0ZPTvDiEzkao+7TQj9NdVkw9BSSAIojrdaswxiExmbln0yYsUO0WEk0/aHEMESEQZZr+0uqkc2KmlNtlwUuEvRkSq9VBpsw3XdmPMcKaxSBvuRew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=gEsE1YDk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KSRXIT59; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 5667D1D00082;
	Wed, 13 May 2026 09:00:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 13 May 2026 09:00:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1778677237; x=
	1778763637; bh=UrfoVDgmukh5MHmyEcxHrBiAtWE/cElCFUzuarcZtic=; b=g
	EsE1YDkaykd3QvhZ65HhVXMys7F6t4jgXmzu8oYZJd/uS+fm9AvhVvUBINZ9TD39
	tnhEoKMpKiHjB132K5VYUz760/Kq1cveosGsFJMJtXvq/Exe+EAh10ztyu2eylB5
	e0/qn9/fnRQ0wf+r+G/uz0D3aXVJNCKRJpO2FbWPDygHmVuYUB0SV7wF8EfyDdpw
	8tM6rOJ/KsWYd4o/VBw5b5Yl1uu5TiRyk2UYrLoRJpADni8BmxtOtKb/Vb6DTK8q
	3ol1RSXkKXDnlQH9FhZxxL/JBb2nktGuSvXgRmZfssmBguTM61+MvoCsbyCcEErH
	sNHhLs7yAGNmmiWLTNOxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1778677237; x=1778763637; bh=U
	rfoVDgmukh5MHmyEcxHrBiAtWE/cElCFUzuarcZtic=; b=KSRXIT595NDv/I2pz
	9mDmUiWvpWjx6SmnelmYiILN8c+9eY+wawZjl2FKPaPY+3WJjrNkMXGLCx1Gx6PK
	bCW+sb9nYdYM7V9qSVKdlufoIAmdldwYqn51xCU6UqllMnrxkjIcS5oaxn4zxN8c
	FX9CVLsNRP5D/cihxNxv3oGaer/9MktyctjHXOL7Y9gbUpD/tXEl82FISNuSYauN
	JhEaQM/Q2M/TpehxyR3LULUFSK+6YHU3p9Sy34F7HMDKs93RsTTWi0m3JFUrSNdR
	v+DTfy90xJCkZIjow+SLEj6YDfM13Zpff5qfg3HgGRqkc6oV8Kdro9Vdo07dtPwN
	LNCdA==
X-ME-Sender: <xms:9HUEanySlQFtsPzewgqtbIj0f281ONAdNw79PsYb7kKrV_p6l2BhIg>
    <xme:9HUEamu-bFJJ8GFG2p7nqaerPtkYe1L8i3DYiOmXUW31Edg0zfUgX2gAetX5dYnzb
    koWXm34uUIXWbRvetSBO4_xdjRf0vpZseNiMPr4hb5Rt0R0wwRSrALx>
X-ME-Received: <xmr:9HUEaus9g1Q_cx0o5dxqNLG5fnpCvuxaY2wG_FOMeIW6_xJSuD-ae4Ns3f4kVkFz36EqIRs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdegjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlfeehmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpefuihifvghiucgkhhgrnhhguceoohhsshesfhhouhhrughimhdrgiihii
    eqnecuggftrfgrthhtvghrnhepkedtleeiteevueetudevjeefheejueevffejteffvdeh
    lefftdffleegleduvdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepohhsshesfhhouhhrughimhdrgiihiidpnhgspghrtghpthhtohepfedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepohhsshesfhhouhhrughimhdrgiihiidprhgtphht
    thhopehluhhiiidrvhhonhdruggvnhhtiiesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:9HUEarMC8ay9JEFlind2PME4AZfSW97Pft98Jc5qh9yoo6ZKWQDXkQ>
    <xmx:9HUEas1zcEyGQX2IKo4Fo5W0qWwPLs1STRQnBnZLNg_SjWfWpr7_BA>
    <xmx:9HUEanP9eCV67zGwbNNQPae7pHw-mdd6ReLkhG3SZQ592Xb4tWYArA>
    <xmx:9HUEas1FEHZaNdckDKx1t-ueD-v2-F7z3AqdULRNhlUNsDKeFo2YAA>
    <xmx:9XUEapcCts7Ilgi5Hb5eeSTkMnvXV67DvbAwJRmBFMUT4pmDvTUeW6nK>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 May 2026 09:00:36 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Siwei Zhang <oss@fourdim.xyz>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.6.y] Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_get_sndtimeo_cb()
Date: Wed, 13 May 2026 09:00:32 -0400
Message-ID: <20260513130043.2190556-1-oss@fourdim.xyz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026051216-wilt-civic-8fb6@gregkh>
References: <2026051216-wilt-civic-8fb6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 65B5A53401B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[fourdim.xyz,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[fourdim.xyz:s=fm2,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246845-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[oss@fourdim.xyz,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[fourdim.xyz:+,messagingengine.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fourdim.xyz:email,fourdim.xyz:mid,fourdim.xyz:dkim,messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Add the same NULL guard already present in
l2cap_sock_resume_cb() and l2cap_sock_ready_cb().

Fixes: 8d836d71e222 ("Bluetooth: Access sk_sndtimeo indirectly in l2cap_core.c")
Cc: stable@kernel.org
Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_sock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 1960d35b3be0..adee617517bb 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1725,6 +1725,9 @@ static long l2cap_sock_get_sndtimeo_cb(struct l2cap_chan *chan)
 {
 	struct sock *sk = chan->data;
 
+	if (!sk)
+		return 0;
+
 	return sk->sk_sndtimeo;
 }
 
-- 
2.54.0


