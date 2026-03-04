Return-Path: <stable+bounces-223007-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAgXMSPhp2mrlAAAu9opvQ
	(envelope-from <stable+bounces-223007-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 08:37:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3961FBAC9
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 08:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02A903040031
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 07:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109E936D9FA;
	Wed,  4 Mar 2026 07:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s1nqVhDh"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F0C36D9EB
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 07:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772609775; cv=none; b=aMOx6EBmS7LORxT8QFEvldqc8X9cXRhTyRs4MzOrBWjygotuSHhLPgPheYe0WlE14988PunhAqNzTiyjHsEpqDy5Wh76BNcz564/6Fg4TGeTDiTf05CwuU/M4aI1wqNuiMi7O0ok31B2ecCm63xzJHUnOz2MVjwsysgStZmAY1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772609775; c=relaxed/simple;
	bh=GUi9iRwTf4ZFEs3U2Iil4IHwEQGUGzOmPWn7Txv8Qyk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ivxTb7c9VsL+cbr+y8Ld2CZH5kIsH2an8I/a/qwltgFdc8PU3tzOSWMoVRQuXxFMF7WW2iMOAoPerebQBVlevYYbcaxygOQ83Xp9/wFvJaztMRrStwrG8pt1XCpHTw8xdcLQd4BgQ+h/s3qcTWv/AF8GnLXirWoeZEYXDOwuPec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s1nqVhDh; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3568090851aso37136695a91.1
        for <stable@vger.kernel.org>; Tue, 03 Mar 2026 23:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772609774; x=1773214574; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yrFMT0TXW/spEw/ZubXnVYULM8dGErCPWbCJGWKhVQg=;
        b=s1nqVhDhEZGHYE9uxo3L4+YY1BQ7WvadfBKyEQSoqLnNt3hG1CU4g0Rw5VsEfiVrRz
         lhvRfoalyz6jmvPzZr2XiyIaYG6Xk0qTiI1NV6HTeBhRlQkZAyL7VNciutb+EgsqxO0f
         A0d0Yq4BViSzynqyUxg/dMYNuqRcXjelTBUUT3foP9HUP/OvrrDjH7z8RzTwKeBlZAgt
         NLNvekD1ezxj/kCC6KfKK16rSntZxbFzeeXVnh8sTL63by74jIRVCKzzm3kIY7Yvrs4d
         6CCRtjDyqMRTn//AWMUCng6X9Gh7/HwUxcgcTZBaY11oWvEBVX4kghJWKhsy5mjwsBRI
         APnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772609774; x=1773214574;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yrFMT0TXW/spEw/ZubXnVYULM8dGErCPWbCJGWKhVQg=;
        b=cGu0ubVeOt1nLBIxAxaAuHR+0yferPe5Kt0egJPV66bYASgaEY01mMRsa1vcBcrRk5
         8M7p+OO5fhi/8JoobNydd36x8zoJF3Sm6aoVL4TXRphu4qonkd544WUZAXvalgwqAMSt
         6qp/pdf9rz+sBCyggXW3yrih02FZ8bRDgtpbIntVDKYveHMYc1gwwXegqzwsqUgeib3Q
         F5RKiE/MtzmTkIOp20Gsx1ubRBvCBdraEoOKujz7S8MvT6rxdzDMlNJx7Kfzl1Nqup9H
         6leeVa8/pT8n4frB81TYXgTkSS72EhZDTeAJvCvDZDf5f+/Je4JNluI63YXZRv4A1cky
         p5ag==
X-Gm-Message-State: AOJu0Ywgy31gQ71iabhCMwAqh0wJxUPZyrK4BJWSDfg/ZYMMKII/lwa3
	iUwjETBajJ2r0e/sdc64Zrd2ft6Kkmt1edcl4pTvYSH3alZ0WW4Z1fXT85F4rNYziKM+iPiRNRy
	Hc1KsSoaJUEPZdMYREN/eh+jcKots3YmtT8Rr++SxUGrVWGx1yye70sU45AxzicN9wkJ9yewwM+
	+pNNZkMCA7bGjHxDs2WTfGgEOeKZWo8gdJ+Di85rjTR5pF4MiqcvKeK8jGphdWg04=
X-Received: from pga18.prod.google.com ([2002:a05:6a02:4f92:b0:bd9:a349:94c0])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:4c13:b0:366:14ac:e1df with SMTP id adf61e73a8af0-3982e21120emr1272175637.69.1772609773929;
 Tue, 03 Mar 2026 23:36:13 -0800 (PST)
Date: Wed,  4 Mar 2026 07:36:09 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260304073609.3228532-1-joonwonkang@google.com>
Subject: [PATCH 5.10] mailbox: Prevent out-of-bounds access in of_mbox_index_xlate()
From: Joonwon Kang <joonwonkang@google.com>
To: stable@vger.kernel.org, jassisinghbrar@gmail.com
Cc: linux-kernel@vger.kernel.org, sashal@kernel.org, 
	Joonwon Kang <joonwonkang@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 3E3961FBAC9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-223007-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joonwonkang@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

[ Upstream commit fcd7f96c783626c07ee3ed75fa3739a8a2052310 ]

Although it is guided that `#mbox-cells` must be at least 1, there are
many instances of `#mbox-cells = <0>;` in the device tree. If that is
the case and the corresponding mailbox controller does not provide
`fw_xlate` and of_xlate` function pointers, `of_mbox_index_xlate()` will
be used by default and out-of-bounds accesses could occur due to lack of
bounds check in that function.

Cc: stable@vger.kernel.org
Signed-off-by: Joonwon Kang <joonwonkang@google.com>
Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
[ changed sp->nargs to sp->args_count in the code and
fw_mbox_index_xlate() to of_mbox_index_xlate() in the commit message. ]
Signed-off-by: Joonwon Kang <joonwonkang@google.com>
---
 drivers/mailbox/mailbox.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index d3d26a2c9895..66cdadbd3d75 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -498,12 +498,10 @@ static struct mbox_chan *
 of_mbox_index_xlate(struct mbox_controller *mbox,
 		    const struct of_phandle_args *sp)
 {
-	int ind = sp->args[0];
-
-	if (ind >= mbox->num_chans)
+	if (sp->args_count < 1 || sp->args[0] >= mbox->num_chans)
 		return ERR_PTR(-EINVAL);
 
-	return &mbox->chans[ind];
+	return &mbox->chans[sp->args[0]];
 }
 
 /**
-- 
2.53.0.473.g4a7958ca14-goog


