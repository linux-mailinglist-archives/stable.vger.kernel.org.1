Return-Path: <stable+bounces-152843-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D16ADCD12
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 15:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E8B21898F2D
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 13:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDCD2DE20E;
	Tue, 17 Jun 2025 13:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tfmFXcHA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2D62248A0
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 13:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750166384; cv=none; b=oKWOs6dFclvwBDlS0pHDpfAm5kgRT5X0cg6qAd6R5wTAe4vvmGko2NTrNPf1jAHlJ/pnVn7mS6A3iX2o4CfMxdQm8NeunsSrHwkL174Rs2oVbYSkUKH067/fVK9KoqefponKT+KB8cWBzKXNCYEHpuw7u+Wa9I3ktSLuzscKO5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750166384; c=relaxed/simple;
	bh=I69wXrHRwhqwHjn2d6mq/P0uYEIZ2ebu1bhx6iosMqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJ7zh0M4DHUdKQK+iHkVyXaFtBkKh41KLn/JN5b5ZAPUZ1GKSqPA/URM8R+JYXQ/Vg9vjMUSaxJsr9Q8Y6/4iMBYXsyw7TRefYbG7co7WjUt0XlYZUoiNT6Z5lLNB7k53UfsBZTOfmYmNbgidsBpsnkMJa2HtwzQN0zHD19DUpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tfmFXcHA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 846C1C4CEE3;
	Tue, 17 Jun 2025 13:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750166383;
	bh=I69wXrHRwhqwHjn2d6mq/P0uYEIZ2ebu1bhx6iosMqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tfmFXcHArxbkbUxL0XTy4lX4O5+HZKI44In8zhT1Igl0pPOIf8KbYTVxQXvUPWMVW
	 hrRZUAr9zoD47dPLzuLGtYSJqGDmBk/cwm/iIypAWJt3daI2Te6E6BjQ79KGftswJE
	 pbxaAAa2Sp43d5UteAZGUeedagooWg77800yKZZI=
Date: Tue, 17 Jun 2025 15:19:40 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: stable <stable@vger.kernel.org>, Rom Lemarchand <romlem@google.com>
Subject: Re: 6.6-stable inclusion request
Message-ID: <2025061734-mongrel-reward-0b9a@gregkh>
References: <407299b0-1318-4943-902d-aa1708259722@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <407299b0-1318-4943-902d-aa1708259722@kernel.dk>

On Thu, Jun 12, 2025 at 11:40:15AM -0600, Jens Axboe wrote:
> Hi,
> 
> Can you add these three patches to 6.6-stable? It fixes a behavioral
> change with 6.6-stable that Rom reported, affecting OpenBMC. Other
> stable versions not affected, as they got the required fixes on top
> backported already.

Now queued up, thanks.

greg k-h

