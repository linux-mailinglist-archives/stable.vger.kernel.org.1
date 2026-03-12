Return-Path: <stable+bounces-224788-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BlEINwlsmnlIwAAu9opvQ
	(envelope-from <stable+bounces-224788-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 03:33:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A462F26C40E
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 03:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 48C313013195
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 02:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A7B37C90B;
	Thu, 12 Mar 2026 02:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="hEVVg/7h"
X-Original-To: stable@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471C033D507;
	Thu, 12 Mar 2026 02:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773282770; cv=none; b=o0F/itEu646CSJlRO6lNqns/7Q4CrST/AS3JqfCYdhHA48WHj3A+tJTCEEKqcfJkHS2t31pE2Vx6Eh1ScI/AugTT10kaVK6O5Oov+/s3okBt0qXJrHwOGoZHaKIr5M1VqPfH+kcX9VJaN4UhqDPqZlNsRZC4ohvciylfXf/hADo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773282770; c=relaxed/simple;
	bh=k+Ne3ped2Jd9193BfFYKMJGxDHiSxuC2PFR2Oy+SPIs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f0rJ22OR6yaYwY+6KB8LtfUJno9VkqpT4Sx+QJQWzrtj8RwqN34g90xn7Q63v9gSwwIfNtvce/2g6RRNLomCN2HFKynbpC0UN7WfjWQ1cCMm4nutUIsDFMLUz5Ugr1FSs8XGgv+rcL9EoElKnC9R1pNsruEvaBCr/Vp7l83Thho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=hEVVg/7h; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from DESKTOP-SUEFNF9.tailb3ad3b.ts.net (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 36a2432cc;
	Thu, 12 Mar 2026 10:17:27 +0800 (GMT+08:00)
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
Subject: Re:  [PATCH] hfsplus: fix held lock freed on hfsplus_fill_super()
Date: Thu, 12 Mar 2026 10:17:28 +0800
Message-Id: <20260312021728.446944-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <afab59a14da6ee4dd23d8ef85301ccff451b87cb.camel@ibm.com>
References: <afab59a14da6ee4dd23d8ef85301ccff451b87cb.camel@ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9cdfd5a6c403a1kunm1d5e9d55263e6
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTx4eVkhDGBlLSRkdSUgaSlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUJCSU5LVUpLS1VKQktCWQ
	Y+
DKIM-Signature: a=rsa-sha256;
	b=hEVVg/7hHKsmjDBlvoKj1IWBEYYDqitEBzUJfYF8sg6jCeRjTMCkWcyCZkX/zM76qq2AB/smLRY0AWeSoEGxXmPICbFY4U1cqwfyNgJzvad1FVx/dJRqNEW1dQxwvHOg3bvx4I52SoaecNctl2/35gG+y+odbhHaSwp5428YwEQ=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=Ujvh4SDEcmnNJUUfXaquApesA8XXZa3dzQCOsqyLgOE=;
	h=date:mime-version:subject:message-id:from;
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224788-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zilin@seu.edu.cn,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,seu.edu.cn:dkim,seu.edu.cn:mid,dubeyko.com:email]
X-Rspamd-Queue-Id: A462F26C40E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 09:17:59PM +0000, Viacheslav Dubeyko wrote:
> On Wed, 2026-03-11 at 19:43 +0800, Zilin Guan wrote:
> >  fs/hfsplus/super.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
> > index 7229a8ae89f9..f396fee19ab8 100644
> > --- a/fs/hfsplus/super.c
> > +++ b/fs/hfsplus/super.c
> > @@ -569,8 +569,10 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
> >  	if (err)
> >  		goto out_put_root;
> >  	err = hfsplus_cat_build_key(sb, fd.search_key, HFSPLUS_ROOT_CNID, &str);
> > -	if (unlikely(err < 0))
> > +	if (unlikely(err < 0)) {
> > +		hfs_find_exit(&fd);
> >  		goto out_put_root;
> > +	}
> >  	if (!hfs_brec_read(&fd, &entry, sizeof(entry))) {
> >  		hfs_find_exit(&fd);
> >  		if (entry.type != cpu_to_be16(HFSPLUS_FOLDER)) {
> 
> Makes sense.
> 
> Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
> 
> Frankly speaking, I think, potentially, we can introduce static inline function
> for this code:
> 
> 	str.len = sizeof(HFSP_HIDDENDIR_NAME) - 1;
> 	str.name = HFSP_HIDDENDIR_NAME;
> 	err = hfs_find_init(sbi->cat_tree, &fd);
> 	if (err)
> 		goto out_put_root;
> 	err = hfsplus_cat_build_key(sb, fd.search_key, HFSPLUS_ROOT_CNID,
> &str);
> 	if (unlikely(err < 0))
> 		goto out_put_root;
> 	if (!hfs_brec_read(&fd, &entry, sizeof(entry))) {
> 		hfs_find_exit(&fd);
> 		if (entry.type != cpu_to_be16(HFSPLUS_FOLDER)) {
> 			err = -EIO;
> 			goto out_put_root;
> 		}
> 		inode = hfsplus_iget(sb, be32_to_cpu(entry.folder.id));
> 		if (IS_ERR(inode)) {
> 			err = PTR_ERR(inode);
> 			goto out_put_root;
> 		}
> 		sbi->hidden_dir = inode;
> 	} else
> 		hfs_find_exit(&fd);
> 
> Because, hiding this code into small function will provide opportunity to call
> hfs_find_exit() in one place only (as for normal as for erroneous flow).
> 
> What do you think?
> 
> Thanks,
> Slava.

Thanks for the feedback, Slava.

While I see the merit in refactoring this into a helper to centralize the 
cleanup, I’m concerned that doing so wouldn’t actually achieve a single 
hfs_find_exit() call without compromising the resource lifecycle.

In the current logic, we need to call hfs_find_exit(&fd) as early as 
possible—specifically before entering hfsplus_iget(), which might involve 
further I/O or sleeping. If we were to use a single-exit goto pattern in a 
helper function, we would end up holding the search data and its 
associated buffers/locks longer than necessary. To maintain the current 
early-release behavior, we would still be forced to sprinkle multiple 
hfs_find_exit() calls across different branches within that helper anyway, 
which defeats the purpose of the refactoring.

Given that this is a straightforward fix for a specific leak, I believe 
keeping the logic inline preserves the optimal resource release timing 
without adding unnecessary abstraction.

Best regards,
Zilin

