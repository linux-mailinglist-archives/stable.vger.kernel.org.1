Return-Path: <stable+bounces-249025-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHSLJC7ACGrh3gMAu9opvQ
	(envelope-from <stable+bounces-249025-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 21:06:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D016155D721
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 21:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3293E3005166
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 19:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA2336212C;
	Sat, 16 May 2026 19:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="c8r9nwQD"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E3F34D929
	for <stable@vger.kernel.org>; Sat, 16 May 2026 19:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778958361; cv=none; b=E0W4mAn9PGv2BTpTXGhZiy7EQTpXNm+TOQm6e+caRyBiCK/R2t20Qily0VfnofNOJG5NTWA+VvJc+1SZWe0eaJIhbD8VxVv1naChssDrm2IaQn+Cmin3TkDdMWhnmyYFQVCDTg0AI3BMku14VStIhL3Mt3LDJmLovia1Gof3yuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778958361; c=relaxed/simple;
	bh=H1v8hiSujTN0uZjS5kUmvN1xFFGnrx/aq0tiUpBHd+E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IPCYLgW1Oz7sWF5m+DuJWryT7Hwc63a1KE/1LlULURBqGeFJh8wkFz9OlUVMXoAuSISwDZ/11HkAJOOfTSseowD0FxbmMWO6aWdoFppVsI0VNQAGJIGEku4tAI93RNkY3G0WF5YTc5CgYwepxChGLD0qjUfBugbJL2febn5dPqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=c8r9nwQD; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7dcd689829eso908435a34.3
        for <stable@vger.kernel.org>; Sat, 16 May 2026 12:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778958359; x=1779563159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hCg2nDoT/7KdIN0atTPHQrr5FV6YL1prt6+sWTXtM4k=;
        b=c8r9nwQDTiOG4uQyA3n+lzE0498l5BKs1IgbkodvZqOJ+ZTxLuDzx3V5PArYBeqb/c
         pFj3njBWBgNRg5kLHWNtwkE4qOzvr9rdi+IoU6utP9na2EMOmeYfd3r0xTtbSPfnA62R
         wWs3SLl7LzKZo/VtMmlThWOkkQABzBnpfnxdssvNFXONlrJnMz8cS5IX5YgSy2o/Pxsu
         yi5fqSxrOc1MCI21rFnNvt0QfHGpEmxUQswL+mNfpUP6/JU5CtZj56c1fNQz/DEaRdQs
         joiyShctqBBCgLcC5ReMF8O1Q7ULdzVQi1vC2HwWTvSocg5oqQ3LAC0AlX+Fl+jkc39/
         JOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778958359; x=1779563159;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hCg2nDoT/7KdIN0atTPHQrr5FV6YL1prt6+sWTXtM4k=;
        b=laYg3aitskmwdv2DMGfQQy1+gC2jkE3kAK4tSW9TOH9hpt/Su/aatAIUftr6s9+1n/
         xvI8h0tmP9xXA073oZCdNMfQBxAKH0lIB5bQbgMIK90yBzVNX3ckirBHhO1ujqdOf+eL
         Fp+Cu5x7Thz/fm773qLtUoP5hKxrb0jNnTXQu9u0FZVIzT79+E3Gjoh25ZJx6kTeW53L
         Uy2PT+wshRpc+GCX1cwwUBxjBoOj0goDb11IpP9j2QUtfkFxJKrEi3sD2ktG/Je9V6Aa
         k4214kmulr53PmTEmmFyAcBWmgiXT1ewH3Meh0AT0kjdnJgK3bPre4aOorEWQMeEb3zS
         XMFw==
X-Forwarded-Encrypted: i=1; AFNElJ8vOCRIY930FsOTryCJa/cTK+bI8p+rCggcz1FGoCQIXb3myJVt4EMkBsyJ8iLY+4Fdknwj8o4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHLtD1/jnWWn2sjz+XznVhewdkHd1NEmB14d1vozXv/dmw/8nX
	WrGGNapi51plf+0ACHFPKWegptN6M0GnPV8/Lb9lrwRW/aN/EbvV3YKRL2JbfMEbfAo=
X-Gm-Gg: Acq92OHlTVMzw6UHZ4MuMFtUGaHvKP56UwmQ4orSvIXpmIG6faqAav+dKwCx4fByBMp
	Ww4cVTfs6aDS2OBxFKXF45V3ZOvCBLgYUiTegjEep3lZ8p6+8aMdkyxjHpvGb1fe3OpQggPc8LS
	UCCqTMXQ2IYP3MLUi5sOyXbIij6e5k3Ld75pxv2E3gmHfBQAfozdebtl703fZ3zeG3I3MAeygP/
	Qyq62sr84KTMjcYy5RH2Tx2nrM3YLxSn6I2FTuMkxVT2HNDJHx/P1mbDO3E/67zvFM9Yr5an7eW
	P8KzLmSUJVKXfv+yQOx8Tic4sJrNfvUNIUuYnLK04frdAt12RvNP/HnaAaLniD2MvBMGo1MsfiR
	w6JB8QZ73y7O2Vo7svFOkkdfvTkn1BX9SJOHi2FjdWFno5z3owxjulJx4UBRhPHTd2EOf0eiCg4
	31jMv30VwzZzEkCR936sbU1/5qt1wOZS4KpL0N5ZiYznZeX6etyth8aeSLdmgXkkM8sihQnNZkS
	1ui
X-Received: by 2002:a05:6830:6f48:b0:7d7:d60e:650a with SMTP id 46e09a7af769-7e4fa054ce1mr6867691a34.23.1778958359453;
        Sat, 16 May 2026 12:05:59 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e55bbd08ccsm4023092a34.17.2026.05.16.12.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 12:05:58 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, Heechan Kang <gganji11@naver.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260516184709.852814-1-gganji11@naver.com>
References: <20260516184709.852814-1-gganji11@naver.com>
Subject: Re: [PATCH v2] io_uring/waitid: clear waitid info before copying
 it to userspace
Message-Id: <177895835836.925638.10996898303585193992.b4-ty@b4>
Date: Sat, 16 May 2026 13:05:58 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-Rspamd-Queue-Id: D016155D721
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,naver.com];
	TAGGED_FROM(0.00)[bounces-249025-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,kernel-dk.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action


On Sun, 17 May 2026 03:47:09 +0900, Heechan Kang wrote:
> IORING_OP_WAITID stores its result fields in struct io_waitid::info and
> later copies them to userspace siginfo. The prep path initializes the
> request arguments, but it does not initialize info itself.
> 
> If the wait operation completes without reporting a child event, the common
> wait code can return without writing wo_info. In that case io_waitid_finish()
> still copies iw->info to userspace, exposing stale bytes from the reused
> io_kiocb command storage.
> 
> [...]

Applied, thanks!

[1/1] io_uring/waitid: clear waitid info before copying it to userspace
      commit: 93d93f5f8da791e98159795c6ef683f45bd95d13

Best regards,
-- 
Jens Axboe




