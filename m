Return-Path: <stable+bounces-196043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B189FC79926
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 14:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 14F852CE2B
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 13:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2699A34CFD1;
	Fri, 21 Nov 2025 13:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="155KuVhp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76233A291;
	Fri, 21 Nov 2025 13:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763732398; cv=none; b=ckEpC6WaTIiLCqw8TN/5QJRQxS4csOmpKstcoNatZSpxuAJnb0cp7JVvBqM8769TDIk5DeZROsdnVqZa0a8ko0sJGEtL+8OKRuW2ERCmvi1f6p7M4bDilyHlVjQTXMYclpzI4N5OE3NAi3m+Re3QRhW4/zOW45sDjnrfxADJHsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763732398; c=relaxed/simple;
	bh=gBWYF/QlM6Jjrc/fGfw+vYaKTKwOlPLVzy7DlC+PQ2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fauFxWCxacN0ezIlWpIu3pCdg998zxt0mJBNN9bSZK48sVmZbpurMyovA+Y2bt0dOfnNpcuS8mrUjbT4ZWxWylcGoEXGuarZmgBoalG/fuoz4K8BRNbvS1ohDT78c5oRFb6LbBvnRSnrtCz8y0jVDTiw4lv73iXABXcjlE9eWzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=155KuVhp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6103DC4CEF1;
	Fri, 21 Nov 2025 13:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763732398;
	bh=gBWYF/QlM6Jjrc/fGfw+vYaKTKwOlPLVzy7DlC+PQ2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=155KuVhpLL5e1mj54gShrKdTH3RfYQMKyM5NkyqlKQtzLCWa7fm8Wr9bh7lRGIWjY
	 IUF3YRBr5ki1vDAmhzysUYs1Y7cp1jNtOyZSNzflJQpIJO5U+w4aZKc6V8x8sDOMQF
	 fJNRoDRjq+wLPXAVaMOaZ1Zw369BDwnS7Nt0+hCo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>,
	Len Brown <len.brown@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 108/529] tools/power x86_energy_perf_policy: Fix incorrect fopen mode usage
Date: Fri, 21 Nov 2025 14:06:47 +0100
Message-ID: <20251121130234.868356200@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251121130230.985163914@linuxfoundation.org>
References: <20251121130230.985163914@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>

[ Upstream commit 62127655b7ab7b8c2997041aca48a81bf5c6da0c ]

The fopen_or_die() function was previously hardcoded
to open files in read-only mode ("r"), ignoring the
mode parameter passed to it. This patch corrects
fopen_or_die() to use the provided mode argument,
allowing for flexible file access as intended.

Additionally, the call to fopen_or_die() in
err_on_hypervisor() incorrectly used the mode
"ro", which is not a valid fopen mode. This is
fixed to use the correct "r" mode.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index ebda9c366b2ba..c883f211dbcc9 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -630,7 +630,7 @@ void cmdline(int argc, char **argv)
  */
 FILE *fopen_or_die(const char *path, const char *mode)
 {
-	FILE *filep = fopen(path, "r");
+	FILE *filep = fopen(path, mode);
 
 	if (!filep)
 		err(1, "%s: open failed", path);
@@ -644,7 +644,7 @@ void err_on_hypervisor(void)
 	char *buffer;
 
 	/* On VMs /proc/cpuinfo contains a "flags" entry for hypervisor */
-	cpuinfo = fopen_or_die("/proc/cpuinfo", "ro");
+	cpuinfo = fopen_or_die("/proc/cpuinfo", "r");
 
 	buffer = malloc(4096);
 	if (!buffer) {
-- 
2.51.0




