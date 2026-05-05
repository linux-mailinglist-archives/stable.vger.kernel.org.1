Return-Path: <stable+bounces-244280-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEpZK/9u+mnJOwMAu9opvQ
	(envelope-from <stable+bounces-244280-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 00:28:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AFD4D454C
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 00:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0D849301C8DE
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 22:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E84E48B362;
	Tue,  5 May 2026 22:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QrwuQs2j"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2900549550F
	for <stable@vger.kernel.org>; Tue,  5 May 2026 22:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778020084; cv=none; b=kwCHxwzLqYfGTfNIq21mmAxFTPRw8cK8kVw9ldBz+gp6oJsh08WADMA+WK5wo+5H3qYvvJ62+j0woZXXQDsOkqwgycDr8pi9ZMKQZgMT3Yjh0rVywaLpteGY7L3M2tS+/B5Z+GyExc064onbMstFYO8FDJm/Mi/cB6aljLZ5x5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778020084; c=relaxed/simple;
	bh=OITgQ8gOEiW6NO3HVvGcSLlvshVDvnjmXGEaMi7RjOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJ3OyFFoKHAHHVe/DiBLYflycbsiq780XIIG/51GcwLY4YPUXeAe3imzOu4Tkyy9NKbCe1bdDqi+2v6BeqwaMjkfpFgG4EqSPnZem2Tda7yNhR4cIC+a8hNHEUNrhOOEFOYB3/Mag9qnr5mFoutlTQCC2R1LvZNJurhMBNisUZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QrwuQs2j; arc=none smtp.client-ip=209.85.215.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-c801d732058so154551a12.1
        for <stable@vger.kernel.org>; Tue, 05 May 2026 15:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778020082; x=1778624882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rj4d9IL+hL4lojp3+Uqxu+QGmAPGmpw5YIIrwS8C56o=;
        b=BZAHVxKt1qUJsWb7yQc+uOwJ3nOKiIcpxvtsbH5KIKH9sp+scBXkejU484ClForTNA
         s1HSubk5N/TMNmt/XqgYVnhrfkGCU+oVwl5560A2dkAB6HzUSwrXpZRM+tLmF+5Ng/Vv
         OEi+dlG7BsNILs3gzbXvnjcnuFDUPdhw1TXq9ElWlN67esdkABg0/g966kBK7hnCtCXk
         VxobR5eyssy21c/rWPVQrbFG0UsaGsBKr4r5hSTr4CkX367ljgGKSMcddSp5NsgmBwjG
         NeKmGZ33dvB+nmLb7N4pVDQb0f/KENCxUzDfJCQUyywY1S3PimkBBhBM0DRl3wwVS+hr
         LXXw==
X-Forwarded-Encrypted: i=1; AFNElJ+SQGg9qiVywj12UUqzBe9ihXiVKbauxmTm7ma8bMow2PcRmOS9v9gUpnGYoEofTJ4zNtPieNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYoOqIz/WvrJXrp7wzCuHmvTYQAC5kD9V+osf1MUS+guvkHYOZ
	zli08X0Y5SkNVFwvm8gViJ8pQup/c1EsNGls4U8O4Vmz3SoBB02RbkVBU09twufMZS0H9eKa4ot
	07ovkzPD3HVIHY0ZNLrGbE5H5IwLtLCcMxX/bkkkPISvS3AfNC92mMqKS47+a2kTf+6oPKPZkew
	1+ED2grUu0XyDBqMZI7GmD6Pj+bDsI588tOPeYtmFnynpvqg6A/j22pggkOpbO8tXkqj2+rBQSe
	eCxHPFP
X-Gm-Gg: AeBDieuGMF5NCR1t7X1J2/4Tgjha8hLlbRLIYESl5bOBXJ4CwUPvxd+OZzeyPFBq81U
	Tq7caOxPe0jp46o4fmbDI0DrzjjVzUEdTQ9rhp1DWAQhq9Mm5AhFQ12Uco6FgVRa/GxTkXl/O9Y
	mkBQnQqngNl8bEoyxUQPrwKI12HchjDXaBFwbsI0yzRPJcsP3Kid65m5hodt12K8Kbs+UsJ/Hrh
	rYlGZFBeinxqC+JslGm7FQxRddByKpVxj4a94alzN/icjrnFYf9n9Hd/raPELWUbTPH5fvZ3amC
	+r/UX6D6I5EjFWpcaO7xZvbnzPPdM12Nb6T/6tz1k16ovZX4rlE/lmHdSr/20XpSO9NRrvs2JZK
	8gAnl7quWE+B5rwJxgfOCVwf5vMkjL6WlxRLS+9CmlRCzjzdh+IFIaKjDfylhpszs2ZBlsRzsHO
	Rxpsy6MsEINkc7
X-Received: by 2002:a17:902:d501:b0:2b0:be79:e521 with SMTP id d9443c01a7336-2ba4e5f89e0mr40766385ad.26.1778020082363;
        Tue, 05 May 2026 15:28:02 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2ba7bd2c6b4sm382515ad.6.2026.05.05.15.28.00
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2026 15:28:02 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50d826ed6f9so10370571cf.1
        for <stable@vger.kernel.org>; Tue, 05 May 2026 15:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778020080; x=1778624880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rj4d9IL+hL4lojp3+Uqxu+QGmAPGmpw5YIIrwS8C56o=;
        b=QrwuQs2jIQx6I/vV8rsk9eIuiHgHJDjJNbCuCR5ixmPlG9DkNkgrLHsE5azKexpRMf
         DLsQ0bPnvNvGc5Pb+SRIJBtEjwTz8w8JttGFuu2NyuUaokqrbejOB+cmDOwlYVyqqNyS
         VNPWy6dq7bnx09yP7Uqo4DCnPFL+ju/Bmc9Uo=
X-Forwarded-Encrypted: i=1; AFNElJ9XvMe6dgfV+iVodlR6PJfNmpsAw4PmZHWFqTWhoxa51QnGZfyA44ZHgM+IIOCzgCjdm1ef88o=@vger.kernel.org
X-Received: by 2002:ac8:7f51:0:b0:50f:ad91:8906 with SMTP id d75a77b69052e-513052ffe4amr74220791cf.20.1778020079948;
        Tue, 05 May 2026 15:27:59 -0700 (PDT)
X-Received: by 2002:ac8:7f51:0:b0:50f:ad91:8906 with SMTP id d75a77b69052e-513052ffe4amr74220601cf.20.1778020079508;
        Tue, 05 May 2026 15:27:59 -0700 (PDT)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b539aa6f5fsm162692886d6.21.2026.05.05.15.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 15:27:57 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: ian.forbes@broadcom.com,
	maaz.mombasawala@broadcom.com,
	Zack Rusin <zack.rusin@broadcom.com>,
	stable@vger.kernel.org
Subject: [PATCH 10/12] drm/vmwgfx: skip hash_del_rcu when validation context has no hash table
Date: Tue,  5 May 2026 18:22:31 -0400
Message-ID: <20260505222728.519626-11-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260505222728.519626-1-zack.rusin@broadcom.com>
References: <20260505222728.519626-1-zack.rusin@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: D0AFD4D454C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-244280-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zack.rusin@broadcom.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:dkim,broadcom.com:mid];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

vmw_validation_add_resource() conditionally calls hash_add_rcu() only
when ctx->sw_context is non-NULL, but the doomed-resource error path
calls hash_del_rcu() unconditionally.

The KMS validation contexts created with DECLARE_VAL_CONTEXT(_, NULL,
0) in vmwgfx_kms.c, vmwgfx_scrn.c, and vmwgfx_stdu.c never add the
node to a hash chain, so the resulting hlist_del_rcu() writes through
node->hash.head.pprev which is freshly allocated and uninitialized,
corrupting whatever happens to lie at that address.

Mirror the conditional from the add side in the cleanup path so the
node is only unlinked from the hash table when it was actually added.

Fixes: dfe1323ab3c8 ("drm/vmwgfx: Fix Use-after-free in validation")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_validation.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c b/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c
index 35dc94c3db39..45fde7ec514f 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c
@@ -309,7 +309,8 @@ int vmw_validation_add_resource(struct vmw_validation_context *ctx,
 	}
 	node->res = vmw_resource_reference_unless_doomed(res);
 	if (!node->res) {
-		hash_del_rcu(&node->hash.head);
+		if (ctx->sw_context)
+			hash_del_rcu(&node->hash.head);
 		return -ESRCH;
 	}
 
-- 
2.51.0


