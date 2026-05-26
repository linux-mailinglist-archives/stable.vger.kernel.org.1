Return-Path: <stable+bounces-254309-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDsiNsp/FWqtWAcAu9opvQ
	(envelope-from <stable+bounces-254309-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 13:11:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6AE5D4B14
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 13:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EEA7B300A659
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 11:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB9C3DEFE7;
	Tue, 26 May 2026 11:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YJB16skJ"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618693DDDDF
	for <stable@vger.kernel.org>; Tue, 26 May 2026 11:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779793858; cv=none; b=ZeVPjkJCce8gdFEWzy8HVZEukQr3Gj0/5+NtTk6BgjvV5rE0HOlFSwgLLuvDIdU11v4ia14FVeGO7d9E3Wy68c9WJPyM8Rd/iYPgQ/WM7BNOEUX/6of2M9V8umQQCyHa+KnCBu64EkjNYcFIEc4/LiQfV6E68+LBGtniAm2+Te0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779793858; c=relaxed/simple;
	bh=+A4STEwAAmqpj7s7BJT+qrktjbNqPTjkY028kSStQxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FTBCV217n5SHdIUxKCZ5O7jgUC1HNMHYC/tdCPBzHzci2cecjPgDRRynbEdeOKzKHOigRpBDP7lb18erkHDCJfCtTLqSJ2yR+Sl7VnncfyuqXUsZ3Xb3B2om6VfHrCE+L9RdzRGKwbjVzCqDJOGoOmuFOjU6lFuD2FC5lr57lUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YJB16skJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779793856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V60fH3o0tseovGlXITmBLQbsSF3we5hZT0I6t617kxE=;
	b=YJB16skJ1aBSWQdpkD2Im70rbZqCensjSoXZu93TKn9cVfXEri3LBIV/zSb3JzCvDF7cUI
	g4XW091ccep93WofH9qt2syvtchXSO0V5S/S8VTWQScsfXejzmFkp7GfGnKU9TsivRm8/G
	OTxkhgJNGAQbq8ngqbbxnKBFOT2E8LI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-17-zFG5O6ahOoivRNxo5ca3RQ-1; Tue,
 26 May 2026 07:10:52 -0400
X-MC-Unique: zFG5O6ahOoivRNxo5ca3RQ-1
X-Mimecast-MFC-AGG-ID: zFG5O6ahOoivRNxo5ca3RQ_1779793851
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D359C19560AE;
	Tue, 26 May 2026 11:10:50 +0000 (UTC)
Received: from fedora (unknown [10.44.48.14])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E50F01688;
	Tue, 26 May 2026 11:10:46 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 26 May 2026 13:10:50 +0200 (CEST)
Date: Tue, 26 May 2026 13:10:45 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Arjan van de Ven <arjan@linux.intel.com>, Jake Edge <jake@lwn.net>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 0/2] proc: protect ptrace_may_access() with
 exec_update_lock
Message-ID: <ahV_teQZlF5hhYHf@redhat.com>
References: <20260518-procfs-lockfix-part1-v1-0-5c3d20e0ac33@google.com>
 <87ik8b2rh8.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ik8b2rh8.fsf@email.froward.int.ebiederm.org>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254309-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oleg@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DF6AE5D4B14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 05/25, Eric W. Biederman wrote:
>
> The ugly with PTRACE_EVENT_EXIT as I recall is that if ptrace stops one
> of the threads (not the one calling exec) at PTRACE_EVENT_EXIT it can
> block de_thread, which blocks the rest of exec.  But there is something
> in there where the ptracer hangs waiting for the exec to complete.  So
> everything just stalls.  The ptracer waiting for exec the exec waiting
> for the ptracer.  SIGKILL can get you out of that mess last I looked.
> Still it is an ugly mess.

Yes... note that even without PTRACE_EVENT_EXIT a traced sub-thread won't
autoreap, so de_thread which waits for --sig->notify_count in __exit_signal()
will block anyway.

Perhaps we can change ptrace_attach() to detect this case somehow and return
-EWOULDBLOCK... Yes this can confuse strace/gdb, but this is better than
the deadlock, even if it is killable.

Oleg.


