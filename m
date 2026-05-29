Return-Path: <stable+bounces-256502-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eC28DHYfGWqnqggAu9opvQ
	(envelope-from <stable+bounces-256502-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 07:09:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D345FD3FF
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 07:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4EB730574B8
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 05:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AEB39FCC4;
	Fri, 29 May 2026 05:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wt6zo7iz"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBED38D3F3
	for <stable@vger.kernel.org>; Fri, 29 May 2026 05:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780031218; cv=none; b=XqJB6shMwBkym+03h1f8dNR+bGhgb2FkNSe4lfW1tlj/DdT4IjBimZjvFFVDqNkpjn8KGNOvvgcik0oAWG4D6fNjii5mBVkMr5mRexYlryItbVI/U/iqbVYe+ENh4fQuVXxAsUho8mbIIDglMejxY5Y6pyIKhG/F5u2LnQBY+/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780031218; c=relaxed/simple;
	bh=C1teFxbkmqUEpKxwsk6TrhvgKguX4DU7tWyrjp5RwxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kCm6m2DCrI4gOwN1ngbzO2LOW3dYGYtv3M8FRRcYhtaLEGte/8n1arv0wxgzaS5KGTy4VxxkbTDUJaVRTiIsPMoJRPqLrTBwYFIxHbmtqgpYfjhZdk2XJQY8TRRHDCn/m72Z5wDzox1Lrt71EEU67PVsaBeWNE5c29QDTD843wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wt6zo7iz; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4909def6a21so415465e9.3
        for <stable@vger.kernel.org>; Thu, 28 May 2026 22:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780031214; x=1780636014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBJ2gsXIs8bElFnwreFyB5fEKwJ7W4oMcY7a30B+xik=;
        b=Wt6zo7izN3UnLg8F6XJnk0DjPQxA1OBt4l0g4xu/8phBZLiHqkcHZsav8LMib6RCJ7
         g6SKwk4BzchQykMQqLemjB9mejpTVj+1qIBfPsYQ+plrDSIwuMojBjg3BLZ2YjHkaONq
         k50PHc88AASs1oqOr192H5w5FDJR/Ote4RR1drrSvKWUWv4d6imFn51+rOOpNBP4sbbj
         iH3Pg6WnrGdLNVUa+K7b0/gT0q1Al35Tsb8uRV7aE62mZtz4PYsCUWfMCBvFILsXxjbT
         F6CHfY4x4CyMM476p++E/zR7b/Gv27GdxfnMlE2/9PW8dM+2z00F6BsCOa/1efbedbSP
         aTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780031214; x=1780636014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UBJ2gsXIs8bElFnwreFyB5fEKwJ7W4oMcY7a30B+xik=;
        b=CAmmNw7dzm6SdTPtL7zgx8oas/4kDOazaB0/3exn9ovKVzHnGEJctwsvdXiD+88XZi
         2nr9t+uh8a4mOGLGWBKbt8K4upKJtjpfToFAWzBEjmyNqoAk21DFLvJ2lITQDHCXfNQc
         GzDrhNRpAqdXThpaovIzpLQQBNIk7zNdFZh7/EHzIsrY8HARPSYMTP/kaqthDoJhwixP
         GSICNjuRaRcQcTVMQ9AN/2HjWBFFpbnykIPUwlR37/i5kKQwVAjjh7jwpyxziLU5+uy1
         k2Av13HBtD1amft89G0KrVNQhed+87S+XcYkuJYvVGNrfMFQYK7DwGEtjoIdAuXpIlUY
         dkng==
X-Forwarded-Encrypted: i=1; AFNElJ/vBwm7L2VGzE0g5kZa8clxjuD2EI3mE0D8bj8rwO/P8vXG6jQZEIY8TqL/gdymoIiuh2ydC1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ9AIWWFrAIvFqJXReGqvvuBah5BtP8E2dSRURp0Y1WkxpeG2E
	Grv0WCeM24fEQLt9GXfOqJwMc/PhxNYWJCWLgQwybHdIXEKH5+gWSX5s
X-Gm-Gg: Acq92OGO4sUcCsC86wBDjfQRb1Y2DEZa6e8CK9kBCJQJw9XUsZmYwsdcYevMDkOteY6
	HDGH7Q3sYw7ZMYlb2PzHw87AJaDB6dJiy1nGiP6MBAqtCqhTLgY/q/4XHyJxfn4lLm1+GuFZ8jW
	XhjcKY2Fd7ig3ZJwuJl7GOqqyXZd8CPHTQbaCcGB+FFWOTZAqYSCltG4UXqUg7GYsiWCumYF1M4
	nbGbKsMfTeZ83A6UnNupXO9N5m2oQji7I08jXf+maRFby445Iqnb8gS0f6ZV2H/F3Kk03VPPcy1
	47lWvLmGvh3fy9orsS8yu8qCju6zw/81Ma/Bxxh2VtcPq/J9gzRfg9XmNof2huwQwN4QP1z9uUa
	xYA+rw2UYaTOejLpCQuqCZFdSI8xJmI4hUbe40jnAUbR3uhxZA2R9j844npfjQRDu9thbTiQwpg
	QPL8RBicWUgMlvn2HFLNoIiJWd/UGbVIlT/FxaEg8ri5Sn54HKhTdE6AJ/G0qR3h63tYi2kvYmR
	uDNJDKS8buO0wcpOsbNbg==
X-Received: by 2002:a05:600c:4e0d:b0:490:5368:743 with SMTP id 5b1f17b1804b1-4909c0c8fcemr21786775e9.32.1780031213383;
        Thu, 28 May 2026 22:06:53 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34c3081sm913830f8f.15.2026.05.28.22.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 22:06:53 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Daniel Scally <dan.scally@ideasonboard.com>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Nayden Kanchev <nayden.kanchev@arm.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH v2] media: mali-c55: fix integer overflow in scaler factor calculation
