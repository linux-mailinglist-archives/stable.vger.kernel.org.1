Return-Path: <stable+bounces-230844-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uK8UBgTEyGmOqQUAu9opvQ
	(envelope-from <stable+bounces-230844-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 08:17:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EED3350EAF
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 08:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEBD8300BDB2
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 06:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091662BF3D7;
	Sun, 29 Mar 2026 06:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fGk8lS4K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF43C2BD5A7
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 06:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774764977; cv=none; b=p9Hx6/5bucKOPr+a0dzNlzZp/IDwm9wcBJJLWYI/AG4ruFoHrmfqj5gshFAz2YN7KIqZO2u9f8FEMM3olQNpbCMCDxyqZbzNv7284rsNCCAmLtkn17XZQdB8eABZRbgl9oflHUK1fE6f4uLigdoj1iAmutioFHFCQ31HO4/Qayk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774764977; c=relaxed/simple;
	bh=ZKOZrVz24N7Rqdp7+AuLk5CJe6dPtCQ2NUbw9luuNXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LoNZQi6ql4Z2rdWIdYW3B0PMedsInTnQpf7ffc76cyfgA0tzIRc71o5/EwlOO9Br/DjdPhXdRphtkhp3IoQp4VD+GgFdC3b+Ct833FJxt4oI5f7OkrY1mLwaHTN2S+M4ijSeGqdvsw+G1fBs/n6WSNULDfo+0quikkEtVovEUnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fGk8lS4K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E4DC116C6;
	Sun, 29 Mar 2026 06:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774764977;
	bh=ZKOZrVz24N7Rqdp7+AuLk5CJe6dPtCQ2NUbw9luuNXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fGk8lS4K7WRL20PbfcNS+GuQioJ6VMAlfaNTtYJ2rfi9xuH4RGY4aPa/+KEmAukJj
	 MJmyn6FGqw6p/h5vrgopmQk2mSQzxhi8ahmP4jm/kzO9+r4Dna3DFMgaYM9CEZe2kF
	 3Q1RXu4Q1wGop6Kjpt2i6MoJNXQjdwV3Cwvw/Z+4=
Date: Sun, 29 Mar 2026 08:16:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "driz2t@qq.com" <driz2t@qq.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"slava@dubeyko.com" <slava@dubeyko.com>,
	"sashal@kernel.org" <sashal@kernel.org>,
	"syzbot+7c669e7491fdbacd64b2@syzkaller.appspotmail.com" <syzbot+7c669e7491fdbacd64b2@syzkaller.appspotmail.com>
Subject: Re: [PATCH 6.1.y] hfs: fix general protection fault in
 hfs_find_init()
Message-ID: <2026032940-rectify-pamphlet-6298@gregkh>
References: <tencent_2352D6EE52D5CF390269BCB1DAD1FD9B2105@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_2352D6EE52D5CF390269BCB1DAD1FD9B2105@qq.com>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[qq.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-230844-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.989];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable,7c669e7491fdbacd64b2];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vivo.com:email,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qq.com:email,dubeyko.com:email]
X-Rspamd-Queue-Id: 6EED3350EAF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 29, 2026 at 05:49:18AM +0000, driz2t@qq.com wrote:
> PATCH] This is a backport for 6.1.y.

Odd text, but also:

> 
> [ Upstream commit 736a0516a16268995f4898eded49bfef077af709 ]
> 
> The hfs_find_init() method can trigger a crash if tree pointer is NULL.
> 
> hfs_fill_super() calls hfs_mdb_get(), which tries to construct Extents
> Tree and Catalog Tree. However, hfs_btree_open() calls read_mapping_page(),
> which calls hfs_get_block(), and that in turn calls hfs_ext_read_extent().
> 
> The problem is that hfs_find_init() tries to use
> HFS_SB(inode->i_sb)->ext_tree before it has been initialized. It will
> only be initialized after hfs_btree_open() finishes.
> 
> Fix this by checking the tree pointer in hfs_find_init() and reworking
> hfs_btree_open() to read the b-tree header directly from the volume.
> Replace read_mapping_page() with filemap_grab_folio(), then use sb_bread()
> to extract the b-tree header content and copy it into the folio.
> 
> Reported-by: Wenzhi Wang <wenzhi.wang@uwaterloo.ca>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: Yangtao Li <frank.li@vivo.com>
> Cc: linux-fsdevel@vger.kernel.org
> Link: https://lore.kernel.org/r/20250710213657.108285-1-slava@dubeyko.com
> Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
> Signed-off-by: Changjian Liu <driz2t@qq.com>
> ---
>  fs/hfs/bfind.c  |  3 +++
>  fs/hfs/btree.c  | 33 +++++++++++++++++++++++----------
>  fs/hfs/extent.c |  2 +-
>  fs/hfs/hfs_fs.h |  1 +
>  4 files changed, 28 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
> index 6d37b4c75903..1b1cbb589f82 100644
> --- a/fs/hfs/bfind.c
> +++ b/fs/hfs/bfind.c
> @@ -16,6 +16,9 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
>  {
>       void *ptr;
>  
> +if (!tree || !fd)
> +     return -EINVAL;
> +
>       fd->tree = tree;
>       fd->bnode = NULL;
>       ptr = kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);

Your patch is completly corrupted and can not be applied :(

please fix your email client to work properly when sending patches.

thanks,

greg k-h

