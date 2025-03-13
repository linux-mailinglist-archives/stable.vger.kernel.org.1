Return-Path: <stable+bounces-124215-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F233A5ED68
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 08:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62D867A55F5
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 07:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E1E25FA2F;
	Thu, 13 Mar 2025 07:55:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B81325F992;
	Thu, 13 Mar 2025 07:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741852558; cv=none; b=J23rJAwYa4qe5rMqyFE4xCYMVSxy1G0voSkm16RB3LYI6NprTiEUl8B2+dRS4PFiMk+Ph9w5aDLJo3p6uwu7qqzHNbZr1cKQLB30b2fP99hoFgEaIX+Ni9pRN4vLBCf9UcjH+fHnAVXNMUFnVdepAaJZvI5g4M7A8904iEZTeSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741852558; c=relaxed/simple;
	bh=Y3qveP2BwZANo6YXOBo9JwpsWcPy0YeXkf1x0BfzsF8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D+O3LhDsqkHTpGYQYVSQDdvtPPMjkH0tOsEA+jx5jdkJWuezvRF8DHdee23CwPebtOTRbN3sbTMJ4j02Igii4lJlmcsJZ2V7GZD3XH79Gul47S/f+iS+/mr9U0aJh8Zrd2gc7KvOI3wHbNo7b3lkYsh8EkzMwc3RhWaA4btXViQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-03 (Coremail) with SMTP id rQCowACnrg5xj9JnokbUFA--.3019S2;
	Thu, 13 Mar 2025 15:55:36 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jdamato@fastly.com,
	aleksander.lobakin@intel.com,
	make24@iscas.ac.cn,
	quic_zijuhu@quicinc.com,
	andriy.shevchenko@linux.intel.com,
	wanghai26@huawei.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] net-sysfs: fix error handling in netdev_register_kobject()
Date: Thu, 13 Mar 2025 15:55:28 +0800
Message-Id: <20250313075528.306019-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACnrg5xj9JnokbUFA--.3019S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GF13GrWUGF4kuFW8CF1xZrb_yoWDJFc_Gr
	10va4Uuw1kJanakw43AanYvr1kJrnrJrWfGrW7tF4kJ345XFZ2qrs5WrWFyr17Ca9ruF1D
	AF17J3yUGw4fWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbSkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28Icx
	kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU122NtUUUUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

Once device_add() failed, we should call put_device() to decrement
reference count for cleanup. Or it could cause memory leak.

As comment of device_add() says, 'if device_add() succeeds, you should
call device_del() when you want to get rid of it. If device_add() has
not succeeded, use only put_device() to drop the reference count'.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 8ed633b9baf9 ("Revert "net-sysfs: Fix memory leak in netdev_register_kobject"")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 net/core/net-sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 07cb99b114bd..f443eacc9237 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -2169,6 +2169,7 @@ int netdev_register_kobject(struct net_device *ndev)
 
 	error = device_add(dev);
 	if (error)
+		put_device(dev);
 		return error;
 
 	error = register_queue_kobjects(ndev);
-- 
2.25.1


