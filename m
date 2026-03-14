Return-Path: <stable+bounces-225408-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPXkHBv5tGlavAAAu9opvQ
	(envelope-from <stable+bounces-225408-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 06:58:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D06A928BD5F
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 06:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BD273055C6F
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 05:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1EC3242C8;
	Sat, 14 Mar 2026 05:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="ipSR2nfe"
X-Original-To: stable@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A813220ED;
	Sat, 14 Mar 2026 05:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773467922; cv=none; b=QUFyhAH5oALcOr2PYD41GQnMkY1U6q40BB/h4wm9aYbmsHI2v0vV6UmM9tU2Mm1RrMMQon+xRR1sdJQtGWJcDy3LxwkBLh9MybeesvZfCSTlnCsZi4X6j06x7eFPkleJmLnUDaBdNxXF7MzxQFna0jyITxHJGloYTX2u1vRWWHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773467922; c=relaxed/simple;
	bh=3noocLolEAOMUOJnlyUkLp0Mdq15PQE18CLrb+L8Ku4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LqPcWbobHC34SWzYecc+ZNIjEWcYFgS+2Em9XyEj8zlM4wbCIa3fkO8Mghl6T/7unz43DVbdjJ6NMs1qZRkacYGC1ZT76EuepsEh/BBeqwTcd4x1duT3X1zTKi7hQ1p4Qj3XrSuYA7Y98CXqGmnd3Cfxdk79bs4PuryKvC4CmI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=ipSR2nfe; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from DESKTOP-SUEFNF9.tailb3ad3b.ts.net (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 36eb75935;
	Sat, 14 Mar 2026 11:36:02 +0800 (GMT+08:00)
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
Date: Sat, 14 Mar 2026 11:36:03 +0800
Message-Id: <20260314033603.14211-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <74c78d0e14517ec28ad269113244562c081722a8.camel@ibm.com>
References: <74c78d0e14517ec28ad269113244562c081722a8.camel@ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9cea6a50aa03a1kunm954900825bda0
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCHkJLVkxMGEwZHk1MS0xIH1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVQkJJTktVSktLVUpCS0
	JZBg++
DKIM-Signature: a=rsa-sha256;
	b=ipSR2nfe9q5XJkLFADsAyHRnSws7J+PRQozJ+SLapaSBX/rW+oxVmrF79I4++/PV+JBd8HOlxulpUbJ6mNni9x6K1VTiH1YrpcCo7MflAzjDf+I99RkkVFsHjcmY2dC8fE8GVPZyhhfSC94rZ/KPyFdtMOCpRtmGGyTCL67wmQ0=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=WNQIZ2gDeyCKMj9X+gub3IQ40scVHpGY3SlWjZ3s+5c=;
	h=date:mime-version:subject:message-id:from;
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[zilin@seu.edu.cn,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-225408-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D06A928BD5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 06:38:14PM +0000, Viacheslav Dubeyko wrote:
> On Fri, 2026-03-13 at 09:49 +0800, Zilin Guan wrote:
> > Hi Slava,
> > 
> > Thanks for the detailed proposal. However, this proposed refactoring 
> > changes the existing semantics and introduces a regression.
> > 
> 
> I don't quite follow to your point. I don't suggest to change the logic. I am
> suggesting the small refactoring without changing the execution flow. Do you
> mean that current hfsplus_fill_super() logic is incorrect and has bugs?

Actually, I don't mean the original logic is incorrect. My concern is that 
extracting this block into a helper makes it very difficult to preserve 
that correct execution flow without complicating the error handling.

> > The hidden directory is optional. If hfs_brec_read() fails, the original 
> > code simply calls hfs_find_exit() and proceeds with the mount. It is a 
> > non-fatal error.
> > 
> 
> You simply need slightly modify my suggestion to make it right:
> 
> err = hfsplus_get_hidden_dir_entry(sb, &entry);
> if (!err) {
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
> }
> 
> I simply shared the raw suggestion but you can make it right.

The issue with this updated snippet is that it silently ignores fatal 
errors from hfs_find_init() and hfsplus_cat_build_key() (e.g., -ENOMEM). 
If they fail, the mount incorrectly continues. In the original code, 
these correctly trigger goto out_put_root.

> > In contrast, failures from hfs_find_init() and hfsplus_cat_build_key() are 
> > fatal and must abort the mount.
> > 
> > By wrapping these into a single helper and returning err, the caller can no 
> > longer distinguish between them. A missing hidden directory will trigger 
> > if (err) goto process_error; in hfsplus_fill_super(), making it a fatal 
> > error. This will break mounting for any valid HFS+ volume that lacks the 
> > private data directory.
> > 
> > 
> 
> Simply make my suggestion better and correct. That's all.
> 
> Thanks,
> Slava.

To make the helper completely correct, we face another issue: the original 
code ignores all errors from hfs_brec_read() (which can return -ENOENT, 
-EINVAL, -EIO, etc.), treating them as non-fatal.

If we combine the fatal setup functions and the non-fatal read function 
into one helper, it cannot simply return a standard error code. It would 
need to return three distinct states:

1. Fatal error -> caller must abort mount.
2. Non-fatal read error -> caller must continue mount, but skip init.
3. Success -> caller must init hidden_dir.

To handle all these cases properly, the helper would have to look 
something like this:

	/* Returns < 0 on fatal error, 0 on missing/read error, 1 on success */
	static inline int hfsplus_get_hidden_dir_entry(struct super_block *sb,
						       hfsplus_cat_entry *entry) 
	{
		struct hfs_find_data fd;
		int err;
		int ret = 0;
		/* ... init str ... */

		err = hfs_find_init(HFSPLUS_SB(sb)->cat_tree, &fd);
		if (err)
			return err; /* Fatal, fd not initialized */
		
		err = hfsplus_cat_build_key(sb, fd.search_key, HFSPLUS_ROOT_CNID, &str);
		if (unlikely(err < 0)) {
			ret = err;
			goto free_fd; /* Fatal */
		}

		err = hfs_brec_read(&fd, entry, sizeof(*entry));
		if (err) {
			ret = 0; /* Non-fatal, but no entry to init */
			goto free_fd;
		}
		
		ret = 1; /* Success */

	free_fd:
		hfs_find_exit(&fd);
		return ret;
	}

And the caller:
	
	err = hfsplus_get_hidden_dir_entry(sb, &entry);
	if (err < 0)
		goto out_put_root;
	if (err == 1) {
		/* ... init hidden_dir ... */
	}

We would have to invent a custom return state convention (1, 0, < 0) just to 
hide a single hfs_find_exit() call.

Given this, I think the current inline logic in my patch is much cleaner 
and avoids this convoluted error routing. 

What do you prefer?

Thanks,
Zilin

