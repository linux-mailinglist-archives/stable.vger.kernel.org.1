Return-Path: <stable+bounces-223002-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOkKDXLgp2lnkgAAu9opvQ
	(envelope-from <stable+bounces-223002-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 08:34:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4D71FBA28
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 08:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12D28302570B
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 07:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7688336BCF4;
	Wed,  4 Mar 2026 07:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nbMj8A0p"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE2134B1BE
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 07:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772609647; cv=none; b=ZY8ScdkQIf85hXi1j6+i9z2U0DjTZsknTI/OiWYffLZ40xjdTPY+NJfUGOd+mjPRzdvHc7aaUoYegxF95LPLwkJbxyTCQv+mect4Q2cnoIirf9ollLtdoMjxTzcaGixOxpc8KO924yhan8XKP/rwLldBqc7/7RZedT15K/Z8sGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772609647; c=relaxed/simple;
	bh=GUi9iRwTf4ZFEs3U2Iil4IHwEQGUGzOmPWn7Txv8Qyk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mSXPLwR+fy+97XQQv2V8OWVKJh7qWUcYRxPuTrJhX2HIE+3grG/GMSUoXOlEPHIRmRKhwfI7uXZEnBMydimqGVo9n8jgtiRIDtXXOZV3yn0oC3MbeaK8sdLcXHDcyEN6WuoAWi3XfcEMSQZ/d7CXX2SAPmmPggQQ07SptzSNFwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nbMj8A0p; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b630753cc38so31282130a12.1
        for <stable@vger.kernel.org>; Tue, 03 Mar 2026 23:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772609646; x=1773214446; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yrFMT0TXW/spEw/ZubXnVYULM8dGErCPWbCJGWKhVQg=;
        b=nbMj8A0pEowN8RwlrUlGG/6JGYCNn3mQyNi3mdEeSnxHDx9eQbutgU/RUMLBG3Odw4
         nSfNnCRcE9t+fd3uqKYBj+31M2R5SHMv60xbL4vAE3XOp/OFHuKU35GlR8cjaKNNPDtg
         i5POUVFm8M9Bf2s7cddfYM2hxm5yfXpWgclJCNkqvDE38ao8t/j3KtAFk2f6jHFcLly3
         wfE3CaS2+E8YfIq7bhJ5xejasFt3o7WSbBvPAcaUtlfqdm2bagAZJO/WeW1Wc41XICP4
         UILJf58aza0TmbFVH5qQJUaaAEZ2DGsK57xQ/xnnRUnBtehsiNYr7a1nZUDiA3UL2SBw
         j1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772609646; x=1773214446;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yrFMT0TXW/spEw/ZubXnVYULM8dGErCPWbCJGWKhVQg=;
        b=nzswib+V7KScGi8Q6KnYUbamu2f3rpDbEaRIB5cOoWtpt3A4q6rhnoXnKr+l/4NJC4
         rC/xHI7OrndKNvhB8CHrtAAG0ch8WvwrtyedKdVJSBx0BEvrKwewQsiVhDjNVGOLxUH2
         V+echWB9e1MPVLhWaH7sMuN8wnb19gW5/jgAgbcMbnwdZNesMMKO0HT2k8FVX4EG+Yr/
         OQFA+5dOFIDQMLh5/k4eJvTZJ65n00PC6JWNz257CVQLVJ1juxZB42E+Kbh5zrK+2XFr
         f9b6u7an6oLlAtaiihp2mVoi/Kazuz5pXNx2qDgmORwrH3J/4LbupXWFADqkTP9+oGH6
         tdrQ==
X-Gm-Message-State: AOJu0Yyx5FjUrtI20/4GQlt/IvWPqOm4cwzwd5mU0a50UkRiqJsu7SYs
	p7Y5+RUCLcDFp/3jCQr5wp1N5dwBWjhrEDaZNaaROJB3ZQacTIciBGpTrZue998MpVEo/h2r5W5
	hrgq/OrZzNPsVNu6qrmnFGC+IehZ7RIB6OxHmOefLdFIlSr4h5tg2A1SjNwsdWjHsBaICXrPgUj
	YuK5xj/HSfTD+tlJpVjcw76qhT4g2+g35EHpyDXDzVsOfE/zD9iauiU5k6SqARTY0=
X-Received: from pgvc14.prod.google.com ([2002:a65:618e:0:b0:c73:7fff:ccbc])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:a124:b0:366:5d1a:c737 with SMTP id adf61e73a8af0-3982deccfb6mr1136843637.16.1772609645297;
 Tue, 03 Mar 2026 23:34:05 -0800 (PST)
Date: Wed,  4 Mar 2026 07:33:59 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260304073359.3226109-1-joonwonkang@google.com>
Subject: [PATCH 6.12] mailbox: Prevent out-of-bounds access in of_mbox_index_xlate()
From: Joonwon Kang <joonwonkang@google.com>
To: stable@vger.kernel.org, jassisinghbrar@gmail.com
Cc: linux-kernel@vger.kernel.org, sashal@kernel.org, 
	Joonwon Kang <joonwonkang@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 8E4D71FBA28
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
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
	TAGGED_FROM(0.00)[bounces-223002-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joonwonkang@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
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


