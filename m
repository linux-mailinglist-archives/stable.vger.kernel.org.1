Return-Path: <stable+bounces-227486-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FhCEkIMvWkO5gIAu9opvQ
	(envelope-from <stable+bounces-227486-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 09:58:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A454F2D79D9
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 09:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37F6E315AFDA
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 08:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAF0377572;
	Fri, 20 Mar 2026 08:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uUdz5pjF"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EFD377009
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 08:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773996923; cv=none; b=BRa29QBfF7G+Q7FzL5Mw+wRX7Qie2N5FELHOEgAW2vESFAT3mYBjcc/JlX195vBqscVLm+5gT+uF3n9KM5mGgi4bT3anMiDKEvBAcnNMhJc6cqYhYfbsEPSAvaS2YcDTxzSVk1dEHTSK9/i/bSya3Ssq16a3YiaabFEIOTg44L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773996923; c=relaxed/simple;
	bh=6Wkr6y8zvwVGvQGPNYUT30NoBb4TcsrkrqZeBgojKgk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ssw324KBwPYQ8L3KsL6pQuztS5Lw/g3nuE2m4zeg15R0z/ZYn6VK7ppgMIsVjiRG7ldbHl3x6Vvws9vIicEMGPuPokkoQ/yXTJHF9uVwSSYrB+C0xCu3L+Seqsu4qJB5YQ9uRET2cvgJuHpDkIFiKpJ9nl4qTeX+c68FET1nOnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uUdz5pjF; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82a1436347eso1063128b3a.2
        for <stable@vger.kernel.org>; Fri, 20 Mar 2026 01:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773996921; x=1774601721; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hZ7vsqBU2jtHuNF1VCOsuin7WLACvQQEK8+9Bbcoxqo=;
        b=uUdz5pjFTS+WCCMmWUWscbOP1MTYn/8UbNXYHATlZNrliZ/h2THIjq3bayR+sV0wgO
         bYkkE9KpGJLPjD/KIHzqV1ybWiGFEKkRMUzgsZb0cgGImtDRCtsI54QWNRkxZ5pL0EUE
         TrTZ/1HhIb0gOfWaC668vlLMTjTRJb+HHoZXcS1RqLVGw32+qRKhAd2y3nxHYPg+xpnQ
         mFvLm+6msxjjq2JDN5f04Dl/J84ub2jiim65HL6pvJDkquEHVmewDvlSLKK5nWaKQuNX
         2yV/w6BQ+h0MOOdjyuvXyDTWO+toL2bRlauG2M9o9rm1JrVd3tXkF387x6U3ga9x8GY7
         mwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773996921; x=1774601721;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hZ7vsqBU2jtHuNF1VCOsuin7WLACvQQEK8+9Bbcoxqo=;
        b=M3cuNLhvfpR8KzK5nVsHJxozzaduwElC3UAIe+NZ6PVT5PocIg0PI92KkXsRLXX55o
         4dNPZnr22oSdNLjrlD1pI2+Eucaj1+rftyAEQuMhZSivBaER5A0OOw6BhHpu8gDYGmNo
         5UIstWbDgv5tqXtkf0458ctZsiC1zQl3m9dC+1PU8dDCwOrALnjie33ZN+jQeVeo9cPb
         qojN2o6I/DQiheox3NUTrAZRZyjoh7IQ6Y5H1WS8xcE8wc2Ny/c5YxtT62uEllOrmW5K
         HYNwyTW7KrZERbk2aJEnJ/TSZjrTVhr5ixTu7btqBGh6yqffbWz8wKxn6My8OxW27DeI
         EiDA==
X-Forwarded-Encrypted: i=1; AJvYcCXHgARbglLHQUM2qu7oM2X5GTknb/tc/HbgeWHhedqtUhESmGwfonAVMAd3hVncpiASFtFLh/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAA7si1VUtWdIK+VSrmwb+GvMLnoQFQfuXTR0/4m6hdo/Pa8Yt
	Mg3+3GMJSO6biApdK3JqcSxil6A6WPcKW/LuPb1CL9zyv0JzRB4puaOZn/oELgiU258gJF+1N9a
	pKoGT3g==
X-Received: from pfbbt10.prod.google.com ([2002:a05:6a00:438a:b0:82a:6e03:a17f])
 (user=khtsai job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3d10:b0:82a:77f9:c563
 with SMTP id d2e1a72fcca58-82a8c22deabmr1820957b3a.12.1773996921141; Fri, 20
 Mar 2026 01:55:21 -0700 (PDT)
Date: Fri, 20 Mar 2026 16:54:45 +0800
In-Reply-To: <20260320-usb-net-lifecycle-v1-0-4886b578161b@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260320-usb-net-lifecycle-v1-0-4886b578161b@google.com>
X-Developer-Key: i=khtsai@google.com; a=ed25519; pk=abA4Pw6dY2ZufSbSXW9mtp7xiv1AVPtgRhCFWJSEqLE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773996915; l=1561;
 i=khtsai@google.com; s=20250916; h=from:subject:message-id;
 bh=6Wkr6y8zvwVGvQGPNYUT30NoBb4TcsrkrqZeBgojKgk=; b=v8vZYl0ZMCKyFw75/3cvh+rKLQGT0mxQMyM9i1ZigduUl/TMQ6/WSN2wbvDbTi7ITMVr9tAy2
 OgCsgnfoDZ6AJKz/G4uH9hFs6gmLjtZtgdn5E3QO8DoyM/0L6RyzjAX
X-Mailer: b4 0.14.3
Message-ID: <20260320-usb-net-lifecycle-v1-2-4886b578161b@google.com>
Subject: [PATCH 2/7] usb: gadget: f_rndis: Protect RNDIS options with mutex
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227486-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[khtsai@google.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A454F2D79D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The class/subclass/protocol options are suspectible to race conditions
as they can be accessed concurrently through configfs.

Use existing mutex to protect these options. This issue was identified
during code inspection.

Fixes: 73517cf49bd4 ("usb: gadget: add RNDIS configfs options for class/subclass/protocol")
Cc: stable@vger.kernel.org
Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
---
 drivers/usb/gadget/function/f_rndis.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/function/f_rndis.c b/drivers/usb/gadget/function/f_rndis.c
index 8b11d8d6d89c..521b4619d6be 100644
--- a/drivers/usb/gadget/function/f_rndis.c
+++ b/drivers/usb/gadget/function/f_rndis.c
@@ -11,6 +11,7 @@
 
 /* #define VERBOSE_DEBUG */
 
+#include <linux/cleanup.h>
 #include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -678,9 +679,11 @@ rndis_bind(struct usb_configuration *c, struct usb_function *f)
 			return -ENOMEM;
 	}
 
-	rndis_iad_descriptor.bFunctionClass = rndis_opts->class;
-	rndis_iad_descriptor.bFunctionSubClass = rndis_opts->subclass;
-	rndis_iad_descriptor.bFunctionProtocol = rndis_opts->protocol;
+	scoped_guard(mutex, &rndis_opts->lock) {
+		rndis_iad_descriptor.bFunctionClass = rndis_opts->class;
+		rndis_iad_descriptor.bFunctionSubClass = rndis_opts->subclass;
+		rndis_iad_descriptor.bFunctionProtocol = rndis_opts->protocol;
+	}
 
 	/*
 	 * in drivers/usb/gadget/configfs.c:configfs_composite_bind()

-- 
2.53.0.959.g497ff81fa9-goog


