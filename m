Return-Path: <stable+bounces-67365-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E23994F532
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 18:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE276B23212
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4567F187345;
	Mon, 12 Aug 2024 16:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1rBLTADK"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9E0187324
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 16:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723481276; cv=none; b=pWFo513WmsIF2M/3XIzjNJtOxOVYsRY7v7chuFj4l/nC6aiqUhIFt7f8lbFB8DrInag8CbWk8CB1RVbk/nBt+HgC0iM7W3UBlCZ3P8mB/PBIlb5qE+2zt/tPGRTwI+iXudkRhBNt2S+2Kwyhg4bieWQtiDku3nd88Z1EFRvGz5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723481276; c=relaxed/simple;
	bh=TmxIX5hjJkq4wPh3iSXY1tz8QGNGETs9QyEuazJFNKU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Gs/+Ov6mIXUaDG7SAdhTk/udi9nuGDfBRfGLibaNp5eVLDvcCeZCPR2c6Oz+DzCyeDY7Emm0QYfvq6UFvQu5f9Dg/Y8ud8eccKKnBqxe41e77IvJFr30AUDIb0BYhz7xzzQOlwKr3dgzEDXeXden3PsXvR+1af9U96k6rN88FlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1rBLTADK; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so69a12.1
        for <stable@vger.kernel.org>; Mon, 12 Aug 2024 09:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723481272; x=1724086072; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8W8rradjiBfJ1L/FzBWBc+HwrX/CzWtseLosahIJT/4=;
        b=1rBLTADKMXYfrNmeKOWEolVY7fDw+I/TdFyYegzLdOYka34083Z9XsT/L2f+qpX9ky
         1VnjNJW2AIXKqDfz/G2aRkYoMlvmmKz3aAZB/L/pRKMIeYr8clhUXPhwvKr7zFCzd7c7
         BYfqqlSx7RvsBCMRfZ/cS2RyA8ZhWFlkq0o2i5VDKHuLKtEi3r2jAdenrzZXx4Wqh5Lp
         F8k9Mwg6tY/ewg0IWdUHudlh0CnTpsu9c33kze8OY/jmvdaVn/LXkn6gg/prmK/TDB3V
         cRYUsoOjz+RCaA2D3k1i+bsNv3+nrtDw5n51ZXkj3jBZ+PUsngmA+XP5hhNJIzMCUfSf
         AhkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723481272; x=1724086072;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8W8rradjiBfJ1L/FzBWBc+HwrX/CzWtseLosahIJT/4=;
        b=SEbCFB7f2ru/vy4YcSWp5S8PfIoyX8P5snZeKr/AZqa5TVs3b4b2hOyyLa2X2jaIEU
         HtPSFUHoGC2s+B4d+TGnY9EszYUqZwZrjULuvItYmWIr2GDbRWR+iVczblJRIOchUaw3
         VDLjONkcSEBtcqtPJyC3hl5ITN2H0O6ScaYYJ05siHEUzR1mGhAKT8m2kgI2u3bzmDcT
         VkSpjc9vEJ9Bq89mv7fCGP2hYyZiXHLtr1G4nH3zvtEG4w4QDQqMn++HSYI+Zjiymacc
         YZXBcbG4GzWes1972rBbCUu7AobHm4tNcNYYAIbe6uA6lLaqaXn8CAMkJxLxwWZ7fLeW
         vHpg==
X-Forwarded-Encrypted: i=1; AJvYcCWzwOIRuhCymXKQwv2te6AVUih3RWHLMK2CgqacM7zKUxhWQgzhWSjus0ll+7COIXFrMCfAHI7w1HLeGJi6c8/Bx7pnc+iM
X-Gm-Message-State: AOJu0YwjC0SrOZn07+pSewEkAf+9iynj4NNs6beJm2uhq4eTf+0zrTvU
	zMzWQmqF/O5KiAoXehrwY+182XQ0G0L9YhM1Ld2WiCY8fNn+Z8UT2mc12yT+FUhUtc6m/vJbLuu
	HlA==
X-Google-Smtp-Source: AGHT+IHIWeGWnY8VcPSgXUJ/jzNWHCgruo+91eEPaXNqAV8WlrWy31snbJsf5esDSgYw/oHR4ZoreA==
X-Received: by 2002:a05:600c:b8f:b0:426:5d89:896d with SMTP id 5b1f17b1804b1-429c827daeamr2869335e9.1.1723480960022;
        Mon, 12 Aug 2024 09:42:40 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:731e:4844:d154:4cec])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c775c2b1sm110862315e9.42.2024.08.12.09.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 09:42:39 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Subject: [PATCH 0/2] userfaultfd: fix races around pmd_trans_huge() check
Date: Mon, 12 Aug 2024 18:42:15 +0200
Message-Id: <20240812-uffd-thp-flip-fix-v1-0-4fc1db7ccdd0@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGc7umYC/x2MSwqAMAwFryJZG2iKgnoVceEnsQFRaVUE8e4GN
 wMz8N4DiaNygiZ7IPKlSbfVhPIMxtCvM6NO5uCdL1xFHk+RCY+woyxq0Bu9k5qEqKShBtvtkS3
 /n233vh8+buAUYwAAAA==
To: Andrew Morton <akpm@linux-foundation.org>, 
 Pavel Emelyanov <xemul@parallels.com>, 
 Andrea Arcangeli <aarcange@redhat.com>, Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Jann Horn <jannh@google.com>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723480955; l=1348;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=TmxIX5hjJkq4wPh3iSXY1tz8QGNGETs9QyEuazJFNKU=;
 b=SYVIM0dXpOuaBFmfew0dZcfaQ+wJ/cNblzbj8USk3qwigNnGDB+zs4mcZYu8VvyVtvHWjADY3
 GUpkxlqeQHkC2YWDR6oOWImtLhppIn32/lWmXQKh3ZrzEtHBMayptaM
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

The pmd_trans_huge() code in mfill_atomic() is wrong in two different
ways depending on kernel version:

1. The pmd_trans_huge() check is racy and can lead to a BUG_ON() (if you hit
   the right two race windows) - I've tested this in a kernel build with
   some extra mdelay() calls. See the commit message for a description
   of the race scenario.
   On older kernels (before 6.5), I think the same bug can even
   theoretically lead to accessing transhuge page contents as a page table
   if you hit the right 5 narrow race windows (I haven't tested this case).
2. On newer kernels (>=6.5), for shmem mappings, khugepaged is allowed
   to yank page tables out from under us (though I haven't tested that),
   so I think the BUG_ON() checks in mfill_atomic() are just wrong.

I decided to write two separate fixes for these, so that the first fix
can be backported to kernels affected by the first bug.

Signed-off-by: Jann Horn <jannh@google.com>
---
Jann Horn (2):
      userfaultfd: Fix pmd_trans_huge() recheck race
      userfaultfd: Don't BUG_ON() if khugepaged yanks our page table

 mm/userfaultfd.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)
---
base-commit: d4560686726f7a357922f300fc81f5964be8df04
change-id: 20240812-uffd-thp-flip-fix-20f91f1151b9
-- 
Jann Horn <jannh@google.com>


