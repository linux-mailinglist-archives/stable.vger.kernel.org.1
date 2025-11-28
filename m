Return-Path: <stable+bounces-197573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC656C9171C
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 10:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 59D4C3475F5
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 09:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357EA30217C;
	Fri, 28 Nov 2025 09:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="VUNq3cL9"
X-Original-To: stable@vger.kernel.org
Received: from n169-110.mail.139.com (n169-110.mail.139.com [120.232.169.110])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA14302176
	for <stable@vger.kernel.org>; Fri, 28 Nov 2025 09:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764322194; cv=none; b=AzpB2B95Ak6mBAE+2dqs7bOJVxBIJCXQPTqS+xBbcs9QLpnz6nDuOAAdpTUCgO0NfAOhXjgEN1/h2LwuvCJaHnJ/OdSWXzirt/8+Fn5kWLCCig8rcGLMYcZHLPRCeg3CL6X7bqZyBa2W2/I/2mE7o0g2z5dZ/OmMiYv+IgZSPwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764322194; c=relaxed/simple;
	bh=z5aE0qsW/9SGur5FsCBCzQV+oxyGC9GojohWDeMT3A8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Xj41mAf+GbrTJJ39LPzAsde8LDKGDmskk7U6T6ei+j2kcOFYOgjIe7PoYpPvO5KzYAVDVjGVOc62w9zdl9/eCY7rUo0zX40qa31al2/nyI2fG10iKeCN6YLo4o9es1QucXnIMPjxh2AFgqc8RJJuP3E3OmT/Q/Cr0MAbCmpOBEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=VUNq3cL9; arc=none smtp.client-ip=120.232.169.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=VUNq3cL9OQh4GLT5GPn4CKYTBkdPRicYqzjvRKhxK1tq92U5ZwukxipgZ7w/CpYxn/GNtSdrikWqL
	 m9Fb/roDFyBGpQeR/+sj+VjDwjuV0lSaaPa0nHpVaDwlr1CKAtLIRFQoQA36qUrGUXoZ8jeVpTpXcp
	 BVRTOa2zqRCIlVdE=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[183.241.245.185])
	by rmsmtp-lg-appmail-08-12086 (RichMail) with SMTP id 2f3669296ac0696-1277d;
	Fri, 28 Nov 2025 17:26:26 +0800 (CST)
X-RM-TRANSID:2f3669296ac0696-1277d
From: Rajani Kantha <681739313@139.com>
To: razor@blackwall.org,
	toke@redhat.com,
	liuhangbin@gmail.com,
	kuba@kernel.org,
	wangliang74@huawei.com,
	joamaki@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH 6.6 0/2] Backport 2 commits to 6.12.y to fix bond issue
Date: Fri, 28 Nov 2025 17:26:16 +0800
Message-Id: <20251128092618.1861-1-681739313@139.com>
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
mode") to 6.6.y to fix a bond issue.

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



