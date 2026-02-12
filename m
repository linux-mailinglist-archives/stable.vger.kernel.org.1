Return-Path: <stable+bounces-215949-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMxjH5vDjWlt6gAAu9opvQ
	(envelope-from <stable+bounces-215949-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 13:12:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA6312D54B
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 13:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93D4D305AC98
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 12:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF04356A2B;
	Thu, 12 Feb 2026 12:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3+T4inr"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBF634AAF9
	for <stable@vger.kernel.org>; Thu, 12 Feb 2026 12:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770898325; cv=pass; b=sg6Gd6CB9nL0yGhSoEsd8sF/pLC6bBCoReZ7RDT7nGEdLSMDfp2h0rq36I7bxx6f3M8akYVpncbKOFt2TN4b9QKjU2v1GZOjFt4MTYcUU+NXbqVImi34wWmQkF4KePmXqVRYiS+uFENzia2XKULKAH5mZWOCqbJ12blACPl3cug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770898325; c=relaxed/simple;
	bh=hdNJuliFV+u1aeBSpWRoouGk7YA8j6s817VbVZUsNhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j6wC17P+Tqm/K20nfDxzuYOr+5CHk7jnbB6t54Pa2+W4VtQ9tqDlzrYIPu49WlHMFJSIbArRHjvNUShB1YNlmpJ+RYmkjxkPcgKCtiCE5fbtYSrt8i5Q8EBO7nsE1l8ooVLWHYd9aZpY64y1J+TZDe5d3goi7u+LSbEbJfDovH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z3+T4inr; arc=pass smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2ba76e80509so318329eec.1
        for <stable@vger.kernel.org>; Thu, 12 Feb 2026 04:12:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770898323; cv=none;
        d=google.com; s=arc-20240605;
        b=itfJLKv+/Q7NPN1Y1NvaMtgZCL/RAPE/TEADGRbJZyZNTD7n4CVBTHgoC9oNdX3L8C
         DqqtT01Q+MlkE/Vwi+V0S1aHPhcl82G5zfd5vHAwdNHG7HTrQ2HtpJYpvViBSNWjlRty
         obJpmjV+DbhvuFhFhn636K6qHJBUPwrCDEpEp9pH8aTaKng0fLwOvsuSf+R943nrQNqt
         FGIbDXNiHmcSYaFCcZTfWdcet+1ptVmu9yle24Fk6Sfy1fBBwBYu8DcpDTP3Xb6KJIOV
         FtXJB307KJsf2mP0MPkZ8oCUdPPSeJX0ITo574crpGiK1/rnsLDvCOZBFU2hnbtw6fMY
         p9eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hdNJuliFV+u1aeBSpWRoouGk7YA8j6s817VbVZUsNhU=;
        fh=UcwNukraXF7UnYx4JtWuUubRk7gjiLTgVnsat+VAeEg=;
        b=SpdVYXS2/8+B/H2p9+YWg7Y5zpMSVTZF6QVjorRIBihbd0LVgp4KBsq+pwGHmCNlJf
         pY0qbLM7KfQXd74bugn2WQXSSzyh4O6EhZgCzAHuHf71Pz7LI/IsReNd8CzdJyu032Q1
         KO+vaLDMniQswhsafAqxraySSu2LtktrJtZs3lrBRXFLKswVNhGX+o06wTczrg99z5I5
         JcnAv1VDWzoAgqHp72kCWm7DMCtjcc2uErZflsGQPSp8KmcQ+eqz/a3WaA6LSUkceAZd
         NQnT/GRSd1gjBbF70qTmySTzjngdxi3c3wahzaWaZEWvnH0tGbd+K0NZXoqq/uY3z2XZ
         N1fw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770898323; x=1771503123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdNJuliFV+u1aeBSpWRoouGk7YA8j6s817VbVZUsNhU=;
        b=Z3+T4inr9efHMeVhgeHMznhpHHjfeni2n9ADLxyFL1PsK0gqZILhkKz0cgK3d59gnc
         bVeiHmEJRdOSuyH0O46irymHBchIx9gALw0OKXS/sg5CMsbWs42J8YoRVHMhPQ9am4mW
         cKiBFoj5MdA7wTRbIvvw4akr6ZJxswxeoPaqD/NLkqtk/PmYp/3Ki0eRv+x5Mpoe9GCo
         yW8mDzvFnjBo0SIIt6viaC/iOlbbNzUXCDsnkDisLOk56+thnZBlXxzBEB7PQakj6UYO
         66hRj7k2uU4kYMR9hjODwdCkpGiPNIGTtG4rcLS6i+JDVm5MuRm/PR4qET/BOMRgWkVT
         b6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770898323; x=1771503123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hdNJuliFV+u1aeBSpWRoouGk7YA8j6s817VbVZUsNhU=;
        b=LPfzBvROKhB/QPADoCcqXjF45qy8cRLaoazkGwd/fgBI5po1tYd7nbKavYiXSoifaI
         C8dKdx1Vx0Uuz4Dj9lzclUR9UU5odmRVhW0Dp8yKIWsumHJ4dNhcbjwQaHgbx78kwg7+
         tx12KDyavNKsZCh8Kf4nO9cECyooqyBd6GtL8il76rsjhNp6nF2zE7C7dovbAjy3U++z
         MATzsqQMkZvwUl3nWf807IU1PjL7dpqa5kzerboajNOeEVop5WHaT3JWFgAR6/FnFPS/
         zkBwqS0r9WFfyDCzgU+4Pgwk8qTzc2ZOzXhFGUhAHt7MNcuXUIQd/PLQvxNzyUECKMdr
         OgvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLvo9zOABclnF7kX0TDVBBDPuRHQupme7GMc8XXS3IVoRxggauOD129h/J3HFIDjO36guCApI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbHht0ps0vcfq1cg5lKjKFfWfE3GQlN56gnZ2Lz0nE1bzdBJSV
	t+6K/8ZL6n/LBl5HyDxt18NOflw2y3l7FEQTbSToNYPPtchXf/yT6slxX4M8v/KfuMtOjGTL4Gt
	uva4VJjqqZWqlFNQBu+izWJGHzIlawNY=
X-Gm-Gg: AZuq6aIwkSlxT/vFHUy58KXLZGcHo3ft1BUmjtm9aG1xJqpl55LzllSQBM7T0YcHdyu
	uzWb+FlP1hiOd6mKToEbsfW/YzNeadLVvhBOSA8qCYKE5Uc9J5HykzHQhXH8gTbmfsxdCQkAxXT
	HogedAo9uOnraaYLIFzIwD7CerscpCDCe9fClPEMqBUKQP4aI7+EOAwwIMSIo9gh/AR26IKO/rI
	zus5jZes7J8ig7W/VcdTKbGqriCHdWj44nG+cQT9ZJRqvxIup6Hv1ivQaoPubkPrQNRKDIbtxWd
	kcjhdQ4C6Jglh64SH4D2iWXelbjV7RPKX1zPWY649MNUj5yGq4GBo4byA+/LRLDyanThzl2gnlX
	NosBgqc0BnV58P5wgA8t6HapI
X-Received: by 2002:a05:7300:cb0f:b0:2ba:6f02:2939 with SMTP id
 5a478bee46e88-2baa7f6a42bmr632842eec.1.1770898323327; Thu, 12 Feb 2026
 04:12:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212010955.3480391-1-sashal@kernel.org> <20260212010955.3480391-23-sashal@kernel.org>
In-Reply-To: <20260212010955.3480391-23-sashal@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 12 Feb 2026 13:11:50 +0100
X-Gm-Features: AZwV_Qjq6JjCaY13QKYBUvVQv4H6RyUaa8vYnCFiiN4Ovi19FySxcmcySYnCq5A
Message-ID: <CANiq72mi6_UrGoFs2=ch6AyKP0hhCon3epSkXCzwiGUGmfswOQ@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.19-6.18] rust: sync: Implement Unpin for ARef
To: Sasha Levin <sashal@kernel.org>
Cc: patches@lists.linux.dev, stable@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Alexandre Courbot <acourbot@nvidia.com>, Benno Lossin <lossin@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, ojeda@kernel.org, shankari.ak0208@gmail.com, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215949-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,google.com,collabora.com,nvidia.com,kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: DBA6312D54B
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 2:10=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
> This is a **build fix / type system correctness fix**. While no in-tree
> code currently triggers the build failure in 6.19.y,

Hmm... If nothing is failing to build in a tree, then I don't think it
is supposed to be considered a "build fix". It may be still good to
have, e.g. for other backports and for downstream developers/vendors,
but it sounds more critical than it really is when worded like that
(same for "type system correctness fix" -- one could think it may be
referring to unsoundness).

> - The commit is still in linux-next, pending mainline merge

Wait, shouldn't all stable commits land in mainline first? (modulo exceptio=
ns)

...ah, it is actually in mainline, but the AI checked linux-next only
I guess (?).

Would it help to hint at it in the AI review instructions? Or, if you
already only ever make it review things that are picked from mainline
anyway, then telling the AI to avoid checking that?

Thanks!

Cheers,
Miguel

