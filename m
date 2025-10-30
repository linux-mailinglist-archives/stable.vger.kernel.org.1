Return-Path: <stable+bounces-191693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8710EC1EA82
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 08:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 542684E7132
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 07:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7D3204F93;
	Thu, 30 Oct 2025 07:00:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from n169-110.mail.139.com (n169-110.mail.139.com [120.232.169.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CB62D3218
	for <stable@vger.kernel.org>; Thu, 30 Oct 2025 07:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761807614; cv=none; b=Km0l1kfYWr6trot5KPxJWrMU8KIEmw7iO182Z2lPBNJqhW4geZq/dMKs9o6cM/TLwY7+4JP8Qbu5EAz031DosHk99I2jinfVe1D5z/Q/kuxCOKkPzeL0yahTqc6iCFxL1qUbOz5LNHx9MvR+tYpdjH5j6iEbe0lz44zwgOmoOu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761807614; c=relaxed/simple;
	bh=wFOutg9/Iewcx6HIe8yiwsXfOWobAu/HsJ4CZHOR5sA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=nWtmBe9x+vGOC9RnPia9TWokR3BGt6aL6ib47q+WZmFDbXjXQvuPPk+wG8lk+ye8NSJLmoWgQ8bDHKiHNurACfLvqG/8VzoHeCFV93UAWUlD0RHsuLGmqBVBzM4T0XmjNBivf+aaslRU4o/odEWKv/1E6cL/Y4chotGx9fdS7oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; arc=none smtp.client-ip=120.232.169.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[117.129.7.61])
	by rmsmtp-lg-appmail-01-12079 (RichMail) with SMTP id 2f2f69030cef717-4dea1;
	Thu, 30 Oct 2025 15:00:00 +0800 (CST)
X-RM-TRANSID:2f2f69030cef717-4dea1
From: Rajani Kantha <681739313@139.com>
To: razor@blackwall.org,
	toke@redhat.com,
	liuhangbin@gmail.com,
	kuba@kernel.org,
	joamaki@gmail.com,
	wangliang74@huawei.com,
	stable@vger.kernel.org
Subject: [PATCH 6.12.y 0/2] Backport 2 commits to 6.12.y to fix bond issue
Date: Thu, 30 Oct 2025 14:59:57 +0800
Message-Id: <20251030065959.8773-1-681739313@139.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Backport commit: 094ee6017ea0 ("bonding: check xdp prog when set bond
mode") to 6.12.y to fix a bond issue.

It depends on commit: 22ccb684c1ca ("bonding: return detailed
error when loading native XDP fails)

In order to make a clean backport on stable kernel, backport 2 commits.


Hangbin Liu (1):
  bonding: return detailed error when loading native XDP fails

Wang Liang (1):
  bonding: check xdp prog when set bond mode

 drivers/net/bonding/bond_main.c    | 11 +++++++----
 drivers/net/bonding/bond_options.c |  3 +++
 include/net/bonding.h              |  1 +
 3 files changed, 11 insertions(+), 4 deletions(-)

-- 
2.17.1



