Return-Path: <stable+bounces-152898-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B20ADD160
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 17:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D503017C347
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 15:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4C52EB5D6;
	Tue, 17 Jun 2025 15:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tl3RCtbG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB302E92AA;
	Tue, 17 Jun 2025 15:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750174185; cv=none; b=eAsXUE94/Gsm0vR3tEOlOwxBqwYF+3h7FHyMOD4gBcl4vRlgzogcIjwFeddZ6pPQLBxiv+6zQiupzuy+dcrDUXNowD5nVanRS+pK34FtaWuDhP+sQfll+DAqHok/dpu6wtgekzv/xiqR9Z1V7PY9F8vROST/ncFKL8MEQ1I9n8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750174185; c=relaxed/simple;
	bh=bmdBg43wsdCvpN0FGQtEg/FkVTW2PaYbWTuwDFKBGko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PVeTdB5GgcSs5Tbs2s2dvcVOr822kw8Xbd+DKve381z6/X4HdCT6eJv52hHSBCi3zq2vwMtwmg78ASDPDvrmsSrcOn0V8xI6O6Th9XBApZ5wlUZyFKUku2yRP9VQt1pqp9CcxVxhfajQb6tt6OYBodxdLJxe3k0ZwwoRRK82/T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tl3RCtbG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A90C4CEE3;
	Tue, 17 Jun 2025 15:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750174185;
	bh=bmdBg43wsdCvpN0FGQtEg/FkVTW2PaYbWTuwDFKBGko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tl3RCtbGEv26QduiZDFhE9rca1nhN+VMeA1EKCf+a+YOf4PRGdOZOGgtUjfKNLz9g
	 JgNs21BlbkZ1MxBfGViD7X8G4OrKCqQ/FjG51apt8n1X23kgLl5yQPnNfADBslnF3G
	 Zq4SB4j5FA37fr10/y6siieH+2B/BLjEtltTqzYE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Manu Bretelle <chantr4@gmail.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6.6 004/356] acpi-cpufreq: Fix nominal_freq units to KHz in get_max_boost_ratio()
Date: Tue, 17 Jun 2025 17:21:59 +0200
Message-ID: <20250617152338.396363842@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152338.212798615@linuxfoundation.org>
References: <20250617152338.212798615@linuxfoundation.org>
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

From: Gautham R. Shenoy <gautham.shenoy@amd.com>

commit cb6a85f38f456b086c366e346ebb67ffa70c7243 upstream.

commit 083466754596 ("cpufreq: ACPI: Fix max-frequency computation")
modified get_max_boost_ratio() to return the nominal_freq advertised
in the _CPC object. This was for the purposes of computing the maximum
frequency. The frequencies advertised in _CPC objects are in
MHz. However, cpufreq expects the frequency to be in KHz. Since the
nominal_freq returned by get_max_boost_ratio() was not in KHz but
instead in MHz,the cpuinfo_max_frequency that was computed using this
nominal_freq was incorrect and an invalid value which resulted in
cpufreq reporting the P0 frequency as the cpuinfo_max_freq.

Fix this by converting the nominal_freq to KHz before returning the
same from get_max_boost_ratio().

Reported-by: Manu Bretelle <chantr4@gmail.com>
Closes: https://lore.kernel.org/lkml/aDaB63tDvbdcV0cg@HQ-GR2X1W2P57/
Fixes: 083466754596 ("cpufreq: ACPI: Fix max-frequency computation")
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Cc: 6.14+ <stable@vger.kernel.org> # 6.14+
Link: https://patch.msgid.link/20250529085143.709-1-gautham.shenoy@amd.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cpufreq/acpi-cpufreq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -659,7 +659,7 @@ static u64 get_max_boost_ratio(unsigned
 	nominal_perf = perf_caps.nominal_perf;
 
 	if (nominal_freq)
-		*nominal_freq = perf_caps.nominal_freq;
+		*nominal_freq = perf_caps.nominal_freq * 1000;
 
 	if (!highest_perf || !nominal_perf) {
 		pr_debug("CPU%d: highest or nominal performance missing\n", cpu);



