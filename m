Return-Path: <stable+bounces-223006-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFX6CgXhp2lnkgAAu9opvQ
	(envelope-from <stable+bounces-223006-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 08:36:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A98D1FBABB
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 08:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA491307EFF2
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 07:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B021371869;
	Wed,  4 Mar 2026 07:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EaSNec+7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADEB36D9E8
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 07:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772609746; cv=none; b=lCfeyqU7n/c+pH3TozWpYPArM5J3Us3c6i/1WSULLcaoxo3bqvu8jboMUtl44woOzZAuMNBHyGi+z9g//eSwxwhq/AnGDmhworsCQtPgpBwdgwjUINbBegaI9aHRVfxkXIkJlQhiUkaqG7ABC298p3XAvDK2DuXl6WX+RWpevpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772609746; c=relaxed/simple;
	bh=GUi9iRwTf4ZFEs3U2Iil4IHwEQGUGzOmPWn7Txv8Qyk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tFAXqTbxy2sEv5esofmS/cFltxNZluJ8i/lpcNJ7BJIPFqjWmaNWczqjit1jX05YBXyaAPEVc9gbLR/z6MZPPCmsnYyUSd0+9jx/1AMxA/cuoEqu7+kmN7i3FxSVO87k2aLDIfmBAKyw4K++I6qciBdvLffkVG0NVTmSGFWa5Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EaSNec+7; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8273937bfa8so2717524b3a.2
        for <stable@vger.kernel.org>; Tue, 03 Mar 2026 23:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772609744; x=1773214544; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yrFMT0TXW/spEw/ZubXnVYULM8dGErCPWbCJGWKhVQg=;
        b=EaSNec+7E5RtJh2mEhqE+BlpT9Szd1Q7GnxcYsc2ROflWyx1KnmNTC2/nYV8SUlgXy
         8iErm1y0X99O5o6DG7JUaBoycFImdYJhYxwrTJKCDyDHJeF8hCQmek7t2aSa/5pC/CtS
         SLZ5fVfQoxfSe7sOdeqAa8jhqT+HvQOlpeDsuYEiyQ9ZYnAvcnf+0GwFYZahtpJw494x
         dZamhcTP0UpVltveH5xsaqVlNpj/Z8xDjN0M3lO61xyNTdysMJZyXybenq/rlwbTq4I8
         2RcH/cuD+DBfLkk78KBNi9DbP8XTGmgy6wdTj+Zz4gfWvW7Z6hV0v5B+Kl89f6SqkGtr
         UjRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772609744; x=1773214544;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yrFMT0TXW/spEw/ZubXnVYULM8dGErCPWbCJGWKhVQg=;
        b=fgqt2FKXj6eVbgrKxJvl91Iy6nUPTFJ1sfmMVpx4wEQCNUiVe81GUMw3caQV8HaqDr
         HBCDY8vgeU1+EHrN1FPk9QpD9pBHtWLSLMSbNIdGP+WehxNYU6/TfPLUTPYpRTVEfro6
         Fk7llogF1sFlX0kgoKY2WQFde+mbHYlwpTY4LXSs3yynDp9g7Ie+iWaEUuMvMEVYS7AU
         +npjffuVBF0xOlhCQwzKf3WKxdhvaSA0kwFSvy0k3OaFIcGML/xYlmMuXGRznf0M/d6A
         4NHIbjNte7bPQzUWIozLlGQEbDpSaz7zdorhcd/fubNUtz4aCYCJ+iTivun4zPJ1Pzm7
         g2Pw==
X-Gm-Message-State: AOJu0YyqPVqK+3qRLTv8O9GThKsqg/uPObj35mbmT3XH5oVZhw3u6WCh
	XtSimaLJ4RwTo/KiQbF/UVl7p9pFhkuZ6sCNCZeMMJB9maFrVPHH1Z3bRYp3e0x0NijtU1DSu46
	D/Njpru4q5R4KhKpuS3iIuo7TIq7MTakm3HnKSGMzTdBYlx36yWLxIqL8l1XjFU0lBdpzK/gZoT
	Xjg94S5iTpulHjUpgrMqEiqn3NyuZGHb6N6oubDFb7UjnsFDjRwnalRzXA2QN4AgY=
X-Received: from pfbdf5.prod.google.com ([2002:a05:6a00:4705:b0:823:1513:f42d])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4f8b:b0:823:1c2f:e9d5 with SMTP id d2e1a72fcca58-82972bcc3eemr1222981b3a.26.1772609744179;
 Tue, 03 Mar 2026 23:35:44 -0800 (PST)
Date: Wed,  4 Mar 2026 07:35:40 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260304073540.3227944-1-joonwonkang@google.com>
Subject: [PATCH 5.15] mailbox: Prevent out-of-bounds access in of_mbox_index_xlate()
From: Joonwon Kang <joonwonkang@google.com>
To: stable@vger.kernel.org, jassisinghbrar@gmail.com
Cc: linux-kernel@vger.kernel.org, sashal@kernel.org, 
	Joonwon Kang <joonwonkang@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 9A98D1FBABB
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
	TAGGED_FROM(0.00)[bounces-223006-lists,stable=lfdr.de];
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


