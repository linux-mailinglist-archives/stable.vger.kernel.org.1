Return-Path: <stable+bounces-241358-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEkWIlOD72kMCAEAu9opvQ
	(envelope-from <stable+bounces-241358-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 17:40:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCDF4755C3
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 17:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2127B300EDBE
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 15:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF663DDDD0;
	Mon, 27 Apr 2026 15:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZl7rvb8"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8919E3DC4C7
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 15:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777303822; cv=pass; b=fLk5abu5ywVrsuEB9RzU/Cd0uoXRMGcX97GzUbHcJy8dR4KC22xQ/YfUHi8wRCW0n3vYD3j8L2EG5b9rwZxlnJyQbqy8qPQmdoB7rLzxQSiQhhVy0csiYEod6/rAj/gYBb7FDCQK+SnS3ZTTa1/2DfBBA2HcF65tO0YcHOoJ7JY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777303822; c=relaxed/simple;
	bh=GCwKatNNar+3ytGo3nZKd7tNZGkjdIGeJgU5RLwcvj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h+hkiMbx4tyxVmQ8wKf/dcLyB6nIK3/ewLOWwRAOipUX/5HR/EiQE7W/7I1cluRvTublXGq8+6i1Yumeql535TlXe5JGCkOUQNoEILQvhwAgXn/RBDmE8evZgrN7D1KbI/HzAKAYwVHk+KL/W4q45v+g1WRCeN814cuHtuNYF2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZl7rvb8; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64937edbc9eso8918123d50.2
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 08:30:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777303819; cv=none;
        d=google.com; s=arc-20240605;
        b=XwW7MjPmgJ2aH51BckEkr0IPP9Cx7z2i6eDchymKlu4NAM3h9WPExazbJ+rU7aEQvs
         juiUy5/cCzsNidwh+tUFoUXDb4dSJXSGtQ71lOz5EfKxWK68HA+r68V/fQRsLZJtwcT3
         iaa1vKFlwxo+p53WrbHTv6587qnLSq9LDbKvcxu2fHtdkXnGkWDwXCeFZNhhfE1P30zJ
         I+RSAP1Zg/EVBJ0rlc/LvkVzL+fxIcZK0unCY23XcTAdYCZUoX+ZVI3+HrgUk/NpgiEx
         PyAlZF8UPy7/O0wjHbEN4cdheM5R9NiyRVH4E7usSjdQWTuu538dfUrQ06+hW1bsjy0F
         zGOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wopAs40F+RJFZTUGjaEGMPUBPuNhbGRlaz39GhporOM=;
        fh=UtkQ2M/Y/l8uBQI0aPJzy7/N4poTUYCJPXEXXOOpRFI=;
        b=cVIiitNDgoWqf5G9BQ6oZs6GomSHg6Qq/qsowTotIoEPV0wErpsaAFS8kJ8VJg5jeZ
         n8lB+9GrBpMECLW+5tfMoWXgsjkMqVgi3uO0a8GHX8SI/Rm5icVxCVYoSgvkLULerstO
         ZkBs2MkN4WRPH90SkRrh/uYXwkyvRJpox+sn68hvQbowCQ2mT/gaeTwXj9na7/9pQoCP
         95PYrrWgJh/IL/TwZJJNwrjv589pM973S0Xbc9FPYCUU5xAJErkYJfKbkCxwRHda6O06
         jsvpq/zaPDILsyhLCUBImO5W0TADs1XezCFPaPnMqpS5CvBkeNcM/EOFRgWgLVPWzZrK
         w0Gw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777303819; x=1777908619; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wopAs40F+RJFZTUGjaEGMPUBPuNhbGRlaz39GhporOM=;
        b=KZl7rvb8lf+sBbOnk4jHtaoH1vNRh94P/hVDm7+cs2/FKBCPa46GXQ2tp/jWtyeVI2
         FA8mxlmk7eKobRckE8qSOokqGx+oGCFY3ZQAvSxaAI1wxA5fvf2mVUexoG/icCVk1TMy
         KyYUVyzKUXyvrZQF1bs8WZEcGS2g9fDj1tyTPUyPXKHlQRE5Hdp24jNdA2//pZWA96Sb
         OsIc7ZX4RD/5GAwqiECwwcVmMtsZn2WbENhakwf0Qni0yZvNVabQcI5468V+4ToznKfl
         QmJW5/DvIuWgVSOcCb0Zib9yKLvE+tsjWJcbrb2yFhHOnjWR/gfSztjZx5lQ7cItr91c
         eUww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777303819; x=1777908619;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wopAs40F+RJFZTUGjaEGMPUBPuNhbGRlaz39GhporOM=;
        b=qccT71WbJWBsNG4WIsoacS0H7UpGGDKp9HHgnvPAKwk9NqdbSUMHRgGH6kymqPgR+S
         YdrUWU7RnWDVXayOmjusqmRN2MA4e7RhAH273rrMB8bJp+WR32FAezPg2TSo3yXPqHXA
         /IyqUYanCQicm9fat3fP16aunvvXnxkM6nBw1s0hw9ujxq0Q7vOthMkV6fNn1cniscCP
         g+G5F5C07QovXTqj4BYkm6x46/QXoAyGwNoCGKarloY7aW+8jHs0N8aVbfT6dg9g1yQG
         7YpRCc8MLBdHOr0jQivKnjtU5qEqx/7yQPwoGMCLopIdFdtNUzVcvxcdb+n93UulSEwB
         rC/Q==
X-Forwarded-Encrypted: i=1; AFNElJ89pKVWLtoS2SSmEK7qDf3A27tLna6K5ctse9IuimXDRInHZivh6dj5l7OlCTiUV5nuOWOP7aM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH9Pc3dP0lFRocVwoj5UTsnCpjLJqF4nFmQPaDJirrwOzLet0Y
	HSGsD70ip+0hIOvMMp9lI8I8zPGHaoOThKwZJKSxfNJosbJG2aKUp0JlmUqKhMWZ9Ks4lOQzfhz
	GnOvO8BccMv6MrFvVhoaO5calqfxtB00=
X-Gm-Gg: AeBDiesyLw7HmwiniMzgIiHa3349mFoISTn6GqMgUgNxANQMN5idqAjxLH1xcaYSzrr
	S49gCg4EoYZXdoGCHyAP9obtQ0MCkXsrxx2n5r3Ow9sgMWlYZwZGHSvukMGrNRXFn28YHv8C1K4
	p+dtAiKQK92aPpSzIJv76O16cp2XTNNMH6mmqitx73G8d8hlOh/UeLwpPZsCWJPXgrorojpclyk
	4w+OZQs7bWOY2/KmkOV+oO5WmmCM3oqqDep1zPyYamw7vXP3EoLi6dZ3cm8MGHuIMiWgouGCLN0
	BX//KDwvvY3LtpH+SaZG
X-Received: by 2002:a05:690e:1918:b0:654:9654:f91 with SMTP id
 956f58d0204a3-65496541a13mr15482214d50.46.1777303819396; Mon, 27 Apr 2026
 08:30:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427133107.334429-1-lgs201920130244@gmail.com> <982f5452-36be-4401-acac-c9f8ba8ff83a@rowland.harvard.edu>
In-Reply-To: <982f5452-36be-4401-acac-c9f8ba8ff83a@rowland.harvard.edu>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Mon, 27 Apr 2026 23:30:12 +0800
X-Gm-Features: AVHnY4IGM9jn954jisHrVPvAVF-ro04mTTaDdyMTsp7VWKWZEgW3x5qekBjo2Yc
Message-ID: <CANUHTR9uTfR3CQF3RLxYVWFSoGZ8B7yV=vowOqx4BBWGHk9Srg@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: net2280: Fix double free in probe error path
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	Chen Ni <nichen@iscas.ac.cn>, Evgeny Novikov <novikov@ispras.ru>, Felipe Balbi <balbi@kernel.org>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 2DCDF4755C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-241358-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,harvard.edu:email]

Hi Alan,

Thank you for the review and correction.

On Mon, 27 Apr 2026 at 22:36, Alan Stern <stern@rowland.harvard.edu> wrote:
>
> You should remove the braces in the "if" statement as they are now
> unnecessary.  Also, the Fixes: tag is wrong; it should say:
>
> Fixes: f770fbec4165 ("USB: UDC: net2280: Fix memory leaks")
>
> The code before that commit was okay.
>
> Alan Stern

I will remove the now-unnecessary braces and update the Fixes tag to:

Fixes: f770fbec4165 ("USB: UDC: net2280: Fix memory leaks")

I will send a v2 shortly.

Best regards,
Guangshuo

