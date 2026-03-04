Return-Path: <stable+bounces-223005-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIdOMdvgp2mrlAAAu9opvQ
	(envelope-from <stable+bounces-223005-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 08:35:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CCD1FBA9D
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 08:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3428130312E1
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 07:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A65C36E466;
	Wed,  4 Mar 2026 07:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cS0mr+kU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF8236D501
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 07:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772609725; cv=none; b=jy6JUAH9KW/mHyT8/oCXxuAVuqhGL5hxr+x7FS57rJ3b78GC6uJkAVweSqnmjucaiuqOH2rRUV99so6ZurJs+UaZWwiAptC/v2Eu0C4Zg7+fafnU8/p9EbFeCmGmF3F+72cxhJlhfcWZkvWX8fZKP27mYBbe7H1zFzSwlqm+X2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772609725; c=relaxed/simple;
	bh=GUi9iRwTf4ZFEs3U2Iil4IHwEQGUGzOmPWn7Txv8Qyk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=V7D4TaYyKuSDCFAEXy6TMZEx0GUGoimwjropLtnLlTyPrajHJnODRfsNSuzT0ADV0GnOsn6CutEr4E/XZEpDnMyPQBWP7oHm6r6sJEtfweOPgt7Qc1u8zdrl6/NgFTl4iRGw4xwxJLyxVWHM46hnuYNWoREJRtfY+F6I2tEg/c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cS0mr+kU; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c503d6be76fso27264146a12.0
        for <stable@vger.kernel.org>; Tue, 03 Mar 2026 23:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772609724; x=1773214524; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yrFMT0TXW/spEw/ZubXnVYULM8dGErCPWbCJGWKhVQg=;
        b=cS0mr+kUlAG79XsD5cXoNgl1wf8WjyE/x6+NurPI+Sky1rkZe1fEFebfo1X4d/apHZ
         k+SPCDd/2W3yhKiLVys8saGA/azOt9W7BbBKUR4SmTZboVLyX9wDtkgq8TLuBsyuSfv3
         aA5wLOUWnXm7aIdX6GfHwT93NJchXjBjcBIymZmVI5I4y92rCgpq/yNVJplw7lweMn+E
         YkEkmn/AVqLvV9OAT9HhbFYdPdBcYYpYsh8pyJrJAWosdX8wLYUGkn6ZZqexahpujvhq
         e/oWhySubA/J+2GFzrqpW0zeck7TyE5D32l+Ccuv+42d/67oLtwaTnFO+cBkHNOERTUv
         GzOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772609724; x=1773214524;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yrFMT0TXW/spEw/ZubXnVYULM8dGErCPWbCJGWKhVQg=;
        b=WaAKgSqG/QXHOufgsxRYJ/5J8GFVxZe3A1pMa5JWX8q7/5upcXYQfgO3Z3erO1q/kF
         oHv0Xpl+igMVc8bbd77AuIWReBKQe8rShtwJ/OS9syW3L7EL4WvnMIclSr4VGNde4wa5
         LIUnL+LbebO35NUd6p4sPIivige0tPxoHsoOIhUUrCWmmQVu8vy3jAUe6wgn9yvaNky8
         Wi8snOT+6vJOnO/H5I0l6A0KOFl7hlqX1Y5R1GAmlOP7qW8PtYsTHb8EKmwcTek6McJH
         1v55X7wkPF7y4XJDlcYQyqHMpcUGYamg+a7L3GtUQSS/Or7L4Es06Eo3fJNSuHbJ5Rs3
         FG7Q==
X-Gm-Message-State: AOJu0YxL+s1LcsxZ8q3/Clvuiry3cOUzo2mEvWdYo5ZspuKYzJReCpim
	bhG13ceR3WvVqFigC0Bhd/2DGgj0ZzAZixk7x9+0Nk0Kqyg2Cv4LElqcHVWk/WwTALkgMfw6gRj
	a17hlfY6cF7W2FmiEHMpa/wju06UOWEZBsGzTsYpdicYrGPsMAL2jfRCUvhB3jTK26FXaZ0tmeS
	aUz8zHLy+nSTMvpdjKeRntniVbg6cKGAqZFhKEdpR2yApl7ZrmzV7ZG8nCrHPA0Ag=
X-Received: from pgkk127.prod.google.com ([2002:a63:2485:0:b0:c65:e24e:cef1])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:608a:b0:392:e5ab:3125 with SMTP id adf61e73a8af0-3982e20233amr1243999637.66.1772609723317;
 Tue, 03 Mar 2026 23:35:23 -0800 (PST)
Date: Wed,  4 Mar 2026 07:35:15 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260304073515.3227465-1-joonwonkang@google.com>
Subject: [PATCH 6.1] mailbox: Prevent out-of-bounds access in of_mbox_index_xlate()
From: Joonwon Kang <joonwonkang@google.com>
To: stable@vger.kernel.org, jassisinghbrar@gmail.com
Cc: linux-kernel@vger.kernel.org, sashal@kernel.org, 
	Joonwon Kang <joonwonkang@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 57CCD1FBA9D
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
	TAGGED_FROM(0.00)[bounces-223005-lists,stable=lfdr.de];
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


