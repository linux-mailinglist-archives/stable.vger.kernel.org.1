Return-Path: <stable+bounces-227316-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOhKIIQNvGkirwIAu9opvQ
	(envelope-from <stable+bounces-227316-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 15:51:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D49972CD32B
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 15:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 395C131476CD
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 14:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199583D646B;
	Thu, 19 Mar 2026 14:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="Jk2dJMey"
X-Original-To: stable@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2975F40DFD2;
	Thu, 19 Mar 2026 14:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773931811; cv=none; b=GWRq9je2m26Ki1xx4AOrPv4vkKPvDaTVzecMbkTEY+LvMyftakpiBt/35gy0cPgqxdgLf/o8NOnMXNo+QdUiHnAPR9nQbXPyx+vSXkFp9dPDbWS/pf7sag7X698dd1qjIrgD0u/gq5W6yoh2Ybi4fxE0Hi8F49mTvhweUht88RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773931811; c=relaxed/simple;
	bh=4hKtpeEC87+WK7hrHDaVDwXDV1P2/Sdtv+NsVi+b2q8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OgaAsE3+T77C5N43AhbSUUjKyJq4ZPLSRo0AXojdsR8B/KY36Ljit/u0sKeF4O562QvTd5NTQOfeVOItjPoDvKWeGwTuDqvhYa3JnYRXwS796hF7U3A7JyJPKiPYWEdaQ77WdrFoXDYxDSKaEvWizRpZbErvFeBOsf4N+yJ6wtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=Jk2dJMey; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from DESKTOP-SUEFNF9.tailb3ad3b.ts.net (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3795726d0;
	Thu, 19 Mar 2026 22:49:55 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: slava.dubeyko@ibm.com
Cc: akpm@linux-foundation.org,
	frank.li@vivo.com,
	glaubitz@physik.fu-berlin.de,
	jianhao.xu@seu.edu.cn,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	slava@dubeyko.com,
	stable@vger.kernel.org,
	zilin@seu.edu.cn
Subject: Re:  [PATCH v2 2/2] hfsplus: extract hidden directory search into a helper function
Date: Thu, 19 Mar 2026 22:49:55 +0800
Message-Id: <20260319144955.648380-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <e86980b8682bb9ea007d9fdfab8a8530781ebb2b.camel@ibm.com>
References: <e86980b8682bb9ea007d9fdfab8a8530781ebb2b.camel@ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d0693135c03a1kunm02123ad01f368b
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGkkZVktPGkhNHx1OHUMaQ1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUJCSU5LVUpLS1VKQktCWQ
	Y+
DKIM-Signature: a=rsa-sha256;
	b=Jk2dJMeyLUk585VcuLBW+u8bFQ+WP2fPORyJilndc+njMVIvzGNtapvI7PxUd6ayTC5uXmXeX4PqbXVG4h2xScXcDDB4aUrZ93te8GzfAhp56oAsA97piYgS+3NoWuP115AtsQ04DPT8Y/F85vHbFADez0jKhGA1zkNxsXCCZ6I=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=sqiUf+eXM3Gt3jVgEwpa3BBJiLznBeFQrrlZaOeVpXc=;
	h=date:mime-version:subject:message-id:from;
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227316-lists,stable=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zilin@seu.edu.cn,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.987];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,seu.edu.cn:dkim,seu.edu.cn:mid]
X-Rspamd-Queue-Id: D49972CD32B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 10:33:47PM +0000, Viacheslav Dubeyko wrote:
> On Wed, 2026-03-18 at 23:00 +0800, Zilin Guan wrote:
> > +static inline int hfsplus_get_hidden_dir_entry(struct super_block *sb,
> > +					       const struct qstr *str,
> > +					       hfsplus_cat_entry *entry)
> > +{
> > +	struct hfs_find_data fd;
> > +	int err;
> > +
> > +	err = hfs_find_init(HFSPLUS_SB(sb)->cat_tree, &fd);
> > +	if (err)
> 
> Why not unlikely(err) here too?

Right, I'll update this in v3.

> > +		return err;
> > +
> > +	err = hfsplus_cat_build_key(sb, fd.search_key, HFSPLUS_ROOT_CNID, str);
> > +	if (unlikely(err < 0))
> 
> The hfsplus_cat_build_key() return error code or 0. So, we can use unlikely(err)
> here.

Agreed.

> > +		goto free_fd;
> > +
> > +	err = hfs_brec_read(&fd, entry, sizeof(*entry));
> > +
> > +free_fd:
> > +	hfs_find_exit(&fd);
> > +	return err;
> > +}
> > +
> >  static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
> >  {
> >  	struct hfsplus_vh *vhdr;
> >  	struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
> >  	hfsplus_cat_entry entry;
> > -	struct hfs_find_data fd;
> >  	struct inode *root, *inode;
> >  	struct qstr str;
> >  	struct nls_table *nls;
> > @@ -565,16 +586,11 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
> >  
> >  	str.len = sizeof(HFSP_HIDDENDIR_NAME) - 1;
> >  	str.name = HFSP_HIDDENDIR_NAME;
> > -	err = hfs_find_init(sbi->cat_tree, &fd);
> > -	if (err)
> > -		goto out_put_root;
> > -	err = hfsplus_cat_build_key(sb, fd.search_key, HFSPLUS_ROOT_CNID, &str);
> > -	if (unlikely(err < 0)) {
> > -		hfs_find_exit(&fd);
> > -		goto out_put_root;
> > -	}
> > -	if (!hfs_brec_read(&fd, &entry, sizeof(entry))) {
> > -		hfs_find_exit(&fd);
> > +	err = hfsplus_get_hidden_dir_entry(sb, &str, &entry);
> > +	if (err) {
> > +		if (err != -ENOENT)
> > +			goto out_put_root;
> 
> The hfs_brec_read() can return multiple errors (for example, -EINVAL). Are you
> sure that this check is correct?
> 
> Thanks,
> Slava.

I see your point.

The current logic follows hfsplus_lookup(), where only -ENOENT is treated
as missing, and other errors are propagated. The original code effectively 
ignored hfs_brec_read() errors and continued as if the directory was missing. 
For critical errors like -EIO/-EINVAL/-ENOMEM, failing the mount seems safer.

If maintaining the legacy behavior is preferred, I can map all read errors 
to -ENOENT inside the helper instead:

	err = hfs_brec_read(&fd, entry, sizeof(*entry));
	if (err)
		err = -ENOENT;

Would you prefer to keep the legacy behavior, or is propagating the exact 
error acceptable?

Thanks,
Zilin

