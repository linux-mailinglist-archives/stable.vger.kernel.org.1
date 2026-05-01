Return-Path: <stable+bounces-242239-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PdXIHYx9GnK/AEAu9opvQ
	(envelope-from <stable+bounces-242239-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 06:52:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7D94AA661
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 06:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 58E4D300BE08
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 04:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289DA27CB35;
	Fri,  1 May 2026 04:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOz+xv8o"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB63C29D294
	for <stable@vger.kernel.org>; Fri,  1 May 2026 04:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777611119; cv=none; b=THImvbVUSagVLj9sI9eHSnBDOafjE6ifuXqdK2I+bqbq3M0D5l4XCnc8Ymy5QxPNx7XLo6UNhAA8+0Gxkzv9Z804glZ/4+dimK6a7/8qXVnxOBfzn/tYrd7A5tyD+8I6357svY8KU2x0voIPHwK9UixzCoeWRL2Tyf/KNFh7KSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777611119; c=relaxed/simple;
	bh=jK0DLZYUDEjXV1SYTaRYK5ZSUNylecs/sAz231vAZno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nvqp3jNDEqQw0K/xKN6C+u/32dd0Zo8pTCq4KxzW+gM1pXZahXtkZxPV9nP+30STZ0MZ2eugj8rL21Dl7pYKfkvmSYJJsy9XX71Z7PVRR6MX3X9wjzlSVKi4It47Qwt4plUqZ7ithK1Nr/+Lv9OWu92kHvVgKsEiNUtkKa2IWnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOz+xv8o; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35fbca04006so793562a91.1
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 21:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777611118; x=1778215918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=16cUvY4zBFvfqnNuRIHA1BYN079Aq1HpTRIsih+lka0=;
        b=YOz+xv8oHLm0Dew9DtLV8F5rKKWNdc1BCsnIviirYEGkL+eUpWbcQjBpE18KgD4qVp
         3uIEmMBpY8WBig6slS38/+QMrUcnpM0LcTH0svRDKA5qoqrn2LlNokr6wQ9KShgimP1W
         uE7wYury5KTkoI31K70rzyHzpCJp1R9S/E8GTXS13xNLMvBTVRFbH1elHe0M8oNE3AHS
         UVtoa03gThZOpFXTlv/X6C5tL5lf0ggKKLHqZSeW6Ke7FBLKWWI6hGL64IpI/vJWgWlS
         ZwbB+K1+SsWN+YncDQBXkwsTkcuDQdgmQENdjTfc6eJ8eSzNkI1CzV/nCed423RLy4NT
         r9/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777611118; x=1778215918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16cUvY4zBFvfqnNuRIHA1BYN079Aq1HpTRIsih+lka0=;
        b=gAWd7y6Q+nsabnIc7tzaXIh+fUcsOMaHNul9wy+HloJ4jOL4mu32LUyxqnKRoluzcS
         Mcl8HF5i8TC4EMeQ/F8RozVvaDWoiOVWUXoveE2adTc7faqAnzXbBFwPB5T4hV/wkjrE
         gHnnkLonM4flfCxW0GLX30GO2Of/apSMV/8Ce3/RkCBKnz3lcZuhJK4S/1fBsVGzm0ja
         +MwFer0Oo10l5+4zKBLUCByBvRuP6WaxFFXN0SH6V5WUkIP1RJ/VLlQJXrnldlwFbscf
         gR6qqx0RoGmwNO4RqKhuJynMzviffn/UUHwR12hN+4t5SfOKwfJGR4na5cwN+ZsHxScr
         GISw==
X-Gm-Message-State: AOJu0Yz7U+i0bYZRz8jhrUbbbLcstbGOcu7Gf3iGSzesuRYhvWP4FRRR
	Ymj+ypWNbud/eA+A1nNjkWqeRIrv+Xl6AeYz8bst1YaRNaM/sG0ujWNL
X-Gm-Gg: AeBDietKuzXP74zsRZm4fFta2dH3YP9Ut7KRbozm6BOdrJhOAcOaEcvzT90E8ZToPB2
	Rrdod7n4ClLiU+fxgCT0fK9W+HqAiav8RHYfO/ZacYcktTGecOy70QwXxZz6abErYtHQUrT4m+b
	kQWr+l/d/V/S+3Wo5QEOMSijbdeXkcvfEKzT6NKwACMjr5TWr8VdvzrSzFXhIVslXk2ikg5y0u1
	azAlxxPLBxwCWzGMgZ6Ryjm83zFmYWazYCSD32QY8IyXT1LdZN6YJifoandz6+HLIdxUjEYjy2F
	7dE4TXkG7xFJKNcal/vIKGjwnm2YoVyWmvHf25fm1+4I4GLfR5Exy0RfgNzyE4HhbZ8MAfjOeHM
	yq+VwqHz3ldrRfUJm8nifHaIWDdVcH/NrkjymhLg1S3EHwr+9IZWSi+rDG2RaYJPBHic/pR+LnY
	yZ1+5bnYifrQfBnOHsb4Dp7OogzaKj4N0=
X-Received: by 2002:a17:90b:4c8c:b0:35f:b69d:7292 with SMTP id 98e67ed59e1d1-364c309c043mr5879421a91.15.1777611117986;
        Thu, 30 Apr 2026 21:51:57 -0700 (PDT)
Received: from lgs.. ([223.80.110.53])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7ffbc6f063sm1088718a12.20.2026.04.30.21.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 21:51:57 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] usb: gadget: goku_udc: avoid double-free in error path
Date: Fri,  1 May 2026 12:51:13 +0800
Message-ID: <20260501045113.484207-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8E7D94AA661
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-242239-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,gmail.com,kernel.org,linux.intel.com,ispras.ru,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

goku_probe() allocates struct goku_udc and passes &dev->gadget to
usb_add_gadget_udc_release() with gadget_release() as the release
callback. usb_add_gadget_udc_release() initializes the gadget device with
that release callback before calling usb_add_gadget().

If usb_add_gadget() fails, usb_add_gadget_udc_release() calls
usb_put_gadget(), which invokes gadget_release() and frees dev. The
current error path then falls through to kfree(dev), freeing the same
object again.

Set dev to NULL before jumping to the common error path so the explicit
kfree(dev) is skipped after ownership has already been dropped by the
gadget core.

This issue was found by a static analysis tool I am developing.

Fixes: 2a334cfaf393 ("usb: gadget: goku_udc: fix memory leak in goku_probe()")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/usb/gadget/udc/goku_udc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/goku_udc.c b/drivers/usb/gadget/udc/goku_udc.c
index db42a5e3e805..46a7e0f6541e 100644
--- a/drivers/usb/gadget/udc/goku_udc.c
+++ b/drivers/usb/gadget/udc/goku_udc.c
@@ -1819,15 +1819,20 @@ static int goku_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	retval = usb_add_gadget_udc_release(&pdev->dev, &dev->gadget,
 			gadget_release);
-	if (retval)
+	if (retval) {
+		/*
+		 * usb_add_gadget_udc_release() calls the gadget release
+		 * function on failure, and gadget_release() frees dev.
+		 */
+		dev = NULL;
 		goto err;
+	}
 
 	return 0;
 
 err:
 	if (dev)
 		goku_remove (pdev);
-	/* gadget_release is not registered yet, kfree explicitly */
 	kfree(dev);
 	return retval;
 }
-- 
2.43.0


