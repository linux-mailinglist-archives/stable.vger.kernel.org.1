Return-Path: <stable+bounces-213299-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOYyNIo+gmmVQgMAu9opvQ
	(envelope-from <stable+bounces-213299-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 19:29:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A07DD96B
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 19:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85C9830F61CA
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 18:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534E13D331D;
	Tue,  3 Feb 2026 18:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElwPQe6s"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52E93D1CD1
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 18:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770142964; cv=pass; b=qpUFowhTjp92bQwqjuIZs/xRlIznnnMneOWT48t6l+IkhxR4PhbRnW5RHd9JSMHIxjhlaqg7iH/FesjxLNlbLZu3l27EnAlUxHWAlUGkKqwR3s91/2K4sjYNwTNHB/UOu5xEVewAYBqVcewZZiOiKPC5dG+mlDDRdhnzwiHE6yo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770142964; c=relaxed/simple;
	bh=72IAYlfThYiEG2aFjGCNshtysLaZbuOWDG3tEGy1mzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ndqm+w4FVwjTkzL7bZyv+P5xYQnEBscq3PuxWlgHfsApCDRZvMaxN0iVhbwrWrs1kDDSj68ILVMMS1UwKoAZBXbpTUAHr9a6niDoGZafOirfnaoOQW7mLTqzJL49YP3k6uxdp58luqkMfqVKg7cX5u0UuCCD7YSkkfBqiXohGgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ElwPQe6s; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-794c2db2ee5so33801937b3.2
        for <stable@vger.kernel.org>; Tue, 03 Feb 2026 10:22:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770142962; cv=none;
        d=google.com; s=arc-20240605;
        b=khvQrjR2D+NCWJ5QMBeF2bGZJ0xmzwe1VjmQNZKo27z19NC2KaSb/kwfsiZwRJZVkP
         fKu6BFdxvb0MdsBj47Y77TXSNHD5eV5v2CoIGMRCb90FB3nMZ/m+45uzdEHLdMtzm/5i
         EY3z0Z1++fiDV795hiXPTZaF9ifjqu2t5AjHMsCDaoKUoYg0IMsyEwpOA+5HOdEiQHhH
         GxI6SGv3vHseC7qs+bmQCha0/kAzwTvtVMF30eqTO9TljO/O7THDAqQq4Vln05eJ9ctg
         gaghPxP6AKlrkDrmU5pFJIhSYDhn1YF/WfHINouPuloMHfN0RvgrUMkdqDtgGXASjIs1
         c9cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=72IAYlfThYiEG2aFjGCNshtysLaZbuOWDG3tEGy1mzE=;
        fh=/d65KstiPZPgLt57LQHTKdjKz69OG63D6fxEz46XecI=;
        b=MR3vM9k2EcsQzvcalWP8KCBOTsT0YxEGSWuf95mrTorxzuFnobu1/29hAnV74qG3wR
         /n3tsl/KAIIJSnYCOmy4SSPdPMtfNHS6BpxxF2LXj0KJyI5AQQukruEdc6XsF2T9Y8RP
         DXaWb32bN5HP6Ul+QSe2LBg81JNIyavMhjc8rcdjO8YALeONneb6TOZ3bVA96zGZDaQx
         jh31QjHtf1hO0voq6GHwu4Y8A+2XvEqZ3N4F0hrOV2Hdsqg2pP+mJtCLqRR9jNuoT3ZO
         zGSJQ3exEWXeiHA/8ZzMwNXiAb/8RDufdCa78brDDQz/+6n6YpZIRwjKBHDWICbShEol
         FtwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770142962; x=1770747762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72IAYlfThYiEG2aFjGCNshtysLaZbuOWDG3tEGy1mzE=;
        b=ElwPQe6sXKaLSZVgNv6Z7x8iDII43pslvRtD/wbmBNe62FcJiwjRNhYdalw3KgD+tK
         yurdy8B4U0Loe98zqoEKn0flJ+q+m6gyMja/i4gjfIDHR7/kwKIjk9AADSYAMqB38VKi
         ssrd6KtKpacT9wQbXjeFNJHRRknKIVVP6FIGe3aPDTX1LYDkH7Tu+ulrS9AN0Garmm7F
         S+JuxHjwE+0xdNjuoyuCrCKf8Sj+aPGXfNYhMuFsYvr6jyW0K5oUoJiBX6V/ROsf2XM5
         qJjypJo5dPsw60p1WVq+kaNcY3KZ8fTSV2ABapwsasUY6yYNX73WT1uRlx7dwfV30Lkw
         94/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770142962; x=1770747762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=72IAYlfThYiEG2aFjGCNshtysLaZbuOWDG3tEGy1mzE=;
        b=Kq3eq7MSTvFFR9+wcPY2pSLQ6GulmtVuLxNjKmNLMOFx5sICJYUGHm3GoRR3QiMO8H
         20GH7LPu5msUCCm7djR5N1I7LWMHyD8YqqJaANw5wfF5rkzGlV4oOJYZa5NNSIWIe2O7
         748VVciTyb5sdFoyBeHVrIYhFgrymEF66w7QpdJVCkAC88KupGY0UUeKfxtBm4L4vI6z
         AUdT8Y6Tp8NrCyjJY0z2KFORDPCEE1cG0tjIBzQcCT6xvFjisD7S0ULIO4rTB24HeSbT
         bxgd3kQV5/Qilkz+0SqedK+Ywp+kCQE8crpvryal/xUc7oxL91D0z61rklNcVRC14Xlj
         l7hg==
X-Forwarded-Encrypted: i=1; AJvYcCUT/De405JwctG50UeFSC0i2c03OxD9TnnD/s/xpmx5aCavntA16rYntvr8J+Y/9PSuYJIl3+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQMHtKPbeMCTXF8//SThshRhR2mZwoz/1v/lObjWiz1tmlGrol
	C5Xsv4tPHkEgsIHkL/3XlfHWErTe71186LPqDumX/IE+K6Tf0DbSLi/SO6nvPCmBBvcBLqW38tb
	7/1Ysv+Hu3rPH5BqpyKCHx8ZgS5+bLw==
X-Gm-Gg: AZuq6aLJjB/V1FgDdmtm7PVZEEzsS7CWg0Az8RZbaWitLslysMp6WEZyeFzjBPMO0CB
	PKG0loy9BYdGpqfh4j8Vg8byOV3y2msdcgCR3rN0xgzqlImv4TwIX2VYdjULTnVKoqhSXdKGuLy
	wtMV+fdk7Chcv7o7YZ++z4ioaZsJc4G6X1+ynEzY8Vc6Qs3spYR5Wj9h/VLq/fgqvEmCHy3wkCg
	/Sk7bK8lphUskpYPHd65MNuTb8wF8tzgDN1mfKrC+BANFzek+K3EBdN8Fvw18/hiufkHCqrjcWY
	xiu9xGbP8mS3HKpREjdW4w==
X-Received: by 2002:a05:690c:39b:b0:794:fe8f:ad8b with SMTP id
 00721157ae682-794fe8fae16mr4373667b3.29.1770142961756; Tue, 03 Feb 2026
 10:22:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130102301.477514-1-tmshlvck@gmail.com> <4819ec3b-23b4-447b-b10b-0bd93a40dc5a@kernel.org>
In-Reply-To: <4819ec3b-23b4-447b-b10b-0bd93a40dc5a@kernel.org>
From: Tomas Hlavacek <tmshlvck@gmail.com>
Date: Tue, 3 Feb 2026 19:22:30 +0100
X-Gm-Features: AZwV_QheORJ8ICtVU_dJsf5jOCxuVCH5tMEhwxpjksgwa5Kxeq4aCWYRoHfnm_I
Message-ID: <CAEB7QLBE8OQtvasbDvaeCownALqMcavA2TWOQJG0Sx3Q_-KShw@mail.gmail.com>
Subject: Re: [PATCH net v3] net: spacemit: k1-emac: fix jumbo frame support:
 manual merge
To: Matthieu Baerts <matttbe@kernel.org>
Cc: netdev@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, dlan@kernel.org, wangruikang@iscas.ac.cn, 
	stable@vger.kernel.org, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-213299-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tmshlvck@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 54A07DD96B
X-Rspamd-Action: no action

Dear Matthieu,

On Tue, Feb 3, 2026 at 10:39=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org=
> wrote:
[...]
> The conflict has been resolved on our side [1] and the resolution we
> suggest is attached to this email. Please report any issues linked to
> this conflict resolution as it might be used by others. If you worked on
> the mentioned patches, don't hesitate to ACK this conflict resolution.

It looks good to me. Thank you!

Tomas

