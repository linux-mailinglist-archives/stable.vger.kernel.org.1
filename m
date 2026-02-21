Return-Path: <stable+bounces-217620-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKLdCdc9mWknSAMAu9opvQ
	(envelope-from <stable+bounces-217620-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 06:08:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7925B16C263
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 06:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C86DF3038AE4
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 05:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F0D334C20;
	Sat, 21 Feb 2026 05:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4X0jDk8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A900334C05
	for <stable@vger.kernel.org>; Sat, 21 Feb 2026 05:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771650511; cv=none; b=MHBc8jTDr+B6zCQRUYzwUyrPbD5IjKSLqmdDp+6R7JGmAtYhQHB1Xvk3EPOb7OuGQwoKnlLZxadB3CvHoK3QMoHRIgNcehGIVUy04p7vCe3QycSr2Jy+K5sX+UH2QAIFSgBqINpPgrMAh3qMB2J5wVsa5ANcoa8myOFsqXmcgi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771650511; c=relaxed/simple;
	bh=FfDkPtaibjMhcxs+7vtPQVv7ihhi6cR/ixcoHKsdKbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QO9dJ+uW1ehFM5ifR7yEgu4fas5MnBao+YZ+ZOpn/QYByH+GSwy+9vTxTxWo5kq9F0ahujBxER/oghzc9BPRoRXkL8qpkVSFt18ImX6r0M5UwkGZUmghzYkJ/DDz4jaEUSUaDxx0iIViNiR2g490XBndmzXjArTj4ZqkUAE2VVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4X0jDk8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4335C19424
	for <stable@vger.kernel.org>; Sat, 21 Feb 2026 05:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771650510;
	bh=FfDkPtaibjMhcxs+7vtPQVv7ihhi6cR/ixcoHKsdKbs=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=V4X0jDk8itTjg9vyHKn20lEus74dyl1K7C7iYbl8dw1Vyr4rYxkO8mxCCW/J6+V6m
	 zm6rBmvkm/9FxN3FA4j/vTswV3+eFmusvExRRdp16nUYNzW1+EUuq4FqVOJalOe0Yb
	 1WkHGoJgkeGv2ZCh/Jziye08vBMq18MKafo42Fqx4QTs9gZZgC8OXlEBkEJy+J1uWM
	 +1egfqN/EQGsTnpU1eYXWw7ttGTnuBjuBejdFG3kEq4pTM4kTVP2LW7m3Xl+4n11aF
	 PGy+arOD0GtutzlqRjlqsb3ih/AXzJ8rAXWcxxyAcKslFTJQH7ievIFWruittdN5f7
	 GJdn0Eyb2tfFA==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-38704f70ea3so24658701fa.2
        for <stable@vger.kernel.org>; Fri, 20 Feb 2026 21:08:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXa1Qn903XezKnIypnJpMoOwvZKHjn88i+SZrJrLzEWhvM1TpCO9f0D81jsvGTUbzBIXidO4Ug=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIdsh6oq5gr2v/dgW46Em62SlkgqVvW4vQ5j9WBnvlt4nJi2I3
	y5ubEJ2JCByeCED0bjN4uuTBRGF8eHihNrHS/sllLPOyrcUha1gzcb/7emgFAovzUkM+SRTBpRw
	VwlxvTJ9fUXYRwvY+ZW0ec2ekPa7mDZk=
X-Received: by 2002:a2e:bc20:0:b0:385:9b50:91a2 with SMTP id
 38308e7fff4ca-389a5ad674fmr4879541fa.10.1771650509149; Fri, 20 Feb 2026
 21:08:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220174938.672883-5-krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260220174938.672883-5-krzysztof.kozlowski@oss.qualcomm.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Sat, 21 Feb 2026 13:08:17 +0800
X-Gmail-Original-Message-ID: <CAGb2v65DiAEXR27TAEBBuP+=Pig2YZdp9w-70ue3TCOT9JGLGw@mail.gmail.com>
X-Gm-Features: AaiRm52TPU0KT3mTHxl4kTJwTo8ag6W6iRhOZSo2XcVHXwftrG7b7iYHyYyc8kQ
Message-ID: <CAGb2v65DiAEXR27TAEBBuP+=Pig2YZdp9w-70ue3TCOT9JGLGw@mail.gmail.com>
Subject: Re: [PATCH 1/4] power: supply: axp288_charger: Do not cancel work
 before initializing it
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Sebastian Reichel <sre@kernel.org>, Hans de Goede <hansg@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217620-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wens@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	HAS_REPLYTO(0.00)[wens@kernel.org]
X-Rspamd-Queue-Id: 7925B16C263
X-Rspamd-Action: no action

On Sat, Feb 21, 2026 at 1:49=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@oss.qualcomm.com> wrote:
>
> Driver registered devm handler to cancel_work_sync() before even the
> work was initialized, thus leading to possible warning from
> kernel/workqueue.c on (!work->func) check, if the error path was hit
> before the initialization happened.
>
> Use devm_work_autocancel() on each work item independently, which
> handles the initialization and handler to cancel work.
>
> Fixes: 165c2357744e ("power: supply: axp288_charger: Properly stop work o=
n probe-error / remove")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>

