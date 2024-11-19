Return-Path: <stable+bounces-93917-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAD99D1F65
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 05:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D59A52820EF
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 04:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA97C14B96E;
	Tue, 19 Nov 2024 04:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hc0001RF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E451459F6
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 04:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731991015; cv=none; b=hGmU6L3TquvNOiDgy03kg7tbmOU0AGpBlbp9+onZ70Bu8sPyIeFj80rkqqZ2R0lXWfYOQFaB34Kjdls7OasKcubllCFOhUWDVUXFHUMOEW25PNovb593ElXlMxsuggtGh8JkcK4snOuQ0FEtN2/nSBoqBN9KvxzVI9NCFOY/gg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731991015; c=relaxed/simple;
	bh=bm3E6agCT/iiCfoZxWDsPcOlCQ/ICj4GfvlxeCC6GV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OGeFKOX4ysex/Wr48tuK2ZW3Tee8LyvgfSG1ttRnCuQTyH4C8Cb0sMITCZyk055XraC3ip866BsJAQwdZhS8VXKbCBeiiRMHx/Q3/HGWhqc9H+4kNT7umEtL+J4Fg7BDUQ3vpRcEMGHxFEf5Li5ujpl/mHJkStewltSJde7jP2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hc0001RF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB09C4CECF;
	Tue, 19 Nov 2024 04:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731991015;
	bh=bm3E6agCT/iiCfoZxWDsPcOlCQ/ICj4GfvlxeCC6GV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hc0001RFHYn/Ciw/Rb9Z59eECoLT/Z4lO5wS3uGc7UPbN8xPlQdxdcECRgNueXrJL
	 5HFLyYsbffBbGxF5PVWiP73s6vgpDoEuO1oor5ArImM/5Dz1qqVL9QJOGiVE4LErUB
	 ODSdgsEDSZB2gV4J6NlNeWkgsknuA10PToQgo9U74Ym7qQhFCXdas9SO2YNvhHTgpa
	 ySMIUdfaD9Xjw+neozjj8wBHoP/Ch48cziAolo1V1kHSNGSvwIIhkTB7qp7dhTxail
	 ExJ8XucnpfQCWtxRPCJRNmUAolXJ7A/Fr8z/ZSp5NkrFIsubRUcKgHIpd5hJGFvdT/
	 H65lLLLnO8cTA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] hv_netvsc: Don't free decrypted memory
Date: Mon, 18 Nov 2024 23:36:53 -0500
Message-ID: <20241118085648.2566126-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241118085648.2566126-1-xiangyu.chen@eng.windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: bbf9ac34677b57506a13682b31a2a718934c0e31

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
Commit author: Rick Edgecombe <rick.p.edgecombe@intel.com>

Commit in newer trees:

|-----------------|----------------------------------------------|
| 6.11.y          |  Present (exact SHA1)                        |
| 6.6.y           |  Present (different SHA1: a56fe6113263)      |
| 6.1.y           |  Not found                                   |
|-----------------|----------------------------------------------|

Note: The patch differs from the upstream commit:
---
--- -	2024-11-18 16:54:05.112773302 -0500
+++ /tmp/tmp.t6kVHCimQu	2024-11-18 16:54:05.106717868 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit bbf9ac34677b57506a13682b31a2a718934c0e31 ]
+
 In CoCo VMs it is possible for the untrusted host to cause
 set_memory_encrypted() or set_memory_decrypted() to fail such that an
 error is returned and the resulting memory is shared. Callers need to
@@ -16,25 +18,45 @@
 Link: https://lore.kernel.org/r/20240311161558.1310-4-mhklinux@outlook.com
 Signed-off-by: Wei Liu <wei.liu@kernel.org>
 Message-ID: <20240311161558.1310-4-mhklinux@outlook.com>
+Signed-off-by: Sasha Levin <sashal@kernel.org>
+[Xiangyu:  Bp to fix CVE: CVE-2024-36911 resolved the conflicts]
+Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
 ---
- drivers/net/hyperv/netvsc.c | 7 +++++--
- 1 file changed, 5 insertions(+), 2 deletions(-)
+ drivers/net/hyperv/netvsc.c | 20 ++++++++++++--------
+ 1 file changed, 12 insertions(+), 8 deletions(-)
 
 diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
-index a6fcbda64ecc6..2b6ec979a62f2 100644
+index 3a834d4e1c84..3735bfbd9e8e 100644
 --- a/drivers/net/hyperv/netvsc.c
 +++ b/drivers/net/hyperv/netvsc.c
-@@ -154,8 +154,11 @@ static void free_netvsc_device(struct rcu_head *head)
- 	int i;
+@@ -155,15 +155,19 @@ static void free_netvsc_device(struct rcu_head *head)
  
  	kfree(nvdev->extension);
--	vfree(nvdev->recv_buf);
--	vfree(nvdev->send_buf);
-+
-+	if (!nvdev->recv_buf_gpadl_handle.decrypted)
-+		vfree(nvdev->recv_buf);
-+	if (!nvdev->send_buf_gpadl_handle.decrypted)
-+		vfree(nvdev->send_buf);
+ 
+-	if (nvdev->recv_original_buf)
+-		vfree(nvdev->recv_original_buf);
+-	else
+-		vfree(nvdev->recv_buf);
++	if (!nvdev->recv_buf_gpadl_handle.decrypted) {
++		if (nvdev->recv_original_buf)
++			vfree(nvdev->recv_original_buf);
++		else
++			vfree(nvdev->recv_buf);
++	}
+ 
+-	if (nvdev->send_original_buf)
+-		vfree(nvdev->send_original_buf);
+-	else
+-		vfree(nvdev->send_buf);
++	if (!nvdev->send_buf_gpadl_handle.decrypted) {
++		if (nvdev->send_original_buf)
++			vfree(nvdev->send_original_buf);
++		else
++			vfree(nvdev->send_buf);
++	}
+ 
  	bitmap_free(nvdev->send_section_map);
  
- 	for (i = 0; i < VRSS_CHANNEL_MAX; i++) {
+-- 
+2.43.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

