Return-Path: <stable+bounces-201071-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDAACBF31B
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 18:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 912FD3062E5D
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 17:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B28133F8A5;
	Mon, 15 Dec 2025 17:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVD84A1r"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0899C33E37B
	for <stable@vger.kernel.org>; Mon, 15 Dec 2025 17:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765818177; cv=none; b=CzYkv2GcpebTUxUV+jVPm0CfTV7GEn2MFgPawlFQCts5pEMPYoNTvsPWedlJqCLOwIYVMc4tkJDKVNaB10cP2xRDFTyLO2fUZW0IcKx83E2C0qz0S+77cN6lyRJpXDu+SihiCRjSdYBFp6zpzss2oN+ONy0+ajv1RdFiv79JPR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765818177; c=relaxed/simple;
	bh=bwZq3pDn45dHMvKwRD/pGpYNsdBTtg1rw7Z6eYR0n6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVqdwKoG13JjqMH7zXPGT6mDVwNSqTyjV0XL+DjvjQCmNxDjIu1UicrKqwy41QweEgrFfqgbUK+g+ETyFQ2tK1L0qD7txTbyPl+iZoQM9/hK1pKhPKqbE1Qg93OQcXHuUDPEJEvhVy8I4OZFam9SvdMubtqJ7ccdoBSkuzU/SCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVD84A1r; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-29f0f875bc5so48411995ad.3
        for <stable@vger.kernel.org>; Mon, 15 Dec 2025 09:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765818174; x=1766422974; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aXgguA2ONOc6Orc1IUAbVwvyBKZhr/2LviXH8dqh3S0=;
        b=hVD84A1rWfHG6Vl81rMzfhk6eGzkCOMFev+WViDmDn7D1aXvufnKLJ061nm14OjXsj
         OAclIQUhhYfOk7IrWC01lnE8KTSM8cDjmEHcg2T5fJrclaz8Minq46jMee5TGZaN1b/1
         WYi+cGYUbJDKlIeK3k2G4IGmI0WeHIGjxRiegId5+6FNkgEgQ83EK/pAfXgrPNpoJJgy
         rJw3pBPZXuj28g/N1Lelx9EUIDM6CQVyqC6PtfY59EHP/baxjN/5yi5+tMVqa8ZrAL4e
         2CnUjipIA8SkrcGGo2HJBSKa2q/mO4NpzeZhfwmIB8CH+lzRNsUD+6lBHi7n4iwIJqdx
         ulsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765818174; x=1766422974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aXgguA2ONOc6Orc1IUAbVwvyBKZhr/2LviXH8dqh3S0=;
        b=NNzYEKNEA2FTiMSJ59aDekvUh6Bid5MzM7+d61Gt9GtT04MCt8NNJQEFUaEtMA1Ckm
         y5GN7SLdmOhnZXYn4xwsLUBmgYVPEsSDAR45Kz+xRkNAq9AElsCcbtHW+JvWTu1GDQtw
         6SN4C7hCM4BWfPbpx1mGx4SSNSGIrBwblO/Pm+iLi0R3+g69VF4bsaal4ZSXL9yE/6EC
         u2DDu+DhcEwWoaUvQP4jj/Mkm32qHniNbRY7OX16WhvqU8P8AB8D4Hm37TY1dpOAgfca
         N6DD04sk0VDPpgneLHNW6bXOdmNJNCMhxOJFu8cu1fN51LdW+aEUz37/NWIgEkca5bPW
         uE6A==
X-Forwarded-Encrypted: i=1; AJvYcCWalDaKGGrZa24+d4Zuf/kux0/SWABvP42Y3DCqEEyo/qy0A4VdXFWTu++4cvzTkdCbcsJD4F4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcvFuRf87YKNpZrq440OYouiwspqz++zdbyd+ESHO5eYZoIQyl
	kH5/ZLqSa6BBqeR+0hpk6J4NngaQJZSeXpw26+LI+k1j7/j9esKrkZqM
X-Gm-Gg: AY/fxX6enCrFpSo3mGLxtmJsP72MpaXaTA3P5qe5dAzBYARlRAulJe7Z7z4gho/e0RB
	hbf0kctASUyDffoqET8poXZmEAReF0Xfarb27ZaCQVEwAYW3C6p3SSjH+p/G3a9KfnI/dJtuEIQ
	2eJzZ5qx0AqYkJ8/0p7DReY/a2KAVSrmpczTWwOKAwPbRUiDV/0tx1jNigp4SUZYIzPU/mGmWQH
	T6vrxXnDpMBJWn0hXJOYWfx1qo+o0FM0GdV/Gv6mYCYIJzkdcGG3MpMBh3j2aHgfsT5HyG6EHm2
	smLaYdg4sZSd8EM+I7hVDylvnLb1zVC15EC8dd0X4geHzNpg/x6YZCy/blHpnQhfmFtbZlhRKhN
	G31woIAYytvnGjuGBrhsxSt1ASrsy7hqYwdgR93pFgi43800f6QrtjvXJL9Sa8E2WegGWY7hlaH
	vrozOqlMz6HqIa
