Return-Path: <stable+bounces-253886-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id LY6IC5k1EWpeiwYAu9opvQ
	(envelope-from <stable+bounces-253886-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 07:05:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9105BD29A
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 07:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE9FF3018BC9
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 05:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1105D2D73A1;
	Sat, 23 May 2026 05:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wj4xku4B"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2447213E89
	for <stable@vger.kernel.org>; Sat, 23 May 2026 05:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779512721; cv=none; b=H8FlQgWPmaYNHJfIeOrvQYzh2LD/DMH9qDXL6gpXNyT0votXSlr08Wyn21raBym4YiyLYYBRmq+mhVH5Rm0A80CmrDor/hW5VwbvkTrTbHWqrOaEAmNqCYg/x25i0vLrY6/lobdpnSQILZXmliJ6KuxCgeYR7xeARZWfh3/pm2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779512721; c=relaxed/simple;
	bh=VzI9czm4MrErn/NZb7FoMdZyZZAmawQ07dwthEnYF78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICj1K/qIeyJzK0xA4KfDE0MnqH35lPdWOqjv1bAJFvK4i1Mm30+smQ7RSGYJf+5BuAyiHvgNB25y6hkMttbGjZE5+bm2crNfwgd7EhPfBprmZgSegWbHu7FqLD2GWNvYSDCWRN/TnYaC28OoHMIoYed5IJLeuRT1Q5QcspWUigc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wj4xku4B; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2f03d6cf77bso8299781eec.0
        for <stable@vger.kernel.org>; Fri, 22 May 2026 22:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779512720; x=1780117520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xYCgRM5mzTQ+ytP9QP2RFZeZNSFcBE/P+Xj1TqGJhWM=;
        b=Wj4xku4BzVgvC83+zSmnkVKVEzkMDhXD7KwisQSqRotpqQY9n8W7ydpRQjV3Bf7Pn1
         pIXwk2LLFenctnIPJC2qR+Jhc8/vJa7uzQlUpcfFEZw6wZnHb1pUmZvOAlEWRJdliONk
         3p3aA8TF5t1uKO1bjKLfod1kSWMOq+yhwaB+H4InpmHD5Ejyivq+bqvS5tQuJl2aKMpj
         Swa7tbjFrFsyyh3pzXr4Zf7g7NuyKMci5mzIk79ZKKACuQ8lkkGlxtE7I1a3mCN12L9q
         kEgiSJjDYp5/wBaumYk4EOjoG1d1YjTxreoHm+Goqs1A7mhf5275tmEzKFKo0mmP8noY
         mQyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779512720; x=1780117520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xYCgRM5mzTQ+ytP9QP2RFZeZNSFcBE/P+Xj1TqGJhWM=;
        b=jD8S3RcOpyqYewRW0plTm1Bbm/wH3DSkaBoaqvB6/Bwa7P1cD3keB/JPXSZUpV/II+
         fZ5Uz6FVEWIfxGXd9p+Of/C4sxZQ/QUEiwSUmrU5y68Y3em/peyvA4S2N7waaPSoFxtt
         nAZveyQbInT7l2G27IeB7kTUHuODbmQIcDXrazIICyTtP645fcibpX4hBfSycIFy3aWa
         Lh295v+Tz7GN8DPWRdslLkkBAp6bXgseSDE21nxB2eyKZUrhIMt3n5Ke0PCi/7bQ4JfQ
         sZNrFCL3D4pUrEQOMibhLpMYsU8enm3BPwDdFeiFd1h9sQIf4rMe0MVhYiXfcOtwS774
         VB4Q==
X-Gm-Message-State: AOJu0Ywj7wK3Zxu7Oj9mpTN+eeDUqr5fAaBx/MaklZxVfE3qDcII5nON
	FMcX//72gkjaKxS9kiuS092DTegN7AMPrHoZHEwkpUU/u8o0Shi48vS1
X-Gm-Gg: Acq92OE7ru7WChHsoDwatWHi1JFHIrgO77sQKAYom6RST1wyeMMY1a9bmVKvxR4Q1Dv
	38wEuPOb1kej8/zSgV1z55Pl7xakfCrbwljVb8dQ/mKvNCcZUWxUg5rqyz1A5zHupDHyRCx70s7
	2D9IA+/9DOJrffjeuHLGgXsVRf21m39wQAV0c67b4+8GBICIh6SIgqOYsTcCpsMVieXUCkZLwGK
	vpLYR9lWgQlG3zC10fAlcwpL8PcDZf6eoJkX71SbJ8gdJWULQlcheESrj6K/NdsaLlyZjdv7oWV
	7Ph5Rtgu8bjLQFFy2VYAIC4SELyjseh/gzgaJp0Xrdaop/KqStzC9IBAvZIxD/ecavRZM8mHdZf
	qnTLeNEU0RxnC/xjy/VW+ohfStqGiIHHC4n/ATIklUQ8/VAX0zyClCQ7dOHYdjApYgZetN2O6D2
	ZJZ1UZF+74+9QBKbuRr0lUMYiPPHLM+z7NhAw/tJzq1YtiweZTCUb4PgKY+IXThGU=
X-Received: by 2002:a05:7301:198f:b0:2c1:7793:7bbb with SMTP id 5a478bee46e88-304491d0c06mr3267768eec.27.1779512719620;
        Fri, 22 May 2026 22:05:19 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:7e45:2bd:3c86:d34a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30452259de0sm2582124eec.22.2026.05.22.22.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 22:05:17 -0700 (PDT)
Date: Fri, 22 May 2026 22:05:14 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: stable@vger.kernel.org, Dan Carpenter <error27@gmail.com>, 
	Seungjin Bae <eeodqql09@gmail.com>, Sanghoon Choi <csh0052@gmail.com>, Kees Cook <kees@kernel.org>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: ims-pcu - fix usb_free_coherent() size in
 ims_pcu_buffers_alloc()
Message-ID: <ahE1hNQnHWRe3yr9@google.com>
References: <20260522085412.45430-2-fourier.thomas@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522085412.45430-2-fourier.thomas@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-253886-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4D9105BD29A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 10:54:04AM +0200, Thomas Fourier wrote:
> The input buffer size is pcu->max_in_size, but pcu->max_out_size is
> passed to usb_free_coherent().
> 
> Change size to match the allocation size.
> 
> Fixes: 628329d52474 ("Input: add IMS Passenger Control Unit driver")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>

Applied, thank you.

-- 
Dmitry

