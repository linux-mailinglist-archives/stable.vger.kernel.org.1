Return-Path: <stable+bounces-144625-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B5BABA2BC
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 20:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D7F5177DE4
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 18:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE87A27A91B;
	Fri, 16 May 2025 18:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJSvDRhd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F08221C9FF
	for <stable@vger.kernel.org>; Fri, 16 May 2025 18:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747420009; cv=none; b=jeHMwmjHFIWoaaoIzJwKrHXSG4LmwSOJ2kdoC6JFxaGJmM3yM1RO7BQ60ngKZD/x3Ps65EQr0CWyOvixBoQz33XARGKnCXKMIjrWS/oitctdqv9VouAC1CBvoGOEf7RIAaOGrD8zETAXmSx8LCKfmEogJU6quP9+oDf14DBSyRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747420009; c=relaxed/simple;
	bh=snjPF0JWAHLyz3Pqx5HJ1M48IOwDk22Z0q4/8bzwlnc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MKu4QvU5vScT3uh9w0uzYl/Zazrp/cJRMprLd8ci9CujDvHpRJgSvrbf/M6xG+EjlqWTsb0LeGXJR1yX3wUw89RZnHJ8JpkifcSA/QNTTR5GfDSf/k9K0NJTcg4OuXyTgapWgOGmHaY+cPVAa258/t5zu5+0zjyUxhCg01r3ZzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJSvDRhd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0E0C4CEE4;
	Fri, 16 May 2025 18:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747420009;
	bh=snjPF0JWAHLyz3Pqx5HJ1M48IOwDk22Z0q4/8bzwlnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uJSvDRhd6qoedmeJF5QJYOh0N9OZrFgkcIn5nY2C7LybPnD0oRJbERTKHmjqXaEiq
	 yE5dPU1K6++gGcb7aPInureL6eZPLEiJ0i+srzm2LO0dwd1UYRToMsJDYm2ErZjyFJ
	 A1WCuHAj8x1jlvGw4k4ZOwtly7ILGzShHLu6+fsJVT2x6nRVOQrS5zUyyOupS3gj7w
	 dHPsOvu4O96eGKtSayaTmV2xBDjbX+7jkAExnk0NXoNdwh29t9BE3V9dWSPvIV9QJ6
	 ztbrJ8qMsMg94IGKBz8xXxtSWj88tGxyc6MetVpBGnN9xlW9rA6Y9+xRuhg/pzO9K0
	 Id2oXQetQXb6A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] fs: relax assertions on failure to encode file handles
Date: Fri, 16 May 2025 14:26:47 -0400
Message-Id: <20250516114804-e27ee000fb678225@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250516010553.1344365-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 974e3fe0ac61de85015bbe5a4990cf4127b304b2

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Amir Goldstein<amir73il@gmail.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (different SHA1: adcde2872f8f)
6.6.y | Present (different SHA1: f47c834a9131)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  974e3fe0ac61d ! 1:  edec8bb9ab27c fs: relax assertions on failure to encode file handles
    @@ Metadata
      ## Commit message ##
         fs: relax assertions on failure to encode file handles
     
    +    commit 974e3fe0ac61de85015bbe5a4990cf4127b304b2 upstream.
    +
         Encoding file handles is usually performed by a filesystem >encode_fh()
         method that may fail for various reasons.
     
    @@ Commit message
         Signed-off-by: Amir Goldstein <amir73il@gmail.com>
         Link: https://lore.kernel.org/r/20241219115301.465396-1-amir73il@gmail.com
         Signed-off-by: Christian Brauner <brauner@kernel.org>
    +    [Minor conflict resolved due to code context change.]
    +    Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## fs/notify/fdinfo.c ##
     @@ fs/notify/fdinfo.c: static void show_mark_fhandle(struct seq_file *m, struct inode *inode)
    - 	size = f->handle_bytes >> 2;
    + 	size = f.handle.handle_bytes >> 2;
      
    - 	ret = exportfs_encode_fid(inode, (struct fid *)f->f_handle, &size);
    + 	ret = exportfs_encode_inode_fh(inode, (struct fid *)f.handle.f_handle, &size, NULL);
     -	if ((ret == FILEID_INVALID) || (ret < 0)) {
     -		WARN_ONCE(1, "Can't encode file handler for inotify: %d\n", ret);
     +	if ((ret == FILEID_INVALID) || (ret < 0))
      		return;
     -	}
      
    - 	f->handle_type = ret;
    - 	f->handle_bytes = size * sizeof(u32);
    + 	f.handle.handle_type = ret;
    + 	f.handle.handle_bytes = size * sizeof(u32);
     
      ## fs/overlayfs/copy_up.c ##
     @@ fs/overlayfs/copy_up.c: struct ovl_fh *ovl_encode_real_fh(struct ovl_fs *ofs, struct dentry *real,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

