Return-Path: <stable+bounces-141995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 723F2AAD9E6
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 10:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 719539A1C3D
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 08:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B393721147F;
	Wed,  7 May 2025 08:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YppOQCWq"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B032222D7
	for <stable@vger.kernel.org>; Wed,  7 May 2025 08:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746605350; cv=none; b=GUb9I01nKuJ7IkBcXSe3AiOFp3giorTdafzDEuUAdtY7aUOmyxXXoq7CNCtQa5otFkQa79Ct6uLeqTaBClhIHBK+/X3sof+HLUpkO6NEMjX812aa5DDLQ6pxnQmLhfrdX58DthZPzM72sTCW7aKyVdUB0cJARD1Qhtdoohn6STU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746605350; c=relaxed/simple;
	bh=vyVsUJZnol9e/16gsq+GvcSE0OY9xhY0vrHxNzS4QN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOyMdxvDlWJhTIqo+1gW1L41cgJPzaJRTPGm13AAqoVOipuw9tioT6E4dIbs/t9H8iMdEPIDH6OGurrQar4hYPJBTRqgHndEP6Hm9ionfZLZknj+a65cPIeVkNloOq9okDw2wqYolZuyH3lhZ2vfCIBdJiMGg54RdShMd7pO5JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YppOQCWq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746605348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1lPXuoPy491a0nenBDzmJTrQnzVkjZ805burt7i68G0=;
	b=YppOQCWqEbGctSgL+fP7xktR9UhylRH3Lyn0TI56oYKT9C9ErIwDCR5GIpJpYomnJeko7i
	SJVQrKZhau/OePizV7i+qUWGcP7xQU2an/+KAXnt+szTfkW7SyiOXPOvdBG+Z2K6uVQIHt
	+h4GN6LTejxfBeMxV2FCyKXQIN8+NF8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-h3NR8NhdNB2C5nJA5WUfEg-1; Wed,
 07 May 2025 04:09:06 -0400
X-MC-Unique: h3NR8NhdNB2C5nJA5WUfEg-1
X-Mimecast-MFC-AGG-ID: h3NR8NhdNB2C5nJA5WUfEg_1746605345
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B08819560A1;
	Wed,  7 May 2025 08:09:05 +0000 (UTC)
Received: from fedora (unknown [10.72.116.93])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1820319560A7;
	Wed,  7 May 2025 08:09:00 +0000 (UTC)
Date: Wed, 7 May 2025 16:08:53 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jared Holzman <jholzman@nvidia.com>
Cc: stable@vger.kernel.org, axboe@kernel.dk, ushankar@purestorage.com,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH v1 0/7] ublk: Backport to 6.14-stable: fix race between
 io_uring_cmd_complete_in_task and ublk_cancel_cmd
Message-ID: <aBsVFZGQInvVfq8l@fedora>
References: <20250506233755.4146156-1-jholzman@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506233755.4146156-1-jholzman@nvidia.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi Jared,

On Wed, May 07, 2025 at 02:37:48AM +0300, Jared Holzman wrote:
> This patchset backports a series of ublk fixes from upstream to 6.14-stable.
> 
> Patch 7 fixes the race that can cause kernel panic when ublk server daemon is exiting.
> 
> It depends on patches 1-6 which simplifies & improves IO canceling when ublk server daemon
> is exiting as described here:
> 
> https://lore.kernel.org/linux-block/20250416035444.99569-1-ming.lei@redhat.com/
> 

The patch itself looks fine, just you need to add upstream commit hash to each
patch, please follow the guide:

https://www.kernel.org/doc/Documentation/process/stable-kernel-rules.rst

Also there is one example:

https://lore.kernel.org/stable/20250430230616.4023290-1-alexander@tsoy.me/



Thanks,
Ming


