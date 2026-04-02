Return-Path: <stable+bounces-233053-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMCrAImVzmkBowYAu9opvQ
	(envelope-from <stable+bounces-233053-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 18:12:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DEC38BAE6
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 18:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B494630E2BCD
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 16:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65973EE1EC;
	Thu,  2 Apr 2026 16:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwTWDqNx"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA813E559F
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 16:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775145978; cv=none; b=mQLcFw/bVTuqe92K53dj+2Uy4DWLWc+e6/ZYi8Vcdlmug6+B4Oltu/noGxoWWb/LnCc5DH3TXeK7yFV9jiVEfl3rpyblPaiCEz4owgLKs/SlCzqFam75VMOsqaImpGDpczyEbK4mzaKxCte+KtnKH9DuND3VaUCdlXSanJ6YAeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775145978; c=relaxed/simple;
	bh=UZUVC6of47sxtIlDlKdvNLnlU4knJofbvJfx4ejzZW4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQo++JOAaofKasv9zGtU4XYH28+H8Aj/SomBzsOlxjlzwFDlSt+XEivTZGP/S8g5qid6iKoTRqRrCB78BywzBTZ2BgJGoI3/ZvTcD9Wd9azt7rG+FNaL/TtTGvIanKQanwPHw8oj23az4CgOufOaSitDrivdDAXUH6WKoaY/S1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwTWDqNx; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-38ad26e3992so9735331fa.1
        for <stable@vger.kernel.org>; Thu, 02 Apr 2026 09:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775145975; x=1775750775; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ax0ee0zXk96CqJlbPgmPN6rovtTH40aoKmXSHJn/bVQ=;
        b=gwTWDqNxvKNz4XQiqGt0pXpbcctSJAv+TRqdZmCQBjBcSgluJRbKqP1t0EqO7Iaw9S
         XK8K2v6KOUH/mYyKn4780Qzo6iTotVJD6PL6t7WCvHRuUJMKbf3ne5ITfuYaPZOZbIFb
         ArsaEO/cUUHVxH8ZLu/EGJTGIiVOoed+N9jBYopvHM+ga6A/geEYvdutBXoVIMKtgZPF
         03EGJNMypPK8ditKr+6MEVDGZh/XR0Z4/wNDNrd0H/izbD8Tez9pQRnB5CLCXnk36ecn
         kV2nXrExPi0akMFUoCYZe18cu5iRhoLV/GGIRXV0FH/UsX2hTNG/TRmeBMTsuA2XR6pC
         R6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775145975; x=1775750775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ax0ee0zXk96CqJlbPgmPN6rovtTH40aoKmXSHJn/bVQ=;
        b=rI49+PgSMMUCJHlgCaySF860+tdkFTVoBAlxo0oFBlZIkQ+M+7g0jZND7Gz48zdm1X
         6tR0d425R3kF5PTylSjLyU4FVIHmS+A/7KGOgEXlSQTmhDPOzm1MNFJwZXF1MMO0j+V8
         rhVg2jbS8iPDGlSbWFJunaR/A9D76KA09dnuxJr82YRq7gM0U1xTUu18AXZqndg2lSFB
         AD0+A0NKO2xGywuSTqW3b7qoBmLejYF5Hc3sMD1yVMqWhHse0nCO/bAwZOi6uPEEYdPZ
         PiVDjk1DI4ujRhKDLKsNEcye0jYF3PsWgNQSrjwRbA+Tjtx5wfz5kxEMzxstRjWxnAbT
         CiIA==
X-Forwarded-Encrypted: i=1; AJvYcCXWg9aNzoCcYfri2i6+jLyJGdDo8OmY0jIynWaV++M1le5tVHw24w4VTlad9JEORWu6eOw5ZZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbALfukUsTtmsgxBzdW+oB035WxWOzIf4lFEMshkcTId6/uhpl
	iFp/XO8CEkFTlDg6kOMZJoNV10tp/x8ICTiWl57/yVm0bnGuazNtH7bu
X-Gm-Gg: ATEYQzymdq0xSgMuLU6GypnuOHlCv7ARwevwi/IR5LVH5k63t5qSeKmYYylcsPVWhOn
	Mcq8ZW3dm6vTvovt1g51lpx0tRMYwz1lRXJghxJDmLz9aNF3bJ/uqF9iiCV9n6UGdaAaq0/TWW+
	MSLLSckEOwEOK8wyqHUA1eEMmjM7/NotKlRgeNABBhPF0sOMWu2VN1S7Q88bdaQFNFvcY132mlx
	qp5HS2bjKIfqmw+kEfBLYUjHWu0XBnqzocM87Ag/2UfwLW23E4zFzq44rPNAzQi8vaizqaEVfE3
	+gC13NVvE9M9GbfEKu/qMVrPaTKrNU8nhFS/s+paSWvfjUVd/3FzDbEQk2POkio7ZRURVyS2iGz
	Hg7QH+Dn04JjAaMbDLyvVtyUGiWvNhZDDApR0AwSQuhjiQagIkeYSvWsGgG5xJwI4
X-Received: by 2002:a05:651c:324b:b0:37c:d689:7e1c with SMTP id 38308e7fff4ca-38cc3072eeamr33114671fa.23.1775145975273;
        Thu, 02 Apr 2026 09:06:15 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38cd217ba60sm6326461fa.38.2026.04.02.09.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 09:06:14 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Thu, 2 Apr 2026 18:06:13 +0200
To: Baoquan He <bhe@redhat.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
	lirongqing <lirongqing@baidu.com>
Subject: Re: [PATCH v3] mm/vmalloc: Use dedicated unbound workqueues for vmap
 drain
Message-ID: <ac6T9YJCA2xUbHsv@milan>
References: <20260331202352.879718-1-urezki@gmail.com>
 <ac227uLhjH8pETb5@fedora>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac227uLhjH8pETb5@fedora>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kvack.org,linux-foundation.org,vger.kernel.org,baidu.com];
	TAGGED_FROM(0.00)[bounces-233053-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[urezki@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 99DEC38BAE6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 08:23:10AM +0800, Baoquan He wrote:
> On 03/31/26 at 10:23pm, Uladzislau Rezki (Sony) wrote:
> > drain_vmap_area_work() function can take >10ms to complete
> > when there are many accumulated vmap areas in a system with
> > high CPU count, causing workqueue watchdog warnings when run
> > via schedule_work():
> > 
> >   workqueue: drain_vmap_area_work hogged CPU for >10000us
> > 
> > Move the top-level drain work to a dedicated WQ_UNBOUND
> > workqueue so the scheduler can run this background work
> > on any available CPU, improving responsiveness. Use the
> > WQ_MEM_RECLAIM to ensure forward progress under memory
> > pressure.
> > 
> > Move purge helpers to separate WQ_UNBOUND | WQ_MEM_RECLAIM
> > workqueue. This allows drain_vmap_work to wait for helpers
> > completion without creating dependency on the same rescuer
> > thread and avoid a potential parent/child deadlock.
> > 
> > Simplify purge helper scheduling by removing cpumask-based
> > iteration to iterating directly over vmap nodes checking
> > work_queued state.
> > 
> > Cc: stable@vger.kernel.org
> > Cc: lirongqing <lirongqing@baidu.com>
> > Fixes: 72210662c5a2 ("mm: vmalloc: offload free_vmap_area_lock lock")
> > Link: https://lore.kernel.org/all/20260319074307.2325-1-lirongqing@baidu.com/
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  mm/vmalloc.c | 79 ++++++++++++++++++++++++++++++++++------------------
> >  1 file changed, 52 insertions(+), 27 deletions(-)
> 
> LGTM,
> 
> Reviewed-by: Baoquan He <bhe@redhat.com>
> 
Thanks!

--
Uladzislau Rezki

