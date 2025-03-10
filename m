Return-Path: <stable+bounces-121647-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B82A58A49
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 03:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10FFF16979C
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 02:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4751E156861;
	Mon, 10 Mar 2025 02:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Phf0VEQ8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D6218A6AE
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 02:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741572872; cv=none; b=mPrFjhc2G6IIKR34F8BbmaiNBtfoq+k3RUCDR6fsMIlvRqzTIswoC6hhyvtMwskK5kmjgGGoFaT4GU0TaU5bPR5N4f3u25gXyeho8k5ZP2DOmNbEH1+G6SUvOm2OoeTg0P6hXedAl8QroGhz2zvKbqlC2ZBEGN6VKwjt2iAERzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741572872; c=relaxed/simple;
	bh=2N0ngInWB0KpphpCxz4d+F+jpnjbMY0fACCjVW2LDA8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NedP+3U4TLXuaNfn6kXhc6z+akVd6AhwmSqCUNJNTKQKqoc+zizTW7AeBL0rvvCQUixDeQ+EmU8J4BavO6sKJKdFsAhdBs3Q58Ax31aP8jswyd84E3ugCwHmBrUhmrgsmF09A/J+EhyEJzT6HGKjkOE99kpToWRF4EJyjN93+zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Phf0VEQ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 686E2C4CEE3;
	Mon, 10 Mar 2025 02:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741572871;
	bh=2N0ngInWB0KpphpCxz4d+F+jpnjbMY0fACCjVW2LDA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Phf0VEQ8Mfoc843ASpd9rcXQ949fVQj0nHFPuzvbSXaE1dL1qNGwUDpwlc/QonpHS
	 Z4KnEnvB5kLc7o48PNfYWtAL9IEemrN3yLyLoJjtOppweyKMugVk+2cUxQITCHM9xh
	 jxcFLI+dhbmiI3+PuBUDMfctBt4awv34BukdyEqjqo1a74OkqMj7mCuenBqZUrmbaN
	 3Plq2p5wxnJ3+EzpnUjuzqhV1/OTDLkyNQduYqsvAA1d9nRkzqWsCjgmaikuIkipd+
	 D4/g0y8Q0YtmP7xixoGA/lbmG1XOeiuM1PByrXHeuniesBwpYFD2NvXLzVeJ3CNv4M
	 jtVko6iqZlrQQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	aik@amd.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 1/2] virt: sev-guest: Allocate request data dynamically
Date: Sun,  9 Mar 2025 22:14:30 -0400
Message-Id: <20250309200612-6cbc40ebda632648@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250307013700.437505-2-aik@amd.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
❌ Build failures detected
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: ac7c06acaa3738b38e83815ac0f07140ad320f13

WARNING: Author mismatch between patch and found commit:
Backport author: Alexey Kardashevskiy<aik@amd.com>
Commit author: Nikunj A Dadhania<nikunj@amd.com>

