Return-Path: <stable+bounces-58189-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 587D7929A90
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 03:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79A881C208C2
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 01:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87AB639;
	Mon,  8 Jul 2024 01:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMuq40Qd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EB7184F
	for <stable@vger.kernel.org>; Mon,  8 Jul 2024 01:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720402574; cv=none; b=vDHbHzSzFCqBJFLoZbQYLOYY6zw5MBXEYQ6LpIwfRkoXqhS2odzEASsfJPQJwc2LtlMKg4yyUXjO8ieRdsgNEbX6+YeVxMa4eiOEqzsyxu2yXY7biSSjCk8ypHXJy/7z+pRUvWNTLy6Zb0AtWl6o9VJuQlm7j+uY52MaW1Oe8bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720402574; c=relaxed/simple;
	bh=jjPi20fkpscvvuNNyz28Huqs5WzzTrBLiMl2784STsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SB1NgU1stFaa89ZfhXI2WxVgOc6nYkWwzF0O6jchNSFjqJpvvqq5isgEyx675AzizhWG14B3QDX2ktfnKZwNkcch6+FIHZ4ZqoirKLSprNj2TZ2PwsZenCLx/e0SbV/tqLx+I9iB81PfqM8Esv8YP2wMzI2zJWp/jKIaDE/0vUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMuq40Qd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62690C3277B;
	Mon,  8 Jul 2024 01:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720402574;
	bh=jjPi20fkpscvvuNNyz28Huqs5WzzTrBLiMl2784STsA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EMuq40Qd+Cjaf5+t9w3DZODkks8kWlHbhNWUn8WRkQLw19FUN92uPBWqD3LDXvlA0
	 eaEzDUxQSC25NgJDgLqLcNBdpsBPA0NivlCVG9gqCYhhpJPgRunub1Mzggx0jhfeZs
	 FWNrqgmEB6iT+BzxlKz/wyAqPRaGC0MpQ8Pqnoj8+sM7E2g2WaXd3vMH/bfcmzP90t
	 V41rdSezPp4ZDFLuIC7KPrlehro2h5K1r6ZIdTCnkeZdk4TVkU5vqfwTdScbGoV/N0
	 UwSLADDxrVbzCOrZGxwshHtvjtaZZgWSazs30FOyeYMvYNvKbuepApukTipOqdpCSi
	 ve7By4XKgSDgg==
Message-ID: <149db396-b62b-4c24-88ee-a6dd2dd85459@kernel.org>
Date: Mon, 8 Jul 2024 09:36:10 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] f2fs: use meta inode for GC of atomic file
To: Sunmin Jeong <s_min.jeong@samsung.com>, jaegeuk@kernel.org
Cc: daehojeong@google.com, linux-f2fs-devel@lists.sourceforge.net,
 stable@vger.kernel.org, Sungjong Seo <sj1557.seo@samsung.com>,
 Yeongjin Gil <youngjin.gil@samsung.com>
References: <CGME20240705082453epcas1p3b42790db4a6df77c14b1f8a2bae39435@epcas1p3.samsung.com>
 <20240705082448.805306-1-s_min.jeong@samsung.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240705082448.805306-1-s_min.jeong@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/7/5 16:24, Sunmin Jeong wrote:
> The page cache of the atomic file keeps new data pages which will be
> stored in the COW file. It can also keep old data pages when GCing the
> atomic file. In this case, new data can be overwritten by old data if a
> GC thread sets the old data page as dirty after new data page was
> evicted.
> 
> Also, since all writes to the atomic file are redirected to COW inodes,
> GC for the atomic file is not working well as below.
> 
> f2fs_gc(gc_type=FG_GC)
>    - select A as a victim segment
>    do_garbage_collect
>      - iget atomic file's inode for block B
>      move_data_page
>        f2fs_do_write_data_page
>          - use dn of cow inode
>          - set fio->old_blkaddr from cow inode
>      - seg_freed is 0 since block B is still valid
>    - goto gc_more and A is selected as victim again
> 
> To solve the problem, let's separate GC writes and updates in the atomic
> file by using the meta inode for GC writes.
> 
> Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
> Cc: stable@vger.kernel.org #v5.19+
> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
> Reviewed-by: Yeongjin Gil <youngjin.gil@samsung.com>
> Signed-off-by: Sunmin Jeong <s_min.jeong@samsung.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

