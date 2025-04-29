Return-Path: <stable+bounces-138954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 976C3AA3CF0
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 01:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D8189A738B
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 23:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521A72BD589;
	Tue, 29 Apr 2025 23:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m2Oten3T"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8F4255F51
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 23:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970431; cv=none; b=ACg4tDWE+VXEBEwmskBeJU/Dp0JtgZRWpr2XpS5fB9nGa9Q7cYV9x6wlhIM2NmGwX4vAXbZjG1nFxKQ1wck3MxQ890oKfH4+NRZGVLk+TcYM+sH40HydLk+X0h1Bzm6+qSU0yFlM6J+RnCt1GzSnu406LBEJm1D7V9yyJozO4B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970431; c=relaxed/simple;
	bh=lqFpTzBKH0n+hLPP3D74zDTrtj3ZCOQgeEHM7+9pKZ4=;
	h=Date:Mime-Version:Message-ID:Subject:From:Cc:Content-Type; b=gXLZ5wnUOzaB7zKQiqgKerv8Vlp8TQI740iA6qvcLlzXWaM2tO6Vj5XZad82NPa5tvWL+CZJY0v0hBth2e2kE/60InvFEAfRaPJR8VCB3ZthMVeg87SjqJfTsxcUsOXMQ921CY21EML8Ozo3bK4NrKiFLRMb+kXbQeV/V8Cqd9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rdbabiera.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m2Oten3T; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rdbabiera.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-af2f03fcc95so6449640a12.1
        for <stable@vger.kernel.org>; Tue, 29 Apr 2025 16:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745970428; x=1746575228; darn=vger.kernel.org;
        h=cc:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rHgN+FCfcpWxKWmUBcvDV+CDR/OsUBfRs2x102Mf4zk=;
        b=m2Oten3TacdjncZXnZwfYz/0bAs35CDRIRa3B6apFcHEWS124i3a4+mSgrLAn186Ca
         8a4rjrF0qHBNKhWXPolP+HnFxqd61iHlDF0Rf/SNdzBi7KhyBcdbrBWTUQDQ2u9a0tbZ
         6dWtN2wg+cmeFSLobbRs7cxj5d9B0nUC6/1EpteOTFcGErTne1fNHzHZ7f8a0GlS83WC
         2O/we83avKo8JAQGU5KnzomJviYacpgJGH+mc+X0hi7kLGlYDmak+UL3eHkttSVSusx8
         oer7vkXC3D2dfYB65q0q2HwH94Hf98L0hVnDaL/1dsjZ5nGwso9MzlDMDZ5NE5cfkiRe
         syqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745970428; x=1746575228;
        h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rHgN+FCfcpWxKWmUBcvDV+CDR/OsUBfRs2x102Mf4zk=;
        b=bgXtEpROHe6rbanz/RrKt4I/Ap191v+soTgZL7P+Mf7w0eMOpFkPYd7hHuDlM8Kzcg
         Lm2XGkwWwmnawoSoL+kDWmXPHviH3RE56u88kaO6s7D4520JwWulatTZGqlc4ywYsqdl
         G2Pi+a93v9TMaeVwsaRutfy9tGp2OXT9imj1xj14kPX7iFKAqy2rQSpsCgb8dV0ns61I
         NBgxNn9rF04r4a0S3tZbWqnT1emBMBY+wNWhf6pp+Ji2hg1PB7MBYiFSKBuq6U9rg1nM
         9nqDoH0UsrKYZQd0NRUk9vzWZZ60mkQWDVAY7w181uzWWE/EqvgKOJ5L6B2BakCpzgq7
         s3Pg==
X-Forwarded-Encrypted: i=1; AJvYcCXYmNL1RpTfCz3yiAu7QDv+37MMvBGpR4vvb+lcQisl3APIc0ARghqpz3EENyr8SCHg/XRNynk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrYkau/KHXcmS2nLRZzrfg65t5oLb8Cihjneln52fyGqt/09S8
	EhIG2CXttWedDfMfu1SAHVobJpWOd95mt5aDDE1dtmOd246ItwvP2GDfbzGOmLX2tgu0nledzA/
	EaNFSxx5JQiv4Lg==
