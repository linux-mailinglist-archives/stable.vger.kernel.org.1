Return-Path: <stable+bounces-211223-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJYWMnIUcmksawAAu9opvQ
	(envelope-from <stable+bounces-211223-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 13:13:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD30667B2
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 13:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 036F36CBEE3
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 11:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F617428487;
	Thu, 22 Jan 2026 11:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcP34y7e"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E2D413250
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 11:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769080807; cv=none; b=djek+2l6PYX+rzUJqj6BiD/T5U/BA03dL3wwiOtt4qMbNoFQ9QZfKGQ3HHA5HQh+We0wii7Wl7a5duVXXvpA8mA1hAkJf9ARBh/db+DapHBYCs9eUkbG9c4gIjgZ4pWE+UxZvGf54PNjkM2iVRhFy1q2Nx9GkAMOfT3WutGx8Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769080807; c=relaxed/simple;
	bh=9drDpY6+z/ej7FB1CPcTn/nYH3WOGUJooU/8D7OpAgg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h50V5WAJfbH7eNZlGaMzzRQWWOGqwA7VhGjmZHV8lelIEOIJ1nrDcYwPRDpRXzC0/kpTbK1qDrpKQUcNEGCAt29GJdjCiIgYbEUyptgnHT9sSlib0CxTiBjB3e7/VCZhNCbqgd58GJyehdrmPIpS3CtX8ox/0HM1whJLUcNeoWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcP34y7e; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4801bc32725so6706585e9.0
        for <stable@vger.kernel.org>; Thu, 22 Jan 2026 03:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769080803; x=1769685603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vE16nPS696hV6qrtA4V5+Qb8uv6z8ojCk8XJiLozdcQ=;
        b=YcP34y7evYlbP8KjZPr56OD/ulJ5DfPGRL+gMMA58U5ujb3+c8LGrj3KtZrTJ7Ri5l
         u/70JMAcJIx28U6HHH5XR8a/yUxOetwQ8H1wtuYjuPanuGdIIeTAG4A/GwIvhvNPrXGi
         kT+kMcYS69OlVKs2EvjtKG2j+2KpC74MGYCCfK4xgo0a9JZZCkMnKsV7IEdKb5505zZW
         Bjflg77EIqPa7wUOh2fIgTAPGnTZ0TF2uqIftBva5lHvFAi8SLeqAC2tKXq3Dl0QQymU
         IRajj3c6eEjzL6asrKBycVhFdr4cAfFrP+qQEB3VnC5INdYHBLlB1clGd+yfs22NGk8S
         cseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769080803; x=1769685603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vE16nPS696hV6qrtA4V5+Qb8uv6z8ojCk8XJiLozdcQ=;
        b=rDyVIMUvNjd+OeRAuHfghKAjkGworTO6lDNmPXFqvlf8tf/dzw2/IL/MVOsELgULRf
         gCejie5L6olfZXJY+8XhK1CB7kE+g7Nyw0KR0GSINpUxAYuXGMVfKKvZ5bqJFaPRm3Bf
         RC5r46iO909lZdM6nGSLYPgBCH1MGSTGoV+txo61Q1Rbu1uYLuDNSYzTxZ+6bYv/zZED
         Bv5yuY2DU3SYUUmwf2BJf3mbE/p57bmdKXUJS3wtvIdbhh4/SmhTeuVLTW2B4+7E2Mlu
         +NEShKYLa8hRVdOtFbu2uuHbwFypMO8E9a1ngzq49AZgPXdF+8DsBfOAkaA7z68hDzM/
         tbVQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/pExBdK/QssYLQZTr7m1X/oomzrn1x0f9CWZkp836KDJSjDPaII02+hgReA4CvTbalHGCkAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxeKSDDVNtGRDEfr7C4E+v3VrW0I/U0+soKFkUoBOe5aCXGBnU
	jvomQZ/Nx53E/DJzHuy3rNQWSeCu6N40VgsPcmbgPOeG7ZxLZ36KX1xt
X-Gm-Gg: AZuq6aKt6FGTVIjRuQv9RQwJ3n044ZtskpASG8+Dc3mmASlNSBr5EcrOmmBSg6tQl2b
	NA8yUV6oi6IA6QLz2FqK7wkxpsntnBWama3j6MFEHB9MVMmhqDasodxZx9lJgb+EcWQFWw7a37Q
	Jx5oDwfF3xprjkjgdaa4WsLhlaU2NATwUfD1E1rMl7QOMapOQWzmVint3r9BWK8KrS3IBCbCYWp
	+aFmUCL2jJ+P5meTyf6PuZB+7iZCyuu2U8ZblDrpsxyUtthz6iNifE+qoqrMvQvrI8ZctoSTcVa
	6ZKVNnfIy3X8T1ci3/FF+FVJA0W2z/zCatxbW6gH0UVd8Vf4/H8h4aTki/Lw7FG6R5kdW8L1iB5
	XApv7t4i+28oUyMDJ+n4/N/lNfP4M4Sce4B65EySSZANZfyZKma/DJNVcNtnZiIovJy3UgCLH1x
	8FlsDLJyhaWsAOMPIVevZSkMgWL23JHl9Cdoi4BZCXsW0sw7bWLydx
X-Received: by 2002:a05:600c:4748:b0:480:1c85:88bf with SMTP id 5b1f17b1804b1-4801eb10a4amr295290455e9.27.1769080803227;
        Thu, 22 Jan 2026 03:20:03 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-480424aa344sm51662315e9.3.2026.01.22.03.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 03:20:02 -0800 (PST)
Date: Thu, 22 Jan 2026 11:19:59 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, christian.loehle@arm.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 yumpusamongus@gmail.com, Ionut Nechita <ionut_n2001@yahoo.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] cpuidle: menu: Use min() to prevent deep
 C-states when tick is stopped
Message-ID: <20260122111959.14e8fb3e@pumpkin>
In-Reply-To: <20260122080937.22347-4-sunlightlinux@gmail.com>
References: <20260122080937.22347-2-sunlightlinux@gmail.com>
	<20260122080937.22347-4-sunlightlinux@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211223-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,arm.com,vger.kernel.org,gmail.com,yahoo.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 6BD30667B2
X-Rspamd-Action: no action

On Thu, 22 Jan 2026 10:09:39 +0200
"Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com> wrote:

> From: Ionut Nechita <ionut_n2001@yahoo.com>
> 
> When the tick is already stopped and the predicted idle duration is short
> (< TICK_NSEC), the original code uses next_timer_ns directly. This can
> lead to selecting excessively deep C-states when the actual idle duration
> is much shorter than the next timer event.
> 
> On modern Intel server platforms (Sapphire Rapids and newer), deep package
> C-states can have exit latencies of 150-190us due to:
> - Tile-based architecture with per-tile power gating
> - DDR5 and CXL power management overhead
> - Complex mesh interconnect resynchronization
> 
> When a network packet arrives after 500us but the governor selected a deep
> C-state (PC6) based on a 10ms timer, the high exit latency (150us+)
> dominates the response time.
....

We had to disable the deep sleep states on much older Intel -7 cpus.
The problem was that we needed to wake up multiple cpu and they tended
to get woken in turn - so it was far too long before they were all running.
I suspect that pretty much anything that cares about latency has always
needed to disable them.

	David

