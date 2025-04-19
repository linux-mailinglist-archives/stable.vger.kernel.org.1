Return-Path: <stable+bounces-134691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37921A9433A
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 13:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 321F88A4453
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 11:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2821C84A8;
	Sat, 19 Apr 2025 11:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9+JfBqD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C12B18DB29
	for <stable@vger.kernel.org>; Sat, 19 Apr 2025 11:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745063247; cv=none; b=t0co8flqM+efg6hxfk9//ihRxFZZOyDwT5XDoe0Ioq82pcAiJRWJCPUH8WTqok/i7eUcrz3JuymqvajT+Dg3V3oEjJJaGGFDjLoHMQiUi8va3xjC0idVWL7bY+EDSvrUJDjPd0kicarbtyJpGutJ0phidABSEOCLm58WVAtWNUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745063247; c=relaxed/simple;
	bh=lC73PSVftXvQrFDrmffEqwrxWCs71lrkmJ86DxMIp8A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eU34iWPjNQYXR4o5Dv4cveggWzCHaLOmBFVyXj17NfxJJdC8tjE73l2Tjo8VgYSGyf4COu8TdFO1Ch6cR62BJMBA6QbpvSkYLtChiJJJQ+E4iYtAzkxe1OglWjQOnM1s+Ds0XaQYqubTaLyWGXhTYocg/RpJFVookE/Ua9ABvTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9+JfBqD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916ABC4CEE7;
	Sat, 19 Apr 2025 11:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745063247;
	bh=lC73PSVftXvQrFDrmffEqwrxWCs71lrkmJ86DxMIp8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V9+JfBqDGr6iSNVem/VbG+AHWPUA1MRdQ3E3dLASm01V2lNiLYc+frXj7/Fdkecme
	 JtijwYA7NeUQSiNzo2yDcGTEDEQMwV+fImRBlxrquEIaPOr8GyDFqaa3i5HdLv6vDM
	 N2+i0Wrv5Ys1qUJ/UZ+Dg6JMrp2zi4Ed7xCVhPnTIr9fYN3b9D8r+XscAnqGrKCu/k
	 r0TWGAU6aV4saa2cgGrlKzo8NohCBhqbeUON2XDyKKBVU227HJ6IeTLonSNsaTvd2+
	 L0ScPeyicnoaYCs33HzNHJRkyFIqTxMio+Kf6Lu0vpTXI3ZeYD1Afl21sKoLMznPz9
	 lzObz+M2hPdPg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	mic@digikod.net
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] landlock: Add the errata interface
Date: Sat, 19 Apr 2025 07:47:25 -0400
Message-Id: <20250418165929-4c038f25145cb4e8@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250418092057.1988926-1-mic@digikod.net>
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
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  15383a0d63dbc ! 1:  13e28a2a55f3a landlock: Add the errata interface
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
    @@ security/landlock/syscalls.c: static const struct file_operations ruleset_fops =
     + *
       * Possible returned errors are:
       *
    -  * - %EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
    +  * - EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
     @@ security/landlock/syscalls.c: SYSCALL_DEFINE3(landlock_create_ruleset,
      		return -EOPNOTSUPP;
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

