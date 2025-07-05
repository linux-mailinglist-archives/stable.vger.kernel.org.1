Return-Path: <stable+bounces-160266-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC21AAFA21A
	for <lists+stable@lfdr.de>; Sat,  5 Jul 2025 23:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EBEF1BC8434
	for <lists+stable@lfdr.de>; Sat,  5 Jul 2025 21:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D798291C31;
	Sat,  5 Jul 2025 21:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihLv7uSn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAC52641E3
	for <stable@vger.kernel.org>; Sat,  5 Jul 2025 21:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751751627; cv=none; b=m5c1ox6M0qUEcBS9d7QEdJQ44FdRqWmT2lzloNp5XHcyRtEAPKVrvIu3/bUPAAiiKLrMX53qIMSKBmtBPoHAqM46nSSHVJzJ2ZU+GRgsOnnFWYr8z0iO1e7MkRIQU86/JVuoMpLLDVujjmRzo/3KhdWHjwJXOaiVghXftQai36w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751751627; c=relaxed/simple;
	bh=ijtAeujOQytHTMEOZsD0eymoCoOIu2ycWHraqIP0YKI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T2om/qwnr7YLgXoEuaMqWoAALFFj+nUqwFsCX/xyV9HmqoiXYXbqojNhXq34NStXf/D1N8Myddl+iVfqx3V1+zTJKsUgvVY8ICpn8foV37Bubx0MGFKVeSLVpzy2UxjHeZ9bUvnR+W7CaXZbemnLaz0ga9qjZAKconUTH4gSYD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihLv7uSn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A19EC4CEE7;
	Sat,  5 Jul 2025 21:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751751626;
	bh=ijtAeujOQytHTMEOZsD0eymoCoOIu2ycWHraqIP0YKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ihLv7uSn7+CkiVkBXYOE0oPkUIl1ZOaN1712wANnRpNOoVXZZB2nitOOQjiSEkmxH
	 0xJ/2SdC1bd65SsxcbU3Z3fCnBYDvIrThuB+5vtWJhq2oVpMpAhHO60ZBlBfd/kM2W
	 g8IOjH5CQAmIAEFttpEGmK+JsrRKpiT+EwnFElYVc9P7JOJiNECBlvkE3Du1xFuNrP
	 G+lAUS1/JoKeFVZM3vq0AfdOPbJN9pmxpRzJVpFwd7ttexNBob+6hEulD/H2MsW/qi
	 gNecZpitsL9jmkGqdtoyXodnypOwz4hF/VeNvku/X2UawXcmeQUL30C7hOr4HwDcHF
	 cD0qBFSTHx47w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	kees@kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] mod_devicetable: Enlarge the maximum platform_device_id name length
Date: Sat,  5 Jul 2025 17:40:25 -0400
Message-Id: <20250705153719-a8f20b3a61d3dd27@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250415231420.work.066-kees@kernel.org>
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

Found matching upstream commit: 655862865c97ff55e4f3f2aaa7708f42f0ea3bd8

Note: The patch differs from the upstream commit:
---
1:  655862865c97f ! 1:  b545ae48a3db0 mod_devicetable: Enlarge the maximum platform_device_id name length
    @@ Commit message
                 /* last cacheline: 32 bytes */
         };
     
    -    Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    -    Link: https://lore.kernel.org/r/20250415231420.work.066-kees@kernel.org
         Signed-off-by: Kees Cook <kees@kernel.org>
     
      ## include/linux/mod_devicetable.h ##
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.15.y       |  Success    |  Success   |
| stable/linux-6.12.y       |  Success    |  Success   |
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-5.15.y       |  Success    |  Success   |
| stable/linux-5.10.y       |  Success    |  Success   |
| stable/linux-5.4.y        |  Success    |  Success   |

