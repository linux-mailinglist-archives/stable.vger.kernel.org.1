Return-Path: <stable+bounces-163699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD25CB0D996
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 14:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB590AA6924
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 12:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B662DBF5E;
	Tue, 22 Jul 2025 12:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XctsAK66"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1576B2DFA46
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 12:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753187096; cv=none; b=LBjCbI0Q3dBXunb7BljB9DWZ/CbHPlYDiRJeauZ4HFzl79Lu5LFBGAklISQtFSdTOe2T3T8Yw3zseO/4fvjixz99vSueJy1SKpHl8Q2xPvNuBfvPwrvs09OoceTW4arEDPkElJNLhDWEFGgpQL4zNlZPd4vBJUoLg2Hlak6hugA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753187096; c=relaxed/simple;
	bh=WiXKy5ptxkrWJXF6pWhUKgvUKbO5IKBJubU3m0HK9Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1Vyzj2sclSiMkGdqf+QaXRiXaDGklujcYl4WURvGIKqrBuK0IB+FSHzrN8xcvl+y0GGTtgUryswELti1Avz4BsNpf6VqcltStqyGGnGbyJbiJydP4yasHQtWKJ8pnWQrf8rlyevBoBini1p8HL17ZC6ORJUOYEegWzqkSP3tDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XctsAK66; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08484C4CEEB;
	Tue, 22 Jul 2025 12:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753187095;
	bh=WiXKy5ptxkrWJXF6pWhUKgvUKbO5IKBJubU3m0HK9Uc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XctsAK663FsKf4+9TMbYeRWB9ka+64cDFyMbFzP0SMqt7GPYgkUouyEg34aJsMBM1
	 hp8sAAq/UJ/Y4Es8f0ipsNKMHpsPhw+FgYf3Swc/wX2WHJ3V7+8JTAdtIpMd26UkwM
	 bbeIELfO6yXXLADzJ+EjdjlEdtDGsj9+63fiREnM=
Date: Tue, 22 Jul 2025 14:24:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
	Wang Wendy <wendy.wang@intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 6.1.y 1/7] powercap: intel_rapl: Support per Interface
 rapl_defaults
Message-ID: <2025072248-sixteen-thirsting-0586@gregkh>
References: <2025070817-quaintly-lend-80a3@gregkh>
 <20250720234705.764310-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720234705.764310-1-sashal@kernel.org>

On Sun, Jul 20, 2025 at 07:46:59PM -0400, Sasha Levin wrote:
> From: Zhang Rui <rui.zhang@intel.com>
> 
> [ Upstream commit e8e28c2af16b279b6c37d533e1e73effb197cf2e ]
> 
> rapl_defaults is Interface specific.
> 
> Although current MSR and MMIO Interface share the same rapl_defaults,
> new Interface like TPMI need its own rapl_defaults callbacks.
> 
> Save the rapl_defaults information in the Interface private structure.
> 
> No functional change.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> Tested-by: Wang Wendy <wendy.wang@intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Stable-dep-of: 964209202ebe ("powercap: intel_rapl: Do not change CLAMPING bit if ENABLE bit cannot be changed")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/powercap/intel_rapl_common.c | 46 ++++++++++++++++++++--------
>  include/linux/intel_rapl.h           |  2 ++
>  2 files changed, 35 insertions(+), 13 deletions(-)

Your patch series here missed 3 fixes for it, and they didn't backport
cleanly:
	081690e94118 ("powercap: intel_rapl: Fix invalid setting of Power Limit 4")
	a60ec4485f1c ("powercap: intel_rapl: Downgrade BIOS locked limits pr_warn() to pr_debug()")
	95f6580352a7 ("powercap: intel_rapl: Fix off by one in get_rpi()")

So I'm going to drop this series from the queue now.

thanks,

greg k-h

