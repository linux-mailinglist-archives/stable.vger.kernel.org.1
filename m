Return-Path: <stable+bounces-303-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF5A7F787A
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 17:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1758D281158
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 16:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDABA33099;
	Fri, 24 Nov 2023 16:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F+uSCs8O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB3D2C87A
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 16:02:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E81C433C8;
	Fri, 24 Nov 2023 16:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700841767;
	bh=Wq5wMloo8HTvRFxHzcoebQ/9siHCxcXzEPjqO1A/U/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F+uSCs8OmFCBKLIBrk+IUSn8IFkY7qy6soQRQsAhFP4CJZZ22f742ktyUfQzHdb99
	 dBTdMgWk21bPN8Gh6vFWvZV3VHxW+M4YsQNeBTZmAAHpcXJ9m72JPgQNtvGb0hp87u
	 VHKjqRLZU9SXG5ecTtWVnBTkkNR3YC7urMGjfDuY=
Date: Fri, 24 Nov 2023 16:02:44 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: zhangshida <starzhangzsd@gmail.com>
Cc: stable@vger.kernel.org, zhangshida@kylinos.cn,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Qian Cai <cai@redhat.com>, Brian Foster <bfoster@redhat.com>,
	Gao Xiang <hsiangkao@redhat.com>,
	"Darrick J . Wong" <darrick.wong@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4.19.y] iomap: Set all uptodate bits for an Uptodate page
Message-ID: <2023112434-sadness-thaw-cae7@gregkh>
References: <20231116064010.17023-1-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116064010.17023-1-zhangshida@kylinos.cn>

On Thu, Nov 16, 2023 at 02:40:10PM +0800, zhangshida wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> commit 4595a298d5563cf76c1d852970f162051fd1a7a6 upstream.
> 
> For filesystems with block size < page size, we need to set all the
> per-block uptodate bits if the page was already uptodate at the time
> we create the per-block metadata.  This can happen if the page is
> invalidated (eg by a write to drop_caches) but ultimately not removed
> from the page cache.
> 
> This is a data corruption issue as page writeback skips blocks which
> are marked !uptodate.
> 
> Fixes: 9dc55f1389f9 ("iomap: add support for sub-pagesize buffered I/O without buffer heads")
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reported-by: Qian Cai <cai@redhat.com>
> Cc: Brian Foster <bfoster@redhat.com>
> Reviewed-by: Gao Xiang <hsiangkao@redhat.com>
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> ---
>  fs/iomap.c | 3 +++
>  1 file changed, 3 insertions(+)

Now queued up, thanks.

greg k-h

