Return-Path: <stable+bounces-159274-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A5AAF67BF
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 04:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1C2C1C45D11
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 02:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB93F13A258;
	Thu,  3 Jul 2025 02:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pq+UjU/s"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21EC10E5
	for <stable@vger.kernel.org>; Thu,  3 Jul 2025 02:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751508535; cv=none; b=OKRvP/4yN6To8zfFPDMHHktXVE+VEk6cspCRmnvYT4PQhttzEyLWRVx26v5YZ9sDqa6F3Q4yvMnJv7f9Z6F0ieESemv9hO9+PdQu5BcwwdjxG4FCtf0koRc1g9Gf+OuXVFCEFbAZIFK/pPsNFkwHyTelxXVb6W//XPdLpYMlWSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751508535; c=relaxed/simple;
	bh=xuxmoyBv6Hc83w0VaD6m722C+zV2bRMFHcP9kM94acA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTa5sslUWtfA21lS3hUAudNXftJ8TuWd0J5pqrcPatyrZURICNH1o5oRNsPY6zLyn4RJChIy257kmKCthJL3lVJs8EacrJFGkRQ1yyhmmolrJKzeDweUkuZL2Ezc27rKRFdSK+1V2iIMHPbbhh8yfV97Ymv+jO4qYmCG8+oiGJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pq+UjU/s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751508532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/M29umMbsMChXKdFRpWTtKhVV8sXKJDMlvqyNyuZTXE=;
	b=Pq+UjU/sbKTXuFUVSEG24/LCTpyoqKM9tbFrLtRnB3qZYO30hmV9fqQdULJVPtgtB8Um4z
	oGHaYuInN71/4Dd0u32zpMQxf4ayMYhA+qVcyxyxaI0y2tK4rTzVgwy2H6C2HMWBVVlcyA
	hxpE/nPeYuHeabfkGfVQZdHZV6Dl8Zg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-9pv0A832OzGQ9SjaN3FE1w-1; Wed,
 02 Jul 2025 22:08:51 -0400
X-MC-Unique: 9pv0A832OzGQ9SjaN3FE1w-1
X-Mimecast-MFC-AGG-ID: 9pv0A832OzGQ9SjaN3FE1w_1751508530
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C3877180034E;
	Thu,  3 Jul 2025 02:08:49 +0000 (UTC)
Received: from fedora (unknown [10.72.116.108])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 171F9180045C;
	Thu,  3 Jul 2025 02:08:44 +0000 (UTC)
Date: Thu, 3 Jul 2025 10:08:38 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Nilay Shroff <nilay@linux.ibm.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/3] block: Remove queue freezing from several sysfs
 store callbacks
Message-ID: <aGXmJg-ZIuFO9WnP@fedora>
References: <20250702182430.3764163-1-bvanassche@acm.org>
 <20250702182430.3764163-2-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702182430.3764163-2-bvanassche@acm.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, Jul 02, 2025 at 11:24:28AM -0700, Bart Van Assche wrote:
> Freezing the request queue from inside sysfs store callbacks may cause a
> deadlock in combination with the dm-multipath driver and the
> queue_if_no_path option. Additionally, freezing the request queue slows
> down system boot on systems where sysfs attributes are set synchronously.
> 
> Fix this by removing the blk_mq_freeze_queue() / blk_mq_unfreeze_queue()
> calls from the store callbacks that do not strictly need these callbacks.

Please add commit log why freeze isn't needed for these sysfs attributes
callbacks.


Thanks, 
Ming


