Return-Path: <stable+bounces-254413-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGQlI+XkFWrdeAcAu9opvQ
	(envelope-from <stable+bounces-254413-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 20:22:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4A25DB4B2
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 20:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58867300B555
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 18:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F187B421EF3;
	Tue, 26 May 2026 18:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="auROnhPk"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E884218A6
	for <stable@vger.kernel.org>; Tue, 26 May 2026 18:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779819743; cv=none; b=dzj0x5OYD/ptNh1P3WfRAhr0VlarD2u7eEpfE+5TASXm4ah+TdZUplh6jaCgnHR33UwmTYj+jXL+JVKle8kL4bxRIABbEMk9mzhWR4NkGflGvhWCZxkPYsxneOfTd75I6oHs61PpMWxPct7Pajh4MLf+P9DRTHgTFZvntEDXIGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779819743; c=relaxed/simple;
	bh=zlYmaVIxdNX99KaTjy189VPXIUUas+kgW8ZjV6vlCA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tN53CqGLC1TwILJ1/hPA1RJ7xpvFyBn3zKN83x+S0QLNvzAdrhuHzBva/EyIK8XBsPm2glJEFhR5t7P8mNjovOohcH+m/Gpdav80kXfi21shdsCv/MaTcHYB6gkIPB6sxY9TFDFWw4+M6PoOo+NJvSwKRXAv+fXBq9vtYChLQ7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=auROnhPk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779819741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AnH0XvnakOmjvDsCffQvkdqlIl51HEj38q+ePa8HlEs=;
	b=auROnhPk2zb9HCDNpdRYn44S1QrrA6Jf5NqWR+zFDsXzDQlKWdXBaDuhysYokD0C48YP+a
	RqlflPja8Srl+z79QzMYmQdh/Pf0GWhGzrmYYtwYzD0fZZWEIJUgUJ2Q56KS8RDSz1Fhnb
	8dOeQeiQFErAtMQcm6jKESUiDQK/DVI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-480-twMgr7NaN62BQVpyXwEEdA-1; Tue,
 26 May 2026 14:22:17 -0400
X-MC-Unique: twMgr7NaN62BQVpyXwEEdA-1
X-Mimecast-MFC-AGG-ID: twMgr7NaN62BQVpyXwEEdA_1779819735
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8C5511956096;
	Tue, 26 May 2026 18:22:15 +0000 (UTC)
Received: from fedora (unknown [10.44.48.14])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A620E1955F19;
	Tue, 26 May 2026 18:22:11 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 26 May 2026 20:22:15 +0200 (CEST)
Date: Tue, 26 May 2026 20:22:10 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jann Horn <jannh@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Arjan van de Ven <arjan@linux.intel.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Jake Edge <jake@lwn.net>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
	Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 1/2] proc: protect ptrace_may_access() with
 exec_update_lock (part 1)
Message-ID: <ahXk0lBmeewqINHh@redhat.com>
References: <20260518-procfs-lockfix-part1-v1-0-5c3d20e0ac33@google.com>
 <20260518-procfs-lockfix-part1-v1-1-5c3d20e0ac33@google.com>
 <ahVeT9TTxlJiW2Qu@redhat.com>
 <CAG48ez0RXFp6nFfOOz0MeQMPknnCPeBj9j1ndR6kL9oE=ZSc=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez0RXFp6nFfOOz0MeQMPknnCPeBj9j1ndR6kL9oE=ZSc=A@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254413-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oleg@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3D4A25DB4B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 05/26, Jann Horn wrote:
>
> On Tue, May 26, 2026 at 10:48 AM Oleg Nesterov <oleg@redhat.com> wrote:
> > On 05/18, Jann Horn wrote:
> > >
> > > Fix the easy cases where procfs currently calls ptrace_may_access() without
> > > exec_update_lock protection, where the fix is to simply add the extra lock
> > > or use mm_access():
> >
> > I thought about this too, but I do not know if it is fine performance wise...
> >
> > And what about proc_coredump_filter_write() which doesn't use ptrace_may_access() ?
>
> Yeah, this series doesn't fix everything,

Aah... Of course, I understand. I wasn't clear. Sorry if it looked as
"you missed proc_coredump_filter_write" from my side.

What I actually tried to ask:

	- Do you think it makes sense to fix proc_coredump_filter_write()
	  as well?

	- If yes. Do you think we should add another down_read(exec_update_lock) +
	  ptrace_may_access() into proc_coredump_filter_write() ? Or perhaps we
	  should discuss other approaches (exec_id/seqcount/etc) from the very
	  beginning?

Oleg.


