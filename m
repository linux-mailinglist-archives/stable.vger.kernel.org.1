Return-Path: <stable+bounces-232795-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMQxLFUrzWn7aQYAu9opvQ
	(envelope-from <stable+bounces-232795-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 16:27:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2296937C22C
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 16:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48D70300AEE6
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 14:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746C2405AA6;
	Wed,  1 Apr 2026 14:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mD0GtjQc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B884035D2
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 14:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775052797; cv=none; b=PfkBvVY4ZHtplhpBl8HJXWk7COrktEuUTByVwHQtVwPOksT5G86fnLYtVRw+WW7jMT2vIHVwH008QYckE4P+cos1GjTjeM23S5hnjwF7OYlX3ChuvdicspHtgj92KF6j/F3Ag8kHmPDe4sH9XzBQftVKtRXXIma3c3zpygNq/LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775052797; c=relaxed/simple;
	bh=aS0SAiFq5A7WJ8N+gPtZQSzSsiDmZBYyXQIvdpL6q8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UykUTnSR1o/Jz+HqerTQxCMcXJxgyD4afQL0T3W92URDfpzdh7Gt8HB89ZrWA6lMMOIuD67i0oIxVbLRuGyxVXFBAEX8Vrhti+nEhBivUo/hiYGu+/VatfPuTldLprLcN236ysYX3JZXIqr8shWv0Ct99JI6NMXsBnpyuSrGy/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mD0GtjQc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DDC3C4AF09
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 14:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775052797;
	bh=aS0SAiFq5A7WJ8N+gPtZQSzSsiDmZBYyXQIvdpL6q8c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mD0GtjQcD+odeet5EBPi7H02yNFT5sLF5eoYpL7vl9EEGn2Ft4q0yWeAVD5XlV9ke
	 UkXoNQ+Z2Cy/iRAupD2+o7/nY5EkfdPeuCmfUi5aS2j+3aF2F/Q8AUPlh4yiAk6SnC
	 QckeFUbM9snIkQbpJisAtvyPWkdWmZllt3pmQnwxDbL9LNLlCZeSSIhcoh/3eLmJLn
	 y/dnw1Adagt+/KkmMF07VIzvMj8meL6s0aQAiEZ148PmI/9u1Za09AKsaaGK03WP2W
	 16+yQP2qMrok/ZTfOSxbLTsUv+eJXSrTe5q9qHI1EVWZMTeSWDkgNTez/Dc9FAowip
	 D6scLIl4VXwLw==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-463a0e14abfso3971085b6e.2
        for <stable@vger.kernel.org>; Wed, 01 Apr 2026 07:13:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXmwS8T8O0AkRUvBCeLeMcjy8wUzKGZQhpTA6jiRdkxajrQv2HMkEvwNxsvwWfWJvE/CtRqs10=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKp1fFdSg0urdph28bbYFkLsForpgjD6ty8xGMdVpGNekflQ/K
	Z0nLqUlTGMFiuBGB7HMdsE50ofY+kEqBzEyJAtcaOCgy/LP4Urd/JxIuWcaZeI7QKq28Or2kba7
	eEFVOcj5Q1EFHA6tZb19vRS/3g1SIz3A=
X-Received: by 2002:a05:6808:1a20:b0:469:eb5f:891 with SMTP id
 5614622812f47-46ae0194519mr1974495b6e.39.1775052796239; Wed, 01 Apr 2026
 07:13:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401024535.1395801-1-lgs201920130244@gmail.com> <aziv3yszmqef3amj3wgnutif7eop5slnmf5eqrg6rl7sk5ghf3@7et2qcnti2y2>
In-Reply-To: <aziv3yszmqef3amj3wgnutif7eop5slnmf5eqrg6rl7sk5ghf3@7et2qcnti2y2>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 1 Apr 2026 16:13:05 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h2ZafW1H9NECCReyrSU9=o5YCreBnY6Q1SW=vQ1Gvcyw@mail.gmail.com>
X-Gm-Features: AQROBzB7rq7t1BHAKFwCMmmotmo2GMjHLmmHBFnGaOFB6hgRCYeW65pL0w6YDI0
Message-ID: <CAJZ5v0h2ZafW1H9NECCReyrSU9=o5YCreBnY6Q1SW=vQ1Gvcyw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: governor: fix double free in cpufreq_dbs_governor_init()
 error path
To: Viresh Kumar <viresh.kumar@linaro.org>, Guangshuo Li <lgs201920130244@gmail.com>
Cc: "Tobin C. Harding" <tobin@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232795-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linaro.org,gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 2296937C22C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 1, 2026 at 8:23=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.or=
g> wrote:
>
> On 01-04-26, 10:45, Guangshuo Li wrote:
> > When kobject_init_and_add() fails, cpufreq_dbs_governor_init() calls
> > kobject_put(&dbs_data->attr_set.kobj).
> >
> > The kobject release callback cpufreq_dbs_data_release() calls
> > gov->exit(dbs_data) and kfree(dbs_data), but the current error path
> > then calls gov->exit(dbs_data) and kfree(dbs_data) again, causing a
> > double free.
> >
> > Keep the direct kfree(dbs_data) for the gov->init() failure path, but
> > after kobject_init_and_add() has been called, let kobject_put() handle
> > the cleanup through cpufreq_dbs_data_release().
> >
> > Fixes: 4ebe36c94aed ("cpufreq: Fix kobject memleak")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >  drivers/cpufreq/cpufreq_governor.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 7.0-rc material, thanks!

