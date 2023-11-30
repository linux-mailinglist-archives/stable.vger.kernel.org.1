Return-Path: <stable+bounces-3213-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 067557FF00C
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 14:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4941281FFD
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 13:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D945147A47;
	Thu, 30 Nov 2023 13:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KQAuosfi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD963E47A;
	Thu, 30 Nov 2023 13:24:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C90CC433C7;
	Thu, 30 Nov 2023 13:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701350698;
	bh=6wXQG8GC4xHQYPa80EXyBOhEFr8itdnJN4uCsBB6Yi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KQAuosfibECnkXGBM2E9G412xWv5J7I4boFHF22LgUiNKc8GyoDpMkzSbitx6ngOX
	 enDFY1isne+gxxvlQpj5WXE4Lu8v/Yw5L5uaNPLlVsO5jycRqvBCE9yBoHE6nZvWsY
	 1qabRZhpA4CZPuIikP6z6PPL3nw4Ba4LIXQqAYac=
Date: Thu, 30 Nov 2023 13:24:55 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Nathan Chancellor <nathan@kernel.org>, sashal@kernel.org,
	bhelgaas@google.com, llvm@lists.linux.dev, stable@vger.kernel.org,
	Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH 5.10] PCI: keystone: Drop __init from
 ks_pcie_add_pcie_{ep,port}()
Message-ID: <2023113047-county-icy-baff@gregkh>
References: <20231128-5-10-fix-pci-keystone-modpost-warning-v1-1-43240045c516@kernel.org>
 <20231129094800.7uxfxx7h2sa4p5an@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231129094800.7uxfxx7h2sa4p5an@pengutronix.de>

On Wed, Nov 29, 2023 at 10:48:00AM +0100, Uwe Kleine-König wrote:
> On Tue, Nov 28, 2023 at 05:37:00PM -0700, Nathan Chancellor wrote:
> > This commit has no upstream equivalent.
> > 
> > After commit db5ebaeb8fda ("PCI: keystone: Don't discard .probe()
> > callback") in 5.10, there are two modpost warnings when building with
> 
> As with the 5.4 patch:
> 
> s/5.10/5.10.202/

Thanks, all now queued up.

greg k-h

