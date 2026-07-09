Return-Path: <stable+bounces-272992-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WMgFERTVT2q2owIAu9opvQ
	(envelope-from <stable+bounces-272992-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 19:06:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C26733B03
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 19:06:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="Z/VFXBqu";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272992-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-272992-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7C9A3113C1F
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 16:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A5A39DBE5;
	Thu,  9 Jul 2026 16:59:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5CE39A7F2
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 16:59:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783616361; cv=none; b=FyhdN5mdi9SxxOChok7AL1nnpG62d9/BN2HspUHTUWNqdUMuqpJoWJoMHyzTpcFR8CdHy0HwhglKzs/PHj08Gyy5UIMiFOmOKdr195Lk4mgRkpuDhdiXEi3yHcDIxB+22D2mVSGqJrEoI+SRZJwirpDRDK3tI/u/l6lArVq4Ycg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783616361; c=relaxed/simple;
	bh=pGq6Ho7akFAbOMMkEMP4bgv7HVaDVNSGjgc1WcBOf1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j5P4DiAJODd21Hy5u9ZCsu2VsQgpj0rLBAlTed9KnC1y2FNTIOQuEVe5lK/UpgN49avyayWkYzIlsea/uoTnxdS3v4OOuQZmXAUbbVGpAcZOdGRUCMYlU1BMlSxZC+4blwbLapZlaBUr8lvmkwba1ifAyBeda641Od3PuSHjS+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/VFXBqu; arc=none smtp.client-ip=209.85.208.41
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6986287534eso30975a12.3
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 09:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783616359; x=1784221159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FcqmO2qOzufGvSZVtWMC1+200YXwxI3/0WI8kXhX1g4=;
        b=Z/VFXBquoOVgqI9jKhtNefNpdSQGrQyz2SVHh2E9pdylEA9OJFPOUTsg5e+A4XVOtR
         IZ7LTVmPXfnEZtGr8DLDEe4vUzntA6YEBN51zW/Y414/MgGltVlutgdJnv3qrhXkLukF
         JxBcHVLImUikKuQjaNgoOravmmsVoSrLKrW1bsiojCIlfPkvxhtrC65N968vEYjSeLdf
         fzjsNRJ/J7g7l+8vlEttIO7rN5oQ0FYxp20nzW9QUaZ+nSYu+3qa0of3NA3UTKkN+bu1
         Auc3/Ug8il6CEKus06AF3q+ikYa+iSu7bvCihZKs+6aGLPqOKlqt7aJhee4Zi2LtaLbl
         CBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783616359; x=1784221159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FcqmO2qOzufGvSZVtWMC1+200YXwxI3/0WI8kXhX1g4=;
        b=oNqyr2Je45aepE1zh97BAv8BmyZm0gpeYnMViHOXFgzgQ0IiqsgEr4Do4T0ReEBDqn
         LlRXAz7UuEb5Yyu68EYTAkF0YFpsWnDzb8mpz8lFLh0i51lB3bL9ewN6ts/9hEok+YUG
         XnARQqqij6O465C/lyNIvH0ZIeDxXgDhBqL/cWNzgVW87OMF4b3x/Vrzy4AVy++0bfrA
         Su7ojqa7FBuJrCJCFGG63KP852gTWJDkhA/yPINHk49Ki5Ob07G87EUoGqbFiJZAZuIJ
         ez1i7mVbzzfbynF76+NkAqNuCsMYnuXbASTT7qKVHZlsTNDHWjX+OBSppAPYDBd0moPb
         b8vg==
X-Gm-Message-State: AOJu0YyXkO9tQc0ncV29JbzixE+OEui0HJHXhK1eaA8V3CvTUk//cJyM
	PZ1Q6XXEYPP0dlWHfWpTv8rwigyQMBVvqKM7eB7eV0/r1iJWcObdsBl4
X-Gm-Gg: AfdE7ckLgbwYc7YTE7xXKoi+VEbchtYd7W8wzA9xibxFNoYj4FpA7Gzwvgsq5EdfPMX
	tMkGuffNfX3lYnd2N9Qc7gE66HAG5JC3cA724XRzfYrnMc2MDIvUBe9eQN9BqkmeE+TOjjfb8Ky
	XIdaKoWXnzqJnzGBfB/Wr4jbhOokPJdb1AAYR5ay7eZJ5r4NTBBjwJRg6cFEwIWCU233EB5XnuV
	v0Ir05v+UWjrtFFTE5Q/dqdkm6NVX0+uH84xUePt+4mIq/U+dQ0zeUINLA+KBqUUsc1v9sexCun
	IEmjN79Q/CKntO4lOHkUVQHjoThpwJkayK2dZPTOdFp7C82l/TBEKViDUXnEV7T92+lTGi6mLZw
	0Iz255pgOG9oQPAiXV34cXSwwViXpmU5MxnohbTGI2UtmBf5yhcBEzPhPywRrk1IY+x7lLr+m6V
	1K2RZf0mlGesIArRCtr0IH2p/OA+SsOSPCn5uH7ovAJYjlQWjvKjQ/1mMhbAhsEN4=
X-Received: by 2002:a17:907:d15:b0:c15:9350:dfa6 with SMTP id a640c23a62f3a-c15ce21e09dmr319755066b.60.1783616358766;
        Thu, 09 Jul 2026 09:59:18 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15c79f2a3fsm329902666b.49.2026.07.09.09.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 09:59:18 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jorge Lopez <jorge.lopez2@hp.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Mario Limonciello <superm1@kernel.org>,
	Armin Wolf <W_Armin@gmx.de>,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v5 4/4] platform/x86: hp-bioscfg: warn on element type mismatch instead of failing
