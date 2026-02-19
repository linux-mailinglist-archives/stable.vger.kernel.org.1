Return-Path: <stable+bounces-217444-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCwRMbYql2nmvQIAu9opvQ
	(envelope-from <stable+bounces-217444-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 16:22:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2B6160116
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 16:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DCE513014416
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 15:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42D53446B6;
	Thu, 19 Feb 2026 15:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Ia5HaE6s"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30CB3033FD
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 15:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771514543; cv=none; b=OFGNUiLvSqXT/vjmdW+lFH6ZyaeG+XqatyJFAk70Ppb08wkz7QtjEd3m9fG9/SPwiEC9JlE2sUbPsIRJO0l+u4DB29b2LwHVrB0AZWZs+CP1T29in5GtsTgA99YVlGs+7thveiS3xLbXlIdV8zGLsEBUxEluR4LZPgqNpiRBtaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771514543; c=relaxed/simple;
	bh=YGmS0R4t4IPHMntYddopsqMYngP/3/s1j3SRdFIkReI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=H5qW61dh0wUI3CC5w6HOr17G6esGnSrvGW6jOI7PRo6j9sVopbhpjKxRnDnbjwwDMIGVjsd2Twwscf/cXuGo0juCBW+8XkyOtD/iwlqKQyXxI91/XB5Dq4ST5DwDlHwPESAN0BAwPwgfqRrtGyCRPqrhkIKWuWmU1WSmXca8ADE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Ia5HaE6s; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d18f80b5c2so989835a34.3
        for <stable@vger.kernel.org>; Thu, 19 Feb 2026 07:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1771514540; x=1772119340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEw6ziLtIMYeEr1+4vym/6HQDO9fW9fuHMCrppee5HU=;
        b=Ia5HaE6s4goo6to9cMFONc779dxVxMQ6QWSRpGXi62ZlW8BIg73+UbKHspJdOITkZu
         0DejH7MQK6ysKhxYC2JzNobkV+7S5iGlj1rnUCf0khscJpGau8efO72K5Ve9jFfxKcQX
         TbetjZqHMyjF7MC0sNIvIS6/nUoP0ip1dSL5qeSmQ83GeeO3ikyx6VrotzDA/AU/WmL8
         CZ+fDQqMuLS+a3Fu++MLvIrJaX3su1jZ0Y9TSseXoNh/XDRQZwqr2AvTt0DgV/lJ8ynm
         2kDyQyVdH4xtdGeIZy2GfiO7PXMskVIM+5sYgImAzhJduO48IRffxdZ670hKBA1XLkjU
         rkxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771514540; x=1772119340;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NEw6ziLtIMYeEr1+4vym/6HQDO9fW9fuHMCrppee5HU=;
        b=OoVYg809D4yWAxf+DSupAtMldsIQ5AgSS5nFNWhnjXQeQmhDCm3MdDF40Nk8mMViKO
         OxEdhgPhBn90fbWdvaktEATL9yUP+EOpeh/0N6cs0IidsgyLDmnyMtPN2qQBqDKAzg0T
         S7NxvNjCOk/8ppM01luzdV2r3gZBs+56dihR1egOE7r46W/9e6wY+WT51jhsCtHIH9BR
         n8tMaNmqsTh9xRMgUqrID13Y8cjYtJy7zwpoRbPLMdclXytiTVvIhOouGDLQHMNfGxHc
         cR9r8MAUXvIVbvPDN0QI7bCDPoHn3L/1WTIaCyKEG3ZYsnsJ7Y0ebV03BMGjYMH0Bsnl
         /YWw==
X-Forwarded-Encrypted: i=1; AJvYcCV2T2uV0gEIdwhXshAg/pYPcHiOeaK/OEJMMDInCznaWJ1GlEbtwvk1yeSnpZJaNetWE3LJm7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ8NPWSS6Z7iNb6jKrkDxxq3mZqHG2PMBK6kK+Te3RO2gAfwY5
	p0Ptsg2g/wZ/ejEhYwlxQDyWENWQ06bCEaFSqMkyC3UnUKLLpc7Lr1gHN/glQdwnfj0=
X-Gm-Gg: AZuq6aKxYct4s6+YGL9N3/oOuzMnVoV3Z3rDUR2vqJiJaITyZMsT4HC9iprgSqFEfl3
	yOv5HWxtgz0KM5dgNKIaZSfRjdQKiJWwcZ6vDWxatgZWH1OUNvlDBEFK1e6RZYsui+Azh3mhSdM
	7l7b08ZnKgEc44w9an4w8e+EZ5KBJGorjLvKYw9WZS31telsjcbGGnC5sGXzvzZ63pWvNNL3jr9
	nhj5iX2GVvmVZ31aPSWoTF9ddjBsgIHOtDG2eWCQ6IjcYG+Q3MWVsjTmhvPPz5i/R9AK6qxpFca
	tFuWbC/OezuikgRuTYpRlFv4cSL+S5wrkKB78/NamPg1DYS06ghut6pR0jyUpH9mvhrMEMPxosQ
	+qqPx8QRiHfVuj2BbxkgeXKpAKMkTbiP4aLEMI1qKafoemM9psWkjckGeGcr8Zpgk3NWDzwDaCH
	tJxBgNT9Vsx8e1Hs7iAu08b7YZqV0uoxL/e7NLlkCRvK2jmvJP4b5iZVu0+gM1PYxOTTfcrtXhA
	KF2eg==
X-Received: by 2002:a05:6820:151b:b0:679:a6d0:e99b with SMTP id 006d021491bc7-679aef36b53mr1781676eaf.70.1771514540481;
        Thu, 19 Feb 2026 07:22:20 -0800 (PST)
Received: from [127.0.0.1] ([187.199.77.89])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679aebf54f1sm1954014eaf.5.2026.02.19.07.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 07:22:19 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: =?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, 
 Lars Ellenberg <lars@linbit.com>, drbd-dev@lists.linbit.com, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Lars Ellenberg <lars.ellenberg@linbit.com>, stable@vger.kernel.org
In-Reply-To: <20260219142012.97756-1-christoph.boehmwalder@linbit.com>
References: <20260219142012.97756-1-christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH] drbd: fix "LOGIC BUG" in drbd_al_begin_io_nonblock()
Message-Id: <177151453921.556009.15485390943324050309.b4-ty@kernel.dk>
Date: Thu, 19 Feb 2026 08:22:19 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-217444-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel-dk.20230601.gappssmtp.com:dkim,kernel.dk:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3D2B6160116
X-Rspamd-Action: no action


On Thu, 19 Feb 2026 15:20:12 +0100, Christoph Böhmwalder wrote:
> Even though we check that we "should" be able to do lc_get_cumulative()
> while holding the device->al_lock spinlock, it may still fail,
> if some other code path decided to do lc_try_lock() with bad timing.
> 
> If that happened, we logged "LOGIC BUG for enr=...",
> but still did not return an error.
> 
> [...]

Applied, thanks!

[1/1] drbd: fix "LOGIC BUG" in drbd_al_begin_io_nonblock()
      commit: ab140365fb62c0bdab22b2f516aff563b2559e3b

Best regards,
-- 
Jens Axboe




