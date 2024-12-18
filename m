Return-Path: <stable+bounces-105169-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC07E9F6872
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 15:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF1977A3899
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 14:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0221B041B;
	Wed, 18 Dec 2024 14:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gP6DaQ+D"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DEE7F477
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734532116; cv=none; b=Wk8KuGuvx8OZ4hfPIVFdCjA1bZ52a2SYfAgG4JPhIV6PrsFhOiutVptajwo38A21PCz7i8xEbY6S6Yvo1K+06JgvSgNMvMnGKnr4hChGZNaTwYpC8bFoqaG0Iki4lvTy+HQDDxC/nTsm1czWVCGTujGv1zbeslxpxpFWUSGrMWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734532116; c=relaxed/simple;
	bh=gROJY2ljwX6Mp1YX+wR8sSOd+J9BLPfNQ5KxrXqquRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MqPfV5FaER4u7duMTrCZzmcY7/becJAJDPC7zCTvrS1PGYwnBZWA85v+aJLtZGNhucmlwUIUG7yBI+lzf5MMLp9oG/Ox8/wTSoaM0E9q6FL/O0lcaPq4QAKh4xzMnSLysoERWG653O0RGnwCsQy43GJBhzdAeWG4Ny5mJl1WbcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gP6DaQ+D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734532114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bkuiz4Qgqt3Oq/7IFt71ZMAizrbOQcCyggtbM/Jj6uw=;
	b=gP6DaQ+DO5nm/rwbml8HyJlMzT/XDdKCX9TwCCv5R+puCHKumuJ9V6dX9gOlMqlTKQC946
	hXZsvHos1mvhyDJcAU7ikdZ7JW2nuFt+dddykFhI+3hzjOxIF1s4naAbIt7ps/iPzO4O1s
	vx8x2VbjbFFWKP5JcRnpl56ZCk0bMgQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373-qzqu4jwPPsqaCqNaohPoFw-1; Wed,
 18 Dec 2024 09:28:27 -0500
X-MC-Unique: qzqu4jwPPsqaCqNaohPoFw-1
X-Mimecast-MFC-AGG-ID: qzqu4jwPPsqaCqNaohPoFw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CFA071956057;
	Wed, 18 Dec 2024 14:28:25 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.58.13])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5E3061956053;
	Wed, 18 Dec 2024 14:28:24 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: anna@kernel.org, zichenxie0106@gmail.com, zzjas98@gmail.com,
 linux-nfs@vger.kernel.org, stable@vger.kernel.org, chenyuan0y@gmail.com
Subject: Re: [PATCH] NFS: Fix potential buffer overflowin
 nfs_sysfs_link_rpc_client()
Date: Wed, 18 Dec 2024 09:28:21 -0500
Message-ID: <90DF7D11-B6A9-4715-823C-CE1E33DBB9FC@redhat.com>
In-Reply-To: <299a43ab3a10317475fcd53f5d130fe3610ca07a.camel@hammerspace.com>
References: <20241217161311.28640-1-zichenxie0106@gmail.com>
 <41572d6005dfb2042482f98177a9b295433c8a5f.camel@hammerspace.com>
 <299a43ab3a10317475fcd53f5d130fe3610ca07a.camel@hammerspace.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 17 Dec 2024, at 12:07, Trond Myklebust wrote:

> On Tue, 2024-12-17 at 16:51 +0000, Trond Myklebust wrote:
>> On Wed, 2024-12-18 at 00:13 +0800, Gax-c wrote:
>>> From: Zichen Xie <zichenxie0106@gmail.com>
>>>
>>> name is char[64] where the size of clnt->cl_program->name remains
>>> unknown. Invoking strcat() directly will also lead to potential
>>> buffer
>>> overflow. Change them to strscpy() and strncat() to fix potential
>>> issues.
>>
>> What makes you think that clnt->cl_program->name is unknown?
>>
>> All calls to nfs_sysfs_link_rpc_client() use well known RPC clients
>> for
>> which the cl_program is pointing to one of nlm_program, nfs_program
>> or
>> nfsacl_program. So we know very well the sizes of clnt->cl_program-
>>> name.
>
> Just to clarify: I'm not strongly against the patch itself. However it
> would seem premature to consider this a bug, let alone a stable fix
> candidate. 
>
> Has anyone ever seen a buffer overflow here? If so, under which
> circumstances?

No, there's no way in the current kernel, but I suppose both
nfs_sysfs_link_rpc_client() as well as rpc_create() are exported, so we
could end up having some other part of the kernel send a long "uniq" or
create a client with a long cl_program->name.  That change might escape our
review.

Probably not a bad idea to send it back to stable IMO, since a change like
that could get back there too.

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


