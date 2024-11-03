Return-Path: <stable+bounces-89585-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6B59BA6B7
	for <lists+stable@lfdr.de>; Sun,  3 Nov 2024 17:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52C9A281BAC
	for <lists+stable@lfdr.de>; Sun,  3 Nov 2024 16:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A0618859E;
	Sun,  3 Nov 2024 16:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GGVIGzTg"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32965165EE8
	for <stable@vger.kernel.org>; Sun,  3 Nov 2024 16:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730652677; cv=none; b=hMI/flZXK4g7hGKMSN/7TTofVKNEyzAg6kqu3LwEdrRfGgr6F0x7Xks1XIfA0okMcApKLlwPbz036BUL8FkNEwbqNTcHkbMaeMG5YJn50x/K+qSd2j+yZWlWQQCt9ye0dcrS5leWFk2BMCpEPJZRVV9OctSlM2AO5nI0nVPGChA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730652677; c=relaxed/simple;
	bh=ZsSNw+9icvvVr1pjTy3qhV4A/3FHQpPNRzqxjXLdzes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dU5F2ohpK0wMDHu6tOyXThIkPIcWyz2PJMeiAXU904ofK6RIFcvj8BhYSQuvAWKf6SqCx0dDCUD/9iT16UbUycilXzohPlP4KnC3OpFL6CC2MJu8f07TpHNyTW11C+8MB+QU92SJqgZCeRbPi8BrPTEiXqlQ50Hdid5CHiBD9po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GGVIGzTg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730652674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ypFPoKgiYqq9zLFDMM1v1jWtbkTfe/etxTifSjr94PA=;
	b=GGVIGzTgVCaU0JJB26wxM40ABuZVc7r2E/DqYbrjwFoB8SXwSYfpU7CyQKeZsRbadT5QMj
	EtGQKJe+5R8n5qesvnib+3yitG/OSLdHcKPQ271TkS67Svbe/uP2Non1ImZ7n825Kmo3Pd
	ePKm+lmRip/qzKlF8FzeNIBAuDla9Wk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-XVBUbNQ2PpClkvWU62iKzQ-1; Sun,
 03 Nov 2024 11:51:12 -0500
X-MC-Unique: XVBUbNQ2PpClkvWU62iKzQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A513A19560B1;
	Sun,  3 Nov 2024 16:51:10 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.49])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A6B4C19560A2;
	Sun,  3 Nov 2024 16:51:07 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  3 Nov 2024 17:50:53 +0100 (CET)
Date: Sun, 3 Nov 2024 17:50:49 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Alexey Gladkov <legion@kernel.org>
Cc: Andrei Vagin <avagin@google.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] signal: restore the override_rlimit logic
Message-ID: <20241103165048.GA11668@redhat.com>
References: <20241031200438.2951287-1-roman.gushchin@linux.dev>
 <87zfmi3f8b.fsf@email.froward.int.ebiederm.org>
 <ZyU8UNKLNfAi-U8F@google.com>
 <87o72y3c4g.fsf@email.froward.int.ebiederm.org>
 <CAEWA0a4Kz9exk04Wgx9UZ9YFfURnS-=50TWyhPHm3i-N-D_8DA@mail.gmail.com>
 <ZyZSotlacLgzWxUl@example.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyZSotlacLgzWxUl@example.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 11/02, Alexey Gladkov wrote:
>
> +Cc Oleg Nesterov.

Well, I tend to agree with Roman and his patch looks good to me.

But it seems that the change in inc_rlimit_get_ucounts() can be
a bit simpler and more readable, see below.

Oleg.
---

--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -307,7 +307,8 @@ void dec_rlimit_put_ucounts(struct ucounts *ucounts, enum rlimit_type type)
 	do_dec_rlimit_put_ucounts(ucounts, NULL, type);
 }
 
-long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type)
+long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type,
+			    bool override_rlimit)
 {
 	/* Caller must hold a reference to ucounts */
 	struct ucounts *iter;
@@ -320,7 +321,8 @@ long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type)
 			goto unwind;
 		if (iter == ucounts)
 			ret = new;
-		max = get_userns_rlimit_max(iter->ns, type);
+		if (!override_rlimit)
+			max = get_userns_rlimit_max(iter->ns, type);
 		/*
 		 * Grab an extra ucount reference for the caller when
 		 * the rlimit count was previously 0.


