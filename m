Return-Path: <stable+bounces-104440-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4EB9F4519
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 08:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90984167531
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 07:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2092018A935;
	Tue, 17 Dec 2024 07:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="N7/KtnCb"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05F61E529
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 07:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734420512; cv=none; b=kqlmB8hP++CsmNAKE27EBtlvIP4sTHHiQ/Vb5DxtWZu2QKZVA0AftUg7CmviflKJ7QANSR9Z/NY3FknSgDTPBcKg8YISS5gLLdlRdLi2LQHtCcD/xcYkP7cT+Bnl5t0F6RnU99JhbKwPlvd6ndrZMEiq556CdTR++oPTYS89xLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734420512; c=relaxed/simple;
	bh=zxe3mkIJZeyJ+3+75qzwk8GTBri2bfxxMrxsD8ZUbaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lUlZdyRt1YjWtKuhk5LXdTuv0/GBT9XtVq2lHOMnepf3SoD04+oTQAv2ZooEsvZfxMYuQy3oDbCinm6Y06L6ONiF6NnxpU9vJWOhz52LKDVRsDPPglBWByHTlQ6McWI1SRFBOSnH3egQuqTkEYjq0gErUdQi/P9DiMDvUIk8pno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=N7/KtnCb; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4361815b96cso32591015e9.1
        for <stable@vger.kernel.org>; Mon, 16 Dec 2024 23:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734420509; x=1735025309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=02eWFI7wv9OBWLrEeqQB6QzT+wn96/g9J1aTLpbRBvg=;
        b=N7/KtnCbjRdYyZJnf2P4Rwjg4gbpSfay74FcqfrAcjYZ2li+BPXE/ag3RTvjKfbpXx
         3H+wxXjtv54hFp9fSdhUqm2WHjwWIaTTdW3kBi74e5PSXfgNKj0Fe8eBmQsOp8wBR6wh
         1mvqfezZJ70jMYa2zF1AitLH+KhlFSL9vUctuVKgN+M1wyqDSrHsXY+CeC0EUTm2axGz
         BtAR6U0G6Jo3HGh2qNhtRhu3sJZNIp6DFkX62cz/Tu3ZepLSB/Z9TG33O7sGs6EKuuXV
         1csBQ1Ir6GpgNCKC4vcENSFXVCqATS2IZeD+PnxBgggy3iXauhtOwAhR0+ObF0/FHXJv
         +DpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734420509; x=1735025309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=02eWFI7wv9OBWLrEeqQB6QzT+wn96/g9J1aTLpbRBvg=;
        b=T9VDJ90QZWa74UtZkJG1wHe1IPx4UsWePJNPwTPlpf8MpCfPcN1GTTcaC4ml0J+mhN
         uFdCFGs6biqQoOgitknaWKD4YWkMc/ud71sS1T5sNevo9PkfrAocWt/QIVE3UrJ8g5Un
         cKOF1thnkRoXAgsTq8jeHbKuDUGfPOyzKUYIvvLgv66WlZ8QiVCY7ykKWB59jXvFvRLm
         k0aX9TQcQmvgl9eZYMM6Qfzh5g7qKMdu5DT+bxUbKQDPMjiHzvjfWQGuuabQ/MyhXl2P
         ze482Q8EeguQ+Sc+JQ3gbnjryZfZ4X4mF10faYzhaAhnwWDSUv/7fG1eyTTQYSUx085l
         aRIQ==
X-Gm-Message-State: AOJu0YwyuBVk3t67Ot60F65h4aB+ID/zZqRLSu8zhkWs8xdPoIpR92At
	UXO1gtP5zNfUQlAfy5NbElZUIe6eupL/SMJ16Tx3+JeAWkzn4zkAvG9VBTFYJwk+HAfMnWaAW0U
	P43gvaA==
X-Gm-Gg: ASbGncu8pOeO/ykyTTkCfwPJiWou0nmKWI6xQOZ3Ori7U3Cod8C9QflgkuFJNDdxqtP
	fn+owj0lKg65i8YKnjTCXLzNdjQJe0oaRc9wOK/mqT/Dx6m7pHWWtrxhaZ0tnUMJyLyy4xzApvW
	O76R2421nebwCEW9RmnYfrdhSep8MAYGN0Ow73xZl/8OGCjLYVqTQ/4ABARAaMB2ZnCf1HtbTYZ
	xw3iBHuEyAuhJXgaA05HW5Mt9/eS/CkBwGgPM5bgZPT6YcW8C+7viPXWW8=
X-Google-Smtp-Source: AGHT+IFiOarE/TS7zpPCGUYTwcMFV1M02PbxAeWfKgHMGHaqUs6oSwc78KCEDcwzKhSdSlQALB1FIQ==
X-Received: by 2002:a05:6000:787:b0:385:f114:15bd with SMTP id ffacd0b85a97d-3888e0b8614mr12237566f8f.37.1734420508828;
        Mon, 16 Dec 2024 23:28:28 -0800 (PST)
Received: from localhost ([2401:e180:8862:6db6:63ae:a60b:ac30:803a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1db5e10sm53298485ad.14.2024.12.16.23.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 23:28:28 -0800 (PST)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.6 v2 0/2] Fix BPF selftests compilation error
Date: Tue, 17 Dec 2024 15:28:17 +0800
Message-ID: <20241217072821.43545-1-shung-hsi.yu@suse.com>
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

Changes since v1 <https://lore.kernel.org/all/20241126072137.823699-1-shung-hsi.yu@suse.com>:
- drop dependencies of __xlated() helper, and opt to remove its use
  instead.

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


