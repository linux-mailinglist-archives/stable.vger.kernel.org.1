Return-Path: <stable+bounces-223000-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Ib6HsTfp2lnkgAAu9opvQ
	(envelope-from <stable+bounces-223000-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 08:31:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 154591FB9D3
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 08:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B2A83018417
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 07:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FCC36A033;
	Wed,  4 Mar 2026 07:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xKahmvAG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AB4248891
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 07:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772609458; cv=none; b=B+BQR+WU9m/Bop9FQxa7onqqb5Jl5zxZe1mfRYV//JicflI9Px+Nisd9egv9fgFdFdLVthV2sqmU6pX/EqU4PLrAQg8qMvkIwBrptKrtRi/L6zogm3wwB9N0jKgbAP88uJ+HmfCrNOeAdYzl8RpZ/jT6cgC4xnydskvmvcNaEBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772609458; c=relaxed/simple;
	bh=GUi9iRwTf4ZFEs3U2Iil4IHwEQGUGzOmPWn7Txv8Qyk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tpUxMqSkuIGNry4LU0mPo7GqXLSdeveeAQkzQFY6nF0SIPz1js/sy/WeE44RRfHIvquZwqwsyP/T2FkzFzNNdscLlHV1Rqo+gsihU38m4K/gZQNeb2omzVJpiQiPYpXKPfPbHCbUvIdo5IUFDbbVi6m7V34FDcqUW+WXMmqC5YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xKahmvAG; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-358e95e81aeso30837392a91.0
        for <stable@vger.kernel.org>; Tue, 03 Mar 2026 23:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772609456; x=1773214256; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yrFMT0TXW/spEw/ZubXnVYULM8dGErCPWbCJGWKhVQg=;
        b=xKahmvAGyNTXyHgI2vsz40J8FX+CJFNp75lrQarGODGiMRFPym9S0tnYQT/6ge7Bb9
         QuDqR7BCJLYtolVg/qyl4SIO8LO7Pl31jaLSQPwKasg3/x9mAfumjw5SQdxyktzgTmgQ
         3C1ZvMkjuvgLHnU5JTayw+m8/y/oaML4FKJn8vRVxpgYwBkOQFHqcptTBtMscIwsXE0S
         qU963HYxdQWJxoJhi+HWFJ9k/tp3QgRELlzsZU8rI7G75zHPI3+apFrfy6Sln67YPrKX
         Z+jl/QUp+fZQmlL+T43W2JVwqdeszxn/bzpUD4Fhgw3dPNL8mCQnuKAr0SSsxRm/Hujg
         q5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772609456; x=1773214256;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yrFMT0TXW/spEw/ZubXnVYULM8dGErCPWbCJGWKhVQg=;
        b=BI5IW2al4WpFm+aIAcRxA7HQiXsu1wJ9dvwpvISMSE19Iw6uKC8rOYWrqBgwYKgPAo
         ffuvZF0MmrxodQppZP+Cazw2s/hureEp0B/pJf6wPYp8ROm6M9bBrjfD9CH9hT7L7b29
         ZBppWQn5tSGyy2GuS8Q+ev7p2VlwMdN0b712/DAcvMcWJ7YpGn7zotbtwpDth6nV1bp6
         +oJ3P3sVAJ6CWJWyf0LNf0EnkHS+NyJEBF7/WBxWQWWEYO5dgTwTOgxPlTyle81ZhiOP
         iirTcZ3AgN+bLBQ65duY8ZIU1aOahF9q6+wW/INoFCNKbtr+D9Xx6TeNeQcTyVAS1o10
         gqHw==
X-Gm-Message-State: AOJu0YxdeGDE91Q41hmQcYo+SW0RQLBYJUnwSkwclSa+sNnHENh47OdX
	k6I6n+1z/Bg20NUgOBuxMrQMkFWPu9iIFcB07P5D9yin54SH11E/v5f+Ayrua9Tu+0lqrhC8Rf/
	sc1Nju7zlGpPNf82iBJKyioKgqh8IyKp7PJai41abdwxwPsl/58zUJNHoitnnYRtkpXS3HpnpjB
	pv20wlIqki7sFtdXMMaDlRlsdrenMqU2Olrnhj3BezUZSNf4z0PlZdUC6jDyDNkSQ=
X-Received: from pjbx93.prod.google.com ([2002:a17:90a:38e6:b0:359:8242:e73d])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3952:b0:339:ec9c:b275 with SMTP id 98e67ed59e1d1-359a69aec32mr1270980a91.6.1772609456213;
 Tue, 03 Mar 2026 23:30:56 -0800 (PST)
Date: Wed,  4 Mar 2026 07:30:52 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260304073052.3224244-1-joonwonkang@google.com>
Subject: [PATCH] mailbox: Prevent out-of-bounds access in of_mbox_index_xlate()
From: Joonwon Kang <joonwonkang@google.com>
To: stable@vger.kernel.org, jassisinghbrar@gmail.com
Cc: linux-kernel@vger.kernel.org, sashal@kernel.org, 
	Joonwon Kang <joonwonkang@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 154591FB9D3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
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
	TAGGED_FROM(0.00)[bounces-223000-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joonwonkang@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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


