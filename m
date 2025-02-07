Return-Path: <stable+bounces-114334-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 463FCA2D0FF
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 23:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDF6616D629
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 22:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B37E1B4223;
	Fri,  7 Feb 2025 22:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kihVBfV2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9C41AF0AF
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 22:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738968677; cv=none; b=ZtRUOR1Gw8VMK9S2w8EaBqUW+WRWL5qj8sm44bHY8vcQzVf+UsslyVF8nbg/2ZhoyQagVUYTTNGfvjwNs5tU26kDXGOZ77kcqFiTc4TtBaJ2prmO9GQ8L+R+B3u9BDIBqxEQj5eVdBwYn3avgu+zq5273XeEQ7lTStc0ebQElYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738968677; c=relaxed/simple;
	bh=QVr1VcEV8W0DXWooU6Cs0PV9tZDWma9xgWFEpCxMGfM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lgbf1RB+rsGmUhagrAGYWUvTcLxlk+sDPDA72MWRN3v8YqUkX5GDOWGJpizgvOe1L4lI99QiopKWftWk4AHNMYvWlbM/WyCXm25CfqJkNympbUIEVLACFKcRLX5rws/AmtoobafQ+Xrv918uysytyN8JhGJa/o14Mcm8/vez1YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kihVBfV2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7FCFC4CED1;
	Fri,  7 Feb 2025 22:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738968677;
	bh=QVr1VcEV8W0DXWooU6Cs0PV9tZDWma9xgWFEpCxMGfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kihVBfV2fxK361ZqLc71af6qE9JfWigMXuha4s8iLVBjztREArLgzsSv5K/c42Daz
	 lvcxALfdtUMwtIi3HgUOtrcQLRNtA+vTJbttiQ/t40yiMD7ZqctJbnJ8mjloRSZak2
	 crwqJ8zB3izuFmqTTvtWhjnRBBJJUZNiuw+eeYhE1onosBtwWIcUzo1tMwy5kl6vlP
	 9I6zjzbN8ihEyoy4esg28pRwu+eiEmBfnOmireJ41atFNCVxPNBhrs9eVRZbTVnDgw
	 tTCCsa4ZAbssYzjZbXv07w7S9hLftSNiBX5BdqBqSOdO/HJinqfP++8hHgGOI1+8A6
	 Bcay4PVdt3MdA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: WangYuli <wangyuli@uniontech.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4~6.13] MIPS: ftrace: Declare ftrace_get_parent_ra_addr() as static
Date: Fri,  7 Feb 2025 17:51:15 -0500
Message-Id: <20250207155644-80cd1fe9926f844f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <6832B20AFE3B7328+20250206102548.95302-1-wangyuli@uniontech.com>
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

The upstream commit SHA1 provided is correct: ddd068d81445b17ac0bed084dfeb9e58b4df3ddd


Status in newer kernel trees:
6.13.y | Not found

Note: The patch differs from the upstream commit:
---
1:  ddd068d81445b ! 1:  9778a7c87d16c MIPS: ftrace: Declare ftrace_get_parent_ra_addr() as static
    @@ Metadata
      ## Commit message ##
         MIPS: ftrace: Declare ftrace_get_parent_ra_addr() as static
     
    +    commit ddd068d81445b17ac0bed084dfeb9e58b4df3ddd upstream.
    +
         Declare ftrace_get_parent_ra_addr() as static to suppress clang
         compiler warning that 'no previous prototype'. This function is
         not intended to be called from other parts.
    @@ Commit message
         Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
         Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
         Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
    +    Signed-off-by: WangYuli <wangyuli@uniontech.com>
     
      ## arch/mips/kernel/ftrace.c ##
     @@ arch/mips/kernel/ftrace.c: int ftrace_disable_ftrace_graph_caller(void)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.13.y       |  Success    |  Failed    |
| stable/linux-5.4.y        |  Success    |  Success   |

Build Errors:
Build error for stable/linux-6.13.y:
    during RTL pass: dfinit
    drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c: In function 'dml_core_mode_support':
    drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c:9217:1: internal compiler error: Segmentation fault
     9217 | }
          | ^
    x86_64-linux-gcc: internal compiler error: Segmentation fault signal terminated program cc1
    Please submit a full bug report, with preprocessed source (by using -freport-bug).
    See <https://gcc.gnu.org/bugs/> for instructions.
    make[6]: *** [scripts/Makefile.build:194: drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.o] Error 4
    make[6]: Target 'drivers/gpu/drm/amd/amdgpu/' not remade because of errors.
    make[5]: *** [scripts/Makefile.build:440: drivers/gpu/drm/amd/amdgpu] Error 2
    make[5]: Target 'drivers/gpu/drm/' not remade because of errors.
    make[4]: *** [scripts/Makefile.build:440: drivers/gpu/drm] Error 2
    make[4]: Target 'drivers/gpu/' not remade because of errors.
    make[3]: *** [scripts/Makefile.build:440: drivers/gpu] Error 2
    make[3]: Target 'drivers/' not remade because of errors.
    make[2]: *** [scripts/Makefile.build:440: drivers] Error 2
    make[2]: Target './' not remade because of errors.
    make[1]: *** [/home/sasha/build/linus-next/Makefile:1989: .] Error 2
    make[1]: Target '__all' not remade because of errors.
    make: *** [Makefile:251: __sub-make] Error 2
    make: Target '__all' not remade because of errors.

