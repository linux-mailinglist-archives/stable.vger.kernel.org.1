Return-Path: <stable+bounces-237677-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPPnBOh43WnbegkAu9opvQ
	(envelope-from <stable+bounces-237677-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 01:14:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A27F3F436E
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 01:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AED7730377BF
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 23:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB5C3939A2;
	Mon, 13 Apr 2026 23:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKUbkIwO"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9A04A0C
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 23:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776122070; cv=none; b=G7SJ7fp6Cm32bJaHcj9mBD12HR6roTicX9CrR6FtE/zt4WkQDQyrrwT/aB8JDF6pa3heLqG6NN4c3Ud7mafJgdfgGi3bCuy/VCorh8WhE9RxlzYnKINmnlIsUXnf6rwTamAbjyMeLkYHczw3OMHZlVuFO+Ho7TBKN079sbMus5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776122070; c=relaxed/simple;
	bh=ji2Va5v84kYBjDNGJ7vQaJdlyFW07sYBWEVS84BZO3M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uKPGfdcZkUSQZ4EI5kKAjcO330XLfPSBkjIFTReGqN6vSCFO4OOzMychcXa2JkCJjDyUHz8ELe+cLU5Ik/vVxyvWis/zV1WI6qK8ollCHZ2BTaRN5ZjZigHFQy6OQyVj93FWESzlNE5lLigRMBds+8dUdXEegyQqcOB3JKKCJf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKUbkIwO; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2aae146b604so35507045ad.3
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 16:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776122068; x=1776726868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8qifmdnzaAxfEy4w4Mah8qbIqZ2DwqSxS6VwV60LoDg=;
        b=eKUbkIwOloLn1Z9HMaUNQA/qKxm6m0WbyEI1eghFBL4jjOlro/yePKzel77OMm060K
         z45BTDeueVnGZTY8/XLpZ2PrfqpMQbslfHmKYN9L8xuAj+URgSulE0DW0Q9D9yJKIdEq
         ERXItAi//jgNQG4wQK787OYRsohOlg0VpDraawNbIwXIfuUgkjjTC67H7z/kHti3wxoL
         oCGrlOfhs7QNglUaTk3QyMeTgLiHH7fYRdMeCtRr8MP/lu7W6tmznK//4byv8Pxfd1cW
         /24yry9m0YpRSe15T38UU+e83tLe1nGHvYLcRJ6C3D1JW25a7AMo9G1z2uvNDwBdXP09
         bUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776122068; x=1776726868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qifmdnzaAxfEy4w4Mah8qbIqZ2DwqSxS6VwV60LoDg=;
        b=bINMWrZuOlLacOdOdYkC+/Ji82hoYkTkGzzSJpRGm0uq6GJWc3kGMQDrfNDPeFYtMQ
         HRTpDM6FzJtG2wuleNv8WdItk7mgiDhls7gBoAqXSHu46IrWGxY1B/QalJU+03UWe9So
         H5e9gUAMLBZsVRpk5bLGnBNcV9wfqADz04TOy84vyIef3T5LQVR5cTGcyNACVH85Uauh
         37POZy8OPb1Gb+SGYPaGFQ9BJ95+Z/bWR5DQmIFQHHohhzVtAdEVEwYsJWODpbfRAsI8
         B1uvtOmFSGIv02dtbOuNjW19taCv3JXw7F9DImp3sRXLlrr0PuG8CHu8X+OUYzQ8U6jf
         a1ow==
X-Forwarded-Encrypted: i=1; AFNElJ9rHp5JtpzH4YHNTP6sJnFW/ACoBwn4qcEwM+E4PHnreixUEo0z0T2xw6TK+Cz8dn0CKl408+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIsxsA9/5BTBOnakxaycKehuRfLmV5hCJJRD0xqqr5b/ySP3ta
	XUimEZqB+tMLm7ryChooJXDW1hpX30c+vmlHlglDN8vCbh5JfGaKRiNRQ3/HwDXu
X-Gm-Gg: AeBDievlquFWho44liKJzWXa7BTGzgkHPWHxHYh67zBzeLNXy6+OHgM3Fyl8euYn5gc
	9wzmGLgCzPiHW5o/JwvlqjvmkWgpbG/U6IUtHJpJk/Ni+hLtDDUvZUqMfhzfTenCmQzZnjq0fn5
	vyXwJrlktp3Pg/RfW+AUzaabbO2ZMo+nLdF8tIXH6kLU2tkNzJcB+LfGV6UL3/eKqMcESvVOWR+
	8XuvsRmRcn1esJIoBQgqHOF8ZY5bgI39RKN8WVSqUUOSloflgj1zhr7VS2rp5g14nASWI7rpGPI
	hRQhkvGepDZTOFv0Ny0DABe8646uHrYXhwxRYh0I55BoESNNlYF0dbaYetHK8zn7QnGzKYgIN9m
	xha2hyeMb1w5f5P90CJkQTOWVCMsWN6GRdbu8nV2NjhsGQvuS5AQLztQ3Vrlfxymrucq439zQqd
	e43h4SSgRHEDoB8Hks2X7/OvL/HP7orcxYY8HLl1TRwlx1
X-Received: by 2002:a17:902:8211:b0:2b2:d126:4e77 with SMTP id d9443c01a7336-2b2d5975bdfmr107459265ad.11.1776122067624;
        Mon, 13 Apr 2026 16:14:27 -0700 (PDT)
Received: from anarsoul-xps15.lan ([2001:569:7c09:b500:8461:f909:7a3b:1c4c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f43994sm129635805ad.80.2026.04.13.16.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 16:14:27 -0700 (PDT)
From: Vasily Khoruzhick <anarsoul@gmail.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vasily Khoruzhick <vasilykh@arista.com>,
	stable@vger.kernel.org
Subject: [PATCH] EDAC/i10nm: don't fail probing if ADXL is missing
Date: Mon, 13 Apr 2026 16:13:53 -0700
Message-ID: <20260413231413.73987-1-anarsoul@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-237677-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anarsoul@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arista.com:email]
X-Rspamd-Queue-Id: 9A27F3F436E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Vasily Khoruzhick <vasilykh@arista.com>

ADXL is not present in Coreboot- or Slimbootloader-based BIOSes and as
result, the driver fails to probe there.

i10nm does not require ADXL for decoding errors since commit
2738c69a8813 ("EDAC/i10nm: Add driver decoder for Ice Lake and Tremont CPUs"),
so we can just switch to driver decoding when it's not present.

Cc: stable@vger.kernel.org # v6.1+
Signed-off-by: Vasily Khoruzhick <vasilykh@arista.com>
---
 drivers/edac/i10nm_base.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index 89b3e8cc38b1..69a4a255e4c8 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -79,6 +79,7 @@ static struct res_config *res_cfg;
 static int retry_rd_err_log;
 static int decoding_via_mca;
 static bool mem_cfg_2lm;
+static bool no_adxl;
 
 static struct reg_rrl icx_reg_rrl_ddr = {
 	.set_num = 2,
@@ -1208,8 +1209,14 @@ static int __init i10nm_init(void)
 	}
 
 	rc = skx_adxl_get();
-	if (rc)
-		goto fail;
+	if (rc) {
+		/* Decoding errors via MCA banks for 2LM isn't supported yet */
+		if (rc != -ENODEV || mem_cfg_2lm)
+			goto fail;
+		i10nm_printk(KERN_INFO, "ADXL not found, falling back to MCA-based decoding.\n");
+		no_adxl = true;
+		decoding_via_mca = true;
+	}
 
 	opstate_init();
 	mce_register_decode_chain(&i10nm_mce_dec);
@@ -1243,7 +1250,8 @@ static void __exit i10nm_exit(void)
 
 	skx_teardown_debug();
 	mce_unregister_decode_chain(&i10nm_mce_dec);
-	skx_adxl_put();
+	if (!no_adxl)
+		skx_adxl_put();
 	skx_remove();
 }
 
-- 
2.53.0


