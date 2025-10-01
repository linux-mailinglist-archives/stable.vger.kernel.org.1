Return-Path: <stable+bounces-182961-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58164BB1009
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 17:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3578F4C6B16
	for <lists+stable@lfdr.de>; Wed,  1 Oct 2025 15:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC45748F;
	Wed,  1 Oct 2025 15:04:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A637B1D5CC6;
	Wed,  1 Oct 2025 15:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=58.251.27.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759331092; cv=none; b=ZD2rMBEoHDi1G+gvmf11Efo0lChTOrsvV4yzCygnOFUwyVShHTvOgHmtSb3WAGqvPHD2TTHcD/UzG2fZsI04rvVupcwS1/NsIFeVz8E35cdCiDfKVF7YfKwTjQpzraKxe5Sm78XcUvCMmFbJDSDM4AFR08hT31S6/tcc+qJsLzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759331092; c=relaxed/simple;
	bh=IK4dePlvCveFAFH/EYgvFWzfcjIWISEuQcfZHYuLnXA=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=ER1qkgFsP9s5ZrZHb4sKW+If9A317p2doXNqGgZfViAN1uXTmEDA4nDfE/u4F+HIo6IUXam6HMmNbxKcdHmT7UzlfcrgtavlrX4/9JFbmtGSrllCOjRgidBsIxj4iziwHsuXeUSgweOjqawFJHewAMLJZ7Ul4vOFzge4K//ktoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=58.251.27.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mxde.zte.com.cn (unknown [10.35.20.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4ccJ104W99zVvc;
	Wed, 01 Oct 2025 22:56:52 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxde.zte.com.cn (FangMail) with ESMTPS id 4ccJ0r16mBz5qdvq;
	Wed, 01 Oct 2025 22:56:44 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ccJ0f3XlBz8Xs6y;
	Wed, 01 Oct 2025 22:56:34 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 591EuQFk092290;
	Wed, 1 Oct 2025 22:56:26 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 1 Oct 2025 22:56:27 +0800 (CST)
Date: Wed, 1 Oct 2025 22:56:27 +0800 (CST)
X-Zmail-TransId: 2afa68dd411b2a3-0609f
X-Mailer: Zmail v1.0
Message-ID: <202510012256278259zrhgATlLA2C510DMD3qI@zte.com.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <akpm@linux-foundation.org>, <david@redhat.com>
Cc: <chengming.zhou@linux.dev>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        <tujinjiang@huawei.com>, <shr@devkernel.io>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgMC8yXSBrc206IGZpeCBleGVjL2ZvcmsgaW5oZXJpdGFuY2U=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 591EuQFk092290
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.35.20.165 unknown Wed, 01 Oct 2025 22:56:52 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68DD4133.000/4ccJ104W99zVvc

From: xu xin <xu.xin16@zte.com.cn>

This series aim to fix exec/fork inheritance and introduce ksm-utils tools
including ksm-set and ksm-get, you can see the detail in PATCH 1.

Problem
=======
In some extreme scenarios, however, this inheritance of MMF_VM_MERGE_ANY during
exec/fork can fail. For example, when the scanning frequency of ksmd is tuned
extremely high, a process carrying MMF_VM_MERGE_ANY may still fail to pass it to
the newly exec'd process. This happens because ksm_execve() is executed too early
in the do_execve flow (prematurely adding the new mm_struct to the ksm_mm_slot list).

As a result, before do_execve completes, ksmd may have already performed a scan and
found that this new mm_struct has no VM_MERGEABLE VMAs, thus clearing its
MMF_VM_MERGE_ANY flag. Consequently, when the new program executes, the flag
MMF_VM_MERGE_ANY inheritance fails!

Reproduce
========
Prepare ksm-utils in the prerequisite PATCH, and simply do as follows

echo 1 > /sys/kernel/mm/ksm/run;
echo 2000 > /sys/kernel/mm/ksm/pages_to_scan;
echo 0 > /sys/kernel/mm/ksm/sleep_millisecs;
ksm-set -s on [NEW_PROGRAM_BIN] &
ksm-get -a -e

you can see like this:
Pid         Comm                Merging_pages  Ksm_zero_pages    Ksm_profit     Ksm_mergeable     Ksm_merge_any
206         NEW_PROGRAM_BIN     7680           0                 30965760       yes               no

Note:
If the first time don't reproduce the issue, pkill NEW_PROGRAM_BIN and try run it
again. Usually, we can reproduce it in 5 times.

Root reason
===========
The commit d7597f59d1d33 ("mm: add new api to enable ksm per process") clear the
flag MMF_VM_MERGE_ANY when ksmd found no VM_MERGEABLE VMAs.

xu xin (2):
  tools: add ksm-utils tools
  mm/ksm: fix exec/fork inheritance support for prctl

 mm/ksm.c                     |   8 +-
 tools/mm/Makefile            |  12 +-
 tools/mm/ksm-utils/Makefile  |  10 +
 tools/mm/ksm-utils/ksm-get.c | 397 +++++++++++++++++++++++++++++++++++
 tools/mm/ksm-utils/ksm-set.c | 144 +++++++++++++
 5 files changed, 567 insertions(+), 4 deletions(-)
 create mode 100644 tools/mm/ksm-utils/Makefile
 create mode 100644 tools/mm/ksm-utils/ksm-get.c
 create mode 100644 tools/mm/ksm-utils/ksm-set.c

-- 
2.25.1

