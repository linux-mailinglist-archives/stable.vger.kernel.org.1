Return-Path: <stable+bounces-247642-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBl1G/H5BmpUpwIAu9opvQ
	(envelope-from <stable+bounces-247642-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:48:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF7154DA77
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 47DC6302C0FF
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C8D39B4A6;
	Fri, 15 May 2026 10:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="e1+K4Lwp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZC2QXTRw"
X-Original-To: stable@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7558F346AF8
	for <stable@vger.kernel.org>; Fri, 15 May 2026 10:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778840178; cv=none; b=ApkgFbXXxQNQ5i3/jqPNa2JrQM0Yt4I2e/U7MRh/HTQsIjXN3WcHrazQzPZLZL8bLDWwChCO9291eL4wPPLFEb057x1P+yN9Yq4P+K0tSkalib6SErV4Pcv+XC4OJucnSdyC6fHDbOjRQTQJdmuRe6qbMk86ydqRA8NwoZsCRNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778840178; c=relaxed/simple;
	bh=OBSPvXaRrxrfrhsTs64tbVj8zcTZcTiu3rvbp295l6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lhDYoHl4b5E245Ai966H/o6mnINZiJl+LgCkDkU0yFen/D5nxbt6ar4Z0vuCFk35SsOiKfrEaX+x9aqAJ3EE4gJrnJpd1Uhhl+uwhroaIdF3zUspEzCZn6Mfpwq1tNy9TM4uAjg+Rd163e8kHh4G9HZSotqomLCYJ2YYZZ0szOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=e1+K4Lwp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZC2QXTRw; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 9DED1EC0012;
	Fri, 15 May 2026 06:16:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 15 May 2026 06:16:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1778840175; x=
	1778926575; bh=eUTO1sFEDceL9NhbMHZwWw3LJofuPGNfLgpavY59mn4=; b=e
	1+K4LwpX7oovMakAQT8iZE/d0fb0A+kwxEVqJs5zc22P7B9BFev+JCy9zdK3NUsd
	I2qpYKVTHd99DsfEf5AqIwb+9m/WXIBfqsSjt6t8tYIrP6AQMbg97Cqg4wMlDG6u
	L0cIrFeczpis5TVkcn6lmZNy2kUaNKuSSOrVhnUWxpgkLsofYHgc53HCwIVM0UEA
	+pfg/hrm7MGLl6HPK8XR7/pHSQWy6mFwDT/sEemXlWhREtYhsvFckPiNcne/RUNd
	BaWMdBmSkoeoMINmzjlHRf2ubLTXRBSt1iAecPqMZiidYj6CxqBiTnE0xkH5Gkfc
	Id/ABW7SgdHP7KIZECalg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1778840175; x=1778926575; bh=e
	UTO1sFEDceL9NhbMHZwWw3LJofuPGNfLgpavY59mn4=; b=ZC2QXTRwIgFLkTzIJ
	8VBE+fjndkz14FsKDadhPH8sA+v4419LdnOhbmCo5F3SOfvSRFyFxGn2vZFPpVd0
	TesrgVy69NCFRqwqyu4H6sbwWEQONUOlFffJf7/IAPdNPQJggANftg43sD3MV+j7
	GDcAkc/k+L9QnyRrpcGtzXnk0Xer1SCFs5S/XmCUuRGuUfLmdl+4DhQvmWf0AQKU
	FBIxhOVzM8DZN6Q8bEgN/BZQvIgqdG5yduFBiPbYmFBshMtKqZ0uiTr5foioDGMj
	n7732GiQU8i/mffa6ErzWPqM2inop9J52xiTM/PlNqYDnC83oanDG5yJVOoWorlc
	AbbvA==
X-ME-Sender: <xms:b_IGauJ-CbyC3-PUy2zGxqA76QVTDi-kn5399Yzmxl7VPQRO405ElA>
    <xme:b_IGatkJND6542Norxg1GOO1DPA38GEJbybdZTDQOp4wFaAc0NuoCFFecVEkgxXOU
    atmcJq3H53OA9VaYuyf3TNa01-4xcDvIDzuapEJWQ_BXHw8hMn0Xps>
X-ME-Received: <xmr:b_IGasEvi7MWnAD6csPhyuLIsEDhVFltHOPnQ3Kt_Te6AJjjoX8CTu7r-4lZvdVHuGH4iL4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufedtudefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:b_IGatE-4cs-JACCPkdIWZ8VBDsZwZ_mk3WCPZOcnH5Bqn1KkbPNXQ>
    <xmx:b_IGapMAZb5d2AT87TejkuIKnSvIRffB9uMrGlpEke0qrUV-cxS6AQ>
    <xmx:b_IGasHRmtsiJzkl0ctSybtswxgqRIxozsYuPiRLT3KuLo9X4I-hbw>
    <xmx:b_IGagO_HcNTuqYY_41IlZL0R46MflVxdTI-BZw23LzeMTEeS7OTOQ>
    <xmx:b_IGasU8oVI7CfxoMXcLALK4pk19kGyj_y_lSCF9ajnV2Ohv2JuTzKgT>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 May 2026 06:16:15 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Siwei Zhang <oss@fourdim.xyz>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.6.y] Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_get_sndtimeo_cb()
Date: Fri, 15 May 2026 06:16:05 -0400
Message-ID: <20260515101618.3691622-1-oss@fourdim.xyz>
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
X-Rspamd-Queue-Id: 6CF7154DA77
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fourdim.xyz,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[fourdim.xyz:s=fm2,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[fourdim.xyz:+,messagingengine.com:+];
	TAGGED_FROM(0.00)[bounces-247642-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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


