Return-Path: <stable+bounces-227485-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMXxBgoMvWkO5gIAu9opvQ
	(envelope-from <stable+bounces-227485-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 09:57:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B35722D799D
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 09:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A675310BD27
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 08:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5853E375F7D;
	Fri, 20 Mar 2026 08:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jIUegXOV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1723375AA1
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 08:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773996921; cv=none; b=OUNQht1QMVmR99rUdAr9MEXRBRcwrRfLvoaAg6AdgI+kad4GsB9zTWVNvK/U1Rb60JUnJwEwM2ptI7wJQtQSL8lLARALJ2wVjlT2bb1Fydm78a0ZUc1ycoUMxRhKO816cESOo+THppi3Mn5UbAN2SXUK9T6+q0hROBeDKMpF57E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773996921; c=relaxed/simple;
	bh=GaK3fnyt6sUtJdGJ1MYlD0Zj97Sh5Zjn/UmRR+fsbns=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VUcWOqNcASwKI6JZF6asKogAFmLmJ+T8drgUfIWeHs/DFQ5GAfg3PfKiYv7Kgn943idf3dCt9he8P3wECzMBhDaDSRxtwSuDO3KhM9HeuV9W3bfi91bzyogKD+96FFN6pI1T974nA1jriTwOMmZlYKlk5xGbjMR96Suqkv/7nNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jIUegXOV; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35b9894f9ceso1930578a91.2
        for <stable@vger.kernel.org>; Fri, 20 Mar 2026 01:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773996919; x=1774601719; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WgV220nsjvXYUtCcSN6gGHf35gDIvTt1U7idg/3OBAg=;
        b=jIUegXOVMODGeq7BYevvelsOBx0iDFcukCVoxXqPAx1lvGDcVjngh3jzkgcXwAikrU
         v17PHO5tTHqnwkpnqWrRKhpvHtvIcNQ9nIlAbDT6HvZA3rtyWcTjXc2ewudEI2zgBjyD
         WTwAt8lAcNedTr/yYL6wu+I7ImbKsusnGS1C83eChbifDSGcafhAkbyXWXbnPIR2Jk8r
         0kdNudl1ZMFAQPffrTxzR+AVlay75kPk5+gYgOaeD8qQyjPAmTeCg1pNFlfPc9CNTsca
         IZ22fP1m7wQOj9TrvgDp7rpZyCcN/gIicfbsAQlvMHXhy6od7AFXIhJ4HX3S4j677tX2
         Mn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773996919; x=1774601719;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WgV220nsjvXYUtCcSN6gGHf35gDIvTt1U7idg/3OBAg=;
        b=Qa3ypx2iD+vtHUwHIO1txdoKOrwF1o4jt/JD9Xzd9ounkrTDzzdPhpGf+W0hwuN2mQ
         bbHWqHPYJ8pbFez3qOM4jQJgsoXxiPrBVf9j/wYxE5TaxIQlVHFTy68ZiHESB6XjM4Li
         hkE69Kj7ZnrNiz9DH2IfwjtJDtOaNnCT+ks0HHLGHpYrxQobuI7TzqacRnka9lRN4/NJ
         +a0vQX5yMDtCX5jEyYLyhQ7AR2Xbcl0pNSIW4ZkyESzdpZXlFrEw4C2MkDve1RaxAuTY
         xQKwRghP1GZJUdpb0bO7aQn+gXGfz2QOpUvt/oUJEGeXD9zxsLY/ZUCPkuIKlSNLp28A
         DeDg==
X-Forwarded-Encrypted: i=1; AJvYcCXhieJnULhhZYbqznuioFLv7nn2XchKtiDA+PXUaiHBQKjgC9x+qpu8n0FChw9/QhfPzSe1v6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLSo4r5JrJZX1JZ544eqEFdaufosMXD9z09JUwhG6rXeudPKGg
	3JLGciK5F3idmcTNawuqw5mLv3+5Q+g0E4xmrPNsDAIkZMFK9CXtbg6bAZ6b0pueOkWcDYKgl0h
	nj52bPQ==
X-Received: from pjzl15.prod.google.com ([2002:a17:90b:78f:b0:35b:9114:f5fe])
 (user=khtsai job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:184c:b0:354:c593:b1a8
 with SMTP id 98e67ed59e1d1-35bd2be16b5mr1830414a91.13.1773996919107; Fri, 20
 Mar 2026 01:55:19 -0700 (PDT)
Date: Fri, 20 Mar 2026 16:54:44 +0800
In-Reply-To: <20260320-usb-net-lifecycle-v1-0-4886b578161b@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260320-usb-net-lifecycle-v1-0-4886b578161b@google.com>
X-Developer-Key: i=khtsai@google.com; a=ed25519; pk=abA4Pw6dY2ZufSbSXW9mtp7xiv1AVPtgRhCFWJSEqLE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773996915; l=1297;
 i=khtsai@google.com; s=20250916; h=from:subject:message-id;
 bh=GaK3fnyt6sUtJdGJ1MYlD0Zj97Sh5Zjn/UmRR+fsbns=; b=+/IvBeyEb1KCNPGCJl7fYirjn/sIcTPTyTsiNvrttl0wrz+0QELKMA77pGV/5JzGwEn4uyrqU
 1JFgAyJdvwDAYFphJqt0GWYWcl0P/WoopApWoF1kDXk2/A0+tEL7oab
X-Mailer: b4 0.14.3
Message-ID: <20260320-usb-net-lifecycle-v1-1-4886b578161b@google.com>
Subject: [PATCH 1/7] usb: gadget: f_subset: Fix unbalanced refcnt in geth_free
From: Kuen-Han Tsai <khtsai@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kyungmin Park <kyungmin.park@samsung.com>, 
	Felipe Balbi <balbi@kernel.org>, David Lechner <david@lechnology.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kuen-Han Tsai <khtsai@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227485-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.984];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[khtsai@google.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B35722D799D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

geth_alloc() increments the reference count, but geth_free() fails to
decrement it. This prevents the configuration of attributes via configfs
after unlinking the function.

Decrement the reference count in geth_free() to ensure proper cleanup.

Fixes: 02832e56f88a ("usb: gadget: f_subset: add configfs support")
Cc: stable@vger.kernel.org
Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
---
 drivers/usb/gadget/function/f_subset.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/gadget/function/f_subset.c b/drivers/usb/gadget/function/f_subset.c
index 076072386e5e..74dc6da5c767 100644
--- a/drivers/usb/gadget/function/f_subset.c
+++ b/drivers/usb/gadget/function/f_subset.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2008 Nokia Corporation
  */
 
+#include <linux/cleanup.h>
 #include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -449,8 +450,13 @@ static struct usb_function_instance *geth_alloc_inst(void)
 static void geth_free(struct usb_function *f)
 {
 	struct f_gether *eth;
+	struct f_gether_opts *opts;
+
+	opts = container_of(f->fi, struct f_gether_opts, func_inst);
 
 	eth = func_to_geth(f);
+	scoped_guard(mutex, &opts->lock)
+		opts->refcnt--;
 	kfree(eth);
 }
 

-- 
2.53.0.959.g497ff81fa9-goog


