Return-Path: <stable+bounces-11803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D96582FCF7
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 23:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C89C628EE4D
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 22:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB63B41C8D;
	Tue, 16 Jan 2024 22:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QdQDZgKz"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF4620B04
	for <stable@vger.kernel.org>; Tue, 16 Jan 2024 22:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705442630; cv=none; b=gNCqzjoNmlqxCa6XIeUehb+WI6UBQk5aMfJaXTU1BK9tHjuhKXIDXsmTGX+HVmzWrgfJN39XJ4t1V1/tJESmJHERllmY9eic1jVoWsN5si0bWvLleiPbgocZHklzx8yeECtaVK9zXp5jaMNM8zT8YRmh+s2J6BYfvTA32yR5vC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705442630; c=relaxed/simple;
	bh=D7xRpJrIqjZP5jeWAvqMV/IYv+apGd28JjwDTM2diXs=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer; b=FNtDT/3r1tqSAkcEIXLPpTIKgnp6s4X63V36HII6NtURy3kMP6kmTFXjZqAY4onpTy7EQ5ek4DQE/MdjaD0EseAlS1kns5VVbWX0t0SzJ/0U5vqxZqh+pgYIXdPkhncKJZEJgcA2XZ9VOeGNTZy8MMVaTQK73J+cRl+2wBc+W1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QdQDZgKz; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7bb5be6742fso100225139f.1
        for <stable@vger.kernel.org>; Tue, 16 Jan 2024 14:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705442627; x=1706047427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VIyU1BRIYxs21GRQFw4kCtrNUaHNQwollWRLcZszYHA=;
        b=QdQDZgKzmk0ADC5AWridK+DepYtS6VQc7YzHXcMvZ84IwZqjHceQrKLJtcmjvKB4VD
         2Almx5GkfUd+joveVXgAivBVxPpTl1z3nDN3Eu7iR2VkuIIeUeIdsmmfdW2S2owV9mwG
         7r0sWBAQDAmUx4ZiRZLoTejTagPqSfR5hkX30nbjsWHDesxyA/vTMaCl4wtt6D0asu7A
         5ll+b37D5twOG/a4WFJfwJuN7irrRrMPZsFJZSPlKMr7E1cQVNlljl+e0rnWJDjA73Mb
         7WAKMMafQd2JQ9UdGiLURYCQXa5y4Ym52OlkOlJHDQ2dVaJJ3IxUHkV3tD+jsiFiBoP9
         x7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705442627; x=1706047427;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VIyU1BRIYxs21GRQFw4kCtrNUaHNQwollWRLcZszYHA=;
        b=IBce3P/pGn4ZfvAqlgLuXRTYYPMcw7oDI0guBWTrfu1U9AuhTGakjihoGAZMx334bP
         xqKVy83x5pJ2snJ97tBwiz2Z7iP82N05XZWUyWG6uK+F/dGqlhOGtVuVdut3mDy1/FtN
         cYMfMQwngQYOvj+155/mzghL0Foy+KLadOBUE3SaRq4iwoVN5nndGE4gWYFeqq2OT39B
         b3vPgiXBdF7WvTnPcTbfmdDDYideG3uXquisrO6h6NZOs3dwpmOVQY8LnoG1BYZdf5jo
         qvKt3CBLT+07g4vFE1mjl4vomcOww4W108vUtNved7RlqOEbgehv0sEkpMD316JLh0Fu
         U52Q==
X-Gm-Message-State: AOJu0YzcJUMq49Ev2jxeZzuKzGV96CmTlgLhtFrErn3NoYZOvfDyYcj9
	9k/6Scaxn/1+MTIPN8SHrP5k9f7h6+TaTQ==
X-Google-Smtp-Source: AGHT+IEBhVEzbxUPC/dV36xmsUmmiGJEMiU22plQpZdebatedQSaUvgxWn8PYaTSAsQLbvD5Z+85NA==
X-Received: by 2002:a05:6602:2c95:b0:7be:e080:6869 with SMTP id i21-20020a0566022c9500b007bee0806869mr14083792iow.1.1705442627249;
        Tue, 16 Jan 2024 14:03:47 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id l14-20020a056602276e00b007beea806d89sm2964862ioe.41.2024.01.16.14.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 14:03:46 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 syzbot+8b23309d5788a79d3eea@syzkaller.appspotmail.com, 
 syzbot+004c1e0fced2b4bc3dcc@syzkaller.appspotmail.com, 
 stable@vger.kernel.org
In-Reply-To: <20240116212959.3413014-1-willy@infradead.org>
References: <20240116212959.3413014-1-willy@infradead.org>
Subject: Re: [PATCH] block: Fix iterating over an empty bio with
 bio_for_each_folio_all
Message-Id: <170544262659.494117.14502342650352587808.b4-ty@kernel.dk>
Date: Tue, 16 Jan 2024 15:03:46 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Tue, 16 Jan 2024 21:29:59 +0000, Matthew Wilcox (Oracle) wrote:
> If the bio contains no data, bio_first_folio() calls page_folio() on a
> NULL pointer and oopses.  Move the test that we've reached the end of
> the bio from bio_next_folio() to bio_first_folio().
> 
> 

Applied, thanks!

[1/1] block: Fix iterating over an empty bio with bio_for_each_folio_all
      commit: 7bed6f3d08b7af27b7015da8dc3acf2b9c1f21d7

Best regards,
-- 
Jens Axboe




