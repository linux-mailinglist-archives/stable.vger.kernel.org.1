Return-Path: <stable+bounces-231695-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HInEVb+y2kJNQYAu9opvQ
	(envelope-from <stable+bounces-231695-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:03:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D3F36DBF3
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 20F60304FF53
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F9E425CE0;
	Tue, 31 Mar 2026 16:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X/EW/Oh1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C74421F1F;
	Tue, 31 Mar 2026 16:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774974830; cv=none; b=uJ338tMfe/OhXPPBlVvHB+qsQKxj34q9QfORQAJYjnMOL0fjZSeV5FnswK/m43GWHXXcfN/FFvRZPH06csRg3Vh88GiKroLLy4Znr5JTg2ux3IkgV8KsewiSizYp85+wax2KyPDiq8SGVu1iuY3wnwmTM9/X7Cc2CSBB9cIB/9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774974830; c=relaxed/simple;
	bh=oPmgT21hhLLCfDOQApOyCrRL1GwOi5gsoQSv4M2o78Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p/MUNlbigEVMwQN3ab2yN3ivg/p5u14vWIUTbSMR2jUk3fN2xvcBpOHc8G5Rocx+U+icR5K3ly6umCxFVLc2THEQbXTnfROP/BFvGiWcUKFPXGBdUkFM5AZkPzk5HEFL92Z2jXVKVUrRqUxpAj+To9ttLrhSy8Oo2KClw5UlMRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X/EW/Oh1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED0DC19423;
	Tue, 31 Mar 2026 16:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774974830;
	bh=oPmgT21hhLLCfDOQApOyCrRL1GwOi5gsoQSv4M2o78Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X/EW/Oh18P2mwZjBJVQoIIqJcDYYE+8LZGDy8609ObyekscjK1PSY8YNmGsoPCWd8
	 3RxrrvdEcUTYIEFXpuVQd6Rl7yeMgTw+kN6IEJXmJFJGddhR2RrPwy8/0IIwk0fg7r
	 6X3F6RC5c7kkVkchpEgAWOfhXNxWNQSNk7n9371w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wang Yinfeng <wangyinfeng@phytium.com.cn>,
	Cui Chao <cuichao1753@phytium.com.cn>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 017/342] cxl: Adjust the startup priority of cxl_pmem to be higher than that of cxl_acpi
Date: Tue, 31 Mar 2026 18:17:30 +0200
Message-ID: <20260331161759.540628472@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
References: <20260331161758.909578033@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231695-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,phytium.com.cn:email]
X-Rspamd-Queue-Id: 18D3F36DBF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cui Chao <cuichao1753@phytium.com.cn>

[ Upstream commit be5c5280cf2b20e363dc8e2a424dd200a29b1c77 ]

During the cxl_acpi probe process, it checks whether the cxl_nvb device
and driver have been attached. Currently, the startup priority of the
cxl_pmem driver is lower than that of the cxl_acpi driver. At this point,
the cxl_nvb driver has not yet been registered on the cxl_bus, causing
the attachment check to fail. This results in a failure to add the root
nvdimm bridge, leading to a cxl_acpi probe failure and ultimately
affecting the subsequent loading of cxl drivers. As a consequence, only
one mem device object exists on the cxl_bus, while the cxl_port device
objects and decoder device objects are missing.

The solution is to raise the startup priority of cxl_pmem to be higher
than that of cxl_acpi, ensuring that the cxl_pmem driver is registered
before the aforementioned attachment check occurs.

Co-developed-by: Wang Yinfeng <wangyinfeng@phytium.com.cn>
Signed-off-by: Wang Yinfeng <wangyinfeng@phytium.com.cn>
Signed-off-by: Cui Chao <cuichao1753@phytium.com.cn>
Fixes: e7e222ad73d9 ("cxl: Move devm_cxl_add_nvdimm_bridge() to cxl_pmem.ko")
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Link: https://patch.msgid.link/20260319074535.1709250-1-cuichao1753@phytium.com.cn
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cxl/pmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index c00b84b960761..3432fd83b1e2a 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -554,7 +554,7 @@ static __exit void cxl_pmem_exit(void)
 
 MODULE_DESCRIPTION("CXL PMEM: Persistent Memory Support");
 MODULE_LICENSE("GPL v2");
-module_init(cxl_pmem_init);
+subsys_initcall(cxl_pmem_init);
 module_exit(cxl_pmem_exit);
 MODULE_IMPORT_NS("CXL");
 MODULE_ALIAS_CXL(CXL_DEVICE_NVDIMM_BRIDGE);
-- 
2.51.0




