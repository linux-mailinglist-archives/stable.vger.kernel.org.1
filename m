Return-Path: <stable+bounces-252824-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPreF4/+DWpV5QUAu9opvQ
	(envelope-from <stable+bounces-252824-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:33:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 094E9596964
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29A143036FB3
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229E0348C55;
	Wed, 20 May 2026 18:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qIp4FD/D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F363F39EE;
	Wed, 20 May 2026 18:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301684; cv=none; b=Fu7g+prE5x4Z/RyM+pUih3LShlRFrkWId9MEUiKO41NfJPulHbXLTqL3FfojC1xBKr436H07sGyoDio7ABnO4YcCGJHMdkTcDoQS5hQpz405ywiFhLmESQNvyt67yx8ZMPtmuKahlH3pLEk0lORp5kWRIjbi5nszDCIqKVv3h+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301684; c=relaxed/simple;
	bh=jgVbQ+W7BLPzVp9hZDnpu+iDy2djidGEgXL9YJeDW8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uD0DWYGs8kWDOcCDeV4mQhr4gq8OiNx+qot+PL66p5P1ziyeeR9WUoYW5N6dk1s7z/eyEY2ZKjIL17CvbmL8Mhte5vrB+DzDAiC+ohrIeFPhqnB679kAqZHUHCocaEpcC19rwIvYjVZSj/PkmiU2jfFz/3cYVuWiuvxubsME+x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qIp4FD/D; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5143F1F000E9;
	Wed, 20 May 2026 18:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301683;
	bh=B80piun3Z1eLwwNRZjLItg7tbRTNKTGUDiPx5KnG/QE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=qIp4FD/DNQD3q2ny4pc80+qfEdD5+dpB9C9AYCTKYIdfKbhY8r6RWKF/x+2aXjhEe
	 CfJil1WpbTfum6k+4TlD/BdKltR7VqajMH5bu+qwL4ty283kwkwCbhx5sbLHv9slWp
	 gpW5jTyqnEJ+UAuDdrEp0qnIW7ydBfbKjbjyYN2A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhenzhong Duan <zhenzhong.duan@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Pranjal Shrivastava <praan@google.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 647/666] iommufd: Fix return value of iommufd_fault_fops_write()
Date: Wed, 20 May 2026 18:24:18 +0200
Message-ID: <20260520162125.305341764@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252824-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,intel.com:email,alibaba.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 094E9596964
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/iommufd/fault.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -317,9 +317,10 @@ static ssize_t iommufd_fault_fops_write(
 
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



