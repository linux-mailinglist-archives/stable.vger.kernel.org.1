Return-Path: <stable+bounces-126765-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F0CA71CFE
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 18:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 432BE177557
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 17:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0A4203719;
	Wed, 26 Mar 2025 17:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="by5Ez+4C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D560202C4E;
	Wed, 26 Mar 2025 17:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743009576; cv=none; b=Pc5kZkWoCV/sScgWsYTeMt1k6OFeJJ+CyDcGXzuSB4/QoeUycNHSC3b5GB/z6m3fppg3mGTqT5vvX50EI/CdYylMZDT8qbrTPdsO2iu74FP8gpYCfBR5nlINIdDdw7Fmjd6FSqJFQOjhLsLhybuBGXKjZ9DGFgIjAT1NGjGJ7i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743009576; c=relaxed/simple;
	bh=+49VODqoj66jw7qSglZ0qzDiNUhovV3FO932Zf0ilsw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UvMp5TKMi/ulOSgt+yPHqPpEjNHjZsjm8aiYT7+Ld6Tw+OHnQzXGzTqa3I6LjHcSiVj24h2EJg6C2tCMjRBxUbshY+aOwV9V7mJAo6HOgIjDFhEJyl7PbBnkSdaDxf5zSVxVc1IPJH2J/el7qvCVNjNWMreZ+YF5TTcE/IoflKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=by5Ez+4C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF39BC4CEE2;
	Wed, 26 Mar 2025 17:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743009576;
	bh=+49VODqoj66jw7qSglZ0qzDiNUhovV3FO932Zf0ilsw=;
	h=From:Subject:Date:To:Cc:From;
	b=by5Ez+4CGpJ4g3aL+02KdMQdu1IAWtduTkPCqVeHcRJT0hSiqJaRLin/05YS7biYx
	 CUuoDZ5KhtWc7r9bZn4I8UuGMxrQQ6gFQFTqph9e1W7lLX/sxt/J7ISB8rtNb3i/nX
	 AcqdUTjfeBCPK9wLSApiIYzRNowy4gYU+FvfaJooRbhZCj+KkE8kK/1NM11mhF89zh
	 1hKgPtjp1Ybi8VcY32rP/a2B4uKswtDNZ1rcWqanCoRA2B7LfPI5ARf9B0pfsZG9qG
	 AONO+u238blggxajwtaUdwXepSvrJARBaaQrEACbw47EKFR+0y502RAYUw1JiZ/7b0
	 7LrFoemKIj8mw==
From: Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 0/2] Add wcslen()
Date: Wed, 26 Mar 2025 09:32:30 -0700
Message-Id: <20250326-string-add-wcslen-for-llvm-opt-v2-0-d864ab2cbfe4@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB4s5GcC/4WNQQ7CIBAAv9Jwdg2gTakn/2F6aGHbEhGapUFNw
 9/FJp49zhxmNhaRLEZ2qTZGmGy0wReQh4rpufcTgjWFmeSy5id5hriS9RP0xsBTR4cexkDgXHp
 AWFZoeN20wgyt1JyVyEI42tc+uHWFZxvXQO/9l8TX/tL1v3QSwGFQo0CpRaOUut6RPLpjoIl1O
 ecPgEpbss0AAAA=
X-Change-ID: 20250324-string-add-wcslen-for-llvm-opt-705791db92c0
To: Kees Cook <kees@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, llvm@lists.linux.dev, 
 stable@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1541; i=nathan@kernel.org;
 h=from:subject:message-id; bh=+49VODqoj66jw7qSglZ0qzDiNUhovV3FO932Zf0ilsw=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDOlPzFXbuHpfx290nF57fAa3ze9fKzltO65lNs240cJxZ
 qr0MpXfHaUsDGJcDLJiiizVj1WPGxrOOct449QkmDmsTCBDGLg4BWAiKpKMDAcKVux88OXDd7Vj
 gu0LLs/7/CH9unrn9y+ztOpN+j5vvriKkeGXR//X3nVJV9dP/sv/6suNaf78LBdvFR9ecuEoL9O
 7RXJ8AA==
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Hi all,

A recent LLVM change [1] introduces a call to wcslen() in
fs/smb/client/smb2pdu.c through UniStrcat() via
alloc_path_with_tree_prefix(). Similar to the bcmp() and stpcpy()
additions that happened in 5f074f3e192f and 1e1b6d63d634, add wcslen()
to fix the linkage failure.

[1]: https://github.com/llvm/llvm-project/commit/9694844d7e36fd5e01011ab56b64f27b867aa72d

---
Changes in v2:
- Refactor typedefs from nls.h into nls_types.h to make it safe to
  include in string.h, which may be included in many places throughout
  the kernel that may not like the other stuff nls.h brings in:
  https://lore.kernel.org/202503260611.MDurOUhF-lkp@intel.com/
- Drop libstub change due to the above change, as it is no longer
  necessary.
- Move prototype shuffle of patch 2 into the patch that adds wcslen()
  (Andy)
- Use new nls_types.h in string.{c,h}
- Link to v1: https://lore.kernel.org/r/20250325-string-add-wcslen-for-llvm-opt-v1-0-b8f1e2c17888@kernel.org

---
Nathan Chancellor (2):
      include: Move typedefs in nls.h to their own header
      lib/string.c: Add wcslen()

 include/linux/nls.h       | 19 +------------------
 include/linux/nls_types.h | 25 +++++++++++++++++++++++++
 include/linux/string.h    |  2 ++
 lib/string.c              | 11 +++++++++++
 4 files changed, 39 insertions(+), 18 deletions(-)
---
base-commit: 78ab93c78fb31c5dfe207318aa2b7bd4e41f8dba
change-id: 20250324-string-add-wcslen-for-llvm-opt-705791db92c0

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


