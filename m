Return-Path: <stable+bounces-124332-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8ED4A5FA5B
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 16:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6D75177DA5
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 15:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E421EB191;
	Thu, 13 Mar 2025 15:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAA4NEzO"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80266523A;
	Thu, 13 Mar 2025 15:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741880781; cv=none; b=m3ANXPNJBcuynRHDeE2sayPozxS33UqgD89XeiCxUI4tB9G4+LBeaSbjroHKPXHaQX7OxOWCZijDAy/YoKaPMXEf625clu7i7KSfKyqj8lLaJ8GMSMr/4GkJ3uPlppbcmLoPCZA7U68xTPExtkJ9Jtd24xLr85BKVUZYoUCGqa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741880781; c=relaxed/simple;
	bh=hA2I1wA1nlZj8ZSEiJ6mwulaNz4wSZhy4YWU6ijeu+k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LP2dnh9+D0OxMCz2fzCmZ3g+rUew3Mb0OX1iodZ20VgmyWWuraoQAkn6xutMVtzIVruubvVtdaF9FQFt+NJnwJRWxTsxpYLEQREiTZi065rl+BciG/eTqBSrYO+iKKWYpX25GqpFpz032u52LkYIiRnPQpQgpib6IGd+nx8echw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAA4NEzO; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so10388905e9.2;
        Thu, 13 Mar 2025 08:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741880777; x=1742485577; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1s53A4pO9sz2b44+AGVFc/j+BP4+7/TZwMsppe6om0=;
        b=bAA4NEzObqMP9ABZyFoqLuDu6qQcbAWfM+VBFSgtsPngOmKQR11wPFTHZ1f0XNRWPX
         hZQrPQ90y3nygu7qUTYYMYqEEvWzwUUSnDRz4010dSFx/Li53smPqE3d/81BHuHF6g9E
         4mHXSupS+8UGEHQRJ3hQZ+4YmQrjd0Cb1lHDqSQ1ip4LIKD8MRrPhNobHqwj53PjjyTF
         nn5duxhOA4/dBuRC4nZfX3tabd5t8oqwFFdfGfLjqX9f3HwdTIJkrKLI9XeYn3Av1MkW
         VEs4rQwIsuDHjpPq2EUssGI0UR6+7ob3uSpLi/CKCA3gbtrX+wsgHGifQLFUXaOW0PzD
         epjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741880777; x=1742485577;
        h=content-transfer-encoding:content-disposition:mime-version:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M1s53A4pO9sz2b44+AGVFc/j+BP4+7/TZwMsppe6om0=;
        b=VtvK0L5OqLlc3nLxe1B6xnJ/QJhhGBbeslbketvQtziHaECA3cetYMZ78OBhev8la+
         PR6Q3vjjbynpc36a8hTZGP8NIcwVvS9wPVBzi4tx/JSEK3iOhHO/zoU9wScnWbJ+fMhD
         B4t18k2JfbFYnx0ejZZeqOSSGyF2jgAs89yJk2Qtw6PtWPwxhaaS4ECIvoPloJob+0+z
         PNhF6bqHZ4ta5v8pNsxr9csUqTrl/tXd0e28I/vKHOLPCW1IF67EuJIAMi9PjmPOlQRX
         bLqq4ZkCD0cpaMyR3e9TJ3ClRpm9XhaS/iXEM+vDXv5H1YhP3fBc49Tqwlv+cMUCcHtS
         8+3g==
X-Forwarded-Encrypted: i=1; AJvYcCUtBAT0JwOmvYJPElWjiRovbDycObnZwWuULA3VKOAevo04Zl1zEMDEDZ0/zl5S8aKHN0T5IMRo@vger.kernel.org, AJvYcCX4+eIuyrbtGDop+eIBhwbK0bEwxJUMoXGnGUQkqi9cPdqg49uEZYuWlgvEvv+UlcMCzplGKCuj39LOJy8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk3UWSmstSfevqGYt7u6kbzhmknKUJMoqFjj+3W4DCnRlqLAKa
	PMe0eXgclsBIwpWdmLhJkMNW6azNJItMP7ehxUE5GWnWIZad1YwQ
