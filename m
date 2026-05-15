Return-Path: <stable+bounces-247841-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMyWCx5DB2oCvAIAu9opvQ
	(envelope-from <stable+bounces-247841-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:00:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E3855291E
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8CFC0303138B
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7453FF1C9;
	Fri, 15 May 2026 15:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGthAw/W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1143FF1A8
	for <stable@vger.kernel.org>; Fri, 15 May 2026 15:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778859432; cv=none; b=lTTpHlzqjXaSzkvQdQs0dGHYhtX77xbk0Pe+FQI+5PhEgJbsxrx/cBg2rfHxhNkD4YHa43N966Wg9G90uSHp5ExKi5U+F7OajVXU2T0uILceeVqklhcicDmzSUzJgCSl+ZIptMAYfh8T1BYM2Wrv+lY434MsDnChD14Jfx6JlJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778859432; c=relaxed/simple;
	bh=rh1T7AAxCfApPEuYBc3FTq29G2I6DNdcGclw2UMWM/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y8o3o1tg9qKD7aJumGsEMKMgMqYUyVgQYZDPNff91ymATtObnMQcMlOJi0WsgIzyRhDOW7cDamJZRca0N/Y6M41rEJEOpDBXCW2wC4MsPO+lzZgLUZhWy8RMuHF4fyG4kf0Hlo7n6ojgUK2hbEMr8Xwv4Oc1i0MeICR2Jt7ghYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGthAw/W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB30CC2BCB0;
	Fri, 15 May 2026 15:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778859431;
	bh=rh1T7AAxCfApPEuYBc3FTq29G2I6DNdcGclw2UMWM/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eGthAw/WxGZfRjXXwZigCaNM4A6Zss9zsvmeALYT82KJGhguv4epfqVEC60AmRrpX
	 EStGASQhVE23dlAxzKW6b58M1ir1SS1uSJ3+2tV38PqSfV3H5vR43NlGLqXeNBTgoA
	 XtwyEwpvWwPEf1fKN156BTzaYbqBS4dEJ+A3XEJJvE5+0fkVEoEf7tZwtVdSqt6bPl
	 pCQLw2/e714dbEa6wWnJnCbL4U2uHIe0B9z6/pPcP00wFRTyRh/qzRnUqvwFjkzq4D
	 l7ZfqmWJ+vLuvmWoves1hlTwrNm/uU0CCvX9DHlVfv5mO9Ke9pUry63g2kXZdCH88d
	 TqB9YfvIOWUrA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Pranjal Shrivastava <praan@google.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] iommufd: Fix return value of iommufd_fault_fops_write()
Date: Fri, 15 May 2026 11:37:08 -0400
Message-ID: <20260515153708.3323159-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051240-paralyses-sprawl-a7f1@gregkh>
References: <2026051240-paralyses-sprawl-a7f1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C4E3855291E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247841-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,nvidia.com:email,alibaba.com:email]
X-Rspamd-Action: no action

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

[ Upstream commit aaca2aa92785a6ab8e3183e7184bca447a99cd76 ]

copy_from_user() may return number of bytes failed to copy, we should
not pass over this number to user space to cheat that write() succeed.
Instead, -EFAULT should be returned.

Link: https://patch.msgid.link/r/20260330030755.12856-1-zhenzhong.duan@intel.com
Cc: stable@vger.kernel.org
Fixes: 07838f7fd529 ("iommufd: Add iommufd fault object")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
[ applied identical hunk to drivers/iommu/iommufd/fault.c ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/iommufd/fault.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index af39b2379d534..8226e28d79a51 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -317,9 +317,10 @@ static ssize_t iommufd_fault_fops_write(struct file *filep, const char __user *b
 
 	mutex_lock(&fault->mutex);
 	while (count > done) {
-		rc = copy_from_user(&response, buf + done, response_size);
-		if (rc)
+		if (copy_from_user(&response, buf + done, response_size)) {
+			rc = -EFAULT;
 			break;
+		}
 
 		static_assert((int)IOMMUFD_PAGE_RESP_SUCCESS ==
 			      (int)IOMMU_PAGE_RESP_SUCCESS);
-- 
2.53.0


