Return-Path: <stable+bounces-108373-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFF6A0B11D
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 09:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C41603A57A8
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 08:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96C3233154;
	Mon, 13 Jan 2025 08:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CjpDqtI0"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115D1233140
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 08:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736756994; cv=none; b=jFpuRiG7FBgRkDDQXDGtHdrf310HfwkMbIkQgTS5ywwt5ljQhLRgtOg+085MrUT0DqXsyhKOHPkWg460XzAYVJnTNfGHNZTsj34zc3QlxxNPPcH8f/YDl4OqoLhBKOPIuv+wzlF7gOha/Xqdt3hgeZ+SUAKRp6B5NZ94+6bXsr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736756994; c=relaxed/simple;
	bh=dBBh2L0GRTutoCtgtcm0z/4Dr/JhYHq2koDnETJwpow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cw3UyCJMDJQmsW8am55sHeABtpXSD1edXVcdETsXE5+7bQig6YtwF1tvEq1N43vFtHHPXN7MeUum4QkHJRk1oJRmWG6hTEmKNgpUhGNTY7Ka2sB0uuLIrehws8DoBvUyA++nKOka4oR/o5Vy8lHvDATIXavDfd5vp5D2CcojWiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CjpDqtI0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736756991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K6GNSSNmAfq8X4vJUzhF/qrQ0SkEFIP0FbiQxYL4Q5E=;
	b=CjpDqtI0i12Tg0sKneEOQGprvJZ2sDASLYjiPWYfvdMxe+eUUql3+HllpPjggix/MKTone
	xxRXnm1DRohO2MgjFrEEMbNGKTKQgjbCbW6Xjz4Wb2MsRnmz8nJRshK4rfz65LLSIXIWy5
	rPDN+KEvK0Sso7WUblxy6PU9TyyRBjc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-ulrURbz_NwWqRjfHtXuC6g-1; Mon,
 13 Jan 2025 03:29:49 -0500
X-MC-Unique: ulrURbz_NwWqRjfHtXuC6g-1
X-Mimecast-MFC-AGG-ID: ulrURbz_NwWqRjfHtXuC6g
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A707195606F;
	Mon, 13 Jan 2025 08:29:48 +0000 (UTC)
Received: from fedora (unknown [10.72.116.4])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 77F7730001BE;
	Mon, 13 Jan 2025 08:29:43 +0000 (UTC)
Date: Mon, 13 Jan 2025 16:29:37 +0800
From: Ming Lei <ming.lei@redhat.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] block: mark GFP_NOIO around sysfs ->store()
Message-ID: <Z4TO8bVgTnB2q4Oz@fedora>
References: <20250113015833.698458-1-ming.lei@redhat.com>
 <2fa89c60-a507-43a0-98ed-4d182bcea3ee@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2fa89c60-a507-43a0-98ed-4d182bcea3ee@oracle.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Jan 13, 2025 at 08:23:19AM +0000, John Garry wrote:
> On 13/01/2025 01:58, Ming Lei wrote:
> > sysfs ->store is called with queue freezed, meantime we have several
> > ->store() callbacks(update_nr_requests, wbt, scheduler) to allocate
> > memory with GFP_KERNEL which may run into direct reclaim code path,
> > then potential deadlock can be caused.
> > 
> > Fix the issue by marking NOIO around sysfs ->store()
> > 
> > Reported-by: Thomas Hellström<thomas.hellstrom@linux.intel.com>
> > Cc:stable@vger.kernel.org
> > Signed-off-by: Ming Lei<ming.lei@redhat.com>
> 
> I guess that you should be including a link to https://lore.kernel.org/linux-block/Z4RkemI9f6N5zoEF@fedora/T/#mc774c65eeca5c024d29695f9ac6152b87763f305
> 

Indeed, I will add a Closes tag in V2.


> Regardless, FWIW:
> Reviewed-by: John Garry <john.g.garry@oracle.com>

Thanks,


-- 
Ming


