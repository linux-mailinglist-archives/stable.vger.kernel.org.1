Return-Path: <stable+bounces-87793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CF49ABB5D
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 04:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76B8CB22213
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 02:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618954595B;
	Wed, 23 Oct 2024 02:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jSmzT7b1"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0343208A5
	for <stable@vger.kernel.org>; Wed, 23 Oct 2024 02:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729649762; cv=none; b=ieGOIx5q29mno3Sk+10hxCmKaIzcB1BRM58+BkMkiNs+3EFwNEtksSaUePN9aEyEQnjZzk87/R7L3QBJq3vp3Y9w9gqw5vE6yJV0gRVx1CCgSWfqjWU5Q5xiY0rkL3HNPamV0qEvGkqFud6T3Jje1iWZgAnTBG3dnqkGNvo2ikE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729649762; c=relaxed/simple;
	bh=Rxp/VQMU1PU9c1THWr5ynYdOTndthDFX+dUvvPPAWdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsuSWRLXHYvQrfGzCdBAi44f+qhmDBtWhLFqm8RiiRQDG9ngkD9cyINXc0oxHUYNzRTX+q3fcHqQNf3Irr1E1zpr/8j7A3hCjNYga3j73R7KLxJSMeBeLSSzjD8j/yB3KGCevon52dploN5Pi+VZTMSjn8X5UCOgdj+kdE+Vcds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jSmzT7b1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729649758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7L4MhxCYhofNtLg+tXJAr77AFE/k5Jqpq5D0/+wLQY0=;
	b=jSmzT7b1xSaFpPhFkV1sP840l6V2O+von4fsoszzfkE3MRIo0fhgdrswiSnS/EvfFHn3tN
	RBLP8lKXAmAYECs21og/2E5L0KjyQutO9aCCrf6rLSaIDALc5BLj3L7emvMm6yHOUdVuar
	nmvwRBZJmim0dNowHTwOwCdTmAttMG4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-uwIhkWCqM1mc3HExexN2WA-1; Tue,
 22 Oct 2024 22:15:55 -0400
X-MC-Unique: uwIhkWCqM1mc3HExexN2WA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1192E19560AA;
	Wed, 23 Oct 2024 02:15:54 +0000 (UTC)
Received: from fedora (unknown [10.72.116.47])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D8D7D1956056;
	Wed, 23 Oct 2024 02:15:48 +0000 (UTC)
Date: Wed, 23 Oct 2024 10:15:43 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Peter Wang <peter.wang@mediatek.com>,
	Chao Leng <lengchao@huawei.com>, stable@vger.kernel.org
Subject: Re: [PATCH] blk-mq: Make blk_mq_quiesce_tagset() hold the tag list
 mutex less long
Message-ID: <ZxhcT46a6glC0Db7@fedora>
References: <20241022181617.2716173-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022181617.2716173-1-bvanassche@acm.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Oct 22, 2024 at 11:16:17AM -0700, Bart Van Assche wrote:
> Make sure that the tag_list_lock mutex is no longer held than necessary.
> This change reduces latency if e.g. blk_mq_quiesce_tagset() is called
> concurrently from more than one thread. This function is used by the
> NVMe core and also by the UFS driver.
> 
> Reported-by: Peter Wang <peter.wang@mediatek.com>
> Cc: Chao Leng <lengchao@huawei.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: stable@vger.kernel.org
> Fixes: commit 414dd48e882c ("blk-mq: add tagset quiesce interface")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


