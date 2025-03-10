Return-Path: <stable+bounces-121712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A22FA596B5
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 14:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F21A3A52F8
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 13:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF14822A804;
	Mon, 10 Mar 2025 13:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zleemMs6"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA4822A1CD
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 13:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741614644; cv=none; b=tMVdYzuDZKIs/dU5v7WscWpJnCjTTXC0nIA6vcxZAu2oWdPkuv+IPNjl8Ddx3uCXt/X+7t9FDLcGlPzwa9kYoZBCutvRwmqr7Er6cMQUK8XfQCvbsYrznhBCKJiQUzmd8jBgqY84/BAKpHD08Hehw0HRc/t1+AHBjTlE0xt7nJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741614644; c=relaxed/simple;
	bh=kRowGLaCnFK9DFM6f7uMT7JNCKLCEf2PT5kJGF3yYYc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IWOZIqmK+uhFBjD5t8ZvU8783dV6gfTEYOPGzQcygzdUnU//xvxMeG744HVw34RMyR/j9erBg+vlhYboVm4D3Jj8LcQGGB7ufof5ytQygpUKENQMGmN3+cuihq82E2DmeobH32BSe7vS9VF5IObmMA5VhKUBkj+GUoU652+cWeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zleemMs6; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-85b3f92c866so13965639f.3
        for <stable@vger.kernel.org>; Mon, 10 Mar 2025 06:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741614642; x=1742219442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUspsaKaBehtCKwT16rXODc0xHUdVxEjdsqpOZ3zIYo=;
        b=zleemMs6gwSf9iH3d7QXA9Cm0D9zd/MVCE+3KpjYFO3zGibKLV0umPE6zqo7/fW001
         ojpnKELVjUVTaVjgjLWXFJt6ZrClCv/tdjm+MEBtgeu8dzMcwZqUttxyqgNjneoY3gGY
         JyBq4X9XdJfUMI91UFYafqAS4hmAQFj6a7EIm5on5i3OnhgAL+u80W9wJOxnATjGOyVv
         BUu2XJJtF7vpqmSBK9v8T2rtol685jbXq6EYRWGRcqtui5D3x+wH8+L3ZLwQIPr2IDso
         lX7fxfJE0uZCOeYx/54UG9Icfm5+yb+ZfcPZTPDDTOaOkvCfKrKY+R6GeANsOrnm/2zz
         3mMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741614642; x=1742219442;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tUspsaKaBehtCKwT16rXODc0xHUdVxEjdsqpOZ3zIYo=;
        b=T5GB/HoxHkukGkApsI+eyoX9ErQTUxCJU5Fc+2FcJFaBaUxqY1oDVg57FX0oN1HvMr
         oxSC/D1Wm4bmcc163/2fFrk+pSIV5hM+dhfolUNWS3XCrFHROsHnTZMGcZQ4KglfEw9p
         wit2lLCkjDcF5L93r+mY3YuZGojC4jkdJEOAERU7BeNkOZuW7VsCs43bswx0zWg3P2cx
         wyeuuDzLarhERF0D+7NzMfdBKDK8w7ksHR3kZH0+ESuchl7BqNzXwWfa19UaPX1qG9qK
         y8byskbL/yyk7Ux0+saDT5Vhi6MPmotwrsiDGvqEWCOcXvVgeNsXs9QYqL9GQhPWFM1I
         bkaw==
X-Forwarded-Encrypted: i=1; AJvYcCWFc19j14VQ1RTH+PyxizwmZUAxe8mRa25QMQGRHTm3492JHOsrZ2CwpYG5rgvzBg3dm3QltLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCjICeIV4/jpnayfgZDFhy81DqX+Z9D/0fatSJ83y6/TLhu+rv
	042JYe46s9Q3Ga8wMYiZFIG49KvQqeE0z+pIIfvjsJZH+F8797cduvResr92eeO6wpN3P3hMDND
	k
X-Gm-Gg: ASbGncv3RBV7fOK2RfJLqcYAPBpQiXAOSTTKz2dwzVeZoSCVWAWSj4FtObpAXXTEd2v
	2WOfry0SeAKv5iEyqepAH4BU2t1JkUXn9NgMxmz89C7GgCm7wNDz1VDunAFCsNJxQXaWU4eLj+9
	7cdb8Ku61mL+9Dh1dTYfMI3pug7ldeymFbl/a8YUXO0n2Ln36mGs8fq65L9F9gkx+mkHXSN0YkL
	vqV1gWa1lQIE0f0TWsZ2K4+b/FblFg5jvJV7tzLVIKFJ58QEH0v8VrTUnFVoyNDOltXKHLhdF8G
	KK3VwEAn0NskXGWg61aCyGLBFx6/g6WOMCA=
X-Google-Smtp-Source: AGHT+IFNw1d4zMmcDFKbVYZybB1yEIUzV0WvPzCrDNX6b2PPX+F5muZn2JfFNZcEZIvopidgYOn7fw==
X-Received: by 2002:a05:6e02:144f:b0:3d4:36c3:7fe3 with SMTP id e9e14a558f8ab-3d441960b65mr144960085ab.9.1741614641970;
        Mon, 10 Mar 2025 06:50:41 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d43b511091sm21350915ab.42.2025.03.10.06.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 06:50:41 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: dm-devel@lists.linux.dev, stable@vger.kernel.org, 
 Christoph Hellwig <hch@infradead.org>
In-Reply-To: <20250310115453.2271109-1-ming.lei@redhat.com>
References: <20250310115453.2271109-1-ming.lei@redhat.com>
Subject: Re: [PATCH V2] block: make sure ->nr_integrity_segments is cloned
 in blk_rq_prep_clone
Message-Id: <174161464074.178937.3099509536865247557.b4-ty@kernel.dk>
Date: Mon, 10 Mar 2025 07:50:40 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Mon, 10 Mar 2025 19:54:53 +0800, Ming Lei wrote:
> Make sure ->nr_integrity_segments is cloned in blk_rq_prep_clone(),
> otherwise requests cloned by device-mapper multipath will not have the
> proper nr_integrity_segments values set, then BUG() is hit from
> sg_alloc_table_chained().
> 
> 

Applied, thanks!

[1/1] block: make sure ->nr_integrity_segments is cloned in blk_rq_prep_clone
      commit: fc0e982b8a3a169b1c654d9a1aa45bf292943ef2

Best regards,
-- 
Jens Axboe




