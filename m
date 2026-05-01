Return-Path: <stable+bounces-242237-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOh5EdYq9GlA+wEAu9opvQ
	(envelope-from <stable+bounces-242237-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 06:23:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C82C64AA4CD
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 06:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42B5D30D2107
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 04:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA1D311C3E;
	Fri,  1 May 2026 04:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNFNez8+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666743115A2
	for <stable@vger.kernel.org>; Fri,  1 May 2026 04:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777608754; cv=none; b=SBm6dmuAeYjyhdn9UFAPQ3ZnsL2RAS4Shl7JVFxYNQrTc2QdpRNXHIKglLhnPguiNDMASg6LMO43s9EvtqfAfPDL4GSmEn8l0YbKda1eWsbFgKVAQvkWbomWBB/ULGndM3hNjZi1fFVh0GUUTd7RjtrKRqztd4TriGcOsGhE00Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777608754; c=relaxed/simple;
	bh=+Oi12GzLgtByjEF2wRqsc0NBBF8vvCA6FOOChN791o4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a7ll/f5ji1Mu/E1WkirTm3J5N7BSOSRvNaB8ArJnND+CbtdOfb2je31ms/KxQjNtMGjiSavCWhfJJyE5R4odhynciXLNyfupbuQUW67Ki/wp1Sm735oHTRRuTXesYIBWVPOQykNPAVVNht509BTpLN9TYKO72B5HqyQWpi2cbdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNFNez8+; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82cebbdbdccso968567b3a.1
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 21:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777608753; x=1778213553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FX+puozfKOk6l+f90pyqn7buO5CtmALr+6nyHUFvWvA=;
        b=gNFNez8+daeJEil9I/I4OboxepyBpMBbU/dBC7yphmqAUNCG2cOF2THHrsd0cYbe6m
         53hJHb+HmmHhJCHTwTnSftzf0scBXeRobEm6uVRt8Y3xh/Hq91WIZdH32CgYMQswhBmm
         oyaGNUWOaBlH3wVJgQ8bjcfLU4rpHFrJyKJUuL3LoJ6pwOqnAlkm6HOUmgHsbYBFFNL5
         WbnWgstYh/tyNPCI1NAgjNSVbJYAnJLiyB/EddPPHtNVEpwPS7pxEJXeW0UMpuoNWTl2
         lzG4cJb3hVUI3+TkKB4JLtPhHCTWOWm/isOHSA0JhL8NA9Vl27x5pHWQUaPbcn7HdNRo
         RCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777608753; x=1778213553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FX+puozfKOk6l+f90pyqn7buO5CtmALr+6nyHUFvWvA=;
        b=pJS8/bMCjuvWGyXu+4Swa3LUADdg2WRX29eFFA4L53azHsBVLUpOQYP74GBcE7Vix+
         bhkk6KceiP7mkCUK3axam0aLoChg8MYw1vJWlccCqmPKKoF8bsjV5TeRx7mRmhcyTNq0
         +k2D12otTgfrB9W1A4htk8iVQ6bUbV1WE6No4yCVYji2c/e+E+vJywdbGIiwo6U/ZR5h
         C0uoEsLQV0uuPk8oiJd0U2bvpeuoxQ72vhTwGQ4Cc3968LhlW8yB/WjXeEePlTzlHiJg
         mecWDQryKGZWnosAbsBRHk1gk4GcdLdS0+38fpCa8yiYNUVsS4svuqEwGyTfMllKs2KF
         GvYQ==
X-Forwarded-Encrypted: i=1; AFNElJ/aS8rp5NV616IUuby0CSXv+0z5jvUElGi2+/4XYIXj2XL8X/Pds1JscZ3/thQoyeKsEQu5zBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ500+AqfgrLXxVyGADjhN0eh3HmtBRbJM8bX4ethy0K9bJZeL
	RUj+egP8r5pb9U4aKob1Yk1oWOrtv5x39rN/kZ7C6H9D/KZncR7Y0nQd
X-Gm-Gg: AeBDieum6q6QZQeo4VBQQaYihZ8joOaVuoq/MsdORcVvHCFLpFtkXtgqLjnWJtGI+Ac
	j58ZGAEXco7RpSwA3KKEhIaapoNa+tdySAP7G9CBHHJXxaSATxldJoeyNrtz/wrH1EimhPOZTPu
	khjndUnvObxDCrX8NpMbe1LFkbyhIvBzWr+tP1rHvyR6NvJms2qs3jcT1z4vc128RKEpCJmpK7P
	AEZJpPD8jspipD8lfnjvTZpsIx3eUPXQbESOJ0fFSruMYiWaBohwmJc2xLan3QPhR3FB0RvH/pB
	4+6qSuJqKG/ommRyLj9/8vpMYCkbL3HmC2IWuhtAHKsFN/BirdZvaFfy5bI0lWJzgKVReppo7id
	rMtzY9RoL7j7OZFMPcRIamf+pjmTOl/uReUzDbWA2515qt1s72h4DVyXXpOofy8T2XMwNrukXrk
	3bAaWfdlc6sFLLxsGPNC2FUlfwvkV22BNq94wrbX93S22UuuG7NJWZqY5Nw+SvSwiXz1IuoX0DV
	Q==
X-Received: by 2002:a05:6a00:3e27:b0:82f:3774:4fdc with SMTP id d2e1a72fcca58-834fff78b31mr5164676b3a.1.1777608752763;
        Thu, 30 Apr 2026 21:12:32 -0700 (PDT)
Received: from localhost.localdomain ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515b485eesm1159428b3a.48.2026.04.30.21.12.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Apr 2026 21:12:32 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	Haren Myneni <haren@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 4/9] pseries/papr-hvpipe: Fix & simplify error handling in papr_hvpipe_init()
Date: Fri,  1 May 2026 09:41:43 +0530
Message-ID: <f2141eafb80e7780395e03aa9a22e8a37be80513.1777606826.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1777606826.git.ritesh.list@gmail.com>
References: <cover.1777606826.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C82C64AA4CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-242237-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.ibm.com,kernel.org,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riteshlist@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Remove such 3 levels of nesting patterns to check success return values
from function calls.

