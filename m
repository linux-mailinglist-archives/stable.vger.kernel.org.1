Return-Path: <stable+bounces-249469-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEp7JU0DDGrETgUAu9opvQ
	(envelope-from <stable+bounces-249469-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 08:29:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6225781AF
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 08:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E7C26307D3F7
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 06:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB2F38A733;
	Tue, 19 May 2026 06:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="FgYoqae9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F88037B417
	for <stable@vger.kernel.org>; Tue, 19 May 2026 06:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779171567; cv=none; b=inzJPV8D+S2zhktRcLMT9Fa/c4p+mqDisQvDhDsa7QndCeV3TBx3cXkGTgwOVnQEvrHiixSwhwdcRxrhkuhLoLho8dXNVxNPNerwS5s31ExmaiIuGbQUZc/C7r4WHLvEP6ljo3vp+dsJFT2iM+yVqL0NQoGX9U+pEzzVP7mQJUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779171567; c=relaxed/simple;
	bh=vqb0FpFo19y3A274d+b4C+8E/9a+TiVcC5zMvUUwpfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHtptDokZVf0bdxWDerX5LSMhOA9wBFPVVejozsqsoYh2+VyvNo+ORENwnuVT/4687ydr3b81S/kvLUoPS2JwbS1xDIeITBAbP6FY+BjASTR/N7l9pX2KIOL78Fco7VCDluKIWbYm0G5dMZXC/UbPLz4XzY7qsf3CPyVM4R2FnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=FgYoqae9; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3697c35eab7so1601794a91.0
        for <stable@vger.kernel.org>; Mon, 18 May 2026 23:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1779171565; x=1779776365; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LLDd1nTNoi/a2u/UDZO1p6PnaILOwf1IfErETTfppzs=;
        b=FgYoqae9d0kYsxVeyeJCXvnRYKuz0CZrVeopGOLX/U0TWihRCBaMQ7DI+RGAAcfxZA
         XdqWioCnLk0xvdCW+u3NNXaqDye1d5MTCGPaCQSujOPnjSa3u3QUSd9j9T5WECkjdDIW
         //Fo6RVlOLJOiOZ5jAWJ9v0uq3vHwbDqqY+lXHrwbqdQuz23j3I3pCFrqo+mOdv/Ip1O
         1ZyUPDu0TJIIMOn8YbTHo0gC17m7ZF6nnA/Z1ehxIhEKuHKHwiKV6A1KQI2IbNSy85zR
         E9i16nAbOcUxUj1J8LyJa8gjOd1xlznbHinSl19DATSH8sjEKMNi9a5NxNkCW6palTbj
         wQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779171565; x=1779776365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LLDd1nTNoi/a2u/UDZO1p6PnaILOwf1IfErETTfppzs=;
        b=h4jqArMQfrG3gaMLmvzk3KpMwZMuH6l+r39m6clxkoYGFR5+nna5ImTjCWx2zNHaBK
         eB7xl7asPX0iK+GFTUDMZ/WwaIRsqVxFDgMzQQPfvIkMj19BwXGekQiZL+rrCUjWdEq3
         gZWSAX+y29rXccRF3lxJY37PVEgCHzzQzOjdR5R8kSIfegzTuGj7hM6djgz9Hgcecnag
         QgRQU0pmW+0JgSNyGYMnrkoxmSJ+dwXxwLGvSdjUkbt2MgFBAGWi9FQsOpuHK8Li157H
         lLEbsoVCxHn90sZ16apSLPe6kg0C05saPhDTcAcldpyQquAAoKV73XvwNGGxNp5u7Yik
         0QAg==
X-Forwarded-Encrypted: i=1; AFNElJ+HmzGuXK+qt73NF8E9YhTe6Ma9DyafPQzihsNeG7No6/iPdjDlwlA08nfU6Upg9cfujlxDmsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqdSvTVv6XEIBTrbi0M+rCRPYiRTgYd8ZM1ENe/q0axdyTcwjw
	elNpfy94a1NpunHErgVVkWJ3oA7SQsqUHYNuUC2eIJORxwXZDUDB49Nugw/Hyxc5j2c=
X-Gm-Gg: Acq92OEcluCi+qdas5CDKyBYjV1hU+TPLZ2KxVuiUUUKLPfYpNHaMuiIWTLWhF5Rb5u
	eD1iSJ+NKxR0xcev0On1uq/EOYYudwmxkFkEQ9oSVL+MTpEtMutQzaqYsJ4XPV2E/ciVcCtvciu
	E3LsrfibeqchO7wd/dEUidXlef3cYkGVQqosLs4gdRYBNKe0K9lsU0RzSsL/Ll+wxeZuVskab80
	S1M3k++kEyn5bcc4A9/v7iYXgkAfk0ZLhcjT+qiKErdb8lGrpY8qMQXCbwG8xKeHilgxXaw5Yto
	vCI84ah0rGqCrqqMQ5zOr7/fxufohQ1/Ka+PQNalpHNmoGSU40Y+fuCPOel09wwXDU9NI8v9729
	vKkXENTQlsJ2VdFZTRvtRyuy5rjJnCWVz7LAF4C2IZeuNicEu7Q+IWCXiq7bo8eiyX+Ae910nxQ
	qYpd0Vx66fiXrWpvpRi09F6qMhvqUiimwx0BFQPCmM+h6Q/A2su/j2D0CQTQEMzBVYSbgWtIZe+
	dYZd8oYduZ3ebERf7OGaFkYiAOThzabaAxBLLFUWmSYBA==
X-Received: by 2002:a17:90b:33c4:b0:35d:9c32:6219 with SMTP id 98e67ed59e1d1-369519e8faamr17627377a91.9.1779171565440;
        Mon, 18 May 2026 23:19:25 -0700 (PDT)
Received: from essd ([103.158.43.41])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695a09e95esm5167462a91.9.2026.05.18.23.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 23:19:25 -0700 (PDT)
Date: Tue, 19 May 2026 11:49:17 +0530
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: Jakub Kicinski <kuba@kernel.org>
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com, 
	johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	m.chetan.kumar@intel.com, stable@vger.kernel.org
Subject: Re: [PATCH net] net: wwan: iosm: fix potential memory leaks in
 ipc_imem_init()
Message-ID: <r6xteqo3uj3hiujtohra63pdkwx4uqqub4zovkkaywfuburhan@6xqqvahrep5g>
References: <20260508092141.82495-1-nihaal@cse.iitm.ac.in>
 <20260510170451.3886726-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510170451.3886726-1-kuba@kernel.org>
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[cse-iitm-ac-in.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[iitm.ac.in : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249469-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org,intel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nihaal@cse.iitm.ac.in,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[cse-iitm-ac-in.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cse-iitm-ac-in.20251104.gappssmtp.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DD6225781AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 10, 2026 at 10:04:51AM -0700, Jakub Kicinski wrote:
> > diff --git a/drivers/net/wwan/iosm/iosm_ipc_imem.c b/drivers/net/wwan/iosm/iosm_ipc_imem.c
> > index 1b7bc7d63a2e8..f4edb277efd92 100644
> > --- a/drivers/net/wwan/iosm/iosm_ipc_imem.c
> > +++ b/drivers/net/wwan/iosm/iosm_ipc_imem.c
> > @@ -1422,6 +1422,7 @@ struct iosm_imem *ipc_imem_init(struct iosm_pcie *pcie, unsigned int device_id,
> >  	hrtimer_cancel(&ipc_imem->fast_update_timer);
> >  	hrtimer_cancel(&ipc_imem->tdupdate_timer);
> >  	hrtimer_cancel(&ipc_imem->startup_timer);
> > +	ipc_protocol_deinit(ipc_imem->ipc_protocol);
> >  protocol_init_fail:
> >  	cancel_work_sync(&ipc_imem->run_state_worker);
> >  	ipc_task_deinit(ipc_imem->ipc_task);

> Calling ipc_protocol_deinit() here frees the ipc_protocol structure.
> Since ipc_task_deinit() has not yet been called to flush the queue and
> kill the tasklet, any pending tasklet may still execute.
> 
> Would it be safer to place the ipc_protocol_deinit() call after the
> tasklet and worker are fully destroyed?

Thanks for reviewing the patch. I agree that this change may introduce a
use after free since we are freeing the ipc_protocol while tasklets and
workers are running concurrently. I'll fix it and send a v2 patch.

The same UAF bug seems to exist in the ipc_imem_cleanup() function.
Will send a patch for that as well.

Regards,
Nihaal

