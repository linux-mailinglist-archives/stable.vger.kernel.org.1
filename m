Return-Path: <stable+bounces-126017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D13EBA6F420
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 12:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 398971891933
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 11:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88811255E3D;
	Tue, 25 Mar 2025 11:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRSlYbA0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5DEBA36
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 11:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902415; cv=none; b=Qnr5Z3IzQRfholfyBUkwOKTxq145OmZyb3jjMXp7Z/vyGoLIYj23Ci6mxC8Fg+cBEj+QGMk1VwpSZ2GC00QPkYQLHkAN2IBGhd8ob5jVd8fsIdXO0286W51VFfalQhCPZKG1zaUKIVTLrn+CnUARxCdj2lvVToib8URjL07tKRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902415; c=relaxed/simple;
	bh=wv1XtDBLtURfva0Fx/0XK5HaU5FeFySJPVmMWv9w+pw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=peagJQF6fIfI1FO0rJ9kmycVpS0NxslY5VdbryCpHUW/274SpjZkVLyG3w9+lrQZWKFtfnYomOo4ZolgpuWUiJGkErjAAqNV3d3xezs2FzG9nb/BUdTvhKYb92YwvqgWPIMo8XjFZaSE0uHZKAk6ySk3zi930BU72FmOvMYhhCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRSlYbA0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56CEBC4CEE4;
	Tue, 25 Mar 2025 11:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742902414;
	bh=wv1XtDBLtURfva0Fx/0XK5HaU5FeFySJPVmMWv9w+pw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YRSlYbA01Hkm+p3y98AvXldbb3Qelk06kARWMWK+6dScp73K732zzrp6x4wJUuOHs
	 xO2xYttafhk4LPnD5C2QrsX7F0dAVyCyztz0nlsn2ezjor12513bT0/dhh1iZIgot7
	 +yPqma800lolXfYgeWc16l5Wbp6oTDbU6TPPTmBAeJALGZr94VoDnVr1BYGB6eXf4p
	 xfbK7VmhNDI7o5sr3fBcavOP71oXkwPKfzxlUY6LgnwB9tU5EnsQ5wi7irbtDIev/2
	 tMTJ3ObDRQsXGzN35e0Cam0fyf3uCbTXDstmITznK5cN3ajaQkV621Z5HzoUSzFOEc
	 gpyEzQ8HiqGsQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kang Wenlin <wenlin.kang@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 4/7] binfmt_elf: Use elf_load() for interpreter
Date: Tue, 25 Mar 2025 07:33:33 -0400
Message-Id: <20250324222233-f7b100f939b2b4ca@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250324071942.2553928-5-wenlin.kang@windriver.com>
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

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: 8b04d32678e3c46b8a738178e0e55918eaa3be17

WARNING: Author mismatch between patch and upstream commit:
Backport author: Kang Wenlin<wenlin.kang@windriver.com>
Commit author: Kees Cook<keescook@chromium.org>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  8b04d32678e3c ! 1:  3b015308f7b5b binfmt_elf: Use elf_load() for interpreter
    @@ Metadata
      ## Commit message ##
         binfmt_elf: Use elf_load() for interpreter
     
    +    commit 8b04d32678e3c46b8a738178e0e55918eaa3be17 upstream
    +
         Handle arbitrary memsz>filesz in interpreter ELF segments, instead of
         only supporting it in the last segment (which is expected to be the
         BSS).
    @@ Commit message
         Signed-off-by: Sebastian Ott <sebott@redhat.com>
         Link: https://lore.kernel.org/r/20230929032435.2391507-3-keescook@chromium.org
         Signed-off-by: Kees Cook <keescook@chromium.org>
    +    Signed-off-by: Wenlin Kang <wenlin.kang@windriver.com>
     
      ## fs/binfmt_elf.c ##
     @@ fs/binfmt_elf.c: static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