ret = enable_hvpipe_IRQ()
    if (!ret)
	    ret = set_hvpipe_sys_param(1)
	        if (!ret)
		    ret = misc_register()

Instead just bail out to "out*:" labels, in case of any error. This
simplifies the init flow.

While at it let's also fix the following error handling logic:
We have already enabled interrupt sources and enabled hvpipe to received
interrupts, if misc_register() fails, we will destroy the workqueue, but
the HMC might send us a msg via hvpipe which will call, queue work on
the workqueue which might be destroyed.

So instead, let's reverse the order of enabling set_hvpipe_sys_param(1)
and in case of an error let's remove the misc dev by calling
misc_deregister().

Cc: stable@vger.kernel.org
Fixes: 39a08a4f94980 ("powerpc/pseries: Enable hvpipe with ibm,set-system-parameter RTAS")
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/pseries/papr-hvpipe.c | 28 ++++++++++++--------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr-hvpipe.c b/arch/powerpc/platforms/pseries/papr-hvpipe.c
index 402781299497..800649f309a5 100644
--- a/arch/powerpc/platforms/pseries/papr-hvpipe.c
+++ b/arch/powerpc/platforms/pseries/papr-hvpipe.c
@@ -780,23 +780,29 @@ static int __init papr_hvpipe_init(void)
 	}
 
 	ret = enable_hvpipe_IRQ();
-	if (!ret) {
-		ret = set_hvpipe_sys_param(1);
-		if (!ret)
-			ret = misc_register(&papr_hvpipe_dev);
-	}
+	if (ret)
+		goto out_wq;
 
-	if (!ret) {
-		pr_info("hvpipe feature is enabled\n");
-		hvpipe_feature = true;
-		return 0;
-	}
+	ret = misc_register(&papr_hvpipe_dev);
+	if (ret)
+		goto out_wq;
 
-	pr_err("hvpipe feature is not enabled %d\n", ret);
+	ret = set_hvpipe_sys_param(1);
+	if (ret)
+		goto out_misc;
+
+	pr_info("hvpipe feature is enabled\n");
+	hvpipe_feature = true;
+	return 0;
+
+out_misc:
+	misc_deregister(&papr_hvpipe_dev);
+out_wq:
 	destroy_workqueue(papr_hvpipe_wq);
 out:
 	kfree(papr_hvpipe_work);
 	papr_hvpipe_work = NULL;
+	pr_err("hvpipe feature is not enabled %d\n", ret);
 	return ret;
 }
 machine_device_initcall(pseries, papr_hvpipe_init);
-- 
2.39.5


