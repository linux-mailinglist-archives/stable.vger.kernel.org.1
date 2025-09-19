Return-Path: <stable+bounces-180592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E76B87B04
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 04:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 610DA564126
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 02:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424DC248F73;
	Fri, 19 Sep 2025 02:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnkUIm6a"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E331123D7EC
	for <stable@vger.kernel.org>; Fri, 19 Sep 2025 02:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758247897; cv=none; b=VcNX4mJU8OO7V1TeMbOduc+KSjfIq0mrJ33Py+DwAlKGvziz4GSHtWGwD+MgZLRim8q1aSBAus+lZC3QKblY8U+4W94mrShQVMPTe8pU4IQipN2qkT26PBVvjuECZtskpzUSs4YAoJ2O3JeI7bzcVnmqil/E2Cj3QK+4aQnykEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758247897; c=relaxed/simple;
	bh=ziXcd/mGn2ry+d/Ov28rbQ3Z8WS0immtLzwgvpIlto0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R2sHbWQCrhScdB8ZsSwBxscX5rVKTJHZJswPK4F219oInuMCz0wbbTgK5lFmcV9WO89Uyr9QQQhHc2AiN6Yuk4/x479N6Ah7eBTed0aS6UWyGUIwNOH4zfjIt/vsykLYi0quT25U+HLQwQG/gsx+C5sWU+uNxC6Xn2L7anDD/a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RnkUIm6a; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-244580523a0so17518825ad.1
        for <stable@vger.kernel.org>; Thu, 18 Sep 2025 19:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758247894; x=1758852694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qZzkp8nCuA3tTuaf6Pt6AXsPGQNEt3CNxtrSQfVvzGo=;
        b=RnkUIm6aoS5bTEJdbZVIq91ZN9KEsN1bIt4Bf1Y4+j4OmXDYuEdYfmf5DTXf7sJPT0
         xN3lGH3WXJQ59LC01wsLdM2oIOWMBE5TvPI1CgfPyRRQy1gp+KU+xThDtgQzhbxS6v6x
         Y3MovN39rpu+jcHzw2rXM0yVG2iBSt6LYtaHyhXUKrLKQ1YJK+3VFYNf68HwoIy+G+go
         Cn00Hlc2upxJ8EMHe11nJq2TAYchXqdNLaakBd+IrKj3E8dkR7tuC8jxEH0LFiqj/V7g
         Y75ZbOzl8uZcY/fw4zuNhULI4OiUEZjoioMDu7QEULWXDbcej/VCOEicv4iBa1U18NXS
         Y1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758247894; x=1758852694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qZzkp8nCuA3tTuaf6Pt6AXsPGQNEt3CNxtrSQfVvzGo=;
        b=gKJK4xuPdye3q59NFrzXV+0pVSeCUS+XedPODrt6AN9l6Fv2aM97Lp9exajY9qG8OP
         974cSB29mP5tOSwnjT79u+TwGp1UbIWUE9OfbBDQNENRt4iIMMu6u8rzPggpoiJTef1u
         797IgKtowIb4Gh5p8+/wXCgK2Zq9zAZq2DLLOAweqnZ9df9bRPKQMSBBZcErXVLluOpO
         et7mtZSVTPei1rL33lKTdYacFSyvRM7+8lYxKcAm30UJzDXwuEBrFm/fUkzkVNpZwq+t
         7yezEnP8RHbqkA+a7RL267nFHAHeURooOZXf4UNSELktbhHVlseFsTq5blDSZ59xKeMZ
         uDaA==
X-Forwarded-Encrypted: i=1; AJvYcCW1HmqirfXWBdzGkk9cvQiD0WvOISg7l7pCaot6n9t0HWZF/uTCY0WhAnaVXht6F+lbCKGE7MI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOTZA2ZKqIgfPHUF1WrgQ66n+3MpNaZW7XFD9A2Ul9ABI+hfLV
	bArf5oOoC/+slpTtZgfHrfzdZmd75GInO0L19zBcSry7/Eg4AziZVHcc
X-Gm-Gg: ASbGncv8iNOOmCznKMgtVrDrBbEwMPDYgr6IilndEcmm90AL2eJjqByVCDvZEFfc3NL
	ERp3Lu61Uyuphlgmr5HiZvYU0cOvLCxiKWFEKyYE6x2+TjAhlvwC6+QvMGlupQXSZY18i094BK5
	Y6Nc0Qq5WslC7Da0Ag7+jxC8dVtwyCbSKPfHJFe6IlAzYL7XH1OwRhviKxS4QmE3phdoKA44VnA
	HVhMVxz6cK2iiR6Lkh1VcQVEDZf7nxNp+dt7ld8KjC7nZkXRxLV+ckd50EEsChwKfRrW04Httg/
	67QLnto5cu6/rhjbhtuCcQ1d5zcMwqYmj8M5xlLlJ9Kq6LPxNdi9Vd/57n69bnz9dPjS/T8LflG
	Lo7RUpnqArQb1Jnu0Gd6bHNWr
X-Google-Smtp-Source: AGHT+IFai2xzlAnilWh4m4u+vIgxxJ3TsFPhkwgF6XAkrIfE2ErA7mqnopPzZJz605+TwLFG1Fausw==
X-Received: by 2002:a17:902:dad1:b0:267:d772:f845 with SMTP id d9443c01a7336-269ba55f8f5mr26364635ad.52.1758247894071;
        Thu, 18 Sep 2025 19:11:34 -0700 (PDT)
Received: from lgs.. ([2408:8418:1100:9530:23e9:7ba2:72c2:e926])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802fdfdfsm38785405ad.102.2025.09.18.19.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 19:11:33 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: HighPoint Linux Team <linux@highpoint-tech.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] scsi: hptiop: Add check for device-provided context pointer in ITL callback
Date: Fri, 19 Sep 2025 10:11:04 +0800
Message-ID: <20250919021104.3726271-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An untrusted device may return a NULL context pointer in the request
header. hptiop_iop_request_callback_itl() dereferences that pointer
unconditionally to write result fields and to invoke arg->done(), which
can cause a NULL pointer dereference.

Add a NULL check for the reconstructed context pointer. If it is NULL,
acknowledge the request by writing the tag to the outbound queue and
return early.

Fixes: ede1e6f8b432 ("[SCSI] hptiop: HighPoint RocketRAID 3xxx controller driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/scsi/hptiop.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/scsi/hptiop.c b/drivers/scsi/hptiop.c
index 21f1d9871a33..2b29cd83ce5e 100644
--- a/drivers/scsi/hptiop.c
+++ b/drivers/scsi/hptiop.c
@@ -812,6 +812,11 @@ static void hptiop_iop_request_callback_itl(struct hptiop_hba *hba, u32 tag)
 		(readl(&req->context) |
 			((u64)readl(&req->context_hi32)<<32));
 
+	if (!arg) {
+		writel(tag, &hba->u.itl.iop->outbound_queue);
+		return;
+	}
+
 	if (readl(&req->result) == IOP_RESULT_SUCCESS) {
 		arg->result = HPT_IOCTL_RESULT_OK;
 
-- 
2.43.0


