Return-Path: <stable+bounces-247646-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cETiIiz3BmpUpwIAu9opvQ
	(envelope-from <stable+bounces-247646-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:36:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF89754D74B
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9008308489B
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBCC3CB8F4;
	Fri, 15 May 2026 10:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="fRHvirMn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uqOZ2T2f"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D22B329396
	for <stable@vger.kernel.org>; Fri, 15 May 2026 10:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778840408; cv=none; b=FVaezyqda38mBDoCnmhtz7I1ecQ3c73wZQEARpHd7+HzMeZJN6I1GYvUrAWtpjHSnOsaswcUguhm1blwXSiNvDfB0ljHhmRMI50y37BG0cU80WgdCrGmPcoc/Jui/a7NwyKUPXbsmqX6l6UZ6jJJwmH+FbocT/7iEk2FSvAcaP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778840408; c=relaxed/simple;
	bh=OBSPvXaRrxrfrhsTs64tbVj8zcTZcTiu3rvbp295l6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FDhEDOVfvgMYA7VlI+x/mnzCourAFERF/z/bzJuO7X7s7NWn4HDhIxapMSpeTvxewyYGXOtg4uDntd+SgruRavnb3POz1cZfbkcVEYRW94F4Aw04jxXMejPguU9MjgATTbPCMrYACxgw3K9SBAYHGiwC0mLPC5RqwUek4QMJUoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=fRHvirMn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uqOZ2T2f; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B7C3D1400138;
	Fri, 15 May 2026 06:20:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 15 May 2026 06:20:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1778840405; x=
	1778926805; bh=eUTO1sFEDceL9NhbMHZwWw3LJofuPGNfLgpavY59mn4=; b=f
	RHvirMnQP6141sQ6ATLQaZ+AGA8Y7muPoc6RQdh1lsN90a1/fPR6D6wfqn0rQVyJ
	bDRiNfdOSsLBleyWwLpYdd7o2Z5hNNaaiHMR04uK5JS11LGCZq55U1qgLL/J9Oy7
	MknSo8FqMr8rjkYx+e5cIe6eyniiVGeTcWDJ7jIE6ajrBwmWOzE33EerYn7s4xtV
	i4R20evFENk11eYo1Id/pdLJyBpaNWrl+4wq6yC1icB9V1ZmN/WXhQlVreftOGEX
	7VqYxWdaM16/M/f7ojBtpqmKqCWeIGCevevoNzmUJkKgVHHMWwSXsBSeovovhEDh
	r2YeNHWU7yuyQqP9wAVdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1778840405; x=1778926805; bh=e
	UTO1sFEDceL9NhbMHZwWw3LJofuPGNfLgpavY59mn4=; b=uqOZ2T2fy/ZnKKD7P
	tiGvp2/rv6Qo6WtRfC+VMuCmXdRPVjv6xuxqpHKIhqcJ5IBvgYLOa+eRhZ6NtQJm
	mtTYKlX41eCgMpYn2VrBqSYi5FQasRQ2jHiANlSqnJIbon9cPgHDJMkj7JW2ydcV
	xHEutddob9PWXNIfBvtZLy0kBrtciMzY/KyYnyQ3Vd6BXxWbzgC+FpDlJcuL6qXk
	Uq6+gTUGJraveyMDQhafRKnP0FPUwvxlF2WOBYYkmoRRG6bjcAUhmfCs4b3lAIWO
	oSfLLpN2vvDhzDBZpV/wIZgx0v79AaKVr4UcRtUjRDcvs8Ee3ME0jUKH1rfLgvA7
	2BXAA==
X-ME-Sender: <xms:VfMGag_dBzzan7E1w8JdzHECAsSguhmSoGphf7ez0Y4lthoqO60oFg>
    <xme:VfMGagKRmh3mvtYRWGU3lG_j286ZEzrO56gBtgWyk3n7UzvKXgonPULtdQDKtmomZ
    CAKIeTi-cSADRHfgoQgIZ_VKSIjQzBNKd7SSNNlMXlbbfVuIEZfmA>
X-ME-Received: <xmr:VfMGajaSbReZCCDIbaLNoWhMo2RySIXhRveoLEtwYo7t8HuVMLZyC_VCa4N-v-a6xB-7uak>
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
X-ME-Proxy: <xmx:VfMGaqJIlvFcWDCxNYOOSyJJEMIaitlrhTZtNZE1OBejImTM4nY60A>
    <xmx:VfMGapD09739iENimdfLKLw0xwzR-MAvQRDLWMNfQjRcoiAGv8purg>
    <xmx:VfMGanoCngeS_BS2IWE0ByqkF3-40D3dueOVggYj-tl-obywirl4ug>
    <xmx:VfMGasizy7Yz-xH5N7aNNGPrF2-1nUahV8b-JjyEty5-1MjbPyhDBA>
    <xmx:VfMGao54gKZbvjy8eA9u-Hql2O2OUnr6rucJs05y_crfxpfHDgLJ_QOv>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 May 2026 06:20:04 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Siwei Zhang <oss@fourdim.xyz>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 5.15.y] Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_get_sndtimeo_cb()
Date: Fri, 15 May 2026 06:20:19 -0400
Message-ID: <20260515102024.3694989-1-oss@fourdim.xyz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026051217-footing-cement-0817@gregkh>
References: <2026051217-footing-cement-0817@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CF89754D74B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fourdim.xyz,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[fourdim.xyz:s=fm2,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247646-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[fourdim.xyz:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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


