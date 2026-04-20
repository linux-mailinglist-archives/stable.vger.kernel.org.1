Return-Path: <stable+bounces-238954-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMraBl8y5mkGtQEAu9opvQ
	(envelope-from <stable+bounces-238954-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:04:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A69342C93D
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0D2CE301A693
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 13:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B023E9F93;
	Mon, 20 Apr 2026 13:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ah5RLloF"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51CD3E959D
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 13:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691504; cv=none; b=HJ5bAqzP+P9N51QuVgQxVu8Mdemwr1DQOxWUtk5MhERhB20MjDCIbDSmuvFGs95jhgKXb4qj9rCFTcw8Fmqo+6OQZyLbJj2zPODQlp7ZEVXqS7VumZoK8R5pf017JgyHBo5V4igA8jNjOkDPpb9NTLVjYW6ztC039wI/BrwlmMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691504; c=relaxed/simple;
	bh=ZOSRbokGZapfu8PcFVycPRLR0QXSPkkl/mLiRDTmFNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=egxisaTA1v6b7NWYck8hEbXFvJ1O9J+e38aac6+NjLbYx5n4x3jG9bwHa8LpVUaL6k0KvkgVhbuoQ+J8HPt3R8AKWINtNjjdkENTverf838ESsoahsd4iIlAMXADG/DIKWFEn3WeKtdHbBUcMTk8AN9QgDwp5rj1KGoChUiSxww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ah5RLloF; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c795a47186bso1117020a12.0
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 06:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776691502; x=1777296302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gr0oztocKaKLkdTKEsH8odatBVVrOkD1g/pdHlqb6Es=;
        b=ah5RLloFm6yD4ohlcWE3LfGOJidnkDgYhywVG6EL7UrV98U4X5laPQovCUQll+ScZ/
         tIpoiCggfHF3RiMclo/9Ey9powapy2xdCiYAxqVKxnxDaPfVaUTjZ8CJeRGQXjNoscs6
         zDJwPoq2iqGWf7YUNpRHbdP5Yh12/jy9H2FByRZ3WJvtOS1UzgS8DQQxIcyeTOT+13Gc
         RR8RidPain9/gwja36CktI1kWINBC+7d0eyc2BsI3XTrtXi0IZlvsJxuENnrGHM+FfXx
         lq3MWemcwm4P1rimcVZnCQ1FUrzh/dTQDZCCJDEFieFqopXCKU38EsZCPL+/eCu7B1mZ
         IfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776691502; x=1777296302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gr0oztocKaKLkdTKEsH8odatBVVrOkD1g/pdHlqb6Es=;
        b=Ml/iD7AS6pUKYwzadmPMxewA6w4oVt27XIQ7vzVIo2skdz5IdEM5tnFSkqXF5UWLVn
         dBJNGq5UiVxCFJp3adPzu4tYydckrE0j2tkyuoKCInF5X6ue1SmdH+tJT+QIsDT1Yshb
         5jzG8Gt12PEwo/LcKvpOyZrhAxMNEc8vF87n299tcHdRl/6pxBpcR2syjW8n40zNy1CH
         5EGzNBqYeFwBnyeW9+DB4+wlrjZmKWqETAa3Gr6VZ9o3NngOFa0vdH/lU7XrUDHyAnWf
         PmxijeptUn2ealoCo5z2TJIqNDStw0pNamSXRPK7feuYW+xUSj3FoBzQsaFrbSNQquWZ
         wGiw==
X-Gm-Message-State: AOJu0YwkL3pqQVyIwKMBC1bdJG+hUR85aFgKjAInMlJCgvxGhcHWv7Po
	26nFfRNPi1vQCpyp4BBXH14zEmdWa6rOgLzB26fuUc+kFVnsWfXGUCPQ
X-Gm-Gg: AeBDietA8TfNXQ8eeypt2Q0EdfS6FLPW548ffaMtzHhDHujqTtZQ/j4BydOpXpY58L9
	S4sD56mQ/hNGD+JreFpHWdW2+Tyg1MB4E/OjSMW4ZXUAdD0lSY8bGvQ+MeNY6w3+0zEhFf7iriU
	3yclIU/uykAjp8WAaOzOE53D8PPF+2ZU2lvdVrLx76vQ/ET3txkjKWQ+hYcP1N9G39293J0j7Ks
	Y8AoiHsY0Ks2UozjriPKRVd6DwZ9SvAlPHW6qprqNo/BwdiukzYi2FPiFICEcCAAYS47QQPYX1C
	eQ2yhkidaGFRZ5dC4Cj9kAsr/YeNbOa4YZKm40lNocGhUh9dJEM9ToF4hK7ulvwrdbDdHQr5ELQ
	XkgLo7ZJ2228YysFk1QTABjik5Z+ZPZlrbg+uarij0DF7sCz17QWyfyAKsplaaRLcULYtJ3B5vQ
	u0UJdUY23Tej2o7Ns+Y/JZy6yeVYYREwvoysQ=
X-Received: by 2002:a05:6a20:3d06:b0:3a2:d5b8:bfa7 with SMTP id adf61e73a8af0-3a2d5b8c92fmr2099312637.1.1776691502065;
        Mon, 20 Apr 2026 06:25:02 -0700 (PDT)
Received: from lgs.. ([2408:8417:d50:4775:1153:f731:14e3:b103])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976f8fcbdsm7907037a12.6.2026.04.20.06.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 06:25:01 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Haren Myneni <haren@linux.ibm.com>,
	Tyrel Datwyler <tyreld@linux.ibm.com>,
	Christian Brauner <brauner@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2] powerpc/pseries/papr-hvpipe: fix NULL dereference in handle creation
