Return-Path: <stable+bounces-158570-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D7CAE85B4
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 16:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62DAF7B5E6D
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 14:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1A92641EE;
	Wed, 25 Jun 2025 14:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEuYBjnu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A075263F27
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 14:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860436; cv=none; b=bysTEVM2Q/qyNCtC0+/bX01ZGHwIE9e3zTu/1ZArEe3MdI0D5/536gMPqWreFVzXvUR/5K5EKr6UBqg4GBUittjzbSXY8zgOU5E+EwE7j1HtktNtHCbisYv9K9J/mgnznhU4lREDi5LG0HYBxVx5WjfsFKObgrnv+NB/rxtZ1dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860436; c=relaxed/simple;
	bh=swYkLyFaLvI2MHoH9bBJfJQ8mb3hAi5bTO5NZqF/QZg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A2rkXcOiZwa7DvY60Ao2vBVD838SGArFcJw5Vs54KVBajn+8WyrlvQ64vI+TeZM6FKh9xTklI0srnczTsoJ6mLk3j3Cf9/Kk/wKjiMQpkPlqFs7A1RPww1Ue8hWhy4c7OOJtoUU774E0HRqIsMCil+KEEMfzRh1O+i7kPbzj4po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pEuYBjnu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B1CC4CEEB;
	Wed, 25 Jun 2025 14:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750860436;
	bh=swYkLyFaLvI2MHoH9bBJfJQ8mb3hAi5bTO5NZqF/QZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pEuYBjnuqraoaGR3E8GGnxzLHFzBjETogYiVDsAmjp3LVh73MpSNaHQgEZxaj040W
	 TMbmoc+EnoVMqUY1M1BfAcoNy5SU84tbq2l4lF87ZvB62mKqN6B3OuR9j7p/3Lb7UF
	 5vP75cRER7UFp5iQVbHjSevXuXbSe2sUbYVUWK59f9Acvf8PWYGU8TC03WyOnrZQcW
	 H63Pf1bTMDisu/66oSngdaRnSNaoiA4TbXjuPcGK7+C2RzIBPo92QCXDeDE50P1XPG
	 iEFuZdPHQyNFXiJvhVFkkCbLG8/h9DlcTq465ESrgln9O2C2chc92H+gEKmzkHwl+6
	 syRWeBf5z4VmA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	chao@kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 1/2] f2fs: sysfs: add encoding_flags entry
Date: Wed, 25 Jun 2025 10:07:15 -0400
Message-Id: <20250624185610-72bf30d9c2d40956@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250416054805.1416834-1-chao@kernel.org>
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

Found matching upstream commit: 3fea0641b06ff4e53d95d07a96764d8951d4ced6

Note: The patch differs from the upstream commit:
---
1:  3fea0641b06ff ! 1:  14acd457cfe03 f2fs: sysfs: add encoding_flags entry
    @@ Commit message
         it is a read-only entry to show the value of sb.s_encoding_flags, the
         value is hexadecimal.
     
    -    ============================     ==========
    +    ===========================      ==========
         Flag_Name                        Flag_Value
    -    ============================     ==========
    +    ===========================      ==========
         SB_ENC_STRICT_MODE_FL            0x00000001
         SB_ENC_NO_COMPAT_FALLBACK_FL     0x00000002
    -    ============================     ==========
    +    ===========================      ==========
     
         case#1
         mkfs.f2fs -f -O casefold -C utf8:strict /dev/vda
    @@ Commit message
         2
     
         Signed-off-by: Chao Yu <chao@kernel.org>
    -    Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
     
      ## Documentation/ABI/testing/sysfs-fs-f2fs ##
     @@ Documentation/ABI/testing/sysfs-fs-f2fs: Description:	For several zoned storage devices, vendors will provide extra space
    @@ Documentation/ABI/testing/sysfs-fs-f2fs: Description:	For several zoned storage
     +Description:	This is a read-only entry to show the value of sb.s_encoding_flags, the
     +		value is hexadecimal.
     +
    -+		============================     ==========
    ++		===========================      ==========
     +		Flag_Name                        Flag_Value
    -+		============================     ==========
    ++		===========================      ==========
     +		SB_ENC_STRICT_MODE_FL            0x00000001
     +		SB_ENC_NO_COMPAT_FALLBACK_FL     0x00000002
    -+		============================     ==========
    ++		===========================      ==========
     
      ## fs/f2fs/sysfs.c ##
     @@ fs/f2fs/sysfs.c: static ssize_t encoding_show(struct f2fs_attr *a,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

