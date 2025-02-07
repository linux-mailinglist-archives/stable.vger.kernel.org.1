Return-Path: <stable+bounces-114253-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5AFA2C526
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 15:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49EB216346B
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 14:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34014223708;
	Fri,  7 Feb 2025 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZ9HxjHF"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910DA1624D0
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 14:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738938321; cv=none; b=Eok4v3oCOm3LxzYoe0NFcACQupSrNMoQGFZOXpr4ZIIQzZiI/MF44aB9pvB/jW1m0+fDN7Np5GUcecRENYFihGjiOCw+jZXsePfDanRG96WlfyNBueO9E4caeCvckISt5XSLqzsO/83txrt6Wa41wa+HZ8pkZ0VZG9vY56wJai0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738938321; c=relaxed/simple;
	bh=NoDAQJCVTRJf+w3Rke3bsj4ZXka3oU7IqKCMp/ldK1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oZ6FEqgyKAUgV9EPyqJJR4580SQv5OlRqsqL5dk4v5mIPZX27YAx00Nu35srbHQzrdS9YKPIcuQFzEZo2Q97sbUVPuvFGwUZYylqKwWjpPMJMuniakAe2cyXnZjmXkW4Yux/QrsvMssnjzLChbzoaF9lr0KXXhETQ9JGxPWVmbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZ9HxjHF; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2fa286ea7e8so1011294a91.2
        for <stable@vger.kernel.org>; Fri, 07 Feb 2025 06:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738938318; x=1739543118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dQEGaDCkNTW5e8C5UAyNEi9e+Yj1fkoH0mYOmgdK5r8=;
        b=BZ9HxjHFJnR/Zqrxgo43ribDkcB34hhERhzD2NnYSxsulMyrdKOi0aifIOi0YN5cjb
         B+rM1sZ4Vc5IygFbHwcjD+dwBgiJDQlr+EHMtbngeJT1xTH+3wLPV86xcJG73iIqTBJG
         YuvPVWxg1zrhhqc6TU1qSI1FyCySijhsMfAyQlEBsi4VJtEiCZyBHq1lfAPo/8jebubV
         iFpLJV5Xn3TvtOOZ89o6Mq6OHE8uOV/1l9Shll4F+3s1OQy4QHt+truh4LU9p5Xvfr9f
         OzJGqqoi3Xvk/Mrln+Hn4Iwy6YPUXoiM36SWyVd+tJ0DdkDzl19/F4jtNQDHuopak2P3
         G+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738938318; x=1739543118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dQEGaDCkNTW5e8C5UAyNEi9e+Yj1fkoH0mYOmgdK5r8=;
        b=VfR5MQ+SO9AFSDXM0riHZP+b8e+OlIt4baXtBVGDJqbh8fAn6VP6i40knNpcZApkGO
         NTackyinyi7yUln2w7yIAVLvG5bdoD/zLCc4MnkTURCoWFyPoFyGTFMSZoq6CK9JA3hc
         f1bbM41UUKdPKPAHR2s+OYa5gKO4Z1jcq0yhxoSmiUNm8Vf/Y7a5ehNPts9DRBIo0tQo
         EIMdKfowcq0hn9mWTaY2kVfAu4SL+0q4n9JaGovRrXCocUi0xUijF4vZSYF2CtFx9biz
         WXK9Y47o9MpcLx4ZC4o85tQOXpD4J04beXdP6CnxoBxWWG/1+VwEcRsp/kceXeAUAI0j
         3kqg==
X-Gm-Message-State: AOJu0YyYvdeJ0k9uox0SCKzX+ZrOJowFFWiPVIisT3C3ie/d3XLv+TUj
	AEtolXhdeIZthZro7/PQwJEEr2zDKZALx89S6V3yPTpDoHf0byEVhe4fIg==
X-Gm-Gg: ASbGnctjXd4+14E+Of6ROcBewyDh0Sz/uA339SENC9ZuIJWR1K0KasLnm/0IcjfscTa
	PeBUR2ykpBm0SeWtVeG5o+sVwbgrwb9QWVdIyp7pIYSZljijC1/MvKq81NEU5pfMegmYAKqM04k
	6p0yWSqjAcs0Y3aS6ZTM9mw/ryGBymBkrQneRPeVDwsnXQGfW0Dg8iBpkccVEMWPv8GhNCOWLzr
	Sf4uyIlTAm7x8nLMh2SxNryfJvTW7Zk3a83anSR2nZ5Gainm0TUvU5YNWDiNfuGkJVxPleYCOo2
	9g3nSPMeJ1iPB3LHUlcnwT1JOW7GKgpIj6jBGCs77Ghy0L269dPIOy0+pw==
X-Google-Smtp-Source: AGHT+IFAJsUFee1mR0MPpD4X7ZE/PfuD2MDLtovhmoEAGS4E0LNCUsBOtSzeItxhZGQmKibY9S64VQ==
X-Received: by 2002:a17:90b:3dc3:b0:2ef:316b:53fe with SMTP id 98e67ed59e1d1-2fa242d9ac0mr4091485a91.22.1738938318207;
        Fri, 07 Feb 2025 06:25:18 -0800 (PST)
Received: from carrot.. (i222-151-22-8.s42.a014.ap.plala.or.jp. [222.151.22.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3655164bsm31174055ad.85.2025.02.07.06.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 06:25:17 -0800 (PST)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.4 5.10 5.15 0/3] nilfs2: protect busy buffer heads from being force-cleared
Date: Fri,  7 Feb 2025 23:23:46 +0900
Message-ID: <20250207142512.6129-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please apply this series to the stable trees indicated by the subject
prefix.

This series makes it possible to backport the latter two patches
(fixing some syzbot issues and a use-after-free issue) that could not
be backported as-is.

To achieve this, one dependent patch (patch 1/3) is included, and each
patch is tailored to avoid extensive page/folio conversion.  Both
adjustments are specific to nilfs2 and do not include tree-wide
changes.

It has also been tested against the latest versions of each tree.

Thanks,
Ryusuke Konishi

Ryusuke Konishi (3):
  nilfs2: do not output warnings when clearing dirty buffers
  nilfs2: do not force clear folio if buffer is referenced
  nilfs2: protect access to buffers with no active references

 fs/nilfs2/inode.c   |  4 ++--
 fs/nilfs2/mdt.c     |  6 ++---
 fs/nilfs2/page.c    | 55 ++++++++++++++++++++++++++-------------------
 fs/nilfs2/page.h    |  4 ++--
 fs/nilfs2/segment.c |  4 +++-
 5 files changed, 42 insertions(+), 31 deletions(-)

-- 
2.43.5


