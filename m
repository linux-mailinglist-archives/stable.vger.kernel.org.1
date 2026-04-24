Return-Path: <stable+bounces-240582-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACRTBm8s62mBJgAAu9opvQ
	(envelope-from <stable+bounces-240582-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 10:40:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A920D45B9CD
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 10:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 13AF130041CC
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 08:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8338E3382CF;
	Fri, 24 Apr 2026 08:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4oyZIHQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C0732A3E5
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 08:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777020012; cv=pass; b=HyqHOYvXLZJxlFQLOTTqxSgaZ4tdyODvRsFQDR6FdxuH60f9Xk05gHdfxo3aA95v9GULNaL6OgpHchAztwiYOkBw+hK5iJtSSgZqb2uvaxQdn3ToJ6xbxG5sANAj9o0lTi2qDlyXYpJR88N4+eygQ9Y/OhruQKssxF724vToeaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777020012; c=relaxed/simple;
	bh=/mC/BKf4U0WKouYblH6lfeusp03jlYNiQI5+z450qX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HcPIOM+xYo1V8c5nMSSyhPTbxYDYn8dBCh3ki0DkedLo4YslDmXq0a6wToBaPXUrEKWqZvnZ0gB+3gO0thDukDpKIo6ydWa5ZHkAatN8oUw0oKTahMQ5O66IxY8sV9Uam8bQoB6nc5MsQ26QY4f6tO4J5r5nGZQwmqWHK9hZ6oM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4oyZIHQ; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-656d749109cso120551d50.3
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 01:40:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777020010; cv=none;
        d=google.com; s=arc-20240605;
        b=UpkmHDXNK29B16DwqAVHN04PO03ybEpJvAHQDdIyqUVlBuU4WrZxH9KIxPPLUMSIRw
         +qNxuxT8RZmbJBfveZJEVyFlzai3SF4m8DQt1aD9ndub2lHPeJZdXca5PsEi8aBLq1Ev
         34CiZb4YEFlhS32jWuSJ3pTwsVx63VjKBTa66CdxS5UqKWdCaJbwBYGAzU3wI1V6DhJv
         u0v/FLxs1/gdfXkL49lPObwpXBaD934kLudg5EXSRB6Apnd9+RhLyF6OariYdjUtZCza
         ojL93VGDam1Yxp8FztICVH9EDypUvxNHqpMyuI66hnPw4fmoymFuX1TpbVo5mTDrXbb1
         2qJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pfHoZ4lC3CFT1FUdlitdtuMFVlsY39ZT/pcG3ClOG+w=;
        fh=ugYTUflxur0o1txYDfxyTZCz1DMX4Mft8s4ugP5XJcA=;
        b=KSnNlxD0Qk5bU2p2oHt2OTZESWmVfFSR4BqzNlqqCrnKn686oLDInb7xdRQWgtMW6w
         1aTRO76W1dEX5+0y2nFDUMzqe+JNtrZI4AbMdSXRwqQZGEi20OkonRxMcn+wmhQ0KPXX
         QlzTeSWZ8i/uoI+zI9O2TaJSiqPkGZa6ZGoh5ivNiHDsbW8kQCxR41qLMl5HuvfZaSTD
         ldj79s9jw39ya2iMZA3E6jiRSXBBoN6o5TW0CB4joB8ML+Y+mkUk26Zwtso8SgGNcLYP
         OBtCNvysxOe5Iq/x+rUyvQgquf0OZuAiJAlIZnmIcZDQRQPLN1MyjwAvZbeqqHH5ZfYj
         g3ww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777020010; x=1777624810; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pfHoZ4lC3CFT1FUdlitdtuMFVlsY39ZT/pcG3ClOG+w=;
        b=i4oyZIHQlegK6VmR/KMTbPSm8NKaeVAqHSTcmhhBLVaRGBFvR8XbUJ3Q8LRgE8GTTX
         S6kFJFf9UIB0M1xj/4SRRB2npv03JX9zoOAsmlJLLgJ8wKJDe5EW7BAaaIdgDvXeutAl
         GyNhyV39zcf5/8yttoOKGy0WYdUdARP1nJeJSum3UflH9hY8jygHpJjnXV2JDEFPbmbZ
         8yJPo5VvT5HqMW6Hjy6UlrUPM5DOqlD7C1Z4pWYiywmErgAfQfLzNNmGy1f0DN293AH4
         0G7yU9+QIlLM2lYI3Oz6sUv2X4inbkKJMYL+q8KGPu4+Vh5SNKQmIFff24qrHRLXDb6B
         MWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777020010; x=1777624810;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfHoZ4lC3CFT1FUdlitdtuMFVlsY39ZT/pcG3ClOG+w=;
        b=ZD02sdHDoLo3lk45Vqus6Td8evXDwi3pxo7vXZHxrfKZ1jYS9BSk54KPlFKO5MiK2K
         3qMaoomMGc/XFcrBsSzul//NxUIOejzU5saLl/zRqo48QeVo/2Oqr0iagaGa/Q/+eFSa
         bkesO6thLRPEoEfMbSjo5ATr3k/mLleD5qWPjiFzFGBacZPjxQHpDXdRW/pI2IQHo9zf
         t1kt2wArmTiRJMXVsG6NUaUvCMffa9e05dtqgwOIotCnntNEAZ4dRFnBIftmogK8fd/X
         f9o1TIhn454AFrtPHLd0XV7XcrsZo3wyMQXztbeRYfi4cm2sl0WBeppf4L9x4y6zifZX
         hxmA==
X-Forwarded-Encrypted: i=1; AFNElJ+rHF73T92i94gN1Ls00EiFYQPI9iCZZHIGg40dkZKywz2GytehLP3/YYPvC+BWWY/wcHy01No=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy03Iky35YiF7KjI1QEtYPpJsz8LC9/dJTN6OiaiDYFwux4gRtK
	TZ0rR5gtDBYsq1eJRteeGYjvN0+PZLNPUGpNGStavy64qdqn9+Po5/k5p27S7ib91wH0IhDS7ho
	sj+aLM5gDObhCr6YlnQOIo5btEZ//QPI=
X-Gm-Gg: AeBDiev1EsLcxde+GNEOEkz2E8H5kjVECNtSC7hnA9uHCnQcAiXqMpAaJx7tn4Wo9Yl
	eu7hkluQ4s3BuoyBB4cYPo1Qz0XO8oF09MrcmzdgaHOiapsvu7MjLsND7TH+01xSC2Iu1bDN9GY
	AxexBdnF2eMK6W1IPuak3+zuUhn564fxf3f4zv4UkxIdqDkWJ7yJRTu1Uk8jNzSl+776h1schsb
	Khf5zPkOrCtOWe6CHYdpaLdGh5XZ2cPSUrflguq2dYjzfEfMzdB7VCuqnqNCh9ERuR6cmSqLx7e
	6jE0feI1UN2VeJxSUJ/z
X-Received: by 2002:a05:690e:58f:b0:651:b728:6f49 with SMTP id
 956f58d0204a3-65310a86b81mr21805806d50.49.1777020010283; Fri, 24 Apr 2026
 01:40:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415181228.3691185-1-lgs201920130244@gmail.com> <c22d8c63-e13b-4346-9607-3967d7b89de1@sirena.org.uk>
In-Reply-To: <c22d8c63-e13b-4346-9607-3967d7b89de1@sirena.org.uk>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Fri, 24 Apr 2026 16:39:56 +0800
X-Gm-Features: AQROBzBZW6huaLd6jq9fWuZQWFrlq7JWUs_MooWGapepzRAyPOMLPodTCCYqfh0
Message-ID: <CANUHTR_08qZ2ojoiKDT8LXeZ3JwC=9QHmaOvXOCGHiw5PqYkJw@mail.gmail.com>
Subject: Re: [PATCH] regulator: wm8400: fix reference leak on failed device registration
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, patches@opensource.cirrus.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: A920D45B9CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240582-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,opensource.cirrus.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Hi Mark,

Thanks for the review and clarification.

On Tue, 21 Apr 2026 at 01:38, Mark Brown <broonie@kernel.org> wrote:
>
> Note that the device is embedded in wm8400 so we don't want to free it,
> and we don't have a release() callback anyway.  The whole lifecycle is
> messed up here, the subdevices should probably be dynamically allocated.

You are right. The platform_device is embedded in struct wm8400 and does
not have a release callback, so calling platform_device_put() on the
platform_device_register() failure path is not appropriate here.

Please disregard this patch. I will drop it. As you said, the lifecycle
is more fundamentally wrong here and would need a different fix, such as
using dynamically allocated subdevices, rather than adding
platform_device_put() in this path.

Sorry for the noise.

Best regards,
Guangshuo Li

