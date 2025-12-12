Return-Path: <stable+bounces-200912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E93CB8EAA
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 14:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADBDA305E739
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 13:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2BF25785D;
	Fri, 12 Dec 2025 13:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="CofnFnK7"
X-Original-To: stable@vger.kernel.org
Received: from sg-1-101.ptr.blmpb.com (sg-1-101.ptr.blmpb.com [118.26.132.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFC2256C6C
	for <stable@vger.kernel.org>; Fri, 12 Dec 2025 13:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765547269; cv=none; b=RExam5ngYKd41RaipvXx4XIzCA9HMJ21kb2/+ZB7FWC9H2uOu4Ln51RAc6EmaROZKLsW9waQUQovlJYpIJ+M9p2AcGxflE4Xb2bGyjJjJptKTfCsAw91FBSJZJ0/XEb+IuTWgsZe2YMpB+LtXg1/uou5ihQD2Id1dEqq5qZvd3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765547269; c=relaxed/simple;
	bh=ERh4A/fa/3EomeuKeJVcjaQG6RPT6qs8hlm76hkoa1c=;
	h=Subject:Message-Id:Mime-Version:From:References:Content-Type:To:
	 Date:Cc:In-Reply-To; b=CLAtVGSoir0Dqj+NrzF5PexkwAIPFN3McO0v4JbQrF3ySJceooXppSUAh+mbX2cQbJa3Oaf79tsleCEnFtMS5Qa+xoCg3DVuZY9qNg48d7MrXbh8itgG6CRBln2SPVk7gUX9yiTfBNOGiPvl+LwWLPfQfuVw+zL6wi7YQHfgVxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=CofnFnK7; arc=none smtp.client-ip=118.26.132.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1765547260; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=ERh4A/fa/3EomeuKeJVcjaQG6RPT6qs8hlm76hkoa1c=;
 b=CofnFnK7SPLuOxnSFerlHGUc7euSuMwBw65EWUn55HI2yT9SAddZEEBHZKgHSvg27y3N2M
 SBhYiJcZyZ1SyWeRrFQydAV6viVpzQsYOnag6IID9syItwpt1/mVvusHupNKJ18uHBs21v
 z/owo3b2BIzOUxeAf+lXIYFi+XxMDbWBiW3H1rNz9EIzEL+vxvzOf2OSLSgXTNFhLNTYkx
 Yvm1zE74fws2PJEte3DYUrBrPd00gbJ7+DYUANtlsFnRTMUt6On/uYzfKd4HKEX3yuPXvK
 /OP3u1WmzhfmMl0ZrZlWmrnvkylNBNAhbvLZ8udveTUY+Z+FKryc7s/hirQnAw==
Subject: Re: [PATCH] PCI: Remove redundant pci_dev_unlock() in pci_slot_trylock()
Message-Id: <20251212134725.2461-1-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.17.1
From: "Jinhui Guo" <guojinhui.liam@bytedance.com>
Content-Transfer-Encoding: quoted-printable
References: <360c5c8e-dfc7-a88b-fa20-a157da87ea74@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
To: <ilpo.jarvinen@linux.intel.com>
Date: Fri, 12 Dec 2025 21:47:25 +0800
X-Lms-Return-Path: <lba+2693c1cfa+da8c12+vger.kernel.org+guojinhui.liam@bytedance.com>
Cc: <bhelgaas@google.com>, <dan.j.williams@intel.com>, 
	<dave.jiang@intel.com>, <guojinhui.liam@bytedance.com>, 
	<kbusch@kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-pci@vger.kernel.org>, <stable@vger.kernel.org>
X-Original-From: Jinhui Guo <guojinhui.liam@bytedance.com>
In-Reply-To: <360c5c8e-dfc7-a88b-fa20-a157da87ea74@linux.intel.com>

On Thu, Dec 11, 2025 20:13:59 +0200, Ilpo J=C3=A4rvinen wrote:
> > Commit a4e772898f8b ("PCI: Add missing bridge lock to pci_bus_lock()")
> > delegates the bridge device's pci_dev_trylock() to pci_bus_trylock()
> > in pci_slot_trylock(), but it leaves a redundant pci_dev_unlock() when
> > pci_bus_trylock() fails.
> >=20
> > Remove the redundant bridge-device pci_dev_unlock() in pci_slot_trylock=
(),
> > since that lock is no longer taken there.
>=20
> Doesn't it cause issues if trying to unlock something that wasn't locked=
=20
> so saying its "redundant" seem a bit an understatement?

Hi, Ilpo J=C3=A4rvinen

Thanks for your time. The commit message was a bit brief, so I've sent v2
https://lore.kernel.org/all/20251212133737.2367-1-guojinhui.liam@bytedance.=
com/
with more details.

Best Regards,
Jinhui

