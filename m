Return-Path: <stable+bounces-133121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EB7A91E19
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 15:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B9027B2EDA
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855E8241679;
	Thu, 17 Apr 2025 13:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Id0YUpiQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FE535948
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 13:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744896566; cv=none; b=m0rXBAefznTtiaYW/m1OSRY686JJT8w9v4dCFAeuTVDjWB5F3hcrqSrCS5639EoKBVpT+wlrzEAG/u/zA6F7yexf8yWjVS8QkEWHMCUdFj+I+9fqSm+x2N9Bg4qU7cSkDFLonLgukH0sRuIBlsw+gvBDemcoepzTv4TdtaHUlvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744896566; c=relaxed/simple;
	bh=j4wAo9b28xeMMVZRlmeK8vHXpUyGhCIH6Hajnk97TuU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pFgF812mquOalQnIQxnF/Nj3DpP3d0mZYramyE0n2LjfhGtqPjkcLwI9w4NiZFR9beXaz6xiWGOBRSybvHH9KuDeLH9m0vGUAKMI8nhWaNAjTdsMizZWZTK/qhvTq+LcftsXTqRwm75tlJz5sh5OrJogPjvEfoFVDWaxcZAi6BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Id0YUpiQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417EDC4CEE4;
	Thu, 17 Apr 2025 13:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744896565;
	bh=j4wAo9b28xeMMVZRlmeK8vHXpUyGhCIH6Hajnk97TuU=;
	h=Subject:To:Cc:From:Date:From;
	b=Id0YUpiQHYXi/jw4KfST8Gd2ArGkzkPn5TQzG/smsav993yLnmv6EZ21NVUCGk3cg
	 BmUCkDNHTYLbcXqsd1yT0nv/9uaw0ay8Vd0+6FkalfTUU13RUh+nfNsO63C70KwY3K
	 KrtyZSOEco5IcwmhegIZUlv7J/Iej9h7pHlwucmo=
Subject: FAILED: patch "[PATCH] cpufreq: Reference count policy in cpufreq_update_limits()" failed to apply to 5.10-stable tree
To: rafael.j.wysocki@intel.com,marmarek@invisiblethingslab.com,stable@vger.kernel.org,viresh.kumar@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 15:28:17 +0200
Message-ID: <2025041717-ethanol-copartner-7800@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 9e4e249018d208678888bdf22f6b652728106528
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041717-ethanol-copartner-7800@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9e4e249018d208678888bdf22f6b652728106528 Mon Sep 17 00:00:00 2001
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date: Fri, 28 Mar 2025 21:39:08 +0100
Subject: [PATCH] cpufreq: Reference count policy in cpufreq_update_limits()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since acpi_processor_notify() can be called before registering a cpufreq
driver or even in cases when a cpufreq driver is not registered at all,
cpufreq_update_limits() needs to check if a cpufreq driver is present
and prevent it from being unregistered.

For this purpose, make it call cpufreq_cpu_get() to obtain a cpufreq
policy pointer for the given CPU and reference count the corresponding
policy object, if present.

Fixes: 5a25e3f7cc53 ("cpufreq: intel_pstate: Driver-specific handling of _PPC updates")
Closes: https://lore.kernel.org/linux-acpi/Z-ShAR59cTow0KcR@mail-itl
Reported-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Link: https://patch.msgid.link/1928789.tdWV9SEqCh@rjwysocki.net

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 0cf5a320bb5e..3841c9da6cac 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2809,6 +2809,12 @@ EXPORT_SYMBOL(cpufreq_update_policy);
  */
 void cpufreq_update_limits(unsigned int cpu)
 {
+	struct cpufreq_policy *policy __free(put_cpufreq_policy);
+
+	policy = cpufreq_cpu_get(cpu);
+	if (!policy)
+		return;
+
 	if (cpufreq_driver->update_limits)
 		cpufreq_driver->update_limits(cpu);
 	else


