Return-Path: <stable+bounces-181625-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7A7B9BA08
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 21:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF3BD3B4DD0
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 19:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E7825F784;
	Wed, 24 Sep 2025 19:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R4MQTFQk"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FE9263899
	for <stable@vger.kernel.org>; Wed, 24 Sep 2025 19:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758741148; cv=none; b=OyOzE91HAS/62o5Bh7tMFmvn8B9H8BP0dMEOAK1lD86t3RvP9h78OPvSaSVSNO2AVXBRr2MZKe1ReR0M4xtxTssKsdQOfpephBWd/upBt2saM67kEysjiIkRIgTnVOfiO9BCHfqNBhx+YzADGhkxtokGs2+jUQDcck6PA7dTNwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758741148; c=relaxed/simple;
	bh=bfdr1izZepy2d7hS8qSaPF7cdm5I0VSenaOU1miTlig=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=UJlugU4pi+8fxXnePz4RbQYwUIYArKtJlbwkglQoM//dsLHQcQypiw6iaBkIHu334C7CF7B0psTjiFSz5uuJH6sNYGM/7zpHNQHoSosGYTseiNftsrNg5duJVB+JE2lq+3b7oNQ3qqHFAAlp3fu8Opw6b20+lUt37rtLhFNauQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R4MQTFQk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758741145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mxh2bN/wrBh4C6P/52usGNA7maYhZCqL+ZR8wk6yXAM=;
	b=R4MQTFQknK/BIdIy5sRfudn2mfU4QAbsO4LIxfh6Wo8wUC0gDrOZYMgKnhj90p758P/Zna
	05gtmeT7ComUHAgMrqkuAPPmSi3LOF0xZ0I8frcMtdZJxbo0bBts0M77wMk/4TIKOUJC07
	ScxXSkIJXABsg62mc87oxts73m1TYag=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-303-TrbHQcITPIqXwuhjR3G3iA-1; Wed,
 24 Sep 2025 15:12:20 -0400
X-MC-Unique: TrbHQcITPIqXwuhjR3G3iA-1
X-Mimecast-MFC-AGG-ID: TrbHQcITPIqXwuhjR3G3iA_1758741139
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E485D19560B8;
	Wed, 24 Sep 2025 19:12:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.155])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D77EE1800578;
	Wed, 24 Sep 2025 19:12:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250924185558.3395930-1-max.kellermann@ionos.com>
References: <20250924185558.3395930-1-max.kellermann@ionos.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.org>,
    Christian Brauner <brauner@kernel.org>, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    stable@vger.kernel.org
Subject: Re: [PATCH v2] fs/netfs: fix reference leak
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <845749.1758741135.1@warthog.procyon.org.uk>
Date: Wed, 24 Sep 2025 20:12:15 +0100
Message-ID: <845750.1758741135@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Max Kellermann <max.kellermann@ionos.com> wrote:

> +void netfs_put_failed_request(struct netfs_io_request *rreq)
> +{
> +	/* new requests have two references (see
> +	 * netfs_alloc_request(), and this function is only allowed on
> +	 * new request objects
> +	 */
> +	WARN_ON_ONCE(refcount_read(&rreq->ref) != 2);
> +
> +	trace_netfs_rreq_ref(rreq->debug_id, 0, netfs_rreq_trace_put_failed);
> +	netfs_free_request(&rreq->cleanup_work);
> +}

Can you change the 0 in trace_netfs_rreq_ref() to refcount_read(&rreq->ref)?
(Or I can do that)

David


