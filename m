Return-Path: <stable+bounces-134675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE02A9432A
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 13:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 155591899CF6
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 11:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027FB1B4244;
	Sat, 19 Apr 2025 11:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoSucKga"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A8F18DB29
	for <stable@vger.kernel.org>; Sat, 19 Apr 2025 11:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745063214; cv=none; b=aViaUMnfX+K8kbh9Wu/Gwe+JFDCaoJA+74AmJO9duCT2A0Rc4iKykdMXXNgspAYDwp9AInxDPGP6qAFoOJm7jDaze/P4luuKXv/NWGDAU34BleDI28FpZcRLNl4yZpKQrmUIrbbLNUZjVeGFnvzCfzSU1dr7dNyroFlMdVf+C5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745063214; c=relaxed/simple;
	bh=+jPHhntHe4G1xHAt2EM6bnsnDA33cUKZf47qxmWZD6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YARcFqWiMu0Tk3k/Imwuzy/M5cMv4aQ7ljIEx0yJuGe6Z4g7R0QWh2NsOje2B5VVfFYMKuktIoSOZ0UPqvi01zRc3phljaao89TLs1WUDn2qDW7GkOkjJSDB6YKzzGTCZFrqzR5D8reBCr6mwKfYphpqv9WzmPczSzElSq8iSuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoSucKga; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B82C4CEE7;
	Sat, 19 Apr 2025 11:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745063214;
	bh=+jPHhntHe4G1xHAt2EM6bnsnDA33cUKZf47qxmWZD6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MoSucKgaanKufK48OZXIoXlkcBMEJXIIztqAy96X9auMMebVOapYVAGZ6Gj6DRro8
	 mVPqyK0w47bsdA9Szq5hMvgba6J55nALk6QhtUpmSeWJSPaGhcuZrk3SbhCje5VCnc
	 GygHhyaQrLWSfW34RDz6n67UkhI+JKe56CVKD+O++UmT+d0c0jn8Lp7O2wHGFlaWFX
	 wgFtPBItws3PvIdf1XcO2yhA2ZehR5cDnHT3vFuIDwBQHAe6od8SNWHoEGuLU89dp7
	 3JoEnn0OjATb0RQPpA4XcYtOriP3GAqLUQWTs9dbjRS8RDTe5RjgBsoVw3/9gZEO1R
	 ZLiog/m8KdE2A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	mic@digikod.net
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] landlock: Add the errata interface
Date: Sat, 19 Apr 2025 07:46:52 -0400
Message-Id: <20250418154532-886623be0b8c77a3@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250418092148.1989291-1-mic@digikod.net>
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
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  15383a0d63dbc ! 1:  7630c5f930b8b landlock: Add the errata interface
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
    -@@ security/landlock/setup.c: struct lsm_blob_sizes landlock_blob_sizes __ro_after_init = {
    +@@ security/landlock/setup.c: struct lsm_blob_sizes landlock_blob_sizes __lsm_ro_after_init = {
      	.lbs_superblock = sizeof(struct landlock_superblock_security),
      };
      
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
| stable/linux-6.1.y        |  Success    |  Success   |

