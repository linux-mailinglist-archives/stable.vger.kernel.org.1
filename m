Return-Path: <stable+bounces-157859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 944B6AE55F8
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 948784C2B13
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A15522A4DB;
	Mon, 23 Jun 2025 22:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BHColgSq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3088322A1D4;
	Mon, 23 Jun 2025 22:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750716894; cv=none; b=bZ0PzyELNx2mJciMhzrw74Fk3vXSYAx1AGsgLOg4TBUE63TIz6FnoGchDEbHHWVpK2wGIfogz12EJTfOELS/yCgvstHkzoBguUQnKIhxGBnpDrdPccylGC8qhEbzlahMy6Q71Gr8hyqqyO124v37+rBVxMXrqtG6clSWfk7Cvdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750716894; c=relaxed/simple;
	bh=x26xcIx3394ooL9JlhIxm2JpRfXna0Zz1sgOir3wZ18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DMecofqag84oLuaan7hd2gcB1TJ3cezFBsJVTIsI/TiUyH6nJfJHVjrd5EZwrBb12bVdrTLCAKvkUiVPPsMAuPQo2sZMZ3NvQMEwh+bLwvp2j55M/nJYwvPZCALD+P65dITFQf3SY0CzGQ5cgL1o6KKrXAKWhZ8SNJGyDjlWUOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BHColgSq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C6DC4CEEA;
	Mon, 23 Jun 2025 22:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750716894;
	bh=x26xcIx3394ooL9JlhIxm2JpRfXna0Zz1sgOir3wZ18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BHColgSqhE0waZW6iXRIdUkHmOOKBuFS0X065tXz+8DdyCreYUaSf9UfLmqSOt+j4
	 dwu2WXUiscQEwllyK947LQETy9nsQ/4eMP2jdcxDgvW6rloZnmm/1HjxIDJBZq/GwC
	 QcVR/i6ljYJiK36J5bL9bctc6abd217o5lydrHIA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 6.15 566/592] x86/its: Fix an ifdef typo in its_alloc()
Date: Mon, 23 Jun 2025 15:08:44 +0200
Message-ID: <20250623130713.904974319@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130700.210182694@linuxfoundation.org>
References: <20250623130700.210182694@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

commit 3c902383f2da91cba3821b73aa6edd49f4db6023 upstream.

Commit a82b26451de1 ("x86/its: explicitly manage permissions for ITS
pages") reworks its_alloc() and introduces a typo in an ifdef
conditional, referring to CONFIG_MODULE instead of CONFIG_MODULES.

Fix this typo in its_alloc().

Fixes: a82b26451de1 ("x86/its: explicitly manage permissions for ITS pages")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20250616100432.22941-1-lukas.bulwahn%40redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/alternative.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -250,7 +250,7 @@ static void *its_alloc(void)
 	struct its_array *pages = &its_pages;
 	void *page;
 
-#ifdef CONFIG_MODULE
+#ifdef CONFIG_MODULES
 	if (its_mod)
 		pages = &its_mod->arch.its_pages;
 #endif



