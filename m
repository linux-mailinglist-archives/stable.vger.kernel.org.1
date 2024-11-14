Return-Path: <stable+bounces-93061-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4363B9C948B
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 22:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED68F1F23270
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 21:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5071AE01F;
	Thu, 14 Nov 2024 21:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="ehs8GPj0"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45A24CB36
	for <stable@vger.kernel.org>; Thu, 14 Nov 2024 21:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731619682; cv=none; b=jP7TXlyozN9rr30FcQBNy5GnYzmyrUMbCWODRwQxrDNoSD6zAezQrMobwceThN88Fj1W8qvyJkm/YtJy5iiw2IY4Vy4jiXoOlHnozTkGs1TV1DVmaKcKRwrldYAJeB0RcLZOGRXR3SJNYVQXlrZNKKjeVxWYeRgUtQue800PDAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731619682; c=relaxed/simple;
	bh=8qa8VhUy4JwdANQm710i5NHHViWW8Z/sPE+0XBglVJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f+y+zXXpI50jIeV9D/ZwLgRuqTvjBFLqAfScKEB0G/OgbZfFwwqgLqrUYKD9Sm+d0Urj2VO9CGSnrvr2OW86B0E1Q7MbUb9gy+N/zlstUjCLw0H55sWHdvB53h2lgEBId7sgmSUsx8SE0GF0xRROzmnaUsAeAORNE5/9YwHWpMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=ehs8GPj0; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4XqCtG3kRlz9smq;
	Thu, 14 Nov 2024 22:27:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1731619670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n61mPYpvwirpr1tMoKxBaqoO5Wd9PhuWV73HURKQn7U=;
	b=ehs8GPj0ImILt6VLNv8rVchk9R0H1lj0M71Tnu7+wMpVbGe3NhlGXrD9Biwh5YBZ1n5XLS
	HqFyP82JyK756PSCkWLQXRRGOXBGxTXFUMufeSCpI40guLm2mkbAiHWD5UGEm1W4CH/cSZ
	I79FpvfsTRARuD3JK3VvaFutgb24r9u3U4R2wVVRuV2BphAngnYiUX7IRnaVNZTxLOwc9f
	1vNv5vqlHjVtTkR+JWLxZp3n7JX4AqTF9xwsZt5+tt7T9RQZRGsoRBvkAmMR7k+RteQbzS
	4/pYhSRDmdG6jsPrRDmiaIH90Ma7Pzd+aIk239FKFrwoMIJriXtGo+5vTVlsiA==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: stable@vger.kernel.org
Cc: jack@suse.com,
	gregkh@linuxfoundation.org,
	Jan Kara <jack@suse.cz>,
	syzbot+111eaa994ff74f8d440f@syzkaller.appspotmail.com,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH stable 5.15 2/2] udf: Avoid directory type conversion failure due to ENOMEM
Date: Thu, 14 Nov 2024 22:26:57 +0100
Message-ID: <20241114212657.306989-3-hauke@hauke-m.de>
In-Reply-To: <20241114212657.306989-1-hauke@hauke-m.de>
References: <20241114212657.306989-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4XqCtG3kRlz9smq

From: Jan Kara <jack@suse.cz>

commit df97f64dfa317a5485daf247b6c043a584ef95f9 upstream.

When converting directory from in-ICB to normal format, the last
iteration through the directory fixing up directory enteries can fail
due to ENOMEM. We do not expect this iteration to fail since the
directory is already verified to be correct and it is difficult to undo
the conversion at this point. So just use GFP_NOFAIL to make sure the
small allocation cannot fail.

Reported-by: syzbot+111eaa994ff74f8d440f@syzkaller.appspotmail.com
Fixes: 0aba4860b0d0 ("udf: Allocate name buffer in directory iterator on heap")
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 fs/udf/directory.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/udf/directory.c b/fs/udf/directory.c
index a30898debdd1..4f6c7b546bea 100644
--- a/fs/udf/directory.c
+++ b/fs/udf/directory.c
@@ -249,9 +249,12 @@ int udf_fiiter_init(struct udf_fileident_iter *iter, struct inode *dir,
 	iter->elen = 0;
 	iter->epos.bh = NULL;
 	iter->name = NULL;
-	iter->namebuf = kmalloc(UDF_NAME_LEN_CS0, GFP_KERNEL);
-	if (!iter->namebuf)
-		return -ENOMEM;
+	/*
+	 * When directory is verified, we don't expect directory iteration to
+	 * fail and it can be difficult to undo without corrupting filesystem.
+	 * So just do not allow memory allocation failures here.
+	 */
+	iter->namebuf = kmalloc(UDF_NAME_LEN_CS0, GFP_KERNEL | __GFP_NOFAIL);
 
 	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {
 		err = udf_copy_fi(iter);
-- 
2.47.0


