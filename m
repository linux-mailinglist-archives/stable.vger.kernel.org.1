Return-Path: <stable+bounces-222467-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CM87C4M9pGlnawUAu9opvQ
	(envelope-from <stable+bounces-222467-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 14:22:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3061CFE82
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 14:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8AE530157EF
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 13:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45693329C78;
	Sun,  1 Mar 2026 13:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="GIylNq9T"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCAA32720C
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 13:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772371327; cv=none; b=O6pojc/b13Pjp9PnHEI3gs0Vn/XEWihudz2pi+ADwVgfKaKy88iwhX9Gx0k26F+uepcfYZJAY2htmrRjQBBjCqmAoSdPdiBt1PPbG1IHAf2LQcGPwayNYLyXVIcontch3r1FnggiuSZQoPaSh2XPpREiv1KjRURu9GMTxBNoLNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772371327; c=relaxed/simple;
	bh=FCQqRKpNjxREaNjutROETudC10EPHFF83+6ysUYQSrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mlAiweQ9xiX6Gs7qS2s1IIKooaK3mGVme4VRvup3OeZOk4viG+FUBSWqsXY+GdIayKJOJ5ZozoIvR0ueugyG8uqX7He/xJyUkSwLoXwj1Yu5sgmsA6Rcmama9MFeS9WKmM5f5dsXO5zpcXkair66dbKaSEA0GZP5JgWvQu7CH9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=GIylNq9T; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d18f80b5c2so2141478a34.3
        for <stable@vger.kernel.org>; Sun, 01 Mar 2026 05:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1772371324; x=1772976124; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=scD8xisebXHg855oMh9WMcJSBqt9Q8TIw/LF4qdPN3A=;
        b=GIylNq9TTtSIlJJCOoc91Myv4JXFHoaUyhf9ECt6EYCShU1WttQ2UOuamk8k3fZ3lP
         lKv6UzX8yJYfO0le5CFfmsPadqUw7wWWxkdJqc1A+o+9rT7B9Uib8pn1NjZjoN+kvHW3
         9W0XGnzs8IXafABWRS1HpG0D8fsyPnPABbtpNTA8gBWM32eNm+sbOIzHIB0MASn9sgdI
         a2Fv/ULrNagDofqXBuwE+TXO66hkkJrbnoq0kbGaGd2qZaR59QMQkVwETdRA6+qB/Gkl
         Mj6GcOEcYxj4xKnJ/wp6+Ok+MH7FnsGdKxGbkpkO9akPJMJ9jDKUJ9RxoKO4jwbuu4PK
         nYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772371324; x=1772976124;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=scD8xisebXHg855oMh9WMcJSBqt9Q8TIw/LF4qdPN3A=;
        b=b5IWoR7LAvfcf14Rb322A/fEr0nuNjLoak1iD1c+XKldHrmmY8KA59qztR/p2/xAKc
         LWK4sEsYLeXiefiaXduTboW3kL3Nstfdyop8VwTF/MlLSpgh9EcGslTM/Cqvd25p18Pc
         0QwPDYlw/b/CfQojrGNMaqhyFgvhl9elBzcYx3jdqfBNlKIq69sQ92EOwQCT7h4CnPkB
         iabUz0eVCi7VQTQLC2E882UNmSYtactOkzXEUWbnjk6AbAPhirNC8gmQLAq3GvB/jDwA
         sXxWoR0IEUNAz/oLUI3QRi35A5dwVziyQnThfos5Jpfyhl23z1Z5WdTIt9D5F/hGQIuI
         0vQw==
X-Forwarded-Encrypted: i=1; AJvYcCWcctEiX6T6lEUI28PAhtknDhoeAVGAP50DEJU980wr/30lgPO6Xsd02YYzExgxaX3Sd9m0ykw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8JjdfBtRQfzNdalCZHPFCw94QdMga86xlUOiimv8yM16+VGIj
	wq5znsVhpLz90H8we0F7SdvWiwIKmTt9Bsi9BGWUOg8NOXwm0dW/SR+ZL/CTTffvjPE=
X-Gm-Gg: ATEYQzwI9ZMgU557TX2OeRSoZvMbTzBJUuuzXCfU1un3q8nXWoln/210Y15lEybg2eF
	vvkoCmrnSADdZQwFIlBX/OQaCo6rn3ccJ3N2JeKQFuaGI56dj19rfC+9R7OF2vP0epT0pgHoMEb
	U2iL11NBKqgj/AaXmkL/qM57D0XlAapvY1cGhiyOpqNVzDov1a/z4o3Eq5UPE7e4O0OyAH7DeYN
	cLQn9QCkLQ8KfTLr/9goKp3SXxc0483zozzwk+c2w8TWE5402LOz3Eihp4iudfGYucWW0ZECUm8
	twOCOS8YjDcmOn3AysRcYcyHiSz17dH6aOYzo1uhr6aAlapz1ddLYai2m9BZ5ZZsmSt6KAWsdz5
	mS7Uubu0DZMQn6nBJmbdbqmzGS1BqkX6wuw2dA/5IVJ6uO4qF96RnaCVDVsvz9QTJrj6JBQDj1n
	x/vuf8/4neY7KRWI4iuj6KB93GU5T/Gyhj2CF3D5Fo4mCka0c4oWStJeTrmTKKQBPid7ZQzmLoM
	mX55M8D6Q==
X-Received: by 2002:a05:6870:168f:b0:375:270b:ea56 with SMTP id 586e51a60fabf-416271049e6mr5162094fac.42.1772371324249;
        Sun, 01 Mar 2026 05:22:04 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160d2cf00fsm9236538fac.20.2026.03.01.05.22.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2026 05:22:03 -0800 (PST)
Message-ID: <002c2bb8-3304-40e0-b8c6-8eee7dcb7710@kernel.dk>
Date: Sun, 1 Mar 2026 06:22:02 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: Patch "io_uring/zcrx: fix post open error handling"
 failed to apply to 6.18-stable tree
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
 asml.silence@gmail.com
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org
References: <20260301011746.1671806-1-sashal@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260301011746.1671806-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222467-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	FREEMAIL_TO(0.00)[kernel.org,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kernel-dk.20230601.gappssmtp.com:dkim,kernel.dk:mid]
X-Rspamd-Queue-Id: BB3061CFE82
X-Rspamd-Action: no action

On 2/28/26 6:17 PM, Sasha Levin wrote:
> The patch below does not apply to the 6.18-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Looks like this has dependencies on parts of this:

https://lore.kernel.org/io-uring/cover.1763029704.git.asml.silence@gmail.com/

series. But seems easier to just do a variant for the 6.18 base,
I'll leave that to Pavel.

-- 
Jens Axboe