X-Google-Smtp-Source: AGHT+IHJSCSltg+/WIvPA6Nl6fDGEhdVNbCCtrD4AIszlnjDqDNJCFlblYduUzbVm4fXKSyRzxB9EK7JCUQkCWs=
X-Received: from pgnm17.prod.google.com ([2002:a63:7d51:0:b0:b15:84fa:ff1f])
 (user=rdbabiera job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:e94:b0:1f5:7280:1cf7 with SMTP id adf61e73a8af0-20a87c542bamr1146783637.16.1745970428604;
 Tue, 29 Apr 2025 16:47:08 -0700 (PDT)
Date: Tue, 29 Apr 2025 23:47:01 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=rdbabiera@google.com; a=openpgp; fpr=639A331F1A21D691815CE090416E17CA2BBBD5C8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1469; i=rdbabiera@google.com;
 h=from:subject; bh=lqFpTzBKH0n+hLPP3D74zDTrtj3ZCOQgeEHM7+9pKZ4=;
 b=owGbwMvMwCFW0bfok0KS4TbG02pJDBmCKd9jVzPEWE+SSrfKeOVlefIr47ZZgRELovtfTD78I
 zOVdXdlRykLgxgHg6yYIouuf57BjSupW+Zw1hjDzGFlAhnCwMUpABP58Z2R4Z39tc+rWv++8FLm
 FvHh9P/j6cJSI/Uy9HDYjEsd03i38DD84c25lzGD5yy3dIz5rdjZusJGkve3vA/pufQr/I70Zd9 1nAA=
X-Mailer: git-send-email 2.49.0.967.g6a0df3ecc3-goog
Message-ID: <20250429234703.3748506-2-rdbabiera@google.com>
Subject: [PATCH v1] usb: typec: tcpm: delay SNK_TRY_WAIT_DEBOUNCE to
 SRC_TRYWAIT transition
From: RD Babiera <rdbabiera@google.com>
Cc: heikki.krogerus@linux.intel.com, badhri@google.com, 
	gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, RD Babiera <rdbabiera@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch fixes Type-C Compliance Test TD 4.7.6 - Try.SNK DRP Connect
SNKAS.

The compliance tester moves into SNK_UNATTACHED during toggling and
expects the PUT to apply Rp after tPDDebounce of detection. If the port
is in SNK_TRY_WAIT_DEBOUNCE, it will move into SRC_TRYWAIT immediately
and apply Rp. This violates TD 4.7.5.V.3, where the tester confirms that
the PUT attaches Rp after the transitions to Unattached.SNK for
tPDDebounce.

Change the tcpm_set_state delay between SNK_TRY_WAIT_DEBOUNCE and
SRC_TRYWAIT to tPDDebounce.

Fixes: a0a3e04e6b2c ("staging: typec: tcpm: Check for Rp for tPDDebounce")
Cc: stable@vger.kernel.org
Signed-off-by: RD Babiera <rdbabiera@google.com>
Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 784fa23102f9..87d56ac4565d 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -6003,7 +6003,7 @@ static void _tcpm_cc_change(struct tcpm_port *port, enum typec_cc_status cc1,
 	case SNK_TRY_WAIT_DEBOUNCE:
 		if (!tcpm_port_is_sink(port)) {
 			port->max_wait = 0;
-			tcpm_set_state(port, SRC_TRYWAIT, 0);
+			tcpm_set_state(port, SRC_TRYWAIT, PD_T_PD_DEBOUNCE);
 		}
 		break;
 	case SRC_TRY_WAIT:

base-commit: 615dca38c2eae55aff80050275931c87a812b48c
-- 
2.49.0.967.g6a0df3ecc3-goog


