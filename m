Return-Path: <stable+bounces-196846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F19C9C8331F
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 04:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C53AC3ABDBA
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 03:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7967C1FF7D7;
	Tue, 25 Nov 2025 03:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuGiEqeo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FC519F48D;
	Tue, 25 Nov 2025 03:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764040485; cv=none; b=QTrBlU8F4JBPnvC1bOdPVXVEAhg8ETcZl+gciKd/5QrW4dXrWqZmFgMJPHbbf9v1ZKjx2kzG/tNXa6pk9lN1seJ+7T1oHIpzoY5JlCUPaDdV+WgHsCmYx6RrYzDroyX14/q7KoJTr5B1ArY6097X6NrahimYHp9JlsbMprVMDos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764040485; c=relaxed/simple;
	bh=nwmtWdZJY08oTKtwV5lKo9BKgiudoFHd8qWo0HVM5ZE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iM9lkKtORsyuJcaXILMZX5M4A5oBgDifrP2NtAYehGuv97Ywt2vct5TKvYz3+psTN3DSKJwi5JpAoPBKvL4j35SLI2lUjBcViRTTZVghb2ItYgZE2AU7X1MuWic21jYC05teuvpTAtIln4GDfFLUi/p8GS6L9XSZAnCSxVaWueo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuGiEqeo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6982AC4CEFB;
	Tue, 25 Nov 2025 03:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764040484;
	bh=nwmtWdZJY08oTKtwV5lKo9BKgiudoFHd8qWo0HVM5ZE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AuGiEqeoG8U74KJVj5wIC5Ek67ARMrI/HtPM8166owxJvmNGOZdPKT6NSF9+eordP
	 AUYB9Mm5ydCfCNGQ572J33QYHBhyU7RxH4aXPXfaSLc3iTx+PDDMomDw4HpNFy4mct
	 OOHn0N/gKV6neC8cP1u0lv/3wbaYLzHJmmcUL0UBTqmOcorQTDFDkcq78bGVUy4SIr
	 4r0wT2ekXOnwMma6bLyRe2oKtlsR/FJ3RFY/q1adoMtOAdsVQWbUwhbqOgpW9LFQpr
	 AO7Dtr9GcUggxc8OQfY0aW9BBinNNF+OmEUO/+HOebQtsGx6m32iswy6JCIogMKCTD
	 1JRHcmSnDvFZQ==
Date: Mon, 24 Nov 2025 19:14:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Liu, Yongxin" <Yongxin.Liu@windriver.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "david.e.box@linux.intel.com" <david.e.box@linux.intel.com>,
 "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
 "andrew@lunn.ch" <andrew@lunn.ch>, "platform-driver-x86@vger.kernel.org"
 <platform-driver-x86@vger.kernel.org>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>
Subject: Re: [PATCH net v2] platform/x86: intel_pmc_ipc: fix ACPI buffer
 memory leak
Message-ID: <20251124191443.4bd11a48@kernel.org>
In-Reply-To: <SJ0PR11MB5072CCB0B5213AE5467C1456E5D1A@SJ0PR11MB5072.namprd11.prod.outlook.com>
References: <20251125022952.1748173-2-yongxin.liu@windriver.com>
	<20251124185624.682de84f@kernel.org>
	<SJ0PR11MB5072CCB0B5213AE5467C1456E5D1A@SJ0PR11MB5072.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Nov 2025 03:07:30 +0000 Liu, Yongxin wrote:
> > -----Original Message-----
> > From: Jakub Kicinski <kuba@kernel.org>
> > Sent: Tuesday, November 25, 2025 10:56
> > To: Liu, Yongxin <Yongxin.Liu@windriver.com>
> > Cc: linux-kernel@vger.kernel.org; netdev@vger.kernel.org;
> > david.e.box@linux.intel.com; ilpo.jarvinen@linux.intel.com; andrew@lunn.ch;
> > platform-driver-x86@vger.kernel.org; stable@vger.kernel.org
> > Subject: Re: [PATCH net v2] platform/x86: intel_pmc_ipc: fix ACPI buffer
> > memory leak
> > 
> > CAUTION: This email comes from a non Wind River email account!
> > Do not click links or open attachments unless you recognize the sender and
> > know the content is safe.
> > 
> > On Tue, 25 Nov 2025 10:29:53 +0800 yongxin.liu@windriver.com wrote:
> > > Subject: [PATCH net v2] platform/x86: intel_pmc_ipc: fix ACPI buffer
> > memory leak
> > 
> > Presumably typo in the subject? Why would this go via netdev/net.. ?
> 
> Because the only caller of intel_pmc_ipc() is drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c.
> I have sent both to the platform-driver-x86@vger.kernel.org and netdev@vger.kernel.org mailing lists.

Just to be clear -- the CC is fine, but given the code path - the
platform maintainer will likely take this via their tree. And the
subject designation is to indicate which maintainer you're expecting 
to process the patch.