Date: Thu,  9 Jul 2026 21:58:59 +0500
Message-ID: <20260709165900.30615-5-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709165900.30615-1-meatuni001@gmail.com>
References: <20260709165900.30615-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmx.de,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-272992-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hansg@kernel.org,m:ilpo.jarvinen@linux.intel.com,m:jorge.lopez2@hp.com,m:linux@weissschuh.net,m:platform-driver-x86@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:superm1@kernel.org,m:W_Armin@gmx.de,m:meatuni001@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[meatuni001@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[meatuni001@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D6C26733B03

hp_populate_enumeration_elements_from_package() returns -EIO and aborts
enumeration of the entire attribute when any single element has an
unexpected ACPI type. This is observed on HP EliteBook 840 G2 when the
BIOS returns malformed ACPI data following a failed WMI query:

  ACPI BIOS Error (bug): AE_AML_BUFFER_LIMIT, Index (0x000000032)
    is beyond end of object (length 0x32)
  ACPI Error: Aborting method \_SB.WMID.WQBE due to previous error
  Error expected type 2 for elem 13, but got type 1 instead
  hp_bioscfg: Returned error 0x3,
    "Invalid command value/Feature not supported"

Aborting immediately discards the attribute entirely.

Warn about the unexpected element type, free the temporary string, skip
the offending element, and continue parsing the remaining package
instead of failing the whole attribute.

Fixes: a34fc329b189 ("platform/x86: hp-bioscfg: bioscfg")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
index de156a9f88a18..21077d17113b9 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
@@ -163,10 +163,11 @@ static int hp_populate_enumeration_elements_from_package(union acpi_object *enum
 
 		/* Check that both expected and read object type match */
 		if (expected_enum_types[eloc] != enum_obj[elem].type) {
-			pr_err("Error expected type %d for elem %d, but got type %d instead\n",
-			       expected_enum_types[eloc], elem, enum_obj[elem].type);
+			pr_warn("Unexpected element type at elem %d: expected %d, got %d, skipping\n",
+				elem, expected_enum_types[eloc], enum_obj[elem].type);
 			kfree(str_value);
-			return -EIO;
+			str_value = NULL;
+			continue;
 		}
 
 		/* Assign appropriate element value to corresponding field */
-- 
2.55.0


