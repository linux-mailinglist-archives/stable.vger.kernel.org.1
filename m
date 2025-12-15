Return-Path: <stable+bounces-201062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C90BCBEB08
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 16:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A244330169AC
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 15:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAD431A7F3;
	Mon, 15 Dec 2025 15:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+4bq+mh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE4530FC30;
	Mon, 15 Dec 2025 15:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765812766; cv=none; b=XInqNghAW84gwoOjAz9qaklsMFc4B8laUaQhwGhhqdO/hHeexdCUO7NakO8DAAPqAPgQ5I1UmXoEAzHV0iTnVQFYWUxF7pRn7CwpQrAYoqOJzZxpXNaGyItypepY3DxT0HJMuivn6YOllVsIFrsZMh2L6G9yaxVGDmBLJkN4B+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765812766; c=relaxed/simple;
	bh=aEQVMiLbvDRSXHO/8bGJyPa2l7Ci/SRkpraFLP/Lxc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nOKvnFv5FvvFNpGnst67Yk8hQ3T/WNMH1bf3/cJSgV7dE0G2MnabPZiI/dF4cpb3nU7kR1S2l08q2SVORtWpD9F/kw8VImKqHjCam2VBzwngQMl2McT/S6DEc3YqrFGvTw+NLrOFe5h35yT48zhGRaQq/StQ7z/Sa6BO+YBQ28Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+4bq+mh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2342C4CEF5;
	Mon, 15 Dec 2025 15:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765812766;
	bh=aEQVMiLbvDRSXHO/8bGJyPa2l7Ci/SRkpraFLP/Lxc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B+4bq+mhKwot8aSJYeW0tdN0x+gxVdcVpZtnse60m5xOxnKjUZatO+dWukN5A1QmI
	 tqZNR1Hhoe9PYIbd01Quy9sesiTrhd2xtP7sBzB9/mX/2wC2i8aKoZBXRUJV+6l9VP
	 bczCfpdQAVicEkiL0abzB5MnRzB8Yqnkya/prkgVjPHRScSHKdNU6xezdIba/w/05p
	 8WUU8fxHM6Wot6VMSok+zL2uYXUAuJCuRpXgp2XINXl8dUMx+uGKrrm/H4KNjVTzMs
	 e977KYL5eKsAGcwvWzKCx8VX7twfBrnxoRUpY8FJ6x6zzfB5MICaKOUthAGFppHwgV
	 aIreOqAPniyow==
Date: Mon, 15 Dec 2025 23:32:40 +0800
From: Keith Busch <kbusch@kernel.org>
To: Ilikara Zheng <ilikara@aosc.io>
Cc: linux-kernel@vger.kernel.org, Wu Haotian <rigoligo03@gmail.com>,
	Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>,
	stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-pci: add quirk for Wodposit WPBSNM8-256GTP to
 disable secondary temp thresholds
Message-ID: <aUAqGO7GXRrTk4Vq@kbusch-mbp>
References: <20251208132340.1317531-1-ilikara@aosc.io>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208132340.1317531-1-ilikara@aosc.io>

On Mon, Dec 08, 2025 at 09:23:40PM +0800, Ilikara Zheng wrote:
> +	{ PCI_DEVICE(0x1fa0, 0x2283),   /* Wodposit WPBSNM8-256GTP */

I'm not finding vendor 1FA0 registered on the public pci-ids, nor in the
pcisig.com members list. I just want to make sure the identifier is
officially registered.

