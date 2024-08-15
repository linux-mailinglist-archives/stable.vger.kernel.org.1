Return-Path: <stable+bounces-67843-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8600E952F59
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 15:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A3031F26F02
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 13:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E4418D630;
	Thu, 15 Aug 2024 13:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QyOpi0vZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CE67DA78;
	Thu, 15 Aug 2024 13:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723728694; cv=none; b=iWPg9HlvcACALfhqNt/UmJ7Kj2qGSgOXCi2i3LvIpZ/YDBXVah1ZDkkN8Ze7SaH1IWBCzYnc5Yhhnnjn8VSDDMXc/Nh7H01F34B9J2hY7VUxt428U2GhF+J4iiG0fe5jWcdcVPXWwB6t9qMrFJ93guyFwV6QdOyI6KfWfY/X1gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723728694; c=relaxed/simple;
	bh=RqqiUcuvlYJPQDJB3gu1zxg9f2qfvibkFCRCFaxTg8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q6xxr4T4fumuGFjmegwGFkK8T3cO/2DtiXs5Rz9aPHB6gBhtu2+Ox/KuoSU+KkhvgGxdsPplK4GWdP0a6H8txfTQq860Ob5Ev0Ax4w2L1kYhQ9rBNmcU8VjVv3+cihYhjb06q8916v7pbRs7Yqr5AJRgOjKWzLFzogHbHVcZSSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QyOpi0vZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA481C32786;
	Thu, 15 Aug 2024 13:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723728694;
	bh=RqqiUcuvlYJPQDJB3gu1zxg9f2qfvibkFCRCFaxTg8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QyOpi0vZdNIYdgjsv8+FP4HO2E6XI1q1w+yDeUPEVvVJ5Jlkg/LB87QZ5Xl/VrblK
	 9USCOjfDjrddszk7oNorYHS4nKhDnnYAzyD6wmS89KfeKC1LK7NqCnVrNS85QNE78H
	 i5EidjU+YW1Tt84sDmidTcbtr08+RLN9I+CGJ6tc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dominique Martinet <dominique.martinet@atmark-techno.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 049/196] MIPS: Octeron: remove source file executable bit
Date: Thu, 15 Aug 2024 15:22:46 +0200
Message-ID: <20240815131853.959222846@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131852.063866671@linuxfoundation.org>
References: <20240815131852.063866671@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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




