Return-Path: <stable+bounces-82577-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B875994D71
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD9D81C24BD0
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148C01DE4CD;
	Tue,  8 Oct 2024 13:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e7beyO+L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58951C9B99;
	Tue,  8 Oct 2024 13:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728392728; cv=none; b=jB2sYTgveArNNudN7o+znltPDFhqjLojlaTfM8BYGazpspj/d+RW5pyBaA3C2poPHM82d732o34ELlazKgaxQ53amxcK8Q2g2aMCmQCM4saE6KwmYmr3h1WgRwxyat1eqcPa4E/PH+T/kOZPDcJaj9+kJIoS4YzgQ2pajvphGfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728392728; c=relaxed/simple;
	bh=sT43mvBk4G1NrMGFcQ4nKuL9fBpStAI670x9SHQhRC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uW3OeKMxcHYVoXYipmL0ylW9u4951stB0d2VZ1o2u86P4rpw1z9VYPr28raEz4d7N3dSH99JgzEStnkZyU3qqMdB5iVKZA0XRV6FuKkq1QKTYSa3j8T2r2S5jxOvM7zmrcrRVkjA/+9arFPwuDp809hGU5pu0HECeFGliJhs5eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e7beyO+L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A63C4CEC7;
	Tue,  8 Oct 2024 13:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728392728;
	bh=sT43mvBk4G1NrMGFcQ4nKuL9fBpStAI670x9SHQhRC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e7beyO+Ly49lKlROTUXJ8V/IEVWXAw7/xImvuLamMTRUggI51PfdrvvJklGMuzAWJ
	 OSgYYFLxHnBDsjiYGl4CRWbyv/PpfOPZM8Ikzzyr2gF7Jar1EBGAM2FrZojxGaR9um
	 nYNVf44IvJomTau2LOYuD951mrFswFsHfpaeJdbc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mikisabate@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6.11 501/558] cpufreq: Avoid a bad reference count on CPU node
Date: Tue,  8 Oct 2024 14:08:51 +0200
Message-ID: <20241008115721.947407277@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115702.214071228@linuxfoundation.org>
References: <20241008115702.214071228@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miquel Sabaté Solà <mikisabate@gmail.com>

commit c0f02536fffbbec71aced36d52a765f8c4493dc2 upstream.

In the parse_perf_domain function, if the call to
of_parse_phandle_with_args returns an error, then the reference to the
CPU device node that was acquired at the start of the function would not
be properly decremented.

Address this by declaring the variable with the __free(device_node)
cleanup attribute.

Signed-off-by: Miquel Sabaté Solà <mikisabate@gmail.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Link: https://patch.msgid.link/20240917134246.584026-1-mikisabate@gmail.com
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/cpufreq.h |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -1113,10 +1113,9 @@ static inline int parse_perf_domain(int
 				    const char *cell_name,
 				    struct of_phandle_args *args)
 {
-	struct device_node *cpu_np;
 	int ret;
 
-	cpu_np = of_cpu_device_node_get(cpu);
+	struct device_node *cpu_np __free(device_node) = of_cpu_device_node_get(cpu);
 	if (!cpu_np)
 		return -ENODEV;
 
@@ -1124,9 +1123,6 @@ static inline int parse_perf_domain(int
 					 args);
 	if (ret < 0)
 		return ret;
-
-	of_node_put(cpu_np);
-
 	return 0;
 }
 



