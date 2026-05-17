Return-Path: <stable+bounces-249122-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAThFHP4CWrivgQAu9opvQ
	(envelope-from <stable+bounces-249122-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 19:18:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E658B56275E
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 19:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C725A300A4C6
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 17:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527333C457C;
	Sun, 17 May 2026 17:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZT8YHCl"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7063C4B81
	for <stable@vger.kernel.org>; Sun, 17 May 2026 17:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779038321; cv=none; b=F2sJ85wD7SuD6+pO6pXDm5paWiuzYYdjiuEUEW7DZwKXqTYMG7trCuowi6t/KwMn/joQJ6M7R9NRSZNGQ8QHEgDi00iLGPw/d9hvp0tN6rSdDJ/JjFx7hfpniJbDbdZ11rTw6yA2KXQqdg31hxSC3NjW4BFkBbwbpiZD0GXf8PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779038321; c=relaxed/simple;
	bh=sC7gGKV7ozm/WzcKRL8dyf5wyvuKoJ9tCvD0h0m34KA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iWMszXM7IL96tglA1DHpPSjeVEFbnVHrEM50NFKQPuN3/d+3IBzecYuzefRVM3430BwTgRyobos7/3cH9lmcH2zlReDkwAfyEPoRwLJChH6A82kknA2ux6rkUsUoF1o6x8L8wN3zcawVI5OOLl2gQ12vShbD6gQEIeGMAWcePsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZT8YHCl; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48fde653997so1831815e9.2
        for <stable@vger.kernel.org>; Sun, 17 May 2026 10:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779038317; x=1779643117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sC7gGKV7ozm/WzcKRL8dyf5wyvuKoJ9tCvD0h0m34KA=;
        b=eZT8YHCl9SLDA7CfoQ6j3M+c1Iaflh/BAv+/Wc/EriQzKp0bUCe5CfdCgitKl7GXxa
         t1+UrR/KdIX0YNfijHS+RMhpVMolS1AUmCFUn4EnkBvDqUVvTP0k+lAI9u4z6OKRZ2bM
         gL/A//PLT2/M/x6iFszzmehWSpGrmmk/2fT8nWIVR2ncwwabFF2sUfHhyYUIqnLwHLTR
         REaKLSfVn4GM5/z6F+m0VJRV8Ds6+E4hGQOoKtwxL4yCWWLMfWw7SzgGK6cIb/0EI0Ao
         dkp6TLBmMm3OOgW2Tyk+obOGXdlOhSsmBM7tPKrlEO4uDLnoPETFieqOHPTauMbtefWF
         VlpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779038317; x=1779643117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sC7gGKV7ozm/WzcKRL8dyf5wyvuKoJ9tCvD0h0m34KA=;
        b=apRH+3pvtQ4UtDy4Df6sNxau2lDirA4X7f04Wp0LW7DU9qQNa95WuLsRXzbUMuHH9h
         6Bka2r14QdQh7VCAdyqCWHqr03E9nuJC3eahaTy95CJ3udNTND/AFE1FOTBjFSt4k2U4
         92dUyJk/kLLf2tGrznuEBE3c0JLzMJbMt87x6btqDsXqK0npthncOJJP8pEThcxMPd6v
         1LmEUw/+7siOXxF+6bUEAft6SYS/vufIELdTlLmRpvxAW4e6KKD2hbxFzzYL9aYJk+fv
         MnBlRPtaA3Gfny+5aUWqsXMhN1HW1weO+B++8OweeZ0RwQc4DMK//UMu6r6GFkHaxjYc
         VC5g==
X-Forwarded-Encrypted: i=1; AFNElJ/FjaCdelYnAuLD3fw8f1x/Ae1bOp8REvaoLApJr6C9LRASoy95glkmRVHBbgvzQ9pdYEHlCDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuAi4MGqKkdhRQWlaEUJY9UHXS5RwkTOty9NxULfn2PAoxFF0/
	bhTCSoYtP+1G51yab2GXVztpvtgSfmxe3POrwbDRUIBKLLSmT10MQ1Ts
X-Gm-Gg: Acq92OFobOLjGF6xnOTKzQatox59EQ/aLSFZ3ieionHnhY3vIzGqVkCxMUG5AZnsX5x
	eFCRVxQWw0tfx0VzurYUZkgNVtGHkgMaPEIn9yV/misib2d4oDbQDYlPf+9DDILRITyxhZvyFuu
	aqTuVNP9Jtan85K5hr6jCWTsLHbtjQTG5OORvJE4JgChCud9hX/qd6JctK8yVSC6KQc7sdJNRba
	FfWuc+dXNTfuLTq8fdt/Pk8Jz+YK3NaPpFGsfYhY3BZ581dRggU4jZarIk94plNz9NoBB4fdar8
	4pB5BUWvsh0xCnY6NorsWp9ykeg5Srg8prSlKOAfAvoamt0kehpcaORsw/GyOwyiebz38nDPj/T
	MgrEgoTTa3a+9QRsEYRgxDYpKrM90RXmz6LWcGVH2BplRirly21THqHvZA7bQKMM4KY/1VW/7kM
	9ipzt+LAhz59B+Ru6iLehQbSgcaYa/ujtpvbwS8KJxIdy6
X-Received: by 2002:a05:600c:3b07:b0:48e:6db5:76e6 with SMTP id 5b1f17b1804b1-48fe63099c6mr95495075e9.2.1779038317040;
        Sun, 17 May 2026 10:18:37 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec3acf7sm30645659f8f.12.2026.05.17.10.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 10:18:36 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: dlechner@baylibre.com
Cc: mazziesaccount@gmail.com,
	jic23@kernel.org,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Stepan Ionichev <sozdayvek@gmail.com>
Subject: Re: [PATCH] iio: pressure: rohm-bm1390: notify trigger on all error paths
Date: Sun, 17 May 2026 22:18:24 +0500
Message-Id: <20260517171824.1845-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <54ee1fba-3209-4192-82c3-674a1ae3ca8f@baylibre.com>
References: <54ee1fba-3209-4192-82c3-674a1ae3ca8f@baylibre.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E658B56275E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,analog.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-249122-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sozdayvek@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sun, May 17, 2026, David Lechner wrote:
> IRQ_NONE means that the interrupt wasn't handled, so it won't be cleared
> and the handler will likely just run again immediately. So it probably
> isn't the right thing to be returning in the first place.

Right -- though here it is called via handle_nested_irq() from the
threaded pollfunc, so the return value does not feed the IRQ
controller and the immediate re-fire concern is moot in practice.
But the IRQ_NONE choice is still odd.

Matti, do you want a v2 that always returns IRQ_HANDLED on the
error paths instead, or keep the current shape and just fix the
missing notify_done()?

Stepan

