Return-Path: <stable+bounces-247645-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAiCGDb7Bmp6qQIAu9opvQ
	(envelope-from <stable+bounces-247645-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:53:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D5554DCD6
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7744C30C198D
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A7A3CD8C2;
	Fri, 15 May 2026 10:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="K4k75gnS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SO9xh5+r"
X-Original-To: stable@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AD73AB284
	for <stable@vger.kernel.org>; Fri, 15 May 2026 10:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778840361; cv=none; b=fzHLcAOu9MvPxx9snn9rWsW5dVyP7a5Ym5WrTbU+Q7uvDuQzol87aOyulSZqPxq7y7iyqrvRs7ASffc9l2t3NGdrwff5BlpwqS6y5BfFmhzCWZa2wkRopAFMiCrjBITFdNcxUbjZGEQos8h7luI21KXtJmNq+ocibGpdpQ9eIy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778840361; c=relaxed/simple;
	bh=OBSPvXaRrxrfrhsTs64tbVj8zcTZcTiu3rvbp295l6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t0PDmhfaLij4J8HrrWezBEXwTL+sYoLSu0EK5+J8oOLkEm6MLhfkFZxIrvOB/Htt5dqW4JgsQo5+IB6J6mGlY4h6zzX/Q31ul2kmeyBfSBrP9IpFEiCIsG9uPf6/iF1Zt7KRH+HaPuaTZVkCxAy2hvpM3ZZTGT3NihE1l7tFjiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=K4k75gnS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SO9xh5+r; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id E1823EC0175;
	Fri, 15 May 2026 06:19:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 15 May 2026 06:19:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1778840359; x=
	1778926759; bh=eUTO1sFEDceL9NhbMHZwWw3LJofuPGNfLgpavY59mn4=; b=K
	4k75gnSuG+eMPEfRezOSpkUCnH78I4d3G0G+SaZbgwlwBnnczT6BRh+4W9tsezVr
	KeTcJxRONlxKh8WJMOOMmq6XbPhSQr8bzUEz9ykeMb6NjohXJfKWBXTOwYd0z8YO
	N30c7lJdEv+En8TbD1PQR15iQNkN21zgL2oBCe0NM7hYieqvZxIpn9puZqmCSLkV
	2dTK9qCf/4Z344u8ygqPM1N7wQ4sieeHhtVpCTGJtJyt7KbidnaaOtljlufhVzhs
	euTNTg0qcUnHxfG8ybi/hEZCAKKEv6N0Ha/Os2cbWSZpih6F5jKJZonKRXUDJAHt
	EshLWVDWZ62V9ndFG48tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1778840359; x=1778926759; bh=e
	UTO1sFEDceL9NhbMHZwWw3LJofuPGNfLgpavY59mn4=; b=SO9xh5+r8V7qzn3Ys
	tw/uh/wpZ0SNmTj/Bmjc0HJc7Qvki4QBI8LJT3hE3fV5Gt4ON6L8VQOh8vXrv/HI
	SzsdgcdBYlIqG5TyU2PX8rM7mrW3Utq6jGVN1bfhYVXNnq1BvHkWEtD1/WNuWeib
	DZJJ2U85wNZgWOhokeWTCI69D3XX/q97FDr/SRcJ3sFLmJ8uvCSngFwBMvKqzLSR
	kGh6VBkFl+oCnRsHaUp79/AWCXP+wtgCfS+kTHZ2kouLw9S7p1XMAFQToPIYX7H8
	bewu3JHG+k4Ndv+Q7GR38S0dgNRvGZugdZ/44NlvuQGxXuY2q2h+qA+jgLTljy44
	CBCrA==
X-ME-Sender: <xms:J_MGakOIlSUEdUrMzWiqlpTcyfkXPionmaWu2liqKWmTz9O-TVPgSw>
    <xme:J_MGaiYurcIY7WAH5ePAFb15xlear5lc53vk_ECMnzFzsRczB3EuMvcSnvhUxlhqb
    0crBk5tEWdy2q21fk8Qu6I49ag-we2roDZ4CvAPALJGuOc2tffEEyU>
X-ME-Received: <xmr:J_MGaorSuC5OOyE1m4BNIALi4V3xzcSM50iemyKsxkrwNBgd-0A9wDm9DJaQmOpxibbxK18>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufedtudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdljedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpefuihifvghiucgkhhgrnhhguceoohhsshesfhhouhhrughimhdrgiihii
    eqnecuggftrfgrthhtvghrnhepkedtleeiteevueetudevjeefheejueevffejteffvdeh
    lefftdffleegleduvdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepohhsshesfhhouhhrughimhdrgiihiidpnhgspghrtghpthhtohepfedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepohhsshesfhhouhhrughimhdrgiihiidprhgtphht
    thhopehluhhiiidrvhhonhdruggvnhhtiiesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:J_MGamYk3J0F3KNq3URajsa0UcjBKi9DpoiiTSl1PjPlIY_yncdhHg>
    <xmx:J_MGagSf2GuRiq12JThB7PS3p-vbz1bLweDYCTOM-VsC_1iL3wwNyw>
    <xmx:J_MGat7NWqTnfuh0fuHvVIJ-AR7DFnjdZSkV36b5FzGDa95KDKHEPQ>
    <xmx:J_MGalwlGko7oHgYtJGwN8ISbCC7n5mdgdcgEvsMmGxND9G5lJvQ3A>
    <xmx:J_MGajK4p4oxgHmE4C6XknuNPmU3VopBACJmF_HifU3tIPTeB5MaKEI5>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 May 2026 06:19:19 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Siwei Zhang <oss@fourdim.xyz>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 5.10.y] Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_get_sndtimeo_cb()
Date: Fri, 15 May 2026 06:19:40 -0400
Message-ID: <20260515101943.3694443-1-oss@fourdim.xyz>
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
X-Rspamd-Queue-Id: 64D5554DCD6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fourdim.xyz,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[fourdim.xyz:s=fm2,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[fourdim.xyz:+,messagingengine.com:+];
	TAGGED_FROM(0.00)[bounces-247645-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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


