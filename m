Return-Path: <stable+bounces-98705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F07F99E4BD3
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 02:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABAAC284F97
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 01:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF5785270;
	Thu,  5 Dec 2024 01:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UQ6jPJHI"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9C3391
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 01:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733362025; cv=none; b=A0WA6+ZzPuMcKfjCRK248QgppX6tI3l6OzuAwvNoVTcZPEdDzpn8DhvhYu4UGOl+iSGYNe0O5yfNp8iRuCxEGVjtOB6gPixkrJJ9xYBEuw2tq4GNvtghvEr96PzHhFmdSINZ6THI61Aov5EATl2CxLml18o7ndKU0SN0c9sw9Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733362025; c=relaxed/simple;
	bh=L438MqHB1Lzc+kZ8gwgHIgBQEde5wvvXOFnhmyjN7bE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hrCGM0ABWiNaIykse90vNOKTenxMx7aqAkNLyjL6w6Zi1ka+gsqDWYB7owlnkz/5kOLZbo3WKT3zuSNflQIfKnHcLa0sCPpAUYHIIE09ifknHp2ZB3OVWptp6ZPqWmRX7blGNDBfYdejJCgiiWz3ZLtEiBV12sYAQmP4HSL+n0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UQ6jPJHI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733362022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VRzCKUh57lh2RbsskuLfk2Sa3SyCxeQEj/TMWD4N4MA=;
	b=UQ6jPJHIbtjCeWVMNSFTnRmYIjiw8BSu5+gLO8qjqqyaRzEfcmGPEgLV/Ez5OCVeIUA6XN
	V061+3LaZF2wMEP7Gre+3fjEFSeLp0oES3QSpw1A+c8S5jeFHIEO5fo6iFRSdo5qZ8+WKW
	MQTzIx8mnnp/Gz60RZw9zbg2+amDzBo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-364-SnaIFmbfPOy0W8VSdmU-Eg-1; Wed,
 04 Dec 2024 20:27:00 -0500
X-MC-Unique: SnaIFmbfPOy0W8VSdmU-Eg-1
X-Mimecast-MFC-AGG-ID: SnaIFmbfPOy0W8VSdmU-Eg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 82D9F19560B6;
	Thu,  5 Dec 2024 01:26:58 +0000 (UTC)
Received: from redhat.com (unknown [10.22.64.4])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF0D71956054;
	Thu,  5 Dec 2024 01:26:56 +0000 (UTC)
Date: Wed, 4 Dec 2024 19:26:54 -0600
From: Bill O'Donnell <bodonnel@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: cem@kernel.org, stable@vger.kernel.org, jlayton@kernel.org,
	linux-xfs@vger.kernel.org, hch@lst.de
Subject: Re: [PATCHSET v2] xfs: proposed bug fixes for 6.13
Message-ID: <Z1EBXqpMWGL306sh@redhat.com>
References: <173328106571.1145623.3212405760436181793.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173328106571.1145623.3212405760436181793.stgit@frogsfrogsfrogs>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Tue, Dec 03, 2024 at 07:02:23PM -0800, Darrick J. Wong wrote:
> Hi all,
> 
> Here are even more bugfixes for 6.13 that have been accumulating since
> 6.12 was released.
> 
> If you're going to start using this code, I strongly recommend pulling
> from my git trees, which are linked below.
> 
> With a bit of luck, this should all go splendidly.
> Comments and questions are, as always, welcome.
> 
> --D

Hi Darrick-

I must ask, why are these constant bug fixes and fixes for fixes, and fixes for fixes for fixes
often appearing? It's worrying that xfs is becoming rather dodgy these days. Do things need to be
this complicated?

-Bill


> 
> kernel git tree:
> https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=proposed-fixes-6.13
> ---
> Commits in this patchset:
>  * xfs: don't move nondir/nonreg temporary repair files to the metadir namespace
>  * xfs: don't crash on corrupt /quotas dirent
>  * xfs: check pre-metadir fields correctly
>  * xfs: fix zero byte checking in the superblock scrubber
>  * xfs: return from xfs_symlink_verify early on V4 filesystems
>  * xfs: port xfs_ioc_start_commit to multigrain timestamps
> ---
>  fs/xfs/libxfs/xfs_symlink_remote.c |    4 ++
>  fs/xfs/scrub/agheader.c            |   66 ++++++++++++++++++++++++++++--------
>  fs/xfs/scrub/tempfile.c            |    3 ++
>  fs/xfs/xfs_exchrange.c             |   14 ++++----
>  fs/xfs/xfs_qm.c                    |    7 ++++
>  5 files changed, 71 insertions(+), 23 deletions(-)
> 
> 