X-Google-Smtp-Source: AGHT+IE4p+UmmUv+Akr7vMEk5JRDk9BgVR4yC6f8f61tsVRIPDIvhHJSvDDX7JBsmMTr5oTAWoShpg==
X-Received: by 2002:a17:903:1247:b0:29d:9b39:c05f with SMTP id d9443c01a7336-29f23dfe992mr125761275ad.10.1765818173098;
        Mon, 15 Dec 2025 09:02:53 -0800 (PST)
Received: from prithvi-HP ([111.125.240.40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a0ced60fddsm49902845ad.77.2025.12.15.09.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 09:02:52 -0800 (PST)
Date: Mon, 15 Dec 2025 22:32:45 +0530
From: Prithvi <activprithvi@gmail.com>
To: Heming Zhao <heming.zhao@suse.com>
Cc: jlbec@evilplan.org, joseph.qi@linux.alibaba.com, mark@fasheh.com, 
	linux-kernel@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	khalid@kernel.org, syzbot+c818e5c4559444f88aa0@syzkaller.appspotmail.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH v3] ocfs2: Add validate function for slot map blocks
Message-ID: <tagu2npibmto5bgonhorg5krbvqho4zxsv5pulvgbtp53aobas@6qk4twoysbnz>
References: <20251215052513.18436-1-activprithvi@gmail.com>
 <pbky57xu3cdwtrxieo7y2dicl5vddy7k5ttf32nxypirceoenx@et4o3qg4ifck>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pbky57xu3cdwtrxieo7y2dicl5vddy7k5ttf32nxypirceoenx@et4o3qg4ifck>

On Mon, Dec 15, 2025 at 10:21:37PM +0800, Heming Zhao wrote:
> On Mon, Dec 15, 2025 at 10:55:13AM +0530, Prithvi Tambewagh wrote:
> > When the filesystem is being mounted, the kernel panics while the data
> > regarding slot map allocation to the local node, is being written to the
> > disk. This occurs because the value of slot map buffer head block
> > number, which should have been greater than or equal to
> > `OCFS2_SUPER_BLOCK_BLKNO` (evaluating to 2) is less than it, indicative
> > of disk metadata corruption. This triggers
> > BUG_ON(bh->b_blocknr < OCFS2_SUPER_BLOCK_BLKNO) in ocfs2_write_block(),
> > causing the kernel to panic.
> > 
> > This is fixed by introducing  function ocfs2_validate_slot_map_block() to
> > validate slot map blocks. It first checks if the buffer head passed to it
> > is up to date and valid, else it panics the kernel at that point itself.
> > Further, it contains an if condition block, which checks if `bh->b_blocknr`
> > is lesser than `OCFS2_SUPER_BLOCK_BLKNO`; if yes, then ocfs2_error is
> > called, which prints the error log, for debugging purposes, and the return
> > value of ocfs2_error() is returned. If the return value is zero. then error
> > code EIO is returned.
> > 
> > This function is used as validate function in calls to ocfs2_read_blocks()
> > in ocfs2_refresh_slot_info() and ocfs2_map_slot_buffers().
> > In addition, the function also contains
> 
> The last sentence seems incomplete.
> 
> > 
> > Reported-by: syzbot+c818e5c4559444f88aa0@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=c818e5c4559444f88aa0
> > Tested-by: syzbot+c818e5c4559444f88aa0@syzkaller.appspotmail.com
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Prithvi Tambewagh <activprithvi@gmail.com>
> > ---
> > v2->v3:
> >  - Create new function ocfs2_validate_slot_map_block() to validate block 
> >    number of slot map blocks, to be greater then or equal to 
> >    OCFS2_SUPER_BLOCK_BLKNO
> >  - Use ocfs2_validate_slot_map_block() in calls to ocfs2_read_blocks() in
> >    ocfs2_refresh_slot_info() and ocfs2_map_slot_buffers()
> >  - In addition to using previously formulated if block in 
> >    ocfs2_validate_slot_map_block(), also check if the buffer head passed 
> >    in this function is up to date; if not, then kernel panics at that point
> >  - Change title of patch to 'ocfs2: Add validate function for slot map blocks'
> > 
> > v2 link: https://lore.kernel.org/ocfs2-devel/nwkfpkm2wlajswykywnpt4sc6gdkesakw2sw7etuw2u2w23hul@6oby33bscwdw/T/#t
> > 
> > v1->v2:
> >  - Remove usage of le16_to_cpu() from ocfs2_error()
> >  - Cast bh->b_blocknr to unsigned long long
> >  - Remove type casting for OCFS2_SUPER_BLOCK_BLKNO
> >  - Fix Sparse warnings reported in v1 by kernel test robot
> >  - Update title from 'ocfs2: Fix kernel BUG in ocfs2_write_block' to
> >    'ocfs2: fix kernel BUG in ocfs2_write_block'
> > 
> > v1 link: https://lore.kernel.org/all/20251206154819.175479-1-activprithvi@gmail.com/T/
> >  fs/ocfs2/slot_map.c | 29 +++++++++++++++++++++++++++--
> >  1 file changed, 27 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/ocfs2/slot_map.c b/fs/ocfs2/slot_map.c
> > index e544c704b583..50ddd7f50f8f 100644
> > --- a/fs/ocfs2/slot_map.c
> > +++ b/fs/ocfs2/slot_map.c
> > @@ -44,6 +44,9 @@ struct ocfs2_slot_info {
> >  static int __ocfs2_node_num_to_slot(struct ocfs2_slot_info *si,
> >  				    unsigned int node_num);
> >  
> > +static int ocfs2_validate_slot_map_block(struct super_block *sb,
> > +					  struct buffer_head *bh);
> > +
> >  static void ocfs2_invalidate_slot(struct ocfs2_slot_info *si,
> >  				  int slot_num)
> >  {
> > @@ -132,7 +135,8 @@ int ocfs2_refresh_slot_info(struct ocfs2_super *osb)
> >  	 * this is not true, the read of -1 (UINT64_MAX) will fail.
> >  	 */
> >  	ret = ocfs2_read_blocks(INODE_CACHE(si->si_inode), -1, si->si_blocks,
> > -				si->si_bh, OCFS2_BH_IGNORE_CACHE, NULL);
> > +				si->si_bh, OCFS2_BH_IGNORE_CACHE,
> > +				ocfs2_validate_slot_map_block);
> >  	if (ret == 0) {
> >  		spin_lock(&osb->osb_lock);
> >  		ocfs2_update_slot_info(si);
> > @@ -332,6 +336,26 @@ int ocfs2_clear_slot(struct ocfs2_super *osb, int slot_num)
> >  	return ocfs2_update_disk_slot(osb, osb->slot_info, slot_num);
> >  }
> >  
> > +static int ocfs2_validate_slot_map_block(struct super_block *sb,
> > +					  struct buffer_head *bh)
> > +{
> > +	int rc;
> > +
> > +	BUG_ON(!buffer_uptodate(bh));
> > +
> > +	if (bh->b_blocknr < OCFS2_SUPER_BLOCK_BLKNO) {
> > +		rc = ocfs2_error(sb,
> > +				 "Invalid Slot Map Buffer Head "
> > +				 "Block Number : %llu, Should be >= %d",
> > +				 (unsigned long long)bh->b_blocknr,
> > +				 OCFS2_SUPER_BLOCK_BLKNO);
> > +		if (!rc)
> > +			return -EIO;
> 
> Since ocfs2_error() never returns 0, please remove the above if condition.
> 
> Thanks,
> Heming
> > +		return rc;
> > +	}
> > +	return 0;
> > +}
> > +
> >  static int ocfs2_map_slot_buffers(struct ocfs2_super *osb,
> >  				  struct ocfs2_slot_info *si)
> >  {
> > @@ -383,7 +407,8 @@ static int ocfs2_map_slot_buffers(struct ocfs2_super *osb,
> >  
> >  		bh = NULL;  /* Acquire a fresh bh */
> >  		status = ocfs2_read_blocks(INODE_CACHE(si->si_inode), blkno,
> > -					   1, &bh, OCFS2_BH_IGNORE_CACHE, NULL);
> > +					   1, &bh, OCFS2_BH_IGNORE_CACHE,
> > +					   ocfs2_validate_slot_map_block);
> >  		if (status < 0) {
> >  			mlog_errno(status);
> >  			goto bail;
> > 
> > base-commit: 24172e0d79900908cf5ebf366600616d29c9b417
> > -- 
> > 2.43.0
> >

Sure, I will make the corrections and send a v4 patch.

Thanks,
Prithvi


