Return-Path: <stable+bounces-45609-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D09F8CCA91
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 04:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D66BB282818
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 02:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CFD29AB;
	Thu, 23 May 2024 02:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="oZAFhS2P"
X-Original-To: stable@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AC5EC7
	for <stable@vger.kernel.org>; Thu, 23 May 2024 02:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716429908; cv=none; b=CpkoLBVRt8T7XFQZd1k1G9fXx35do316HVBCgXkXpUCn8Bwv/7kbUNj700ddG+vNShPmD1aboisrfP6xkylYetCJOkt9gUXuOvl9bsjZxsIf/FKK65PU20SUzUh4mdXHTcIfUmwqBP0Bh3L58f5q2elau/ro73Bd8pRxSFxT7Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716429908; c=relaxed/simple;
	bh=uU02zWn+x+enVYixP8x8EeGI25iP5gwshT1JsVYT2Ms=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RDCGMhnE4MSHYIP8PBu031D2Bnnajxu5wgnzhODvWod0cRIS6oHEAJl/qiHyS6ekFTPw55aPKiSV0G0DMxVne2od0OU5rxp0Es0XrMqjVX2Xq2fi59DMK2eq7Ar9kPW40LDDsRk+3dFFRs/iXr6OJObhLt9Lg/nKpr3uVymb7LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=oZAFhS2P; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1716429904;
	bh=oxPIohl6k+Esk2D4FILg1jbKI/EByqNRRb7JVTCne5A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=oZAFhS2P4x1SnjpZ3Avk70TTIzvfFnDI4H9IHnTLvgfb4vPZNPB77E7TsSHQjwG5W
	 vONj1z+P/CnPiWLDlC6vcbtatf634mN74dOBWDxxIIcq5+5o9Dw/2GpEFKIrJbgA6n
	 qHQBI93jGwe+gKNw4MMQKyZtI2a8c6KJO3vsD4J0BXEFsN2QK7iXgaMDLxmEHKq9d7
	 MkySL2XRe7KwQg8FKWfKvg7zk+ioopqqHu2Eg3T91CyxNl1+9kMvuoyHrIw0OTgrs2
	 xK+0SO50aOPReVLf0SletCG2yBi3cUqfUDWA+7NOeaT8kfmSBDHzlfBV8p4kvsm+5P
	 59tfsOmX92ohw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VlBMN5Xctz4wcq;
	Thu, 23 May 2024 12:05:04 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: kernel test robot <lkp@intel.com>, Gautam Menghani <gautam@linux.ibm.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] arch/powerpc/kvm: Fix doorbell emulation by adding
 DPDES support
In-Reply-To: <Zk2tjEcFtINQhCag@9ce27862b6d0>
References: <Zk2tjEcFtINQhCag@9ce27862b6d0>
Date: Thu, 23 May 2024 12:05:03 +1000
Message-ID: <87msoh2shc.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kernel test robot <lkp@intel.com> writes:
> Hi,
>
> Thanks for your patch.

I found this report confusing.

It seems like it's saying a patch with "Fixes: ..." *must* include a
"Cc: stable" tag, but that is wrong, it's up to the developer to decide.

What it's trying to say is that the patch was Cc'ed via mail to
stable@vger.kernel.org and that is not the correct way to request stable
inclusion.

So can I suggest the report begins with something like:

  Your patch was Cc'ed via mail to stable@vger.kernel.org but that is
  not the correct way to requestion stable inclusion, the correct method
  is ....

> FYI: kernel test robot notices the stable kernel rule is not satisfied.
>
> The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1
>
> Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
> Subject: [PATCH] arch/powerpc/kvm: Fix doorbell emulation by adding DPDES support
> Link: https://lore.kernel.org/stable/20240522082838.121769-1-gautam%40linux.ibm.com


cheers

