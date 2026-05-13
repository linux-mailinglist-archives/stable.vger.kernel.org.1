Return-Path: <stable+bounces-246850-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AVWGY57BGpoKgIAu9opvQ
	(envelope-from <stable+bounces-246850-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 15:24:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B4340533FF4
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 15:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7855030D76A8
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 13:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13081382F1B;
	Wed, 13 May 2026 13:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="f42ZQ0u4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pNgPNj0j"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59ACC282F35
	for <stable@vger.kernel.org>; Wed, 13 May 2026 13:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778677542; cv=none; b=ufEKxjnVZPIwRGoarofHMpv6Ga9RKGQN7zuuxvCaq7S6CwA3wHATZ3dDjVIfBIRUt6I+29DgAuyPe3A0OdtEeFpvOPBIMDai8WNIG4FhLsfbk99IMYTt6qKdj+UvBdmVXi287ETtqUb7k4amR3iglCHEYFPUI08X5lBvCbFCUUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778677542; c=relaxed/simple;
	bh=pOAjCEVsOt3sjNrSU2GVZODzb4uckoGbEXs9JNcIL88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dWzom8x6PuIaLs0Iop+zskWtTvdSH3RCNmSK9+3a6B8XyKdN9letxNB2xgMVZAtlfWMxFDmvGHPxw0zTkKqdAwowy8X1HFjYH2YeEFzNDIjzF+6ygPB48WDxBD6EnHK72XceXKSYgz1V9vwiPjz/Pv922RU+zDxt0Raike4a9ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=f42ZQ0u4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pNgPNj0j; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 867017A0076;
	Wed, 13 May 2026 09:05:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 13 May 2026 09:05:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1778677540; x=
	1778763940; bh=UrfoVDgmukh5MHmyEcxHrBiAtWE/cElCFUzuarcZtic=; b=f
	42ZQ0u49FEjel9NmCfS+wh8x44wPgKw0JbeIufHqO7ht2Ix5EXuQDZncrQ35YEFX
	1ixM0n+EvHsYLWzG5yx/pIxEShsr0+XxBn8zEGAsHYDfMI+Lu8RreBXN8hFHU0kk
	276W8hoFckP4Kp5ktsb5sAeeqmYl4bRXT6PXynp7n315dQa+Atc9f+aAkTnTVB4f
	e4fx2NgX0yiERHYam+QpFpVmKJXYKuVDy6XNwmEg82nztf/kPtRcFLdkWYEeZ9WO
	8XRTswGqCzkMuFKOOMaTDvvqo890Zvhm4uAv1tbVbTR3HRmTYyCxpJfd1WhR+caX
	R+YauPsJmG8M5ZXqP1m9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1778677540; x=1778763940; bh=U
	rfoVDgmukh5MHmyEcxHrBiAtWE/cElCFUzuarcZtic=; b=pNgPNj0jlBAFuzaRj
	411UHwH57X//QeEkDvRWkqyqJyqfpcS9++X9dLrZkPB+XfwBHXuNyLZBrRw8+aTv
	4YbIRm1Ji+3Jf4DVKXoaEpiO1DWcvFSXod9uH3Ppn8tgZVXuOnRvEyXVuJKFusiK
	rRaHGt7yoPEFew9fzgS9qF1yjHI+oLT6TVaUtdB0O802PSfq/hDLasN9WkuZi3iJ
	OvCcm51dp0MYQYKqkN3Dd/0whHYvu1q99FKEEjEg8ccU90GD43yAu8169+wrAqVi
	H1IBjqXl9jUn2w7unygxn0Ltb7EEJ6QmsF0xLE6k9/81IjRuuvNdPhxVT1hKkVLb
	lh7mw==
X-ME-Sender: <xms:JHcEaj-FmVZxVzGGxozcJnyk080sImb2ZIjyrc_PYjgvsMKqutXrGg>
    <xme:JHcEanJN-vZqfYBPCkZL0ZR8GjPAFBYXWqVbdwGm23AfIao4IDEBRjGuevnVK_2iS
    XGEPXds3DN_bHRccTW-gHgV4y9O4Ua-OHY5ZRR8vmGTMoOYq5T7qe8>
X-ME-Received: <xmr:JHcEauZtvX928VP-Fc3gKqxvwABfo9Y0yXYrrfTQ_BlbkaF7jjd8UOyV5Ojk_Koy8dvwrEE>
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
X-ME-Proxy: <xmx:JHcEapLyNkHYupnvmG5dW3qvUfFg_IMSZB2zXONyO65MkLMZAMa8Sg>
    <xmx:JHcEasDvTcccnoJRjOLdN3aiUAlBLnM2fEGyq2wFzjSNUN_x-C04AQ>
    <xmx:JHcEauoVJ3Hqc_q9mE_S63GI8Y08SU0Ikrxk8A3nhpFdFFL_QmRFFw>
    <xmx:JHcEania39iVdfPl7wCaa5Af8Rwkxmp_9b7DZwPkzkEuZvhTxN0KIQ>
    <xmx:JHcEav5KP6G5S87WG6ptu22X2vpImuBF74ejKhkKtPdNckrqUty5x_4S>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 May 2026 09:05:40 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Siwei Zhang <oss@fourdim.xyz>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 5.15.y] Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_get_sndtimeo_cb()
Date: Wed, 13 May 2026 09:05:51 -0400
Message-ID: <20260513130557.2195176-1-oss@fourdim.xyz>
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
X-Rspamd-Queue-Id: B4340533FF4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[fourdim.xyz,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[fourdim.xyz:s=fm2,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246850-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fourdim.xyz:email,fourdim.xyz:mid,fourdim.xyz:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,messagingengine.com:dkim]
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


