Return-Path: <stable+bounces-222507-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mH57Nq8IpWl/zwUAu9opvQ
	(envelope-from <stable+bounces-222507-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 04:49:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB661D2BF3
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 04:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41DFC301BC3D
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 03:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEE72D8391;
	Mon,  2 Mar 2026 03:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DwSrB/qc"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E62A430BB9
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 03:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772423323; cv=none; b=RxhBsfv58Grny9nvyn7+7ye1uf36JltNS9sEXRwVRM0gaJVvqPiAPscfPp35ixiF15bAfI8secxzAlf+SZMJTuIUfDzhMEB/+dVJG9RBE+LOSdv0DhiYAUxuseaROMgJ5MZGY8Zu135mVzC/sFVlzSCSr9XOoz96C8opzsXdNB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772423323; c=relaxed/simple;
	bh=8iMACVROmZEB8RJb7ycf960mZtilOKIs3wbKE6dJ8n8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBHKRaHAOjwwSbon+98ARy4AcjRRoDnDVGQprpa6QAHDJkwAWSvWjdz70QeRM1ecfu4Dl1ko3bxoAj0xpg8quCBZv3iFCXDyO50DEVrEC8qd2DqjVDVYEzj+RC8bekRzJ/3Nys2fJ9POIOTi3K2BNMijV2YsJM7hs2r+WG1uATk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DwSrB/qc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772423320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l1acEAhrt48XvZXt+QxSXebqR9U3MKRpe1lxlgPtU6k=;
	b=DwSrB/qcfJ1vrlzyp4rAepw6r85IIAQ00d9Xpk5MMSAtG80FuG6CM7mkA7g7Csp4qzggsb
	trAfUMQELOEChv5alTpnOGxNUisr2prb4S5k9Tng+bvsFuzFGD+h/LYQ264SJ92PVxvcy5
	uQtRve0QgE62vUr46QXSkTqV/Hc4HnE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-rKfCszv4PaimexNIMnoYYQ-1; Sun,
 01 Mar 2026 22:48:31 -0500
X-MC-Unique: rKfCszv4PaimexNIMnoYYQ-1
X-Mimecast-MFC-AGG-ID: rKfCszv4PaimexNIMnoYYQ_1772423310
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 89BCF18002C2;
	Mon,  2 Mar 2026 03:48:29 +0000 (UTC)
Received: from localhost (unknown [10.72.112.98])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E09C81800669;
	Mon,  2 Mar 2026 03:48:27 +0000 (UTC)
Date: Mon, 2 Mar 2026 11:48:22 +0800
From: Baoquan He <bhe@redhat.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	Coiby Xu <coxu@redhat.com>, stable@vger.kernel.org,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crash_dump: Don't log dm-crypt key bytes in
 read_key_from_user_keying
Message-ID: <aaUIhtN0oUkP5ALi@MiWiFi-R3L-srv>
References: <20260227230008.858641-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227230008.858641-2-thorsten.blum@linux.dev>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222507-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhe@redhat.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: 3DB661D2BF3
X-Rspamd-Action: no action

On 02/28/26 at 12:00am, Thorsten Blum wrote:
> When debug logging is enabled, read_key_from_user_keying() logs the
> first 8 bytes of the key payload and partially exposes the dm-crypt key.
> Stop logging any key bytes.
> 
> Fixes: 479e58549b0f ("crash_dump: store dm crypt keys in kdump reserved memory")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  kernel/crash_dump_dm_crypt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
> index 27a144920562..5ce958d069dd 100644
> --- a/kernel/crash_dump_dm_crypt.c
> +++ b/kernel/crash_dump_dm_crypt.c
> @@ -168,8 +168,8 @@ static int read_key_from_user_keying(struct dm_crypt_key *dm_key)
>  
>  	memcpy(dm_key->data, ukp->data, ukp->datalen);
>  	dm_key->key_size = ukp->datalen;
> -	kexec_dprintk("Get dm crypt key (size=%u) %s: %8ph\n", dm_key->key_size,
> -		      dm_key->key_desc, dm_key->data);
> +	kexec_dprintk("Get dm crypt key (size=%u) %s\n", dm_key->key_size,

Make sense to me.

The kexec_dprintk() is only for debug printing. We can remove above line
or change it to pr_debug() if security is worried.

Coiby, what do you think?

Thanks
Baoquan


