Return-Path: <stable+bounces-158837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01779AECC98
	for <lists+stable@lfdr.de>; Sun, 29 Jun 2025 14:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 481413A426B
	for <lists+stable@lfdr.de>; Sun, 29 Jun 2025 12:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4811E32A3;
	Sun, 29 Jun 2025 12:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u3ovUHCE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A30113957E
	for <stable@vger.kernel.org>; Sun, 29 Jun 2025 12:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751200915; cv=none; b=OCmA2H2NPLcBVnDjOZdDN7tJnOjUtLX22g4yDE+d03U4dp2XgvasXG681jZ+djyTs943FnvBuGNcbmAd3KH30fpc2/U46vaPot94bzCeltqVXwwPBK0t3DPcAg2uBcWrB6PkBtUzD5tKJsovoEOfU4qW3bYg5R5BpNy0FbA98NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751200915; c=relaxed/simple;
	bh=jQKVj7Z2WcuxiG3XmqNYbH6mHxQ3guDirt6ub2RqsUM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bkFd/OtiPRUzIK0G469M735xoBVFS5tu30uqIk6Fn2tyXD5Jl9POpQUreicRHvnqqlVHjpACmDPJpyz+RVYKtlss1J72fGe8TaJy2XI7pl76B2D7q+BDA/CR+6IK2NRAfHAdn5zNGsMHKBUAQg0w5UCW9j9D+Rdr7nfxqAdUHK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u3ovUHCE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37AAAC4CEEB;
	Sun, 29 Jun 2025 12:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751200914;
	bh=jQKVj7Z2WcuxiG3XmqNYbH6mHxQ3guDirt6ub2RqsUM=;
	h=Subject:To:Cc:From:Date:From;
	b=u3ovUHCEhVohkqolDfYOyfqRc/i9E5URr69HmV8i+dPaRL9j0IhVYBCn7x2Al4cNK
	 5xE4NA3siyPhWsgfpXib+xeZU3wx6f3irrJjsGqU4x5A4Ol/+6lkzS0MlACEWIdrfh
	 jRZnGTg4Ld3/kKYFYns7509tmjQacySyWIYvKsek=
Subject: FAILED: patch "[PATCH] s390/pkey: Prevent overflow in size calculation for" failed to apply to 5.4-stable tree
To: pchelkin@ispras.ru,agordeev@linux.ibm.com,dengler@linux.ibm.com,hca@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 29 Jun 2025 14:41:06 +0200
Message-ID: <2025062906-tightwad-overvalue-2006@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 7360ee47599af91a1d5f4e74d635d9408a54e489
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062906-tightwad-overvalue-2006@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7360ee47599af91a1d5f4e74d635d9408a54e489 Mon Sep 17 00:00:00 2001
From: Fedor Pchelkin <pchelkin@ispras.ru>
Date: Wed, 11 Jun 2025 22:20:10 +0300
Subject: [PATCH] s390/pkey: Prevent overflow in size calculation for
 memdup_user()

Number of apqn target list entries contained in 'nr_apqns' variable is
determined by userspace via an ioctl call so the result of the product in
calculation of size passed to memdup_user() may overflow.

In this case the actual size of the allocated area and the value
describing it won't be in sync leading to various types of unpredictable
behaviour later.

Use a proper memdup_array_user() helper which returns an error if an
overflow is detected. Note that it is different from when nr_apqns is
initially zero - that case is considered valid and should be handled in
subsequent pkey_handler implementations.

Found by Linux Verification Center (linuxtesting.org).

Fixes: f2bbc96e7cfa ("s390/pkey: add CCA AES cipher key support")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Link: https://lore.kernel.org/r/20250611192011.206057-1-pchelkin@ispras.ru
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>

diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
index cef60770f68b..b3fcdcae379e 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -86,7 +86,7 @@ static void *_copy_apqns_from_user(void __user *uapqns, size_t nr_apqns)
 	if (!uapqns || nr_apqns == 0)
 		return NULL;
 
-	return memdup_user(uapqns, nr_apqns * sizeof(struct pkey_apqn));
+	return memdup_array_user(uapqns, nr_apqns, sizeof(struct pkey_apqn));
 }
 
 static int pkey_ioctl_genseck(struct pkey_genseck __user *ugs)


