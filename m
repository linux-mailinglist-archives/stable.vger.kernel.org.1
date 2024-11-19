Return-Path: <stable+bounces-94049-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9269D2ADC
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 17:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 861D5B28FB6
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 16:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90191D0BA7;
	Tue, 19 Nov 2024 16:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="yvmoqkUK"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8891D095E
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 16:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732033217; cv=none; b=KKyxY/HMOw2vZJ2iFlJgdcrSHuMeapqaRrsId7ygbil4eZthNS5KPnLLm1DSpbI31mpA4/xUBrAEjLG1f2Xn0WbA3h1R6lbqiLvx/zfVNlp5rXH4MS8jP3d05eSraBQTcX5QRBL0HzBmt9y0Ey3Dq30am8XSjEgwl4gRvbakd6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732033217; c=relaxed/simple;
	bh=OdIfCpg1AbVHgB2T9ispri3GwOHonibskh7udt0tJSk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=J0iXroEX2St3qETopcr0bbIyUZe5Zg1Cojl8SKk8Kabquq//dN4VOr4Y6HIgb0shCl9UUoO1Cs3BFYFg3Fv0bweKhvEpfPmj61WIxz6wZFzIDPCLhySvxWtK5rb6dupD5942TmYSbmOQkzN9YGssdtKc6txALtGDdAFc86SWoJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=yvmoqkUK; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2969dc28d9eso1138684fac.0
        for <stable@vger.kernel.org>; Tue, 19 Nov 2024 08:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1732033215; x=1732638015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/Ft9aR9yRqj3mw2lSDRrmazp16w7rI4C6akOruFlLg=;
        b=yvmoqkUK4R2/JO3S/Gl7TzLvr/fR0uP7B5AswRkbupwIzK5pZ2ZazZ8j19TJbEWilU
         yqNheA3JwVWg3FHTlgZ8g8yqJlUX6R21p/MDEN5tDcXySREt/odX07g4h323DUB6asse
         6WVUcgDkDlQlm+TrmOMdXnQ8+yklOF0iGhUmrc7ugHxVg7mYBo4c1W0+dgOL5S+bOrr6
         q2mCBBU4i3dADEv3xJ9YHM9mjCHxu0sG02316e2wDNYth5gLAhtyNQc+G2pwRchO6ljW
         YNdtz3NwQrZP7/ccji5Hy+XdGFhyhMmqOPGOWt7WyhoZ4mPz+EtJ3naVpAGvtgUVFv2T
         Q1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732033215; x=1732638015;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o/Ft9aR9yRqj3mw2lSDRrmazp16w7rI4C6akOruFlLg=;
        b=XokoGfivwGqhlltPQK5oez6rMSiW0VaP/VAYY1iwxIcJ081L7T3qET+2MD7yB8MH2d
         ldzTxrGJheGnM915ZKOp3XYWJw56/VZXcbTtNUiYzLjajac9wNGpwliIcv+B3M3RxLSr
         ApqHnm0N8ADQdNaw5G/zsZgFyx4V8NRm8VPKwR5/KL+bmTEmWiJcPte/rJZjSJonFrtn
         B+O00F/P7SdTtCutTD5F9owxcFx4BHHWpt4vBLRRuCp7+pPD0Pin06L4/QRvlmr/lsvF
         xB0gaLTVu6YQixZxywEr64tnVxWvpolcBiq9cBL8CRj61BEL9hGgs0f9iV3A4Srl3eqF
         H9cA==
X-Gm-Message-State: AOJu0Yxuta0zRBiM4H6k1UG1/I7i1rW9R/Jl6R3heXEhg4NG9XYSy9Ni
	mRwS2c0zKOd+cOVSmDSAhtVZkgOvkEofibrx408r40v/zmSQp6PwnCOBOwA9CSQ=
X-Google-Smtp-Source: AGHT+IHUSAcx5cc3Rj7yHOAXiycIRvr9L9h13LXraWwRqkP6IfzKdhaJyzOX6qpSjqqWjmH+Y1RfDg==
X-Received: by 2002:a05:6870:bacd:b0:296:1e98:6846 with SMTP id 586e51a60fabf-2962e34d157mr13773103fac.40.1732033215025;
        Tue, 19 Nov 2024 08:20:15 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29651ac449bsm3588807fac.37.2024.11.19.08.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 08:20:14 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: stable@vger.kernel.org
In-Reply-To: <20241119030646.2319030-1-ming.lei@redhat.com>
References: <20241119030646.2319030-1-ming.lei@redhat.com>
Subject: Re: [PATCH] ublk: fix error code for unsupported command
Message-Id: <173203321410.117382.14501473576821099671.b4-ty@kernel.dk>
Date: Tue, 19 Nov 2024 09:20:14 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319


On Tue, 19 Nov 2024 11:06:46 +0800, Ming Lei wrote:
> ENOTSUPP is for kernel use only, and shouldn't be sent to userspace.
> 
> Fix it by replacing it with EOPNOTSUPP.
> 
> 

Applied, thanks!

[1/1] ublk: fix error code for unsupported command
      commit: 34c1227035b3ab930a1ae6ab6f22fec1af8ab09e

Best regards,
-- 
Jens Axboe




