Return-Path: <stable+bounces-240847-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCfbNbp062koNAAAu9opvQ
	(envelope-from <stable+bounces-240847-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:48:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A47045FAF1
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C96B030AB44E
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735EB3D75C2;
	Fri, 24 Apr 2026 13:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tnCETz3o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378B73D75C1;
	Fri, 24 Apr 2026 13:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777037994; cv=none; b=GFZMeGTPOmX27XPx5D3YdBtyihEy/Gd+atV+xqDfNQaC/GaDH3uAZqJ5XKlNcsPKzYH1G28BFnjAc5Do6BcvT0pQeVvZJ/ce5AqLAqzHqxrTsu9Q3IiHqSORwxMNVvptOk/EcpN18rkdXoSiav1M35CwhPi0w5ADdAkGo/nXQiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777037994; c=relaxed/simple;
	bh=Tf3xFCkTaVlSBAG8MYtOn+FGgNTU2OHT6GzLUC7419U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F/lsxaW4Z6/1dCKjV3D6ufqcmiKRowZ1ZbSXVOhVsxVasl1fmw4A6PLfcGdDX6rpGhay07P7I/JJVKY/s3hG6ih9DShTTHdjMCE/7dyWR/vLGyIeDgLbh8tDuYYGDl+sT10mqO9uIwi1Lw+9Z98OtdycT1C2eT/jXeDdVMYrwDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tnCETz3o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A99EC2BCB6;
	Fri, 24 Apr 2026 13:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777037993;
	bh=Tf3xFCkTaVlSBAG8MYtOn+FGgNTU2OHT6GzLUC7419U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tnCETz3oLjHbQ9BpagEXsOcB32KJx9JpVZqrEQPK/T0hjjBxnp/IFFFokcrY6lPN7
	 q7U21lVY1VpNwqQPs+Bw2aBC4j4r+340FbIwq+dDGndKC33c29/ALA9l13XvDcAU4s
	 LxBSfu5hZZ9El2ShnvH2ctZ/r7ZdgFnwxHN4Fj5o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bernd Schubert <bschubert@ddn.com>,
	Horst Birthelmer <hbirthelmer@ddn.com>,
	Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 6.6 148/166] fuse: Check for large folio with SPLICE_F_MOVE
Date: Fri, 24 Apr 2026 15:31:02 +0200
Message-ID: <20260424132604.130673069@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424132532.812258529@linuxfoundation.org>
References: <20260424132532.812258529@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3A47045FAF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-240847-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ddn.com:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bernd Schubert <bschubert@ddn.com>

commit 59ba47b6be9cd0146ef9a55c6e32e337e11e7625 upstream.

xfstest generic/074 and generic/075 complain result in kernel
warning messages / page dumps.
This is easily reproducible (on 6.19) with
CONFIG_TRANSPARENT_HUGEPAGE_SHMEM_HUGE_ALWAYS=y
CONFIG_TRANSPARENT_HUGEPAGE_TMPFS_HUGE_ALWAYS=y

This just adds a test for large folios fuse_try_move_folio
with the same page copy fallback, but to avoid the warnings
from fuse_check_folio().

Cc: stable@vger.kernel.org
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/fuse/dev.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -823,6 +823,9 @@ static int fuse_try_move_page(struct fus
 
 	folio_clear_mappedtodisk(newfolio);
 
+	if (folio_test_large(newfolio))
+		goto out_fallback_unlock;
+
 	if (fuse_check_folio(newfolio) != 0)
 		goto out_fallback_unlock;
 



