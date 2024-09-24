Return-Path: <stable+bounces-76955-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCA9983C70
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 07:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0833281850
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 05:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB2246447;
	Tue, 24 Sep 2024 05:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HewoBtYU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE6644C68
	for <stable@vger.kernel.org>; Tue, 24 Sep 2024 05:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727156517; cv=none; b=rDdyc/JFpUs2Eee/tiJCMtgJmKp0xTHk77OWynG02gbZcdfPVQ48pNdoYe4P4sOHa1PEfcf6z5IAqdlm46H4q57BYwRHffqGIVKKSUQ6CZVRty2KnWnxtDtIC53Qqjc/aQSF6QOx8RZVg84WK/Uik0pnWTG5sdNdkgssFI6H3sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727156517; c=relaxed/simple;
	bh=jH6sv8FNLFl/Kif28e2IwbxyIC15AJwFwxX0qKHVeUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMCdowN58N53k6lFobL0wf7QABFgHIX5kPdjHIBK0PRaXnTo+HhCsOqivygKegXwq879XUPOWsWaCmwAIjTrwqmhR9qgm9LiwOftAk8DBPuPAGHeJL7z9Q0WHN1E3BD8Z7qgXgddomv6I8REGm2NBfqb9oVsvS9IPppA677fM5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HewoBtYU; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7b0c9bbddb4so3460880a12.3
        for <stable@vger.kernel.org>; Mon, 23 Sep 2024 22:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727156516; x=1727761316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cge31yltZ3LBqF6Zjp76yFNSwmaUL6JImZQbh8KHv9Q=;
        b=HewoBtYUFcwrDJxS/LiYKia4PdxpxNFPuST4Jd7FT8su7mdpEkHebJPWVow345IjLX
         SC19yurgWbb/Vtl6/kNTDclLo826TtFg+THGLxZuNwD1/kPIXKlyi11K1mZEFIe4oIPh
         WxXGuOwc6n5fSErJnkVE+381ZWQYOWA6vsmOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727156516; x=1727761316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cge31yltZ3LBqF6Zjp76yFNSwmaUL6JImZQbh8KHv9Q=;
        b=A3QGyLSK7kA8US3IkB3owH+nBulkNCUR8SIR6WAwG792xb3Ko7efjVvObt3S49Wu4F
         NQxvarhaQDNyPvbg8zrOtx8aDIwLS/ncRt2WF039tAHVVnAaZgxFz57xyu3l+krKFHB4
         T4mhMBHOAr+lQIDUJKacZDESh8Ap9ReOQKNepjok3ys0OM068H0fgdsviddEzNi7BWaf
         n35riNcVi1hxuX2sc74GtiQWcl2FIgmyvQP6J9VPsul/LCG+XORE1NaN+yLjHLL9tv5s
         +xE+h+AVCpBbjblskdVB8ykCvzjq8+9yr14iC9msVSPi4Cl3y113mCg0+F7JKGsVRWlj
         O1/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUTKLv3MJAbCBs3JEF/wgk2BtSLT1dBeBwysNuIPFjGZblOs3nI+i+TgcSFMSq89swiSV/El4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLIh1FulkVW0RZ6V8nQ+mT2n16TQM4em7lMtAIcP2YgFzn0ygp
	AE8SLgB5y99uEa2Fps8S6y3gGkxUMjMw70UKekWS8Xec1IOjh5nvcG/AOL+XuA==
X-Google-Smtp-Source: AGHT+IG1lZisxJAgOWdpQ4rLYMltGE4fxYOV29zGec732JAMjhEQW5CudTcv6H4bnb03Tqzw7xN0QQ==
X-Received: by 2002:a05:6a21:168e:b0:1ce:e725:1723 with SMTP id adf61e73a8af0-1d30a9d8901mr19524958637.45.1727156515684;
        Mon, 23 Sep 2024 22:41:55 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:93d1:1107:fd24:adf0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e058ee6110sm590246a91.8.2024.09.23.22.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 22:41:55 -0700 (PDT)
Date: Tue, 24 Sep 2024 14:41:51 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] zram: don't free statically defined names
Message-ID: <20240924054151.GL38742@google.com>
References: <20240923164843.1117010-1-andrej.skvortzov@gmail.com>
 <c8a4e62e-6c24-4b06-ac86-64cc4697bc2f@wanadoo.fr>
 <ZvHurCYlCoi1ZTCX@skv.local>
 <8294e492-5811-44de-8ee2-5f460a065f54@wanadoo.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8294e492-5811-44de-8ee2-5f460a065f54@wanadoo.fr>

On (24/09/24 07:21), Christophe JAILLET wrote:
> > > Hi,
> > > 
> > > maybe kfree_const() to be more future proof and less verbose?
> > 
> > kfree_const() will not work if zram is built as a module. It works
> > only for .rodata for kernel image. [1]
> > 
> > 1. https://elixir.bootlin.com/linux/v6.11/source/include/asm-generic/sections.h#L177
> > 
> 
> If so, then it is likely that it is not correctly used elsewhere.

Oh, apparently there are drivers that use it...

So I suspect it works when you do

	kstrdup_const()
	kfree_const()

// I only looked at drivers/firmware/arm_scmi/bus.c

kstrdup_const() can't tell module's .rodata so it does plain
kstrdup() and then kfree_const() (for the same reason) does
plain kfree().

But calling kfree_const() on something that has not been
kstrdup_const() is unlikely to work as intended for modules.

So I guess kfree_const() works only when paired with kstrdup_const().

