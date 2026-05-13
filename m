Return-Path: <stable+bounces-246752-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EL4AImcPBGoMDAIAu9opvQ
	(envelope-from <stable+bounces-246752-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 07:43:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE5D52DA83
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 07:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F06383044BA0
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 05:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAB73A6B78;
	Wed, 13 May 2026 05:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9ZSlOdZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1BD3A6EEF
	for <stable@vger.kernel.org>; Wed, 13 May 2026 05:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778650974; cv=none; b=eRIUIm8ifvILyeMqU7a6KSBWXoe/g8z8DW9Tz+lEPthb0oUxuv2JN/TVoCXTthQwiAoJVpDVVO8jbJh98DxEknvBNIo7/jdwYVrlVeTdU8izyRloV8ZXJ8DFQ0j0O0HOe1o50s2c46rFeNgB6mLcWULdAXVBD1v1LHvGMZYoiDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778650974; c=relaxed/simple;
	bh=AUFheTiaIdq9G2k4NVJD81/GQk2hPB7b+FIJOQIso9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=me/LgLWQEdYpJsMYLCUjtC/jJ1ATP/D67feDxrEIiQop2h94WlvXIgFuDfvQF5XHl2LS3h/GyZdJG/ShMsNPtABwi5uzX/Ckwi+uplA003bNLan1Udhp2rk30I9vVOdPPhrKoh99UtHp/B40ZtAzPlFBw8J0HGQGUnLP7gVfsrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9ZSlOdZ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so57458845e9.0
        for <stable@vger.kernel.org>; Tue, 12 May 2026 22:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778650970; x=1779255770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yYBEv39uEgMy3N++VlBuBjtbHkIyYso+pXEc18UPlvk=;
        b=i9ZSlOdZg4mmOpjerXieSv0dag7k37jcmPIvfypYeERjNpfVzKPcsE1HgHxo0OuFiX
         rlYOAVxpLmalWozT+7vL0yBF5S5GFPlY1KqXgSsMHR8igRadrX2gUa17w4jEjjYQImyz
         GUMN9cKMKJZ1p/iudPC6WP5MewRM5ddKXgQ186o7DBOjpxCEOOSVkstNDmnfUMU54/2H
         v7xXFmKA49viGnQ0B8FMwYGRErVDX6NAAlsbBX0FPfuBlgUIJqzRtpd30wyESG4bIopc
         fn/I9+utPJFb2z3MdQgIH9piM0tOGvky/Nx1ROzsYm5vWy5wdVfqNTAYUoBdohFVtVxC
         W9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778650970; x=1779255770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYBEv39uEgMy3N++VlBuBjtbHkIyYso+pXEc18UPlvk=;
        b=G+FszxBYuwnsxgleqR0GJ1nkNq2UDj4YRq1/yKZMcYjkmcKBtuphk2umt1BuhPagqJ
         5bUdCKkveVfJT8WhTRM8RzdoRu9ci/sI/EkaRcU1ef4EA+n0t+6e74oCTgsalz5Uoiml
         Pmi7tcCXJ3I8HyR+3Gq+0/YKwURNueYDGD9oIe3mIq49MhwFHV1zoKGesgYF7QVPw+Hq
         Az6iJIDRINqp+JixvZ4sKdVbK/r9ImMPml3ykynF0gEvMJK3feKaknVwY8V/AJEKrDHL
         xsbQ1Hy5onT03M1Aec8F78+zI77Q/Ds0PNe1a9h9eKz3yP/zgXmBStLwpbaBvDbe4Oh5
         nYTA==
X-Gm-Message-State: AOJu0Yypflad1uom+u617FGOE4GpuMEbLZ3tNpvIeg1xqxllLaaZugqt
	zWT7CALcJGOUp2NJnlRZK8K4fpQEENq/p0qDwxA4JJWN4DUaAiW09rVq
X-Gm-Gg: Acq92OFqnmQXNdeTzmD9PCa1wBYJE0fnrq7005zjLIsoPNwrNXXtGs638ZfAEraDHeE
	VAmveiA4mCzsvX7FXE+DRrqePfraM+C002MOqkDJfOmpOcgjbv1kgtgRWQtY4hW/etiCYasz48y
	6Q5FmUomzbqwC71jgpZQAV2D9NHKm9f2zgdQDGMngYywc36gmfchyNKKVHuSygySNirSuiQA+vj
	/Oer2p9UWTlz+FSYLe3O1PZlLhsYh80/sW9/8Li9bChL/59gtoyb/PBrqZhcZoOLMGll+K7RDGL
	/pESC9Z2iaslOweusBPA3LoCR/HpF4/UKwkS3wSRz1Js4IBUWABs23akv5dLWoC3rd3qVUuLhqN
	5SGEKVHa/WZNwAfQ+qFqIQ3SjoSvF9CV4GIvgO1aj7Y+9tqkGrGAS3CtPLXz5Kj4geUU2UUXZIF
	OoN+S+yRvXDWR/8Ff+40q1mnxvt9BibDj+dpMpF7lQSft0Y9P9VsIyvERJ
X-Received: by 2002:a05:600c:3f0c:b0:48a:55d8:7882 with SMTP id 5b1f17b1804b1-48fc9a0ead2mr20611005e9.9.1778650969796;
        Tue, 12 May 2026 22:42:49 -0700 (PDT)
Received: from va-HP-Pavilion-Desktop-595-p0xxx.mshome.net ([31.7.57.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fce37b182sm38558085e9.9.2026.05.12.22.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 22:42:49 -0700 (PDT)
From: Valery Borovsky <vebohr@gmail.com>
To: hverkuil@kernel.org,
	mchehab@kernel.org,
	hansg@kernel.org,
	linux-media@vger.kernel.org
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Valery Borovsky <vebohr@gmail.com>
Subject: [PATCH] media: pwc: Drain fill_buf on start_streaming() failure
Date: Wed, 13 May 2026 08:42:44 +0300
Message-ID: <20260513054244.143866-1-vebohr@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DFE5D52DA83
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-246752-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vebohr@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Action: no action

pwc_isoc_init() submits its isochronous URBs with
usb_submit_urb(.., GFP_KERNEL) in a loop. After the first URB is
submitted, its completion handler pwc_isoc_handler() can run on another
CPU before the loop finishes:

  start_streaming()
    pwc_isoc_init()
      usb_submit_urb(urbs[0], GFP_KERNEL)
                                  pwc_isoc_handler(urbs[0])
                                    pdev->fill_buf =
                                      pwc_get_next_fill_buf(pdev)
      usb_submit_urb(urbs[i>0], ..)  -> fails
      pwc_isoc_cleanup(pdev)           /* kills URBs */
      return ret;
    pwc_cleanup_queued_bufs(pdev, VB2_BUF_STATE_QUEUED)

pwc_get_next_fill_buf() detaches a buffer from pdev->queued_bufs and
stores it in pdev->fill_buf. The error path in start_streaming() only
drains pdev->queued_bufs, so the buffer parked in pdev->fill_buf is
leaked. vb2_start_streaming() then triggers
WARN_ON(owned_by_drv_count).

stop_streaming() already handles this since commit 80b0963e1698
("[media] pwc: fix WARN_ON"), which added the fill_buf drain in the
teardown path but not in the start_streaming() error path. Mirror that
handling on failure so start_streaming() returns with no buffer owned
by the driver.

Issue identified by automated review of the INV-003 series at
https://sashiko.dev/

Fixes: 885fe18f5542 ("[media] pwc: Replace private buffer management code with videobuf2")
Cc: stable@vger.kernel.org
Signed-off-by: Valery Borovsky <vebohr@gmail.com>
---
 drivers/media/usb/pwc/pwc-if.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/usb/pwc/pwc-if.c b/drivers/media/usb/pwc/pwc-if.c
index c416e2fc5754..26ce7106ae30 100644
--- a/drivers/media/usb/pwc/pwc-if.c
+++ b/drivers/media/usb/pwc/pwc-if.c
@@ -726,6 +726,11 @@ static int start_streaming(struct vb2_queue *vq, unsigned int count)
 		pwc_camera_power(pdev, 0);
 		/* And cleanup any queued bufs!! */
 		pwc_cleanup_queued_bufs(pdev, VB2_BUF_STATE_QUEUED);
+		if (pdev->fill_buf) {
+			vb2_buffer_done(&pdev->fill_buf->vb.vb2_buf,
+					VB2_BUF_STATE_QUEUED);
+			pdev->fill_buf = NULL;
+		}
 	}
 	mutex_unlock(&pdev->v4l2_lock);
 
-- 
2.51.0


