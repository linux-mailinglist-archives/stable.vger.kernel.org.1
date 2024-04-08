Return-Path: <stable+bounces-36783-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D1F89C1A4
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB06E1F21518
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C532C7FBC7;
	Mon,  8 Apr 2024 13:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pTva/uBE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845AF7F467;
	Mon,  8 Apr 2024 13:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712582331; cv=none; b=XY0J2BM4u5hSqfPE2v3H7uhCpPAWpZnCI6xa5aIAuDUVj2WLvCLgriufp8KeLYNOXQgzVOVBb8BLHnii3ylpSKrZdXW1M2zsTXKVtSIvU5DWOZcJZ7R0UojGGdu4YY60JTFKqoECuzOQVp7sdhYqx1I0bk+tuc1UqUFoO46oVbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712582331; c=relaxed/simple;
	bh=73GGUbSHqDQ4tRKo31QjhEr6sUAtBxlmZnTXNMvWeRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yr5+I3q9SFd1Hro/peiSdORuzpyECaHfTv7LcmW/+6ZoyD3wvQf2iu+8JTzOqtXuXsxIE6nXTGHOwjE2RlIKNk81xWMPHltc4cf9ibo+GtBHIdPsmO06/ajZs2TRiFu+82qlMddvDIPIfBbiXhxP82nMJGnsAJJZfLklywOdPbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pTva/uBE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E72BC433C7;
	Mon,  8 Apr 2024 13:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712582331;
	bh=73GGUbSHqDQ4tRKo31QjhEr6sUAtBxlmZnTXNMvWeRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pTva/uBEaT0FEIKu/07vV/tdYRYCFAqYLejOA18KCKcf1UhVm024zhSr5JhPVPwM0
	 nd5vSSvH6+YhmtsIlIBUkvCeMVGdag/0HI5blSBxonD0LO6jq8ApeliBDOi8NZ+Zkv
	 EENdt0DA1QrsXr5XohZchYZqeqKJ5wb6qgkWzJEk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nicolas Pitre <nico@fluxnic.net>,
	stable <stable@kernel.org>
Subject: [PATCH 5.15 133/690] vt: fix unicode buffer corruption when deleting characters
Date: Mon,  8 Apr 2024 14:49:59 +0200
Message-ID: <20240408125404.348549101@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125359.506372836@linuxfoundation.org>
References: <20240408125359.506372836@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolas Pitre <nico@fluxnic.net>

commit 1581dafaf0d34bc9c428a794a22110d7046d186d upstream.

This is the same issue that was fixed for the VGA text buffer in commit
39cdb68c64d8 ("vt: fix memory overlapping when deleting chars in the
buffer"). The cure is also the same i.e. replace memcpy() with memmove()
due to the overlaping buffers.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
Fixes: 81732c3b2fed ("tty vt: Fix line garbage in virtual console on command line edition")
Cc: stable <stable@kernel.org>
Link: https://lore.kernel.org/r/sn184on2-3p0q-0qrq-0218-895349s4753o@syhkavp.arg
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/vt/vt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -398,7 +398,7 @@ static void vc_uniscr_delete(struct vc_d
 		char32_t *ln = uniscr->lines[vc->state.y];
 		unsigned int x = vc->state.x, cols = vc->vc_cols;
 
-		memcpy(&ln[x], &ln[x + nr], (cols - x - nr) * sizeof(*ln));
+		memmove(&ln[x], &ln[x + nr], (cols - x - nr) * sizeof(*ln));
 		memset32(&ln[cols - nr], ' ', nr);
 	}
 }



