Return-Path: <stable+bounces-157951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28032AE5697
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41A354A144A
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77503218EBF;
	Mon, 23 Jun 2025 22:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V5heGpxj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322531F6667;
	Mon, 23 Jun 2025 22:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750717119; cv=none; b=B6euozuPhDGsbsXxKxWT6Q6gyx2i3QGDE/+uFKytjtqWKyHPsVJP+3RF2i+SrpC0aiHtUrVEOozPdrEko0D58pxURP/n/9rPYQOLsc6qh0scL6RceT/Wuud4ip+SbeI8Z9Z1x/pTLwlgNVKIVmb4lhg+L4JFNE85BUmqntslBXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750717119; c=relaxed/simple;
	bh=eplzBX0dQA1j/FTd+zSCRlTL4nUuOkl3NWrBaYjdYhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q2ywfOqga9CY1DvK8Yx10xz9pa/DtFOrMYKDZzCFWXwNhJ80j3HoCIVALhxpelUqdDnsMjDLKFVfeBqADQcd9wOUwvCkqH2EqP3JPr92C5g2EInZzQFHEFCz0dbF9lWwPbHkPVwc22krc0oHpDsswt70pPxsZzMFCxm4zNGEjj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V5heGpxj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF3DC4CEEA;
	Mon, 23 Jun 2025 22:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750717119;
	bh=eplzBX0dQA1j/FTd+zSCRlTL4nUuOkl3NWrBaYjdYhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V5heGpxjXt2rXUWFwhO9SUi8UyQjM2bJO7enuUnI9n6Ac8jUPat9mdQZF64BkwBOa
	 BmGNbWX4JcCeWH5aGJXkE3fhEVOHL/essFtIeWb8RXRB7+knMdtltgMAO0qU94itS8
	 h6TYQ8vJOesWkHXPgWC+/yHA30wjH282YNpQ1Rag=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Wenshan Lan <jetlan9@163.com>
Subject: [PATCH 6.12 326/414] cpufreq/amd-pstate: Add missing NULL ptr check in amd_pstate_update
Date: Mon, 23 Jun 2025 15:07:43 +0200
Message-ID: <20250623130650.141970876@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130642.015559452@linuxfoundation.org>
References: <20250623130642.015559452@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>

commit 426db24d4db2e4f0d6720aeb7795eafcb9e82640 upstream.

Check if policy is NULL before dereferencing it in amd_pstate_update.

Fixes: e8f555daacd3 ("cpufreq/amd-pstate: fix setting policy current frequency value")
Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Link: https://lore.kernel.org/r/20250205112523.201101-11-dhananjay.ugwekar@amd.com
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
[Minor context change fixed.]
Signed-off-by: Wenshan Lan <jetlan9@163.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cpufreq/amd-pstate.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -482,6 +482,9 @@ static void amd_pstate_update(struct amd
 	u32 nominal_perf = READ_ONCE(cpudata->nominal_perf);
 	u64 value = prev;
 
+	if (!policy)
+		return;
+
 	min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
 			cpudata->max_limit_perf);
 	max_perf = clamp_t(unsigned long, max_perf, cpudata->min_limit_perf,



