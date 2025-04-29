Return-Path: <stable+bounces-137892-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2DBAA1589
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E51241BC28E5
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92BF253331;
	Tue, 29 Apr 2025 17:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pB4fDUvC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676C7247280;
	Tue, 29 Apr 2025 17:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745947450; cv=none; b=L9mB015vNH1lj0IL5mI1JMk+Eo69/RIyyM6jPBzmD0rdEWPG1cIezZThD5HxJ1fpZJBv8mSNFS8EQur0cCF9KJlR4lO143k9uJkzh/ACes2ih1DgBnKSaJJ1zU089ElcSzQvU7iuZ4JnaYdTSxknyxj0WGz9qiqvFPZiqpWim30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745947450; c=relaxed/simple;
	bh=sTyrEGcOXh+QFUZdqW4A22X1g3M5BZhxFEbjapiu9Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YAXMk8eEQ1utaWhXlND7NhOBDVIYnRGYAzgN0XyQck54PpTJRINA80i7ntUpxHAoQqs42DLiZTjFsraa1vLM+U6odLOTDoQTKDUtVAZWDtn+mNxD5M5JM5AFOjwvLMQHvWCyEZnHTGujFVjU6BvBBbikXClChaDIOeWSq/BiHEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pB4fDUvC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA13C4CEEE;
	Tue, 29 Apr 2025 17:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745947450;
	bh=sTyrEGcOXh+QFUZdqW4A22X1g3M5BZhxFEbjapiu9Kg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pB4fDUvCU96uoMeBMqRnCOGF2XiAWaw0PWrYbTsvyW67//7yG9SllZKJxFvGH/XWa
	 RUAn8spuFBx5mDizuKz1Q+us9ZX04NtpArdyDRhow6LhRA2Ab+l9aW8/glkQPKzwMw
	 NdJzP2V87OM45WnTPT4AaQVZVrQIaQEKFYB1IYjk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 5.10 284/286] soc: samsung: exynos-chipid: correct helpers __init annotation
Date: Tue, 29 Apr 2025 18:43:08 +0200
Message-ID: <20250429161119.594697924@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161107.848008295@linuxfoundation.org>
References: <20250429161107.848008295@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzk@kernel.org>

commit 6166174afc2bc74ca550af388508384b57d5163d upstream.

After converting to builtin driver, the probe function should not call
__init functions anymore:

  >> WARNING: modpost: vmlinux.o(.text+0x8884d4):
  Section mismatch in reference from the function exynos_chipid_probe() to the function .init.text:product_id_to_soc_id()

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 352bfbb3e023 ("soc: samsung: exynos-chipid: convert to driver and merge exynos-asv")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Link: https://lore.kernel.org/r/20210105174440.120041-1-krzk@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/soc/samsung/exynos-chipid.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/soc/samsung/exynos-chipid.c
+++ b/drivers/soc/samsung/exynos-chipid.c
@@ -55,7 +55,7 @@ static const struct exynos_soc_id {
 	{ "EXYNOS5433", 0xE5433000 },
 };
 
-static const char * __init product_id_to_soc_id(unsigned int product_id)
+static const char *product_id_to_soc_id(unsigned int product_id)
 {
 	int i;
 



