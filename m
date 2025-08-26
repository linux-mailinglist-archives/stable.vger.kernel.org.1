Return-Path: <stable+bounces-174586-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AA6B3640E
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E37648A7ED5
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470BC230BDF;
	Tue, 26 Aug 2025 13:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lBpZHbbU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0135017A2EA;
	Tue, 26 Aug 2025 13:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214785; cv=none; b=cgS7wSEdGsks+WYcTvUFQwphRCUK3tIobiGB/goUjYAsCTPazJE5RvoWZryh3jPFOZnHdVB5+gudCvIpWHn3nmxkLmTlNx9lR6T157KxstVpCd6nlDfSb/WEr/QPDKs2xNLRV2EzFCYNt9eLzBwNqALhxLH5/bUEp9Tci12ZPVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214785; c=relaxed/simple;
	bh=UJqvyY/dtkPHwcgGNHfcLsbRGfMzfPWPTt8Djx4pwQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XZSyS/U7O9W10qHecGCtKjRopOU1XqUxGELAY20Ak6sB/jNGSU4YDbnJjaLBN4Kjo2QLyDAcD/kvu/lPhfLRJh1q2MegJ4W60DmW4eZjoXSrUS7TBheDwxUcJxscLT7NNGfwsljo7ugJmyDZCzc6mxyRMaJYFNAqG0DNBWYrDhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lBpZHbbU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88CC6C4CEF1;
	Tue, 26 Aug 2025 13:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756214784;
	bh=UJqvyY/dtkPHwcgGNHfcLsbRGfMzfPWPTt8Djx4pwQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lBpZHbbUp1bxzASlFvepSlgJwLBjan8mqV3CAFhhnWZVbxqwZ9o0VKsG4t8X+V1w4
	 iN3w2rC/ab2yu0f994OSyWKDvQLaRf84CZ2tL9mAN6TAHlL18xEaI30VrrixVD+14h
	 yL6p6zqRyicBeiEbn4R2jG+VYv50p+1sgL7Dwhpc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 6.1 268/482] cpufreq: armada-8k: Fix off by one in armada_8k_cpufreq_free_table()
Date: Tue, 26 Aug 2025 13:08:41 +0200
Message-ID: <20250826110937.387914806@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110930.769259449@linuxfoundation.org>
References: <20250826110930.769259449@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

commit 4a26df233266a628157d7f0285451d8655defdfc upstream.

The freq_tables[] array has num_possible_cpus() elements so, to avoid an
out of bounds access, this loop should be capped at "< nb_cpus" instead
of "<= nb_cpus".  The freq_tables[] array is allocated in
armada_8k_cpufreq_init().

Cc: stable@vger.kernel.org
Fixes: f525a670533d ("cpufreq: ap806: add cpufreq driver for Armada 8K")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cpufreq/armada-8k-cpufreq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/cpufreq/armada-8k-cpufreq.c
+++ b/drivers/cpufreq/armada-8k-cpufreq.c
@@ -96,7 +96,7 @@ static void armada_8k_cpufreq_free_table
 {
 	int opps_index, nb_cpus = num_possible_cpus();
 
-	for (opps_index = 0 ; opps_index <= nb_cpus; opps_index++) {
+	for (opps_index = 0 ; opps_index < nb_cpus; opps_index++) {
 		int i;
 
 		/* If cpu_dev is NULL then we reached the end of the array */



