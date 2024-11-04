Return-Path: <stable+bounces-89743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 672109BBD71
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 19:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C34E2812F4
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 18:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641C21CEE8D;
	Mon,  4 Nov 2024 18:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ItfR/Lto"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9F318C010
	for <stable@vger.kernel.org>; Mon,  4 Nov 2024 18:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730745911; cv=none; b=NBJDCUtmDutOqzZgQaG75EPnAs4xMWMHZ/puiGV0rBGSs3/tdJqTpdzZT6FWHX2Mpqg6ISHIs6sj5eO71bsYiTjZNfPxVXDvwZfzflKE75KuGm+9V1kt+oc0+1MsSUVU4AGNZ0lQ81kRGQyXzhfW4ROiztNDuJVJhFnqMBRIfbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730745911; c=relaxed/simple;
	bh=LSYHL84k60O4Bp6oUKPEDc5h1hYdJevPt+gcIoulWwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjXQqqy5foCIp32OvUa/eN7ntVVSJMCjAtmISXC0RO8uZ1eNgxyxi7MZ6UnHTIu3dJMsUxDl4rpVOd29dmo8AkySrkGPbkhILSB9+2fawvN/msspBLe/sD0uyxcbaOOh6rMSdgbkErj0tkNGmj4WP2/754xpX+WRDV5vKPL9O9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ItfR/Lto; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730745908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LSYHL84k60O4Bp6oUKPEDc5h1hYdJevPt+gcIoulWwo=;
	b=ItfR/Lto0EuPHaYPeHyHtjq3RoUEQTILU8dxCnfMYuvHqWbUyp/O5UvA1S1Fe8gtCZLGaK
	7Ee24Q+fymSjcMMJvwy+7FGIDJKU+7fLebCfCoWjyMxCRoNHPd7/Wml6s106NilTlW8Z8X
	VmDgNhgoctnKNHgsFYlaluoNJbBLZMg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-kAF9FGTcO6yIawLiTPvJTA-1; Mon,
 04 Nov 2024 13:45:06 -0500
X-MC-Unique: kAF9FGTcO6yIawLiTPvJTA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB5661956069;
	Mon,  4 Nov 2024 18:45:04 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.168])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id DFE5D1956086;
	Mon,  4 Nov 2024 18:45:01 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  4 Nov 2024 19:44:47 +0100 (CET)
Date: Mon, 4 Nov 2024 19:44:43 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Alexey Gladkov <legion@kernel.org>, Andrei Vagin <avagin@google.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] signal: restore the override_rlimit logic
Message-ID: <20241104184442.GA26235@redhat.com>
References: <20241031200438.2951287-1-roman.gushchin@linux.dev>
 <87zfmi3f8b.fsf@email.froward.int.ebiederm.org>
 <ZyU8UNKLNfAi-U8F@google.com>
 <87o72y3c4g.fsf@email.froward.int.ebiederm.org>
 <CAEWA0a4Kz9exk04Wgx9UZ9YFfURnS-=50TWyhPHm3i-N-D_8DA@mail.gmail.com>
 <ZyZSotlacLgzWxUl@example.org>
 <20241103165048.GA11668@redhat.com>
 <ZykQnp9mINnsPTg2@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZykQnp9mINnsPTg2@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 11/04, Roman Gushchin wrote:
>
> On Sun, Nov 03, 2024 at 05:50:49PM +0100, Oleg Nesterov wrote:
> >
> > But it seems that the change in inc_rlimit_get_ucounts() can be
> > a bit simpler and more readable, see below.
>
> Eric suggested the same approach earlier in this thread.

Ah, good, I didn't know ;)

> I personally
> don't have a strong preference here or actually I slightly prefer my
> own version because this comparison to LONG_MAX looks confusing to me.
> But if you have a strong preference, I'm happy to send out v2. Please,
> let me know.

Well, I won't insist.

To me the change proposed by Eric and me looks much more readable, but
of course this is subjective.

But you know, you can safely ignore me. Alexey and Eric understand this
code much better, so I leave this to you/Alexey/Eric.

Oleg.


