Return-Path: <stable+bounces-121307-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5FEA5563C
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 20:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1A9A3A9CD3
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 19:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FA526E15E;
	Thu,  6 Mar 2025 19:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLq897f7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433BA26D5C3
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 19:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741288282; cv=none; b=DQ0c9uGJdrCMvRfEISrkaKHvE4atDUtvkGLWmgiY++DLEABQ5Bi+CFv3iiOvBwEMatcTYH6eUh+K1+MQOFMOsiCYuVkkg6dCLsDLMADrRvPjccSQlZ/YMhxpxI5NeePJe/fH6Cc5O/RMPISNf3gmd01t/KvuKknSJpIdLVjEG9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741288282; c=relaxed/simple;
	bh=peKk5Blc5vU/zU2pSEP0C9PsETqGdlWRC7AfRakFdbs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TjzpHkaDozfMyJzyQ6WHtkcZQcCoKdznUeVwykA6oWvgZROPJFT4Oui1MyP71gIwIAs3suQhNqerE+F2pg/e5q6nY/9en593kXKpFlAKHH/OgFBYlx36Y+TJHVaByQ+ziS56cKY9ajW837NWGoWEsQyfHkzPktpqni7zxxdiBs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLq897f7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC26C4CEE0;
	Thu,  6 Mar 2025 19:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741288282;
	bh=peKk5Blc5vU/zU2pSEP0C9PsETqGdlWRC7AfRakFdbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KLq897f77OEbMo/Ti6BisEyerdb2XVm50suDH88PJf7BuKXaxRRfwCLp9vQWxbEDE
	 u19vjuxJSZpCYiN+uYxh539qhk/CbYKT7HEklbJsSfkmsbIIRmFHuPZZo8PGiXZqUU
	 1HsZhKHBqYUAD8mOjoX1nSyngY5o0abuyPbFHxZaQmNKgwu3lFfuXOV2FCPACmgRum
	 tErWuHzgoMS0iPfnwAIjd9Wn5bn0TF43eToCp/R1ZQvlDYw08v6Jiawo8ddFfWy5DZ
	 jzA+NSiyaLmyOVaUFY2143Hqn8co2dbh+qaaGHVS29as0MIxk4Q0DjhOZTZ0G0ARt5
	 MLq5Gw0zNBJgQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	zohar@linux.ibm.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] ima: Reset IMA_NONACTION_RULE_FLAGS after post_setattr
Date: Thu,  6 Mar 2025 14:11:20 -0500
Message-Id: <20250306112709-ece888969576e60b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250306022833.6151-1-zohar@linux.ibm.com>
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
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 57a0ef02fefafc4b9603e33a18b669ba5ce59ba3

WARNING: Author mismatch between patch and found commit:
Backport author: Mimi Zohar<zohar@linux.ibm.com>
Commit author: Roberto Sassu<roberto.sassu@huawei.com>

Note: The patch differs from the upstream commit:
---
1:  57a0ef02fefaf ! 1:  6f8f39f341145 ima: Reset IMA_NONACTION_RULE_FLAGS after post_setattr
    @@ Commit message
         Fixes: 0d73a55208e9 ("ima: re-introduce own integrity cache lock")
         Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
         Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
    -
    - ## security/integrity/ima/ima.h ##
    -@@ security/integrity/ima/ima.h: struct ima_kexec_hdr {
    - #define IMA_CHECK_BLACKLIST	0x40000000
    - #define IMA_VERITY_REQUIRED	0x80000000
    - 
    -+/* Exclude non-action flags which are not rule-specific. */
    -+#define IMA_NONACTION_RULE_FLAGS	(IMA_NONACTION_FLAGS & ~IMA_NEW_FILE)
    -+
    - #define IMA_DO_MASK		(IMA_MEASURE | IMA_APPRAISE | IMA_AUDIT | \
    - 				 IMA_HASH | IMA_APPRAISE_SUBMASK)
    - #define IMA_DONE_MASK		(IMA_MEASURED | IMA_APPRAISED | IMA_AUDITED | \
    +    (cherry picked from commit 57a0ef02fefafc4b9603e33a18b669ba5ce59ba3)
     
      ## security/integrity/ima/ima_main.c ##
     @@ security/integrity/ima/ima_main.c: static int process_measurement(struct file *file, const struct cred *cred,
    @@ security/integrity/ima/ima_main.c: static int process_measurement(struct file *f
      
      	/*
      	 * Re-evaulate the file if either the xattr has changed or the
    +
    + ## security/integrity/integrity.h ##
    +@@
    + #define IMA_CHECK_BLACKLIST	0x40000000
    + #define IMA_VERITY_REQUIRED	0x80000000
    + 
    ++/* Exclude non-action flags which are not rule-specific. */
    ++#define IMA_NONACTION_RULE_FLAGS	(IMA_NONACTION_FLAGS & ~IMA_NEW_FILE)
    ++
    + #define IMA_DO_MASK		(IMA_MEASURE | IMA_APPRAISE | IMA_AUDIT | \
    + 				 IMA_HASH | IMA_APPRAISE_SUBMASK)
    + #define IMA_DONE_MASK		(IMA_MEASURED | IMA_APPRAISED | IMA_AUDITED | \
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

