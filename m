Return-Path: <stable+bounces-75823-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A33CE97526C
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 14:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9EE51C25F6D
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 12:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CE719E81F;
	Wed, 11 Sep 2024 12:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ayVjDTRz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE7519E80F;
	Wed, 11 Sep 2024 12:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726057890; cv=none; b=DQGHAwSnnWI1/orIEQI9lLELhtYqIwS/Hu1moyWgQkqLa2On2IZZlqL1zL0Lr5gNgtIHGjBlP3yir2WLzI6EajrovjFkIEIzbsDSxmPf1aaaD4OnDFHeqrWazlZY/D+iq86UML0uG4M2cyFL61m9rNklUAulwSvtqf/f4MhF1zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726057890; c=relaxed/simple;
	bh=Fdj0q0pVD/ggTHM+Ik2S/NvfwPTQ8AAyOcVULW9PyVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AHH8xS3N6rv4o5IaVEw7qzzheXsCSqx42nUOeGPPpaf/6sUhvlu8qoAUmWo2zXYJxIvS7+QkwCujz3qelJ4wmLDGoANwwUCronkrZksZ/RJWkNyaUlhPiQoI5mT0VncoS4NSLFr+Wv3kcYDbQlEz06TNTxXXYZRqBKiicvT5wxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ayVjDTRz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D761DC4CEC5;
	Wed, 11 Sep 2024 12:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726057889;
	bh=Fdj0q0pVD/ggTHM+Ik2S/NvfwPTQ8AAyOcVULW9PyVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ayVjDTRz6hgaLP0bob5pmAAi5bmpANJE/YTTIfCCz7FoFJJkabeYrkTlo205lNaHe
	 ZftpOfexRw3cV1FhK50YbS1uxkAGjB2ZcAvWRgb/uut69eeRwuKFaDk/vxxZn/Tb3A
	 xSpkq4nvgYbRX0XJY41QKVhJUgHpVlMtlOPF4+v4=
Date: Wed, 11 Sep 2024 14:31:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: vkoul@kernel.org, yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.intel.com,
	krzysztof.kozlowski@linaro.org, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH stable-6.10 regression] Revert "soundwire: stream: fix
 programming slave ports for non-continous port maps"
Message-ID: <2024091130-detail-remix-34f7@gregkh>
References: <20240910124009.10183-1-peter.ujfalusi@linux.intel.com>
 <febaa630-7bf4-4bb8-8bcf-a185f1b2ed65@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <febaa630-7bf4-4bb8-8bcf-a185f1b2ed65@linux.intel.com>

On Tue, Sep 10, 2024 at 04:02:29PM +0300, Péter Ujfalusi wrote:
> Hi,
> 
> On 10/09/2024 15:40, Peter Ujfalusi wrote:
> > The prop->src_dpn_prop and prop.sink_dpn_prop is allocated for the _number_
> > of ports and it is forced as 0 index based.
> > 
> > The original code was correct while the change to walk the bits and use
> > their position as index into the arrays is not correct.
> > 
> > For exmple we can have the prop.source_ports=0x2, which means we have one
> > port, but the prop.src_dpn_prop[1] is accessing outside of the allocated
> > memory.
> > 
> > This reverts commit 6fa78e9c41471fe43052cd6feba6eae1b0277ae3.
> 
> I just noticed that Krzysztof already sent the revert patch but it is
> not picked up for stable-6.10.y
> 
> https://lore.kernel.org/lkml/20240909164746.136629-1-krzysztof.kozlowski@linaro.org/

Is this in Linus's tree yet?  That's what we are waiting for.

> > Cc: stable@vger.kernel.org # 6.10.y
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> > ---
> > Hi,
> > 
> > The reverted patch causes major regression on soundwire causing all audio
> > to fail.
> > Interestingly the patch is only in 6.10.8 and 6.10.9, not in mainline or linux-next.

Really?  Commit ab8d66d132bc ("soundwire: stream: fix programming slave
ports for non-continous port maps") is in Linus's tree, why isn't it
being reverted there first?

confused,

greg k-h

