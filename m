Return-Path: <stable+bounces-144571-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4D5AB9558
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 06:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D01507B7E5C
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 04:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C95157A6B;
	Fri, 16 May 2025 04:51:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1272D4B1E44;
	Fri, 16 May 2025 04:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747371091; cv=none; b=Ri6uG3+b+NxUzyU1M9agiXzXLqU2no1OMs9dkLycq1hnZaMUUe1XwN4e1uRSdo8Vp02eJxM8WP+pe8yFe1WMlGy3nENx82OSWZtN52rSjbTXSohejbwQPHvKTerwb0QVC+Qt7g/DHcW1uygChzuLzYRmBQvqxsRO8nJXz41YmeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747371091; c=relaxed/simple;
	bh=1C07mZRpH7Wqb5+KFcvdfCKd/a+IxY0xxBlCWG4D/OY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ayv0boiEY+gJ1LmdsmWSP6eYw/RAbeogDpxFRQC1Io56PGccmoa+RRPG4EQG//ff248BaYX2ZxPW7hWtNmJnqXEdPetVTiBZMnfDvx2veaZtFOLO6QnOfi+SK+b0L+BsZwBh9v29wzHyqTdacz69JmzgquX0Qlq2c438/Qet96o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id EDA0468AA6; Fri, 16 May 2025 06:51:24 +0200 (CEST)
Date: Fri, 16 May 2025 06:51:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Yu Kuai <yukuai1@huaweicloud.com>, Ming Lei <ming.lei@redhat.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] block: Fix a deadlock related freezing zoned
 storage devices
Message-ID: <20250516045124.GB12964@lst.de>
References: <20250514202937.2058598-1-bvanassche@acm.org> <20250514202937.2058598-3-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514202937.2058598-3-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, May 14, 2025 at 01:29:37PM -0700, Bart Van Assche wrote:
> +/*
> + * Do not call bio_queue_enter() if the BIO_ZONE_WRITE_PLUGGING flag has been
> + * set because this causes blk_mq_freeze_queue() to deadlock if
> + * blk_zone_wplug_bio_work() submits a bio. Calling bio_queue_enter() for bios
> + * on the plug list is not necessary since a q_usage_counter reference is held
> + * while a bio is on the plug list.
> + */

How do we end up with BIO_ZONE_WRITE_PLUGGING set here?  If that flag
was set in a stacking driver we need to clear it before resubmitting
the bio I think.

Can you provide a null_blk based reproducer for your testcase to see
what happens here?

Either way we can't just simply skip taking q_usage_count.

