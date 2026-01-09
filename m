Return-Path: <stable+bounces-206422-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8F7D06F4B
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 04:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 219FC304C2A3
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 03:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E39326D70;
	Fri,  9 Jan 2026 03:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="ZlTNKhna"
X-Original-To: stable@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2219F2ECE98;
	Fri,  9 Jan 2026 03:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767928480; cv=none; b=Fxu+nIPAcVxr6ItZu9dZ6SUIH8RZuleYV02XrM60pF42c7ae9YJgcovzeA01s6jk0sBSACU7JfWATqxeOQB8FwHRngCfGCZDBC4iAW4NbUHu1aKMVU212UpP90zfFqp6EBaiHn9PQO14wSPmxad1EN6U+DXeP0FP0/n1+51jRr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767928480; c=relaxed/simple;
	bh=/0r8SwXN2uqPFgub3vScOCBwPKUaSDDgHhDXceaXG0E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FI/pBCN5SWj4SgGwqfUn4+z3d3eAzSkWsUY4zdQUJfLbTA/BwAtsScIku6S692JvO3ZYM8bar0hkfRo1aMFJHGtQwU7jqI4Rr48efGx01IR/lkokn/UAUs/fN/4/a4ZtTv4eOe0y/9FPdCiRHuMoi+ciV7CIvId2eSB495GI0QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=ZlTNKhna; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 300666a2a;
	Fri, 9 Jan 2026 11:14:30 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: gregkh@linuxfoundation.org
Cc: jianhao.xu@seu.edu.cn,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	mathias.nyman@intel.com,
	stable@vger.kernel.org,
	zilin@seu.edu.cn
Subject: Re: [PATCH v2] usb: xhci: Fix memory leak in xhci_disable_slot()
Date: Fri,  9 Jan 2026 03:14:29 +0000
Message-Id: <20260109031429.1472804-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2026010840-rage-sprang-2662@gregkh>
References: <2026010840-rage-sprang-2662@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ba0bf9a9803a1kunmf84f701073b2e
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSU5JVh1NSkIZTxgZHk1LQ1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUJCSU5LVUpLS1VKQktCWQ
	Y+
DKIM-Signature: a=rsa-sha256;
	b=ZlTNKhna/RVu6LOIAp+5waAldQ8u4eB2nbXxDCeV2wRWhTVU+eHUIsAGCOyVdg34Km5JTWSmJqty4exV6P1LXQ4AvjG1lmj9Jy2daHHaGSRJXfMHNNpUYC4GTyoC3Ovjac1mA4KaT8Y1hIl9xe7H4lrLaPiUBJ3tTu5IXwqZPPM=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=gNFEVQqGBhcVIOW3B/VaCDYtgPyQD7HkCiM2nrPvsDU=;
	h=date:mime-version:subject:message-id:from;

On Thu, Jan 08, 2026 at 04:28:42PM +0100, Greg KH wrote:
> On Thu, Jan 08, 2026 at 02:11:08PM +0000, Zilin Guan wrote:
> > xhci_alloc_command() allocates a command structure and, when the
> > second argument is true, also allocates a completion structure.
> > Currently, the error handling path in xhci_disable_slot() only frees
> > the command structure using kfree(), causing the completion structure
> > to leak.
> > 
> > Use xhci_free_command() instead of kfree(). xhci_free_command() correctly
> > frees both the command structure and the associated completion structure.
> > Since the command structure is allocated with zero-initialization,
> > command->in_ctx is NULL and will not be erroneously freed by
> > xhci_free_command().
> > 
> > This bug was found using an experimental static analysis tool we are
> > developing. The tool is based on the LLVM framework and is specifically
> > designed to detect memory management issues. It is currently under
> > active development and not yet publicly available, but we plan to
> > open-source it after our research is published.
> > 
> > The analysis was performed on Linux kernel v6.13-rc1.
> 
> That is a very old kernel version, from December 2024, please redo this
> to verify it is relevent to todays tree.
> 
> thanks,
> 
> greg k-h

Sorry for the confusion caused by our description. While the static 
analysis was indeed performed on v6.13-rc1, we have manually verified 
that the bug still exists in the latest mainline kernel before submitting
the patch.

I will clarify this distinction in the v3 patch and update the version 
information.

Thanks,
Zilin Guan

