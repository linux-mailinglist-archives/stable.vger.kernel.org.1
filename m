Return-Path: <stable+bounces-89756-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 690399BBEEA
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 21:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2A3DB21C83
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 20:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099F71F585D;
	Mon,  4 Nov 2024 20:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c62b0P+8"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5167D1E47D8
	for <stable@vger.kernel.org>; Mon,  4 Nov 2024 20:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730752952; cv=none; b=V2+R7AGxSkSvsHhhG1yxqMeGh5jTUxZYtoAcmtJ8zJcG65j8HpCOqGJUzfTkihhlnNVDrWDTrJ/3ctUfQ9amaY8tY/QCH1YPHMhjnVbblZG6nfvG46CC14MSJ6nDdpDYWxlVlga3YOGhg9KdslOXN8tgs/DgR3ZmMO2kWd7Adn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730752952; c=relaxed/simple;
	bh=ix7Kqk7GQmr/xV7w8jeE+AQaNlvDZOuASROq2dm+eZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d25aScoLGIEPtv+Hj2zBoVFXDPbDlW5z7CTiQW5wfnS3QOrdH+A/yTYT0h0LuIpW2IOM7NaanLKw41ZvPu+JFjJYgHWVwba1aKTfiGEAd9gdEtM4kDG4yUi22S73wiUEKrsLZ1yK/baBzcCqnaIjQvFc+os9VdQSPNnY7Kqh82I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c62b0P+8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730752950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7sMUGsUyl1WIe7UvWFagXtO9/bnq4SlWJJ0dMGdfYUo=;
	b=c62b0P+853z8mYlOOrHRpw2MQ7ujH9KZyrPsy4Oqn8P6qbmbA0kU1dv83rKFCFKlZQnrAg
	BXcS9hUZWaW4Yka7Hns0QN6uqrZHK2J8LSGiY9qrhmyh+UWMw7sGFvU67yBGzawzTnu+JL
	8YGkP3tahvZwD3cwENeCn6AuVj98qrE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-303-VNIcwlUvNPOHCeqEUhnltA-1; Mon,
 04 Nov 2024 15:42:27 -0500
X-MC-Unique: VNIcwlUvNPOHCeqEUhnltA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1B2211955EB3;
	Mon,  4 Nov 2024 20:42:25 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.168])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D3EC019560AA;
	Mon,  4 Nov 2024 20:42:21 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  4 Nov 2024 21:42:07 +0100 (CET)
Date: Mon, 4 Nov 2024 21:42:03 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Andrei Vagin <avagin@google.com>, Kees Cook <kees@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Alexey Gladkov <legion@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2] signal: restore the override_rlimit logic
Message-ID: <20241104204202.GB26235@redhat.com>
References: <20241104195419.3962584-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104195419.3962584-1-roman.gushchin@linux.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 11/04, Roman Gushchin wrote:
>
> -long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type)
> +long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type,
> +			    bool override_rlimit)
>  {
>  	/* Caller must hold a reference to ucounts */
>  	struct ucounts *iter;
> @@ -320,7 +321,8 @@ long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type)
>  			goto unwind;
>  		if (iter == ucounts)
>  			ret = new;
> -		max = get_userns_rlimit_max(iter->ns, type);
> +		if (!override_rlimit)
> +			max = get_userns_rlimit_max(iter->ns, type);
>  		/*
>  		 * Grab an extra ucount reference for the caller when
>  		 * the rlimit count was previously 0.

Acked-by: Oleg Nesterov <oleg@redhat.com>


