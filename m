Return-Path: <stable+bounces-121632-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A2BA588BE
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 23:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09B7E7A2FAF
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 22:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D6F18870C;
	Sun,  9 Mar 2025 22:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I2JBaGrO"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5896B13CFB6
	for <stable@vger.kernel.org>; Sun,  9 Mar 2025 22:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741557830; cv=none; b=pDZkStgpe63lCacsiIlEzUMOeTThU0MWUlm5KeBoFtp2hvWwQ+RiZC8pUQc0/0oN3CtSArsA/7DoIh6nEcZkQh0lMi9BybcEVByJ7PbUhlWvGPKpRCagCiDl+U7zH+AY5rVfkLtIJpka43RN8NgHh+E2ooegUin2wWSHbHnxn3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741557830; c=relaxed/simple;
	bh=/AgGykda8+vk6gd+VRek/iWLLYFknrhSg5CPlGctDxU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=u4sGnipN9EYX0RLyw+iVeFrm7g2H1i/D0HGz5bzHwM1BuKdJFZYzUF1VDu38vLviwFU7u4oWS4DYFIsMLEN6C7pA2HHIC9Xl/2ZxyAQTlxSvacxUbMPCTvzGEsjJzyjxeBgczqicANaO5nckIIvJkLenjbZg7xKRb0B/VzL2FAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I2JBaGrO; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43ceed237efso5888125e9.0
        for <stable@vger.kernel.org>; Sun, 09 Mar 2025 15:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741557827; x=1742162627; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2n1kKYhtsWKYB4THV+dU3ffLQAXcgXHs9GBsP1NeAQc=;
        b=I2JBaGrO7r1RTHqGXMKIKABmUqxT7tbpA6oplzO6VRR/SbtQ2kKNFANPBRJNTgR9PM
         O882y1qWXhtC9C4HIU44snwMjFebKz5hkSidhqsIxHV+N6yjLA5Whk93PH9Eqibu8dAr
         h+y11eD9bwAHwnpX1tnDADa5M8V0P5lZ9rP+NKdT7TsF2O8ATBUSUdQeOJCZ3aW8wJ8P
         85/HcwZ3yIiuFZ3rq15763hejua9U9OuMxAyzo1rUA4xyqN347Yjqea0WNuOqMaSO7dE
         G/tQFbkAwL4Fn0aoEm+2VzRLH/MSYoEyS/VkXBETzgXG3BIyqaRNfg6HoUCd2fDZZtHd
         R/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741557827; x=1742162627;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2n1kKYhtsWKYB4THV+dU3ffLQAXcgXHs9GBsP1NeAQc=;
        b=f2ADB9V6HbMfoNhZiOHmgeq3yJPyRVU1gG6zRK9DnqlTw/TeFBr0RR0dnud/QCHwbi
         SQLNyHztZRHWPhENRaFkKdy/rD/nqrqYUUzJWcR+DSMSXx/e0twpvPbhak+48UQ+nuf8
         1Kvqb8n79XQuHoP3erdWn454KMKjriC8usBP1HevdZZ4mbM5wkc5jxgxtTu2bLRk6ToE
         yy+Wr/EP+TfPDyTb/xRQU+jHookIOn7H281L/cJ3eYlRHsvAr1oC/+cWmmhkSn+1awjW
         12+6vDVNSlrtiGZoZYfP+5jZ+BvSFOsABaaUxkN8f31isLZpFQvpFzp+bsyZPpSKLiG2
         OMzw==
X-Gm-Message-State: AOJu0YycHZt0jt2su+st7QS8co3P2qolJ9oLPVGvnlRCcW0CyC0Ixd4a
	XeKlgF4nV3CbBU5EOQYXua/dcnVr/pdvHo/i+2HSRebcRP6teLBPtBd0cX5JAo0whfadfsRgbGh
	aVsjW2QATUPG6cgLPuxKSt6XeA6U2nkrydVkCZbS/kyuH/BnHeHxKsMd5CW9mLP879Tlh5AUQZY
	8ydVHH0K1ABybt9f3fQbyFCg==
X-Google-Smtp-Source: AGHT+IHgHVZeMaZeOx8DZ6dMowYXgtxEW7zUlb43PjO43PiNfB/2CztSOQ6zf05/MmLBIpSTql5Slaoh
X-Received: from wmbet7.prod.google.com ([2002:a05:600c:8187:b0:43c:fad4:7595])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4710:b0:43c:f470:7605
 with SMTP id 5b1f17b1804b1-43cf470795dmr13401175e9.12.1741557827744; Sun, 09
 Mar 2025 15:03:47 -0700 (PDT)
Date: Sun,  9 Mar 2025 23:03:18 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250309220320.1876084-1-ardb+git@google.com>
Subject: [PATCH for-stable-6.x 0/2] Stable backport of c00b413a96261fae
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

This is the stable backport of commit

  c00b413a96261fae ("x86/boot: Sanitize boot params before parsing command line")

to the v6.6 and v6.1 trees.

Patch #2 can be applied to both v6.1 and v6.6. Patch #1 is a
prerequisite that is already present in v6.1 but was not backported to
v6.6 yet for reasons that are unclear to me, and so it needs to be
applied to v6.6 first.


Ard Biesheuvel (2):
  x86/boot: Rename conflicting 'boot_params' pointer to
    'boot_params_ptr'
  x86/boot: Sanitize boot params before parsing command line

 arch/x86/boot/compressed/acpi.c         | 14 +++++------
 arch/x86/boot/compressed/cmdline.c      |  4 +--
 arch/x86/boot/compressed/ident_map_64.c |  7 +++---
 arch/x86/boot/compressed/kaslr.c        | 26 ++++++++++----------
 arch/x86/boot/compressed/mem.c          |  6 ++---
 arch/x86/boot/compressed/misc.c         | 26 ++++++++++----------
 arch/x86/boot/compressed/misc.h         |  1 -
 arch/x86/boot/compressed/pgtable_64.c   | 11 +++++----
 arch/x86/boot/compressed/sev.c          |  2 +-
 arch/x86/include/asm/boot.h             |  2 ++
 drivers/firmware/efi/libstub/x86-stub.c |  2 +-
 drivers/firmware/efi/libstub/x86-stub.h |  2 --
 12 files changed, 52 insertions(+), 51 deletions(-)

-- 
2.49.0.rc0.332.g42c0ae87b1-goog


