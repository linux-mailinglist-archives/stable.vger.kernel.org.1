Return-Path: <stable+bounces-233917-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCZjHJJg1mmDEwgAu9opvQ
	(envelope-from <stable+bounces-233917-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 16:05:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C848F3BD62D
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 16:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B80F30570DC
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 13:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C8C3D16F0;
	Wed,  8 Apr 2026 13:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="EmlW33VM"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427D02F3C3E;
	Wed,  8 Apr 2026 13:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775656653; cv=none; b=rIfveLTtA038W1ZZ0pHbpzsyUNheS5ug1Oc7wZP1MpS00J8tlkMMT02/V6MTCrG136PnYGKYtiiOQFx+U7KQM/0rPzpTO0Yyv67fdLIFSSkZvaUz3dd7HPVAkOFukY9JYljJ2Poi8NE1nHmPholEyURJDxjXImlEUGLl5zfZyjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775656653; c=relaxed/simple;
	bh=iVzYktDqQoVsac4V0l0TREA1TCgxcBM7qkRKmohyM/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EjWw1ouJxMP/zD6kuXNBGI9/MEcOq0q3oti9N7oDHuatbOnRjMUGOcua3BJN7jp0Qeb4uPrtzGZVWfm/+NyLzjKesXa1iuId0pOsmcS+NmFI7ZuSAcmzvbYaRTweBNbgOBlpth5NY9OJKoLHELy7BQMaF3aIGttOkS7FfYUa9Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=EmlW33VM; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.28])
	by mail.ispras.ru (Postfix) with ESMTPSA id 6458F45F7982;
	Wed,  8 Apr 2026 13:57:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 6458F45F7982
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1775656641;
	bh=qJ14xyneL5A9/L/KrHb5BAjljVMrFlgO0kngOi7YGhg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EmlW33VMXV1fxuMduQyfKd1YopPc90ric6gVZtN8/MtzyTmT7hA/12yHEKyW1oLlX
	 Rm/fW5KNwOotqi06xyokYUUgPvmrbux3uR0Fn4rPVOyeT5DnOezrLCrc+00EeTI9JC
	 m+75ccAjcoRNXJFQoVV4IwxZmYPhn0I4pBdPPMTE=
Date: Wed, 8 Apr 2026 16:57:21 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, "Heyne, Maximilian" <mheyne@amazon.de>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvme-apple: drop invalid put of admin queue reference
 count
Message-ID: <20260408165531-2a55fd1a87a2369d9a5bea2b-pchelkin@ispras>
References: <20260403202701.991276-1-pchelkin@ispras.ru>
 <8143e057-4c3b-4365-8780-003e897b9baf@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8143e057-4c3b-4365-8780-003e897b9baf@kernel.dk>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ispras.ru,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ispras.ru:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-233917-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pchelkin@ispras.ru,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[ispras.ru:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ispras.ru:dkim]
X-Rspamd-Queue-Id: C848F3BD62D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 06. Apr 20:20, Jens Axboe wrote:
> On 4/3/26 2:27 PM, Fedor Pchelkin wrote:
> > @@ -1269,8 +1269,6 @@ static void apple_nvme_free_ctrl(struct nvme_ctrl *ctrl)
> >  {
> >  	struct apple_nvme *anv = ctrl_to_apple_nvme(ctrl);
> >  
> > -	if (anv->ctrl.admin_q)
> > -		blk_put_queue(anv->ctrl.admin_q);
> >  	put_device(anv->dev);
> >  }
> 
> Could this just be:
> 
> static void apple_nvme_free_ctrl(struct nvme_ctrl *ctrl)
> {
> 	put_device(ctrl->dev);
> }
> 
> at this point?

Right, ctrl->dev and anv->dev point to the same device.  I'll simplify in v2.

