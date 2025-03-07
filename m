Return-Path: <stable+bounces-121437-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F10A5707B
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 19:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 405B7189BFB1
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 18:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5DA241696;
	Fri,  7 Mar 2025 18:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Mm//iCO7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fmX1k1+O"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE5024113E;
	Fri,  7 Mar 2025 18:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741371952; cv=none; b=SNVerXXqYmpzbaDlWp1g4uocN4p09YvADiagRUgiz2ajH57N0LH0ecxlFScNaKa7cNPPbuq+R7Tuhp56E1Hd70/vzmoz3nP/to/zTCdqPadQifri4nCFx+OkmV8UzVN9NnNWT+mkGWodeLT8INc/GPFJBP+YijWQecrSyp0PtLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741371952; c=relaxed/simple;
	bh=3Ovd0J5I7/I82BSajaIsMtk4zYygg6eqFGLuo+FNr+c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=n5z3Rh34K01N/vpVToGlj2V5qoVxTrZ/tbqz3aRYck9WjPYRkRgTvsVRscKzmUe0zlXd5wGkHD7+tckt0No+HcB4Ju8/udlgQYyhxPK5zm0ADxf7h9kYscLXJuz13+lNc1/9uC71Ttcrwr/zbyh1tMsEhgnixoXKWaOFyRShnCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Mm//iCO7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fmX1k1+O; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 07 Mar 2025 18:25:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741371949;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5BAgIn8+hjI+E0W6vDfg3HoDMlP1tfnkvdf5IbyHekU=;
	b=Mm//iCO7c+5qdVznzFCR2OHq615G9xyG96ZJYFFa2pSwTtvRQ9Rp46L72AMDLWnfBVOLYi
	UWCW6p58tKIyZZYy/6FI3lK7aofLdM/1E78rro5AgGEn8V1RdEqSsFIeB7phjKX28hWD5y
	dSLbwewfO40Ik/4nzqJromU9Y3YpeetwaR99sM0k/maS85z8u+wbbsSMuf/w5LNA9TtMZr
	nkK1LUpf3f/h1/jmjHuyBoi1mnNtj5uVRtFWREAq6Hw7vjlArtCxT34K7DSxD4ivcf1BPy
	e2Z2mSiCrfZm3II6LLcMyR3js93/Ko291/AnsqGyhMfK+QMpKJrZ/RtWavcCmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741371949;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5BAgIn8+hjI+E0W6vDfg3HoDMlP1tfnkvdf5IbyHekU=;
	b=fmX1k1+OCjgOUtmCNEhhMZnAwgrtRaotgSiddGMlv9zpXyJuehL76LajuBc0lgXKDdMsQF
	JIg4EYkP7YxbTcDg==
From: "tip-bot2 for Nikunj A Dadhania" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] virt: sev-guest: Allocate request data dynamically
Cc: andreas.stuehrk@yaxi.tech, Nikunj A Dadhania <nikunj@amd.com>,
 Alexey Kardashevskiy <aik@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250307013700.437505-2-aik@amd.com>
References: <20250307013700.437505-2-aik@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174137194865.14745.6525578423507333253.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     ac7c06acaa3738b38e83815ac0f07140ad320f13
Gitweb:        https://git.kernel.org/tip/ac7c06acaa3738b38e83815ac0f07140ad320f13
Author:        Nikunj A Dadhania <nikunj@amd.com>
AuthorDate:    Thu, 06 Mar 2025 19:17:21 +11:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 07 Mar 2025 13:34:25 +01:00

virt: sev-guest: Allocate request data dynamically

Commit

  ae596615d93d ("virt: sev-guest: Reduce the scope of SNP command mutex")

narrowed the command mutex scope to snp_send_guest_request().  However,
GET_REPORT, GET_DERIVED_KEY, and GET_EXT_REPORT share the req structure in
snp_guest_dev. Without the mutex protection, concurrent requests can overwrite
each other's data. Fix it by dynamically allocating the request structure.

Fixes: ae596615d93d ("virt: sev-guest: Reduce the scope of SNP command mutex")
Closes: https://github.com/AMDESE/AMDSEV/issues/265
Reported-by: andreas.stuehrk@yaxi.tech
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250307013700.437505-2-aik@amd.com
---
 drivers/virt/coco/sev-guest/sev-guest.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 264b652..23ac177 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -38,12 +38,6 @@ struct snp_guest_dev {
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
@@ -71,7 +65,7 @@ struct snp_req_resp {
 
 static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
 {
-	struct snp_report_req *report_req = &snp_dev->req.report;
+	struct snp_report_req *report_req __free(kfree) = NULL;
 	struct snp_msg_desc *mdesc = snp_dev->msg_desc;
 	struct snp_report_resp *report_resp;
 	struct snp_guest_req req = {};
@@ -80,6 +74,10 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 	if (!arg->req_data || !arg->resp_data)
 		return -EINVAL;
 
+	report_req = kzalloc(sizeof(*report_req), GFP_KERNEL_ACCOUNT);
+	if (!report_req)
+		return -ENOMEM;
+
 	if (copy_from_user(report_req, (void __user *)arg->req_data, sizeof(*report_req)))
 		return -EFAULT;
 
@@ -116,7 +114,7 @@ e_free:
 
 static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
 {
-	struct snp_derived_key_req *derived_key_req = &snp_dev->req.derived_key;
+	struct snp_derived_key_req *derived_key_req __free(kfree) = NULL;
 	struct snp_derived_key_resp derived_key_resp = {0};
 	struct snp_msg_desc *mdesc = snp_dev->msg_desc;
 	struct snp_guest_req req = {};
@@ -136,6 +134,10 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
 	if (sizeof(buf) < resp_len)
 		return -ENOMEM;
 
+	derived_key_req = kzalloc(sizeof(*derived_key_req), GFP_KERNEL_ACCOUNT);
+	if (!derived_key_req)
+		return -ENOMEM;
+
 	if (copy_from_user(derived_key_req, (void __user *)arg->req_data,
 			   sizeof(*derived_key_req)))
 		return -EFAULT;
@@ -168,7 +170,7 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 			  struct snp_req_resp *io)
 
 {
-	struct snp_ext_report_req *report_req = &snp_dev->req.ext_report;
+	struct snp_ext_report_req *report_req __free(kfree) = NULL;
 	struct snp_msg_desc *mdesc = snp_dev->msg_desc;
 	struct snp_report_resp *report_resp;
 	struct snp_guest_req req = {};
@@ -178,6 +180,10 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 	if (sockptr_is_null(io->req_data) || sockptr_is_null(io->resp_data))
 		return -EINVAL;
 
+	report_req = kzalloc(sizeof(*report_req), GFP_KERNEL_ACCOUNT);
+	if (!report_req)
+		return -ENOMEM;
+
 	if (copy_from_sockptr(report_req, io->req_data, sizeof(*report_req)))
 		return -EFAULT;
 

