Return-Path: <stable+bounces-164272-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD65EB0E128
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 18:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EF373B7F09
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 16:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2B0277C81;
	Tue, 22 Jul 2025 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="xt3xVbJs"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68FFBA36
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 16:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753200160; cv=none; b=czvyoK274hAbVOcEpKEwu9YB/QtswsIsMJkuGlTK3jXjOi7bn5YsYRgiy9oLzdc0lJfXqHio1bdFKEVlg8LurzOPyxfC/Bg7CkWo8MvE4e9UvCNjRX0PEQUe4F75OGtiJ/AunOdjvkpfBM1LlYBvZ+ksyqeqF36CIbNAgZsTtow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753200160; c=relaxed/simple;
	bh=noCp+eXK33xOruhl37s/mqn60tBI6l0AIHoZYe0gMCk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lgA8cdJmDkdVRH6/b6AEelFQfITL1mgF2I6yA1yJAubFThckygcLzdI79HvCFnAgYMNMal/PSCTGj29N9mnvrO4Li3NyFPqSmTR0xdO3z/ZiNGxYlNtsm0diA3akfHUJHSv2Fbhqdk3G/By36Zx56meMA9jbsTvqxzMElHrwMi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=xt3xVbJs; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-875dd57d63bso1833139f.0
        for <stable@vger.kernel.org>; Tue, 22 Jul 2025 09:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1753200156; x=1753804956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBDUtHjG8WwK4Nzt7OVo+JKFrKxCJS3/depqRx3MmAo=;
        b=xt3xVbJsXEzkPhPitoRtfx5sqT2K6sM94IayNFRZvpJe538HdUludl83xXLiAiaPbI
         Y+DTlJBMwcLQrv3bHNIiwMNS0qnBgk7Xd4BH81HI3fOlhhkoeNfLRJDBCbljhjedtxi8
         ly6ura0OF04Jsc799gZ8ZEmzRJ6R8akr3Bl3v/czMOyA2Pf9n+NJb/5fzjXnYZ1Ko0Yj
         M/X9hccYU/7e/aJE3bFdYuJTL8E9g1XEAGGpBbl1isaykTzDpSH5ghfBGIv/bzK0QPph
         6+aXJgEOh4erjwbahzyOonudSopGu0r8fuz0ten8Yr/mnYl4pfhEJAGoTjq44+JG74jC
         tNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753200156; x=1753804956;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dBDUtHjG8WwK4Nzt7OVo+JKFrKxCJS3/depqRx3MmAo=;
        b=BNxa+/8uX7CM8w14rrzGBARGN83THeHpV+bCQXrHv7SeJ+MkK5+OBcZ8GSrtxkGamr
         5G3TPgEzv5SoTe2PewXMpreZ/lE4WmjXWEJ+BNc4lshY3LeNg8GN/EBE7BegqQpOaQU8
         UjfZVOqx/lxc71Km379tQ5lU8npZKAmU8qOM4HqwpIm57F1A/XUDblArtaybXa1ivRPq
         BhksWOzxL28sJiCTWy+njbpg2OAZwsxCCS1gU91474pTA5YLWXv+bzI0QC8g8OOx39Kh
         xRueu0bCM6gRR3uLwo97KfY7fKhpI1QiWwG3EWQFdnnTc4Sr+ob44JN07BGFQHAdbgCA
         mjCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbP43eCcMHjlKM+KbSOWFt9c0HnvpGzKxXjFbUuwxSxwtJ9u3QaTatNLydtHKzMivK1DBtSA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSIctQdLV+IrZsPNsLwwQr6jItgiL02euhXfhkvU+thncdDPV3
	WsuF++NClch5Fh2SDINeFeUoXUtad6Jow0F2t+Z0rXHHr41N2dEm7ECSvHVbBBXwx4Qz/bCyUPr
	jsKXv
X-Gm-Gg: ASbGncuSqU40eB6hr/qmtXcYwesbf7U9WMeaq8bKFWxS/0n/rZA6twgzn7BUnhGcTwQ
	J10BhjZLDH3py3YXvbrQOmIw7Ut2DdrVLPordlud1WcPyHg2aL/5evo8e9wTfNXAqcBL3zLcx65
	2+k0eV+hjxIPB0GodRFHTjIbrhmIHWI3jb/Nt6qa4js11N0qWLAfY22/yZZY45ypNfcmtJFh2tS
	pFdi4bSJUG7DUpMsWE6dk6GziufHrGvhahevoloEQ0fepOYtxCG9pxTsixvG2h8Z6zSTsCQkM1m
	g0kRFhRA8TxPPzCXkwBd0mq6J1RFFotfUw2KyzFcQpw5gARSdpwV3xK8Q+McfWGZUaUv71YcgnH
	FwcWm3q7UR/Qn
X-Google-Smtp-Source: AGHT+IGwFeinDrd1apvfPiLCe115kkPKtu21yo+ZtYpYX23SlO5YPHk6OgHUI5gPbzer2SUz6HNeAQ==
X-Received: by 2002:a05:6602:7417:b0:873:1e91:210e with SMTP id ca18e2360f4ac-87c538883bcmr676458339f.4.1753200151901;
        Tue, 22 Jul 2025 09:02:31 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5084ca62884sm2493638173.123.2025.07.22.09.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 09:02:31 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Jim.Quigley@oracle.com, davem@davemloft.net, sln@onemain.com, 
 alexandre.chartre@oracle.com, aaron.young@oracle.com, 
 Ma Ke <make24@iscas.ac.cn>
Cc: akpm@linux-foundation.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20250719075856.3447953-1-make24@iscas.ac.cn>
References: <20250719075856.3447953-1-make24@iscas.ac.cn>
Subject: Re: [PATCH v2] sunvdc: Balance device refcount in
 vdc_port_mpgroup_check
Message-Id: <175320015081.186214.5828107139805643955.b4-ty@kernel.dk>
Date: Tue, 22 Jul 2025 10:02:30 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Sat, 19 Jul 2025 15:58:56 +0800, Ma Ke wrote:
> Using device_find_child() to locate a probed virtual-device-port node
> causes a device refcount imbalance, as device_find_child() internally
> calls get_device() to increment the device’s reference count before
> returning its pointer. vdc_port_mpgroup_check() directly returns true
> upon finding a matching device without releasing the reference via
> put_device(). We should call put_device() to decrement refcount.
> 
> [...]

Applied, thanks!

[1/1] sunvdc: Balance device refcount in vdc_port_mpgroup_check
      commit: 63ce53724637e2e7ba51fe3a4f78351715049905

Best regards,
-- 
Jens Axboe




