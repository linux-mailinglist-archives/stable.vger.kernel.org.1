Return-Path: <stable+bounces-254478-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMKTC6F3Fmr3mgcAu9opvQ
	(envelope-from <stable+bounces-254478-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 06:48:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8C05DF38C
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 06:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0BD43019F32
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 04:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E232F12C5;
	Wed, 27 May 2026 04:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgRG8o/1"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B891325F984
	for <stable@vger.kernel.org>; Wed, 27 May 2026 04:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779857301; cv=none; b=dZOeV3wEGVAn6000L2xHjWaVyi378RnrVCJoh0ZUwHJjqxKB8ArqzqF+u2vABX/HbjiYO05ylv7JQrEJmIDo2Qdt4Zy/G/Iv79v9NqZOwvIsdu11AVcOszCfInWhfhXjtuk4HBRHitnqUZBHZ0l44Jpvwv8i2VSTuCpn3HQ+pZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779857301; c=relaxed/simple;
	bh=LwvBMnJ1UpPWgCimFzDiGtFXtkX4zeCEdu5501y+XsE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=i1FHK81MCoH/uo5OG5gN+mgOsrftf0y+kKxLGnnb+9Krv8Y89WNt56YLikSZTzB2R6KlS3w3zd2lrlzR4hGZEFioxn+MOKqxbiwnVoCZWR4RIADFdvhl96rt6am2Qrj1jzVJgFV20S49Zd/zpnGTC81XepVKals2mF1fkgn3cFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgRG8o/1; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3697c35eab7so6866350a91.0
        for <stable@vger.kernel.org>; Tue, 26 May 2026 21:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779857300; x=1780462100; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :mail-followup-to:references:in-reply-to:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Chd1jutX+G+jhl5nJg9KkScymzrTc5Tq+2T6gtcZuEI=;
        b=UgRG8o/1zkcMRIDzPN8GMuLLojIFisr5kfmbaDWegvI3TI5VOR2Aypo3CDHJE/yaSU
         vp/0PHuelk7JUFhdqh+FTIZozl5sBb2aDdN1BjufCR2FbcEu4qYGU1xERKcO+QKe/yLd
         BkGptGHsKnf3v24bW212gzj1c07WFYnli96X9RMttzqE9QZ/V0rMbfC7kpQ5I2nqvioX
         1aC3dbg/vc/vkeoop5mZngiilvUhMK4LAzkLvlevyctsQKotcjix+tIkP33AA0rDqOGJ
         XgBksdzjKpWPJsdR7nWwL+EaLngxt5rpBwdvvj8ql2msjhQrRRjA/68ACCOfOan16ZrQ
         sGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779857300; x=1780462100;
        h=content-transfer-encoding:content-disposition:mime-version
         :mail-followup-to:references:in-reply-to:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Chd1jutX+G+jhl5nJg9KkScymzrTc5Tq+2T6gtcZuEI=;
        b=bAxEZfp9ElOhgWxx6IewbqORSx2U6Pryu36Tfn00qQgLOqnTAUSG9707Z5gb29nLXh
         B8TdLsDAXtW0Ku0GHTK0DycVoD0zgzmRgH5gFyq8NoCRfLqMckgalFtAP5YxIBOF+7wl
         qEYzman4E1qKTCFzdslmDcOpWyL1jY9gz2b9Kk2TkhfBc8QrUvAddPBLLVhTilIa8Oa2
         Xny4qcdvNT+qvzVHKPmDHWMXlEoJCJOAAdLfVghExoVb4lY+deXseNngWRXkNFCcgjSs
         6MbVWuGLuzsBSNB/1rPXxehQrsTbDV3/bKBycai0VhN8W7Oz2BYhO784Z4wVvWrUyqwv
         O4YQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ymgaJfqc+OMqdtjbd4T2AA1EP+wVH+kJiqT51vtqupFyW2ACNWCNBci4CpECcO9Uicz16kMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQPlQGvQO5zkNbWFteQINR+g4UoRmezw/5sSOqXktHzb7GLxnn
	yuSRUrQkgddvpuuvgpaY6YlH3aqvYmNAw5lmy0/qRImt3+O6cLqdqtRS
X-Gm-Gg: Acq92OHqNIQCyYDPZtXliJwNLvmhGFeQX51KcF/+yRyXChyGMsNcy4Oag7ITsVxxj+y
	WlvmC5vOt5eSYnjJRF/Q40J/yUlrUbktfYLbkzZQd8W+tFUt7OnhNx9NFxJSnLwOS8uTlw3jINv
	BJKISl10fQI06OYNPXrKOCIO56SuQTWq23fGu6JCmuuLJVErV98vhknU7eX96ihDsRBq/cewPmG
	icjQAPlPqhqEvkhOIKk/soZDwUXKjdxBnroSN18Z1rlqvgnowkXNTPvg9AbTsdookXzbRH4gjAi
	Gcc6SZjiiZ1+0DrPya0+WKtH25I943FO9WMFzPEiF+FAekzDYndAa+pbK79l4ZHNSE0g1KKhMzO
	mcsoWd7ladpcUL89YuUqo1Ur2q5MtRm1SBx3rjncz6jbFRUtsO2Y/ORaAY5g9hdHFTtwj3et08B
	wmRW6QM7KJ94BkxqZ4RhKw+Cp8/hbgfiS0DNRT
X-Received: by 2002:a17:90b:3bcc:b0:366:3517:1a95 with SMTP id 98e67ed59e1d1-36a6746f232mr19970443a91.0.1779857299926;
        Tue, 26 May 2026 21:48:19 -0700 (PDT)
Received: from localhost.localdomain ([116.80.91.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36b2690534csm879124a91.11.2026.05.26.21.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 21:48:19 -0700 (PDT)
From: Cunlong Li <shenxiaogll@gmail.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	stable@vger.kernel.org
Subject: Re: [PATCH] zram: fix use-after-free in zram_bvec_write_partial()
Date: Wed, 27 May 2026 12:48:14 +0800
Message-Id: <ahZ3jSIGz4urice3@debian>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <ahZov_99kMxaTH2P@google.com>
References: <20260527-zram-v1-1-ce1acb2bfaf9@gmail.com> <ahZov_99kMxaTH2P@google.com>
Mail-Followup-To: Cunlong Li <shenxiaogll@gmail.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>, stable@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254478-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shenxiaogll@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BA8C05DF38C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 12:45:37PM +0900, Sergey Senozhatsky wrote:
> On (26/05/27 11:26), Cunlong Li wrote:
> > zram_read_page() picks the sync or async backing device read path
> > based on whether the parent bio is NULL.  zram_bvec_write_partial()
> > passes its parent bio down, so for ZRAM_WB slots the read is
> > dispatched asynchronously and zram_read_page() returns 0 while the
> > bio is still in flight.  The caller then runs memcpy_from_bvec(),
> > zram_write_page() and __free_page() on the buffer, leaving the
> > async read to write into a freed page.
> > 
> > zram_bvec_read_partial() was switched to NULL in commit 4e3c87b9421d
> > ("zram: fix synchronous reads") for the same reason; the
> > write_partial counterpart was missed.
> > 
> > Fixes: 4e3c87b9421d ("zram: fix synchronous reads")
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Cunlong Li <shenxiaogll@gmail.com>
> > ---
> >  drivers/block/zram/zram_drv.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> > index aebc710f0d6a..b23a8bbb687c 100644
> > --- a/drivers/block/zram/zram_drv.c
> > +++ b/drivers/block/zram/zram_drv.c
> > @@ -2333,7 +2333,7 @@ static int zram_bvec_write_partial(struct zram *zram, struct bio_vec *bvec,
> >  	if (!page)
> >  		return -ENOMEM;
> >  
> > -	ret = zram_read_page(zram, page, index, bio);
> > +	ret = zram_read_page(zram, page, index, NULL);
> 
> Sounds like zram_bvec_write_partial() doesn't need bio parameter then?

Right -- v2 follows up with a cleanup patch that drops the bio
parameter from both zram_bvec_write_partial() and zram_bvec_write().

Will send v2 shortly.

Thanks,
Cunlong

