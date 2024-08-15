Return-Path: <stable+bounces-68275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 639C1953174
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 15:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ECAE1F2169D
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 13:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321A919DFA6;
	Thu, 15 Aug 2024 13:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pBq/B1wV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E422E1714A1;
	Thu, 15 Aug 2024 13:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730052; cv=none; b=udfsMzzIMJfjiURDmT+KW/oc6XQIbo04XhVQW/nWg4Y+j9gSWEK2ElkKqNk6EH5EfT6H5pFgnMfn5bwNsK4HNTW12Hc5J8fU/lH1YLnotcCuKU4gUiTXwNB/KTLV1NbjNO1miHzEqkxoSigTA1MrP1zQhg6VcXYckUd4B2S8j+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730052; c=relaxed/simple;
	bh=ryFqPWKvOWBX3ndThv21aPbtokymiZdhm0f51TbgrEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tyMs5ytN3bAXFnPgSTobSozmLnDg6HQdrJJ0+9qjQ/EdZWBcp/YKm34LuZHGJVBv7pjVny1EW/bb2Ap03i/4xiLvpMub0HejziYlRVvpRVi0QnPGvCj8vqcu9Cnj8fbprO/QwQbMZkGpPbd/uk977Ox573Mv9WZvbw6/cwZx11Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pBq/B1wV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E398DC32786;
	Thu, 15 Aug 2024 13:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723730051;
	bh=ryFqPWKvOWBX3ndThv21aPbtokymiZdhm0f51TbgrEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pBq/B1wVTBO8ZflzADTQISufbCLgqOWg/UwXokyZPjA2gGli57oPDkJ0/2Rl3eCg3
	 X563IYeDkDyUjj17z5oU0Ojmo2VFDQACLxCnxTDCMqTRPwXGrw95cWaO27cofAzFVO
	 E0yrphCS9/4PvFRD4prfBgQhlAg1z7T91V4HykWM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Takashi Iwai <tiwai@suse.de>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 288/484] ASoC: Intel: use soc_intel_is_byt_cr() only when IOSF_MBI is reachable
Date: Thu, 15 Aug 2024 15:22:26 +0200
Message-ID: <20240815131952.532450255@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131941.255804951@linuxfoundation.org>
References: <20240815131941.255804951@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit 9931f7d5d251882a147cc5811060097df43e79f5 ]

the Intel kbuild bot reports a link failure when IOSF_MBI is built-in
but the Merrifield driver is configured as a module. The
soc-intel-quirks.h is included for Merrifield platforms, but IOSF_MBI
is not selected for that platform.

ld.lld: error: undefined symbol: iosf_mbi_read
>>> referenced by atom.c
>>>               sound/soc/sof/intel/atom.o:(atom_machine_select) in archive vmlinux.a

This patch forces the use of the fallback static inline when IOSF_MBI is not reachable.

Fixes: 536cfd2f375d ("ASoC: Intel: use common helpers to detect CPUs")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202407160704.zpdhJ8da-lkp@intel.com/
Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://patch.msgid.link/20240722083002.10800-1-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/common/soc-intel-quirks.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/common/soc-intel-quirks.h b/sound/soc/intel/common/soc-intel-quirks.h
index de4e550c5b34d..42bd51456b945 100644
--- a/sound/soc/intel/common/soc-intel-quirks.h
+++ b/sound/soc/intel/common/soc-intel-quirks.h
@@ -11,7 +11,7 @@
 
 #include <linux/platform_data/x86/soc.h>
 
-#if IS_ENABLED(CONFIG_X86)
+#if IS_REACHABLE(CONFIG_IOSF_MBI)
 
 #include <linux/dmi.h>
 #include <asm/iosf_mbi.h>
-- 
2.43.0




