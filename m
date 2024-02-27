Return-Path: <stable+bounces-24094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCFD8692E6
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 559C0B2E7E0
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014A113B7AA;
	Tue, 27 Feb 2024 13:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oMxIUfmt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FD913B2B3;
	Tue, 27 Feb 2024 13:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041016; cv=none; b=Tm9pVbDZksrs5X7nsmnK+1kcb2KfCwW4Sdbkq3YS3iWxFnVESzmjzvbFAYm6tfmI6TU0TSWZbvufT3lHGKthYrEjVRd2Sta33BBuyzek+11FNs7ORllMKE5sfSrtA4qgOBUbRZ9xe7rm+YCdDpJ+XlS+sNa8zRl/Do2pIDWPLbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041016; c=relaxed/simple;
	bh=l1///Si0BUP5EFC0pnDhBH0put2fdTH1urGuv4R9WEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IWj552ih/l6b5kVLnOSfADY2fD7TAjgox5I582clwGAeigzX+xMKSTFJRuht4v/xl1jXcx7thztuOstWd09/kEG74fqbJPne9Z/dIwdcE/4fQUqNYQCWv5t5PHc85OZe30w+wD1QzRAdj2P9T9QE3c9AOb1x8fnIu001FJ5ihmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oMxIUfmt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE59C433F1;
	Tue, 27 Feb 2024 13:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709041016;
	bh=l1///Si0BUP5EFC0pnDhBH0put2fdTH1urGuv4R9WEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oMxIUfmt5NGP4E55cDLloFWWAR6QXOz/w//TVbaD154FOmdA+9tbtwU2NPJRIPtQO
	 JL+VNgAx9RdqCZXhZsTMpar85WcZXP3vcZzCEJLVfpQqvQwlzNv7rfj6ClASFvGzBW
	 GMsn/4Nfcpgsg84Ok6u87zQHU5zSL7caIyTqslKM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrzej Kacprowski <Andrzej.Kacprowski@intel.com>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: [PATCH 6.7 190/334] accel/ivpu: Dont enable any tiles by default on VPU40xx
Date: Tue, 27 Feb 2024 14:20:48 +0100
Message-ID: <20240227131636.822823797@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131630.636392135@linuxfoundation.org>
References: <20240227131630.636392135@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrzej Kacprowski <Andrzej.Kacprowski@intel.com>

commit eb0d253ff9c74dee30aa92fe460b825eb28acd73 upstream.

There is no point in requesting 1 tile on VPU40xx as the FW will
probably need more tiles to run workloads, so it will have to
reconfigure PLL anyway. Don't enable any tiles and allow the FW to
perform initial tile configuration.

This improves NPU boot stability as the tiles are always enabled only
by the FW from the same initial state.

Fixes: 79cdc56c4a54 ("accel/ivpu: Add initial support for VPU 4")
Cc: stable@vger.kernel.org
Signed-off-by: Andrzej Kacprowski <Andrzej.Kacprowski@intel.com>
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240220131624.1447813-1-jacek.lawrynowicz@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/accel/ivpu/ivpu_hw_40xx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/accel/ivpu/ivpu_hw_40xx.c
+++ b/drivers/accel/ivpu/ivpu_hw_40xx.c
@@ -24,7 +24,7 @@
 #define SKU_HW_ID_SHIFT              16u
 #define SKU_HW_ID_MASK               0xffff0000u
 
-#define PLL_CONFIG_DEFAULT           0x1
+#define PLL_CONFIG_DEFAULT           0x0
 #define PLL_CDYN_DEFAULT             0x80
 #define PLL_EPP_DEFAULT              0x80
 #define PLL_REF_CLK_FREQ	     (50 * 1000000)



