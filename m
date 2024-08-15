Return-Path: <stable+bounces-68577-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FD6953306
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98BA01C2336A
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D249C1BB6A2;
	Thu, 15 Aug 2024 14:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pmqvp69i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1A11A7056;
	Thu, 15 Aug 2024 14:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723731007; cv=none; b=ChqPFAzuA8I6tk8tcbUyAxD5bdUwHeXBQ5Ulz6fuPn7UrYznkFLILlmz3tdITmH++oRkdKbE5FIEXPvaEg7RXpqBE5p6h/e7IWksoh7u24ER7LHFK1licHUMA3buBoCY6TvTusH1dk1KvjoAngTE2c1lYbri+HAYH/c3q8Dv4rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723731007; c=relaxed/simple;
	bh=So96CqWl6ABd7LPYNN9kKkh2SUcwn+kkmnKanVp09M8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kw809q8cCnKooAIUwj3lh1E8jrDhxq6iiAPJPQvWPCsfhaPsQwSrQ1YH+4Jqa88WRqG2nhDKYWM74ppw+yXgK+G9DaNaGFqy1j9hi3iTwlGDSVBU8JjqsFg4ZGNPjuiEkLh1CU2PZrnXE20HMLQ+/nnBM+du5ZH3t/68QSWKdb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pmqvp69i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B82C32786;
	Thu, 15 Aug 2024 14:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723731007;
	bh=So96CqWl6ABd7LPYNN9kKkh2SUcwn+kkmnKanVp09M8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pmqvp69i35rvpROkWMN5Jht7HyJf9vBvDFSi6pirv2OXPc+wONeM1LCppEn6sgV6N
	 CTsV/0u0+MpOY2pjn3JJc6NZKiOLyeHmjn7jfrf2GRsJVojzbaB3qjpzOju0lDpjYL
	 tPGj0vBPFZU2FpfHx34Ll183sokpbZe15cKgQKlE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: [PATCH 6.6 62/67] Revert "jfs: fix shift-out-of-bounds in dbJoin"
Date: Thu, 15 Aug 2024 15:26:16 +0200
Message-ID: <20240815131840.680592382@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131838.311442229@linuxfoundation.org>
References: <20240815131838.311442229@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Kleikamp <dave.kleikamp@oracle.com>

commit e42e29cc442395d62f1a8963ec2dfb700ba6a5d7 upstream.

This reverts commit cca974daeb6c43ea971f8ceff5a7080d7d49ee30.

The added sanity check is incorrect. BUDMIN is not the wrong value and
is too small.

Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/jfs/jfs_dmap.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -2765,9 +2765,7 @@ static int dbBackSplit(dmtree_t *tp, int
  *	leafno	- the number of the leaf to be updated.
  *	newval	- the new value for the leaf.
  *
- * RETURN VALUES:
- *  0		- success
- *	-EIO	- i/o error
+ * RETURN VALUES: none
  */
 static int dbJoin(dmtree_t *tp, int leafno, int newval, bool is_ctl)
 {
@@ -2794,10 +2792,6 @@ static int dbJoin(dmtree_t *tp, int leaf
 		 * get the buddy size (number of words covered) of
 		 * the new value.
 		 */
-
-		if ((newval - tp->dmt_budmin) > BUDMIN)
-			return -EIO;
-
 		budsz = BUDSIZE(newval, tp->dmt_budmin);
 
 		/* try to join.



