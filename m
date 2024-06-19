Return-Path: <stable+bounces-53820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B4B90E8D0
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 12:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F814287855
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 10:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3765A13664E;
	Wed, 19 Jun 2024 10:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kV4MNPHP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA4C135A58;
	Wed, 19 Jun 2024 10:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718794639; cv=none; b=aZmqzPfWAGSB1cq2K8aTebvfKbKzKn1/Ov3KU8KH7TBJe2VGqLQhbC2M+oz+idH/kI5jlSA9kvBGX2Yp4T+nCDQHu8udfpc4sw4hRCFI/5P8jhlF0/PmU5lzLK083CFASsTflCwbYKnIlcL4lR6VJZU4FFPUvwbMD01k1J7pA7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718794639; c=relaxed/simple;
	bh=xrLIQVxkZ7Jn9eAr9FLE/zgOohdaV8aDoK/KuceYvy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+SoffcdTuF1M/2xpgoieFdjmteBDUlbQiRqQMgL7z3R/9ak35QjLmMcritbz/UmCz34Ye8OVdCLv+z4QmmQDlEnQIStsA8LlpApfbmAm3gCOkR21aNCO44ZJhqLPAi+aT12OofPx1spYOkwgX5cAMmMVzAQFteYvbY8JfOml88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kV4MNPHP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A90C4AF52;
	Wed, 19 Jun 2024 10:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718794638;
	bh=xrLIQVxkZ7Jn9eAr9FLE/zgOohdaV8aDoK/KuceYvy4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kV4MNPHPOYVwGlsoyAcQ+io5VIcnLnv+hg8NQjHxqgywbJgy2oMDMqI9h8DgP7jK9
	 PETFTCZ6pOZERwVSFoecWKFPiFbYw85h+qzqgY/pzmekDDqiBrjexH3sbjrjEUWxhh
	 iPQ8dNZ5PNj/mRDvnOZoAbNdqFm8EWBF9JtXgTxU=
Date: Wed, 19 Jun 2024 12:57:15 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	kadlec@netfilter.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: Patch "netfilter: ipset: Fix race between namespace cleanup and
 gc in the list:set type" has been added to the 6.9-stable tree
Message-ID: <2024061900-precise-underuse-d4f4@gregkh>
References: <20240617113341.2561910-1-sashal@kernel.org>
 <ZnA0cgegIgvcg26v@calendula>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnA0cgegIgvcg26v@calendula>

On Mon, Jun 17, 2024 at 03:04:50PM +0200, Pablo Neira Ayuso wrote:
> Hi Sasha,
> 
> This fix requires a follow up to silence a RCU suspicious usage warning.
> 
> Please, hold on until end of the week with this.
> 
> I will get back to you with a reminder if it helps.

Dropped from all queues, please resend it when you feel it is ready to
be added.

thanks,

greg k-h

