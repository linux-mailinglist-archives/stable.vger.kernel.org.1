Return-Path: <stable+bounces-124620-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3AFA648B0
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 11:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D5F03B1049
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 10:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEF0226D1D;
	Mon, 17 Mar 2025 10:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i4J9Gpoe"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F041227BB2
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 10:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742205806; cv=none; b=WTENyJyakr99Vq8CiGaOQJavRUho23scx90rNU6eNqKxYwfSuZ37sa9QsFbyif4Qd19OTEdCLLqXtvKJRtqtN5sAWYaQBrorFBX2ti8QpJtrbHDek0kp29haeE/lDKU/FX+BwjhS26KXSNq0LccKGfongXgfjr5WPvuTxIuTkvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742205806; c=relaxed/simple;
	bh=ypZ17jJfpN+bq6gupq+Ho+KrCCKX7qiYeSCHx1uvw2M=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=ie9rfpQAJPRwZT0Q+x6JQ7ty2Urj9dYZZ6mpPdIOjPyDbybupD3z96/jG/Ob1rQnsWbskZpl0OJaLReJO0lL7jgDtwsr6i2yc+hKq98scvjmKUx8JwZykYj0nV/uMBQB6DQe+bZwUIe9HxBa3JQvPEP8dwGvSxfa9Qzx0OUrLjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i4J9Gpoe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742205803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ypZ17jJfpN+bq6gupq+Ho+KrCCKX7qiYeSCHx1uvw2M=;
	b=i4J9GpoedtPwGknbEDstc5sNdwRGBfpmQ5ZWkfqo+n/Wra/bGYlFwpOWLNERASviAHf9eM
	QDqR79eYJlEjClJaIYjTY77BOjCFyki2vBTbysFs0anxF7ZeEfYulH4ziESQTt1lA52xm6
	YxaIGv684zkFUmRovnR1fDNO8p/4uzA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-GtkgsP6UO8qCsvDShsm1mg-1; Mon,
 17 Mar 2025 06:03:18 -0400
X-MC-Unique: GtkgsP6UO8qCsvDShsm1mg-1
X-Mimecast-MFC-AGG-ID: GtkgsP6UO8qCsvDShsm1mg_1742205796
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D8CFB18001E6;
	Mon, 17 Mar 2025 10:03:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.61])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F2DD519560AD;
	Mon, 17 Mar 2025 10:03:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250220152450.1075727-1-max.kellermann@ionos.com>
References: <20250220152450.1075727-1-max.kellermann@ionos.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: dhowells@redhat.com, Max Kellermann <max.kellermann@ionos.com>,
    netfs@lists.linux.dev, linux-kernel@vger.kernel.org,
    stable@vger.kernel.org
Subject: Re: [PATCH RESEND] fs/netfs/read_collect: add to next->prev_donated
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2110404.1742205792.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Mar 2025 10:03:12 +0000
Message-ID: <2110405.1742205792@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi Greg,

Could you pick this up for 6.12.y and 6.13.y?

https://lore.kernel.org/netfs/20250220152450.1075727-1-max.kellermann@iono=
s.com/

Thanks,
David


