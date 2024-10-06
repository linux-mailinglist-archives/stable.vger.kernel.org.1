Return-Path: <stable+bounces-81178-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C749991B8A
	for <lists+stable@lfdr.de>; Sun,  6 Oct 2024 02:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBD401F22473
	for <lists+stable@lfdr.de>; Sun,  6 Oct 2024 00:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5354D2582;
	Sun,  6 Oct 2024 00:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bS6bcxhG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F634A23
	for <stable@vger.kernel.org>; Sun,  6 Oct 2024 00:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728174131; cv=none; b=YN46GZYJAuImDK1YqC3cUzsv/ZV1T6HB3NAklexUjmqAFnjmYq5fldeypBX8plrP8IK7h6+ZfnI5PpeBLmfNbe+LSphBl2cfmVeaUr4CHCiimZ/WK3ReY/jRcRwJp1BvJrD6F+qlgK6ZTq7lCnPs5yZR6u1o9C3BHRP/aO4zA+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728174131; c=relaxed/simple;
	bh=YL47cSlUSCpOmWDSvLzf9+9vSvcaFLSSflHKZJY8n4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5ah5sFyYwS8XayPuLlye57MB2CcXZVmlqztBN6tU0E4b3qMgj7/dL9gP8aHm2hmKLtI31kZOQmaOK9CwNLxCrFYGSbL2LvBfqBIO8sL1lc1TTjGk4rwX85zfcLTNgbu8eR8wFuCDaEoAFRDAJAUjaHo18G3Dz5pwjIyTzmtgbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bS6bcxhG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D75C4CEC2;
	Sun,  6 Oct 2024 00:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728174130;
	bh=YL47cSlUSCpOmWDSvLzf9+9vSvcaFLSSflHKZJY8n4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bS6bcxhGLqF9dWTGO/L1sUoxkhHxyMZX8yXYIHlPMFRDPZz4MSsG16lcwtfPSw7II
	 zGEJJY9OCR+uhN61bKhlcKRaBNOXzJBZAwa3NLirZx9nm1Ug/xOM/7c1I0zeVc5hWv
	 Kl9q6LTwo66G+N9dNKRNX12sHLZFiHlhAJlaHUYin2dBs9jDWPW1oJAcd2OkoBDIyH
	 wA55QVojePi1+yEKb5golhN8F5kGlveZ+LnD6aUH/JFPGsIGV1teH5nvEKxLGC6WBN
	 Zx3mLKRbUxuNHyaW/c+SDOMpxG/cW5kgM+UsbNjJ6OHaBzN3dIXPBcthlE7fA+Letq
	 unj6MVdBtrAHA==
Date: Sat, 5 Oct 2024 20:22:09 -0400
From: Sasha Levin <sashal@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	Jann Horn <jannh@google.com>, Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 6.1] f2fs: Require FMODE_WRITE for atomic write ioctls
Message-ID: <ZwHYMVtlagIeibP5@sashalap>
References: <20241004193442.189774-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241004193442.189774-1-ebiggers@kernel.org>

On Fri, Oct 04, 2024 at 07:34:41PM +0000, Eric Biggers wrote:
>From: Jann Horn <jannh@google.com>
>
>commit 4f5a100f87f32cb65d4bb1ad282a08c92f6f591e upstream.
>
>The F2FS ioctls for starting and committing atomic writes check for
>inode_owner_or_capable(), but this does not give LSMs like SELinux or
>Landlock an opportunity to deny the write access - if the caller's FSUID
>matches the inode's UID, inode_owner_or_capable() immediately returns true.
>
>There are scenarios where LSMs want to deny a process the ability to write
>particular files, even files that the FSUID of the process owns; but this
>can currently partially be bypassed using atomic write ioctls in two ways:
>
> - F2FS_IOC_START_ATOMIC_REPLACE + F2FS_IOC_COMMIT_ATOMIC_WRITE can
>   truncate an inode to size 0
> - F2FS_IOC_START_ATOMIC_WRITE + F2FS_IOC_ABORT_ATOMIC_WRITE can revert
>   changes another process concurrently made to a file
>
>Fix it by requiring FMODE_WRITE for these operations, just like for
>F2FS_IOC_MOVE_RANGE. Since any legitimate caller should only be using these
>ioctls when intending to write into the file, that seems unlikely to break
>anything.
>
>Fixes: 88b88a667971 ("f2fs: support atomic writes")
>Cc: stable@vger.kernel.org
>Signed-off-by: Jann Horn <jannh@google.com>
>Reviewed-by: Chao Yu <chao@kernel.org>
>Reviewed-by: Eric Biggers <ebiggers@google.com>
>Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>Signed-off-by: Eric Biggers <ebiggers@google.com>

I've queued these backports, thanks!

-- 
Thanks,
Sasha

