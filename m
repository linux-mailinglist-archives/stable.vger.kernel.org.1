Return-Path: <stable+bounces-254396-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UC6qDlLMFWq6bwcAu9opvQ
	(envelope-from <stable+bounces-254396-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 18:37:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A76145D9D10
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 18:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 643603002E4F
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 16:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5773C9EDD;
	Tue, 26 May 2026 16:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="jK8Fy/jy"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43AC3C6A43
	for <stable@vger.kernel.org>; Tue, 26 May 2026 16:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779813425; cv=none; b=kQtRKAbxXLo64oc9xzMdHGXCRe6laQ1kjToRGSkIKFSlyCzgrA8W7bEmG0Wy596ZCSmZ8HAPQ4CWBtbuo2aAd6VLsPa9hBb44ExcQ/uNVbra0SWePW3lWdfJSPQeADCMDuU118o7xWAcWf/X0y4yfjwj1VJXJQKTajH+oJRkR0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779813425; c=relaxed/simple;
	bh=/GO3LeLy3wKpnITAQTk1hnrHhz5bef2/BRgq4MASNl4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BJ0vPczWTrZDEShF1TAPh14K4/4AJfgRzBgb7kcDK5XmtdRAAbLXUt0FGcHdAedwt5ubLPTCh8Lub06Okwi+4aqkIAiwxOvpWntdkqoF+XB1lPEp2OJUKdYW5QIZFyWapeT8iWrNqmHhyj+ytDWUntLvnXoW8k81bHJydxsvX0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=jK8Fy/jy; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7e612d0693eso3192340a34.3
        for <stable@vger.kernel.org>; Tue, 26 May 2026 09:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779813423; x=1780418223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7pfyyoGQMu4WrjFiMzIODi4ZGH4tu1162Cj6NAkVLc=;
        b=jK8Fy/jyUnzS49pxgSdZ8X9lpQrw/+/L8hdngVx/hvxZXPwqfPBOkAG6L55I8aHDIw
         zKunQHdGSiZ0lPPEhzHf8brI8K00BXAFQPRd3uXwooU5b2+kPbBgLr+4uNS3oGHjQGhf
         Rmvecgn2h77BGa0pBKVhzvDVWYTy142hub4VkMWgPD/FU3ErZsBP06tbEbC/hPwsqu92
         3b7UKytUCO//2Yhxi/K7IW6gwugcSzl4kU3Xnj36j1Z+DxzG+SfNxyWsHs44hKc1BxPZ
         YclRuOtWmH427dC7wniovX8R4AGz+/GbPecPQnZtyEPgDlwlG+70GlgWHZ+uVPYctGYW
         xAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779813423; x=1780418223;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b7pfyyoGQMu4WrjFiMzIODi4ZGH4tu1162Cj6NAkVLc=;
        b=OIJTUBmTd1E8s0AM2sccR7mR+KnQqnUh7fincE4KLcVEFJ7Aqb1DLtOwKeEglMA3NM
         4DVDgQ+wpm5AMEtOzv5bOYfxG3Rm13u16u9iHwE8nc6SqwtPKhsiJaFh0zAet2tcDxgI
         I+ydfAbxEC06oxzYdqj6MhMHUaqZ1guxm5DWbusT0phZdjz9HOOviNwdfoR6wMfVQ7p8
         A6XRIuHqN3fC3Y8n82llPv6ZuD1th4kUdtoWloziz6JYdeBo+WvfmnLPPwn/NUUZTS4a
         h6JsxaD257T8RpP2okvA0LdoHDfl77hj7Ckm6l+SMN3tgRNCxtPslP36CFSdNsXTN055
         WXRQ==
X-Forwarded-Encrypted: i=1; AFNElJ98xZB6mN3xxyGPTn03G1/aYcDaZP4BAxNKhU5ofZNOkNt4ANQeiInnqST7aw4qUDhoS6Mw0Kw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5RAK3g0d2y/lnDp6TPfQ/M3X2KyxMlDBCSgQYnttp2irc70oi
	9X1+LpaeHLcYJs+QXpaVDVPXUB8RHSoDjjGeH92cuZQJpr7mPGEJoWVMgFo4v+E5Z60=
X-Gm-Gg: Acq92OGZQ/5mqn3cgAhUffXN+wAYYejpwBrP4kR+yGpNS+zNviMwLwIP7yV+M5edIJj
	xLkrp2zh6lhAh3V92bewka6P7tjvQgCIaOtJmgwMSnXdqbBV6/AhXnMrYRajwD1+4fgnRtX4Xfx
	oNG5MU1BNbMzlSBZwFU1Vi9B+/fvbGoDs/U5R5InwbRno9dk8rSpKl+YYoLkJ/4I+MztE5HkRUY
	8iH0D6v1kHRO1WRVWk6pFrVvg2E3UTuJnbah4NlCSMwg1n8GIJLJK7QhDQb1n2fI0yB04C932Vs
	LUWnnu9xlWVergeZvfSRFGRK9jctU6vhpSKLl+6TBAFBFJ+wes7bqS4KUHo2tTwcoBym/iwPhTM
	x15JeC+oan91Rrro0+RYeN0Z4L4lx0d/hidGRlcmIvnWaeZj4nmmjKmJFSqfpk3hVEksQR4TUaK
	UA3B1k1v/zNrq2PdIHhmGoGPkG7qoobHxfBRow0ZqDLN+XpdeW7fQR5WLzjuYJO7P5PXaOFUpnv
	XgM22MlP4FXjA==
X-Received: by 2002:a05:6820:215:b0:69d:9be6:860e with SMTP id 006d021491bc7-69d9be68ef9mr7011333eaf.43.1779813422691;
        Tue, 26 May 2026 09:37:02 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b639fd7adsm13561265fac.14.2026.05.26.09.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 09:37:01 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260526103722.2287587-1-vulab@iscas.ac.cn>
References: <20260526103722.2287587-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] block: blk-mq: fix ws_active refcount leak in
 blk_mq_mark_tag_wait()
Message-Id: <177981342076.464267.17950379735757813338.b4-ty@b4>
Date: Tue, 26 May 2026 10:37:00 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	TAGGED_FROM(0.00)[bounces-254396-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A76145D9D10
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Tue, 26 May 2026 10:37:22 +0000, Wentao Liang wrote:
> blk_mq_mark_tag_wait() calls sbitmap_queue_get() which increments
> sbq->ws_active. On the error path where the waitqueue_active() check
> fails and the function returns early, sbq->ws_active is not decremented,
> leaking the reference.
> 
> Fix this by calling sbitmap_queue_clear() to properly release the
> ws_active reference before returning on the error path.
> 
> [...]

Applied, thanks!

[1/1] block: blk-mq: fix ws_active refcount leak in blk_mq_mark_tag_wait()
      commit: 94028f339610f5d39d101449dc27156aea03b3cb

Best regards,
-- 
Jens Axboe




