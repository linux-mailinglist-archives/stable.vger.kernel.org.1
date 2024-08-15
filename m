Return-Path: <stable+bounces-68154-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 854CF9530E5
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 15:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A1361F24BB0
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 13:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0A819AA53;
	Thu, 15 Aug 2024 13:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XltpbwnA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0FB1AC8AE;
	Thu, 15 Aug 2024 13:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723729661; cv=none; b=Skdm+sHnxyJDAhXaSsuqW44THlznzlQ9Eb7D1n5UJwLDhbCICiVgfiaKrcxV06yWUczchy1WEvbfiuVZHpHOuc1Qw/3zprcUGOmjA9heFPO74wvHFYRnxGDkhjMiDURNCmi4Pw/XSWJOovJ/u9POo5lVt1dbq6GUG/ei2bzMAXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723729661; c=relaxed/simple;
	bh=nGd155eX45aMxJ83KhQ0cPwxr3I0rxAYH5XQKOBjI+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ulqbIXBS9NiPueKssThs9X7sFUrGXL+LYUgKBZw5kl3OLIE1Cf6NHGCTvb2ftDM+1+k5qG98gIVtf8QXJRNpkLD1yZwcfOsqyrGwDAOaWj7l2bHQ6p7cXIJpbUk+lS1BW7na2p7UvpFpiW7KCE8TuGMQjz1kazSzey9DSgenbE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XltpbwnA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE46EC4AF0C;
	Thu, 15 Aug 2024 13:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723729661;
	bh=nGd155eX45aMxJ83KhQ0cPwxr3I0rxAYH5XQKOBjI+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XltpbwnA3z/9MzUCKiBIuz9xJG+bW6UoSVy8bpmkJQ7O8LtudE40Ji49eg59dOM9P
	 /KneWmDtnEtt723lehpNvmW9mZ/3BnDXzHtdCU4BvqyLdeFQ6gnYQ9H5WfatmTB9fM
	 98F7ZpJW8ioLxQcAdDwsnKm7dkuECUPUYNI6DNiM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dominique Martinet <dominique.martinet@atmark-techno.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 137/484] MIPS: Octeron: remove source file executable bit
Date: Thu, 15 Aug 2024 15:19:55 +0200
Message-ID: <20240815131946.695850600@linuxfoundation.org>
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
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dominique Martinet <dominique.martinet@atmark-techno.com>

[ Upstream commit 89c7f5078935872cf47a713a645affb5037be694 ]

This does not matter the least, but there is no other .[ch] file in the
repo that is executable, so clean this up.

Fixes: 29b83a64df3b ("MIPS: Octeon: Add PCIe link status check")
Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/pci/pcie-octeon.c | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 arch/mips/pci/pcie-octeon.c

diff --git a/arch/mips/pci/pcie-octeon.c b/arch/mips/pci/pcie-octeon.c
old mode 100755
new mode 100644
-- 
2.43.0




