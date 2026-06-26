Return-Path: <stable+bounces-268965-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +XPKEmuWPmpsIgkAu9opvQ
	(envelope-from <stable+bounces-268965-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 17:10:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8786CE585
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 17:10:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="fD/4lAjE";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268965-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268965-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D3DB304047E
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 15:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995B737B02A;
	Fri, 26 Jun 2026 15:06:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71810376BE2
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 15:06:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782486401; cv=none; b=X29p2Bf6zsKS3MPyfDu4d04IkygBDdCGJIxL3JubnGx/IuifX6bPOriOwtWuBUvZzD9IUz0Yx0xeUqYs10bLTiJKvYJKOkmKOFvXtELAMUXn+ye20r2gJmYISW0QjZH+fuzvnmc9cHX1bmA/2z725kMKzYpmfilgpEMkj1ln1+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782486401; c=relaxed/simple;
	bh=WxThccFU6fqH1o7MU/b8IjeGX/MbGDadiHicR6Np6Es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvEr61UZpGWU1bu8z2bSjtB3cRvqJeOxVkNFi/w22KEcLvnruCOOBJjzmNIOIFVIducD0DV2fZEXIwuMqQlMri8o/OsyGXt/1HR5L1ik/brf5xo+9/QfWdqDlh0AywA4ulqWCBoo2U7qBpcnZ1/GR9GQ7cbA+s536sDQo3UUGRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fD/4lAjE; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782486395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WxThccFU6fqH1o7MU/b8IjeGX/MbGDadiHicR6Np6Es=;
	b=fD/4lAjEyFtIb9Jk86YObDcdRhliZeqLO2sz1MKVzMQgdK0PD+oaPZ+vr8dU8LuGk794J/
	jZQf6yjuLGzDyQjlwZbPk6/YoSSPgLG80nDZkW6LjC40zWDGiBqqKf4ZeJ9n2JYgd+4RXj
	SQhIyeFrjY8Il/Gi0rcJD20YTSO65cE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-dZPTgASaNzCfbsZgxDOP4Q-1; Fri,
 26 Jun 2026 11:06:31 -0400
X-MC-Unique: dZPTgASaNzCfbsZgxDOP4Q-1
X-Mimecast-MFC-AGG-ID: dZPTgASaNzCfbsZgxDOP4Q_1782486390
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7FC0C1955DD3;
	Fri, 26 Jun 2026 15:06:29 +0000 (UTC)
Received: from fedora (unknown [10.44.33.126])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D9B34180057F;
	Fri, 26 Jun 2026 15:06:24 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 26 Jun 2026 17:06:29 +0200 (CEST)
Date: Fri, 26 Jun 2026 17:06:19 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Bradley Morgan <include@grrlz.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, ebiederm@xmission.com,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Huang <adrianhuang0701@gmail.com>,
	Marco Elver <elver@google.com>,
	Kexin Sun <kexinsun@smail.nju.edu.cn>,
	Thomas Gleixner <tglx@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] signal: avoid shared siginfo namespace rewrites
Message-ID: <aj6Va2nNBZvDJqP5@redhat.com>
References: <20260622164029.11474-1-include@grrlz.net>
 <aj6Ms6uygc1vtySn@redhat.com>
 <FC7EAB84-0845-4DA3-AD43-3B30B47507E5@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FC7EAB84-0845-4DA3-AD43-3B30B47507E5@grrlz.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,xmission.com,kernel.org,infradead.org,gmail.com,google.com,smail.nju.edu.cn,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-268965-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS(0.00)[m:include@grrlz.net,m:akpm@linux-foundation.org,m:ebiederm@xmission.com,m:brauner@kernel.org,m:peterz@infradead.org,m:adrianhuang0701@gmail.com,m:elver@google.com,m:kexinsun@smail.nju.edu.cn,m:tglx@kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[oleg@redhat.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oleg@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5C8786CE585

On 06/26, Bradley Morgan wrote:
>
> On June 26, 2026 3:29:07 PM GMT+01:00, Oleg Nesterov <oleg@redhat.com>
> wrote:
> >To avoid the confusion, let me reply to V1 again.
> >
> >Acked-by: Oleg Nesterov <oleg@redhat.com>
> >
> >IIUC Eric is fine with this change too.
> >
> >Andrew, can you take this fix please? We will send more changes on top
> >of it.
>
> Thanks again oleg.
>
> Andrew did reply to V2.

OOPS... where? I didn't get any email from him in this thread...

Oleg.


