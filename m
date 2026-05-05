Return-Path: <stable+bounces-244275-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEX5BO9u+mnJOwMAu9opvQ
	(envelope-from <stable+bounces-244275-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 00:27:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F7E4D44E4
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 00:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BF30D30208F0
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 22:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46D44968F8;
	Tue,  5 May 2026 22:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RPzIqvAl"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f226.google.com (mail-dy1-f226.google.com [74.125.82.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769963ED5A7
	for <stable@vger.kernel.org>; Tue,  5 May 2026 22:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778020075; cv=none; b=h8UOwhF5QwfHyHoO3dXXxFALoKlKLHHsrhvPtTB/VKjMXubgxGQYsDw/xXhFUjtSFqI1ptwolr0d1NdjaQZNzeopW89C868KiU4qpgFUpuM8EuoeZam1BvL5bfqKMchoqK1k8QoIJbHV7d8QI9XAz4TMpgUAqadpm9Hr65AxCoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778020075; c=relaxed/simple;
	bh=5ApR9WEydTgnNiUkC7RDM3+plk2WBnYI61Zu5ROOjPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vCS+YSSaRtC+/kUeeoxDU47aqWsG9HtXt/oJrNuuJ3BEqRmiJhojUmtvITel82uBVW6cefurrd54570mWyXWnt/qWNvvW2SYeFWxK8Z+pJYHPtPlPfHTBxgas8sccLPZ+yLFblVLzKaJ2ucNZ1ONzYpb2lEVVlDbV/4uwtlDhWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RPzIqvAl; arc=none smtp.client-ip=74.125.82.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dy1-f226.google.com with SMTP id 5a478bee46e88-2f33ae12f97so3527382eec.1
        for <stable@vger.kernel.org>; Tue, 05 May 2026 15:27:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778020074; x=1778624874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9QJ6qduHbEic2dYqxfK+F1VSZSIA1R8upDR4GV0g4G4=;
        b=mbeHSHinboJW7N7phxJzTjMqm8mDYlaaJBb/BHzrH90R2mQB54LWb1Lcyh4m85fIds
         HbvJHqagwIrVtnQir5S6cPoyC6Rd64EtkfVK3eepBEKT1dWVjxZDVXvggDnYDOn5H9iz
         tDjEpT4C8yVje67MrjjpZ8Y6VI1Gkbjh9I7y7G8SPjIJEH5NJwZkFoyrMnbWB43skJcZ
         Vuen1pTYzJkZCCFBcNs34AX5YtUybAk3dGLR79haBadmm9BjL/pJEfAt4StV0mlSIkr9
         hiZYRcOdo743K6dQAYYLc6ujPZedCTU4Cl1wRs03/tb1HY9/VSlVwbjbCvCJPMSzZ4Cb
         RSAA==
X-Forwarded-Encrypted: i=1; AFNElJ95acWC5FreGIQf/HKN3t9j4rKoVBzLQDv87LPlKcTmiYVxffAbM7/QgIlvYSWgEITmkr0vI5w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3tQpr5fSUbtqAo+ZzfDqHNEbCAPgRr/UqVtkB/GZXCC4i4XyR
	sIvT5HpCRhsA/GqUHlyB5j6i+W0PxrSRt2OwPrh2HsfWyQlpJikcGiDxn0np9HzuzdWD50LVes/
	/WiA8RSHOw0ww3bLZcK4+2n6bvJ19hgFrLOYcqEfFSKPUZ965iwpozaAPDOZOQd8u0BnnW9JZRN
	XGOwHt1ptcS8JIB3o5nQB8HekqTXyK1W46z23YZBo3d5NCgtRw4FcnvhE4rRE+Ky9zfEL0h57dm
	uElvOiT
X-Gm-Gg: AeBDies4AMT5dsybu4OzmaXdcc1MEoKTg3nET3G/i8RGtPtSdaXAFM9dvLrtISHMQg5
	smLtv4ThlxVm5DyMu95/bHA9rczNLm2atH6HQFZF0sh0rWRbbiSs0B0NmJWj29VZsA7LDLfLhsW
	rI5S7LDFxb2d7zbM6wnLH+zoH6cwX+b1jwDsqSPzmulmCyqV7OO4xcjtq0/K294JAZSNyymD74J
	G/Y6HmLXlSMjKIsabBVYredSHOjtAtnuPJKOP4uVRhO4qhNao57fWJLuRCSfHR06vgW3743dsMv
	8HnbxzBGuoMfCoIhtzqhWA9Y5wbgTOKMtyBTlFk/GX0xYyK+Gpx/dWSvAVdm4YAAv1DZgh65sMa
	g7IwK0eIR9hQcHJR23cBZk+KT7fn42Z/dVqjUfFzceAnZyDlBYI2tiLcdkAW1vKIAnuEiaSEyZo
	X239/acEc4mNDnSpeFQPHk8li9GU5OfKUgsF+KRbp3Pg3UFFWg7V22Q4gAcCUKi5W+q00=
X-Received: by 2002:a05:693c:3013:b0:2e7:af57:3b72 with SMTP id 5a478bee46e88-2f54b89a18bmr613629eec.29.1778020073565;
        Tue, 05 May 2026 15:27:53 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2f570286f64sm37077eec.22.2026.05.05.15.27.53
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2026 15:27:53 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8b5ceedb5c1so98512716d6.0
        for <stable@vger.kernel.org>; Tue, 05 May 2026 15:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778020072; x=1778624872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QJ6qduHbEic2dYqxfK+F1VSZSIA1R8upDR4GV0g4G4=;
        b=RPzIqvAl4tUAfVvL1NhQEzUPBP1+RqsRNPs0k3RRpMfReZebpn7VnJoqIClEv9eKJG
         mhd2gyowQoCVnwnYcLyMTl1/lVdDcjwrYnKcj/UfK1aLzPpOqldcNhtXzsYU92HdahwE
         EOai3V1O+G/VC0QzTPRO5n7jvUpgleV76LsBk=
X-Forwarded-Encrypted: i=1; AFNElJ9ckM1kN5U6WFNWndm90BiXgBA4+tgapXeQHH1Abe8o3lfELU0j2dEwHBlLr9/DCodEbnSXL4s=@vger.kernel.org
X-Received: by 2002:a05:6214:e84:b0:8b8:88a0:1061 with SMTP id 6a1803df08f44-8bc467e0d04mr10605516d6.36.1778020072017;
        Tue, 05 May 2026 15:27:52 -0700 (PDT)
X-Received: by 2002:a05:6214:e84:b0:8b8:88a0:1061 with SMTP id 6a1803df08f44-8bc467e0d04mr10605016d6.36.1778020071436;
        Tue, 05 May 2026 15:27:51 -0700 (PDT)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b539aa6f5fsm162692886d6.21.2026.05.05.15.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 15:27:48 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: ian.forbes@broadcom.com,
	maaz.mombasawala@broadcom.com,
	Zack Rusin <zack.rusin@broadcom.com>,
	stable@vger.kernel.org
Subject: [PATCH 05/12] drm/vmwgfx: drop dma_buf reference on foreign-fd prime import
Date: Tue,  5 May 2026 18:22:26 -0400
Message-ID: <20260505222728.519626-6-zack.rusin@broadcom.com>
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
X-Rspamd-Queue-Id: A7F7E4D44E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-244275-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zack.rusin@broadcom.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

ttm_prime_fd_to_handle() returns -ENOSYS when the imported fd's
dma_buf->ops do not match the ttm_object_device's ops, but does so
without releasing the reference acquired by dma_buf_get().  Any
unprivileged renderD client passing a non-vmwgfx prime fd through the
DRM_VMW_GB_SURFACE_REF{,_EXT} path leaks one dma_buf reference per
call and indefinitely pins the foreign exporter's GEM resources.

Funnel the error path through the existing dma_buf_put() so the
reference is always dropped.

Fixes: 65981f7681ab ("drm/ttm: Add a minimal prime implementation for ttm base objects")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/ttm_object.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/ttm_object.c b/drivers/gpu/drm/vmwgfx/ttm_object.c
index 2421b0dd057c..f9042bafdc93 100644
--- a/drivers/gpu/drm/vmwgfx/ttm_object.c
+++ b/drivers/gpu/drm/vmwgfx/ttm_object.c
@@ -547,14 +547,17 @@ int ttm_prime_fd_to_handle(struct ttm_object_file *tfile,
 	if (IS_ERR(dma_buf))
 		return PTR_ERR(dma_buf);
 
-	if (dma_buf->ops != &tdev->ops)
-		return -ENOSYS;
+	if (dma_buf->ops != &tdev->ops) {
+		ret = -ENOSYS;
+		goto out;
+	}
 
 	prime = (struct ttm_prime_object *) dma_buf->priv;
 	base = &prime->base;
 	*handle = base->handle;
 	ret = ttm_ref_object_add(tfile, base, NULL, false);
 
+out:
 	dma_buf_put(dma_buf);
 
 	return ret;
-- 
2.51.0


