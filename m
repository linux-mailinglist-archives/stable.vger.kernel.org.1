Return-Path: <stable+bounces-132559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9910A88351
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 15:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 683D716A637
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00892C17AB;
	Mon, 14 Apr 2025 13:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fvj7LxQ3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0172F42;
	Mon, 14 Apr 2025 13:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637412; cv=none; b=XcBr+S/a6wTgnPPmQPaxu8t9rhHz6/Ckzjlgn9YEhgLuAM+JWXXIcSp72GtkACb7i2BwXMtAKw2UdNF+SgA8xz/DStC0yR3+yFQQK39MOyckiWJ11TKP6RnXOTctI9O3WBSmTxsEvr90r+Dvsk8+nwHpS6HRi+pMyyltU6cThDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637412; c=relaxed/simple;
	bh=MM1HcIrsCsuD7/pRkw4M1fx7Lt6v9Lafl9o4yzNx0YI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HPWG9QofjqwoYaaTHWEXOA2oOlZ0B99E2a6drU+QKmVS9C5sNq1E0mTdR7YO+DuqdMUCXhh/PaNXQcHBcnGFjdQzfwLbsg1wF0RXoUMO4rNFDuivYzSXqkdScfR+zrbJGN5bIp3bdSVWlqsqhZGOOOcMmYhjvR9+dKXbmDSgm7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fvj7LxQ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59F4C4CEE9;
	Mon, 14 Apr 2025 13:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637412;
	bh=MM1HcIrsCsuD7/pRkw4M1fx7Lt6v9Lafl9o4yzNx0YI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fvj7LxQ38qE0XlL1bfG5zv3oXhfBN2WgnmuHK1zA16vIntFoOYiz5sJvhMxUhdjmK
	 8lUfMmhvMfc0wbqdTd7kW/GvTaADRU7dUo9pTzTgLFf4Na4kxxMUgVoJ2k7gl2fNyv
	 JheqPQ92waJAnf4lLGx+mfXpJBmjlk4h/oVZktnEDWMIosiQJzH2y8mep7SF3Gq3A0
	 SQ7K3CwdHYGiOcYlZ8jICd1kwplPV8k4F7IpjEi7nMjUhOrt7chDId4Sh0iHTgnmmM
	 +pqmDl5iMK6r5bx3Yjdt3E6O5MKmOUgMzlFO74sahrvZ+ISC8hZCuWNCFUX0+2v81W
	 h43iRY/k1z8Sg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Andryuk <jason.andryuk@amd.com>,
	Jan Beulich <jbeulich@suse.com>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	sstabellini@kernel.org,
	xen-devel@lists.xenproject.org
Subject: [PATCH AUTOSEL 6.6 06/24] xen: Change xen-acpi-processor dom0 dependency
Date: Mon, 14 Apr 2025 09:29:39 -0400
Message-Id: <20250414132957.680250-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132957.680250-1-sashal@kernel.org>
References: <20250414132957.680250-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.87
Content-Transfer-Encoding: 8bit

From: Jason Andryuk <jason.andryuk@amd.com>

[ Upstream commit 0f2946bb172632e122d4033e0b03f85230a29510 ]

xen-acpi-processor functions under a PVH dom0 with only a
xen_initial_domain() runtime check.  Change the Kconfig dependency from
PV dom0 to generic dom0 to reflect that.

Suggested-by: Jan Beulich <jbeulich@suse.com>
Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Tested-by: Jan Beulich <jbeulich@suse.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Message-ID: <20250331172913.51240-1-jason.andryuk@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index d43153fec18ea..af5c214b22069 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -278,7 +278,7 @@ config XEN_PRIVCMD_IRQFD
 
 config XEN_ACPI_PROCESSOR
 	tristate "Xen ACPI processor"
-	depends on XEN && XEN_PV_DOM0 && X86 && ACPI_PROCESSOR && CPU_FREQ
+	depends on XEN && XEN_DOM0 && X86 && ACPI_PROCESSOR && CPU_FREQ
 	default m
 	help
 	  This ACPI processor uploads Power Management information to the Xen
-- 
2.39.5


