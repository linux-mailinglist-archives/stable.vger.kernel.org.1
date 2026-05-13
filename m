Return-Path: <stable+bounces-246848-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OILpJAx8BGpoKgIAu9opvQ
	(envelope-from <stable+bounces-246848-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 15:26:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCB8534091
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 15:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D74263107D27
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 13:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D012253FC;
	Wed, 13 May 2026 13:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="f4qssH7x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vG3lbMRx"
X-Original-To: stable@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CAA1F0E25
	for <stable@vger.kernel.org>; Wed, 13 May 2026 13:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778677355; cv=none; b=YJkjBNof09AGKiCIm7vPY8D1wb2QEY6GnlKZO/PObYfaNfwSJbE6fKJDgcRpg1qJvX1OcvAMF7YH1QgESptqvYUwYyrjBaVTEn1z7MARmlZEoOrmHbA3HQXlfA3QvaVWo4rUe77VD3qtPWOp55iU8qSgPbmegBH9uKOnRsQYLJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778677355; c=relaxed/simple;
	bh=pOAjCEVsOt3sjNrSU2GVZODzb4uckoGbEXs9JNcIL88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=io5xj3pJHQYjowiQSqeNWtaWRpRu4kzCR5SEsc3Gbiymn/Axawl9hjKsrrj85bxS3vJtjhwxG7Q8rSfxJ+lJ3o2wzgg6ggXIO3M3/TdJyN6Ak9X2gqxNtLQCEmIhxaeip0X4SIco8Y+DNTrZZ6OOZrGZzbYht1VLHRf1ALYH5+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=f4qssH7x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vG3lbMRx; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id B747C1D000C9;
	Wed, 13 May 2026 09:02:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 13 May 2026 09:02:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1778677353; x=
	1778763753; bh=UrfoVDgmukh5MHmyEcxHrBiAtWE/cElCFUzuarcZtic=; b=f
	4qssH7xUTJvpDnGZfN5lUdlVKWKfybdOIjq8rdKW7Rlzrx+RsfkvFnTPTl1n6QK1
	1W2W8clF7sYkZtaUpZYgC4IvAa1wOdfFiVh21P4Rz5WdY3rMBxE0RjoukHzDxTwh
	Xi/ftN6hWxFASXn0sFTooKTSESwALe/Y/yEb+Gx8GUlpH5kQKuE9TBnbcU3wUwYv
	OzpIpinn+atTSCKUcJwm5AKeqvqtcHIRdi5YWrDMuPo/+KaziKIKXM4Fj5KVSXYC
	DkTL15vna+H1KuY607Fu7h5yrf4Y46n4aV6VEpMngmG5GKSe7eIsJcPpy6oFGkoR
	l284a+B9aJSWpVzYIfp1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1778677353; x=1778763753; bh=U
	rfoVDgmukh5MHmyEcxHrBiAtWE/cElCFUzuarcZtic=; b=vG3lbMRx5He2qC4qG
	YwmmSXHC3KD344wSJ63VUBWGFGtDjS/PnAm/DyVldDfSvGeAOoSKplU/Z5x6m9OD
	GJsWE+sOucH9aPdYGMzFwl92L76lF7xZPWfjsIAZlNKukC8M2QCKL4jfcg5Bo/VW
	7ATOLSBiwHGI1XXEUuytA0Z1T4TN02LxVGkAaQScE3GyGJNK1qjhZ01WgB57A2JD
	2QvaioZXT/98EyFVjZmHttQv7WT3bZvR/7OtstHfS30FbfgoWb8bc7RMuMjxJ3+G
	Isb1im7YxSlpe2q88m66gJnKOKiw3dguX3iTusZ1wc0Gz51ZgAkRduFEjEK+i0bm
	KSqyQ==
X-ME-Sender: <xms:aXYEasxudhX4GXcGUVr3okfe3lsupRpasNQFw7LsRzJkb8N_OXhNaA>
    <xme:aXYEants2khRmW_zJ_B0xYAIAt2tethH5_NrNU1PArQqd5ZZ44HR7CBW6xymo7Mf6
    9d0FZvyGT1Dop0bA8pI5P10rvS6Adk2uL5xuUE5zf5oMbUskG4O0OE>
X-ME-Received: <xmr:aXYEaru6WCI2EyCEtp9yx847orb5b2xlJNKMUQjYy6a2w7yC2V5u30NK8PnbbHUUBNfEXAs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdegjeefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:aXYEakMHuo6CQpAF_rNuuEEvyfemY1OhIjxkNmROrF0Rqwwyq3AkFA>
    <xmx:aXYEah3F4B0uM7i0vMEukYvbX1Wevc7qaiAgZfaiaTXdPJn7n9RiKA>
    <xmx:aXYEaoN8GZFIEPSIkX5cKydXlgCnb6psiSDPFOX2LDDAJs0kcODVDg>
    <xmx:aXYEap2_Tn6vaXG3fko8LP8PemiBQ-D8Cg1BOvEPU_SYyvGfaCiB3w>
    <xmx:aXYEalyvY0yC9VnG3ORA6GP5plVbo1yzl0B30ekRcH5Ayscai5WFI01w>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 May 2026 09:02:33 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Siwei Zhang <oss@fourdim.xyz>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.12.y] Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_get_sndtimeo_cb()
Date: Wed, 13 May 2026 09:02:37 -0400
Message-ID: <20260513130248.2192409-1-oss@fourdim.xyz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026051216-harsh-pretender-53e0@gregkh>
References: <2026051216-harsh-pretender-53e0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EDCB8534091
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[fourdim.xyz,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[fourdim.xyz:s=fm2,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246848-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fourdim.xyz:email,fourdim.xyz:mid,fourdim.xyz:dkim,messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
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


