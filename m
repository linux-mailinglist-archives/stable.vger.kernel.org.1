Return-Path: <stable+bounces-18479-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4D58482E3
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD77128C35C
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907934F213;
	Sat,  3 Feb 2024 04:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ilqzm8ig"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA634EB46;
	Sat,  3 Feb 2024 04:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933829; cv=none; b=E+vPBGsHAE95il9ZB7l+sdl9VmqSFnY3UYgao32g2SYBTv1aJiKDdf6fEF+BKxeCI+0kVpsaO2cgih1CgduMy+ui6Yam1gFhym9pbAjs55O5PNPHlyTDkZ5DfJbk1uZon6z8DXsXjz9zqLWehjAtj+0Ejz9Jl/NNrf4tmNj7fKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933829; c=relaxed/simple;
	bh=Obph4iLtyU20x0/xUgeCKIUcUOHHEwkxka2bCj/+mas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BnjEhs8z38mrmNLC5RhuAcE1h1MKJWnmNYXXk/y6RskCUuR9pCEloVrmdyy3vM2ACTUO5Ex+f92aOcv9sN0fdlF+xbQg9DKMalUcksnCACRNEUle1zKZvT54hnYWOa9JHs+vIlC7IzQYLLKE30Ipumk62F/jqHMjIFrY+rRDwPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ilqzm8ig; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9A7C43390;
	Sat,  3 Feb 2024 04:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933829;
	bh=Obph4iLtyU20x0/xUgeCKIUcUOHHEwkxka2bCj/+mas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ilqzm8igV0OUUNeVcWsbs+DNCxnhSc8LWhu5qqij1cBSJN5SlOHrVL1BjoSY3xoNa
	 aWkhc3X7dC6MpHdVMQZfi9vclo/1gHQ7wv5gozBMdJv6MbO8LkeWt7/QIvmv4fdkIM
	 47/Qmln3iNwYgirwDK6HeSit3IYnCpgJ1iFwL7T4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wen Gu <guwen@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	Wenjia Zhang <wenjia@linux.ibm.com>
Subject: [PATCH 6.7 152/353] net/smc: disable SEID on non-s390 archs where virtual ISM may be used
Date: Fri,  2 Feb 2024 20:04:30 -0800
Message-ID: <20240203035408.475187972@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035403.657508530@linuxfoundation.org>
References: <20240203035403.657508530@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wen Gu <guwen@linux.alibaba.com>

[ Upstream commit c6b8b8eb49904018e22e4e4b1fa502e57dc747d9 ]

The system EID (SEID) is an internal EID used by SMC-D to represent the
s390 physical machine that OS is executing on. On s390 architecture, it
predefined by fixed string and part of cpuid and is enabled regardless
of whether underlay device is virtual ISM or platform firmware ISM.

However on non-s390 architectures where SMC-D can be used with virtual
ISM devices, there is no similar information to identify physical
machines, especially in virtualization scenarios. So in such cases, SEID
is forcibly disabled and the user-defined UEID will be used to represent
the communicable space.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
Reviewed-and-tested-by: Wenjia Zhang <wenjia@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/smc/smc_clc.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index 72f4d81a3f41..1489a8421d78 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -155,10 +155,12 @@ static int smc_clc_ueid_remove(char *ueid)
 			rc = 0;
 		}
 	}
+#if IS_ENABLED(CONFIG_S390)
 	if (!rc && !smc_clc_eid_table.ueid_cnt) {
 		smc_clc_eid_table.seid_enabled = 1;
 		rc = -EAGAIN;	/* indicate success and enabling of seid */
 	}
+#endif
 	write_unlock(&smc_clc_eid_table.lock);
 	return rc;
 }
@@ -273,22 +275,30 @@ int smc_nl_dump_seid(struct sk_buff *skb, struct netlink_callback *cb)
 
 int smc_nl_enable_seid(struct sk_buff *skb, struct genl_info *info)
 {
+#if IS_ENABLED(CONFIG_S390)
 	write_lock(&smc_clc_eid_table.lock);
 	smc_clc_eid_table.seid_enabled = 1;
 	write_unlock(&smc_clc_eid_table.lock);
 	return 0;
+#else
+	return -EOPNOTSUPP;
+#endif
 }
 
 int smc_nl_disable_seid(struct sk_buff *skb, struct genl_info *info)
 {
 	int rc = 0;
 
+#if IS_ENABLED(CONFIG_S390)
 	write_lock(&smc_clc_eid_table.lock);
 	if (!smc_clc_eid_table.ueid_cnt)
 		rc = -ENOENT;
 	else
 		smc_clc_eid_table.seid_enabled = 0;
 	write_unlock(&smc_clc_eid_table.lock);
+#else
+	rc = -EOPNOTSUPP;
+#endif
 	return rc;
 }
 
@@ -1269,7 +1279,11 @@ void __init smc_clc_init(void)
 	INIT_LIST_HEAD(&smc_clc_eid_table.list);
 	rwlock_init(&smc_clc_eid_table.lock);
 	smc_clc_eid_table.ueid_cnt = 0;
+#if IS_ENABLED(CONFIG_S390)
 	smc_clc_eid_table.seid_enabled = 1;
+#else
+	smc_clc_eid_table.seid_enabled = 0;
+#endif
 }
 
 void smc_clc_exit(void)
-- 
2.43.0




