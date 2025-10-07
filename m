Return-Path: <stable+bounces-183525-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A73B2BC1017
	for <lists+stable@lfdr.de>; Tue, 07 Oct 2025 12:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 54C6534DCC1
	for <lists+stable@lfdr.de>; Tue,  7 Oct 2025 10:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E832D7DCF;
	Tue,  7 Oct 2025 10:25:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B556528F4;
	Tue,  7 Oct 2025 10:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759832721; cv=none; b=PClxTkjikDT1Z9IFU+wUBQWpaHnAjqmx5X2thJjqd9qqiehc2OJZroCNaRCUIhezQWSAFCjZU+S8ltQdZHGO0K54/ohytPWefmkFWL7PMcSDaIcn1NfqpMMjVrkef3qbcb9GltpoSHxbx+dyaMKGJCKhEk1I9GjMgRmlYSYVAwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759832721; c=relaxed/simple;
	bh=LxBylTd1fLT79qZsOxEUlK94268VpIa18MipaqAfrHY=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=st8COQLEsCeW8pbURUafQjvJrqER5LpoUkUDewfUow+2slXDYvTsSxez4GTqqHLG0ZUPSaHTaO1+Nm7nAjSvUxB1FdwsPjRhM6LQvZB3B2TcDqwoQp0qULUgIpgtQSurLhM9c0CTHIXY0th64u7Vn/SmK7BSvrzNBPb+ZH456Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4cgshh70f2z8Xs6v;
	Tue, 07 Oct 2025 18:25:08 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 597AP1N5014420;
	Tue, 7 Oct 2025 18:25:01 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 7 Oct 2025 18:25:04 +0800 (CST)
Date: Tue, 7 Oct 2025 18:25:04 +0800 (CST)
X-Zmail-TransId: 2afb68e4ea80563-5fb0d
X-Mailer: Zmail v1.0
Message-ID: <20251007182504440BJgK8VXRHh8TD7IGSUIY4@zte.com.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <akpm@linux-foundation.org>, <david@redhat.com>, <tujinjiang@huawei.com>,
        <shr@devkernel.io>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, <yang.yang29@zte.com.cn>,
        <wang.yaxin@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgdjIgMC8yXSBrc206IGZpeCBleGVjL2ZvcmsgaW5oZXJpdGFuY2U=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 597AP1N5014420
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Tue, 07 Oct 2025 18:25:08 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68E4EA84.000/4cgshh70f2z8Xs6v

From: xu xin <xu.xin16@zte.com.cn>

This series aim to fix exec/fork inheritance. See the detailed description
of issue at the following patch.

PATCH 1: the patch to fix the issue.
PATCH 2: a reproduce program or testcase.

xu xin (2):
  mm/ksm: fix exec/fork inheritance support for prctl
  selftests: update ksm inheritation tests for prctl fork/exec

 include/linux/ksm.h                           |  4 +-
 mm/ksm.c                                      | 20 ++++++-
 .../selftests/mm/ksm_functional_tests.c       | 57 +++++++++++++++++++
 3 files changed, 76 insertions(+), 5 deletions(-)

-- 
2.25.1

