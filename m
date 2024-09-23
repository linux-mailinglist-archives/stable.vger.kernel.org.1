Return-Path: <stable+bounces-76912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7886A97EE60
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 17:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 141B728262D
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 15:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B90C197A8A;
	Mon, 23 Sep 2024 15:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LLD8bCkJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E293126C01
	for <stable@vger.kernel.org>; Mon, 23 Sep 2024 15:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727106139; cv=none; b=rHoCPnFV2coLtIFoopOq9x/SfgihkKZZGsR9hZ6H3iPdiR/nQosYgqsS/1Z8GuSq2YueRXdJaigwj1PEtt2W2DBtIwOOvFVdU2nJqLW9nvEqTTvjhpY7IJVCeiOadn/KpeMUeBCzVzszR8WlotlVnccF1soqdraGRxhHJWdKntg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727106139; c=relaxed/simple;
	bh=3Q5rxwHj3JGxVIbkrTDsygr7k3PWWTVyU46YCgH2IqI=;
	h=Date:From:To:Cc:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tENVBDN+S9WabNkACxzRbl8uMSWSap2U2Jamze8u6toWofleKQ1ytjslxqyaM+7OHYCx5WtKAdz6/DJ7ETwq/g3K9qBkpQGLniWh5x7osq0So1f99ZJgcMq0Ug3UOQ5lm5sSPtt8eF11z9QgRdg4B8EtwVNaiqSaps798Eff7ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LLD8bCkJ; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3e039889ca0so2495240b6e.3
        for <stable@vger.kernel.org>; Mon, 23 Sep 2024 08:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727106137; x=1727710937; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H4psRH9uvTvZ+EcppbtddhdemTURw3wm4/GpZ5POPFI=;
        b=LLD8bCkJOvqGj9e4bMiyRufcefLoRwR2QV4ScCqvboHFKIrlsITBln7+VQ3WcDsQnz
         mzXxb3SJKZqYYpQ3I5Yk72WjoFzu08K0Mr9QAGRyKa2stTASES7yxA188jBLNsse413D
         3oVibPmYUY36iOpKlHny1PHmRq/DoqQy5bb6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727106137; x=1727710937;
        h=content-disposition:mime-version:message-id:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H4psRH9uvTvZ+EcppbtddhdemTURw3wm4/GpZ5POPFI=;
        b=o3dxkh61sJX7KAuuVPyoB2tHyQEfaWA20rtAdYSEwfjpx4mF4RtttkKESXo75ZeP6i
         AN7TX4RSdOamdF874rs2STQp4YhQb05/htNShEGD621LE8D5G7UefUJBdWcZSTFDD9VG
         egz5j8NMsRCimwlgv4aV9ak+F/+JalZ2s8wawSTRz+dEIuQRr1c48MSsjIUX0z0ELLKR
         uOqHohZE/ba2fnDY/tpO4BILAuxIuMsh/c2CnjpSpguO+qXBZVaIWHJ+Sz9FIbsl6hLK
         vUdWcQ937odMjo1CWHJezAOQdO05qslpv+Y121RRcd+do+RXYs1el5rAOUsCo1pCjiuW
         2i9Q==
X-Forwarded-Encrypted: i=1; AJvYcCX3s5nMlknHsMfftIZ6CkVf5gN1RRQtWxgvw7qCJ5O5liiau5d110czn/6PSDEPgx0iBHm8rQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4aK+vRHz1UDesjMI3a6iFJPQFU6N/5ZVzGNfFafOhQzdzzM2F
	u2squ6h2m2A4yMdlU/+HNQIsuwQzYXLQCGTqS0G+4R6WjcOnpvvvlSoht4HDhw==
X-Google-Smtp-Source: AGHT+IGLrt1SdhW3xWs5HczP5HQsxOV2tK1fkasmItJ6/En3/5xyUcP+o7dkEkQDL7Hn6T6uDllS4w==
X-Received: by 2002:a05:6870:344b:b0:277:e868:334f with SMTP id 586e51a60fabf-2803a7b8503mr9722097fac.34.1727106137629;
        Mon, 23 Sep 2024 08:42:17 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:fd63:e1cf:ea96:b4b0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db498fb730sm15502664a12.28.2024.09.23.08.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 08:42:17 -0700 (PDT)
Date: Tue, 24 Sep 2024 00:42:12 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Cc: Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	stable@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Message-ID: <20240923154212.GD38742@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Bcc: 
Subject: Re: [PATCH] zram: don't free statically defined names
Reply-To: 
In-Reply-To: <20240923153449.GC38742@google.com>

Cc-ing Venkat Rao Bagalkote

On (24/09/24 00:34), Sergey Senozhatsky wrote:
> >  	for (prio = ZRAM_SECONDARY_COMP; prio < ZRAM_MAX_COMPS; prio++) {
> > -		kfree(zram->comp_algs[prio]);
> > +		/* Do not free statically defined compression algorithms */
> 
> We probably don't really need this comment.
> 
> > +		if (zram->comp_algs[prio] != default_compressor)
> > +			kfree(zram->comp_algs[prio]);
> >  		zram->comp_algs[prio] = NULL;
> >  	}
> 
> OK, so... I wonder how do you get a `default_compressor` on a
> non-ZRAM_PRIMARY_COMP prio.  May I ask what's your reproducer?
> 
> I didn't expect `default_compressor` on ZRAM_SECONDARY_COMP
> and below.  As far as I can tell, we only do this:
> 
> 	comp_algorithm_set(zram, ZRAM_PRIMARY_COMP, default_compressor);
> 
> in zram_reset_device() and zram_add().  So, how does it end up in
> ZRAM_SECONDARY_COMP...

Ugh, I know what's happening.  You don't have CONFIG_ZRAM_MULTI_COMP
so that ZRAM_PRIMARY_COMP and ZRAM_SECONDARY_COMP are the same thing.
Yeah, that all makes sense now, I haven't thought about it.

Can you please send v2 (with the feedback resolved).

