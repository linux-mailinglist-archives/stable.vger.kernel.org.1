Return-Path: <stable+bounces-247643-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Da4IiL0BmohpQIAu9opvQ
	(envelope-from <stable+bounces-247643-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:23:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 288AB54D407
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D861B3002315
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D507F3AC0D7;
	Fri, 15 May 2026 10:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="YRlZZeDZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tkePoxrO"
X-Original-To: stable@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E5A394462
	for <stable@vger.kernel.org>; Fri, 15 May 2026 10:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778840252; cv=none; b=GoD2txxTO2EiK8gwXK4kkmEKiInRDc3XpB0L6MLIRSS103XJHUlSXzhpz6jyGW5GCWhQ1H7Bwfp+0MIykzJM6xCqpYvGE1UOZaWeowg0Y5BkCOEV8VEUOTyk+e9Xtk9q3mgzk2rd1vAWmMT00wd5iMNaX2aqniiytHFSnE3acVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778840252; c=relaxed/simple;
	bh=OBSPvXaRrxrfrhsTs64tbVj8zcTZcTiu3rvbp295l6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TAkywIlYYpZvrFbWOFsiUVz8ntnHperi4xrGWxMhAjPX/95+W9orv4uHci8asi8HLUmIMhShUwt5LJTUoZmb/X8FNQXEn9BRUUOEhOi+vCJyACLXrNMGrVarPXgsDadFcmcgvAgdvcKvyrYcGxrSWKZFVMFsUBPRGuuLU9ME4UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=YRlZZeDZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tkePoxrO; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 6C60CEC0016;
	Fri, 15 May 2026 06:17:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 15 May 2026 06:17:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1778840250; x=
	1778926650; bh=eUTO1sFEDceL9NhbMHZwWw3LJofuPGNfLgpavY59mn4=; b=Y
	RlZZeDZEK3jeZNp2Sn3Hb5MKMeLLryhUDdhNCzP2immlGdLbPZjM11GhuJbeCDi4
	rlUJMXJ+3wl+DfkdUJCoE+5APOQgDRbt+vABDssXts8pC5Ix84NJSNIvxPch+w1b
	178d6Nny+1DSvkSaDlukGie9kB8qqRZF+ezU6smRL0L6XbK/kPKNTuvSh3KqQFPu
	j/bPHrwdxGY0y1S9irYEoZzRvgQSuYpMD2CK0FOOLa51RC2rTbWgDiOPmDTrOJub
	9iLmyyPq5H9K++TNrIImZSc0nTmFFCIsTq2EhJL0HSjBQZUY4uvGthoKWOMIXRpZ
	BV9CkDfVN/wrY1fIoyIOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1778840250; x=1778926650; bh=e
	UTO1sFEDceL9NhbMHZwWw3LJofuPGNfLgpavY59mn4=; b=tkePoxrOlmP5xJvHv
	7gT3BmQMWHMh+X3UnN94W8eIPYfgWozcB0lExv4nBan/YUUETQ1E1tLCO1aImeUr
	OGzzT+FEKR+M3z71k+VWs7wVeOh9jpbls/08JZpAcs7r9mq2UnC7LNWbnaMoCGv1
	Em/BJupH/wM9Z5F/3vYpQkLAOcR4JEuUFdG1dgWbai2m2UIynhQV4275ia29+6ZS
	Te1bNtTi169FSzgkJ3l+iqMVcpb5Pzskkh8SyP6QO7xI/ioDrm/ncpGcd45eJA25
	yofcfQW/F29C37crlU/bxXPGEMBO49QSPqzcClT1SNBft70mSOb3Gj09ts+bQWJF
	MeG8w==
X-ME-Sender: <xms:uvIGasKZVyTKh-ZdxYXRWW-3K7BC_5wz8pxnS1JHU368IkzlHHWd8g>
    <xme:uvIGajm7GtrTultCQJh8_4BIssC4DY_G4xUCO8-c1ImTIr4DrbdBzwxJrBnXoD-BK
    eFN4Qds8ZewmSP05I76v8wy5gWu7363OzgVRC4-0Rw8FEsxoPAnbg>
X-ME-Received: <xmr:uvIGaqH1oBwXVdZHTbkoLp4qiTm_k-WKJqKekKTsiLGZ8ihFCgpW7LEtl1WBNMCeoBL2IOs>
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
X-ME-Proxy: <xmx:uvIGajG_bcSmblAr4e6vyU7gJD39dWwMMzQ_RIQSWZmR3-GKKhkDfw>
    <xmx:uvIGanPpDWaSW2SUhFn9PRgI2M26pSRZNrWh8F-1cZLX-ONhRHKI-w>
    <xmx:uvIGaiE5P-6Wc8on1u6Eh0CCzwAKwhLn66ribPX2cwD56vYbUIIXyw>
    <xmx:uvIGauMCfvTK9-U-k48loCtjxA6b6UgfGttEF32WMYP64zC56wAnhQ>
    <xmx:uvIGaiXq0kH5Kj6-0VzQxrjzp7NVFqMFNNNmAVu10dOZx9MpKcAQXDEM>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 May 2026 06:17:30 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Siwei Zhang <oss@fourdim.xyz>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.1.y] Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_get_sndtimeo_cb()
Date: Fri, 15 May 2026 06:17:46 -0400
Message-ID: <20260515101752.3692887-1-oss@fourdim.xyz>
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
X-Rspamd-Queue-Id: 288AB54D407
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fourdim.xyz,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[fourdim.xyz:s=fm2,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247643-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[fourdim.xyz:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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


