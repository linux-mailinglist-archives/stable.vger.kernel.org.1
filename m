Return-Path: <stable+bounces-141819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4F2AAC715
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 15:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E68C43AC154
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 13:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74CF280333;
	Tue,  6 May 2025 13:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="xiv0V3pp"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403E627585E
	for <stable@vger.kernel.org>; Tue,  6 May 2025 13:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746539815; cv=none; b=M4NLM+fX6MMiIF4otlb7477KjwLSkPRsSjUHOs/a4MbvI2mF66Otq1kNtPlOJ2RqlESvcSmcrbKCflH92ADmTTxJgHXnF7yixlfQ8Ss70UbAi5WgMTSq/3yB5VGcqJmlt1htzHMXn8eODQ7UxZIlioXyUcqbv3/jGiYlpqCI2gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746539815; c=relaxed/simple;
	bh=diuTHdg9wH86je35PAf/oPFW74sGs6JKnCKwxE06PsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDn8jdORNw9HKk9DGdzPNh1h5lp549nBypRiWlGNtWnhZyBJmt4Q/Apwekn0CNDRTv9ewDhBHmOVeX9bQp0QEilm1BAqa0mXk3TiLnoIQqV7hilKKVBwlFRzoTWZw5NMqaWJLtwuXGAOkAOlO6+iLXr7i8C091Jh3nNMaHAq71c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=xiv0V3pp; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4775ce8a4b0so38828261cf.1
        for <stable@vger.kernel.org>; Tue, 06 May 2025 06:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1746539812; x=1747144612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aN2vCmnMOiTJRd2NcNvbHVRm+Ax5/gKsVJUXvhmTYu8=;
        b=xiv0V3pp0l/1/UgPQaNQXiGsXnKvvgJ14lIIF1YxYa+blDzmEonvgWuC7fw7FdRA2O
         l0K57/DMpbJs9jNNp1DlgTXF3MuqZJhNO599cYfhpdj9Hj4eM+E7xs72M8KpErz9DFV8
         FbNgPc83/9YQuncqvCvMcjvEO5I5qs2Fuaqntdjeuc4MIruAGx4giiPxKrLC+avFvZHl
         gha1Ww+MP11r29vK4pIzXkNsHfhDGNH+4nmqgblgdITSZMWaa5R+mFsi/TKPZSUsENG6
         59BcYKnRjLbEnmBP3h9TFZJqRiNuLLDwfDZlArnGw+5vHe4QEQOMeB9xZj3RSDPTQBom
         JuSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746539812; x=1747144612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aN2vCmnMOiTJRd2NcNvbHVRm+Ax5/gKsVJUXvhmTYu8=;
        b=qjLerfaIC2VpGvGCj1t+dN7ZhApcslW/a3F+FPn41S9UDEk62IMeOqt4J5oXrbD6h7
         snYsWMSYwd99qHX6eBIvvSvIiA6xb5f0ps4d0JGZIFfzBAJ4B4w2jhFGVAtvya4Yuyof
         ysnk00dcfHHFIDqLW1Cqf12O5bwm05122P4N3caRP7p15dlfc+r16h11jHsH+MttPhrJ
         DFExel+xEdOtzPYIVyJ2mi+DtxLmtLrpezjGeI2jWRI4j2FEQliPM8MyTGPMFjsF9SmN
         gIM8R8X1dzg6tib3WZrPE2OftaL+4wmv5jnYEWdWizSdV9mNPIBOTmnCWB2tQnVrXT2d
         go2A==
X-Forwarded-Encrypted: i=1; AJvYcCXOLDOHm/BFoqF+Rk/flQ4dZDrDlSoVI7rXAz0ezBtdPGTSt79GuR9Fgq+na4GPaxpqFIlAkyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxViamr1qXagYK/L4pv2nbMhYP2tcrbEF1PdLh1T9PmZehJ3bH6
	UpFt065RcCyf30qh33z4u2+tSYDMB46x7YUgf6CfffP+ZcoSuDGcvBseGlKk7Dg=
X-Gm-Gg: ASbGncuy63CZNY8Nm+5mENpn7Czf4HcnUteN+z5V6GzstqfgFex6DvcUFWIMXTfLckt
	Zt7YecnnyIVOu8WSRpjwbfolI3I0pqG9rb0TBh+SNjjlsoPBblYLk9ahm/RaY0c6vfcruB9AXut
	JQ25QIqPBQDV0J7APOMJOUDsYJj6mMKpH58i19QI7l/MNQq6uJIy2WPunRyqbHNv7YDIZGGYicv
	GQs0gE+ncfZQR/k10emBjLiapMM11n4DexO4MWXXQNWhLhb3FMY40WLG4tJrnoWEgA665WzDOin
	/+DldkaESPbiRrbFaDMnGVP2bMnWtUPXBdILQnI=
X-Google-Smtp-Source: AGHT+IEf4MiWHFWj8hzchKZtX+h2HhYFuraa3E7oJqsE/qGwLNoxGmCiP394t/DNB9Ph3/h3uXyTVg==
X-Received: by 2002:ac8:5dca:0:b0:476:add4:d2c0 with SMTP id d75a77b69052e-48e00e67234mr190077851cf.35.1746539811949;
        Tue, 06 May 2025 06:56:51 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-48b98721c92sm73164021cf.55.2025.05.06.06.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 06:56:51 -0700 (PDT)
Date: Tue, 6 May 2025 09:56:50 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Vitaly Wool <vitaly.wool@konsulko.se>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Igor Belousov <igor.b@beldev.am>,
	stable@vger.kernel.org
Subject: Re: [PATCH] zsmalloc: don't underflow size calculation in
 zs_obj_write()
Message-ID: <20250506135650.GA276050@cmpxchg.org>
References: <20250504110650.2783619-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250504110650.2783619-1-senozhatsky@chromium.org>

On Sun, May 04, 2025 at 08:00:22PM +0900, Sergey Senozhatsky wrote:
> Do not mix class->size and object size during offsets/sizes
> calculation in zs_obj_write().  Size classes can merge into
> clusters, based on objects-per-zspage and pages-per-zspage
> characteristics, so some size classes can store objects
> smaller than class->size.  This becomes problematic when
> object size is much smaller than class->size - we can determine
> that object spans two physical pages, because we use a larger
> class->size for this, while the actual object is much smaller
> and fits one physical page, so there is nothing to write to
> the second page and memcpy() size calculation underflows.
> 
> We always know the exact size in bytes of the object
> that we are about to write (store), so use it instead of
> class->size.
> 
> Reported-by: Igor Belousov <igor.b@beldev.am>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Could you please include user-visible effects and circumstances that
Igor reported? Crash, backtrace etc, 16k pages etc. in the changelog?

This type of information helps tremendously with backports, or finding
this patch when encountering the issue in the wild.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

