Return-Path: <stable+bounces-176499-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DB5B3811E
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 13:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 501554604AE
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 11:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B839829AAFA;
	Wed, 27 Aug 2025 11:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HRGpgjVD"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FDE230BCB
	for <stable@vger.kernel.org>; Wed, 27 Aug 2025 11:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756294429; cv=none; b=Z3Y6pHorKaBFFkKsaHLO2q9WBVNI0RKatuCz/2OGpfl6D4/mtccjcEIHin6GqTK5+rMKiSueU9AJWsGzFeEZOobmWViAqVmy9A8yAKr/Z7AiCJKgLFSZGdbgCdDrabpbnvyiL3GkccfN/iDjNuX1ZnE4zInlXaHnc4lqbDOZ8Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756294429; c=relaxed/simple;
	bh=XmNCkzuQTa4pSLXuCBnvKLcjmKigsVba1pgLbUpx+X4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=THfotn1vw+GdT2X6KrY0Qn+OA8bKIp9KacXti95wdV1VDOxHTUIboXPZB59kNtTLTEduy+4FOIJPIric5I+o/ld/yvmFN4tUtLHvpKsz9CFGu6C5u+D0xiy0oetdkY0/w4i+JJYuzHjmwVd60jCfwn66r4eHsvReUh5frBW9O+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HRGpgjVD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756294427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c004jzm2W4PkBjkE5bj+/Vzdbx5vYKS5DvBkpQgw7xM=;
	b=HRGpgjVDNXzwXRxGycxfWTnYR6u2Pmc4piClq1kpjLVgANQ5SV91VfORDljwGbmEEo5M++
	XExjOAqfhRXPkgjRmX1ahg0lcXZzpujM608PyXnqPUZJukPuRuQRWt+/9BrqlN5Oxa1oZo
	nGB7G5Wp9Rdr9TRV9eAyHuPf1Erqbvs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-135-ilkgBNJtM2aBkgCYTXwC1A-1; Wed,
 27 Aug 2025 07:33:43 -0400
X-MC-Unique: ilkgBNJtM2aBkgCYTXwC1A-1
X-Mimecast-MFC-AGG-ID: ilkgBNJtM2aBkgCYTXwC1A_1756294422
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7563819560B2;
	Wed, 27 Aug 2025 11:33:41 +0000 (UTC)
Received: from localhost (dhcp-192-195.str.redhat.com [10.33.192.195])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 526E919560AB;
	Wed, 27 Aug 2025 11:33:39 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>
Cc: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "stefanha@redhat.com"
 <stefanha@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>, Max Gurtovoy
 <mgurtovoy@nvidia.com>, "NBU-Contact-Li Rongqing (EXTERNAL)"
 <lirongqing@baidu.com>
Subject: Re: [PATCH] Revert "virtio_pci: Support surprise removal of virtio
 pci device"
In-Reply-To: <20250827061537-mutt-send-email-mst@kernel.org>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20250822091706.21170-1-parav@nvidia.com>
 <20250822060839-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195292684E62FD44B3ADFF9DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250822090249-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195392690042EF1600CEAC5DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250822095225-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195C932CA73F6C2FC7484ABDC3FA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250824102947-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71956B4FDE7C4A2DA4304D0CDC39A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250827061537-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Wed, 27 Aug 2025 13:33:37 +0200
Message-ID: <87frdddmni.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wed, Aug 27 2025, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Aug 26, 2025 at 06:52:03PM +0000, Parav Pandit wrote:
>> > What I do not understand, is what good does the revert do. Sorry.
>> > 
>> Let me explain.
>> It prevents the issue of vblk requests being stuck due to broken VQ.
>> It prevents the vnet driver start_xmit() to be not stuck on skb completions.
>
> This is the part I don't get.  In what scenario, before 43bb40c5b9265
> start_xmit is not stuck, but after 43bb40c5b9265 it is stuck?
>
> Once the device is gone, it is not using any buffers at all.

What I also don't understand: virtio-ccw does exactly the same thing
(virtio_break_device(), added in 2014), and it supports surprise removal
_only_, yet I don't remember seeing bug reports?


