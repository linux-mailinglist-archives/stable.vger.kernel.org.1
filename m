Return-Path: <stable+bounces-191377-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DDBC129A0
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 02:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C74C567F43
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 01:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4250025F7A7;
	Tue, 28 Oct 2025 01:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTaDNk+a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F140B1D61A3;
	Tue, 28 Oct 2025 01:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761616603; cv=none; b=UyKP2BfGh36KsYSNT8goWB/GO5GRSj7EJ7i7uy9eBVytDiLCeY1rfSymeyTbrddJugl91yJJyveDT+o+Tude5igFQRlkKwR6FKpSWbuFaIvRqZJgOUhsTkGvGmDPD3DZAYmyiX4czUMZ5jqL3sY5rvyNKkFqTYdnjbwq8i6pQkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761616603; c=relaxed/simple;
	bh=g2yyvoN+1HNOmdyvaXIarerpwTT69j+s8Bc+DILxvjI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YGmJZI+qKuKg71YkiK9iCyfIoikBDonrbj6T5fF/LDins71sQpUqkLpVScpLyMEUS0wK7sUyuE6Byi5eVqyD5e2R0VwRzX1OKiRRSpIq0T9+tWePbBhvHDDkillEBWKCaQ0Z0IQjf8Q1JLz/13QWlDbPE3OTvKFqeVoS87Kn/sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTaDNk+a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56839C4CEF1;
	Tue, 28 Oct 2025 01:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761616602;
	bh=g2yyvoN+1HNOmdyvaXIarerpwTT69j+s8Bc+DILxvjI=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=iTaDNk+aZqktgIHMAvwTEZ+sCp+1KPnLqdtWZnXIf//ShAfEgm8my91TerFAY4ROi
	 3lpeXg3a/tvo+Z11E8FZBYb+dyIKUVcPXHJmw2gHQIoxj6dxJGQQ9bWmeLDedQcHbd
	 0eysn84yPKkKTIH03mr99MHmCZwd/dqM74Y6v19UF7g4zOpA8oVSNqhtKwDd+vaqpu
	 iAJ3LNAA6CKcfo60D0TKEmc2ffhoaVduudmS5bzJUTGd6A9rh9Myy2w+ZtTWe2qHt9
	 HNwlsKC31qImNA+2+KpT+XPZF2xA2r7nso/VJ9HT/IRfe0NHHScelDgw78T9so6Aur
	 ggqYEVV8xDt/g==
Message-ID: <8ad9e792-7b0a-4c93-8ad9-3f13e6f8614f@kernel.org>
Date: Tue, 28 Oct 2025 09:56:39 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org,
 syzbot+632cf32276a9a564188d@syzkaller.appspotmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: invalidate dentry cache on failed whiteout
 creation
To: Deepanshu Kartikey <kartikey406@gmail.com>, jaegeuk@kernel.org
References: <20251027130635.13739-1-kartikey406@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251027130635.13739-1-kartikey406@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/27/25 21:06, Deepanshu Kartikey wrote:
> F2FS can mount filesystems with corrupted directory depth values that
> get runtime-clamped to MAX_DIR_HASH_DEPTH. When RENAME_WHITEOUT
> operations are performed on such directories, f2fs_rename performs
> directory modifications (updating target entry and deleting source
> entry) before attempting to add the whiteout entry via f2fs_add_link.
> 
> If f2fs_add_link fails due to the corrupted directory structure, the
> function returns an error to VFS, but the partial directory
> modifications have already been committed to disk. VFS assumes the
> entire rename operation failed and does not update the dentry cache,
> leaving stale mappings.
> 
> In the error path, VFS does not call d_move() to update the dentry
> cache. This results in new_dentry still pointing to the old inode
> (new_inode) which has already had its i_nlink decremented to zero.
> The stale cache causes subsequent operations to incorrectly reference
> the freed inode.
> 
> This causes subsequent operations to use cached dentry information that
> no longer matches the on-disk state. When a second rename targets the
> same entry, VFS attempts to decrement i_nlink on the stale inode, which
> may already have i_nlink=0, triggering a WARNING in drop_nlink().
> 
> Example sequence:
> 1. First rename (RENAME_WHITEOUT): file2 → file1
>    - f2fs updates file1 entry on disk (points to inode 8)
>    - f2fs deletes file2 entry on disk
>    - f2fs_add_link(whiteout) fails (corrupted directory)
>    - Returns error to VFS
>    - VFS does not call d_move() due to error
>    - VFS cache still has: file1 → inode 7 (stale!)
>    - inode 7 has i_nlink=0 (already decremented)
> 
> 2. Second rename: file3 → file1
>    - VFS uses stale cache: file1 → inode 7
>    - Tries to drop_nlink on inode 7 (i_nlink already 0)
>    - WARNING in drop_nlink()
> 
> Fix this by explicitly invalidating old_dentry and new_dentry when
> f2fs_add_link fails during whiteout creation. This forces VFS to
> refresh from disk on subsequent operations, ensuring cache consistency
> even when the rename partially succeeds.
> 
> Reproducer:
> 1. Mount F2FS image with corrupted i_current_depth
> 2. renameat2(file2, file1, RENAME_WHITEOUT)
> 3. renameat2(file3, file1, 0)
> 4. System triggers WARNING in drop_nlink()
> 
> Fixes: 7e01e7ad746b ("f2fs: support RENAME_WHITEOUT")
> Reported-by: syzbot+632cf32276a9a564188d@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=632cf32276a9a564188d
> Suggested-by: Chao Yu <chao@kernel.org>
> Link: https://lore.kernel.org/all/20251022233349.102728-1-kartikey406@gmail.com/ [v1]
> Cc: stable@vger.kernel.org
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

