Return-Path: <stable+bounces-201046-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE11CBE44E
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 15:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F7283030928
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 14:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35A6346E5A;
	Mon, 15 Dec 2025 14:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E0ioidWH"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3340346E56
	for <stable@vger.kernel.org>; Mon, 15 Dec 2025 14:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765808505; cv=none; b=cdyclQjwMxTb1MhuReSg3jVcSf49MwDlRqB9VR4lAwoEkP863YSgn1RUGKZEScDwuCn9RbIvH7hqmEuvu339lWPQnTlLn2beuNC3MQwuhiZYn0jboEPVd7mBH2EDcUrB40xOuahHwwT2v3FbhMjnKXxUdizI4Gdt5lNVFd54Fm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765808505; c=relaxed/simple;
	bh=bSZ+jogn9yHHF2Hf/tFUteTWBVrPzrenciac6AIJbrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2TKNiOKsB8UkM/vnDwAjv6SrVwQ8zR8RfI9aZW00HJlQLTP4pJitZsbiAMKrHtG7YSrn94x8rJaZu6MllPQgFN99m/uU8Ufjaq/k34aWgEeKYZ9G4B9PYFzLBZvQuyTU5x048yodiCEAX9SqngChA8ijuv+P7kKEAHRFH0fIus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E0ioidWH; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4779b49d724so7853375e9.0
        for <stable@vger.kernel.org>; Mon, 15 Dec 2025 06:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765808501; x=1766413301; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=atmDNHEXByx/FHD/Om49naRn/dYz/9e7ZxK7+pLOTlM=;
        b=E0ioidWHM4fmyrGePuw6CiudgyitYOP0ybzNgRN7Dl4NheI/PkcyRqpJoWXfp+v77H
         lcH8hz7GwYvqG3H5XFA9Hhlrtj6Ts6VqeHHlMMEjW2VVeBzbJh8ozeVvPezjkzGxwjUi
         tyvhu7whH2JjjJB0/oeDYjmCn+NlT9gierYjD/Mt4siHvT5typG9hD04Y35q9y02/UiG
         cyGwX2crVMIO1YDqAvP91GoB6oBieiCNy3SlxO4CI5JocxhWjL6/0qIr9u7T/h3/lX+H
         XR0/cK54SMF/lAZSM0cFnz8I+uXl50I1BKD+iIAdT/SECMACOWcPOl4czitpkukHnPqm
         5Tiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765808501; x=1766413301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=atmDNHEXByx/FHD/Om49naRn/dYz/9e7ZxK7+pLOTlM=;
        b=GAJ2355kNQM7t4oHe+FE1x/RuOvC76rAAcUrPbgJi9IX5mqQoewfCk+Vm5tnl5bXT2
         vpv+PnDLWdHjtAPCynthh/LvoV5S0YByOVejyYqif38KPyiiGkCKemNwINlrIMVEOrsM
         FZbFQnrTtgvx5vDGWjxm/pPXLHCaOFIr65ixHl3sOIGoGkZ2nUBHSwfH5jX0rpf0HVOS
         WyyEYW9F5OOxeGhYttBMc9+q7d29aqmjxNeNr8cya/lKs/3CHd6T6vLbjh9Jf3FypN2v
         OQLsgpQzvL1Td7rXqs0G/PxLheD33EQBh7hHkKtxj+XUNc53lkxrKk81Da6bTKsQo8oM
         alIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxEUySfg63zLxQcBqDZEuZp4poJ09spAPSOlp8sERSVXkVpdu2h6ZpnDBuMIv4zEUfLVvMk1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTo4pFlrMdYFivuFzo5cILWjjrf6eg3U3dvElNNc/iSh0b7QyT
	jHgmKxy+90xlBqjEh2rswBD6EaklzWckDvHq49TpSGolxTccsksja5ZfTs7kBhs/Q+ht6Lg2rPn
	xSH6g
