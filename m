Return-Path: <stable+bounces-71398-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7354D9624E8
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 12:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FE55284FB0
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 10:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FF516B3B6;
	Wed, 28 Aug 2024 10:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="tJvJH7YE"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE3D86250;
	Wed, 28 Aug 2024 10:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724840888; cv=none; b=MUIDdHB3RrGc5RQCnToIyepsU01u1eVr12uyKJzFP8eXf376KJTFcrX7bmdSE6oMa64KdQEoSjQqtB1Nvz+34BFhjZp8RkJEz+8sZ66oQ7RpobUTZJFA9mOE+3rhgTn2U7rlb185Y0kzg8cZS5iWEboGFu6DhrZtE84KCyf584E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724840888; c=relaxed/simple;
	bh=gaPlcdEA7Z9YOY307vMY480QLIT/MFs/VK4xOCj73x8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FTAxWFQ48kz/1LZgWXf1XrEpB6FuKG9JNFg8D6nG7GpjDGNaSO3t6TQ2MH833IoOhW+b3LAyNK/FxRZyncGc9WIormr9E2iQWOEGObORswDehU4QTIzBFsw/foBgsxwja8WOPCqgq8+UWiK1guOvquVec4PgHVdWF5S4q7VeD3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=tJvJH7YE; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Wv0wr6X8lz9tHb;
	Wed, 28 Aug 2024 12:27:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1724840876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UHJJNtLGi09bnfsgHmNFjhdxvbLAnk7lz+tuyz0TCRw=;
	b=tJvJH7YEoN2ul4yhYxdAEQSykAoV8j03onoaVRaxus5rozfftSQHSlddDvsX+CbZYLlKNX
	YI4FoDGEyi+sG+QCybXxZTUdvgaAmv9tXc7BwRYfwllc9AtGPJFE8iZANKX0rZ1mwmr1iX
	fqP0obbff/3u9P+tDu9XhbnbN9pR5R1ptOSUijCiFst5RNF5vUN6zjR5Ha7HyFnwx5Rxxx
	hdYJ7+xsfhTGpV8lk78388El/ci0AT3l/tNrf1xS7/amboN4/E7kMo3vrH0mBxZoCdZ9G9
	D9vECapuaq0r8pIhJ9P40w/soo98OvofBLyk56kwWN4XW9j1qTF9zWgaaVg4xg==
Date: Wed, 28 Aug 2024 10:27:53 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Cc: Pankaj Raghav <p.raghav@samsung.com>, Christoph Hellwig <hch@lst.de>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"javier.gonz@samsung.com" <javier.gonz@samsung.com>
Subject: Re: [PATCH 1/1] nvme-pci: add NVME_QUIRK_BOGUS_NID for Samsung PM173X
Message-ID: <20240828102753.msxe2owymg42zwqp@quentin>
References: <20230315223436.2857712-1-saeed.mirzamohammadi@oracle.com>
 <20230321132604.GA14120@lst.de>
 <20230414051259.GA11464@lst.de>
 <CGME20230427074641eucas1p185bb564521b6c01366293d20970fdfe2@eucas1p1.samsung.com>
 <20230427073752.3e3spo2vgfxdfcv2@localhost>
 <53369ABE-DB4F-44B0-831C-E4CB232A949A@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53369ABE-DB4F-44B0-831C-E4CB232A949A@oracle.com>
X-Rspamd-Queue-Id: 4Wv0wr6X8lz9tHb

On Tue, Aug 27, 2024 at 07:08:15PM +0000, Saeed Mirzamohammadi wrote:
> Hi Pankaj/Samsung team,
> 
> Sorry for pulling up an old thread. Has this been fixed in the firmware? If not, we could fix this issue with quirk for now until it’s resolved on the firmware side.

Hi Saeed,
  As I said before, this was specifically requested by the customer. I
  would highly encourage you to get in touch with the firmware team in
  Samsung.

  So I still don't think this should go as a generic quirk.

<snip>

> >> Did this go anywhere?
> > We had a discussion about this internally with our firmware team, and it
> > looks like these firmware were given to specific customers based on
> > mutual agreement. They are already in discussion with our firmware team
> > regarding this.
> > 
> > I don't think this should go into as a generic quirk in Linux for these
> > models.
> 

-- 
Pankaj Raghav

