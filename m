Return-Path: <stable+bounces-73780-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEEB96F4DD
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 14:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CC85287527
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 12:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A1F1CC8B3;
	Fri,  6 Sep 2024 12:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tr4Bjn+e"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D9B1CCB53
	for <stable@vger.kernel.org>; Fri,  6 Sep 2024 12:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725627494; cv=none; b=UVKcIo6pBxxSjlK4wjyzbIDaZ80mCxoFPHamLy/FSbFObYLmDaEXmTdMPTKmBcUnRjJtZcMOQpODxdZMpWbWwNafhHZ6Y3rzJenwxt6qQLa0AIRa7DU/E1ZhNBx/QHY1tshxVoEgn9vpdDB50Tb/L3qkQK06ODaafwTWUbiG58o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725627494; c=relaxed/simple;
	bh=BcTHJyFEMEh0+b1IinTGMWEZFkZ3h0/W9UXB1tBIldo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Ux31LU8LyzmS9ZaC9YXKZ9wuaFrroFTQj3twMqUiAsKPbH/BfNm/48DLRk0mIby0annNdSnZIY+jmB9e+Mt6WpWys7ewCU5JYhN3SmYno7S2wXVaP6tp47HtDDQimZmR8OK558a70L3yaDcBuBylthxxC9unQGwSfjCKRUWOLwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tr4Bjn+e; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dff1ccdc17bso2148471276.0
        for <stable@vger.kernel.org>; Fri, 06 Sep 2024 05:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725627492; x=1726232292; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B8vr481uMgJZB9pqndjloCZMju/qQPyu/xKE2qZU6s8=;
        b=tr4Bjn+epPcsqixTQAy+0NdhCRPSUlxL1MeunUgcQxsYqTt56gZD+kuHc8J1jBv8GE
         nSMiE2i1YEM4fTzgDBfsCb6C/FbEapJkwKIykDPdKwAM2bkclpsox2xP6O/zUeMOpaD0
         JVyrh76D77QS4+WHg/0lioZ1dUTQ37ymPivexwa5YX48bKYW4wV2uMv7h5FzmOh6fCoR
         ko/iOZxEenL/PbqSaimrknGCahqevt8pXXwUwX8mcRfB6s13OjE2z9zGuP+bG2l8/m9y
         AYkrn8euOGU5t9ubekmAsrIWq97YYMTVRwdT9dQ9OHTnJemgIURek3EKHnCka7hHsTQp
         qmoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725627492; x=1726232292;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B8vr481uMgJZB9pqndjloCZMju/qQPyu/xKE2qZU6s8=;
        b=B+qEJxwOv/peIGTq1GbJ1ksi3Ui3y5DSA37/CmCxUGbThPT7VS6ha+L4Hei+e3VRBe
         eHf5bPvTRFK67Sk7J20hUSvsu0uGLsUiuywzskv34yu5rEcuSdVswtQgyV4S2IUPZkP5
         t8D5cxNdvNfHIcN7NIiueFfIHZAmUeOq/172pm02KjTnJbgVUHwf3+diozYpjWnu/2d4
         NQKpCkoulLaH2ZhfEWVAzHmIwdPFYvpTxU5q4Ao6sKqryPSaP2MclT0Mt9rv6+Qwr19i
         rmcojJ/5grhfLpa0o1QlVw+qdB+Gg8KSiXoPLb9ZG5DnuP+Wf3FSmvI8dvY5TCqpS4DK
         RWow==
X-Gm-Message-State: AOJu0Yy8pBmNhC60wAexHL0QODNvHY2yRxF07Ao5XLTHDC3qSygdRRo0
	JwYHXt1z77BRUGMvsb8W9wTnqJ5qaeIn2MTrhPS79CYwHOehrkhBtU+U8IbG0d+9BdZhYeWUcpP
	0aKGyAPj1mnciz6rgtzSg5X4ndISUNYbiknLP/bt0AyQYOwpdnx4kwcHB
X-Google-Smtp-Source: AGHT+IGia2tZuzruqQ5v95ZBhh5zSJ2CN7oFRRJKJkyuzgJMKe9oMscWbHGSXNHtJUhk6hgxq0YdCvgZN1JF7Rg8CCo=
X-Received: by 2002:a05:6902:15c4:b0:e1a:73cb:b77a with SMTP id
 3f1490d57ef6-e1d3486652emr3272856276.2.1725627491780; Fri, 06 Sep 2024
 05:58:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yongqin Liu <yongqin.liu@linaro.org>
Date: Fri, 6 Sep 2024 20:58:00 +0800
Message-ID: <CAMSo37VOzcQyjeg6NszqEDxXiA3tUfpLCqDJ+g6nY3xJebYJ7w@mail.gmail.com>
Subject: [Backport request for 5.4.y] reset: hi6220: Add support for AO reset controller
To: stable@vger.kernel.org
Cc: GregKH <gregkh@linuxfoundation.org>, Peter Griffin <peter.griffin@linaro.org>, 
	John Stultz <jstultz@google.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Enrico Weigelt <info@metux.net>
Content-Type: text/plain; charset="UTF-8"

Hi, Greg

Could you please help to cherry-pick the following commit to the 5.4.y branch?

    697fa27dc5fb ("reset: hi6220: Add support for AO reset controller")

It's been there since the 5.10 kernel, and this along with the clk patch
are needed for Hikey devices to work with the 5.4.y kernels, otherwise
it will reboot again and again during the boot.

-- 
Best Regards,
Yongqin Liu
---------------------------------------------------------------
#mailing list
linaro-android@lists.linaro.org
http://lists.linaro.org/mailman/listinfo/linaro-android

