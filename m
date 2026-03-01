Return-Path: <stable+bounces-222439-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBSzN2cRpGlcWQUAu9opvQ
	(envelope-from <stable+bounces-222439-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 11:13:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4703A1CF0DA
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 11:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D28D1301A70B
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 10:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D573358B6;
	Sun,  1 Mar 2026 10:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CugbtiO6"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B45F33509B
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 10:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772360034; cv=pass; b=ZbBWn2Nh0iQtFwg+uGwQnQdMKp32vUvkmVSOQtdkXLOXXvVzrSDEak+3JKKi5lsG56wMzeB934wFh7CRR82VhzCHb4e9OfOsqjtESzZWIz53TLdjw/wmErEdIgput1AGLik6CbGfloo2P832YT06I0AgxD0z47kCwll16JOsjKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772360034; c=relaxed/simple;
	bh=QERv4eKUlmZOQXI9AgmqSV7lUjptvtTpV+52nAuVu3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ud4vtKqheyxtwmvtp8ciATwmpofdL1dTKPfnc6SUache/J70Ky/mFF5k5cNIe7dUQtoUrv7cFqHZ2LWSXraM03H8VUbrfWREx4XlDGPIE9qctLL1XVcgI7lCWI75hdsPKj9Nfgh/lq+OyJKvHboD5IN5BvFjY4jkuI8bm70tTpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CugbtiO6; arc=pass smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2bda3b4318dso275177eec.1
        for <stable@vger.kernel.org>; Sun, 01 Mar 2026 02:13:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772360032; cv=none;
        d=google.com; s=arc-20240605;
        b=VXBvVZjM0ItqhE+NS0WizCXSpvgpQnFLHW6V6V9Es0C8BQHXkjl5x8rEvRO95vLDhn
         slpgnGJkpLy+aphh6bRkrd/RLivEWx+b/1MACt9PlZHGyuE5sgN5H2vRb2npLoLjpseu
         WUJO9bz8kJL4qPF/PxAkVLdMGs1/rPV8G9eMyGRqqMV/xf1/4B0u3jdj3TSyKzjKAXBQ
         VAd02fbujdmhk3OMrH8uBiKL3b8ofPGmv5/AepwSuRNoPrq7iIaI8IzOKMHVW+gkRrjJ
         U7uQwQam4CWHzJ3+/gKTsOuslh5O+y0mtUXR5KHsaimm5kQiHtry8+DMtKqAIMHWumph
         pMwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QERv4eKUlmZOQXI9AgmqSV7lUjptvtTpV+52nAuVu3A=;
        fh=6SlAK/s1LDjYOpJGfmZa0f6MYkX0DKJLke/nL7xIdlg=;
        b=FdLNKbuwBiEveEoSpUszvZcDPdQtTkEBNAem+l5E3halu9yCpnZ20El/rjhT7b2+WC
         BnJiTKXkOYNN8cP3TbGLqs3Thtoae34WQCbgKtGQCu66hfMZRpJBUH7oJxxgkp2IV7A8
         8HyxdRjwfd4D3SQu5f551xHSybvGQ7L2oFY3Dp4PHX7+KLi2VJYsk7MXnjVQp+Vw6UYb
         OUrMyulvlmM3KUde1KiipkFKA2KqYzY89d42Bn9BxNm0furt6D55yUkxUat7iDSPEbY5
         1F3RyvzUZsdTYykISa9F0w9ONuZ1zAjsg6y2BeeB9fmuodnFJa7sI6baZIRsPPSJiu1L
         Ihiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772360032; x=1772964832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QERv4eKUlmZOQXI9AgmqSV7lUjptvtTpV+52nAuVu3A=;
        b=CugbtiO60Cuj89HuO0KTMu3slWY+b7oHTqBJIv9IAUsP64mPyKxYet1xCtQtSfeX7k
         RWmitNH1O1LQZtw0VkChP6wQGl5qM5Q1+U3VYoIe0fz6dnOUc2XYmYhANI5xbwZgZiPA
         u0zjsL+Qlggqj49TMf0YLYBoLX+FIbsR1FAT8l7R0SFuDXs+C8i5HAZ2GwHqzDJ0zMjA
         yVr1a4hspW0QQzzCziHgPyhUF4Zuchu/Jj84R6M51WeE1L4kMPSGCgJ+s69nKQucCd0g
         YIh0GnzBRlcseEy8RFC2tuiFoNXjHDX34Rb3GpjCapSd6dykDJlh0YQO/H9eWK4jvMMQ
         gFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772360032; x=1772964832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QERv4eKUlmZOQXI9AgmqSV7lUjptvtTpV+52nAuVu3A=;
        b=EVj5J7yWupzdw6KoprRgtOYn8A9j+ehlEYYVSwxH4KZO6rrq7CrdBxw23fWQqsOGyD
         LDuBthrS9JEcbGcJr1x12VVFY45FtQ0Lq9YZti45cDUeGjzg1MuxyFsfABhnDXNYqkHP
         3bq1lusGtUj87q1h+Dxhgyt+r5NwNtfmt/GPe2X//cRvBcJmrhPxKYN5nWw0GtbJu8ZV
         efIKR9xYMMBAt5ujOAWtoyFGSsHFzcIjcFHKfR6Mo2T1cM9R6cWW6FCNF2+lyWPWVoBa
         9WrNYR4+hABPy5tkS+pgczloLZ+BTF6GP43cxNVDPsDtoPlMbCHMNGfBeoqshwsaGKcy
         he4g==
X-Gm-Message-State: AOJu0YwLFzeKlJddzruAMOwb2CXLcfo3IzGqjueciWC7D53rolj6CiLv
	qmYWzyl45rLmNh6X2Extilh+QW/UPWLaKtnrthGEOycEwbSQcALJsAH+Pbfeha4i/SCa2BT+eKb
	gnCGBtGLR5XconqLHkPcfLQcProB52UI=
X-Gm-Gg: ATEYQzwDqu3WABg39VGDtY3XdkMdI8hjhPMWeDZnlOb8kZAeGR+gZDzGZ+TyJEKMAAS
	y/O8uDo0YODBuk0APH5j+UKG5Wc6RlIyP9nVZMYaO0VozQUJBm01p8dvdcP5mrSduWeu2581W0D
	PUOw7Ju8sYN52RXj0zbY75FdmTWu7jfp1wlT33VK6BJ20XjwDlTCZOw/Dmt5jD7LQGpV7o3BY7Y
	Cst2b9PpnFTOviZSMRtaS4CiS9DihUBLzv01DWc3EEPWv/dv/CVRlKfPah3i+P8rk759rrKIOrr
	wtGnmMYpUMT68+2Nv129Y2+lKjuZhZi1tXxmXytk1KA2o4gnEMPkkEk62StJc61pzwHtFIn5KP1
	imHXZUghebMPmUYWWKKo3Q9YYKdzb
X-Received: by 2002:a05:7300:724c:b0:2bd:d8e6:90a0 with SMTP id
 5a478bee46e88-2bde1d1535cmr1841036eec.3.1772360032199; Sun, 01 Mar 2026
 02:13:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260301015836.1724150-1-sashal@kernel.org>
In-Reply-To: <20260301015836.1724150-1-sashal@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 1 Mar 2026 11:13:39 +0100
X-Gm-Features: AaiRm51kU1xX2n6LHsSv4jLUf25Ra4JIJBszCLjU-FUJZnmegoJJxrWL8NcxIrI
Message-ID: <CANiq72k5hJSJDBF=opAzY99ZTCQmUUkGgiFWm9wCQPkQ2WyYVw@mail.gmail.com>
Subject: Re: FAILED: Patch "rust: pin-init: replace clippy `expect` with
 `allow`" failed to apply to 5.15-stable tree
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, lossin@kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-222439-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 4703A1CF0DA
X-Rspamd-Action: no action

On Sun, Mar 1, 2026 at 2:58=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> The patch below does not apply to the 5.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

There is no Rust in 5.15.y, so this is fine:

> Cc: stable@vger.kernel.org # Needed in 6.18.y and later.

Cheers,
Miguel

