Return-Path: <stable+bounces-76656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5827B97BAA5
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 12:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 892671C217D8
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 10:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D3517BEC2;
	Wed, 18 Sep 2024 10:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="g/0RNlEh"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75C7158203
	for <stable@vger.kernel.org>; Wed, 18 Sep 2024 10:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726654632; cv=none; b=UGR6q6nnfqzKBFx1qNtzS07dNj3Ww3YU6nfEEVpvofiYlijTYKyaIYAPYRk9KKUcZ19Ty7t7XAmpF+HLLCLRv3fR+crZZ04D6ukwi/gCLpfDZaRxADSREGAy50W4oSvwpp85QY6uI87EDhrc20os9Zpn8ewy8IccSN7evdPI9nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726654632; c=relaxed/simple;
	bh=+tpJnY909VM1M+m1CMhX0xl6c3hIZ9gIwNHSsoAD8J4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=n+WxgAsHFwQuf8xgUEYbY8YZ5Yo4TbW1uf874EE0KXRKS229AyRRhztMaopcxUWTJbc+AoUqaU+A5cvAeWUsMoskkhL6Tpwd0PZPL9jDagG46JP51sDZjP1rRzl7L8VXBpZjPZ+4V089kHMNtwaq+VaWS1XS4ExVu9Crob+L2to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=g/0RNlEh; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-374c1963cb6so4483727f8f.3
        for <stable@vger.kernel.org>; Wed, 18 Sep 2024 03:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1726654628; x=1727259428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9xmRlfgY58bu3lgrbHWfq1PnhjWfcGquoMknYxltLHw=;
        b=g/0RNlEhZ8yqQd2ys9yx4Rbl/rjCpXGI0ubNLOYG6dPrAmwB34cNeVodCV2XkAvBhj
         2b6D3UZVaihlE6VmUQsDWPPKQklE/zTCdJuZZEUkz756pmoxio3ugq8AsZL4BCR2jyxI
         2mNAzCJo2Qa+kiIFIqNBpk4fN1YV33iumDo8jVe3Kwb6kH6ctvGn0w6QZv4Qzh5CfCgf
         AdHCXa9zEs3/3iZ3TEPsN8NH/bzgd/0gamP8W7xlbeSzvdf1D+CiJFS8MeV591McvmVi
         sc6WCOvaQ4Fr6M6xO0Kbp4ovTzlIc7N/0NbFWycbqTl5ea7E1epqYzpOhHbiLieuP0CW
         +vyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726654628; x=1727259428;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9xmRlfgY58bu3lgrbHWfq1PnhjWfcGquoMknYxltLHw=;
        b=Z6uTMPHQnaOHko5JaI1wlwEDmKzE5MA1wpvMCP4MZOgbfvkWzidQ/S1LydSomuy5sQ
         2p0Xk46kG2Nl4F3WqmNcMvqq3jrg998YuCPcfUJ8JC+CdRIhYOpBJBz5Buh23bWF+VBc
         Z+eF5B1sPHVrhRis7VCFQKkLh3XdnBYB2uJnplyoAcn2h2B41Zmc1sBu+IR+YgOnMc2Z
         A5stwNuUVfL1mU0QRrR8IUQGWa6MBgu85NDPlSbXpZ18MAEUt1ckMUu4AWdZisdsKVgW
         lC88T+mPDzk6ZUYlQHWITpiXD714zqOI33kX/Zxe5CPK7UnH3UxrDcSxeTW9UGVt/mb5
         YvdQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5YRnr3SqRXeyOJi38eJ3RAawJSUuZ7rmef3Kch82xIV7mD7ESCVn41bBG7GxkBh0mnk9j2Z8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcWZcXiGoVEAD55sUDWU4ptDjXGUFxh4rOg+QL1S/nZlA9q4vw
	gGUTwN68Puz8JVa2Bh2ezJ9vRN41WvWeEq9uEkX5oJjFb5GvbLW+Zqc5m7CEPu8=
X-Google-Smtp-Source: AGHT+IEt+88MOqjxAvT4BA2X407wtBcTy4RsMgu6zlhxdOqsfDfTg/sRarmUG6UIBwTVkHUeUeJlPg==
X-Received: by 2002:a05:6000:128c:b0:374:cd3e:7d98 with SMTP id ffacd0b85a97d-378c2d062fcmr12084591f8f.19.1726654627726;
        Wed, 18 Sep 2024 03:17:07 -0700 (PDT)
Received: from [127.0.0.1] ([185.44.53.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e7feesm11837758f8f.29.2024.09.18.03.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 03:17:07 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: philipp.reisner@linbit.com, lars.ellenberg@linbit.com, 
 christoph.boehmwalder@linbit.com, Qiu-ji Chen <chenqiuji666@gmail.com>
Cc: drbd-dev@lists.linbit.com, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, 
 stable@vger.kernel.org
In-Reply-To: <20240913083504.10549-1-chenqiuji666@gmail.com>
References: <20240913083504.10549-1-chenqiuji666@gmail.com>
Subject: Re: [PATCH] drbd: Fix atomicity violation in drbd_uuid_set_bm()
Message-Id: <172665462666.8208.13856585668352326031.b4-ty@kernel.dk>
Date: Wed, 18 Sep 2024 04:17:06 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2-dev-648c7


On Fri, 13 Sep 2024 16:35:04 +0800, Qiu-ji Chen wrote:
> The violation of atomicity occurs when the drbd_uuid_set_bm function is
> executed simultaneously with modifying the value of
> device->ldev->md.uuid[UI_BITMAP]. Consider a scenario where, while
> device->ldev->md.uuid[UI_BITMAP] passes the validity check when its value
> is not zero, the value of device->ldev->md.uuid[UI_BITMAP] is written to
> zero. In this case, the check in drbd_uuid_set_bm might refer to the old
> value of device->ldev->md.uuid[UI_BITMAP] (before locking), which allows
> an invalid value to pass the validity check, resulting in inconsistency.
> 
> [...]

Applied, thanks!

[1/1] drbd: Fix atomicity violation in drbd_uuid_set_bm()
      commit: 2f02b5af3a4482b216e6a466edecf6ba8450fa45

Best regards,
-- 
Jens Axboe