X-Gm-Gg: AY/fxX6/icOPsT1SQAZg9ATWrqazEV/tQU7DDwOuh6T5SJXZdAdlObyHj4Cu3UuD38G
	eZT39a+ypHPAj1eeh2++Z7SWmo7NtYHbz9GAGcsMrNv9OgdnI7RRx6j3reqEyLRuA066pXFMN/S
	vRIymmSTjljzmzCkE8HaRPgHMU7BndSCThmca0A7U0cR4NJozRxF3V4xW6kzzsawt/8mtCE1E6G
	l0JIBcmQhHQK6sUc9iktzZXORkQF7UexE0tzwwcjYUts25JNjyz48VqkNKC/SJmHds6ky07tTk0
	KKc7NBvCU7lf/GeUXu/YsbswjoYnqkI52xhMNFBSaV4dGGQ5TiinT/s9uTjb8Nfv5OxJtmLdFvU
	Naj1nCjOxUA1gI2hWLDGuq9eHEbK0miWqjkTB3W6mefByvTOIXNWJUulIM/EAaydFOZKCqmKd1E
	K/sBoHN+V60Q==
X-Google-Smtp-Source: AGHT+IGxxdNneEkWwCyD+yQT8HKoJxaWVvr0zBdvdfhVTdhMRoUl3QCSxmfSYCIwwy2sEyBG5Ae59g==
X-Received: by 2002:a05:600c:34cb:b0:47a:8bfa:bd5 with SMTP id 5b1f17b1804b1-47a8f92285emr69796785e9.8.1765808500726;
        Mon, 15 Dec 2025 06:21:40 -0800 (PST)
Received: from localhost ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29f0f74f467sm112333995ad.90.2025.12.15.06.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 06:21:40 -0800 (PST)
Date: Mon, 15 Dec 2025 22:21:37 +0800
From: Heming Zhao <heming.zhao@suse.com>
To: Prithvi Tambewagh <activprithvi@gmail.com>
Cc: jlbec@evilplan.org, joseph.qi@linux.alibaba.com, mark@fasheh.com, 
	linux-kernel@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	khalid@kernel.org, syzbot+c818e5c4559444f88aa0@syzkaller.appspotmail.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH v3] ocfs2: Add validate function for slot map blocks
Message-ID: <pbky57xu3cdwtrxieo7y2dicl5vddy7k5ttf32nxypirceoenx@et4o3qg4ifck>
References: <20251215052513.18436-1-activprithvi@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215052513.18436-1-activprithvi@gmail.com>

On Mon, Dec 15, 2025 at 10:55:13AM +0530, Prithvi Tambewagh wrote:
> When the filesystem is being mounted, the kernel panics while the data
> regarding slot map allocation to the local node, is being written to the
> disk. This occurs because the value of slot map buffer head block
> number, which should have been greater than or equal to
> `OCFS2_SUPER_BLOCK_BLKNO` (evaluating to 2) is less than it, indicative
> of disk metadata corruption. This triggers
> BUG_ON(bh->b_blocknr < OCFS2_SUPER_BLOCK_BLKNO) in ocfs2_write_block(),
> causing the kernel to panic.
> 
> This is fixed by introducing  function ocfs2_validate_slot_map_block() to
> validate slot map blocks. It first checks if the buffer head passed to it
> is up to date and valid, else it panics the kernel at that point itself.
> Further, it contains an if condition block, which checks if `bh->b_blocknr`
> is lesser than `OCFS2_SUPER_BLOCK_BLKNO`; if yes, then ocfs2_error is
> called, which prints the error log, for debugging purposes, and the return
> value of ocfs2_error() is returned. If the return value is zero. then error
> code EIO is returned.
> 
> This function is used as validate function in calls to ocfs2_read_blocks()
> in ocfs2_refresh_slot_info() and ocfs2_map_slot_buffers().
> In addition, the function also contains

The last sentence seems incomplete.