Date: Mon, 20 Apr 2026 21:24:29 +0800
Message-ID: <20260420132429.128075-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-238954-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,lists.ozlabs.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1A69342C93D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

papr_hvpipe_dev_create_handle() transfers ownership of src_info with
retain_and_null_ptr(src_info) after anon_inode_getfile() succeeds.
However, retain_and_null_ptr() clears src_info immediately, and the
function then still dereferences src_info in the subsequent list_add().

Store the transferred pointer in a separate variable and use that for
the list insertion.

Manually identified during code review.

Fixes: 6d3789d347a7 ("papr-hvpipe: convert papr_hvpipe_dev_create_handle() to FD_PREPARE()")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - Fix the Fixes tag to use the documented 12-character SHA-1 format

 arch/powerpc/platforms/pseries/papr-hvpipe.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr-hvpipe.c b/arch/powerpc/platforms/pseries/papr-hvpipe.c
index 14ae480d060a..497eb967611b 100644
--- a/arch/powerpc/platforms/pseries/papr-hvpipe.c
+++ b/arch/powerpc/platforms/pseries/papr-hvpipe.c
@@ -480,6 +480,7 @@ static const struct file_operations papr_hvpipe_handle_ops = {
 static int papr_hvpipe_dev_create_handle(u32 srcID)
 {
 	struct hvpipe_source_info *src_info __free(kfree) = NULL;
+	struct hvpipe_source_info *owned_src_info;
 
 	spin_lock(&hvpipe_src_list_lock);
 	/*
@@ -509,7 +510,7 @@ static int papr_hvpipe_dev_create_handle(u32 srcID)
 	if (fdf.err)
 		return fdf.err;
 
-	retain_and_null_ptr(src_info);
+	owned_src_info = retain_and_null_ptr(src_info);
 	spin_lock(&hvpipe_src_list_lock);
 	/*
 	 * If two processes are executing ioctl() for the same
@@ -520,7 +521,7 @@ static int papr_hvpipe_dev_create_handle(u32 srcID)
 		spin_unlock(&hvpipe_src_list_lock);
 		return -EALREADY;
 	}
-	list_add(&src_info->list, &hvpipe_src_list);
+	list_add(&owned_src_info->list, &hvpipe_src_list);
 	spin_unlock(&hvpipe_src_list_lock);
 	return fd_publish(fdf);
 }
-- 
2.43.0


