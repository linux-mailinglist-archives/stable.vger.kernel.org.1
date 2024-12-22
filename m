Return-Path: <stable+bounces-105562-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 530969FA7A9
	for <lists+stable@lfdr.de>; Sun, 22 Dec 2024 20:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3BC8165807
	for <lists+stable@lfdr.de>; Sun, 22 Dec 2024 19:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DCC192D84;
	Sun, 22 Dec 2024 19:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="excKdCuI"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE85A18E054
	for <stable@vger.kernel.org>; Sun, 22 Dec 2024 19:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734895157; cv=none; b=JJfe1aWuB5Uf3pWHVVSLndHQbJBFJrvXybcdTYoQcbscMI9xSI2tFyeVzgQw8lCWf4c9qiUv6qvyr/fgsIAJzvWsy2B0TVvyNQ/r1IuiIT0qRFI/OyDA3OOSQF31h7etS2WaX2PjcdC6MnP6AQAEd/jCbWfeEnXOXzBRelS31Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734895157; c=relaxed/simple;
	bh=3fYwNzIBWKbEuxRCKjXnKf6+QLQCZIJ7U4RHQamSGUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5apNsdPLXZCPCBBpbl/LAtKwSxvmPOERkmCLXE8yivTq5Z3huS3ZQjC+kOgQ03bw9fJvGrgMlRr5K8RXX71GWUYSEIeJn5M2L6aj24Nx8tHM06Jbsj5KXnr6o9HmaA5V5VBnG9G3LFxo0w8dwfOD5j6DT15MJ/IcfCctZQ3hrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=excKdCuI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734895154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3fYwNzIBWKbEuxRCKjXnKf6+QLQCZIJ7U4RHQamSGUY=;
	b=excKdCuId9iOiK318SSRQTzBBtdyHsR/hTxbvHkUvfb6+atm2/1U9gxbXcxNDpxK9yqopv
	VOE1dv0kqnZUupAn5cxYZDTZ2A/Iv1XTvAAOFUjsgTZ766BRG1a+lk2+cg4eJykjY667ov
	UD0LlopHMfqLlAJuZXEMQgZlKeG6+l4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-M0dHsuhIMK6xe8Bd2aO7gg-1; Sun,
 22 Dec 2024 14:19:09 -0500
X-MC-Unique: M0dHsuhIMK6xe8Bd2aO7gg-1
X-Mimecast-MFC-AGG-ID: M0dHsuhIMK6xe8Bd2aO7gg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5DA5719560AA;
	Sun, 22 Dec 2024 19:19:07 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.16])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 535C83000197;
	Sun, 22 Dec 2024 19:19:02 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 22 Dec 2024 20:18:43 +0100 (CET)
Date: Sun, 22 Dec 2024 20:18:37 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dylan Hatch <dylanbhatch@google.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	John Ogness <john.ogness@linutronix.de>,
	Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] fs/proc: do_task_stat: Fix ESP not readable during
 coredump
Message-ID: <20241222191837.GA4224@redhat.com>
References: <cover.1730883229.git.namcao@linutronix.de>
 <11e1777296b7d06085c9fd341bafc4b9d82e6e4e.1730883229.git.namcao@linutronix.de>
 <20241217145923.GA29091@redhat.com>
 <20241217150913.GB29091@redhat.com>
 <20241220145326.Q7Z6NQ7j@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220145326.Q7Z6NQ7j@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Nam,

On 12/20, Nam Cao wrote:
>
> > Can't the trivial patch below fix the problem?
>
> It can. In fact this is the original fix we had. I thought that checking a
> single "core_state" is simpler than checking 3 flags, oh well..
>
> Can you send a proper patch, or should I do it?

Can you send V2 please? It was you who found/investigated the problem,
and the patch is trivial.

Feel free to include my acked-by.

Thanks,

Oleg.


