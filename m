Return-Path: <stable+bounces-161638-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DCFB01717
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 11:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA386170E64
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 09:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA271FE45B;
	Fri, 11 Jul 2025 09:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DRsLp5s6"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227BD20D500
	for <stable@vger.kernel.org>; Fri, 11 Jul 2025 09:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752224533; cv=none; b=gGxPL/R93DYvRHPGvHT43+dp8bu2bpcKF5uqK5vpk3Kl3HquPtUfjy/gObSVnHIM8xkCWh8EbXm54f3KlC/YYQH0HkTIVROccMtpfz4c8ppkAKKWZxfo2RfyI8VV56VyYj9zAJdq9WZ2VpJQyOSbdyB5Q+PNW04JffzOrZ5P52M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752224533; c=relaxed/simple;
	bh=cto3EzGQZzW73ugCld0nMZaHD1j8pd8ICo4AwYB7fdA=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=gPka2UedsjufYnoeFuAHHtgrqiYnayfcwA2f8tkjfbHwO68cK6iV1/al+ZXNTuGA/PUVS9HdsRpIjUHnM3JAmHzZeATiGopASi7UAQT6yP7jpC43eiiCcqSJbx/aLD7ebmlWHc9kv9r26wPVPt4cyoAk6HeXxFv7VQYFWtbM3nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DRsLp5s6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752224529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o1jZHyMv/IfsPFuzxj8R0DksAkT3xvNU/ruvopmewh4=;
	b=DRsLp5s6Vwpdqtn9rwBKAPlXegf3eyGxCiUH4Ajr52/nfZ/nRy2fvT+RVsFID+SqZSghcM
	YIVFCh38FLD01rvJiWpjrHegAzKo2L59z1vSOHVRVTgrTWatjkvc9lyUq8f9yWsdwlvB5m
	jYDbm/vgBwEuz0ThccTOdSDwcolDhhk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-rivJtzP0M4KrE81clFfU_Q-1; Fri,
 11 Jul 2025 05:02:04 -0400
X-MC-Unique: rivJtzP0M4KrE81clFfU_Q-1
X-Mimecast-MFC-AGG-ID: rivJtzP0M4KrE81clFfU_Q_1752224521
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A262819560A5;
	Fri, 11 Jul 2025 09:02:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.2])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E349030001A1;
	Fri, 11 Jul 2025 09:01:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250710165040.3525304-1-henrique.carvalho@suse.com>
References: <20250710165040.3525304-1-henrique.carvalho@suse.com>
To: Henrique Carvalho <henrique.carvalho@suse.com>
Cc: dhowells@redhat.com, stable@vger.kernel.org, smfrench@gmail.com,
    linux-cifs@vger.kernel.org, Laura Kerner <laura.kerner@ichaus.de>
Subject: Re: [PATCH 6.6.y] smb: client: support kvec iterators in async read path
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2944135.1752224518.1@warthog.procyon.org.uk>
Date: Fri, 11 Jul 2025 10:01:58 +0100
Message-ID: <2944136.1752224518@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Henrique Carvalho <henrique.carvalho@suse.com> wrote:

> Add cifs_limit_kvec_subset() and select the appropriate limiter in
> cifs_send_async_read() to handle kvec iterators in async read path,
> fixing the EIO bug when running executables in cifs shares mounted
> with nolease.
> 
> This patch -- or equivalent patch, does not exist upstream, as the
> upstream code has suffered considerable API changes. The affected path
> is currently handled by netfs lib and located under netfs/direct_read.c.

Are you saying that you do see this upstream too?

> Reproducer:
> 
> $ mount.cifs //server/share /mnt -o nolease
> $ cat - > /mnt/test.sh <<EOL
> echo hallo
> EOL
> $ chmod +x /mnt/test.sh
> $ /mnt/test.sh
> bash: /mnt/test.sh: /bin/bash: Defekter Interpreter: Eingabe-/Ausgabefehler
> $ rm -f /mnt/test.sh

Is this what you are expecting to see when it works or when it fails?

David


