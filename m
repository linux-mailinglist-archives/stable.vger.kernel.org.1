Return-Path: <stable+bounces-254287-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eE+XLbNrFWoBVAcAu9opvQ
	(envelope-from <stable+bounces-254287-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 11:45:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 595775D39B0
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 11:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5884A30117C7
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 09:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C4C3D9666;
	Tue, 26 May 2026 09:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y5iSbB99"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAD83D9024
	for <stable@vger.kernel.org>; Tue, 26 May 2026 09:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779788690; cv=none; b=HgNzcO5yr/MeguKDR4NlsMOLaTa4B5yjQfrZcmPn6lQgfSxWeXKZv7WWQVmVBJWlmNtukXjgclY403VpCFrFC8tTZGysd6ItVAmdB9cOfbw3c+ZgtXW6h3Ii9/1WJsNFy7WMabforgJo74DDKWwIekQt3nxFovXjTF5zHyyoY0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779788690; c=relaxed/simple;
	bh=IHSVwXJPiynCs4+Zec1w99QS2qWQiOtQIsMq1m3b258=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ID/4m9MhJogYmh9c1zW9nVKYlSWir7OFGqziBT7p4Ut8J9N+wsbW7lSdDwTRY1Z+VKjcnzs4oUAI+vZrNlFVUpAIq/Fqz8oMG1g3qmpiIHrf3wGrqLjr6Hnw+B6mH1I0Tr/4ZGg00+DDw3GFdUMyhWi7lkYoxskXBvSepL+Zkaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y5iSbB99; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779788688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IHSVwXJPiynCs4+Zec1w99QS2qWQiOtQIsMq1m3b258=;
	b=Y5iSbB99ZpEq9cR9eB0QXVNSCKGsjmyqVJ4467R79xc0e47PR2BJ0tu4HZc8phBfWm9tX9
	lJjwJibigHiWUwRs+VxBl2zXthhkWeeD0jXPS6FH4jQADj+aUTVNp9ANFx1nEKPDAR0nlG
	tEllTjtIqLbKYUWjvlmMAKWbq75V5ig=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-Iv1RnVvjPQymGwX8mL_kvQ-1; Tue,
 26 May 2026 05:44:42 -0400
X-MC-Unique: Iv1RnVvjPQymGwX8mL_kvQ-1
X-Mimecast-MFC-AGG-ID: Iv1RnVvjPQymGwX8mL_kvQ_1779788680
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E650E19560A1;
	Tue, 26 May 2026 09:44:39 +0000 (UTC)
Received: from fedora (unknown [10.44.48.14])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B9DF619560AD;
	Tue, 26 May 2026 09:44:35 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 26 May 2026 11:44:39 +0200 (CEST)
Date: Tue, 26 May 2026 11:44:34 +0200
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
Message-ID: <ahVrgomLQ14ncWTE@redhat.com>
References: <20260518-procfs-lockfix-part1-v1-0-5c3d20e0ac33@google.com>
 <20260518-procfs-lockfix-part1-v1-1-5c3d20e0ac33@google.com>
 <ahVeT9TTxlJiW2Qu@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahVeT9TTxlJiW2Qu@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254287-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oleg@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 595775D39B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Perhaps proc_pid_make_inode() can record task->self_exec_id in
proc_inode ? At least this can help to fix the
"if (ptrace_may_access(task)) mm = get_task_mm(task)" pattern...

On 05/26, Oleg Nesterov wrote:
>
> On 05/18, Jann Horn wrote:
> >
> > Fix the easy cases where procfs currently calls ptrace_may_access() without
> > exec_update_lock protection, where the fix is to simply add the extra lock
> > or use mm_access():
>
> I thought about this too, but I do not know if it is fine performance wise...
>
> And what about proc_coredump_filter_write() which doesn't use ptrace_may_access() ?
>
> AFAICS, we can't rely on the open-time checks. /proc/$pid/coredump_filter can
> be opened for writing, the task can do suid exec after that, the file remains
> writable.
>
> Not a big deal, but still.
>
> Oleg.


