Return-Path: <stable+bounces-232896-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AY6L7nhzWlVigYAu9opvQ
	(envelope-from <stable+bounces-232896-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 05:25:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DC83831AD
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 05:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A7DE7301493D
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 03:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C4335AC0C;
	Thu,  2 Apr 2026 03:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJNVdau+"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDA1359A99
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 03:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775100270; cv=none; b=rG/Hg4l6FnAXhfl0He8hGbkcxgTVfKroS/WBYow7tedylT3Ohu4/2eA7/AYjlxxtcamCwHPUwNa4LoOVpZkyU1CfGlAiyGV4ckxxx9QA8hfeF3MfK26KErmF1BKF8zp25GreqWQPifteeaO3VxuYuoo7exda/IXaG+bTRteTb+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775100270; c=relaxed/simple;
	bh=xoAxyd23RUHtYfq932MDE3PcTF7vl72cZnWGDgo18cE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CgIXcX2fYfvJaqmX6p4gu18f8H+6CuN6r/LxgjXYQDmekdMtLcdnem2iUCw2e4FKAv1sp6K9XguhyUn6OVuMLtuvqmCZbXqg07usH5V2yyaSxv4qk06z9c2ynDkwewBtMNP4ohBHO171o4D55YQ24/fNACCPDed+BiqDi/LdeUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJNVdau+; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2ca4ff720ccso556380eec.0
        for <stable@vger.kernel.org>; Wed, 01 Apr 2026 20:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775100268; x=1775705068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lNuuLOzmr03xq4m1O8HQgZGp2bHbRJpd3HGUaao6ag=;
        b=JJNVdau+RMHXLBNoH8a91Zz51IwaIMqy1HBvhcsaDi1TwTREuROK3cMTAXSMcgHHS+
         B01dkgpVIpCyxFHFaHmd5igJAYqxNSK2iVYAtV1nuQCbO/WwAJ8xHKizVGBQPJudOsPh
         a40bEeEEueyekxgzUaMkLSBhbIoOrHIU/+arJbyzdQ8pREScDY3GTU3IJo8Nx9tloyrB
         Gx+rHr0LidAYM4eWFi5OmVg6r/Yv5zfyDcKYiY8zWB+grCdTERRgLA/lSYAkT4W0rs1z
         eHWaS5XvXG2A1WF8A3tKLev3R7ywIZZ820/NjFfpvd4CgQhbe+8dnQKArYoh6tNvFcFJ
         60lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775100268; x=1775705068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7lNuuLOzmr03xq4m1O8HQgZGp2bHbRJpd3HGUaao6ag=;
        b=aMS4D3lfMYadISiNQg/SbD0ZzUhsHK4AkKBZcm/gmdhurgc/2nbbafBRGxhYZH6INn
         2QsX2RTG7CovxH7ARKkYH22Pveu8TFjdiScXVUcTar3NbmvCTaOaEv8M9QZILyZR7hAf
         RksOVqJqUw7C7EK+G6KmFbhNqJT8BVIljEflQILjFrjeMTULS7C/mshOGSzaroD+c8BZ
         7wDeJsebCpxMNnwR7GylpBBimGZ4wkDolnJcmA+Zt0HQs1jgSE3WBkxsOD3l/JQrcY0I
         +OJ/6pOUxbAL6eRykuiMXF39FLEgzwwmoFcM+KPWQbirj5ILRWQL9TfAqwIA4gXiukMW
         aSgg==
X-Forwarded-Encrypted: i=1; AJvYcCU+Pqm115quOh0TBgBWqjbP1TTKJ0pNbw9G8kTALNWDnsBlMz18BILzAxFl6CXbCEJVWJlMq2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEQ4pfVyB6WjqbDeTm62poYl3Uuw9W0wVIEYULPMt1yeLU3pC2
	DBpqN3ZJntvTRFyoz21OBoAanuCGdV1UG+ULarntNZlk2VxgQxotrugm
X-Gm-Gg: ATEYQzwvlHY3L2e2sl3stFIUL/c8XIoDbd7ihpgYFKChIFEf1cbojOdr77xmrCSZSfS
	e1MaeTeZ27pWev0+PHOlda26DzMdYzg6QQqGJiNyHff39V7b32zdJcDq4VPPRyEJblOetGlV3fF
	2axbDHUEnluyXNbQbLC/IJ7EfZWgszEeKC5U8LjQooaKuPbShbd0EKNdwEilJGY5IlLvQIQr0j4
	Q1eISuD2ACWnP+BeUiDfPcuMX7tMNOS2/czr3pD7f+RLSGoaIU2talt3jdOoo061L0VKQx8eoan
	ceqlxu8ezLXK4TAK8+jaffRNqrjQ9bLqrZ7ChgEUwEWW1ebupifi2QnZB9/Ne4xqBTuIZIGDgi5
	D/xLNauepni43Y7FCTQVSme/oZtsrwkWFHGA6mTxjt5CJZV37meqmMY7wYYEHk0SksyOZ8XU9X7
	i6/hthbAunHCuGVPHqKuxFjcapcLhX4rQ3KshxuDF+sXRE/tpeUfnv/8vFSspyqL4okME99M2lj
	IDFeapeqsCZQOU=
X-Received: by 2002:a05:7300:a483:b0:2c1:1d6b:1698 with SMTP id 5a478bee46e88-2cad67a8282mr332104eec.5.1775100267985;
        Wed, 01 Apr 2026 20:24:27 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca7cae9e9esm1265981eec.23.2026.04.01.20.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 20:24:27 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>,
	Armin Wolf <W_Armin@gmx.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Rong Zhang <i@rong.moe>,
	Kurt Borja <kuurtb@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v7 01/16] platform/x86: lenovo-wmi-helpers: Fix memory leak in lwmi_dev_evaluate_int()
Date: Thu,  2 Apr 2026 03:24:09 +0000
Message-ID: <20260402032424.678528-2-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402032424.678528-1-derekjohn.clark@gmail.com>
References: <20260402032424.678528-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232896-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[derekjohnclark@gmail.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[squebb.ca,gmx.de,lwn.net,rong.moe,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 14DC83831AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Rong Zhang <i@rong.moe>

lwmi_dev_evaluate_int() leaks output.pointer when retval == NULL (found
by sashiko.dev [1]).

Fix it by moving `ret_obj = output.pointer' outside of the `if (retval)'
block so that it is always freed by the __free cleanup callback.

No functional change intended.

Fixes: e521d16e76cd ("platform/x86: Add lenovo-wmi-helpers")
Cc: stable@vger.kernel.org
Link: https://sashiko.dev/#/patchset/20260331181208.421552-1-derekjohn.clark%40gmail.com [1]
Signed-off-by: Rong Zhang <i@rong.moe>
---
 drivers/platform/x86/lenovo/wmi-helpers.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/lenovo/wmi-helpers.c b/drivers/platform/x86/lenovo/wmi-helpers.c
index 7379defac500..80021f59d1ef 100644
--- a/drivers/platform/x86/lenovo/wmi-helpers.c
+++ b/drivers/platform/x86/lenovo/wmi-helpers.c
@@ -55,8 +55,9 @@ int lwmi_dev_evaluate_int(struct wmi_device *wdev, u8 instance, u32 method_id,
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
+	ret_obj = output.pointer;
+
 	if (retval) {
-		ret_obj = output.pointer;
 		if (!ret_obj)
 			return -ENODATA;
 
-- 
2.53.0