Status in newer kernel trees:
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  ac7c06acaa373 ! 1:  9460661fc99bf virt: sev-guest: Allocate request data dynamically
    @@ Metadata
      ## Commit message ##
         virt: sev-guest: Allocate request data dynamically
     
    -    Commit
    -
    -      ae596615d93d ("virt: sev-guest: Reduce the scope of SNP command mutex")
    -
    -    narrowed the command mutex scope to snp_send_guest_request().  However,
    -    GET_REPORT, GET_DERIVED_KEY, and GET_EXT_REPORT share the req structure in
    -    snp_guest_dev. Without the mutex protection, concurrent requests can overwrite
    -    each other's data. Fix it by dynamically allocating the request structure.
    +    Commit ae596615d93d ("virt: sev-guest: Reduce the scope of SNP command
    +    mutex") narrowed the command mutex scope to snp_send_guest_request.
    +    However, GET_REPORT, GET_DERIVED_KEY, and GET_EXT_REPORT share the req
    +    structure in snp_guest_dev. Without the mutex protection, concurrent
    +    requests can overwrite each other's data. Fix it by dynamically allocating
    +    the request structure.
     
         Fixes: ae596615d93d ("virt: sev-guest: Reduce the scope of SNP command mutex")
    -    Closes: https://github.com/AMDESE/AMDSEV/issues/265
    +    Cc: stable@vger.kernel.org
         Reported-by: andreas.stuehrk@yaxi.tech
    +    Closes: https://github.com/AMDESE/AMDSEV/issues/265
         Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
    -    Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
    -    Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
    -    Cc: stable@vger.kernel.org
    -    Link: https://lore.kernel.org/r/20250307013700.437505-2-aik@amd.com
     
      ## drivers/virt/coco/sev-guest/sev-guest.c ##
     @@ drivers/virt/coco/sev-guest/sev-guest.c: struct snp_guest_dev {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.13.y       |  Success    |  Success   |
| stable/linux-6.12.y       |  Failed     |  N/A       |
| stable/linux-6.6.y        |  Failed     |  N/A       |
| stable/linux-6.1.y        |  Failed     |  N/A       |
| stable/linux-5.15.y       |  Failed     |  N/A       |
| stable/linux-5.10.y       |  Failed     |  N/A       |
| stable/linux-5.4.y        |  Failed     |  N/A       |

Build Errors:
Patch failed to apply on stable/linux-6.12.y. Reject:

diff a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c	(rejected hunks)
@@ -39,12 +39,6 @@ struct snp_guest_dev {
 	struct miscdevice misc;
 
 	struct snp_msg_desc *msg_desc;
-
-	union {
-		struct snp_report_req report;
-		struct snp_derived_key_req derived_key;
-		struct snp_ext_report_req ext_report;
-	} req;
 };
 
 /*
@@ -72,7 +66,7 @@ struct snp_req_resp {
 
 static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
 {
-	struct snp_report_req *report_req = &snp_dev->req.report;
+	struct snp_report_req *report_req __free(kfree) = NULL;
 	struct snp_msg_desc *mdesc = snp_dev->msg_desc;
 	struct snp_report_resp *report_resp;
 	struct snp_guest_req req = {};
@@ -117,7 +115,7 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 
 static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
 {
-	struct snp_derived_key_req *derived_key_req = &snp_dev->req.derived_key;
+	struct snp_derived_key_req *derived_key_req __free(kfree) = NULL;
 	struct snp_derived_key_resp derived_key_resp = {0};
 	struct snp_msg_desc *mdesc = snp_dev->msg_desc;
 	struct snp_guest_req req = {};
@@ -169,7 +171,7 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 			  struct snp_req_resp *io)
 
 {
-	struct snp_ext_report_req *report_req = &snp_dev->req.ext_report;
+	struct snp_ext_report_req *report_req __free(kfree) = NULL;
 	struct snp_msg_desc *mdesc = snp_dev->msg_desc;
 	struct snp_report_resp *report_resp;
 	struct snp_guest_req req = {};
Patch failed to apply on stable/linux-6.6.y. Reject:

diff a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c	(rejected hunks)
@@ -39,12 +39,6 @@ struct snp_guest_dev {
 	struct miscdevice misc;
 
 	struct snp_msg_desc *msg_desc;
-
-	union {
-		struct snp_report_req report;
-		struct snp_derived_key_req derived_key;
-		struct snp_ext_report_req ext_report;
-	} req;
 };
 
 /*
@@ -72,7 +66,7 @@ struct snp_req_resp {
 
 static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
 {
-	struct snp_report_req *report_req = &snp_dev->req.report;
+	struct snp_report_req *report_req __free(kfree) = NULL;
 	struct snp_msg_desc *mdesc = snp_dev->msg_desc;
 	struct snp_report_resp *report_resp;
 	struct snp_guest_req req = {};
@@ -81,6 +75,10 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 	if (!arg->req_data || !arg->resp_data)
 		return -EINVAL;
 
+	report_req = kzalloc(sizeof(*report_req), GFP_KERNEL_ACCOUNT);
+	if (!report_req)
+		return -ENOMEM;
+
 	if (copy_from_user(report_req, (void __user *)arg->req_data, sizeof(*report_req)))
 		return -EFAULT;
 
@@ -117,7 +115,7 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 
 static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
 {
-	struct snp_derived_key_req *derived_key_req = &snp_dev->req.derived_key;
+	struct snp_derived_key_req *derived_key_req __free(kfree) = NULL;
 	struct snp_derived_key_resp derived_key_resp = {0};
 	struct snp_msg_desc *mdesc = snp_dev->msg_desc;
 	struct snp_guest_req req = {};
@@ -137,6 +135,10 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
 	if (sizeof(buf) < resp_len)
 		return -ENOMEM;
 
+	derived_key_req = kzalloc(sizeof(*derived_key_req), GFP_KERNEL_ACCOUNT);
+	if (!derived_key_req)
+		return -ENOMEM;
+
 	if (copy_from_user(derived_key_req, (void __user *)arg->req_data,
 			   sizeof(*derived_key_req)))
 		return -EFAULT;
@@ -169,7 +171,7 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 			  struct snp_req_resp *io)
 
 {
-	struct snp_ext_report_req *report_req = &snp_dev->req.ext_report;
+	struct snp_ext_report_req *report_req __free(kfree) = NULL;
 	struct snp_msg_desc *mdesc = snp_dev->msg_desc;
 	struct snp_report_resp *report_resp;
 	struct snp_guest_req req = {};
@@ -179,6 +181,10 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 	if (sockptr_is_null(io->req_data) || sockptr_is_null(io->resp_data))
 		return -EINVAL;
 
+	report_req = kzalloc(sizeof(*report_req), GFP_KERNEL_ACCOUNT);
+	if (!report_req)
+		return -ENOMEM;
+
 	if (copy_from_sockptr(report_req, io->req_data, sizeof(*report_req)))
 		return -EFAULT;
 
Patch failed to apply on stable/linux-6.1.y. Reject:

diff a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c	(rejected hunks)
@@ -39,12 +39,6 @@ struct snp_guest_dev {
 	struct miscdevice misc;
 
 	struct snp_msg_desc *msg_desc;
-
-	union {
-		struct snp_report_req report;
-		struct snp_derived_key_req derived_key;
-		struct snp_ext_report_req ext_report;
-	} req;
 };
 
 /*
@@ -72,7 +66,7 @@ struct snp_req_resp {
 
 static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
 {
-	struct snp_report_req *report_req = &snp_dev->req.report;
+	struct snp_report_req *report_req __free(kfree) = NULL;
 	struct snp_msg_desc *mdesc = snp_dev->msg_desc;
 	struct snp_report_resp *report_resp;
 	struct snp_guest_req req = {};
@@ -81,6 +75,10 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 	if (!arg->req_data || !arg->resp_data)
 		return -EINVAL;
 
+	report_req = kzalloc(sizeof(*report_req), GFP_KERNEL_ACCOUNT);
+	if (!report_req)
+		return -ENOMEM;
+
 	if (copy_from_user(report_req, (void __user *)arg->req_data, sizeof(*report_req)))
 		return -EFAULT;
 
@@ -117,7 +115,7 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 
 static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
 {
-	struct snp_derived_key_req *derived_key_req = &snp_dev->req.derived_key;
+	struct snp_derived_key_req *derived_key_req __free(kfree) = NULL;
 	struct snp_derived_key_resp derived_key_resp = {0};
 	struct snp_msg_desc *mdesc = snp_dev->msg_desc;
 	struct snp_guest_req req = {};
@@ -137,6 +135,10 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
 	if (sizeof(buf) < resp_len)
 		return -ENOMEM;
 
+	derived_key_req = kzalloc(sizeof(*derived_key_req), GFP_KERNEL_ACCOUNT);
+	if (!derived_key_req)
+		return -ENOMEM;
+
 	if (copy_from_user(derived_key_req, (void __user *)arg->req_data,
 			   sizeof(*derived_key_req)))
 		return -EFAULT;
@@ -169,7 +171,7 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 			  struct snp_req_resp *io)
 
 {
-	struct snp_ext_report_req *report_req = &snp_dev->req.ext_report;
+	struct snp_ext_report_req *report_req __free(kfree) = NULL;
 	struct snp_msg_desc *mdesc = snp_dev->msg_desc;
 	struct snp_report_resp *report_resp;
 	struct snp_guest_req req = {};
@@ -179,6 +181,10 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 	if (sockptr_is_null(io->req_data) || sockptr_is_null(io->resp_data))
 		return -EINVAL;
 
+	report_req = kzalloc(sizeof(*report_req), GFP_KERNEL_ACCOUNT);
+	if (!report_req)
+		return -ENOMEM;
+
 	if (copy_from_sockptr(report_req, io->req_data, sizeof(*report_req)))
 		return -EFAULT;
 
Patch failed to apply on stable/linux-5.15.y but no reject information available.
Patch failed to apply on stable/linux-5.10.y but no reject information available.
Patch failed to apply on stable/linux-5.4.y but no reject information available.

