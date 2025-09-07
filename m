Return-Path: <stable+bounces-178028-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A51B4797B
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 10:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A049D1B238F4
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 08:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6271B0414;
	Sun,  7 Sep 2025 08:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Il0Kfg0N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB164315A
	for <stable@vger.kernel.org>; Sun,  7 Sep 2025 08:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757232022; cv=none; b=lMLAgJkii6pBblzu/4NZXNgJwnOmeOiPIKjcn8udxgxIIc7a5wBwS5OaG/BmzMG0Ry1Np9FXGYNR3EPFrTbt08ke3ShBTysPqnjXDDzLh4/WitB+D5St2RNMkYvO8qld6r0gLNkhmKW7VK6QKGnvbyOj9PZ4pcLJPEhrmJdSJ+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757232022; c=relaxed/simple;
	bh=o+mFiObxpRz4XV6yeLK2m0dFof2BB458XWwvnMPxh+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ip9ll8g6J8bf+bq14RCyQTSLuQ5u7KrBrjuh1DzeoqaJiIM2iZLlHdsBGj56nGWiY5BlFEZqImAYJTPxElA1v1syTlG+OSl9pFv33/y37RwprgjhveFaVcf8MCMt6BpjqPJD0EY2cFgMPtOCGOip93/pBwwM3jeONMVQC5Rijs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Il0Kfg0N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F3DC4CEF0;
	Sun,  7 Sep 2025 08:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757232022;
	bh=o+mFiObxpRz4XV6yeLK2m0dFof2BB458XWwvnMPxh+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Il0Kfg0NGdLGJEBfYgQM0nb0+bZw6q8MGZFkekq+fLTCt7SoVPg5EK7D/T2S0EqHd
	 DnC/B6BPcvkZm2Ceuc6I/vJG9MTp7g11jau/cEIS8zwNlgQBIQXXPhvUyq5Kw4ZrSA
	 fIyAG1vevqi1DDz36QdKqUPFtu0BgOgEUpCSdFlg=
Date: Sun, 7 Sep 2025 10:00:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Norbert Manthey <nmanthey@amazon.de>
Cc: stable@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com,
	Dmitry Safonov <dima@arista.com>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 6.1.y v2] fs: relax assertions on failure to encode file
 handles
Message-ID: <2025090737-encroach-natural-a187@gregkh>
References: <2025011112-racing-handbrake-a317@gregkh>
 <20250904092138.10605-1-nmanthey@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904092138.10605-1-nmanthey@amazon.de>

On Thu, Sep 04, 2025 at 09:21:38AM +0000, Norbert Manthey wrote:
> From: Amir Goldstein <amir73il@gmail.com>
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
> [ git-llm-picked from commit 974e3fe0ac61de85015bbe5a4990cf4127b304b2 ]

Please don't make up new strings for a simple 'cherry-pick' line, as our
tools don't know how to find this commit id :(

thanks,

greg k-h

