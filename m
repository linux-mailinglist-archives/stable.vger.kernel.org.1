Return-Path: <stable+bounces-210984-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLt6GkAfcWmodQAAu9opvQ
	(envelope-from <stable+bounces-210984-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 19:47:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E44B5B7D9
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 19:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4239B8614CD
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427D036403D;
	Wed, 21 Jan 2026 18:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MNqU0/y+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C8D33A9F4;
	Wed, 21 Jan 2026 18:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020046; cv=none; b=XTUA2CKicct8rPnyEMpO+g07Jz8jALRucf4+81mpxVmmSUfXWte3dfCMhquqde+7sAFT9wlPSKsIqiiHBypA3sSGRXDKzh/s9Ags2XbN/ee04hDnjHH2sWyCjbiABtHNccRWyHlaemwQq5FknwzeUmGjhBMZh/FeNHxsAmeAFPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020046; c=relaxed/simple;
	bh=HoqZ1t/Ad83K4/qNPjUfNYzWWbEIpGzu+pwIsubXvT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YiyNKK1v9DCYrs86UYzHKVc4wAuZuZkV8HP6qjpGbarPqbmcq7Wu/IOKCjbxfajp6cBaupv4tpaxZj30pwSzjTV0XuDDznJbtVCvfjbq7g4sHrj3jkvjy/PPtDjbsodxan8AItPvun/YnwZjYmYOp9YI8hiQoCKVRS8mBh/pOw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MNqU0/y+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC8BC4CEF1;
	Wed, 21 Jan 2026 18:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769020045;
	bh=HoqZ1t/Ad83K4/qNPjUfNYzWWbEIpGzu+pwIsubXvT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MNqU0/y+dTJ/3r6j6ZiN+CiiCkFcwEWyN5IsBTQv+QTVwbjKRGba32w1Xx2I7brJn
	 2boJBesnbzPP7bavdgUVBqjSNRRGAkkWI/mcFzUlTDbtpCt49D8A3nuT89dAPpQyPt
	 eF08T7YCuyec+Hu8bx5ZNVXQLjzy+gE8zAbpuLq8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Li Ming <ming.li@zohomail.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 044/198] cxl/hdm: Fix potential infinite loop in __cxl_dpa_reserve()
Date: Wed, 21 Jan 2026 19:14:32 +0100
Message-ID: <20260121181420.135776460@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181418.537774329@linuxfoundation.org>
References: <20260121181418.537774329@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	TAGGED_FROM(0.00)[bounces-210984-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 0E44B5B7D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Li Ming <ming.li@zohomail.com>

[ Upstream commit d4026a44626490dc4eca4dd2c4d0816338fa179b ]

In __cxl_dpa_reserve(), it will check if the new resource range is
included in one of paritions of the cxl memory device.
cxlds->nr_paritions is used to represent how many partitions information
the cxl memory device has. In the loop, if driver cannot find a
partition including the new resource range, it will be an infinite loop.

[ dj: Removed incorrect fixes tag ]

Fixes: 991d98f17d31 ("cxl: Make cxl_dpa_alloc() DPA partition number agnostic")
Signed-off-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Link: https://patch.msgid.link/20260112120526.530232-1-ming.li@zohomail.com
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cxl/core/hdm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index d3a094ca01ad9..20dd638108062 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -403,7 +403,7 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 	 * is not set.
 	 */
 	if (cxled->part < 0)
-		for (int i = 0; cxlds->nr_partitions; i++)
+		for (int i = 0; i < cxlds->nr_partitions; i++)
 			if (resource_contains(&cxlds->part[i].res, res)) {
 				cxled->part = i;
 				break;
-- 
2.51.0




