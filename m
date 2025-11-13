Return-Path: <stable+bounces-194673-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C73C56BA0
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 10:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 173F34E2CF3
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 09:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336332DF71D;
	Thu, 13 Nov 2025 09:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="Sr/RhrsC"
X-Original-To: stable@vger.kernel.org
Received: from n169-114.mail.139.com (n169-114.mail.139.com [120.232.169.114])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07AD2DF707
	for <stable@vger.kernel.org>; Thu, 13 Nov 2025 09:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763027940; cv=none; b=M7eWGWNxmfPXuCd4PpYQKOJexTC+DBP2pXuL5F/UDVv2NtK6Q4zQM9E9YEUx2cL+iZ2k1r2lDk/K9uLBLXEC1m0K1W6wILZUNMctcxxTAUGrXceVS1viOS6XbwT0z5ZZV8KcmPaIuWvSw4xSVaXoglS71WgWDYdTPQjyetD2doU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763027940; c=relaxed/simple;
	bh=2muTn9cewC/+BcZ7tPhF0/rkiZSGN7J07GDdbFpLQ7I=;
	h=From:To:Subject:Date:Message-Id; b=HSchoEEW66CGQ88TiQPF0CuOQomuC52GcWtuICmMWLw5+Z10sMdkVQ4yPlwk74HB1P4tcdu2i1C3vE6T46LiBQHbXxqL/A5dRCI7GBnNkoycJupvplzD+M+uTqeY1ywo6gJU2hrLRCsI8l4CMgSezWthVeubGR5NZU7oARZBpZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=Sr/RhrsC; arc=none smtp.client-ip=120.232.169.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=Sr/RhrsCbAxJpeNQpjSuS0av4Q0TCech3VtFnfrRe6ae3zejTOhx6YPZOjAb1Ed4u5DZj4kqSpg3U
	 pF9LyJzfPIxkmBljU8QybVscevxPNGeTez9kL/7u4H1V5OdDqVx6kBjaXRcid0UxdcMrk7ySWRWeGy
	 uk3DcshyWUlAHAGk=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[117.129.7.61])
	by rmsmtp-lg-appmail-39-12053 (RichMail) with SMTP id 2f156915ab1e329-30548;
	Thu, 13 Nov 2025 17:55:44 +0800 (CST)
X-RM-TRANSID:2f156915ab1e329-30548
From: Rajani Kantha <681739313@139.com>
To: yebin10@huawei.com,
	jack@suse.cz,
	tytso@mit.edu,
	stable@vger.kernel.org
Subject: [PATCH 6.12.y 0/2] Backport 2 commits to 6.12.y to fix
Date: Thu, 13 Nov 2025 17:55:35 +0800
Message-Id: <20251113095537.1831-1-681739313@139.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Backport commit:5701875f9609 ("ext4: fix out-of-bound read in
ext4_xattr_inode_dec_ref_all()" to linux 6.12 branch.
The fix depends on commit:69f3a3039b0d ("ext4: introduce ITAIL helper")
In order to make a clean backport on stable kernel, backport 2 commits.

Ye Bin (2):
  ext4: introduce ITAIL helper
  ext4: fix out-of-bound read in ext4_xattr_inode_dec_ref_all()

 fs/ext4/inode.c |  5 +++++
 fs/ext4/xattr.c | 32 ++++----------------------------
 fs/ext4/xattr.h | 10 ++++++++++
 3 files changed, 19 insertions(+), 28 deletions(-)

-- 
2.17.1



