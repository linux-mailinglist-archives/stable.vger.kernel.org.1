Return-Path: <stable+bounces-233014-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uP6FLPRuzmnxngYAu9opvQ
	(envelope-from <stable+bounces-233014-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 15:28:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE94389B8E
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 15:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47897313AB7E
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 13:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E87733CE88;
	Thu,  2 Apr 2026 13:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B1/wN2n+"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2688D33F8C5
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 13:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775135612; cv=none; b=PCoyrO2w4VXfcMWdDX1N94M7cxKUaHJxm+JYskJhwOD/pCGdLQN4Agznui0pOxAdsY6xwR+kLTodCNm9QgVjcdFSwTHkqLsYwjhWF8BLEz6fM7A30qVPC5C4O67PBQ6xv+7okEhFkZk/aYJOUTr2sKNaFfugaKErErGuY1L3TYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775135612; c=relaxed/simple;
	bh=/YRNIQrSkQf4zLA1baxaQXSwOyrPQlDuT6XsLrPAOZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AbDGv5HBFU0/7t5vPhQEew1ghGeXyDKDMDSuUw6NArKGd+gQjO+O7SVQUkZvnkl9UjokgNQlNSkZu93pDsmULvQfkbKixiVmXluan/nhNwP2df6CopnTrIKqeLUg/AWqOe8qZNv1C0qSREOzrId4bY6eFbxPaT7Hm9Q46IHicI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B1/wN2n+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775135610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8dqJbydy8kPoZ8vkvOHpYwvti02M9iy/iDgel0f8R/U=;
	b=B1/wN2n+4XUKBtaOiF7iZ1vF+ksqFHA92IqV0OaLjYrpaVh0O1Us/oOnhgFagZ7B1BmIX/
	eDHckcRpQ93h+zk+jhRm3d/5VpNHyuYDwcEh6ksYUMQ3e9suOM/z6yM3bOt4w/ScCrYXEQ
	DtXTJqqaMVZJfUFCJzmFoGlfzmvroL0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-6yz4-_QfOT6mBShUEPdWVQ-1; Thu,
 02 Apr 2026 09:13:27 -0400
X-MC-Unique: 6yz4-_QfOT6mBShUEPdWVQ-1
X-Mimecast-MFC-AGG-ID: 6yz4-_QfOT6mBShUEPdWVQ_1775135601
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D22D51800654;
	Thu,  2 Apr 2026 13:13:19 +0000 (UTC)
Received: from fedora (unknown [10.44.36.60])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 0F60730002D2;
	Thu,  2 Apr 2026 13:13:16 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  2 Apr 2026 15:13:19 +0200 (CEST)
Date: Thu, 2 Apr 2026 15:13:15 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Qi Tang <tpluszz77@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Cyrill Gorcunov <gorcunov@openvz.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] prctl: require checkpoint_restore_ns_capable for
 PR_SET_MM_MAP
Message-ID: <ac5ra3EArU31ZKI9@redhat.com>
References: <20260402111332.55957-1-tpluszz77@gmail.com>
 <ac5nzyCMJSkwuhRh@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac5nzyCMJSkwuhRh@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233014-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,openvz.org:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oleg@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3FE94389B8E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Note also the comment above validate_prctl_map_addr() called by
prctl_set_mm_map(), "we don't require any capability here ...".

Oleg.

On 04/02, Oleg Nesterov wrote:
>
> On 04/02, Qi Tang wrote:
> >
> > The original commit f606b77f1a9e ("prctl: PR_SET_MM -- introduce
> > PR_SET_MM_MAP operation") states "we require the caller to be at least
> > user-namespace root user", but this was never enforced in the code.
> >
> > Add a checkpoint_restore_ns_capable() check at the top of
> > prctl_set_mm_map(), after the PR_SET_MM_MAP_SIZE early return.  This
> > requires CAP_CHECKPOINT_RESTORE or CAP_SYS_ADMIN in the caller's
> > user namespace, matching the stated design intent and the existing
> > check for exe_fd changes.
>
> Can't really comment... but if you add this check at the start, then you
> should also remove the same checkpoint_restore_ns_capable() check below?
> In the "if (prctl_map.exe_fd != (u32)-1)" block.
>
> Oleg.
>
>
> > Fixes: f606b77f1a9e ("prctl: PR_SET_MM -- introduce PR_SET_MM_MAP operation")
> > Cc: stable@vger.kernel.org
> > Cc: Cyrill Gorcunov <gorcunov@openvz.org>
> > Signed-off-by: Qi Tang <tpluszz77@gmail.com>
> > ---
> >  kernel/sys.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/kernel/sys.c b/kernel/sys.c
> > index c86eba9aa7e9..2b8c57f23a35 100644
> > --- a/kernel/sys.c
> > +++ b/kernel/sys.c
> > @@ -2071,6 +2071,9 @@ static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data
> >  		return put_user((unsigned int)sizeof(prctl_map),
> >  				(unsigned int __user *)addr);
> >
> > +	if (!checkpoint_restore_ns_capable(current_user_ns()))
> > +		return -EPERM;
> > +
> >  	if (data_size != sizeof(prctl_map))
> >  		return -EINVAL;
> >
> > --
> > 2.43.0
> >


