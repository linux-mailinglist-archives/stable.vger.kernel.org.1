Return-Path: <stable+bounces-176904-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A87AFB3EF01
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 21:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2640D4E0EC9
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 19:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820901AF0BB;
	Mon,  1 Sep 2025 19:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j3qKAi2F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296D742050
	for <stable@vger.kernel.org>; Mon,  1 Sep 2025 19:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756756448; cv=none; b=HyAWa/kuz2av9DXuCm9tgDHipPqNLW0HSzRVzH5aoLJ1q4Qlkj7PSlvMbE00vqaN5wGNOD8J8xeAHegNO/7sHPBcm70sis89P4OnIZvva50+5dhRRCbXn0UI3g6LGp1FpLyjRPYKj8Ne0Hk354D8roGuMZL1KISc/Y39z0iOMN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756756448; c=relaxed/simple;
	bh=Zw0P5JM2sUlBtG+4cPArBTAiB2BsRFKZQLEQ+IzW5Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJvE6ne2xe35PEFR2MeFOiTWK1gHpUwBRY3Y9DGAQdjSCRWt4ll8/UFJ56/UPne5aJuT1LkTeZ7LXceYretQkXWjh4b0KvHpfJKEvnDH8KUYMPzddq/eKSaE9vqjD44PIiSUiQOlV3ay4wIc62gXKFUjTZLsHLaTCZOlPK2VH1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j3qKAi2F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52EB6C4CEF0;
	Mon,  1 Sep 2025 19:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756756447;
	bh=Zw0P5JM2sUlBtG+4cPArBTAiB2BsRFKZQLEQ+IzW5Q8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j3qKAi2FHYef1C85XkNePVyG06Ya8FBhNcBdReRh7BgEfZMtYuJilW6Agx9TL547V
	 eohaZdPpFnkAP1QT6xnNki1J7Fg1mUZvBAZPnvlMqAfll7ADpIe+8F1Df9MenBqMjw
	 UI8ew87GmRXiipgIlUWybikfq5qhPwRY0bTFf2CE=
Date: Mon, 1 Sep 2025 21:54:03 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Norbert Manthey <nmanthey@amazon.de>
Cc: stable@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com,
	Dmitry Safonov <dima@arista.com>,
	Christian Brauner <brauner@kernel.org>,
	=?utf-8?B?w5ZtZXIgRXJkaW7DpyBZYcSfbXVybHU=?= <oeygmrl@amazon.de>
Subject: Re: [PATCH 6.1.y 1/1] fs: relax assertions on failure to encode file
 handles
Message-ID: <2025090114-bodacious-daffodil-2f2e@gregkh>
References: <2025011112-racing-handbrake-a317@gregkh>
 <20250901153559.14799-1-nmanthey@amazon.de>
 <20250901153559.14799-2-nmanthey@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250901153559.14799-2-nmanthey@amazon.de>

On Mon, Sep 01, 2025 at 03:35:59PM +0000, Norbert Manthey wrote:
> From: Amir Goldstein <amir73il@gmail.com>
> 
> commit 974e3fe0ac61de85015bbe5a4990cf4127b304b2 upstream.
> 
> Encoding file handles is usually performed by a filesystem >encode_fh()
> method that may fail for various reasons.
> 
> The legacy users of exportfs_encode_fh(), namely, nfsd and
> name_to_handle_at(2) syscall are ready to cope with the possibility
> of failure to encode a file handle.
> 
> There are a few other users of exportfs_encode_{fh,fid}() that
> currently have a WARN_ON() assertion when ->encode_fh() fails.
> Relax those assertions because they are wrong.
> 
> The second linked bug report states commit 16aac5ad1fa9 ("ovl: support
> encoding non-decodable file handles") in v6.6 as the regressing commit,
> but this is not accurate.
> 
> The aforementioned commit only increases the chances of the assertion
> and allows triggering the assertion with the reproducer using overlayfs,
> inotify and drop_caches.
> 
> Triggering this assertion was always possible with other filesystems and
> other reasons of ->encode_fh() failures and more particularly, it was
> also possible with the exact same reproducer using overlayfs that is
> mounted with options index=on,nfs_export=on also on kernels < v6.6.
> Therefore, I am not listing the aforementioned commit as a Fixes commit.
> 
> Backport hint: this patch will have a trivial conflict applying to
> v6.6.y, and other trivial conflicts applying to stable kernels < v6.6.
> 
> Reported-by: syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com
> Tested-by: syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/linux-unionfs/671fd40c.050a0220.4735a.024f.GAE@google.com/
> Reported-by: Dmitry Safonov <dima@arista.com>
> Closes: https://lore.kernel.org/linux-fsdevel/CAGrbwDTLt6drB9eaUagnQVgdPBmhLfqqxAf3F+Juqy_o6oP8uw@mail.gmail.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> Link: https://lore.kernel.org/r/20241219115301.465396-1-amir73il@gmail.com
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

I never signed off on the original commit, so why was this added?

> 
> (fuzzy picked from commit f47c834a9131ae64bee3c462f4e610c67b0a000f)
> Applied with LLM-adjusted hunks for 1 functions from us.amazon.nova
> - Changed the function call from `exportfs_encode_fid` to `exportfs_encode_inode_fh` to match the destination code.
> - Removed the warning message as per the patch.

Please put this in the proper place, and in the proper format, if you
want to add "notes" to the backport.

But really, it took a LLM to determine an abi change?  That feels like
total overkill as you then had to actually manually check it as well.
But hey, it's your cpu cycles to burn, not mine...

> Signed-off-by: Norbert Manthey <nmanthey@amazon.de>
> Tested-by: Ömer Erdinç Yağmurlu <oeygmrl@amazon.de>

Your signed-off-by has to come last, right?

thanks,

greg k-h

