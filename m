Return-Path: <stable+bounces-40303-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FE18AB248
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 17:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0D4F281264
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 15:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B13212FB36;
	Fri, 19 Apr 2024 15:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="dQ3gWQS6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0311A12F361
	for <stable@vger.kernel.org>; Fri, 19 Apr 2024 15:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713541728; cv=none; b=fA2stVXD972U/rjkrMAfg8FjI4r4qGFOOo8bHuZ+H2/XA6VjBhVVDt7W/Pc+NMIRJWG3ZC3clPiFNyIgoB7VrJSCthutvHFr2mPytvvtTYbdQm8IvqkfTTgGEjZnx0WqDbpV79JDxkrYkAsywytuZgda2BVIXmeVZH8AZusfm9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713541728; c=relaxed/simple;
	bh=06W4FaOu5FrZnPQ2iBD/vux40hNLAT9rXm/yN0QWIJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AJ5CIRJweSgvPcyUrKytjWY19pfs8KkylMPAQOkv0epvJDUindo+Ev4a+RW1C5ZWId7XMj2d7PcA4b8zakxDvvwqE4c8Tot/HD47vWFSnqO9W95YqU1DZPEZrtarm9bhQogmTGgBiW5Kf6GBGtcZiEBwZcGKbT5bmw/j+8FnpbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=dQ3gWQS6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528A4C32781
	for <stable@vger.kernel.org>; Fri, 19 Apr 2024 15:48:47 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="dQ3gWQS6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1713541725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=06W4FaOu5FrZnPQ2iBD/vux40hNLAT9rXm/yN0QWIJ4=;
	b=dQ3gWQS6lFBhz0nkaExfJB79DzPqTv2SLSPfiDGaGXmHGODiCPrlc7yfvYbo/ExVGrRZfW
	ivzeOhvY99B/viGFC2sCYtEd8uzqDI30Du5TQvMC2fMWz1dsY4o9wDgNqpaIqY27lMaF1J
	doNM9ZFcwwLL5GAp9jujkhaEKZBLcAg=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 454f5ea3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <stable@vger.kernel.org>;
	Fri, 19 Apr 2024 15:48:43 +0000 (UTC)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-de46b113a5dso1838504276.3
        for <stable@vger.kernel.org>; Fri, 19 Apr 2024 08:48:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX0jfcQuSYf36tNVWH69HkSW9EbJeGSOp2XCZ5zLUOFv+sAd9l1Vh4L61wA5+FqcwQZYLm9P+vMHX6k8e4uC/RiF2btxT5m
X-Gm-Message-State: AOJu0YyK22QNGl5ZTD9XbaFucV79f1a9AiXYtHIIl9cNbL9klpe2sqnY
	DVeeCYcZBEGV1p6F7MH3Qg7GKjlkiEbkjLvAxNL9hfRMdB/RaLFtr0wA75hHFxRNsfPVDlpO5yz
	4ri0M30Kc1YAxYrtKyhM3rBs68BU=
X-Google-Smtp-Source: AGHT+IHwI6C6vXXBfMhXR88L2Q3dEkqo2H4QoF500zU13U1QT56qE8whnWwjWxSfHlWPivV6jJ27b5J3/yMjDe1j0+8=
X-Received: by 2002:a25:bb4d:0:b0:dcd:1436:a4ce with SMTP id
 b13-20020a25bb4d000000b00dcd1436a4cemr2189370ybk.23.1713541722765; Fri, 19
 Apr 2024 08:48:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024041908-ethically-floss-e1ea@gregkh>
In-Reply-To: <2024041908-ethically-floss-e1ea@gregkh>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Fri, 19 Apr 2024 17:48:30 +0200
X-Gmail-Original-Message-ID: <CAHmME9ryqt=HRtxWCs+WQpu7L5Q6qFXv40C1-oWtKNv=4C1-UA@mail.gmail.com>
Message-ID: <CAHmME9ryqt=HRtxWCs+WQpu7L5Q6qFXv40C1-oWtKNv=4C1-UA@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] random: handle creditable entropy from
 atomic process context" failed to apply to 4.19-stable tree
To: gregkh@linuxfoundation.org
Cc: guoyong.wang@mediatek.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

4.19 doesn't have f5bda35fba615ace70a656d4700423fa6c9bebee because of
66f1abda14a6789348cb9f5f676ae59e2de78ebd and so we don't need to
backport e871abcda3b67d0820b4182ebe93435624e9c6a4 to it. So nothing to
be done here.

