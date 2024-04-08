Return-Path: <stable+bounces-36310-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4D189B7EF
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 08:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A5AA1F215FE
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 06:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AF61BC31;
	Mon,  8 Apr 2024 06:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s/r03b/p"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784922B9AF
	for <stable@vger.kernel.org>; Mon,  8 Apr 2024 06:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712558981; cv=none; b=G6pXesUGBDolgZdHII/6lifKGcGLOZazjqVpBSQRp1fvedgKoTDXbu3WCAysvUfVfBdS/pL2JdqYDah+2j/mKSkv06RWiZmZBvLI4F104frV7/Rd0DWbElvKF8tn0BQ+5pV/u27+eZamGxXAeY/WkGMLXa0RvDDlcIZfE/nqCrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712558981; c=relaxed/simple;
	bh=CXZUwPwD15lH1zgbTSEV1d0b6Wey+8yMIIfBYXOWPSE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gGBoWjcSG/SkTeoJnv63CCj17R+xtTME+uG28fCMjXMgDZPjuufm1EJv8XsvxWN3HqWWRouKbBy6knHWi9fNMAJFAVi04yTIyVy4WyyQCWunEVehm+Rqqk1U8M7s/WBaDlEU3/gUNQjK+WvqbZF8zZlbuF8JrH+TBLa6np5Wkz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s/r03b/p; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4162bc2da3fso12686545e9.1
        for <stable@vger.kernel.org>; Sun, 07 Apr 2024 23:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712558978; x=1713163778; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ey5xMkvOJxruqnjFfBGwjxj/6b+vvCV1iafyhdCjvn8=;
        b=s/r03b/pinmMdTOkmAMdVKgj7/P9PtDST9FxAwnSg/HV7IC3mSUo9TjPZx+sCao6w/
         f1OrgE1d42remL9Bm35UR2eMxTKAhbtBGvtEvL+5kD992bGFhqLxq8u4GY+Nw6D+x+WG
         5u31rg2YDyBgL+yT0Sl4Y4UuH9N7qaGdwKvZyfZPyj22Iwn34RH5RbnyzUAUpUNJgEz/
         aMYujvKTgfHjV6fR3Joe4aq6tlrtCrVVg1OJ+/njmFoSEkscPiSJpRzOy6RGOwAPm2kq
         tapWevB9YLtkIqVB26xIyvSRPHIeju4ND1Qt4zhmEY34M0Tt/xbMKD7t0hFY4Dd2V+D8
         ic5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712558978; x=1713163778;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ey5xMkvOJxruqnjFfBGwjxj/6b+vvCV1iafyhdCjvn8=;
        b=ozpxVxWu+T6ZG6gZidA7eMH74ehpFO/1smbB/h9Ac9Br6JuGpL3DAdKg5T/ka/hRCi
         Nw7jk9mnHUoLa0Y+Qng8XRkpl6gQ5gScAdL0324BUSYfNpl6QfUTHoeoX1+WzG+QDvnp
         A1YQ8xU8cpImYoZJ9weanue2H2Vv1iJrMS9jdYM7E+SHcJlscqafWpKFHutNqtIK6AZ8
         J3HsU8YTnIgcYRLDgDcvIEoVUfgN2Xj2EdyeFKeQ4Cq1vErYSgEBec1iOrVKey3K7PTw
         BA9CAm7E+naQiWEM/m0GPIYzVcIgzCaExEDt6LJCOYEaVrGUs2rSe/RHfC0waWlccQgd
         ghBg==
X-Gm-Message-State: AOJu0YxGQs4y7RSbluvuaLcjJ/R2goVpl7ZB2wNUVOiS+7cyajJbBdOH
	3008qBxn1CYoaEWTmQdx0XuD1c1+pCb5WC6oEHDpukazpM74ADpD5TJgjheiiCJDH4ChcnvI35g
	tuAJnUHtmZmi5oOBJd3+gjgizuy+fVpUmi8/P73QZejJVPkJo6n/g0jufVGNola67+sVs/mzxP2
	1GH3ViA974wd9pF1rMe64VTA==
X-Google-Smtp-Source: AGHT+IFe00mjY4cL2MrOTH/DWC6c7Cq5WtdP7+z+ppRDsiumvRNSZiaPdrGMUm0+navfEg57P/Z5exeY
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:510a:b0:416:7e7e:98cf with SMTP id
 o10-20020a05600c510a00b004167e7e98cfmr3607wms.1.1712558977797; Sun, 07 Apr
 2024 23:49:37 -0700 (PDT)
Date: Mon,  8 Apr 2024 08:49:18 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1928; i=ardb@kernel.org;
 h=from:subject; bh=2LD34qqEHbnPlZ+11j84Yel1YkNAKHcKomyxkTh8cZE=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU14ci5L3LIKwS+Sy9sXXt1WsO3j/s4lC/oqD6hMnPLNr
 OHxx5PtHaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAi51sYGe5EeZSW31122n5G
 cn20wNN+7m1iCbZbcx/VLl7rIig1sZbhn9oMk7WLJwQmaM+ezVhQvWdV3JFy4Zd/Jm7wVSw40aX /igMA
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240408064917.3391405-8-ardb+git@google.com>
Subject: [PATCH -for-stable-v6.6+ 0/6] EFI/x86 updates for secure boot
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Please merge the attached series into stable branches v6.6 and v6.8.
They backport changes that are part of the work to harden the EFI stub
and make it compatible with MS requirements on EFI memory protections on
secure boot enabled systems.

Note that the first patch by Hou Wenlong is already in v6.8. The
remaining ones should apply equally to v6.6 and v6.8. Only patch #5 was
tweaked for context changes due to backports that overtook this one.

Thanks.

Ard Biesheuvel (5):
  efi/libstub: Add generic support for parsing mem_encrypt=
  x86/boot: Move mem_encrypt= parsing to the decompressor
  x86/sme: Move early SME kernel encryption handling into .head.text
  x86/sev: Move early startup code into .head.text section
  x86/efistub: Remap kernel text read-only before dropping NX attribute

Hou Wenlong (1):
  x86/head/64: Move the __head definition to <asm/init.h>

 arch/x86/boot/compressed/Makefile              |  2 +-
 arch/x86/boot/compressed/misc.c                | 16 +++++
 arch/x86/boot/compressed/sev.c                 |  3 +
 arch/x86/include/asm/boot.h                    |  1 +
 arch/x86/include/asm/init.h                    |  2 +
 arch/x86/include/asm/mem_encrypt.h             |  8 +--
 arch/x86/include/asm/sev.h                     | 10 +--
 arch/x86/include/uapi/asm/bootparam.h          |  1 +
 arch/x86/kernel/head64.c                       |  3 +-
 arch/x86/kernel/sev-shared.c                   | 23 +++---
 arch/x86/kernel/sev.c                          | 14 ++--
 arch/x86/lib/Makefile                          | 13 ----
 arch/x86/mm/mem_encrypt_identity.c             | 74 ++++++--------------
 drivers/firmware/efi/libstub/efi-stub-helper.c |  8 +++
 drivers/firmware/efi/libstub/efistub.h         |  2 +-
 drivers/firmware/efi/libstub/x86-stub.c        | 14 +++-
 16 files changed, 94 insertions(+), 100 deletions(-)

-- 
2.44.0.478.gd926399ef9-goog


