Return-Path: <stable+bounces-175258-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 499D5B36695
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2896B612F5
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBFC34DCD2;
	Tue, 26 Aug 2025 13:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cT+gNtYQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103B9226861;
	Tue, 26 Aug 2025 13:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216562; cv=none; b=ZEmxCoNH4ASeDTsPXUf8n9oLeECw+raNlqc5+o90+P+XeD92jKXK0dEkc96vHIUFq0sVBt7yX0dxZDZ0J55558yz544MPYQX5L5k5qYVguiNPRHnrgho5q+a/nyLrzu+HmzNLczeJZL8mcA9dLyO/Aw/sP2rWtCeWFeS54tvqTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216562; c=relaxed/simple;
	bh=WjJwW2TaoAMGkd+Eh6mZA8WLl/ERSnTPztqHFPusT/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Onk/wLWcBRb4Lec+9a8CpwMtvPWAsUaSVEzH+pwDOAoTS6BnF7nldVY9RfqUHRZVGNbqw/trrMKlh6IvVcTG/+cPLGXy3HKdTTb0M8BnJ4ahN9Um519innO+pG/yWlFirRsZK7VSSkgjhCrsjMgys5DotO6PGIPAXE13HNX38v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cT+gNtYQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93FD1C4CEF1;
	Tue, 26 Aug 2025 13:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756216561;
	bh=WjJwW2TaoAMGkd+Eh6mZA8WLl/ERSnTPztqHFPusT/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cT+gNtYQkPRtUlsE14NnmwmRL38t1TEyDqRoj14ZieFiLzRzLwhhRfKivZEJGVrHD
	 eE/EiSVXVn/enHncJ8dau8bxTSK7yKOhIrSeS8krhzvnff9pWohoBw19ay/Lq9U7lQ
	 DzQSgTKJHLHHqW16luTHs/9Dax4WpbEKAEuGOJsQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 5.15 457/644] cpufreq: armada-8k: Fix off by one in armada_8k_cpufreq_free_table()
Date: Tue, 26 Aug 2025 13:09:08 +0200
Message-ID: <20250826110957.800603271@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110946.507083938@linuxfoundation.org>
References: <20250826110946.507083938@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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



