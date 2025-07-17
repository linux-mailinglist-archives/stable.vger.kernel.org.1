Return-Path: <stable+bounces-163228-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6958BB087A1
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 10:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6379161076
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 08:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95713218AB0;
	Thu, 17 Jul 2025 08:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WG6BZ0xW"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFDB279327
	for <stable@vger.kernel.org>; Thu, 17 Jul 2025 08:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752739781; cv=none; b=on7Ehvd9VfuZWZmyYgTGKOVkNCNX2ruzBvQeKeOWhGm53BMna8+cvr3u5/pdL4ze/jodzkGUps8vIa9Goyv3x5jQDz/q+BHW1HRnqTGsk7PGKw6XiWSWgniOqd5MsJ0e7f4qIuPW96leVOdh/OrFPcWvP1WQW1DisOwdhAU5eFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752739781; c=relaxed/simple;
	bh=Mrc1K65diM+cvknKb5Rc7Ld2/cE7DLN6Lnv8FEax6wQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OJq8sQbHqXXumcSO5Cs9ifeCXi1GKQ59df7fYGdHRAlygeejEU7XxQPSRpovljjjq6YkVNfREtOqa9sNb621RYpA3gTbFa0pvzrp6lsPVo6CE6tG8qYmKrQH0RFGQLzFwmYrS3Bzbd8rxCbwgo+Q+cWeY/NO5LDj/LfnJJ6WB1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WG6BZ0xW; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-3a6e8b1fa37so465016f8f.2
        for <stable@vger.kernel.org>; Thu, 17 Jul 2025 01:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752739777; x=1753344577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YJE5H+Jqrn8e0ReWun6QdyQyeMJLqsZwDIzTLZYsjUs=;
        b=WG6BZ0xWGIx7R46WujsbQITVlY3yuky5LEDXAReO9oV+WnFZaBApTboKxG3pIdcV4t
         +ZjteVuIUPe9ZUmAmrmQhMeQKWQiZxG1Hzw0YzGnr1/ndPqAhKsB3tftCChZv2chJM4B
         c4XytSqaHL7tbzHQW3sHjrkJQ+zjydON+0pl7rV5pEY2/Ox8pxo0K3AiNhSXKgtfJRqx
         Hx5wVqZ0LFkZhKiWWEVufRH5tULcG36U+0nq04Kg2OHYeYqwpOCGvsYmHjCjjNf8/VMZ
         SvuMwc74B1/+qdXClTsVYW8sy80sj0WpyITX7W+0wp9xxdJv4CR3ylDzMm53QLUH/hOF
         5qiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752739777; x=1753344577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YJE5H+Jqrn8e0ReWun6QdyQyeMJLqsZwDIzTLZYsjUs=;
        b=Bo6CJeKefd47E3v1xBXmyy0Zu6/udj9A/siP/1vWrn6pNbXcF1p/5Noi4y9/ykuXiK
         FIdSuTpSFbkADRln08bIRtpH8thX8hww3Xj+RTMNylUbaAT6r8FGBQj7Zkd/BErMJaUH
         is81XDcjip+TSEjBSZ9Wyr+eAOMd3Kjrf0Yw5wQD/9NHKx/x9dl4KzaJm1fu2B5IYKDa
         MNxq7J250P+3aMEfgG0kIR01d/j8TSsm50+LGgDsrT20aw887XaVxh/aGAfixKNBya3x
         lKToOmbHej+u+aEqmz4pLs9YceI5frjt2l/6q7SIpjFwUfqVqeD165pD4Fb7q+OKpzsd
         dWvw==
X-Gm-Message-State: AOJu0Ywu2bqxx+48694bgpd/y9uwufljWkHjoLSO8rwTRZJnKZyTfn1X
	DKPYW7CjYxB1fVy2bQKujxOPO85//NGV80F3GK7hRCbJzhoJRcEIjmTHrFHzIkqCxxTdxLpm91Y
	weY1gJvmI6g==
X-Gm-Gg: ASbGnct/Fiot1x5VUnWvHJJ0IWLvdIYODj5AotYCSWhC3bhV8hmSE3hLeLk9+YSbxhz
	Ej5zuJz4UwR9r+rVdbddKHP0BbKaY/G2Ndvig3PndOnznvb9rjO5gRwy+Pmm5X6w/gqzVqM9S5z
	TCVJSO7C43Uf4MPukCLodrq/E/A2symjCkauK+Vtxt8RWbO4qrsItn5X0wDSnR2Mabme3kNjd3a
	WAGEALUNIMhwpksWHDl/Hc1ZiAxZMMj4LLDRv5oeHQoNprV2B3VLfzuuklhtEran5EpijXlx0tF
	bQutnE5jDnRI76cQ1EIEonrjwXLJHWgqeOL/e76Op9vKkfudyPiPbANqD/gvdBFsJNnmXRHrMMD
	1EgHVJr5mepZYNLCrYvE2ry17
X-Google-Smtp-Source: AGHT+IHjabtkWOGpT6bWohE6HoBlmslvqIkySojMPXkyrCcfi4V0FKUOY7RVQWdXODSI4hte0C/6aA==
X-Received: by 2002:a05:6000:2309:b0:3a4:dfa9:ce28 with SMTP id ffacd0b85a97d-3b60e4be284mr4697198f8f.5.1752739776863;
        Thu, 17 Jul 2025 01:09:36 -0700 (PDT)
Received: from localhost ([2401:e180:8d6c:365f:22a6:ee13:ef7f:1e74])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74eb9f24378sm15953486b3a.105.2025.07.17.01.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 01:09:36 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Kui-Feng Lee <thinker.li@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.6 0/2] selftests/bpf: revert changes from "check bpf_dummy_struct_ops program params for test runs"
Date: Thu, 17 Jul 2025 16:09:23 +0800
Message-ID: <20250717080928.221475-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset reverts BPF selftests changes backported from "check
bpf_dummy_struct_ops program params for test runs" series[1]. The
changes are causing BPF selftests to fail on stable 6.6 kernel due to
missing dependencies (mainly the "Support PTR_MAYBE_NULL for struct_ops
arguments." series[2]).

Please see individual patch for detail.

1: https://lore.kernel.org/bpf/20240424012821.595216-1-eddyz87@gmail.com/
2: https://lore.kernel.org/bpf/20240209023750.1153905-1-thinker.li@gmail.com/

Shung-Hsi Yu (2):
  Revert "selftests/bpf: adjust dummy_st_ops_success to detect
    additional error"
  Revert "selftests/bpf: dummy_st_ops should reject 0 for non-nullable
    params"

 .../selftests/bpf/prog_tests/dummy_st_ops.c   | 27 -------------------
 .../bpf/progs/dummy_st_ops_success.c          | 13 ++-------
 2 files changed, 2 insertions(+), 38 deletions(-)

-- 
2.50.1


