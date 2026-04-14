Return-Path: <stable+bounces-237829-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAqcNgop3mmSoQkAu9opvQ
	(envelope-from <stable+bounces-237829-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:46:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EB23F98D6
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DBD1A30195FA
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 11:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8AA3E0C49;
	Tue, 14 Apr 2026 11:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QijGMksl"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACE53E0224
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 11:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776167068; cv=pass; b=dVOR+HqXJW2uAsbM4709NB+ivtTiIpLh2WI4RX/x/tHjdWscWU8U7DcrAXtxYF+dn877zKzeaakv7hj44+A44/egdQuXNuf3r13+XKfJ8+xSrwF9iOAO3M/avXPc66OYlol8HOrnp6XnzPpOZ3dr9uT6GeJ8MCzwJgjsN/7zx6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776167068; c=relaxed/simple;
	bh=2D+4ijjnwuc1tvEXWl4yl2BJD4fo5wLmMkmr6m/nUMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vFaiZ/69BkB9Q1I6YkFH3Xj1hTWb+iAxDlspvmhzwBgEuIXWSGW5JlVdUPMvEXckHyw8zfi24bZnSmxy/3ckIbpt3v8ys6RZ+eWNL4Ta8/b6q0tHP4Lh5KWOIfnYf0pgp/EvDB999ruz7Eu1916TIGOvXXFd9AXfRTdrobG65NQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QijGMksl; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79853c0f5b9so73077307b3.0
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 04:44:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776167066; cv=none;
        d=google.com; s=arc-20240605;
        b=LmwUtEiVVtyhnWRM45BYrmdS0p/4W0ggfx5PSS3DVb8XQMXusnOo474EosEJ4yNQJN
         DdRN6D14OzMjKI47XHHxsOzhCedJZ2jOBGGM7uPMc7/rfthjmbQ0fA1H93Z8UAvc9+Wz
         ae7nm7iAU0V4FZMfz3AlBcAsylwp6HtBRYie7EY+1TIHVK+O9ylZJcUR1P0SswVsAr/H
         Enk4j2+F5/T10wSomb3WFXbfJ+8sFe/UMXFCzNjt+C2uG7YX2ZV5AYJbfMUGosUZ9vd1
         whtkSnRDpDFpeCmo427zEQkF6t7Q7HYP2zzCDLxVW2uqQ4hAvQnuVrwnexhZF4ri6S6o
         YOkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zQ9r39RFYNLQtni9+zz7YlrKwdJf7Gv2tJLgwx8RCXk=;
        fh=0oMQpvkI7Iklh80L4dWhSPkXhhx1KMyVyCWYXxB/hjM=;
        b=MOlmL4offqPoLubk46QcqhJLdQkDtEnkvFVTjSLUMUY3Qxi+s90RiOxXecS9jXzqMn
         Kzsvr8p+LoqBj41CcqTJWry9f/HtSIHEMkXw4g8GrJ549KurDZ7A0ax6cUJAYplxdP26
         zevzdD7ptf/4AhlAEzmB6cFU86hD9G70QXDjM6g7F+Umyaj3xDhWA5o2C9ZcgszWhDdd
         JtKXqQpURDyPTMFn1sEZctb/K7I43W5fBnUi7cDvJJMRNIREas9AoTFR01ttJG/FXnrD
         wSpnw7nw5dnR6NBn8cjkCDNBwAd5voxynqM2dgEe/LneRwibdJfHW0VpICenj/WHqd+W
         afDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776167066; x=1776771866; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zQ9r39RFYNLQtni9+zz7YlrKwdJf7Gv2tJLgwx8RCXk=;
        b=QijGMksl08PZzMO8zXWa1KVR9PyvFgeLvdz8hXRI2t83+X20rKtSZMwxAW3flobKQ4
         Hd3t9N7NqgIbPLOQzf0lpMOcrE8vGfWHQY2fjYhWGLx/2wB6Gkmr0xM1usdT7i3+xoj7
         ozsUidTOMaeKuHpYij/JScOEn8btS0Rg9OvjXW8A6qvyZBHIwLxTDRR7bjWQZJmwq5Qs
         oWg2MHjK/uM4blvYerg0uG7nFFgJr6RiMRUClSyOXmdnjFAhQxs649kA59rFwR6tWphy
         Dlc0fwz5tNZ3NMsY2WYHL6HUssjhUgUX2rstOsFKGi8wViVKDaIyqZix1AXvnxYU+YEJ
         Ov7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776167066; x=1776771866;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQ9r39RFYNLQtni9+zz7YlrKwdJf7Gv2tJLgwx8RCXk=;
        b=LZNkYM9rLYquDyzLSNSaVU8jFYsYap8Ug7izBfgn5GLe+HdvSEvvM8UXfoN4noxmFH
         v/DJfNHSoGFjJIgG5aQtHQ1Av3KOwsXV4C9KhaGvwoobeLvl0PkAJ4svt/wPKaNb1Sml
         2YQcTP0DP0IlDDaZRurlMECKNvxQV3SkVJ9J+rFqkrhKZLSOQ5UvH2Ucm23gdJK6tqkD
         ZNosJauaYog+eI7sGYhR7bf2qICmEze8GO4kCkLo8cvFhfTiAvpXvgLY3acRUqrW2Etz
         y/zqJ4xmJCzA0yHr6ZN5HU+syOBOc01wJahqKnjMvexg0ib7MuOewrTDLN2ojfj0iI2j
         CH4A==
X-Forwarded-Encrypted: i=1; AFNElJ9NJWCw58DPVy/ONi7DLeL4FABa5b993KdG3xuXwiJFWdV9nrLhbgHEZd6fxSr3kGr/lgxqLC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTKokuNCe7/Zd5ZapmNxFDdk+HJnDY3qx3qLB0M2f3cZT2H9rl
	CrJ7ys4C8fqpo0mR6/oJGj4jC5EhHiFtweFk5tJOJvvCMdV31ckl9NWmgE8mWEdA6UEkZjyYLE2
	xRwPXwKEvJIpUvdiBK7E1joIerLyHzJM=
X-Gm-Gg: AeBDiesr98CidI5a+l5ofQk8JEMXZkgNPTvaBcgg548i8oSnWtv2MqtZKiVmwcMaAnk
	+YxNl4QJe4FYGDg5H/MjeaH24kckB9l3J8KrjhOpykmVy/s5C+Z2pOba+AYiGQbwVauefJb9Bv4
	jdZW9KqvjfGsw5oozoImFhubHQdnEtGH7JXRAGgWNvtKzyOXJbfYt/Dq6M2FNeZwwzVJB/ZXleZ
	ujvgg9SUDERJhJiiQyHIVotP7PHXJmo2t6HK2xsJUWwwyUaTpf5l0PiDpCOVyBwqYhuNFR4p/Ob
	WyFf9cm19A==
X-Received: by 2002:a53:ac86:0:b0:652:541e:9685 with SMTP id
 956f58d0204a3-652541ea003mr1312802d50.19.1776167066077; Tue, 14 Apr 2026
 04:44:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413143643.3002454-1-lgs201920130244@gmail.com> <ad0d5fIAkjblQcIt@redhat.com>
In-Reply-To: <ad0d5fIAkjblQcIt@redhat.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Tue, 14 Apr 2026 19:44:18 +0800
X-Gm-Features: AQROBzDRON2GSvR6gFet_WamV1u2nq3FGC-LPKOrKn-jHgvhjSChOhLjzs7CCmU
Message-ID: <CANUHTR8JCPLMAPfdjXX95tcPTqHWBy7k3GwOo7=BcjRxfMSavg@mail.gmail.com>
Subject: Re: [PATCH v3] clk: starfive: jh7110: fix memory leak in
 jh7110_reset_controller_register() error path
To: Brian Masney <bmasney@redhat.com>
Cc: Emil Renner Berthing <kernel@esmil.dk>, Hal Feng <hal.feng@starfivetech.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Conor Dooley <conor.dooley@microchip.com>, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-237829-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E0EB23F98D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Brian,

Thanks for reviewing.

On Tue, 14 Apr 2026 at 00:46, Brian Masney <bmasney@redhat.com> wrote:

> There's actually another leak in the error path for
> auxiliary_device_add(). I think this code should be
> converted to devm_kzalloc().
>
> There is no devm_kzalloc_obj() yet, however according to [1] that should
> be coming soon.
>
> [1] https://lore.kernel.org/lkml/20260330154108.GA3389518@killaraus.ideasonboard.com/
>
> Brian
>

I may be missing something, but I think the auxiliary_device_add() error
path is already handled here:

ret = auxiliary_device_add(adev);
if (ret) {
        auxiliary_device_uninit(adev);
        return ret;
}

The embedded auxiliary_device has:

adev->dev.release = jh7110_reset_adev_release;

and the release callback does:

static void jh7110_reset_adev_release(struct device *dev)
{
        struct auxiliary_device *adev = to_auxiliary_dev(dev);
        struct jh71x0_reset_adev *rdev = to_jh71x0_reset_adev(adev);

        kfree(rdev);
}

So my understanding was that after a successful auxiliary_device_init(),
the auxiliary_device_add() failure path should be cleaned up through
auxiliary_device_uninit(), which would eventually call the release
callback and free rdev.

The leak I was trying to fix is only the auxiliary_device_init() failure
path, where the function returns directly before that cleanup mechanism is
available.

Please let me know if I overlooked something.

Thanks,
Guangshuo

