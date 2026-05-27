Return-Path: <stable+bounces-254479-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDbxLt13Fmr3mgcAu9opvQ
	(envelope-from <stable+bounces-254479-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 06:49:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 405905DF3AA
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 06:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3EB2130285C2
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 04:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EA43016F2;
	Wed, 27 May 2026 04:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M389yDtQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2725B126C17
	for <stable@vger.kernel.org>; Wed, 27 May 2026 04:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779857371; cv=none; b=dLCQz9dCdOmw80PYbBX0DTbNW/ot1QU/jEuOtuTrAf7CN7pjoK5wY9n5HXna8L/2ZODXxEXnCmnjqkxSSwhKrwFUpcU8GtWj4yQJhkYsXtTbfl4H6GsCR1Jjs5GGettgm4Ryxv/BBBejZc1QsHR1FVg8vlDuSTdLnFPqp4s4esE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779857371; c=relaxed/simple;
	bh=MWXxtYUJHKCFAwaYN7w+xkzs9tEH+b5cbl78IjB6IzQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pDFMJLpjrz19RSbipNrgGhMy3I9+fsFEcOpV/DXhDZgcWmjrpo8d+0seg2uTC3Lmvks0raeSTM6XRtvftJJLLTHJ3+3Be6IDqA9xSx3/LX3mzk7OvGmqYIICf+y8ULWqIBnVYsKpAlCuQVKH33Wgt6j398mKZ8WwjCT3EdRVbhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M389yDtQ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36a8ee1e28cso3669946a91.0
        for <stable@vger.kernel.org>; Tue, 26 May 2026 21:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779857369; x=1780462169; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DtWoDaWr1fAVpczHdMCywjJZwwAcuUUA2TuUPYOhsgk=;
        b=M389yDtQv0kt9VYx5Wl5UzXjCXCJ085Q8qpo/OqWFhj+Nh1g6lSUKrwjXPZ++6NFgh
         GJbjf1H1yizBdY3kMz38nMllW0bBf2IVlo9SV8GbFJ9tl3YlGyk8WjJnrlbrKWhpL7Ef
         TsCcxnEGkOUyYcO3D1F3scMR6UeVuoOLFPh5vEWJUbGafVwyo7EeRNQAn0AM7jBDRKRn
         hUw5P6af4NR6QKYIMykw4rPKBvWFh+z8ofsAV2BjlyyXJ3p3aDo/rD8AKUUt5/lmzZXs
         g4oF8ecw29LlEsfT4OU02ci94c9khKJ7dFTL8+GHV1UtdL2P/OFiOB+boDK/ibUt1OAX
         63sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779857369; x=1780462169;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtWoDaWr1fAVpczHdMCywjJZwwAcuUUA2TuUPYOhsgk=;
        b=icKyiB3l+7q3Y+STMRcw3rEzM1PC/11SUVB+UH7aplguB34lc79N3oHZktdQXPlFKB
         WD/qrzCZPtQRCfCiWxB3z16LCnaEvXEDCUUQ7DbLorJW3BtVTsmdLPQx7Yq31IZMGdfL
         09i/GaH8C+V34eAMcj7vBT0bCZkT63Y0jgn4AsXM7/YaJMrEEvdH55zYYvQe5CM6sKPu
         0/2peNrhn6Imo3EtWptJDmCkv+9yDKe38zDih1plnlcF7QMNiZJwHIgz+vjKGMsNg9sc
         6/Y/VnPNyOmHIQutDG4h7MaVGz5wGw9fEbztubaGGyAk3TlpLLK7jWP2w2w48oJFoaZa
         b8ow==
X-Forwarded-Encrypted: i=1; AFNElJ+9NJUXs4hu+MKrR1TmIvkfpnpJ07r3jZ+ap8x3hqedSWC82v57FPwpT+DnkW6Jl51s/fu+lWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhWkbIZ0q1p87K2MK7R8zT4nJGMF4N8FyJwu22siwwTVhDs/Qx
	yrub+6y3HTIepyOHoSxltXGvhSZYQ9pWo8LjKU0M91FEVFQeQ+ke1QsUJ8ySd2mY
X-Gm-Gg: Acq92OG+BcrS1bsNOK2rfr/DrXLMoZBKNFmpkQuitGkE2OWIYjSpHl1sFVNZZSik6h2
	Nu+mQgQuLA6bBJbOpQzsId6VbApxY0q8NCDMZ2l20EmiPw7HWC7jN0YwfOF2WjKjZ0fKAoVhAo7
	coFqkwQLysBKINF9yIH7VRUBzErmBGXmm8RZkGiLLkfijYFGNTGNOrOPg4knh8+3p+HxGqdiXEv
	FGSy5nxM47XoSnPCjSaa+v6CtCZrmFFF0joz/rIStY0F+swAWGG0b6RP5g3a4rJcGhC28LejQDq
	nd4czAKh0uXJvaGa+c2p9s0Lw2HcmBoLIIusz/zOHguPwVEWit1Kqo74zZa1RCGDk4XnoURJdMr
	tWhOnVLq6zlD4yIBe5YoUIgrcpjxiL19LyBe5aCnYTapqbnR6kRlLlxACdsccHxs/IzLIdo2LMR
	AtnAF4isGW+NG7w1PcfrKcuxJLcv1wj2SODQ==
X-Received: by 2002:a17:903:1a2b:b0:2bd:ef12:14d6 with SMTP id d9443c01a7336-2beb06cfc33mr237395755ad.34.1779857369510;
        Tue, 26 May 2026 21:49:29 -0700 (PDT)
Received: from [127.0.0.1] ([116.80.91.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58dba7bsm135704105ad.66.2026.05.26.21.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 21:49:28 -0700 (PDT)
From: Cunlong Li <shenxiaogll@gmail.com>
Subject: [PATCH v2 0/2] zram: fix UAF in zram_bvec_write_partial() and drop
 dead bio plumbing
Date: Wed, 27 May 2026 12:49:23 +0800
Message-Id: <20260527-zram-v2-0-2fb84b054b5c@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANN3FmoC/zXMQQ7CIBCF4as0sxYDE0ujK+9hugAc2kmkGDBEb
 bi7WOPyf3n5VsiUmDKcuhUSFc4clxa468DNZplI8LU1oEQte9TinUwQVqoD9nYg7TS06z2R5+f
 GXMbWM+dHTK9NLeq7/oHhBxQllHCkjLNovfHH8xQM3/YuBhhrrR8t8VD0mAAAAA==
X-Change-ID: 20260526-zram-b01425b7e6c6
To: Minchan Kim <minchan@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Cunlong Li <shenxiaogll@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779857366; l=1050;
 i=shenxiaogll@gmail.com; s=20260517; h=from:subject:message-id;
 bh=MWXxtYUJHKCFAwaYN7w+xkzs9tEH+b5cbl78IjB6IzQ=;
 b=awVJ3Reynx/9qKcpkry8pPVO6WO/SxEC+sbgYlB/AXjE7b9wokupd/75eZl2DJa0r9X5EKc89
 efYJzuJECK2DHFqkFpgYD8dIqvHv2XslkX3RsXOW5OSU8b65Aik3V+A
X-Developer-Key: i=shenxiaogll@gmail.com; a=ed25519;
 pk=SKFifnqPdsvsjuhUiq+Y9vtCdhyZ/LrRcfYn8eRq6AE=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254479-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 405905DF3AA
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


