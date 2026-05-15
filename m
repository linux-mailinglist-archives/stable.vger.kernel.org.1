Return-Path: <stable+bounces-247644-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CITMKZb3BmpUpwIAu9opvQ
	(envelope-from <stable+bounces-247644-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:38:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0799F54D7BF
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 132F030EF791
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEF53CFF75;
	Fri, 15 May 2026 10:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="aCrA9kFY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O2yRHG09"
X-Original-To: stable@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D0C3CEB87
	for <stable@vger.kernel.org>; Fri, 15 May 2026 10:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778840301; cv=none; b=n0uGn7iAFvE4XJCEJyGN8CDUc5REa6YLhaKvshHqB61aN01n39VhjBTPZjqv3UGOzEtC2puoqWnVxUs1Hh22T7u0TQBy8rNzres2npNzJUZSTiiJbJ+5IYmf/BnOhl4yOm4eWd4436yIg+0rt5nfN9W2rzA9FmyhWdFi4fpqiFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778840301; c=relaxed/simple;
	bh=OBSPvXaRrxrfrhsTs64tbVj8zcTZcTiu3rvbp295l6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fE0HmGE1ywEPrLt5ag0b2l1PPXTnnOrvXAehDHaDJBsgdLcdPsRL/jvCRmlJeqANhl99zTsnM/rzUBZnKC/4zZgvtTo+tdgHknMrkRs7u3ikw+pA6IMdoZcOtNxV+tiwjWrC0aXumSlmv+lOeb34cs6gkJVVQbtdf84GoYzpAWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=aCrA9kFY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O2yRHG09; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 4E337EC0016;
	Fri, 15 May 2026 06:18:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 15 May 2026 06:18:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1778840299; x=
	1778926699; bh=eUTO1sFEDceL9NhbMHZwWw3LJofuPGNfLgpavY59mn4=; b=a
	CrA9kFYaHiM4ggPnXxEPOkLNAaHRrvtHAQ3hyR7huQUrInH+GYKVySfFSt1vGtTt
	Y+k8HibinwDYRnNc0lSS61Z2zH8gQcCJFcDJu64aexAg/LOm8ZQiye87LL9UNzE4
	mdFWk1yQv7A/Z9fojM7S2Ex6fUa5G+UqB1RLP+J7JwwtG8LqZUWRn/v4oKxujUVJ
	Wpcp/KSrhUpCtxPmmfUUz7IL8NFVcERJppgyigAN1VXQQH/7g1dZ2ani8x/qpex8
	i75boqXH4KS3dHphtfO7u98RzOGhsyQIFrMDbP0jW9S9mvq4NLGtebT3cUeLCVLZ
	5/BF7i4c+6taVphcjL20Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1778840299; x=1778926699; bh=e
	UTO1sFEDceL9NhbMHZwWw3LJofuPGNfLgpavY59mn4=; b=O2yRHG09vOWsPk6e8
	HJvs7wNCY37afLacSrYFE42m6Lr279vfURtD/LDgU2xUbwMaZYA+FwanP2d99cVC
	6bBw3D9SIPnLkFY8oOGbwiU7tpcJgOXFek/l6IIkeXryW/3/6osrlzsUsax5y5AW
	L8+6QTJpmiuV9Hv4ZpMv/3mOatV2LhpsictTQACxaquXW4eHZaGBHJUU25y9WyuN
	TvwaOQSYZfidBkowdR6Nam76Eb0VZk0vzwKNBCks1eWK1q7kfB15/snEiHYDs5tK
	MGY+e7kC85n6m9ShyBJ1hTAZqBHv1fINsE/nPl71i9fldkKUIuBzH4WUxtKKj6NM
	DId2w==
X-ME-Sender: <xms:6_IGarTSXObvJ_lg15ojCpcN9JXywKOd4TfK2zt0_4RDBM2EaAR5kg>
    <xme:6_IGakNmlYKJONlHV_i_M6XJdQKbAjeU7rG1fjlHCRu6HgBfF7_HEZ-eMlp1neb-M
    qIHg4sW5ffm9txzmV3ZQsGcIS6GWizDIx6r8DuJISDDGuA86kkk9oo>
X-ME-Received: <xmr:6_IGauPEvmdoq04hHeDqj10aR2AAEeToBhDaaf_yJrMW04LS1BsR7YAsZnHYELBjjPM8Auc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufedtudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdljedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpefuihifvghiucgkhhgrnhhguceoohhsshesfhhouhhrughimhdrgiihii
    eqnecuggftrfgrthhtvghrnhepkedtleeiteevueetudevjeefheejueevffejteffvdeh
    lefftdffleegleduvdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepohhsshesfhhouhhrughimhdrgiihiidpnhgspghrtghpthhtohepfedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepohhsshesfhhouhhrughimhdrgiihiidprhgtphht
    thhopehluhhiiidrvhhonhdruggvnhhtiiesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:6_IGaktKLNVQiMoATP-0ctbCDuidm4j6E8ZkD320vYXnmOh2duZIGQ>
    <xmx:6_IGaoV_IIAtXC_JKUhwqguvEJtDRx9r9vgA0J7QNsLSRCU50Ih1IA>
    <xmx:6_IGastKla8fZCBZ4iL0a_rYgHigbUd6ezTao5WDIUGcWraGhWzTyw>
    <xmx:6_IGakVEuk5cFYp78cNOQAy9mfEppoe_zcW59f0VUNjBdXZe-HKRsw>
    <xmx:6_IGam8ZoeKYocJdTSYp_e-QWILi3Ivxw8eyX48yuSVryb9ZQFviq8sa>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 May 2026 06:18:18 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Siwei Zhang <oss@fourdim.xyz>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.12.y] Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_get_sndtimeo_cb()
Date: Fri, 15 May 2026 06:18:39 -0400
Message-ID: <20260515101842.3693613-1-oss@fourdim.xyz>
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
X-Rspamd-Queue-Id: 0799F54D7BF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fourdim.xyz,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[fourdim.xyz:s=fm2,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[fourdim.xyz:+,messagingengine.com:+];
	TAGGED_FROM(0.00)[bounces-247644-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oss@fourdim.xyz,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

commit 78a88d43dab8d23aeef934ed8ce34d40e6b3d613 upstream.

Adjusted as stable does not have READ_ONCE around
sk->sk_sndtimeo.

Add the same NULL guard already present in
l2cap_sock_resume_cb() and l2cap_sock_ready_cb().

Fixes: 8d836d71e222 ("Bluetooth: Access sk_sndtimeo indirectly in l2cap_core.c")
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


