Return-Path: <stable+bounces-238148-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLojI86y32lCXwAAu9opvQ
	(envelope-from <stable+bounces-238148-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 17:46:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2F340610B
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 17:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6954F302BE9D
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 15:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAF93E3141;
	Wed, 15 Apr 2026 15:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lL3gIjWB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A09E3E2771
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 15:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776267952; cv=none; b=RXITve35gR+41xFDDyLqgMUHpjtjVNR7NJ+8ttBtHM4PtXiR15V9muu0zBQ4/5Wy2qqEAaIVnAT5IS7q9X+qx5gui6Nj6OhdJCWNs3aWxqaKprIMbzVLWP9TJ997KgWkfCYwtHI4NKTDmxvcDHqWzkPyrfMTpsdA9BEnBKFmfCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776267952; c=relaxed/simple;
	bh=gh7C2dUIZG4hFmy7cefMS/4bTu2pI3aYjrPn6rlC3xE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nRAidcMvtl89JAwAECi6bPA5PhjRBH55jpD+NmLlZCr1IhHaP5UzEFdsJNi7ctVQsQwG85ZFLxJBcLMqcEp4ZuSxRBdhQnINtrdodInlcfR/FzTGnvAqXEBuFAj2YmnqAFxYu9twzTknrJeVgOyEPQOxaU23y2hcqT86itjlcy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lL3gIjWB; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82f68b3aaf7so340910b3a.0
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 08:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776267951; x=1776872751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TnIFZObf5ErHGAi6LOPmajn+8u0D4ZmRXDoAcGE05pE=;
        b=lL3gIjWBeTBIX8TUGQVxde2jhgDTUpaf4MFozRqkyLw+KlwQUwhtugkpqln+ZHXzb0
         pgPrdUYyF1KQdQ7chAMkIfA4cWid1L5V+nax/GEzAt8ZLl6e3mGiQ2KchPekhfbTh2ww
         fWFyIQusrnZxdkAOHvdhGYupPweWN96JT3gZ3ZGPn5HRMVZpFevjDDE05hj45Yg8mBNI
         aMns8yQmHY98n+xU0zY2MZG2LmdAUNgF+brDbSWhDp/73gdYWs97/fVW8qWKizPa2Q/8
         8MZOtZxPE051JrpGc30lgb0mKnU7dW+gp5zoMwQiPkiTD5bdlGgDhorBhy34nQvm47eJ
         Ahyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776267951; x=1776872751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnIFZObf5ErHGAi6LOPmajn+8u0D4ZmRXDoAcGE05pE=;
        b=aTfpf41WQ/FiDMDpPf3LrtbVheMPJxoA/n55vWKMwGo4xe6cDdIZbbdWbrJeQsfjIl
         kqGxF8DIWZCVQG0Qk/5Mass/zMloSRhvSlU48O5hjsQMHUGUDHLinRTnwxfWHksep8q2
         5uiqlgKUVrjF2TMT6CEyO4tyPl5ini3JaqQftqImSBYLe8Qls6R9sUUwFgyo82/8IqV+
         q2FVJ66pRfVCEagdA5p2Hv4fR9/ffluGMo0vASzkj5l57dZ7HushiEgah3ymrS63mxrs
         J5FjWOfWdRfPzjZBYMNGiuo/PtdHCNmoaMC/ismVxlj1KEpdSniRbEjRes6baAakGOPQ
         Lp2w==
X-Forwarded-Encrypted: i=1; AFNElJ98Eq+un4beQjN6WqGZlBqP0LwNxdU0yZxdaYJsOl1TclrPFfN7Y35HuhNiI3t0Yz4mVFEmk64=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa3bMYVEcDGQK9CkTieu8SfO+bnzPZel2ei+/s4UJOGApikA2A
	CWEVlECBW4fGYlfkYReRhoFiBWnf06n0mDViYyFgO0MYxLizFFe8zt1D
X-Gm-Gg: AeBDieuZDfQYOqCgZy+uZwmFMxtVc2TnrN+i/Tp2wJ6B4fgqdmy2Z34/KIIGzrJ1kOV
	foVNF9r9dSr5RQEnp3X73/oFcIen1ISWoeFDmaVusEWfaERZnTFb//TsYEziMu3R+T3EMYMbMPg
	4EB+orrXzZhQ9eA7Ly6oG2yef/eoO5s9JU6H9OeRjuwcdcX7YYS5qadlj7vef+9FP8tnZuaX/XZ
	7GeRfCl/0V40TmL9ydEBfpT1NxJH8mFNmXlWXOTG37oy17Ma2Hi+ASB3XvoYYjPQS+m2ka0TH7a
	U0aLLbtVMW4aSjF5UwJaVXxmnifE7cI9SL8dlEe1Gc4OpeoZAWL0Fg+U7oOXIfyLZQJTOuUqWkg
	gt6RTpdqEwdDTPQa80yhQdwAHIDEwP5jr1EXkzK24by6soWC7mLZCMPWnsxSO2yWCpYYfQxNLVW
	qOpcViXWZD0iV++vptpP2Ny0iUlNfPvJGp
X-Received: by 2002:a05:6a00:1ad3:b0:82f:6be8:6c0e with SMTP id d2e1a72fcca58-82f6be878e3mr2380350b3a.45.1776267950573;
        Wed, 15 Apr 2026 08:45:50 -0700 (PDT)
Received: from lgs.. ([112.224.67.108])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f67476a5fsm2506233b3a.60.2026.04.15.08.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 08:45:49 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Shuah Khan <skhan@linuxfoundation.org>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: vimc: fix reference leak on failed device registration
Date: Wed, 15 Apr 2026 23:45:37 +0800
Message-ID: <20260415154537.3451732-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-238148-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DE2F340610B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When platform_device_register() fails in vimc_init(), the embedded
struct device in vimc_pdev has already been initialized by
device_initialize(), but the failure path returns the error without
dropping the device reference for the current platform device:

  vimc_init()
    -> platform_device_register(&vimc_pdev)
       -> device_initialize(&vimc_pdev.dev)
       -> setup_pdev_dma_masks(&vimc_pdev)
       -> platform_device_add(&vimc_pdev)

This leads to a reference leak when platform_device_register() fails.
Fix this by calling platform_device_put() before returning the error.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: 4babf057c143f ("media: vimc: allocate vimc_device dynamically")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/media/test-drivers/vimc/vimc-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/test-drivers/vimc/vimc-core.c b/drivers/media/test-drivers/vimc/vimc-core.c
index 15167e127461..fee0c7a09c4f 100644
--- a/drivers/media/test-drivers/vimc/vimc-core.c
+++ b/drivers/media/test-drivers/vimc/vimc-core.c
@@ -421,6 +421,7 @@ static int __init vimc_init(void)
 	if (ret) {
 		dev_err(&vimc_pdev.dev,
 			"platform device registration failed (err=%d)\n", ret);
+		platform_device_put(&vimc_pdev);
 		return ret;
 	}
 
-- 
2.43.0


