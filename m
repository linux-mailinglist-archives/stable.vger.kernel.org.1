Return-Path: <stable+bounces-181606-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87276B9A1CD
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 15:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38B841756D8
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 13:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E2C2D9EE1;
	Wed, 24 Sep 2025 13:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VdIeOW18"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED158280018
	for <stable@vger.kernel.org>; Wed, 24 Sep 2025 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758722059; cv=none; b=kQlvMyjYCFQdYC0YuLXJ2THTpRwdT/8iiVbDXEAvB3bQgRZRSUBjA02v4zfR4O1cu8wPREPu4RqKUXoY8PiyUS8+7uniei8GFVFl45r+KkU268Sh2jsW/RP9zz/9Gq7V9QXQLoq93ZVthMx/Kc/zZElxVNiTnRqrmQrUoHfZlsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758722059; c=relaxed/simple;
	bh=u+UL2SKXK+zzyrU7f0XnwYDGZmtMG97p8dfFtz2Fsn0=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=VZWFcRv1f9W4Dkh3BSzGd1M6QmqHpCa0CeuB7xAGY+JbKV2+dghw2Ow2k23JxOXJIpwjDEY9etR6zQxcFt51KC/VxqdBLq1lpBHrspcMj1TheHOhs04ZK54sdzxIFBWDpJuVPt5lDBktYANVF+5oK6K89ALD17NsvLwg17WfmQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VdIeOW18; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758722055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dKeIMwGs7GUFddwsch2eYbh6rjEo/AnzA5Csp77LLxI=;
	b=VdIeOW18s9V/M/5tbTjn1UkV1yagcJFKH38PGFbKm66UY1/mNH8FPAOJUHrGVpRhNZF3N2
	34meIdGkR7+nLyLGSnHURGBdH786E1qwAFKOLXdTFPjr/G2b0VXVwFckucnNE4V7dJR/TR
	5H2l6nnIfKvj7q8RYEOdhvXx/wcCIG0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-fUSfSon8OwqccIN7K0QCUA-1; Wed,
 24 Sep 2025 09:54:10 -0400
X-MC-Unique: fUSfSon8OwqccIN7K0QCUA-1
X-Mimecast-MFC-AGG-ID: fUSfSon8OwqccIN7K0QCUA_1758722049
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B86461800365;
	Wed, 24 Sep 2025 13:54:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.155])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 38A14300018D;
	Wed, 24 Sep 2025 13:54:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250923075104.1141803-1-zhen.ni@easystack.cn>
References: <20250923075104.1141803-1-zhen.ni@easystack.cn>
To: Christian Brauner <brauner@kernel.org>
Cc: dhowells@redhat.com, Zhen Ni <zhen.ni@easystack.cn>,
    marc.dionne@auristor.com, linux-afs@lists.infradead.org,
    stable@vger.kernel.org
Subject: Re: [PATCH] afs: Fix potential null pointer dereference in afs_put_server
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <742133.1758722044.1@warthog.procyon.org.uk>
Date: Wed, 24 Sep 2025 14:54:04 +0100
Message-ID: <742134.1758722044@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Christian,

Zhen Ni <zhen.ni@easystack.cn> wrote:

> afs_put_server() accessed server->debug_id before the NULL check, which
> could lead to a null pointer dereference. Move the debug_id assignment,
> ensuring we never dereference a NULL server pointer.
> 
> Fixes: 2757a4dc1849 ("afs: Fix access after dec in put functions")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>

Can you pick this patch up and add:

Acked-by: David Howells <dhowells@redhat.com>

Thanks,
David


