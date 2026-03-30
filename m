Return-Path: <stable+bounces-230988-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iL0XLzvcyWlm3AUAu9opvQ
	(envelope-from <stable+bounces-230988-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 04:13:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 247D0354B78
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 04:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EC52300A385
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 02:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AECA344023;
	Mon, 30 Mar 2026 02:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OhZQ9ACq"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21207344DB5
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 02:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774836790; cv=none; b=tkSEffkomG+VI9DNvM5Eysc/s8mtf2vrmaWMn07xfm1Jf4CHyeK8EuGrmGaC3gqyI2AVM6jObkTW1GgsnjUGtq11VGFZK2rq8W5A6NfDrqcatQKJHKo8XuJ/0VlKXFkSe8vAkvf749irhWh9zY17e0cH/2S9yj4uxk2W7++C5QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774836790; c=relaxed/simple;
	bh=vrzSyHaslq3MSiXPuC7FSAAC4qvh97I27PRanA5teso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWs3ZeIYjp7/XJbObAe8qE6/p77QmLeqMmNdIa9gTWq8WR9BhtobgyE+9+MUCVqarTDza/Qhie/dQca7miOEBaVoHI5HkibWExi/u/Co+kYi/E/+Ds/x0vzrXnsQLEhDvzHh8Jk511JlsfIRrvNNo4yoLpgbOrvvDhZ7l94SpjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OhZQ9ACq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774836786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GYl0Gfx1l/S4PpzJS9mjyQT83t+lS+RXkxvjtJf7FQE=;
	b=OhZQ9ACqliH7wvA2TLQCcgJRQ0MfKA2SnpyMFuJJasZwishAoT8P2gqYRwM5YnHoTs5Ufb
	pZGPF9vXphcyWFb8H+VdnzarfThC+oC5pyRDU/TgAjFXQy7aCnfSXrQRqb+v+OVLaHuPDe
	0VqfhXj9ZDHPSEaNLA5Kq4nwznK5EUM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-194-y-rX6CFkOo-dZBIN4EfKeg-1; Sun,
 29 Mar 2026 22:13:03 -0400
X-MC-Unique: y-rX6CFkOo-dZBIN4EfKeg-1
X-Mimecast-MFC-AGG-ID: y-rX6CFkOo-dZBIN4EfKeg_1774836782
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 72F57195608D;
	Mon, 30 Mar 2026 02:13:01 +0000 (UTC)
Received: from fedora (unknown [10.72.116.5])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED88019560AB;
	Mon, 30 Mar 2026 02:12:56 +0000 (UTC)
Date: Mon, 30 Mar 2026 10:12:51 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yang Xiuwei <yangxiuwei@kylinos.cn>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
	John Garry <john.g.garry@oracle.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3] scsi: sd: fix missing put_disk() when
 device_add(&disk_dev) fails
Message-ID: <acncI-IZhtdDsmJg@fedora>
References: <20260330014952.152776-1-yangxiuwei@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330014952.152776-1-yangxiuwei@kylinos.cn>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230988-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ming.lei@redhat.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 247D0354B78
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 09:49:52AM +0800, Yang Xiuwei wrote:
> If device_add(&sdkp->disk_dev) fails, put_device() runs
> scsi_disk_release(), which frees the scsi_disk but leaves the gendisk
> referenced. The device_add_disk() error path in sd_probe() calls
> put_disk(gd); call put_disk(gd) here to mirror that cleanup.
> 
> Fixes: 265dfe8ebbab ("scsi: sd: Free scsi_disk device via put_device()")
> Cc: stable@vger.kernel.org
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> Signed-off-by: Yang Xiuwei <yangxiuwei@kylinos.cn>
> ---
> v2: Add Fixes: and Cc: stable; add a short note on how the issue was found.
> v3: Commit message and subject refined per review; add Reviewed-by from John Garry.
> 
>  drivers/scsi/sd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index 628a1d0a74ba..aba22060fcd5 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -4018,6 +4018,7 @@ static int sd_probe(struct scsi_device *sdp)
>  	error = device_add(&sdkp->disk_dev);
>  	if (error) {
>  		put_device(&sdkp->disk_dev);
> +		put_disk(gd);
>  		goto out;
>  	}

Another fix is to clear `sdkp` and `goto out_put`:

- clearing `sdkp` because the device is released already, and this way is `memory safe`
- `goto out_put` can release disk centrally



Thanks,
Ming


