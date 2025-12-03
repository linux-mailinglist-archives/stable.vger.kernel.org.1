Return-Path: <stable+bounces-198980-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59872CA0EC1
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 19:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54CC93005AB4
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 18:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923063469FE;
	Wed,  3 Dec 2025 16:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1GK2hGEZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504C93469EF;
	Wed,  3 Dec 2025 16:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764778302; cv=none; b=TdfoXfgqV2hxwaTzny+41xT56YUE+j/TYtC8qHxRKtvJxPurXEQfsiI8hbPwKrk7ZnPwQQ74xfjhTmgHb6gtyfA/4Qjl3VLlQhAzJXqhbpGX323FXVVFl8okxZ7XqD3fQ4a6dTQ6YzWa8R6pAmbxCJWwZf9Pi/P1HHr5600i/Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764778302; c=relaxed/simple;
	bh=K/rQe8sZgQDRZgTfz4gdyBhsRnCRiemLV8W1oPnUNCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I0g6hjLgs3/Y/pOZJwuqIwLH1/0gr+hkL/e/oSNgXYIgeCesHan6UvKSV+HortHRzQKWibIoQUouIHj6N8qEjbwvEjTy9SLj1jXUGg+JGcnRz7oz4IF9w6S3tGyHUPtZz71dXMFTOM0j+lELYzauhQwbLQoAOnJodcejcXVIArU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1GK2hGEZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC135C4CEF5;
	Wed,  3 Dec 2025 16:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764778302;
	bh=K/rQe8sZgQDRZgTfz4gdyBhsRnCRiemLV8W1oPnUNCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1GK2hGEZpkWsLBRc0oxDZ3rVE0HNqVCOyhYstxYcTELEFbb8m6FrHEB9KuRYZ8dIS
	 hKZXE/3VJH7ktIolQWl+bPrgd9XdHD41QTunvWPkIZW1M9uBwIr6pfOmz4pRNDj0as
	 uUSN7WxWbG3bvlkPEGW9dwCtVDMQwBZ2J63zx+20=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Edoardo Canepa <edoardo.canepa@canonical.com>,
	Po-Hsu Lin <po-hsu.lin@canonical.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 303/392] selftests: net: use BASH for bareudp testing
Date: Wed,  3 Dec 2025 16:27:33 +0100
Message-ID: <20251203152425.315943367@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152414.082328008@linuxfoundation.org>
References: <20251203152414.082328008@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Po-Hsu Lin <po-hsu.lin@canonical.com>

[ Upstream commit 9311e9540a8b406d9f028aa87fb072a3819d4c82 ]

In bareudp.sh, this script uses /bin/sh and it will load another lib.sh
BASH script at the very beginning.

But on some operating systems like Ubuntu, /bin/sh is actually pointed to
DASH, thus it will try to run BASH commands with DASH and consequently
leads to syntax issues:
  # ./bareudp.sh: 4: ./lib.sh: Bad substitution
  # ./bareudp.sh: 5: ./lib.sh: source: not found
  # ./bareudp.sh: 24: ./lib.sh: Syntax error: "(" unexpected

Fix this by explicitly using BASH for bareudp.sh. This fixes test
execution failures on systems where /bin/sh is not BASH.

Reported-by: Edoardo Canepa <edoardo.canepa@canonical.com>
Link: https://bugs.launchpad.net/bugs/2129812
Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Link: https://patch.msgid.link/20251027095710.2036108-2-po-hsu.lin@canonical.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/bareudp.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/bareudp.sh b/tools/testing/selftests/net/bareudp.sh
index f366cadbc5e86..ff4308b48e65d 100755
--- a/tools/testing/selftests/net/bareudp.sh
+++ b/tools/testing/selftests/net/bareudp.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
 # Test various bareudp tunnel configurations.
-- 
2.51.0