X-Gm-Gg: ASbGncunaOECBNGu7dWw0/rQCvO+7xNqb18uHLBT6XKRKC4Obh5DGBxYLZPVdrMmCR3
	oEOdyDZ/3UdGtxdnudBKxRlQ/BVXXatq+SEASW1SXNrtagin23R1BVqPh0TkL04D7xtZsqXKtxi
	NqeoEl23aRxXtnP5oehYwQKXEAq8QgB4tVEcw/dX4DMl7mUSAbktqm+rWR68qKSKzrS3aeV3HbP
	oL4XyYAdqj5ue85AmEyIBPOyFS6lOH50fJI8PZ+tWeIYo0MjHyMjlRejY5dlSmkSlXVYDihoawI
	509e52QD9tj87ki7u+z0yA9Ks4tCEatmmdWG560Bs877x++G
X-Google-Smtp-Source: AGHT+IH9dnsaN8JCZkVtg0IE9aoEMip4K1WYukBLvgiu5/zN5ZSL4K/lbc/jZ3sa2EhUb4p6J5NbwQ==
X-Received: by 2002:a05:600c:1ca4:b0:43d:b32:40aa with SMTP id 5b1f17b1804b1-43d1d88ea8fmr1733475e9.3.1741880776361;
        Thu, 13 Mar 2025 08:46:16 -0700 (PDT)
Received: from qasdev.system ([2a02:c7c:6696:8300:41ee:4f4e:e8e9:935f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d188bb59esm24797935e9.21.2025.03.13.08.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 08:46:16 -0700 (PDT)
Date: Thu, 13 Mar 2025 15:46:13 +0000
From: Qasim Ijaz <qasdev00@gmail.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: ray.huang@amd.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	simona@ffwll.ch, thomas.hellstrom@linux.intel.com,
	Arunpravin.PaneerSelvam@amd.com, karolina.stolarek@intel.com,
	jeff.johnson@oss.qualcomm.com, bigeasy@linutronix.de,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/ttm/tests: fix potential null pointer dereference in
 ttm_bo_unreserve_bulk()
Message-ID: <Z9L9tbL7fWxw3yb4@qasdev.system>
Reply-To: 6a24d733-88ef-4cfb-8cc8-1c01fb64fc0f@amd.com
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Mar 13, 2025 at 03:20:34PM +0100, Christian König wrote:
> Am 11.03.25 um 20:01 schrieb Qasim Ijaz:
> > In the ttm_bo_unreserve_bulk() test function, resv is allocated 
> > using kunit_kzalloc(), but the subsequent assertion mistakenly 
> > verifies the ttm_dev pointer instead of checking the resv pointer. 
> > This mistake means that if allocation for resv fails, the error will 
> > go undetected, resv will be NULL and a call to dma_resv_init(resv) 
> 
> The description here is correct, but the subject line is a bit misleading.
> 
> Please use something like this instead "drm/ttm/tests: incorrect assert in ttm_bo_unreserve_bulk()".
> 
> > will dereference a NULL pointer. 
> 
> That irrelevant, an allocation failure will result in a NULL pointer deref anyway. This is just an unit test.
> 
> >
> > Fix the assertion to properly verify the resv pointer.
> >
> > Fixes: 588c4c8d58c4 ("drm/ttm/tests: Fix a warning in ttm_bo_unreserve_bulk")
> > Cc: stable@vger.kernel.org
> 
> Please drop those tags. This is just an unit test, not relevant for stability and therefore shouldn't be backported.
> 
> Regards,
> Christian.
> 
Thank you for the feedback Christian, I will resend a new patch with the
changes you described.

Thanks,
Qasim.
> > Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
> > ---
> >  drivers/gpu/drm/ttm/tests/ttm_bo_test.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/ttm/tests/ttm_bo_test.c b/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
> > index f8f20d2f6174..e08e5a138420 100644
> > --- a/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
> > +++ b/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
> > @@ -340,7 +340,7 @@ static void ttm_bo_unreserve_bulk(struct kunit *test)
> >  	KUNIT_ASSERT_NOT_NULL(test, ttm_dev);
> >  
> >  	resv = kunit_kzalloc(test, sizeof(*resv), GFP_KERNEL);
> > -	KUNIT_ASSERT_NOT_NULL(test, ttm_dev);
> > +	KUNIT_ASSERT_NOT_NULL(test, resv);
> >  
> >  	err = ttm_device_kunit_init(priv, ttm_dev, false, false);
> >  	KUNIT_ASSERT_EQ(test, err, 0);
> 

