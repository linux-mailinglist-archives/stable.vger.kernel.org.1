Return-Path: <stable+bounces-104449-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 758D19F459D
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 09:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A7EA188EF03
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 08:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6D5126C08;
	Tue, 17 Dec 2024 08:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XQVCjOmz"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD61EEB2
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 08:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734422569; cv=none; b=kbEnpumNfvPRrJgLkeaX7lOHo4DTuVG4RuIcva3Qa0L+/R6cyiB2nicUXny+r0a9ojEanfpCsasndFnpYAyuKuajQWZ8NCQeOY+vdzZiXGfL6BKkjN9Xe1yHBlNEUM7WYLGU6ilqKO2W+bEJdqzkEekDMGNbb5RzVviMU7j+onE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734422569; c=relaxed/simple;
	bh=Uz9IQf/PCc3hEgWuULewTHn5ujlRuonTH5DlWF7MJ58=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LndmInj3Jav4NKJpukEisjUZbH2FH1LCWWGzBJOraQjrXkttx3PuflpVfLDUhx9qN4ewpf/TUTUGCgY/p+0Q1Xgopaj0PG1Rmcq1YI1QLF2YzJ9OQgsT5vansKXXR3N5HDeqLNi7emnHE7dVk8A4YAsZlymFPAeuoaw1lPFfhjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XQVCjOmz; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-3863494591bso2664251f8f.1
        for <stable@vger.kernel.org>; Tue, 17 Dec 2024 00:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734422566; x=1735027366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X4ircQ6YWhUysMQKxFbMbB345zp18ppnDe0j92eUF1I=;
        b=XQVCjOmzwokS9TUUT4YnbaJM3LK3JWmhQUsxOKJ63yQTvJ8YBDshJSHChwQOSR1gvN
         8+ZbcQkz+Xece+9pR7s1lghEzPXZgEEOLtp1DwCWxv7mTavYMctBTFmX0To34LmefFNe
         4yaGZ0I/d0JXY/8JgLi4PS8u65FYIc9F4wJhpDSoZdD3aBd1mDULksR+hkcRjEZ3ttef
         tggs0Vpm6Z6Nu1Y5RggQgenv6oVF1FIvPQlLD0Yst9nODzjOqjISG15N7jUzJBYMzUag
         +opeX6lW3HGU60NQifRi7B/QtbZmvdNSZnV81so7rAk3nZiYpUYX1JCVJKJ8poq4lmza
         XkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734422566; x=1735027366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X4ircQ6YWhUysMQKxFbMbB345zp18ppnDe0j92eUF1I=;
        b=HJYNGx5w8IeSJNPxExtBzaf6FK/S/yNTvAFp4UW0+YC3cT1vA0ZqM55aZnVpayNzZ1
         WAuLog3bWN4PcZf22AXrG1dneP93rXKuKhsF0jEWjw3qNXGI8PXmFlsW2h1E4lrASuwj
         XyUDVDdNvUSpUjzNhD5TKX/4pCa5/rVyT04pFmfR+sIk3GZn5DBcg4/BGO+EOvrP4teL
         V3pRkZ0OA8RXT7GQAVcT3HKyDt6c3e8g3n2Aoxw2Tw3RCxtnRJnOca2PS21IfxedVUF6
         AOW2ZzKLYRsQN83uW8IulheJt8yBoa0F6XBfzsSJ1O3b3kDcEq1qTycBI7/NHxYNUo3b
         hgcg==
X-Gm-Message-State: AOJu0YwTdHAJ0QfiZC7bLXLOQiVWhQ+URWZBDBToCo7RNy+WBA9uSNFC
	31l5p1iTMd+9Tnutf4JTrEdxdVmtCQmyT4x5829AGq3fubM0nstjGBU3RYhEBYIIfNBGU0OxIlF
	pEcb59w==
X-Gm-Gg: ASbGncuGSubs/T9iejHLFSSQEHmD8ALMkZy0C4vIC40jSIKekJ8sXquO76/nMYj4dTL
	WCbzlsDawgqmbQzcw18mK1AHbArHjbzgiRalem6NGpsjkUR1D6/cAcn5P0iTYyoeggQx2bpebLW
	XMvnmnYXetbvp2kpkr5JILJ8Vtk7Af0wbr+EYQUya3nFPTsrkyjJC1i8kfvU4R2DHdRg88MzyWf
	CaFwiDpIIIG3H/fM/lEsomuXLmSOH4OzxPQkpn3qb9hi8MaP2OFFR2V5Vc=
X-Google-Smtp-Source: AGHT+IHGxB1fhPDi4FtQRIxvaBXZcKeyhJ1xluNyX17iKD9YQeL6rW1L+5YnmzHrJLFLs+Ate0I2gA==
X-Received: by 2002:a05:6000:1885:b0:386:4112:fc7c with SMTP id ffacd0b85a97d-3888e0c04bcmr11902278f8f.56.1734422565506;
        Tue, 17 Dec 2024 00:02:45 -0800 (PST)
Received: from localhost ([2401:e180:8862:6db6:63ae:a60b:ac30:803a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918bad6b5sm6033588b3a.155.2024.12.17.00.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 00:02:44 -0800 (PST)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.6 v3 0/2] Fix BPF selftests compilation error
Date: Tue, 17 Dec 2024 16:02:37 +0800
Message-ID: <20241217080240.46699-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the BPF selftests in fails to compile due to use of test
helpers that were not backported, namely:
- netlink_helpers.h
- __xlated()

The 1st patch adds netlink helper files, and the 2nd patch removes the
use of __xlated() helper.

Note this series simply fix the compilation failure. Even with this
series is applied the BPF selftests fails to run to completion due to
kernel panic in the dummy_st_ops tests.

Changes since v2 <https://lore.kernel.org/all/20241217072821.43545-1-shung-hsi.yu@suse.com>:
- minor reword of patch 2, dropping the "downstream patch" line and add a Fixes
  tag

Changes since v1 <https://lore.kernel.org/all/20241126072137.823699-1-shung-hsi.yu@suse.com>:
- drop dependencies of __xlated() helper, and opt to remove its use instead.

Daniel Borkmann (1):
  selftests/bpf: Add netlink helper library

Shung-Hsi Yu (1):
  selftests/bpf: remove use of __xlated()

 tools/testing/selftests/bpf/Makefile          |  19 +-
 tools/testing/selftests/bpf/netlink_helpers.c | 358 ++++++++++++++++++
 tools/testing/selftests/bpf/netlink_helpers.h |  46 +++
 .../selftests/bpf/progs/verifier_scalar_ids.c |  16 -
 4 files changed, 418 insertions(+), 21 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/netlink_helpers.c
 create mode 100644 tools/testing/selftests/bpf/netlink_helpers.h

-- 
2.47.1


