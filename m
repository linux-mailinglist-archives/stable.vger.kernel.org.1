Return-Path: <stable+bounces-174289-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C78AB36214
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E49A87BBEBA
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC491E51E1;
	Tue, 26 Aug 2025 13:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TZDnLYcp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3896F196C7C;
	Tue, 26 Aug 2025 13:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756213995; cv=none; b=HR0//YwGzwuNh9jDfLRHbVmNwkQRKSMXaYCeZy4DvVeB7gxZ+b8DvyFvNMCnTByIBT8nLtz4WXTt8bD1bmFTzOg3pJvGuFiMdnWHoqnmm3YDC+mb62ch1pkJUqnc/f8nUvqROLidbxTfdehCCvHPX+D+VrkWUPi2Zn8x12tl5Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756213995; c=relaxed/simple;
	bh=yFQvfDsTUq0CHMjirH+5N0IvEXFvwRS7+w7s10iKyzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ASXSYJlz3dWy4RrlsMxz2g4VjfrULnjJt6j6ARSBgqCxhw6lM+SV+C0eDXe23f+w/Eju0jxEzUqA/D7eBn3B+Ftr3gzENfdvG2NiqtpRjSm5sH43CoI4i/yJu5rbo0pKUZuyHWqjAqc6+OxZIMmGoZMzW81ni9OEGGUxterSd9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TZDnLYcp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D2C5C4CEF1;
	Tue, 26 Aug 2025 13:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756213993;
	bh=yFQvfDsTUq0CHMjirH+5N0IvEXFvwRS7+w7s10iKyzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TZDnLYcpniVEjDi0phFagj/QZdB3Me06WRmqMAHww5NwzpMoT8JXiUvB5gmwrBnll
	 FQJ1ylFkmY0+cBblc7+1oitx4bFkbWFsrpiD9Knet6LoBfhQqzXpoGvXmGWBQngKY+
	 PeZGN/UlpfOpQp0+y7SYYbweOHOBU9X5lfsOHq+o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Simcha Kosman <simcha.kosman@cyberark.com>,
	Kees Cook <kees@kernel.org>,
	Ankit Soni <Ankit.Soni@amd.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 558/587] iommu/amd: Avoid stack buffer overflow from kernel cmdline
Date: Tue, 26 Aug 2025 13:11:47 +0200
Message-ID: <20250826111007.220420142@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110952.942403671@linuxfoundation.org>
References: <20250826110952.942403671@linuxfoundation.org>
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

From: Kees Cook <kees@kernel.org>

[ Upstream commit 8503d0fcb1086a7cfe26df67ca4bd9bd9e99bdec ]

While the kernel command line is considered trusted in most environments,
avoid writing 1 byte past the end of "acpiid" if the "str" argument is
maximum length.

Reported-by: Simcha Kosman <simcha.kosman@cyberark.com>
Closes: https://lore.kernel.org/all/AS8P193MB2271C4B24BCEDA31830F37AE84A52@AS8P193MB2271.EURP193.PROD.OUTLOOK.COM
Fixes: b6b26d86c61c ("iommu/amd: Add a length limitation for the ivrs_acpihid command-line parameter")
Signed-off-by: Kees Cook <kees@kernel.org>
Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>
Link: https://lore.kernel.org/r/20250804154023.work.970-kees@kernel.org
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 2e7a12f30651..431cea41df2a 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3625,7 +3625,7 @@ static int __init parse_ivrs_acpihid(char *str)
 {
 	u32 seg = 0, bus, dev, fn;
 	char *hid, *uid, *p, *addr;
-	char acpiid[ACPIID_LEN] = {0};
+	char acpiid[ACPIID_LEN + 1] = { }; /* size with NULL terminator */
 	int i;
 
 	addr = strchr(str, '@');
@@ -3651,7 +3651,7 @@ static int __init parse_ivrs_acpihid(char *str)
 	/* We have the '@', make it the terminator to get just the acpiid */
 	*addr++ = 0;
 
-	if (strlen(str) > ACPIID_LEN + 1)
+	if (strlen(str) > ACPIID_LEN)
 		goto not_found;
 
 	if (sscanf(str, "=%s", acpiid) != 1)
-- 
2.50.1




