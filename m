Return-Path: <stable+bounces-242977-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFv3K0Nw+GkYuwIAu9opvQ
	(envelope-from <stable+bounces-242977-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 12:09:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E9F4BB739
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 12:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ABF923004D11
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 10:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900ED39099B;
	Mon,  4 May 2026 10:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N12UaExJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951AB392C4F
	for <stable@vger.kernel.org>; Mon,  4 May 2026 10:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777889314; cv=none; b=Z8TCXmIyZbC4L6VEpXb5ZrOWsLmVrP8Vuv2+tY5NrCV9S28sX9dAxUUwP+4ZjUxMmDa9h4lMLEXKbV8JM3BZaZw/MEiLckpqri0qRIKFXKbcCmBFf18axWmYMMsnA8y+8jTnLXWEGaP6Qb464DdKoT5J71MR7OXRq7tQ4DBLjl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777889314; c=relaxed/simple;
	bh=Zs9WNTC83oSjBnoN+C/Zgou1KF6Ibnz5FPkh61SSYcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S9Qxl0P576MrpeJyqm4bmJvgLmjKgCmu6ubagfdfZWonYlRCeqfIbjQvjg6aT4yYTbueFnGpaGP31MG0K5LJiO4QPA2eZcMzTT+S4yr/zdPLUY6lGPsICbe6IS2m0pp2jwHXfxCdLiVlUzlxZjiFYvRowQ2CFoCDF/lFf3eQCZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N12UaExJ; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3937ac12828so13375471fa.0
        for <stable@vger.kernel.org>; Mon, 04 May 2026 03:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777889309; x=1778494109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=efcgj+nt9ZDETRdVUhLvA9ywV/eZR7SxjX6DhlexZWI=;
        b=N12UaExJyKpAKgewnzehNv/g10mi4LDH1p3cmvNtL6OPCPXijVyYBNRvZ6CANfKkbN
         BzErs9AiOwD8odoncPzVggXvX12FZCi7mo2yMyXXOfLFWdNs8Ey46xrbGWmgGrk2NsWz
         xHxnNoCN8/fghVh84TuvolNl47Ye6WQcFY1iRC+nax81rAdiQDyuILPZZyfX+Ut5LMXx
         cGCaX1fR9ObujivWmvhHRdHk/uBHhWWoLancmwLm/Y1Rvj/i30P9wa/vg1cv3838hz7o
         o7cy/0sZHFhmjrOF6z3eCJdSj1NyYKiWmSPth9DtjWV7ISHPh96hwQxicNP8NetXAonC
         4qFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777889309; x=1778494109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=efcgj+nt9ZDETRdVUhLvA9ywV/eZR7SxjX6DhlexZWI=;
        b=C11WV1i0MJeMhI/xfPSXZmEQ0j/2Pz3iJYVwmnLU6g/4x3ripDzoVR59WjyZMtqiue
         KmWrMubI94iUvVCc/EDGpeL45OUDvEav+QM/+/AGOIUm9VPOSRhJQl3mX9+ubYXz8S/Q
         jjsnGAhudbi4ehduFSwXJjwP7jPvb8tmtWWRRwpSxH/9V6bUENG6rcC3Gfz1KdXLY4ph
         4UysZh/DVQ9wpiu3NfGt1LBQc4wxdoUThzbFrzxUHNXZ0SoQNoOw6kwgm8sp2Z63Nexy
         +BulcRrWbrnCnj98PGk1hO669biewWKKusRB12l1OjLNm+ewP6rBJnddLBmB9l/0h3Zh
         Cstg==
X-Gm-Message-State: AOJu0YyIwF+JP7KrJS24X9O8hPP4oRUVYQiEclrP3SI3Rp2IHTHLVckO
	seQlC7a/s5ctmTdy5Pn+weofWm8d8ILxnHVN6P4y0tZjoh3kohOuvyz2
X-Gm-Gg: AeBDieuvgZlBc2agQHtxotxHGcbK1C1vXnuPUr2+M0yWkCvf1gEuw95zYWhVoTu4WtK
	Im+A7T2q7okjV7MLGVMFqfkrzmbilNp43j3UO7eKx3XLmgnhMeMe9aPTxYFhg0HjgLt+3kApx/p
	77BiqWS0diOlO+GctybsyvRiT/tSp37V30UWl3Sw9jRlGlGvmMPUIHVcsZ5dwQ2bLjk2ULzGmKX
	6m+6Xh8jtkigIVtE3MDDiTSwTEKb8B5w0PWL0NSqL+Qmsf2DiyX7ubSiZQc7esWnEX/Gvoi0wd9
	KWQNE1tHwuBHWx48ySHUEgTbs80bmmS/z1VQIQO7St5jnzdQ+DpDTbkQTu3OlpR35d8ODBN5aHj
	2pSZL0Xem3wLCDF+9z2L39JRY+qJ3/ro63wMG+o2vrKEVP/NAEvD7a8MZuoCt/TdjnAbZNP0rzr
	bHmELXyInMsaWmyr8i/C/WXq3KyrYfKfEGnIJoeVhEHNQc2yT/LzvbU0y2pO3+i9jko3gSnLk=
X-Received: by 2002:a05:6512:3d20:b0:5a4:b02:66b1 with SMTP id 2adb3069b0e04-5a86212766fmr3639550e87.9.1777889308613;
        Mon, 04 May 2026 03:08:28 -0700 (PDT)
Received: from va-HP-Pavilion-Desktop-595-p0xxx.mshome.net ([193.0.150.248])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a85c33c2ecsm2856217e87.42.2026.05.04.03.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 03:08:28 -0700 (PDT)
From: Vastargazing <vebohr@gmail.com>
To: vebohr@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH 5/5] mfd: sm501: fix reference leak on failed device registration
Date: Mon,  4 May 2026 13:08:20 +0300
Message-ID: <6b4a9f5ae8a316b6f07f72f2fe3f0b8fc5f18dff.1777889235.git.vebohr@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1777889235.git.vebohr@gmail.com>
References: <cover.1777889235.git.vebohr@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B2E9F4BB739
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-242977-lists,stable=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[vebohr@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

When platform_device_register() fails in sm501_register_device(), the
platform device allocated by sm501_create_subdev() has its struct device
initialized by device_initialize() inside platform_device_register(). The
error path logs the error but returns without dropping the device reference,
leaking the memory allocated by sm501_create_subdev():

  sm501_register_device()
    -> platform_device_register(pdev)
       -> device_initialize(&pdev->dev)   /* kref = 1 */
       -> platform_device_add(pdev)       /* fails */
    <- dev_err() called, kref still 1, sm501_device_release never called

The device's release callback (sm501_device_release) calls kfree() on the
containing sm501_device structure. Without platform_device_put(), this
memory is never freed.

Per platform_device_register() kernel-doc:

  NOTE: _Never_ directly free @pdev after calling this function, even if
  it returned an error! Always use platform_device_put() to give up the
  reference initialised in this function instead.

Fix this by calling platform_device_put() in the error branch, which
triggers sm501_device_release() and frees the allocated memory.

Fixes: b6d6454fdb66 ("[PATCH] mfd: SM501 core driver")
Cc: stable@vger.kernel.org
Assisted-by: GitHub Copilot (Claude Sonnet 4.5)
Signed-off-by: Vastargazing <vebohr@gmail.com>
---
 drivers/mfd/sm501.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index 0ee6d8940e69..8276456b142f 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -704,9 +704,11 @@ static int sm501_register_device(struct sm501_devdata *sm,
 	if (ret >= 0) {
 		dev_dbg(sm->dev, "registered %s\n", pdev->name);
 		list_add_tail(&smdev->list, &sm->devices);
-	} else
+	} else {
 		dev_err(sm->dev, "error registering %s (%d)\n",
 			pdev->name, ret);
+		platform_device_put(pdev);
+	}
 
 	return ret;
 }
-- 
2.51.0


