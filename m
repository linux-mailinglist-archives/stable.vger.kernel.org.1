Return-Path: <stable+bounces-53672-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADA690E125
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 03:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE9B71F22A84
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 01:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6AA6139;
	Wed, 19 Jun 2024 01:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6XIrLAy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F753C0B;
	Wed, 19 Jun 2024 01:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718759364; cv=none; b=CN89QmB4gIE2lcvwS/cLjt4seMmMB9koQ0Zu+56yuAno2kzOCVVAW7BZ8KY+99zj+9w3HV9WInZicolmeTKeWRC05+tYdR8xVVG6X1Bqdauij2ekoN+dz0M4xXTw+h0l9vj3YcbyYitsSsNoFH1MHzshDB6q/892nWaKBM58NUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718759364; c=relaxed/simple;
	bh=UErUBcvcliu7jOK7EUKySL1PIUbLZdkkiwHCRkyKEtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HsMX4gftc/wD8R3YWP7JqXTXBIBTzQg882w3tWA9St/oGfXPnTVvhO7tBUqclWZbEvP5SfXJ3dm2vs5AO4Tvqev4CPvDkOvbW/giuAMa+4qoIo5YgHm8mocn5VhV1SCKoSbBRya3SZ3dK/y6ukFKY5BrUBUiZsJgbju3aJoSRAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6XIrLAy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366EFC4AF1D;
	Wed, 19 Jun 2024 01:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718759364;
	bh=UErUBcvcliu7jOK7EUKySL1PIUbLZdkkiwHCRkyKEtA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a6XIrLAytiipmZgBjd0hDf9HXN+gj6NYp3buoJ2TKDyqTIdX6sTOuIgB5hYdvSEek
	 l85k2RpB2x+MRks9lMnMQfbkqe02gOHmVc6z82FOJTjfEJq0OkutnV9loLP/AyEp/9
	 IZNXq505l0gHv11JFDrONKGyX6nmQy2v1lAPo7Kfnf8cou9+cn8h/t5sfoXSTGih+L
	 T54jgND4al4HLMiuXnaJP+M5o6/SNInsakUSPLxcjRvb+HaT//TrZXHsz9SObDEKb4
	 SmAgA8ISR8cFvBIkKhZETk5svxtLYEpMxpQx47LkxDo8fEM7KWjloN+jz+aqaH+7LY
	 Os1YdKBlS/dCA==
Message-ID: <2cb67503-d974-4db2-942d-b68b69de9447@kernel.org>
Date: Wed, 19 Jun 2024 09:09:18 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH] f2fs: assign CURSEG_ALL_DATA_ATGC if blkaddr
 is valid
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Cc: stable@vger.kernel.org
References: <20240618022334.1576056-1-jaegeuk@kernel.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240618022334.1576056-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/6/18 10:23, Jaegeuk Kim wrote:
> mkdir /mnt/test/comp
> f2fs_io setflags compression /mnt/test/comp
> dd if=/dev/zero of=/mnt/test/comp/testfile bs=16k count=1
> truncate --size 13 /mnt/test/comp/testfile
> 
> In the above scenario, we can get a BUG_ON.
>   kernel BUG at fs/f2fs/segment.c:3589!
>   Call Trace:
>    do_write_page+0x78/0x390 [f2fs]
>    f2fs_outplace_write_data+0x62/0xb0 [f2fs]
>    f2fs_do_write_data_page+0x275/0x740 [f2fs]
>    f2fs_write_single_data_page+0x1dc/0x8f0 [f2fs]
>    f2fs_write_multi_pages+0x1e5/0xae0 [f2fs]
>    f2fs_write_cache_pages+0xab1/0xc60 [f2fs]
>    f2fs_write_data_pages+0x2d8/0x330 [f2fs]
>    do_writepages+0xcf/0x270
>    __writeback_single_inode+0x44/0x350
>    writeback_sb_inodes+0x242/0x530
>    __writeback_inodes_wb+0x54/0xf0
>    wb_writeback+0x192/0x310
>    wb_workfn+0x30d/0x400
> 
> The reason is we gave CURSEG_ALL_DATA_ATGC to COMPR_ADDR where the
> page was set the gcing flag by set_cluster_dirty().
> 
> Cc: stable@vger.kernel.org
> Fixes: 4961acdd65c9 ("f2fs: fix to tag gcing flag on page during block migration")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

