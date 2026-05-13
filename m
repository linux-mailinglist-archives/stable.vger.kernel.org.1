Return-Path: <stable+bounces-246847-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLviDcZ7BGpoKgIAu9opvQ
	(envelope-from <stable+bounces-246847-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 15:25:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89380534038
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 15:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 109403203108
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 13:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D539125A33F;
	Wed, 13 May 2026 13:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="GZIwnfVZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m8VsM9cD"
X-Original-To: stable@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58A71F0E25
	for <stable@vger.kernel.org>; Wed, 13 May 2026 13:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778677296; cv=none; b=qFqyGsAdABnczz8NkWlqt7rC5A2GWpQewsOUc6m1ukPlh+W/pYINwsBSOc9b5gtAS8Apc51i5uwcK4JzuLNNu1eXtw09nCAR4P8hvNDdYS8aGVCer+ZcYM2Pi2emvMQhSXi5uvIVB2/84XuzSm3Nx1CEeLnDU0VsA2CHFzOCsBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778677296; c=relaxed/simple;
	bh=pOAjCEVsOt3sjNrSU2GVZODzb4uckoGbEXs9JNcIL88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QGFPojSOW+uqnhX6pk+ZOCXc70QKJFLhvwHEg4REMzF30Jg7L2LC5832cto0V4dGP7lMebWEBjIDU67prkTXdHSSdjyeNeOMQXwGynw+1Zd7tlrZvkE2BvDZXNXjICQIyn0v5+hBETnPZK8spm2BHu81SASlNV9e3QsihuqwRvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=GZIwnfVZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m8VsM9cD; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 5129F1D0003F;
	Wed, 13 May 2026 09:01:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 13 May 2026 09:01:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1778677294; x=
	1778763694; bh=UrfoVDgmukh5MHmyEcxHrBiAtWE/cElCFUzuarcZtic=; b=G
	ZIwnfVZYCAxuDb+dY6NQi4aXuyfSPxtKuNYAX8dg4Hxt3ShJyqIp+vDyP0HWDZJ3
	uaui99qvtoaL96n71fckVCbVh/VXQoRUDdCFTp1GgXF3kkvZCKNbzcoz+/p3gfzq
	2hghjhRSaLc4S8jF2T5cMo71oDKdBoHvWptslsKloAiQnWLJQ+2CV99bIIwjoCuH
	68Hkfx6k2ItBUCIMUzyyXbVLfQhHMp19wBD2xBZuWqpKxRT1g+T288V5x/VijXN7
	D6XR0CByh74tPyaIacPwrTEZQOzCktFsjrHhsop/1UQ6hi9E7LCBNZzMViD08e1S
	GTTcosfamMqLPI4uJ/Jzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1778677294; x=1778763694; bh=U
	rfoVDgmukh5MHmyEcxHrBiAtWE/cElCFUzuarcZtic=; b=m8VsM9cDZrTAp05Wu
	gk/SHMEAStn4qguU8WuNh3xWkm3olpi6ynLVIxsc15fW3iEDKNuzmSztWnMXdF65
	O7TiW8EukbL/5B1RDRk4TFMj6MVtdD7Uks2Of4dR1g9ON3oR2Lk574yXayyH8jN+
	e1CiEN5qf91Ruq8I5FGS2HT2tVcdJ2ulUYk+mo0MXdVYTuQpfkCcQM6Tko6lu/KJ
	3O3QeOW6I2g4GPHU52Jo3RS7DhcpNlG2qc5n9goQEdXdloURvHU0jD1sqMSlF6HF
	xhanuR9BxXTML6y2xFVUIov1Gd5tED21uqf062dEtkdEX4HQ4WkpaKQcYCGE3owh
	1egZA==
X-ME-Sender: <xms:LXYEagqmnloei8khuCbwrv2DePcCIY5taL26bqMvTfFfo_R7R0eQzQ>
    <xme:LXYEauGlw41peQOP8UnE3aTPImlK8j8XzcIikXS5nxlOzii2yOg8JeqWX2szRpXGo
    qT3IizQbt4UNLCyjH7DEoEZxRhj3bIWrnz0jdPuYWGQd630hAIPozc>
X-ME-Received: <xmr:LXYEainPP2FvV-b277yi2SExmdra2cvHFKPCgfbitFQHp1GiqHBV0Pc-p_JIOk1KMBD4s0c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdegjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlfeehmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpefuihifvghiucgkhhgrnhhguceoohhsshesfhhouhhrughimhdrgiihii
    eqnecuggftrfgrthhtvghrnhepkedtleeiteevueetudevjeefheejueevffejteffvdeh
    lefftdffleegleduvdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepohhsshesfhhouhhrughimhdrgiihiidpnhgspghrtghpthhtohepfedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepohhsshesfhhouhhrughimhdrgiihiidprhgtphht
    thhopehluhhiiidrvhhonhdruggvnhhtiiesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:LnYEahmO4CwORAoyV5fSk7ZAMdCZYS1Q3_siXSuuCjaj0EsMNycaTw>
    <xmx:LnYEajtytPIc588aoYdGw2sOm8l66N75zY7Wgb1B8z4onW0aZhWDTA>
    <xmx:LnYEakkma_hcU67kdmrevMOYcJq0-9v5HYT2cj5mzcYEBpKVHOHxPw>
    <xmx:LnYEauvsIxHo36k8OsHsOs1Sn-vHvfME6bpO2hxwe7Mmx4gUGPatww>
    <xmx:LnYEas11TO88QShqTA2GBiXnogYtCzpU_CF7jeD9s14UPmB8ntKfSGi0>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 May 2026 09:01:33 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Siwei Zhang <oss@fourdim.xyz>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.1.y] Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_get_sndtimeo_cb()
Date: Wed, 13 May 2026 09:01:43 -0400
Message-ID: <20260513130151.2191562-1-oss@fourdim.xyz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026051216-resource-trading-20ac@gregkh>
References: <2026051216-resource-trading-20ac@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 89380534038
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
	TAGGED_FROM(0.00)[bounces-246847-lists,stable=lfdr.de];
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


