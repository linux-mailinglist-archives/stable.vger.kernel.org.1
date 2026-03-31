Return-Path: <stable+bounces-231615-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMv+Fs/3y2kXNAYAu9opvQ
	(envelope-from <stable+bounces-231615-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:35:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEB336CCE2
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 663F63001027
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A652A423A9A;
	Tue, 31 Mar 2026 16:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SiQYDlqK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F90423A62;
	Tue, 31 Mar 2026 16:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774974628; cv=none; b=UnvFBe+Y8oqHCZVOTvuz/sVnIwGB0JJWaFd++6Jf0sexiYzbTDiUzD5KiDH2ZiO89fQehzKVQP6iDV6UvS44KY9SEr1mc0ARv/b7kLmQ9F0Ie4zDtSu0kQ0uHv7UHjnQtqt1yQG5Ma0tjrnmgbwh3h4dvDO5kWhkBOT0KQIPuv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774974628; c=relaxed/simple;
	bh=4SIEReAFAXG7WhY9hHWHUsG2RM4JRbqWZ3hBXx8ldDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T70ttoqbKoyupQGmLu2vUDkt+gRvMOHcwTXTepbVcsXNidq9tdfAsEWcH1wed1t38bUim5le1lPVje0nbgQZ7Ge1VEOYeJTeZih5cxVT6hWCIRSi7QNmpLxm1jsr51Q5x7uNPrynvYU7jnIzQA274rUARaz1Q9WkJlYsa5WVYLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SiQYDlqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F267FC19423;
	Tue, 31 Mar 2026 16:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774974628;
	bh=4SIEReAFAXG7WhY9hHWHUsG2RM4JRbqWZ3hBXx8ldDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SiQYDlqK0sX/vIa5hL9CSPLFY8PXw3zRgMnczQFei9CHfct31NyFZzvl21n1jDJFs
	 08YNrCx5T7dL1JboRwDZGsVJ4nz6i6yZpXlIYaCbdZdgSH0pKOWs5yT9rQo808TfqN
	 MeqWXgTFjkWO9x47nXhGDglEUpGtW4NJA4hlO2ow=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	syzbot+b6353e35ae2bab997538@syzkaller.appspotmail.com
Subject: [PATCH 6.6 159/175] erofs: fix "BUG: Bad page state in z_erofs_do_read_page"
Date: Tue, 31 Mar 2026 18:22:23 +0200
Message-ID: <20260331161735.639737707@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161729.779738837@linuxfoundation.org>
References: <20260331161729.779738837@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231615-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,b6353e35ae2bab997538];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,appspotmail.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 2BEB336CCE2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gao Xiang <hsiangkao@linux.alibaba.com>

It's actually a stable-only issue from backporting 9e2f9d34dd12
("erofs: handle overlapped pclusters out of crafted images properly")

We missed to update `oldpage` after `pcl->compressed_bvecs[nr].page`
is updated, so that the following cmpxchg() will fail; the original
upstream commit doesn't behave like this due to new features and
refactoring.

This backport issue only impacts some specific crafted images and
normal filesystems won't be impacted at all.

Fixes: 1bf7e414cac3 ("erofs: handle overlapped pclusters out of crafted images properly") # 6.6.y
Closes: https://syzkaller.appspot.com/bug?extid=b6353e35ae2bab997538
Reported-and-tested-by: syzbot+b6353e35ae2bab997538@syzkaller.appspotmail.com [1]
[1] https://lore.kernel.org/r/69c3b299.a70a0220.234938.004b.GAE@google.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/erofs/zdata.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1503,6 +1503,7 @@ repeat:
 	lock_page(page);
 	if (likely(page->mapping == mc)) {
 		WRITE_ONCE(pcl->compressed_bvecs[nr].page, page);
+		oldpage = page;
 
 		/*
 		 * The cached folio is still in managed cache but without



