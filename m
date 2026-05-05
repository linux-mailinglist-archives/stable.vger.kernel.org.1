Return-Path: <stable+bounces-244084-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CK1YFUTL+Wn3EAMAu9opvQ
	(envelope-from <stable+bounces-244084-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 12:49:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D78834CBD0D
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 12:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 959C431A11B6
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 10:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954A433D4F8;
	Tue,  5 May 2026 10:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+XBGfQj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562653368BE
	for <stable@vger.kernel.org>; Tue,  5 May 2026 10:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777976914; cv=none; b=f0JuGnzKDIhb3jNqB7RwAibWzGMmm/JFwitxdVdyaZkSUucsONjUDrtLtbWvyXHgYL9SfYdLKWz1ME4hISKLl1gXMK6XBPe/FLBPjaZxN3aQj1OI6JVhq0NZCU+zBBr3152mituja0D9koH0zZWcgC8PwbUjVvSlvLhToIfxMvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777976914; c=relaxed/simple;
	bh=zytMuWjG0fiHX9INaamnKiHfY1coYLUKlKEAABYlbWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oc7r+OueyCPjcrCGELGl2ZvB/6MZnR2xygi+r3dI42FGyTgTVk88NzliI+wOF/6RPw4qKuUHSVjlFPGcKOkvziQe6Sz69OpZxH8jMGuT/+WokQtS1OD4NevEVesamvaELCJFogXfoKQlgz/IMFjVUSl/8kVACUNGXV0Wss+7+Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r+XBGfQj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12434C2BCB9
	for <stable@vger.kernel.org>; Tue,  5 May 2026 10:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777976914;
	bh=zytMuWjG0fiHX9INaamnKiHfY1coYLUKlKEAABYlbWw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=r+XBGfQjmEqlhCRyhvawLxMRxMqfQ8vs1qaoF8H1d1Lq7A3CvsSLHSsFL1d6EziXr
	 fiqGCfi9rsnhRQ66tMpjqRGdlT55Ygdecf9N90TSkgSMcpAnkHmjJLypsC4G2Z8IWT
	 trh3QJ0/ypwMnrf/XlqEij1u8tEEvFdUP2RcEALI35f4/Qwy+rc7EwGQJzSPWShQnE
	 NiaFvFE5PxYCTv2YMmt3t67fQJTMdEq6vw9Gs+KAJkh2vDtgjse3sVynfJZlG2Dsrc
	 7rueWHjaVpD2fIq2BIfPWlSJPv1WcBFw3TYlkIonUmYoygWBPNSs8CJoK5NobZnsVQ
	 Z7taWD5BsRoZA==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a858881ad2so5153091e87.3
        for <stable@vger.kernel.org>; Tue, 05 May 2026 03:28:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9c+tsrSH/4vxpdXXBmwfLT92VwsQCibe/KZl+P812hTRwQvi+t3SZgQLFEblefiWzsNxV05F8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBEa74qCncJ2KLwIj/8omV2619MR2TtRa7S2PpgOQVNrwFy/8B
	oxZ6zRnAqVk8h/w2tgXGhjYFxPPKw/CE5UIYNEScY5s1gfYsT/lwbZyCa1TvzMVjYThV6O75lGp
	Ian75fZlczl/IJH2RyafYVDpTUst1ZLU=
X-Received: by 2002:a05:6512:1091:b0:5a8:7652:9258 with SMTP id
 2adb3069b0e04-5a876529284mr2605579e87.0.1777976912811; Tue, 05 May 2026
 03:28:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430-enable_wakeup_capable_gpios-v1-1-5de39bf06094@oss.qualcomm.com>
In-Reply-To: <20260430-enable_wakeup_capable_gpios-v1-1-5de39bf06094@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 5 May 2026 12:28:21 +0200
X-Gmail-Original-Message-ID: <CAD++jLnX5J+GncH1U6zE40eErQ1LeNiPmQqZe5UewR3S4VhBOw@mail.gmail.com>
X-Gm-Features: AVHnY4JBZ0_aB4B7_nUxwn9lnfxpk_Z6f18SRCw7UeiainLcID73YORf9XCZVRs
Message-ID: <CAD++jLnX5J+GncH1U6zE40eErQ1LeNiPmQqZe5UewR3S4VhBOw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: Unconditionally mark gpio as wakeup enable
To: Sneh Mankad <sneh.mankad@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D78834CBD0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244084-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,qualcomm.com:email]

On Thu, Apr 30, 2026 at 7:54=E2=80=AFAM Sneh Mankad
<sneh.mankad@oss.qualcomm.com> wrote:

> The wakeup enable bit needs to be set irrespective of the SoC using PDC o=
r
> MPM as wakeup capable irqchip to allow the GPIO interrupts to be forwarde=
d
> to parent irqchip.
>
> This is set only for PDC irqchip using additional check skip_wake_irqs
> making it impossible for MPM irqchip to detect the GPIO interrupt during
> SoC low power mode since for MPM irqchip the skip_wake_irqs is always
> false.
>
> Remove skip_wake_irqs condition when setting wakeup enable bit to allow
> forwarding GPIO interrupts for SoCs using MPM irqchip too.
>
> Fixes: 76b446f5b86e ("pinctrl: qcom: handle intr_target_reg wakeup_presen=
t/enable bits")
> Signed-off-by: Sneh Mankad <sneh.mankad@oss.qualcomm.com>

Good work here, also super-dangerous so if some more Qualcomm
engineers could pitch in on this patch it'd be great.

Is this an urgent (-rc) or nonurgent (next) fix?

Yours,
Linus Walleij

