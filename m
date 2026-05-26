Return-Path: <stable+bounces-254252-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OM66B2hHFWqLUAcAu9opvQ
	(envelope-from <stable+bounces-254252-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 09:10:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 794585D1856
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 09:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6BA5300734B
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 07:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BB23C4B90;
	Tue, 26 May 2026 07:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IFGejzlE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A4D3A6F0F
	for <stable@vger.kernel.org>; Tue, 26 May 2026 07:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779779204; cv=none; b=bhznfS1jqrsLnmj6i6Us7io7RD8zftIGNO+Exu01sIVUpeTQhbXtQcX3ZAUlVl/tEUtap2Y7b7IBFommNLpfblUabP6S9JcK96IxcSREfTYAVd5DyRZYFszegyTwyQYfvTnVGo+DaJtzEu0OKnVuOeGAKpsbbgdO7cMIG0lfUAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779779204; c=relaxed/simple;
	bh=JDU+r+4eAFHPbUpIU0DFrV5eLnEjfElHbf2/4HA8k0Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FdmkTdggYr8No4jeeO/dnJ4NjAhU2FvWqkRZpvGfi7/420XFOl7jqjmN4GT69k6DT0tBw+ufYa1uvVLSwtM4tLLEfUGU5PiU3ZLRD+CukcXqP3+nTB6OIJcQ5DH0SLj6pLQ6Fa1CeiFTdVySSJosvO1Y33c+RR9kQBO0+z89RnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hhhuuu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IFGejzlE; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hhhuuu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-837d43e9ff3so6643577b3a.2
        for <stable@vger.kernel.org>; Tue, 26 May 2026 00:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779779201; x=1780384001; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DmSH083zLCvpnjRw/E18mHYgSCn8sHqasuCuNLVFOPM=;
        b=IFGejzlEOxNGoTXGcqCIyTUa6eNoaBj+nDDOzMqnAnKSTStrAL/73U66pKruBzQ/6d
         zzzEH+b2IngNd1VV/n3EhStwTpEEqvJiAI3QBTGon+1Sl1wIXSXM5cM+a002y/hTdI8h
         Vl5U11m7S5lyIO9xfl7hf+ehAQA8qzgSkzoZ3BqQAZayYAK4uYDwaECB9QDk17ajrDwq
         4VaSXyrLSYwY0SlHYouJXh3w4JB/ap4vLlT5Ri2vEKjuOjnnF2BQ1MVxl0cVfNvNbNyX
         8yXgTma+hqeabkJIWp9f8BMkU7kxkVRxuU0AIfzvjCmDrdP7LteySdDecioRwSab/jvq
         sa/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779779201; x=1780384001;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DmSH083zLCvpnjRw/E18mHYgSCn8sHqasuCuNLVFOPM=;
        b=QvPeLhUg0h1qUlFG57W8fdPoGfON1FtqoH0ltNnovDD8koNT4FCVYxBsqgRee6X4Rw
         fdtP26RtvOoJkUWGcHxG9xdnKiiAgkZL5RRBXjnVPvufF3GUdLz7EdvbKWhwhDMCLkKh
         duW1BWm0MHeOGg/t89Rnh0plaguKqsz7DSMZ5QpU3fHGxp9Uc2+HsyixobOyRWBqS2re
         5f7vKvHo6HkZfkWKJxR9FfkP9+Mb+HLCIHCKWvUtCU+22thLR55p4uHy8uBGYOHgqYqw
         2f1d7dh1ivxjUBdwa34zYZI/NG3Vql4OCaOiiJEePGQ3fZUcfLs9XZSy0hsVgdXdhmNm
         J5yg==
X-Forwarded-Encrypted: i=1; AFNElJ/WV0y/5AYDsuyDyPf0w9poUII5bTwMrtK2lPE8lDuetc8/n8dg57B2WPlg2gDemXYow5RudBo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0V3cRYvOjQltiwVEzgdfjDu1+8QAY8B/d53hxUsioKUDooShs
	tFvnhnbDktoWHPbLNG99tmL7xMEmaFgS7904hZpPZWVi8zANs7aaIYgdMtvGhYxbxUJk01rcRVe
	AbPQHWw==
X-Received: from pfny9.prod.google.com ([2002:aa7:8549:0:b0:838:f05:69ac])
 (user=hhhuuu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3a08:b0:82f:2226:5aeb
 with SMTP id d2e1a72fcca58-8415f426d0bmr15966910b3a.20.1779779200135; Tue, 26
 May 2026 00:06:40 -0700 (PDT)
Date: Tue, 26 May 2026 15:06:35 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260526070635.839701-1-hhhuuu@google.com>
Subject: [PATCH] usb: gadget: udc: Fix NULL pointer dereference in gadget_match_driver
From: Jimmy Hu <hhhuuu@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jimmy Hu <hhhuuu@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254252-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hhhuuu@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 794585D1856
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A NULL pointer dereference occurs in gadget_match_driver() because a
race condition exists between the DRD mode-switch work and the
configfs UDC write path:

1. The DRD mode-switch work invokes __dwc3_set_mode(), which calls
   dwc3_gadget_exit() and subsequently frees the UDC device name via
   device_unregister(&udc->dev).
2. The configfs UDC write path invokes gadget_dev_desc_UDC_store(),
   which calls usb_gadget_register_driver() and subsequently
   compares the UDC device name via gadget_match_driver().

If gadget_match_driver() runs concurrently during UDC unregistration, it
may access the freed UDC device name. Once the freed memory is zeroed,
dev_name(&udc->dev) returns NULL, causing a panic in strcmp().

[39430.908615][ T1171] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
[39430.911397][ T1171] pc : __pi_strcmp+0x20/0x140
[39430.911441][ T1171] lr : gadget_match_driver+0x34/0x60
...
[39430.911890][ T1171]  usb_gadget_register_driver_owner+0x50/0xf8
[39430.911910][ T1171]  gadget_dev_desc_UDC_store+0xf4/0x140
[39430.931308][ T1171]  configfs_write_iter+0xec/0x134
...
[39430.957058][ T1171] Workqueue: events_freezable __dwc3_set_mode
[39430.957287][ T1171]  dwc3_gadget_exit+0x34/0x8c
[39430.957304][ T1171]  __dwc3_set_mode+0xc0/0x664
[39430.957341][ T1171]  worker_thread+0x244/0x334

Fix this by checking dev_name(&udc->dev) before calling strcmp().

Fixes: fc274c1e9973 ("USB: gadget: Add a new bus for gadgets")
Cc: stable@vger.kernel.org
Signed-off-by: Jimmy Hu <hhhuuu@google.com>
---
 drivers/usb/gadget/udc/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index e8861eaad907..79baed640428 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -1594,7 +1594,7 @@ static int gadget_match_driver(struct device *dev, const struct device_driver *d
 			struct usb_gadget_driver, driver);
 
 	/* If the driver specifies a udc_name, it must match the UDC's name */
-	if (driver->udc_name &&
+	if (driver->udc_name && dev_name(&udc->dev) &&
 			strcmp(driver->udc_name, dev_name(&udc->dev)) != 0)
 		return 0;
 

base-commit: 5d6919055dec134de3c40167a490f33c74c12581
-- 
2.54.0.746.g67dd491aae-goog


