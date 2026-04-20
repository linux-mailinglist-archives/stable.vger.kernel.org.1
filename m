Return-Path: <stable+bounces-238724-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEERIenr5WnxpAEAu9opvQ
	(envelope-from <stable+bounces-238724-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 11:03:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1C94289C8
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 11:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 71BDA300A328
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 09:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15114378D85;
	Mon, 20 Apr 2026 09:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgiodse9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2AC2D738A
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 09:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776675812; cv=none; b=VDE49bBDtEZSt9Kf4r4b2mk5KEefigKgpBR5TIpUkBnv7AKIKJEy4XSA1IEGB2ha4el/RYhCSUOjXCmG3v0aLBBCxNh1hPs8kZQ8BYVPnyZytubPEGojOVcW9GergEkfOcJwf8ngKCDBUYFNotsRi7CDduMaE0PB6oCYSXn90q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776675812; c=relaxed/simple;
	bh=1tZrYGL2ukBRHqFAeIW8jryqk5p9P57CIGtRpN4KNcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R0AG4BD5LT/SRbOIYbNe5xl1b8tiq0PGik4gfIdYDZvKm0nRnlQDhLYKVXbX2zsjABrV0hImlD6O0Q+lq5uf5s6r/m157S3evlLejEHV+5hC1UeYJYDUrOIlmE9gwh5P8SQJ5hrr/HJwnT1C2fU7XjWMyIPosgs1E5i8GPZkrhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgiodse9; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35d99bae2ebso2651588a91.3
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 02:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776675811; x=1777280611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1tZrYGL2ukBRHqFAeIW8jryqk5p9P57CIGtRpN4KNcs=;
        b=mgiodse9w1+GOZP/6eOpvd9qDxsDpb2lYLfkuYEYMWJEIEQdFMxXRQMKOK5XqZjazx
         9ZsXBZnA8O22xoNOBjpzv0r48q3wMKQM3KoLj6QmeqHvksQ34LDb63jErKt1SFPAhczf
         H0BJL957gF7SWD/ed/Up52Wql/MP/1vp7g1gijEKXVS52JC+QiWLQ1WZzr9+9yp8F3Uh
         yZiDrtFE/m3nZRxgZojs5vjOUQPEx861CvpXVO92N9Y5NJhnLE7DWsQAxW5aaJBjSv2X
         mf/ayPh/rq9EcVqpMF8vHP0bBC+YtdqmzLVoBHJZyHViowRHIN5mt6Dsgbp2T56cHbHh
         rsOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776675811; x=1777280611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1tZrYGL2ukBRHqFAeIW8jryqk5p9P57CIGtRpN4KNcs=;
        b=WxhndWDIR5houKtowO/sxG2lEKK3LsrRF9LYtx8PLu4EHKmnIEY2sUE6qIYHs9All3
         19G5C3xaLYTdAOuKuNSBZr60FFVpnUtlGkTSfNyZAlNjWxmFVOwKXdFBc9LXWk8oOWu9
         /i9/oxNOMaT2tJI9BqAtU5wViTak4I2Jdh1ZLk+lvTmyWWsb5mWSJG3gJBiKN3rDH7j2
         9LdEH0LyiDy74VGYwsHHLK4ngT0sRBHlLpYQFLWzd3EeNqpagmpf6q02lyg9Hc4hFPTR
         SeZCDaqUAovMwMab6JU97IgcFukOk+6HyjrhXwVxvSbIl+Tx8rqJke1hH9UXljOWNvgG
         MsZg==
X-Forwarded-Encrypted: i=1; AFNElJ8HR6GfrrqCZpMyNRyhEfBrSei5mHMD9i//g1hOwOVyzcZbi3qyyrFgxPE5yPhextKoFD2LlGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhh7rTPetJdX8Jr6VUT0jdKfZL77M6NoUXF+9dfiP1iqGOf5vF
	Ffcv07aH1XsmzmctLK+DMU0eyNbyEljUa/cJ4NtA4MXc1s0LYpOJHje7
X-Gm-Gg: AeBDieuaJa6cxiW4Dn2bJ8Q7XR1YEHygwaRfplZDJykRFgS4WWOiaqkgyHQr7N968QE
	ijDdnzpztBTFW4nCODulSNKdOKufo2MhMGzftuLFNWQCoAHKQcWznzPXg/h5vdNBXfDX6y9dQ1D
	as6JZVHvkTy9gjY5tpiPfbaoTTTT/MoN6qf3M+qYqJVjEwu3TXCww/Tc8XWAO2fvLBR6XQx/qhl
	Gvg3Y+259lBMFfhkARR5a4ePdU5OCfDGvuWfOvojr8MvbHwx4lU7VxKnaL892qNh/1JWJkax7pQ
	3JAWNo8oYsKLi5FcqjShyScIchmurdGN+jP2XKQGbqaRYT4XQ4V4iXa5GfuouyoSQNbEAyg/lVK
	M+bRIy45uz6kLLla3JUH+YAKLZ7Uxhs7MvSDV9w5X8/G0aJM74+8mwsQejo8g/CkEpAnosLchrU
	wyDz7gdmwZWuD4ggg5mc6kcjeLhIFg86eVUX0PDlr0WA==
X-Received: by 2002:a17:902:cec8:b0:2b0:5b4e:370c with SMTP id d9443c01a7336-2b5f9f8b3ccmr140887735ad.32.1776675811168;
        Mon, 20 Apr 2026 02:03:31 -0700 (PDT)
Received: from 7c1ef1825668 ([115.245.213.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa1739fsm98861015ad.22.2026.04.20.02.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 02:03:30 -0700 (PDT)
From: Sanjaikumar V S <sanjaikumarvs@gmail.com>
To: pratyush@kernel.org
Cc: hd@os-cillation.de,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	miquel.raynal@bootlin.com,
	mwalle@kernel.org,
	richard@nod.at,
	sanjaikumar.vs@dicortech.com,
	sanjaikumarvs@gmail.com,
	stable@vger.kernel.org,
	tudor.ambarus@linaro.org,
	vigneshr@ti.com
Subject: Re: [PATCH v5] mtd: spi-nor: Fix SST AAI write mode opcode handling
Date: Mon, 20 Apr 2026 09:02:37 +0000
Message-ID: <20260420090237.21-1-sanjaikumarvs@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <40364d66-f8a2-4efb-a4d3-70f0aa3137e2@os-cillation.de>
References: <40364d66-f8a2-4efb-a4d3-70f0aa3137e2@os-cillation.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238724-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[os-cillation.de,vger.kernel.org,lists.infradead.org,bootlin.com,kernel.org,nod.at,dicortech.com,gmail.com,linaro.org,ti.com];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_NEQ_ENVFROM(0.00)[sanjaikumarvs@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2C1C94289C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Pratyush,

In v4 you suggested updating dirmap_info with the right opcodes. I went
with a different approach in v5 -- disabling dirmap for SST AAI devices
in sst_nor_late_init() instead. The reasoning is that updating
dirmap_info at runtime is problematic since AAI requires dynamic opcode
and address byte changes per write, and controllers may cache the
template at dirmap_create time.

Hendrik has tested this approach on his SST25VF032B.

Does this approach work for you, or would you prefer a different
direction?

Thanks,
Sanjaikumar

