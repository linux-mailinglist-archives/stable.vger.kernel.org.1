Return-Path: <stable+bounces-4835-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E9C806F89
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 13:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68F00B20DEC
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 12:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B13E364A4;
	Wed,  6 Dec 2023 12:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LDNy3lDA"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467BCBA
	for <stable@vger.kernel.org>; Wed,  6 Dec 2023 04:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701865061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eB959rdqwj3McpopDWbd2KITPsbXVjh5QYy/Nwyj7gY=;
	b=LDNy3lDAHufF7P/X1ceFVZHDVENsTsJorh751Y3eJ4noh/SvPFgGhyPLj7hcB2enuOKChh
	3GNQiHevgnCrHUcdkerBmhcyX69vI/Po5z/li3tG4ooPkF/bh8ht6GqgEZj7QTsuGy2Ubj
	oXz6EbFriVdCXwaYgB7V7NQxMF1s6rg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-oRHB5hP9Ot2hTUPZpvAgvg-1; Wed, 06 Dec 2023 07:17:38 -0500
X-MC-Unique: oRHB5hP9Ot2hTUPZpvAgvg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8CCD685CBA5;
	Wed,  6 Dec 2023 12:17:37 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.193.237])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4998D111E3EE;
	Wed,  6 Dec 2023 12:17:34 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: stern@rowland.harvard.edu
Cc: davem@davemloft.net,
	edumazet@google.com,
	greg@kroah.com,
	jtornosm@redhat.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	oneukum@suse.com,
	pabeni@redhat.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] net: usb: ax88179_178a: avoid failed operations when device is disconnected
Date: Wed,  6 Dec 2023 13:17:32 +0100
Message-ID: <20231206121732.7154-1-jtornosm@redhat.com>
In-Reply-To: <624ad05b-0b90-4d1c-b06b-7a75473401c3@rowland.harvard.edu>
References: <624ad05b-0b90-4d1c-b06b-7a75473401c3@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Hello Alan,

> The __ax88179_read_cmd() and __ax88179_write_cmd() routines are 
> asynchronous with respect to ax88179_disconnect(), right?  Or at least, 
> they are if they run as a result of the user closing the network 
> interface.  Otherwise there wouldn't be any memory ordering issues.
Yes, I think so, they could be asynchronous regarding ax88179_disconnect.

> But the memory barriers you added are not the proper solution.  What you 
> need here is _synchronization_, not _ordering_.  As it is, the memory 
> barriers you have added don't do anything; they shouldn't be in the 
> patch.
Ok, thank you for the helpful clarification, let me check it better,
I understood it in a wrong way.

> If you would like a more in-depth explanation, let me know.
Thank you for your help, I will try first, I really appreciate this.

Best regards
José Ignacio


