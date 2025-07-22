Return-Path: <stable+bounces-163682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FCBB0D6BC
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 12:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9957AA0158
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 10:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58BB2E1742;
	Tue, 22 Jul 2025 10:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HGsR0Kc5"
X-Original-To: stable@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B593228A718;
	Tue, 22 Jul 2025 10:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753178442; cv=none; b=UB1nQwN62Dqu64hXSuxdB4GDyzqVNn1FpvGwtmNQQNthL+jkCcIozd4eCELlq4gByViRCjC8IsMzWqqfCm8wCDZs81IN/Tj3NJWfI1SMrVg488yMSWiDF7kH6tAdp5WW+05Bj25YeegzPc634k+Hm+fKM9OArz7aGilIiV0bZQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753178442; c=relaxed/simple;
	bh=tZ3HcF1s0zrmlCAeX9Whnel/rxThk9/kOf1hXEkLx4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fYVM1BYAuD6SHBDA8eujS5pBnW2GEZLDpYUedNLYs8ABFjim8ea8exWTgtNEsErSGCVsNJVynNtIr6OKM0yHVp5BjF/s1zJHe2WyT4cB4qDeTPUVBgmlu8LHQ2PcscI6mE30Qw3RIakGfUU3Ii75Ijo85RwExM9BI1M6bQyEetY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HGsR0Kc5; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753178435; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=lPjat0Bi98OfxfxyAaI3NTYf7rjxuzInugrh9ayiTI0=;
	b=HGsR0Kc5evxmMWn6nyp9vQFGxcQjJ0Edqc8R4o+my80mosqvigaQsXy+pRVVp4uHoXf19Gs7FL9nUVnZfQAdjmkksx07Oe7MvGVHUNU47XytuUmqaxwda8ysIBc6xKI/sVWiMVgtEZRerLIyursGXK4JuImg2NtFrkLoRD0mPCI=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WjVvTmr_1753178430 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 22 Jul 2025 18:00:35 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Stefan Kerkmann <s.kerkmann@pengutronix.de>
Cc: linux-erofs@lists.ozlabs.org,
	LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 6.1.y 0/5] erofs: backport for `erofs: address D-cache aliasing`
Date: Tue, 22 Jul 2025 18:00:24 +0800
Message-ID: <20250722100029.3052177-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6.y fix: https://lore.kernel.org/r/20250722094449.2950654-1-hsiangkao@linux.alibaba.com

Hi Jan & Stefan,
Please help confirm this 6.1 fix backport if possible too.

Thanks,
Gao Xiang

Gao Xiang (5):
  erofs: get rid of debug_one_dentry()
  erofs: sunset erofs_dbg()
  erofs: drop z_erofs_page_mark_eio()
  erofs: simplify z_erofs_transform_plain()
  erofs: address D-cache aliasing

 fs/erofs/decompressor.c | 23 +++++++----------
 fs/erofs/dir.c          | 17 -------------
 fs/erofs/inode.c        |  3 ---
 fs/erofs/internal.h     |  2 --
 fs/erofs/namei.c        |  9 +++----
 fs/erofs/zdata.c        | 56 +++++++++++++++++------------------------
 fs/erofs/zmap.c         |  3 ---
 7 files changed, 35 insertions(+), 78 deletions(-)

-- 
2.43.5


