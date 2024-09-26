Return-Path: <stable+bounces-77837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16971987BD1
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 01:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 222391F22557
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 23:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC0A1AFB3C;
	Thu, 26 Sep 2024 23:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3gET8Axi"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B7718890E
	for <stable@vger.kernel.org>; Thu, 26 Sep 2024 23:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727393801; cv=none; b=RCYJozP6RcKlINefP81PYkvMVU/sawNLbDJJ4TWwgkmNz1iwu/KGIHRPO2BvUKEaaiGMmWBJK7wGGrEoWC45Tx01L8RcVjHEBS5eW1FChi5d/kh7bVwYCoj2oMd7XXNgZwnuTOgFC1kAco1XvIwTIIDCXoPLIhVCboiAQfIdeNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727393801; c=relaxed/simple;
	bh=btuG0rdXl4iycnF0syedQgjixOF4epBMnIrgHcGRgko=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BvjMtJ6rkNMml1jUyq/6aSpCmLSkz8OYboeXeN9nuXHMf4AGRdAWfT59bDxunAVsDc33oYH3MI/ZEX7dLBpTlcQ3GK9KxOURku4epSnbft2dERJtgt6NmezIcYmvy5pozJAFKFfsWox7WKhD9D5yUoT2prThxHomX3Oll8eHA5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3gET8Axi; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-718d51f33a6so1498109b3a.2
        for <stable@vger.kernel.org>; Thu, 26 Sep 2024 16:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727393799; x=1727998599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3zA+NTTDrNsYiLWyeaQyWbu0C8Sd9VhUHtR4/aWFrb0=;
        b=3gET8AxiM0J+OkjELMWE89de13/XGyCPhebRHe0cAhqg52vZXhE+dfQqO0c2uvwUmd
         ginoXg8KFDmdWiiIvzUeQAGCp6zw3I7Q8TqVPKixFpxy7j47hBS/OULmyGTFO6FQAVqE
         aMHp6g64WnbkzNCZrl/3PYjUNg2V4nWIUlfoZP4uIjikAOlecfO9AIwyAzdYvkHcI9zt
         HjrN1mwsH4/Hj6Abnq0lbsLuRIV6qiB04BRx9WG5MNhVRR3E0Lk+sv1uFhJXOCcol+3Z
         vvYVuDdIKtofHKAzOhgrUhyWdnzQPT8/y5jxBMuW+9oHJmYpZAmMx7vwOvSBGPJv96Sm
         rCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727393799; x=1727998599;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3zA+NTTDrNsYiLWyeaQyWbu0C8Sd9VhUHtR4/aWFrb0=;
        b=NFGq8V3fA7IvIlRvuUy53m8Q0Lkdhh200Kf9TMsW1SQDzH/9vFsG6aEJiX0unySYnM
         N6AhkJw2EHU4FN0wZcCDoArsMail5H/++rv70g9WPtDZNhXZT29MhpV1xEg/O0YJm9Hv
         sjT1wBmL1OKP/sRZ3zAQHjBz+AMxKl4Gf2pM36WNoEBPDAXyZs2LFk2b3DiEPJZfXHU/
         n5PBkuwXEf65xXE100SzDHIEqlJfSpytl/eNljmzvt2Oy+8G9ld5rJM9/QLdJLtzaOhP
         d53O+WGB6nkrdgGowax9urQtdQfGOgkZ9ZmumbO71/UnBrwu8XzXY3BRdWJ8uAgEJ5G4
         JIWA==
X-Forwarded-Encrypted: i=1; AJvYcCVoQ1sZdDU6autFYIbJ7IUG8jk+DJEg0RFjddDdN7AJO3PYAAEDqJv7wNRAOVq/fbcPMBcNaps=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTSjFSiwrMI5ntQmhKMcLoaCjX0eeq75nj5mQVJs1/g3YcN0iv
	y2BPLhKljDjjkpvBO+y9s0g6AIyN0r64/kurTef4jjVbpFjuPTDKYg8aBWK9mEdiveW6Y7WrO8c
	8cHkl32Y+9Q==
X-Google-Smtp-Source: AGHT+IGCxy+wJv8OHzbyv/7j+8lY+SUfQRcB6l5MQseGCOvdCvySd0fiWD3iueTVvTRZKAMAXhW61Dy8Pss2bw==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:aa7:8b46:0:b0:717:9865:235e with SMTP id
 d2e1a72fcca58-71b25f3520cmr4837b3a.2.1727393798608; Thu, 26 Sep 2024 16:36:38
 -0700 (PDT)
Date: Thu, 26 Sep 2024 23:36:11 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240926233632.821189-1-cmllamas@google.com>
Subject: [PATCH v2 0/8] binder: several fixes for frozen notification
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org, 
	Carlos Llamas <cmllamas@google.com>, Yu-Ting Tseng <yutingtseng@google.com>, 
	Todd Kjos <tkjos@google.com>, Martijn Coenen <maco@google.com>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Viktor Martensson <vmartensson@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

These are all fixes for the frozen notification patch [1], which as of
today hasn't landed in mainline yet. As such, this patchset is rebased
on top of the char-misc-next branch.

[1] https://lore.kernel.org/all/20240709070047.4055369-2-yutingtseng@google=
.com/

Cc: stable@vger.kernel.org
Cc: Yu-Ting Tseng <yutingtseng@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Martijn Coenen <maco@google.com>
Cc: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
Cc: Viktor Martensson <vmartensson@google.com>

v1: https://lore.kernel.org/all/20240924184401.76043-1-cmllamas@google.com/

v2:
  * debug output for BINDER_WORK_CLEAR_FREEZE_NOTIFICATION (Alice)
  * allow notifications for dead nodes instead of EINVAL (Alice)
  * add fix for memleak of proc->delivered_freeze
  * add proc->delivered_freeze to debug output
  * collect tags

Carlos Llamas (8):
  binder: fix node UAF in binder_add_freeze_work()
  binder: fix OOB in binder_add_freeze_work()
  binder: fix freeze UAF in binder_release_work()
  binder: fix BINDER_WORK_FROZEN_BINDER debug logs
  binder: fix BINDER_WORK_CLEAR_FREEZE_NOTIFICATION debug logs
  binder: allow freeze notification for dead nodes
  binder: fix memleak of proc->delivered_freeze
  binder: add delivered_freeze to debugfs output

 drivers/android/binder.c | 64 ++++++++++++++++++++++++++++++----------
 1 file changed, 49 insertions(+), 15 deletions(-)

--=20
2.46.1.824.gd892dcdcdd-goog

