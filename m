Return-Path: <stable+bounces-207020-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71612D0991F
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 13:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B9168302DD5F
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 12:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA90B33B6E1;
	Fri,  9 Jan 2026 12:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RCJG60b/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C293346AF;
	Fri,  9 Jan 2026 12:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767960865; cv=none; b=QZV6fNnmIhloLX7W9aglHBZLosp/QV6Oajz4sD+i8V+9Dbq8Y8d/+3/sCzLrVyhV/g8qi8aIPaQGqH85+tmvA+uKrALS1JUM9KoOlt5UqrEbWyKoYREJVRxgogJKBcI2btDKH+1aMHce5jlLqtGNXrbCh8120t55lc2K6NVHI2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767960865; c=relaxed/simple;
	bh=g51Aik9f6cQ81SkfKD6jD5cZWruJ+NtA48I7PMkAsLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ip2+0BMuRRs5sqVpWYd1YKnW/llpGZZviKpHH/EojW1io/cyRKx6AXjQjjYDdqhs/0aDpphDfsJpG5ACIWKmVPJcXowJCk96LELgz6nY0uPbwlWSiCeA9ZWtPKBUwxUtW8acMnQknOPsM+BwHuSLlFYLPJiIKEXGhDZ1i6iKpBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RCJG60b/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31311C4CEF1;
	Fri,  9 Jan 2026 12:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767960865;
	bh=g51Aik9f6cQ81SkfKD6jD5cZWruJ+NtA48I7PMkAsLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RCJG60b/+iFvLRHumtAe9He0S5F0nufre3SjG7LuE3PYotrQgPmhOT/U72WbiaMUR
	 kgs9k2k/kBpd0fzXn3jDpPicLroG464KuPTKWcr217M42X8ZlCZwz0ASvqk5ly/87h
	 M92t+nP6Fa///l1Q12N5qrwVjFSoDc9RZJuEtrzE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Magnus Damm <damm+renesas@opensource.se>,
	Robin Murphy <robin.murphy@arm.com>,
	Johan Hovold <johan@kernel.org>,
	Joerg Roedel <joerg.roedel@amd.com>
Subject: [PATCH 6.6 552/737] iommu/ipmmu-vmsa: fix device leak on of_xlate()
Date: Fri,  9 Jan 2026 12:41:31 +0100
Message-ID: <20260109112154.761732832@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109112133.973195406@linuxfoundation.org>
References: <20260109112133.973195406@linuxfoundation.org>
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

From: Johan Hovold <johan@kernel.org>

commit 80aa518452c4aceb9459f9a8e3184db657d1b441 upstream.

Make sure to drop the reference taken to the iommu platform device when
looking up its driver data during of_xlate().

Fixes: 7b2d59611fef ("iommu/ipmmu-vmsa: Replace local utlb code with fwspec ids")
Cc: stable@vger.kernel.org	# 4.14
Cc: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/ipmmu-vmsa.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -681,6 +681,8 @@ static int ipmmu_init_platform_device(st
 
 	dev_iommu_priv_set(dev, platform_get_drvdata(ipmmu_pdev));
 
+	put_device(&ipmmu_pdev->dev);
+
 	return 0;
 }
 