Date: Fri, 29 May 2026 06:06:49 +0100
Message-ID: <20260529050649.14109-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529024429.6942-1-devnexen@gmail.com>
References: <20260529024429.6942-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256502-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 87D345FD3FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The scaling factors are computed by multiplying the crop dimension by
the Q4.20 unit (1 << 20) and dividing by the output dimension. The
results are stored in u64, but both operands are 32-bit, so the product
is evaluated in 32-bit arithmetic and only widened afterwards.

Crop dimensions may be up to 8192. Once a dimension reaches 4096 the
product overflows 32 bits and wraps (zero at exactly 4096), programming
a corrupted scaling increment and corrupting the downscaled output.

Define the fixed-point unit as unsigned long long so the multiplication
is done in 64-bit arithmetic.

Fixes: d5f281f3dd29 ("media: mali-c55: Add Mali-C55 ISP driver")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
v2: Use the BIT_ULL() macro instead of an open-coded (1ULL << 20)
    (checkpatch).
---
 drivers/media/platform/arm/mali-c55/mali-c55-resizer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-resizer.c b/drivers/media/platform/arm/mali-c55/mali-c55-resizer.c
index c4f46651dcee..6706939b4a90 100644
--- a/drivers/media/platform/arm/mali-c55/mali-c55-resizer.c
+++ b/drivers/media/platform/arm/mali-c55/mali-c55-resizer.c
@@ -15,7 +15,7 @@
 #include "mali-c55-registers.h"
 
 /* Scaling factor in Q4.20 format. */
-#define MALI_C55_RSZ_SCALER_FACTOR	(1U << 20)
+#define MALI_C55_RSZ_SCALER_FACTOR	BIT_ULL(20)
 
 #define MALI_C55_RSZ_COEFS_BANKS	8
 #define MALI_C55_RSZ_COEFS_ENTRIES	64
-- 
2.53.0


