Return-Path: <stable+bounces-168408-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF616B23494
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D299D7AF292
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65362FF17D;
	Tue, 12 Aug 2025 18:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cdiMK8Z5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934F32FE597;
	Tue, 12 Aug 2025 18:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755024069; cv=none; b=bkaVUE8Rxd69KYz3DaOe0GDa4KF9sqX7x4z57lM1ITU9KehAyk6yZBsv8/Signj0+bDUpTcqkZ8e+zIn4f7JOvcsfKxXnJJGPQHrNulZgIp5YB6PO9ZvlHzX2jOGJAAqtFzJOwJA7ms66xHtAdxbsYsD8KtowNg8rchXOSQmuVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755024069; c=relaxed/simple;
	bh=a1EB9HRancx8F1eEHOn7Qx/CWr1TzX+qvpPlFrqibbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s25ZsYP2pdUCeerFOMkGEFXfZg4jxJHwutFpkCjQizJ/y+2S555nxSXpPFVX9Qe9gLw4lNXJyGpzDHpNjI3SZITh5AdoqgkXSsfPR/N/e3DsQi9E28+X6UZrX2No2xB1WCGJOOEEtTUVR7ILbF9E11nW48YvtRV3PHDXT003e1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cdiMK8Z5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B47BC4CEF0;
	Tue, 12 Aug 2025 18:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755024069;
	bh=a1EB9HRancx8F1eEHOn7Qx/CWr1TzX+qvpPlFrqibbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cdiMK8Z5pLgNdMgHrySannp0HGmzqBlhV0rxOS2ZFEvmTU0tvn5rfM/aBEjnh/S2N
	 eFu/eTgV/pXOtQ7Jxj6QTElZX+SSlGOmxZ8zhG+V5iXbRpIPna3Uy/A0jE2h1Ntxcl
	 ohGLeHw7IOJzCtw7c4I6oa9xrru473+Q2SOkQKaw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nimrod Oren <noren@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 264/627] selftests: drv-net: Fix remote command checking in require_cmd()
Date: Tue, 12 Aug 2025 19:29:19 +0200
Message-ID: <20250812173429.357279156@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173419.303046420@linuxfoundation.org>
References: <20250812173419.303046420@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gal Pressman <gal@nvidia.com>

[ Upstream commit b4d52c698210ae1a3ceb487b189701bc70551a48 ]

The require_cmd() method was checking for command availability locally
even when remote=True was specified, due to a missing host parameter.

Fix by passing host=self.remote when checking remote command
availability, ensuring commands are verified on the correct host.

Fixes: f1e68a1a4a40 ("selftests: drv-net: add require_XYZ() helpers for validating env")
Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
Link: https://patch.msgid.link/20250723135454.649342-2-gal@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/drivers/net/lib/py/env.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index 3bccddf8cbc5..1b8bd648048f 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -259,7 +259,7 @@ class NetDrvEpEnv(NetDrvEnvBase):
             if not self._require_cmd(comm, "local"):
                 raise KsftSkipEx("Test requires command: " + comm)
         if remote:
-            if not self._require_cmd(comm, "remote"):
+            if not self._require_cmd(comm, "remote", host=self.remote):
                 raise KsftSkipEx("Test requires (remote) command: " + comm)
 
     def wait_hw_stats_settle(self):
-- 
2.39.5




