Return-Path: <stable+bounces-216290-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPErAW1pj2lHQwEAu9opvQ
	(envelope-from <stable+bounces-216290-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 19:11:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E52D138D67
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 19:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 147BB303A4BA
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 18:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926FE360754;
	Fri, 13 Feb 2026 18:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zq+4x5U3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5282F3328FD
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 18:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771006310; cv=none; b=sb6El4qX0SF1qTT5gHlHwkR5JNXiCNfd0dQ5P8gXlDX/q0mBMGUSfpaZ5ngBpWWe0riSF7ntA46ZHanieB1M2xR5m+sl5m8FFWwP2Bbt2ca+mo7u90FFU+KLZ929cJoiqlW7bfrusOwzuWMykE6ndM6a7de1JwabW+dj6oPodbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771006310; c=relaxed/simple;
	bh=0W0uEGlwXRjiBkj6qvvNd9tmGfgmWtKW/vCFweZxoiU=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ql1W/LwAaR5wxM9RoHGbXRclFZOxpZAz45gpSpiLCrf1d3mJQJvjkLwJZEHKnO3PxlqDlQisn4pNaYiFUd2Md28sYtIYG9OHUamM7fE2E3NMJwMuQ6Bgc0ooga774wKXQxx8wzc5ruC3fmk+We86QtURX0484HN6mDQqlLAMDX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zq+4x5U3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BDF3C19425
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 18:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771006310;
	bh=0W0uEGlwXRjiBkj6qvvNd9tmGfgmWtKW/vCFweZxoiU=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=Zq+4x5U33H4DoyB9SVcgbDxPTfzSdGG65OavKjcu3oNcZt+S3fKM1NUzsQAbWwtLT
	 x1RcFT/M53W+8JmvVokBexFeR6vdgXrZ/UHjlM+lJZWRun59501tUu8SfKQoaYfnJM
	 yF2ZE1517dFUrU8kS2vMFD5PeQpkd/KT4j65CAgWQZIBiJBxlQXMK/NSJ/EBFmgf6B
	 n8nz4q9LDkmGeE0vWYdvishqDitg9Invwk++MXYDawA64Wc5g9BWIbU7+2hxx7AiLy
	 US150e8QhqU6QLUmIuBI8nnALVl4CmPBdb4EdilRPen5UXnRfa1euD9YZoZvG9WJ5w
	 WTJ6AgmJx43og==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59e5eaa491cso1473752e87.0
        for <stable@vger.kernel.org>; Fri, 13 Feb 2026 10:11:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWEX5SIsUO6DFxCLUkIEtEOmA71y5hbtPNJMb3RtFKYD5D8OAbf5oqJtR+fl5qp/FkVyRq7Q8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB3kXjuo2HnN1LQ+RU/7p4fAm+ZnyPXFGmOkqM6clx2c5OYYFZ
	9oEQc3uvra0OoQA/56Oa+xykDvXrG7XcGsx01O2/OFoETBFR30d28Ewksj2XC4GlsYqIJ4zHUwl
	j3MPeQjyyBUUAGIHbfmSObyYYrlmeyM7/TNM4lIYe/A==
X-Received: by 2002:a05:6512:234c:b0:59e:2242:fb9 with SMTP id
 2adb3069b0e04-59f69c27962mr909375e87.16.1771006308713; Fri, 13 Feb 2026
 10:11:48 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 13 Feb 2026 10:11:47 -0800
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 13 Feb 2026 10:11:47 -0800
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <aY7hr2NGmZ3gBd5Y@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212133505.81516-1-bartosz.golaszewski@oss.qualcomm.com> <aY7hr2NGmZ3gBd5Y@hovoldconsulting.com>
Date: Fri, 13 Feb 2026 10:11:47 -0800
X-Gmail-Original-Message-ID: <CAMRc=MeN+LDWhP=X_weTL8vzX3chL7Kp282WNVSgB2HJWm_OGA@mail.gmail.com>
X-Gm-Features: AZwV_QjZ5lBslmdhOHIuxglRnRWtKN52Hi9bOYvBtsGwxXwwe8INRADvp-nhOiU
Message-ID: <CAMRc=MeN+LDWhP=X_weTL8vzX3chL7Kp282WNVSgB2HJWm_OGA@mail.gmail.com>
Subject: Re: [PATCH] gpio: sysfs: fix chip removal with GPIOs exported over sysfs
To: Johan Hovold <johan@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216290-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6E52D138D67
X-Rspamd-Action: no action

On Fri, 13 Feb 2026 09:32:47 +0100, Johan Hovold <johan@kernel.org> said:
> On Thu, Feb 12, 2026 at 02:35:05PM +0100, Bartosz Golaszewski wrote:
>> Currently if we export a GPIO over sysfs and unbind the parent GPIO
>> controller, the exported attribute will remain under /sys/class/gpio
>> because once we remove the parent device, we can no longer associate the
>> descriptor with it in gpiod_unexport() and never drop the final
>> reference.
>
> Is this a recent regression? I'm quite sure fixed this once back in
> 2015.
>

Yes, that sometimes happens. There have been close to 100 commits between your
fix and now, including two major reworks.

>> Rework the teardown code: provide an unlocked variant of
>> gpiod_unexport() and remove all exported GPIOs with the sysfs_lock taken
>> before unregistering the parent device itself. This is done to prevent
>> any new exports happening before we unregister the device completely.
>
> So please add a Fixes tag here to document this.
>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
>
> Johan
>

It bisects to this commit, though it's possible it's a mix of several changes.

Fixes: 1cd53df733c2 ("gpio: sysfs: don't look up exported lines as
class devices")

Bartosz

