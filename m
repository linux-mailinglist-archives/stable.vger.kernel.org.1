Return-Path: <stable+bounces-223003-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAmdHqfgp2lnkgAAu9opvQ
	(envelope-from <stable+bounces-223003-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 08:35:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1301FBA53
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 08:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 250373031AD1
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 07:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E93936D9EB;
	Wed,  4 Mar 2026 07:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XEdZwzVp"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ECA35CB7A
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 07:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772609698; cv=none; b=eeZrI6EqovIhkxWStbkg8l3Avj7G0iwtNXNtsHhs+mgyLHV2sc1OaNE9g6wwKZiNy8X1ZdnmAM48TTyckKAq6NxHv++QW2KhApvyS+3WwDUaob08ooQy2NYxvKwSbDYeLkwozg0qHWAfJMXZVMnpvEQgR8Ks3aotqSlCG3jKFTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772609698; c=relaxed/simple;
	bh=GUi9iRwTf4ZFEs3U2Iil4IHwEQGUGzOmPWn7Txv8Qyk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OQmOUzjUFbtzPnbs3Hn6rBf6deF5jQJehC29H97DeEhgZaBk1RL8IX6oUJQxwiGywZNlX1fbR11/GvbxuHWmMGyfrMi6Iryxh0JfgbPHcos/GrRqEUZFCj1d8bQb323MvPiX/LpoxZpGHtIoDRKQm3DOPkoGKm9yQ1ciy+nTbSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XEdZwzVp; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ae6961bff0so28936735ad.2
        for <stable@vger.kernel.org>; Tue, 03 Mar 2026 23:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772609696; x=1773214496; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yrFMT0TXW/spEw/ZubXnVYULM8dGErCPWbCJGWKhVQg=;
        b=XEdZwzVpD6n6TAzdbeeliHFm7usZTO0f4+Ft48vD+16GiRoupwotL0tfDVZ0xKR+Iy
         lkWy33fQtbLz/5ZMOPNOAcrALbob1saiz4JCGs0DoiBHQUGLQ0dOzeLTKPZ1A/Xg6LuC
         yDHW8EoF/DgCsmSHG0Z7/Ms22QAP6W4EMDXIcJ082e9KqQIaVdGW5tkhwp/h1BEgJfsG
         1i9Yotu9/Se139lNrKKIcX7BbN5tmyXSewKD+VQByRj2GvsYRrBOXuPbH1Z6z18wAKF9
         WoXte0OTdpLLCvrpc2mbd6eNKgqRGKwdYx0WGltdTNqEdQ/HpNtwI8VDGp+C1PGX0tsh
         awfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772609696; x=1773214496;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yrFMT0TXW/spEw/ZubXnVYULM8dGErCPWbCJGWKhVQg=;
        b=BPqKpe9sruln6WFgHaK1i2DuGtcl5Un+wFx/cJzG3PSDL+h9hVY+h8vCuHLkvKluhQ
         +pByHXMcEEj5e6X0SwEIny3ZP3Zia9CeU3Pa2R8O6PXBTCmZSwCfyUCkKRTtRcSDIynC
         t26gyX44cc3Jwo2ZnR5u20FjfC9A8sNek3XPhWQPNW5FKhujIbVQSWcxUDrnxwPjIY+h
         E+di/UvMgZJTfzLxaVSPQ50IXw+gaQt+zrfLs5WmzaXAccdJquFsyTp9DxAGeDgo1dxE
         jVlFu5Aw6QnUQdbEPPoIoBcSGEToXxUj1M5mlQR0ANgrlZDga9dhDegNtoplr/mnmswz
         THYA==
X-Gm-Message-State: AOJu0Yx2LIu8CKzQ6ZvHQEvQUF+8h2yCWAlDUn5StdIFTdGcBXqj90cf
	KuIT5qKvlUwEGzllHR8hUIUIg7NMwcXo+kjTExh31Zie0S4qnPkmubHzT969MlT9vJSTIQtwWv1
	F7/NV8f2yJCemIrspRWBAq6prPuw/ypEZOI5Qzdk4k07kiSMtPASTHbK0CWv29AeLfeixlW0JOZ
	lhM7fyB3Eg5yn2mTihhbAsIYuPrEmAXiangGwwT74gqaUvSdRyLgFL82B8C2AgUgs=
X-Received: from pghf20.prod.google.com ([2002:a63:e314:0:b0:bac:a20:5eeb])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:6a15:b0:38b:d9b5:5de2 with SMTP id adf61e73a8af0-3982e1b27demr1164593637.50.1772609696104;
 Tue, 03 Mar 2026 23:34:56 -0800 (PST)
Date: Wed,  4 Mar 2026 07:34:51 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260304073451.3226917-1-joonwonkang@google.com>
Subject: [PATCH 6.6] mailbox: Prevent out-of-bounds access in of_mbox_index_xlate()
From: Joonwon Kang <joonwonkang@google.com>
To: stable@vger.kernel.org, jassisinghbrar@gmail.com
Cc: linux-kernel@vger.kernel.org, sashal@kernel.org, 
	Joonwon Kang <joonwonkang@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: CB1301FBA53
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-223003-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joonwonkang@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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


