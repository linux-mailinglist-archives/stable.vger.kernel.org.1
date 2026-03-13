Return-Path: <stable+bounces-225227-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGVGMV5ts2kEWQAAu9opvQ
	(envelope-from <stable+bounces-225227-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 02:50:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F7827C4E3
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 02:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7AD953067855
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 01:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94482F532C;
	Fri, 13 Mar 2026 01:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="SYO7SUMd"
X-Original-To: stable@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B6A32AABD;
	Fri, 13 Mar 2026 01:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773366608; cv=none; b=m/tcgSxRrf9KFcgKkLPAy4BCk24EA/8NLMxV9WiMqH+Uet+OFYmCUoytIFCzC6pYTBqD/5PvlvER3A3y6Eg7Ue4V+lKF0rNAuPHu/zIn3lgepoG0cLJs5wq8dhPsT1GDVYiFaHSUZtoASy9bmDlb7h7VJHwylTV6wz8YfUxU1QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773366608; c=relaxed/simple;
	bh=6KtpKOJDtkV6BORlHClu997PS0MH/vOvv0UwIKGsQWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jy0/74FzDww0zS+CSE7C6iDPgq2c1lQvo9aK+fJBiH68rZSVXhA3dnvGqBdSpvqjlS0GDl7ZnVhrvkpjTPYVR0lvqveyGYD+RsoLLhn22skRPA7cXhnP3XyDvzdkQRCvOQQLxeFlTHu15EfddCJnJgBJ/Nn3kzY1Z6PLmA6klvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=SYO7SUMd; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from DESKTOP-SUEFNF9.tailb3ad3b.ts.net (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 36c692dc3;
	Fri, 13 Mar 2026 09:49:47 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: slava.dubeyko@ibm.com
Cc: akpm@linux-foundation.org,
	frank.li@vivo.com,
	glaubitz@physik.fu-berlin.de,
	jianhao.xu@seu.edu.cn,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	slava@dubeyko.com,
	sougata@tuxera.com,
	stable@vger.kernel.org,
	zilin@seu.edu.cn
Subject: RE:  [PATCH] hfsplus: fix held lock freed on hfsplus_fill_super()
Date: Fri, 13 Mar 2026 09:49:49 +0800
Message-Id: <20260313014949.19178-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <77a8534a8b7922a1c0cf85f68fd8bda2bd7a61dc.camel@ibm.com>
References: <77a8534a8b7922a1c0cf85f68fd8bda2bd7a61dc.camel@ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ce4e2b01a03a1kunm4d4ba3db1d2ae
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSU5IVklCQkxKGEoYGEhKSFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUJCSU5LVUpLS1VKQk
	tCWQY+
DKIM-Signature: a=rsa-sha256;
	b=SYO7SUMdYOF03vRa30IWqaGsPjE0zvVt5x3maj+9yeEngdnRX8aiEf+6i9VOCPZeb01pJONY6ca9GsRTLyA6eUaiZtgyQg1nN6OipBQMGkNWlwkfJsrLrC2yuvhZM2kNR+bmTENWG1NSu/tmwQfCWkSKxIFElQFkBap5rLjkxVE=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=3f94yEpvLHTFyIc2v5X/OTnhWXa1TvgrDI017wFG8+s=;
	h=date:mime-version:subject:message-id:from;
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225227-lists,stable=lfdr.de];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[zilin@seu.edu.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+]
X-Rspamd-Queue-Id: 41F7827C4E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 05:36:38PM +0000, Viacheslav Dubeyko wrote:
> On Thu, 2026-03-12 at 10:17 +0800, Zilin Guan wrote:
> > On Wed, Mar 11, 2026 at 09:17:59PM +0000, Viacheslav Dubeyko wrote:
> > > On Wed, 2026-03-11 at 19:43 +0800, Zilin Guan wrote:
> > > >  fs/hfsplus/super.c | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
> > > > index 7229a8ae89f9..f396fee19ab8 100644
> > > > --- a/fs/hfsplus/super.c
> > > > +++ b/fs/hfsplus/super.c
> > > > @@ -569,8 +569,10 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
> > > >  	if (err)
> > > >  		goto out_put_root;
> > > >  	err = hfsplus_cat_build_key(sb, fd.search_key, HFSPLUS_ROOT_CNID, &str);
> > > > -	if (unlikely(err < 0))
> > > > +	if (unlikely(err < 0)) {
> > > > +		hfs_find_exit(&fd);
> > > >  		goto out_put_root;
> > > > +	}
> > > >  	if (!hfs_brec_read(&fd, &entry, sizeof(entry))) {
> > > >  		hfs_find_exit(&fd);
> > > >  		if (entry.type != cpu_to_be16(HFSPLUS_FOLDER)) {
> > > 
> > > Makes sense.
> > > 
> > > Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
> > > 
> > > Frankly speaking, I think, potentially, we can introduce static inline function
> > > for this code:
> > > 
> > > 	str.len = sizeof(HFSP_HIDDENDIR_NAME) - 1;
> > > 	str.name = HFSP_HIDDENDIR_NAME;
> > > 	err = hfs_find_init(sbi->cat_tree, &fd);
> > > 	if (err)
> > > 		goto out_put_root;
> > > 	err = hfsplus_cat_build_key(sb, fd.search_key, HFSPLUS_ROOT_CNID,
> > > &str);
> > > 	if (unlikely(err < 0))
> > > 		goto out_put_root;
> > > 	if (!hfs_brec_read(&fd, &entry, sizeof(entry))) {
> > > 		hfs_find_exit(&fd);
> > > 		if (entry.type != cpu_to_be16(HFSPLUS_FOLDER)) {
> > > 			err = -EIO;
> > > 			goto out_put_root;
> > > 		}
> > > 		inode = hfsplus_iget(sb, be32_to_cpu(entry.folder.id));
> > > 		if (IS_ERR(inode)) {
> > > 			err = PTR_ERR(inode);
> > > 			goto out_put_root;
> > > 		}
> > > 		sbi->hidden_dir = inode;
> > > 	} else
> > > 		hfs_find_exit(&fd);
> > > 
> > > Because, hiding this code into small function will provide opportunity to call
> > > hfs_find_exit() in one place only (as for normal as for erroneous flow).
> > > 
> > > What do you think?
> > > 
> > > Thanks,
> > > Slava.
> > 
> > Thanks for the feedback, Slava.
> > 
> > While I see the merit in refactoring this into a helper to centralize the 
> > cleanup, I’m concerned that doing so wouldn’t actually achieve a single 
> > hfs_find_exit() call without compromising the resource lifecycle.
> > 
> > In the current logic, we need to call hfs_find_exit(&fd) as early as 
> > possible—specifically before entering hfsplus_iget(), which might involve 
> > further I/O or sleeping. If we were to use a single-exit goto pattern in a 
> > helper function, we would end up holding the search data and its 
> > associated buffers/locks longer than necessary. To maintain the current 
> > early-release behavior, we would still be forced to sprinkle multiple 
> > hfs_find_exit() calls across different branches within that helper anyway, 
> > which defeats the purpose of the refactoring.
> > 
> > Given that this is a straightforward fix for a specific leak, I believe 
> > keeping the logic inline preserves the optimal resource release timing 
> > without adding unnecessary abstraction.
> > 
> 
> I mean really simple solution:
> 
> static inline
> int hfsplus_get_hidden_dir_entry(struct super_block *sb,
>                                  hfsplus_cat_entry *entry)
> {
>     int err = 0;
> 
> 	str.len = sizeof(HFSP_HIDDENDIR_NAME) - 1;
> 	str.name = HFSP_HIDDENDIR_NAME;
> 	err = hfs_find_init(sbi->cat_tree, &fd);
> 	if (err)
> 		goto finish_logic;
> 
> 	err = hfsplus_cat_build_key(sb, fd.search_key, HFSPLUS_ROOT_CNID,
> &str);
> 	if (unlikely(err < 0))
> 		goto free_fd;
> 
>         err = hfs_brec_read(&fd, entry, sizeof(*entry));
> 
> free_fd:
>      hfs_find_exit(&fd);
> finish_logic:
>      return err;
> }
> 
> static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
> {
>   <skipped>
> 
>   err = hfsplus_get_hidden_dir_entry(sb, &entry);
>   if (err)
>       goto process_error;
> 
> 		if (entry.type != cpu_to_be16(HFSPLUS_FOLDER)) {
> 			err = -EIO;
> 			goto finish_logic;
> 		}
> 		inode = hfsplus_iget(sb, be32_to_cpu(entry.folder.id));
> 		if (IS_ERR(inode)) {
> 			err = PTR_ERR(inode);
> 			goto finish_logic;
> 		}
> 		sbi->hidden_dir = inode;
> 
>   <skipped>
> }
> 
> Does it makes sense to you?
> 
> Thanks,
> Slava.

Hi Slava,

Thanks for the detailed proposal. However, this proposed refactoring 
changes the existing semantics and introduces a regression.

The hidden directory is optional. If hfs_brec_read() fails, the original 
code simply calls hfs_find_exit() and proceeds with the mount. It is a 
non-fatal error.

In contrast, failures from hfs_find_init() and hfsplus_cat_build_key() are 
fatal and must abort the mount.

By wrapping these into a single helper and returning err, the caller can no 
longer distinguish between them. A missing hidden directory will trigger 
if (err) goto process_error; in hfsplus_fill_super(), making it a fatal 
error. This will break mounting for any valid HFS+ volume that lacks the 
private data directory.

Thanks,
Zilin

