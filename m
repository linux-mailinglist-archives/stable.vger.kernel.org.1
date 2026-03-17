Return-Path: <stable+bounces-226857-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mA4eGO2UuWk2KwIAu9opvQ
	(envelope-from <stable+bounces-226857-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:52:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D8B2B049B
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 05F7A30ED7F6
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637553368AE;
	Tue, 17 Mar 2026 17:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Echj8JX8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9E0374174;
	Tue, 17 Mar 2026 17:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768496; cv=none; b=gqaHD/l1r4zRe56YULPOxtSr+wNLE1nKh2/BxliTPRscevKra6J+v3KGTCTKVfaatEP4Bk7NZSxXrO8auVkv5uwJ93n9SxigPvwlf3Xdz3phwFwEJfH72nRMvq8FEOPKINJE9OkmfaAFVJRW9P5u9lfFPa882nyenNU55CjDlwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768496; c=relaxed/simple;
	bh=D77GGRNo9Icymf4kU9mqXtnlz4WVN8HEM8LRQQyIWUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o/UI0T7OHnqk7blF+i7fvKasxb/+nmnXfCuoyazpDiBDc6oLv68s63xdIH92JXpJuE/JWxyEuXYbcUliWBBCq08glvJ7n709nWkP7GOobxzUVUMrRSEDEuGFzPGmcKGAoM0wEA98OmNAHkzWnRzvmACTUmOpUSVgpZIM1u3rh7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Echj8JX8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB77C4CEF7;
	Tue, 17 Mar 2026 17:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773768495;
	bh=D77GGRNo9Icymf4kU9mqXtnlz4WVN8HEM8LRQQyIWUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Echj8JX8sUgZCUMNtDVCqng1pkcOCDCl03WpUZxpuQ50TUYXlquYMQMqQD0laJF2f
	 nQb1rjEztE9g8xGEGat7aISoFVWMQ5qe14tgtgAf50XvjamJXDGzeI1uQBXeb/tUMK
	 obDfCBcitYRMarTRNyjmXqWsYukcOqVSZQ8i94Q4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Keith Busch <kbusch@kernel.org>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH 6.18 315/333] cxl/acpi: Fix CXL_ACPI and CXL_PMEM Kconfig tristate mismatch
Date: Tue, 17 Mar 2026 17:35:44 +0100
Message-ID: <20260317163011.064682368@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226857-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,msgid.link:url,intel.com:email,huawei.com:email]
X-Rspamd-Queue-Id: 58D8B2B049B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Keith Busch <kbusch@kernel.org>

commit 93d0fcdddc9e7be9d4f42acbe57bc90dbb0fe75d upstream.

Commit e7e222ad73d9 ("cxl: Move devm_cxl_add_nvdimm_bridge() to
cxl_pmem.ko") moves devm_cxl_add_nvdimm_bridge() into the cxl_pmem file,
which has independent config compile options for built-in or module. The
call from cxl_acpi_probe() is guarded by IS_ENABLED(CONFIG_CXL_PMEM),
which evaluates to true for both =y and =m.

When CONFIG_CXL_PMEM=m, a built-in cxl_acpi attempts to reference a
symbol exported by a module, which fails to link. CXL_PMEM cannot simply
be promoted to =y in this configuration because it depends on LIBNVDIMM,
which may itself be =m.

Add a Kconfig dependency to prevent CXL_ACPI from being built-in when
CXL_PMEM is a module. This contrains CXL_ACPI to =m when CXL_PMEM=m,
while still allowing CXL_ACPI to be freely configured when CXL_PMEM is
either built-in or disabled.

[ dj: Fix up commit reference formatting. ]

Fixes: e7e222ad73d9 ("cxl: Move devm_cxl_add_nvdimm_bridge() to cxl_pmem.ko")
Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Link: https://patch.msgid.link/20260305204057.1516948-1-kbusch@meta.com
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cxl/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -58,6 +58,7 @@ config CXL_ACPI
 	tristate "CXL ACPI: Platform Support"
 	depends on ACPI
 	depends on ACPI_NUMA
+	depends on CXL_PMEM || !CXL_PMEM
 	default CXL_BUS
 	select ACPI_TABLE_LIB
 	select ACPI_HMAT



