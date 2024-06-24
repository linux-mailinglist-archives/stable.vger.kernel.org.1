Return-Path: <stable+bounces-55005-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C809149DB
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 14:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68E521F221B8
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 12:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F0713B2B2;
	Mon, 24 Jun 2024 12:31:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DCC1E4AE;
	Mon, 24 Jun 2024 12:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719232276; cv=none; b=nI3kd9I6fTZbEwpWhliBpQBmjZTvhV6S095MphFTv3qsikmIrFDTtCVJabuQg5sA8q/NwEhnvk2PRvsSxNCCoLlMCdmd8LHrJneQbUcRkWK+/F/a91hM5LoDHQzZi3yyGDA5hD3zRVBGuspb5eGLu3z9vNUSYSCMqRsmQ8BJF8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719232276; c=relaxed/simple;
	bh=bgSQbwzzLy0IMcbGGpuXzAPavbkaB1dJm5nM8P4Sp5g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OTdXlWGtxJRD63X1QnfXQ8ld9af1E3xI5FI54QJ9n0VuV1LhCeL/CRryyHv0X+SN+45zYH4hDoY0zRq/EvOqoN2tCnRQLB2mxMGzWPCq8HvzgNPv3ORHcoE3mKI57dEZSdpcw4shgcKn9VGdXZYZUx0yA/Z1o/aILScZM4N0xGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4W76l33xMDz4wqM;
	Mon, 24 Jun 2024 22:31:11 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: mpe@ellerman.id.au, Jinglin Wen <jinglin.wen@shingroup.cn>
Cc: npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen.n.rao@linux.ibm.com, masahiroy@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20240620024150.14857-1-jinglin.wen@shingroup.cn>
References: <20240617023509.5674-1-jinglin.wen@shingroup.cn> <20240620024150.14857-1-jinglin.wen@shingroup.cn>
Subject: Re: [PATCH v2] powerpc: Fix unnecessary copy to 0 when kernel is booted at address 0.
Message-Id: <171923223894.136336.11371649484834180156.b4-ty@ellerman.id.au>
Date: Mon, 24 Jun 2024 22:30:38 +1000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thu, 20 Jun 2024 10:41:50 +0800, Jinglin Wen wrote:
> According to the code logic, when the kernel is loaded to address 0,
> no copying operation should be performed, but it is currently being
> done.
> 
> This patch fixes the issue where the kernel code was incorrectly
> duplicated to address 0 when booting from address 0.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc: Fix unnecessary copy to 0 when kernel is booted at address 0.
      https://git.kernel.org/powerpc/c/13fc6c175924eaa953cf597ce28ffa4edc4554a6

cheers

