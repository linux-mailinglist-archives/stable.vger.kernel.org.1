Return-Path: <stable+bounces-134692-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 652B1A9433B
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 13:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33028189A18C
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 11:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1827C1C84A1;
	Sat, 19 Apr 2025 11:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cx27OPLo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB59218DB29
	for <stable@vger.kernel.org>; Sat, 19 Apr 2025 11:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745063249; cv=none; b=mkdXfNo6azRJJ7FZJdCeMJ1nomRs6AnUED1n4IiWYWnm/L9jzeGc+eBbwhRcF/IHK+aakcoJw+lRWutIbDxb/maEurl5bOCKxmpBhPI7nDqC9lrACOwjyILDy+EHpBEQmu25eHtXNFETwo9THVS9E5yn0iW+GhVcPvl0898CXcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745063249; c=relaxed/simple;
	bh=fq0HlNQHwr/DPX3fIlZj8S4BaeolGbTnUrlSEFHJaCc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t2FmoJl5TlQTCr71MydrRUsnBjwOHknTynZamTiayXos33disDxEL2KgQkQLM2/pI7t0P0OtX/Pkx9YoHEf6IS4RLdpKEGieUbMOq04eotoPkzyVWxPq6eWfOvvY0FiIrSFYEjX9P3PuGVous7XsLoyeKO48MXh2oL3lr9TwsXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cx27OPLo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D763FC4CEE7;
	Sat, 19 Apr 2025 11:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745063249;
	bh=fq0HlNQHwr/DPX3fIlZj8S4BaeolGbTnUrlSEFHJaCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cx27OPLoGaAdTZDqllfOo2QglEJoGr025n+0f2UWzYarQ3KZmhsxeZn1YLzWF837F
	 EUVZyK2cTTtn/LI6FKE5PqabnPnauSyHlZaoqCQRuXoJf5WOcRmNe6RQ00EvUfakZJ
	 LCbYqSpLP62rlXQUmeqN5IdC0ljJfTfB4eWEUAUEkwthxR0fKnm9Ya/h95JaEH0boy
	 D7WO66yy/fhahedcBGaNWPGV7Tww3om8LZS8DLgdTW3JGvp1rtuBD+ZTUd2XjFO81p
	 E1wnmQNzeqlzb7py5ZshZpwQ/qH9zwihci00i84Bsn4zBErrr2h26Qc6lhK4B0rkGS
	 8ZGvUUu0Veu2Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	mic@digikod.net
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] landlock: Add the errata interface
Date: Sat, 19 Apr 2025 07:47:27 -0400
Message-Id: <20250418162926-e6673f6e7a64da72@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250418092249.1989854-1-mic@digikod.net>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 15383a0d63dbcd63dc7e8d9ec1bf3a0f7ebf64ac

Status in newer kernel trees:
6.14.y | Present (different SHA1: 728f62bff8a0)
6.13.y | Present (different SHA1: be73220526b7)
6.12.y | Present (different SHA1: ed390ad1458c)

Note: The patch differs from the upstream commit:
---
1:  15383a0d63dbc ! 1:  9908f3355915b landlock: Add the errata interface
    @@ Commit message
         Cc: Günther Noack <gnoack@google.com>
         Cc: stable@vger.kernel.org
         Link: https://lore.kernel.org/r/20250318161443.279194-3-mic@digikod.net
    +    (cherry picked from commit 15383a0d63dbcd63dc7e8d9ec1bf3a0f7ebf64ac)
         Signed-off-by: Mickaël Salaün <mic@digikod.net>
     
      ## include/uapi/linux/landlock.h ##
    @@ security/landlock/setup.c
     +#include <linux/bits.h>
      #include <linux/init.h>
      #include <linux/lsm_hooks.h>
    - #include <uapi/linux/lsm.h>
      
      #include "common.h"
      #include "cred.h"
     +#include "errata.h"
      #include "fs.h"
    - #include "net.h"
    + #include "ptrace.h"
      #include "setup.h"
     @@ security/landlock/setup.c: struct lsm_blob_sizes landlock_blob_sizes __ro_after_init = {
      	.lbs_superblock = sizeof(struct landlock_superblock_security),
    @@ security/landlock/setup.c: struct lsm_blob_sizes landlock_blob_sizes __ro_after_
      {
     +	compute_errata();
      	landlock_add_cred_hooks();
    - 	landlock_add_task_hooks();
    + 	landlock_add_ptrace_hooks();
      	landlock_add_fs_hooks();
     
      ## security/landlock/setup.h ##
    @@ security/landlock/setup.h
     +extern int landlock_errata;
      
      extern struct lsm_blob_sizes landlock_blob_sizes;
    - extern const struct lsm_id landlock_lsmid;
    + 
     
      ## security/landlock/syscalls.c ##
     @@ security/landlock/syscalls.c: static const struct file_operations ruleset_fops = {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

