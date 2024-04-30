Return-Path: <stable+bounces-41830-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D850B8B6D73
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 10:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F1E21F21B25
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 08:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB9A127E18;
	Tue, 30 Apr 2024 08:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xNZtHlDo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5E712A14F
	for <stable@vger.kernel.org>; Tue, 30 Apr 2024 08:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714467107; cv=none; b=koTQTcuyzfeRgFhuUzOyi7jsh0eQM3BsDSe1lDCNTTas3iezxQeS172mCylG0/w0VR3NUH/tFIi+2MiMEIPUxORS44xsLI1THGo1iiBGytFA0o/0I9j2yDAvNicAB9gv2SHFMQ6Sx/SdgYuEWCo4YQds97W46q9y+2z3msbzN/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714467107; c=relaxed/simple;
	bh=SEu2+5CL3KGz0Zx0gtub90Ho5AF02ziU/GiVhrBkfW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nntB2F+cXP+lbOKbK2z5U6PfOHwrQspTPIODCc7gu6EhMT2S/J7jytgueF5QHpXgp5xyKsd6f2xNaATizXysrm+IiJmiBBNcnPg/VTh0Qb/j4bzKSrlVlsxmXOrFoCfQz+HCmufhGYEncDjKNkqyZ8S3r4xqAgevdeZa0AASIHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xNZtHlDo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E87C2BBFC;
	Tue, 30 Apr 2024 08:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714467107;
	bh=SEu2+5CL3KGz0Zx0gtub90Ho5AF02ziU/GiVhrBkfW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xNZtHlDo+VvcpiaODlMxB2IYsK/5lzgZz0xV5mrPT9No4QmyyyRnKDcUl6zoFzHVN
	 u77RlA7b7rYfjGC/bwcL9FMGp0HCOL7TjPcAiKqWWKoCWW0uP9GLF0VvzexPQMRcFQ
	 1+7YPRF+dYuPs8aE4/vGApr4oAU5zq3E7KQdcd6I=
Date: Tue, 30 Apr 2024 10:51:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yick Xie <yick.xie@gmail.com>
Cc: stable@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 4.19.y] udp: preserve the connected status if only UDP
 cmsg
Message-ID: <2024043035-tamer-angling-f9da@gregkh>
References: <2024042925-enrich-charbroil-ce36@gregkh>
 <20240430080923.3154753-1-yick.xie@gmail.com>
 <2024043057-gloss-sustainer-601f@gregkh>
 <CADaRJKs+1dyyLMzVrBW8ZHBOxSjFW7PwX7VeK6qY0qCj6iHLjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADaRJKs+1dyyLMzVrBW8ZHBOxSjFW7PwX7VeK6qY0qCj6iHLjg@mail.gmail.com>

On Tue, Apr 30, 2024 at 04:45:07PM +0800, Yick Xie wrote:
> All of them have been sent out.

All now queued up, thanks.

greg k-h

