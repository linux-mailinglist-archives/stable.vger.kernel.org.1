Return-Path: <stable+bounces-122295-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23995A59ED5
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071ED188B7A4
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33053230BF6;
	Mon, 10 Mar 2025 17:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d2RuiLT/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B9A22D4F4;
	Mon, 10 Mar 2025 17:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741628090; cv=none; b=YCrGqVv1JM2TGAPtffFkaclsnLLqgyKf5j10woYGMBBElIpZkgqc/3MdQbb4vnSr2bjCS+YNtkqDnM0HIQuPWFwX+LS4tqmjDdaa6G/sexaLraQoE0jbNzLuINFzJiGa5dWG/S2tgo+/M+KGxWzffi/UIF83XdrE5Ygl3XqGDrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741628090; c=relaxed/simple;
	bh=GoI7V0Oqm59EzFgvjygAm9yXuUWPY/PtMPbTx0UzgxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ngjrssgJ5yCW88LsGqxtUMN2Gf1V5nuDM3CG4Mq/PNYSUiMJZsIbRJuUOEkt0k6C+8c+vBvXzqu4N58QVs9aMCr5S7Zyp+NV8QKlMvzW1apAx55REUyYG2kR6Mv4M1Mvn6LjZhpy80Apz/mfjHLAU6g8hG0tM5gxVRzHgQPGha0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d2RuiLT/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F97C4CEE5;
	Mon, 10 Mar 2025 17:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741628089;
	bh=GoI7V0Oqm59EzFgvjygAm9yXuUWPY/PtMPbTx0UzgxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d2RuiLT/ZsS37aZ7nKUoNjgBciioUtVAnigmoAR9k9b7PRVxxlbnf+YXrC4GD0jTF
	 BzWHs6q7wCP/GfFZq+pyzWDWljT6fzSKi7jwWME+CbNIXHH+TjXpRKHvjsIkmDQPTR
	 EIhg6N2KVkHHJyX2ZGrnPM7ew1zVeq+ZAR0hd1m8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 083/145] x86/sgx: Fix size overflows in sgx_encl_create()
Date: Mon, 10 Mar 2025 18:06:17 +0100
Message-ID: <20250310170438.108267112@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170434.733307314@linuxfoundation.org>
References: <20250310170434.733307314@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jarkko Sakkinen <jarkko@kernel.org>

[ Upstream commit 0d3e0dfd68fb9e6b0ec865be9f3377cc3ff55733 ]

The total size calculated for EPC can overflow u64 given the added up page
for SECS.  Further, the total size calculated for shmem can overflow even
when the EPC size stays within limits of u64, given that it adds the extra
space for 128 byte PCMD structures (one for each page).

Address this by pre-evaluating the micro-architectural requirement of
SGX: the address space size must be power of two. This is eventually
checked up by ECREATE but the pre-check has the additional benefit of
making sure that there is some space for additional data.

Fixes: 888d24911787 ("x86/sgx: Add SGX_IOC_ENCLAVE_CREATE")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/r/20250305050006.43896-1-jarkko@kernel.org

Closes: https://lore.kernel.org/linux-sgx/c87e01a0-e7dd-4749-a348-0980d3444f04@stanley.mountain/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/sgx/ioctl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 5d390df214406..a59a0011c930a 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -64,6 +64,13 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
 	struct file *backing;
 	long ret;
 
+	/*
+	 * ECREATE would detect this too, but checking here also ensures
+	 * that the 'encl_size' calculations below can never overflow.
+	 */
+	if (!is_power_of_2(secs->size))
+		return -EINVAL;
+
 	va_page = sgx_encl_grow(encl, true);
 	if (IS_ERR(va_page))
 		return PTR_ERR(va_page);
-- 
2.39.5




