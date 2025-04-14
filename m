Return-Path: <stable+bounces-132581-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD43A883B9
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 16:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3177F3BA802
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4156B2D3238;
	Mon, 14 Apr 2025 13:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvSMlhij"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C132D320D;
	Mon, 14 Apr 2025 13:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637459; cv=none; b=HPwVAzhZVLnBfoCd16+UHXGJ3krNDvAgcec00XgebIosOULK5JLZoppZ3c5ZyOFyGZK3FJtjVKDVTbBW4f4efLqiXNCvVl5XH6RYsmRjg/LgzLnAXvLa+pXI4fp7L9Ou58ozuJsU+Xg2CTCssIQuQqlDKmofBAacTNVbCV7CrXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637459; c=relaxed/simple;
	bh=v7Iw0f8SmGD/dvTFvJTtjO3m7ciPzRNBNSs1CGo4oYE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I4VuXJ0JUORPD+1o1stixvvZRn7ekIGdOTfBnv2I51wGVqgg6nPIgDtAQZCCS3eLsNLypZwSYi2GWRxwcuGufaGz59LjautazJf5bNvSXhF6yJBW8G0iZUntRhu/Try5Zt7135E7o6yPnHcaISUawPRcJaW5hISYUIWX3IzIFeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvSMlhij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42287C4CEE2;
	Mon, 14 Apr 2025 13:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637458;
	bh=v7Iw0f8SmGD/dvTFvJTtjO3m7ciPzRNBNSs1CGo4oYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZvSMlhijMlmxL6OvRLiCsZCIUY2r9D/sAJZv9YyDriIofRMV8fyZ7bZrUfrMQq1pZ
	 13gG89uk9W6q3x/nJISM7nmcnau/trV0nnchspMh/P68CpRQnzfXOxtIjFL3kWyCLS
	 Wu+boTkb01wDhd9mt9ZeTeEvvMwidQF0wJORS+o+gvL5tPCpTBDJDiBZgK6eU3IBRq
	 DhDhgKIgL1Uh5LsMsBltrnNjlx0PT2NlsbcfjXKcSMn3oPdRFYZWuT9OZGwAf3YGoy
	 L56vq9vpqcyVvR7YwJhbmL3qMMbCT04Ns3D54oH4t57Ro5IGLCA1INXXD3xP2D/Mpa
	 uMKhS/83HLsgA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Andryuk <jason.andryuk@amd.com>,
	Jan Beulich <jbeulich@suse.com>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	sstabellini@kernel.org,
	xen-devel@lists.xenproject.org
Subject: [PATCH AUTOSEL 6.1 04/17] xen: Change xen-acpi-processor dom0 dependency
Date: Mon, 14 Apr 2025 09:30:35 -0400
Message-Id: <20250414133048.680608-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414133048.680608-1-sashal@kernel.org>
References: <20250414133048.680608-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.134
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
index d5d7c402b6511..ab135c3e43410 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -271,7 +271,7 @@ config XEN_PRIVCMD
 
 config XEN_ACPI_PROCESSOR
 	tristate "Xen ACPI processor"
-	depends on XEN && XEN_PV_DOM0 && X86 && ACPI_PROCESSOR && CPU_FREQ
+	depends on XEN && XEN_DOM0 && X86 && ACPI_PROCESSOR && CPU_FREQ
 	default m
 	help
 	  This ACPI processor uploads Power Management information to the Xen
-- 
2.39.5


