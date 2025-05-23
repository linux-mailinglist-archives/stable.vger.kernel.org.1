Return-Path: <stable+bounces-146149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 367E0AC1A54
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 05:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 969591BC4577
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 03:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB66E22129A;
	Fri, 23 May 2025 03:10:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525D2218AC8;
	Fri, 23 May 2025 03:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747969834; cv=none; b=C5CAW7HzgI0H5sbX1NQMSNlxNc8DuUPAvkjeidwjNLjaIU4IdKhA/rw5EzfAJ+w6w+vaQEHu36sPxbrKwT9UIroPw+SDCwb+CtAnhCUOnoGo0HtzOZMbE9fc0/tg8pRZXjjhhPn3SO/tR7Koy/+fAegmJ6lJf9rXF2WHCGWDBPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747969834; c=relaxed/simple;
	bh=aopWxo9c85Zcks/Gg5oIH7H07Xu0umY8YVe30IuWyrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ueioEALhsJY4pok7iLTCMo3r/RJDTdNXKPxV0+M5sBtSV1wpOK7mQRSDTdOiyniH0e+rgWe6R8uPzbbDRL6PNGcpQ/3I/w+0WColKtwbmq9zH5Ou/DLN/uYmHCADs23vp1ZG/5My80aBCz2+2o4bkFTQnTgYI46i+A5WLzcc2Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1504667373; Fri, 23 May 2025 05:10:20 +0200 (CEST)
Date: Fri, 23 May 2025 05:10:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Yu Kuai <yukuai1@huaweicloud.com>, Ming Lei <ming.lei@redhat.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] block: Fix a deadlock related freezing zoned storage
 devices
Message-ID: <20250523031019.GA5564@lst.de>
References: <20250522171405.3239141-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522171405.3239141-1-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, May 22, 2025 at 10:14:05AM -0700, Bart Van Assche wrote:
> Changes compared to v1: fixed a race condition. Call bio_zone_write_plugging()
>   only before submitting the bio and not after it has been submitted.

And just like I told you for v1 we can't just bypass queue freezing.

And I'll ask you again to provide a reproducer and explain your findings.
Without that you we are just waisting a lot of time and effort.


