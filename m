Return-Path: <stable+bounces-254705-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGAwKEauF2qiNAgAu9opvQ
	(envelope-from <stable+bounces-254705-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 04:53:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11ADD5EBFE8
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 04:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4050310AA1D
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 02:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90412E2DDD;
	Thu, 28 May 2026 02:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCmtmwQs"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528D71C5D7D
	for <stable@vger.kernel.org>; Thu, 28 May 2026 02:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779936535; cv=none; b=OEQxl+SM+e2t/kYIpZYvs2wmJbKi1U2g8oPaeWkhKZRYwKdFfBKTh+oJRXtiIWUVrPOPGitjYPprp6d+um1kql8bSLbnwxyY+vm3/cpRt+jloGg9SxkKr+1Be8xrdfBQlmvVcAN1GThaZI0EHxdf8YcdikJuQmMihvqikuq8lUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779936535; c=relaxed/simple;
	bh=hEMiF3S5n7GD3rgFs1MSCMOijiI81jrIRmqCj3tGYEk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Sr7A7G4STaaT0V40UtzMHdCt/hpp4Jtapj5hKVkWXiNYFSlndHF8j+wlRib2QKD5hTu8TTfbczN6l44x0O/TPkWqqaov5tzFTJNY8bMQMf5Oa/kDbzHAea9r4fP8Xxy1tTl7RFEH3iEzphhCA4CGV5pqVzchqoyuQ/p8tKg6PsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KCmtmwQs; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-83ef1d17904so12181997b3a.1
        for <stable@vger.kernel.org>; Wed, 27 May 2026 19:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779936533; x=1780541333; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2mHoOLXw1ORyK+bjLW8SaA8gqA96ImAqk4cz+WkSseo=;
        b=KCmtmwQsAUgddrCgHUpBzgPHK4YznK4z+jAhu6d537AN4xwK3dS//AGoAemrYIwYgi
         55Rg2Aj/jwvrHDe+xz54mRUw/I20sxjohnDSt6QVK5FIlcS+pJYiHCSlkKsjsx4CWni/
         0CcDIg7yddTqiEO013xrRyOUU94TusqN6wzlNrp6EkAgEO/cyzOK3Fb9B89c84FFcvJW
         VMTrB6srX1eGh9M+o5MZWSIpygwRIzgiUxYIQoklFQCcy/dr44MjqogFYkTGxfEhEg5L
         mgszAXCHFpsT2hQNkhNaIFQfTr1J9IpmPd88+mZ2LbcXWnehU3ps5gOIIsmO1/VvUPKz
         cgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779936533; x=1780541333;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2mHoOLXw1ORyK+bjLW8SaA8gqA96ImAqk4cz+WkSseo=;
        b=rSZ9/2yXXHpUfE/ow+rLeDMKVn8i5dyyoCm4utYipWLupGVwKqUNydxq27qXJPdXn8
         mp8FjcdGQ+hvR434/E9FzIDbaU71FdK2PqsbivFaNxZ1qPsCzYaLDcULOHIHHQ6k9HLK
         KwZiseDb0/LA/RWd563QsYZsevoJ/Vg/pCeDWQOnv457MfJAbhM+HF0o6P6q8QAJtCEp
         eqC6anspXW9PXZNzN/CV0UygxMhJrH7u+nABk5VREFVo2nnbEOsxdFn3py78ooNPH31K
         FY9h97USclII5hjjtiBbVVzaSGdOULL7j4Og3ZL5SG61F+fF0rZy+8ngxC8ENqxviHSh
         oymw==
X-Forwarded-Encrypted: i=1; AFNElJ+Ur23tRkKouvWLc8hTe1FvZt0rvxCF9yOWljFdeWUqFUlE2lawaIbdIUeZpMH0d/FJSb7YRO4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4wwsTquux1f7W5MyIQodepknzt9VkbZ9Wg+u6sXtONbEhEeiW
	NLCLdJemQaIgAT5XTJvs32uvzPCURSJGUe6EybjoRVMv/iSm4h92oX0Z
X-Gm-Gg: Acq92OFkXQSI4j3C2iBAvfvjNGPtI4vE5VfAxIxJxnPh7ZznP1/OfiQx5N/RN0l13fr
	mullmmzng504EXIuHaug51WtVQDi5Gw4PfRQRkT6iB0tbZfGFGCSSC2o4GQGff4qLH/OxtlExVQ
	9yrfCissS3YETdIY4lPAizDvyUUhRP2enthH1/GxcV6OlWl68rongfpHnlbxhzAxaEHPeefiqig
	A3OY4MSGjHNtWfNZEzhJ3+roxvFmfHo9TmxxhzuD+Y1DSCMgBLUbX0FsdFXarYDrWKikd4L2xXo
	Nu01jMV8Dk52NesIyPlVPX3yk54D+UDR1lYzNvySJIwmIUCluMBsSwS/cvOQe4qDWLN7uS0vTOZ
	F0NQxKvNhXHhgPvtXdBSVyp70/Wf4CrukfdLkYYBdxUeoVArNZcu42uFhJKQ1QHTkKXCwLY33k+
	GugA3r/E8NmOPEa0BJMsV5OxLiy5eZOPQ2ww==
X-Received: by 2002:a05:6a00:91c1:b0:841:dc7e:6adc with SMTP id d2e1a72fcca58-841dc7e7888mr4287582b3a.19.1779936533561;
        Wed, 27 May 2026 19:48:53 -0700 (PDT)
Received: from [127.0.0.1] ([116.80.91.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841f3cbcddbsm366877b3a.4.2026.05.27.19.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 19:48:53 -0700 (PDT)
From: Cunlong Li <shenxiaogll@gmail.com>
Subject: [PATCH v3 0/2] zram: fix UAF in zram_bvec_write_partial() and drop
 dead bio plumbing
Date: Thu, 28 May 2026 10:48:43 +0800
Message-Id: <20260528-zram-v3-0-cab86eef8764@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAytF2oC/23MQQrCMBCF4auUrB1JxiZVV95DXGTipA1YK4kEt
 fTuphXBhct/mPeNInEMnMS+GkXkHFIYriU2q0q4zl5bhnAuLVCikRoNvKLtgaSqUVPDxhlRXm+
 RfXgszPFUugvpPsTnomY1X79A8wGyAgWOlXWE5K3fHdrehsvaDb2YgYz/RggS0NO2Jqlr0u53N
 E3TG7bTpUPNAAAA
X-Change-ID: 20260526-zram-b01425b7e6c6
To: Minchan Kim <minchan@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Yisheng Xie <xieyisheng1@huawei.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Cunlong Li <shenxiaogll@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779936530; l=1246;
 i=shenxiaogll@gmail.com; s=20260517; h=from:subject:message-id;
 bh=hEMiF3S5n7GD3rgFs1MSCMOijiI81jrIRmqCj3tGYEk=;
 b=b0BDviFETroiomMLL7jl4q+mx7Zxj3oBLg5d53SGnqIPES4wURls/SzkCaj/bSMVLu7RDu0Nh
 FQNi/cpR0KuDbjHlHbFkwfXLikSkTIE9UCFOw+gYAtjyOvG21yJL0pA
X-Developer-Key: i=shenxiaogll@gmail.com; a=ed25519;
 pk=SKFifnqPdsvsjuhUiq+Y9vtCdhyZ/LrRcfYn8eRq6AE=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254705-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[lst.de,vger.kernel.org,kvack.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shenxiaogll@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 11ADD5EBFE8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Patch 1 fixes a use-after-free in zram_bvec_write_partial() that
happens on PAGE_SIZE > 4K configurations when a partial write hits a
ZRAM_WB slot.

Patch 2 is a follow-up cleanup that drops the now-unused bio parameter
from zram_bvec_write_partial() and zram_bvec_write(), no functional
change.

Patch 1 is tagged for stable; patch 2 is not.

Signed-off-by: Cunlong Li <shenxiaogll@gmail.com>
---
Changes in v3:
- Update Fixes: tag to 8e654f8fbff5 ("zram: read page from backing
  device") per Christoph.
- Link to v2: https://lore.kernel.org/r/20260527-zram-v2-0-2fb84b054b5c@gmail.com

Changes in v2:
- Add patch 2: drop the now-unused bio parameter from
  zram_bvec_write_partial() and zram_bvec_write(), per Sergey's
  suggestion on v1.
- Link to v1: https://lore.kernel.org/r/20260527-zram-v1-1-ce1acb2bfaf9@gmail.com

---
Cunlong Li (2):
      zram: fix use-after-free in zram_bvec_write_partial()
      zram: drop unused bio parameter from write helpers

 drivers/block/zram/zram_drv.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)
---
base-commit: e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7
change-id: 20260526-zram-b01425b7e6c6

Best regards,
-- 
Cunlong Li <shenxiaogll@gmail.com>


