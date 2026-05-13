Return-Path: <stable+bounces-246849-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OInM5p5BGoPKgIAu9opvQ
	(envelope-from <stable+bounces-246849-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 15:16:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE12B533D53
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 15:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7A44C3064DA0
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 13:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CAE25B094;
	Wed, 13 May 2026 13:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="TwEnZIhG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TwJWHkBx"
X-Original-To: stable@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BBB274FE3
	for <stable@vger.kernel.org>; Wed, 13 May 2026 13:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778677487; cv=none; b=uILPFhyXJihdKtiQxQdGGfWTwq5XvCRm4IRf4E0KKxsOKyxoGCM1VEWUCaZLwca7SdusiQ7jNd2cDjCxjyeE9P1ncbRNi8S6xAZRB7DggJCUGY/CUyN8aeylIHeSsJXiIhIgNVGVsuK56Bwweo+QUpYuY6dVAdml1IFGCkfm/54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778677487; c=relaxed/simple;
	bh=pOAjCEVsOt3sjNrSU2GVZODzb4uckoGbEXs9JNcIL88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ncJOp+kwzYagOrIPwxcfKh2jJV4qxju53cDaCCxyVOzAh8wo/D62mWIjhziV9WLeThCs24zrsXGvNhM72vW2Sy7eDHzU7TTWK4/kP5b9mvDPR2pPMsmgzrQ2qRtXVT/yS0RzIBkibC65OabEDGksNRcsZ7fzS3zA6957W0/DuDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=TwEnZIhG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TwJWHkBx; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id E93D41D00112;
	Wed, 13 May 2026 09:04:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 13 May 2026 09:04:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1778677484; x=
	1778763884; bh=UrfoVDgmukh5MHmyEcxHrBiAtWE/cElCFUzuarcZtic=; b=T
	wEnZIhGimbJIMuBMgHXBZOgtrzGKTPGsZYXbzCvg0nOtQDjSj4C0hmpHV3Tr96Ru
	Z9/I7F+y6Q5diceXR4G0pV6irTI4pt0P9/SmzQJtyVQUSBekmdfbZfB80CBzXcpB
	rZe1cdgUKTaRKR84K/dJeJSwNk4VEhV+XG/16ojNM+fEyEavOEJBLiw0ukWbb1sz
	3hYyNLZ/R2j07AbbmImHcYEV2HipOEc2cYNX/zjEKAXc1/5A9T2JL6j+GCz/oKGj
	qblLq1ob/LhV7EUbiWCxuiyghhNGcGz8gC1OI30DT0ywZlYbTcs/PIMR9gkcRicE
	psoHgALh34AvbXndVjvkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1778677484; x=1778763884; bh=U
	rfoVDgmukh5MHmyEcxHrBiAtWE/cElCFUzuarcZtic=; b=TwJWHkBxuG1pm2oEE
	rR+Fh89bSgK6pi6u7xAxqny5H0Z3bcIV6VLdb7w8kYXOQHcYqrcWJj7O54zsi8ji
	3/1i18UOBRhhVLnVSIFnvFKcXI7NLo3zq04TkAeqlPflT/CsKtU3C6s8tVPYhVMM
	UY3tZsGY2HpLTSdD7ncLWrE88tTZWvRoFmvIKhaUCrS70DkO4tJETnnN73G+SyJl
	jPTg/tFfWH0uKi/Qqey+OWEN496S40u2CJKKNnV1lnjZVlw8uD2Un2x+zlgozD3A
	nMqRvWGeJBrvpwIqWr8MDIlR4H7N9qn6G65vHte4iEyU0tNfartIj7GqVa7ZBQDf
	8FyHA==
X-ME-Sender: <xms:7HYEahO9c-dc8wSUTomiCtdyqRhxDDoxGOCnY9kXZceiZtB7jqsd1g>
    <xme:7HYEaraKfAEARq0gjEeQtWBi2keEvVwG8QRC0DZs8MLYgu2zdFSmh-BULpwjTKxjN
    h-RvLVK4j8MxHz2bi31oT0-iiU3Fh6nQS8DQMZI884KzYSTcqZlvYc>
X-ME-Received: <xmr:7HYEatqb7G6JkFUahhn4WAyXvDaPl0y7kC8BTnVi5VhQme0LWqT4TR9JAusiEga30H90So0>
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
X-ME-Proxy: <xmx:7HYEana7hnC2FFSk_Wo9P_nYTbfsOQHi2VwrXUy7oIuyZdYqwmoenQ>
    <xmx:7HYEatRQ84R21IUJORAExcMXi9TcVxlBiiSAIubeEKypSJYkEe41Ng>
    <xmx:7HYEam5jOZzZMdSTHdVcnrK1Pje0x7xh2EOQUbVL97xSwwa_BhUfSQ>
    <xmx:7HYEaqwz_47OQ-4d_CTJhVKXKPKg7jN64WhO_kyjCsRqtLuwaRT2cw>
    <xmx:7HYEasKekhW2MLIY48Dfx9QbJcVKGuyX8l0xTcWErRuTx4_ZixJWVxZC>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 May 2026 09:04:44 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Siwei Zhang <oss@fourdim.xyz>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 5.10.y] Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_get_sndtimeo_cb()
Date: Wed, 13 May 2026 09:04:53 -0400
Message-ID: <20260513130502.2194212-1-oss@fourdim.xyz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026051217-erasure-slick-6fb7@gregkh>
References: <2026051217-erasure-slick-6fb7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CE12B533D53
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[fourdim.xyz,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[fourdim.xyz:s=fm2,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246849-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,messagingengine.com:dkim,fourdim.xyz:email,fourdim.xyz:mid,fourdim.xyz:dkim]
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