> 
> Reported-by: syzbot+c818e5c4559444f88aa0@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=c818e5c4559444f88aa0
> Tested-by: syzbot+c818e5c4559444f88aa0@syzkaller.appspotmail.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Prithvi Tambewagh <activprithvi@gmail.com>
> ---
> v2->v3:
>  - Create new function ocfs2_validate_slot_map_block() to validate block 
>    number of slot map blocks, to be greater then or equal to 
>    OCFS2_SUPER_BLOCK_BLKNO
>  - Use ocfs2_validate_slot_map_block() in calls to ocfs2_read_blocks() in
>    ocfs2_refresh_slot_info() and ocfs2_map_slot_buffers()
>  - In addition to using previously formulated if block in 
>    ocfs2_validate_slot_map_block(), also check if the buffer head passed 
>    in this function is up to date; if not, then kernel panics at that point
>  - Change title of patch to 'ocfs2: Add validate function for slot map blocks'
> 
> v2 link: https://lore.kernel.org/ocfs2-devel/nwkfpkm2wlajswykywnpt4sc6gdkesakw2sw7etuw2u2w23hul@6oby33bscwdw/T/#t
> 
> v1->v2:
>  - Remove usage of le16_to_cpu() from ocfs2_error()
>  - Cast bh->b_blocknr to unsigned long long
>  - Remove type casting for OCFS2_SUPER_BLOCK_BLKNO
>  - Fix Sparse warnings reported in v1 by kernel test robot
>  - Update title from 'ocfs2: Fix kernel BUG in ocfs2_write_block' to
>    'ocfs2: fix kernel BUG in ocfs2_write_block'
> 
> v1 link: https://lore.kernel.org/all/20251206154819.175479-1-activprithvi@gmail.com/T/
>  fs/ocfs2/slot_map.c | 29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ocfs2/slot_map.c b/fs/ocfs2/slot_map.c
> index e544c704b583..50ddd7f50f8f 100644
> --- a/fs/ocfs2/slot_map.c
> +++ b/fs/ocfs2/slot_map.c
> @@ -44,6 +44,9 @@ struct ocfs2_slot_info {
>  static int __ocfs2_node_num_to_slot(struct ocfs2_slot_info *si,
>  				    unsigned int node_num);
>  
> +static int ocfs2_validate_slot_map_block(struct super_block *sb,
> +					  struct buffer_head *bh);
> +
>  static void ocfs2_invalidate_slot(struct ocfs2_slot_info *si,
>  				  int slot_num)
>  {
> @@ -132,7 +135,8 @@ int ocfs2_refresh_slot_info(struct ocfs2_super *osb)
>  	 * this is not true, the read of -1 (UINT64_MAX) will fail.
>  	 */
>  	ret = ocfs2_read_blocks(INODE_CACHE(si->si_inode), -1, si->si_blocks,
> -				si->si_bh, OCFS2_BH_IGNORE_CACHE, NULL);
> +				si->si_bh, OCFS2_BH_IGNORE_CACHE,
> +				ocfs2_validate_slot_map_block);
>  	if (ret == 0) {
>  		spin_lock(&osb->osb_lock);
>  		ocfs2_update_slot_info(si);
> @@ -332,6 +336,26 @@ int ocfs2_clear_slot(struct ocfs2_super *osb, int slot_num)
>  	return ocfs2_update_disk_slot(osb, osb->slot_info, slot_num);
>  }
>  
> +static int ocfs2_validate_slot_map_block(struct super_block *sb,
> +					  struct buffer_head *bh)
> +{
> +	int rc;
> +
> +	BUG_ON(!buffer_uptodate(bh));
> +
> +	if (bh->b_blocknr < OCFS2_SUPER_BLOCK_BLKNO) {
> +		rc = ocfs2_error(sb,
> +				 "Invalid Slot Map Buffer Head "
> +				 "Block Number : %llu, Should be >= %d",
> +				 (unsigned long long)bh->b_blocknr,
> +				 OCFS2_SUPER_BLOCK_BLKNO);
> +		if (!rc)
> +			return -EIO;

Since ocfs2_error() never returns 0, please remove the above if condition.

Thanks,
Heming
> +		return rc;
> +	}
> +	return 0;
> +}
> +
>  static int ocfs2_map_slot_buffers(struct ocfs2_super *osb,
>  				  struct ocfs2_slot_info *si)
>  {
> @@ -383,7 +407,8 @@ static int ocfs2_map_slot_buffers(struct ocfs2_super *osb,
>  
>  		bh = NULL;  /* Acquire a fresh bh */
>  		status = ocfs2_read_blocks(INODE_CACHE(si->si_inode), blkno,
> -					   1, &bh, OCFS2_BH_IGNORE_CACHE, NULL);
> +					   1, &bh, OCFS2_BH_IGNORE_CACHE,
> +					   ocfs2_validate_slot_map_block);
>  		if (status < 0) {
>  			mlog_errno(status);
>  			goto bail;
> 
> base-commit: 24172e0d79900908cf5ebf366600616d29c9b417
> -- 
> 2.43.0
> 

