Return-Path: <stable+bounces-211910-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aK8CDld1eWkSxQEAu9opvQ
	(envelope-from <stable+bounces-211910-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 03:32:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1749C4A0
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 03:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 439F1300D324
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 02:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E8E298CC7;
	Wed, 28 Jan 2026 02:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j16rXNZO"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21A029B216
	for <stable@vger.kernel.org>; Wed, 28 Jan 2026 02:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769567384; cv=pass; b=OltlImdbwpVK9TpiyUL9+/KWS/e/hQTQQDMTcGtwprCQphrKRUWDrzwuZYDxoZajLYVChdtdUf9fZW/YWk8kepypNN7cMKUe7Tx87dmi7GDBgdYfeA1ZjGJcfDxUthU0KGR9jU66Ch+enVb8/4wFkIbqNWUAhI8prdo5se/qlkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769567384; c=relaxed/simple;
	bh=V963d3b3AD9Oy2rNmVtDx9e9R5WXsPaM2sd5/Cu05Lw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kmb+wtQWDB0iuPujmVdw5bzef9gSJqHJzusdFpJMSv2PWQCf04IsZSft7dZWjzFaMetv1T9PKFoP8dLdGedj/A9EWCSWTS6YfIOYR203qFGNwSPthQ4rbiusWmXdYdszXTARemkEhC/FV/1Fviu73XY3HQOBNgM5sx0DV+b1MNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j16rXNZO; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34abc7da414so3541112a91.0
        for <stable@vger.kernel.org>; Tue, 27 Jan 2026 18:29:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769567382; cv=none;
        d=google.com; s=arc-20240605;
        b=hBwWgeshAChTUUxiGxO2ONgAwF0ujNiB0ddmaifjwCnT1SNptkfEghcgFsFNczVx6I
         gnEbaWtFcz3tM9eJufDoywh/Mq6iAd02snK/V4gbLsEXVgNw3b16QTN66bXQ65GMMtO9
         tpPgGKfHO7EOIqyGBNOW7FnTSXzHplNITGvJSHp9TBPfLgdSwa5S51Jw8cwr336wq+hg
         6PfEWIlFCI3xUpVgFtLyegZhJ8dyqR/ZhMRBXq3oLzUDnatllRpyWQenPUQVp8AXh685
         sNOSN5IB3nzlcl+EeHNs3DTvWociWbF4RQvLRXTx5GWq5OV4gNerwMl7RNrqp7LWIDQq
         GA0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=kqR0EGH0s+NDWAFGm/wPUPQe81g+9pCgJbwXCpHmMJA=;
        fh=1B6abWkBW8lGWqbYrSZhIFezpH3fOVNisbZTR6K3R9I=;
        b=ZZYKAjTs6Xif/CgDrFNpYa2SJGaMXXynAKU0f8mmhYGLRuY5GY7QI12pFrWVJFtsed
         CA5vUZtnbvn9uwdelYbRPW4pYsPbO1JBWtdI/4av/2T1L/HgcBJWQlfUrzkIeC6waWYn
         2kzZQDwzgj0Nci6sgFHPk3u0PvLWbUPVeyKYZhWRUpbdfGVM1vXT8r4qAnMBfrk8Hd6J
         F1ESkyT3vFx1kdKcy9f1EbF+VxZ5F8wEu9riFa1aasa+05mvp0t64JcGlaXsWpwrpdd0
         kVjyXpSBpNPWxiy34YdLwse0gO4ugmE+QR22rn6xzqPyF5JHMzqV8DHjibGbZVGYWYD2
         E96w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769567382; x=1770172182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kqR0EGH0s+NDWAFGm/wPUPQe81g+9pCgJbwXCpHmMJA=;
        b=j16rXNZOsoHTXsUDzi33cgtcnICfUq30RwtYmtlO8S6yt4oNnD7itABIyMBGTmHIb4
         GD5zoArMeeHIzV8pppRl0jNB+pEBx8bWYya3jzh4nrGV1zYg6uWMYpw+WHX5UoRMrxzP
         /7DVmshyvwZEFl0rS6vSiJb9Hr74VTqiDbuKBfZlJ7hKzNk0UY04xy/xLO8V4sAvaMDr
         J4hWf2qfHmU+BLlfMZzgbRo/wj6nS4rBqpAwcQ/JpN5x/zEMOS2YI31JrQK6egC43lLH
         lQoAdkEHsDZrF7LQLu3hgvQM++F6B2sodaqFvkkq68+tVyaK2X5S+pBnEN7eVMlMRWlZ
         +cpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769567382; x=1770172182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kqR0EGH0s+NDWAFGm/wPUPQe81g+9pCgJbwXCpHmMJA=;
        b=W5aBQfX/xP7xPhBqGCJNuv1zanqHbKY9DEJKq1BVGJJqfRAIqmUzfKJnSRGxg/af2w
         7FE/zZhoVwEZgO4/f9lbj664A9FftGeFNAG3SZdqSL7Bg+YRtatdnC0QMMibIEnAyC1g
         wsIYrN+SMhZeRWW8Wte3Txopi/yEwluibHBCES+3LmuCsaRid5VW4XteSphpdNL0ztdc
         XtK/dhayzUK6vZ0GhU54sp8vI/ISBNRDPe1edkQuZWf9XDIpfSYuV8ODV6sIqmzVS6F0
         HpA+K2saR4EeGMwo77sc3rZ7kfr58SGQ81OJssOznVxQ+FNIRS5BEHglTGFqZBFBTdm3
         8BfA==
X-Forwarded-Encrypted: i=1; AJvYcCU1XXqEWOYcXaKF/2OSCgGGqdR2EALzCLiVTnbpOyCqUGYYVSHEGXULgDrtJwKkQANRJn1VRM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU7vuW2tieBYFQaoFFHZgqWD17yjFWvhrP9kWUr69nwxuwl062
	eAHMVuEI6T9Y+g0eHqrJrCBDQe2zbmxiWz7HJ8E2RkUP21eRzQN2hYFoJhGYIr36rwt54QNm0c0
	gVvcsD4nGvYxQZrw2EVCmvxz/eugDGCDRyV0tSKXrGnys
X-Gm-Gg: AZuq6aJ97vw3WQLizy3voTCgi7JQxHhsz8Krdz8WRffd7Jd08uOjadrCOGORWuOGrNL
	m1cLl5hrog3gRm+Vhk4cIDazm+d41fQFssKL1jtrlJFhk7t9UM1sJs4hzbYcQL0FLDcmRMksRXq
	OIiNjRd51JyCOccolPxsWQ+9wrQa+1cqMjTZf1pcvF9U+su1jbn17/9yMYrsKzFeKD5jdRP6Ksh
	zge4CmU0Mc/BLZg91dDaZGTRcmLeS2dNdbrsPcUGoiMuK11vtyJ0+XgwT7BGCOOeXb35A==
X-Received: by 2002:a17:90b:268a:b0:349:7f0a:381b with SMTP id
 98e67ed59e1d1-353feccfdb6mr3408881a91.8.1769567381930; Tue, 27 Jan 2026
 18:29:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260117140351.875511-1-xjdeng@buaa.edu.cn> <2026012631-suffice-enforcer-8553@gregkh>
 <qbuccwnfljpnxvpp7vl4weoecx6ujg3cy2lwwgoz42b3ux5o3k@mi5fxhplgrt7>
 <CAK+ZN9r+oCbSNjSf=yKQHGT9=Cqfw02J+TS3eZaUgrd=PfV7tA@mail.gmail.com> <2026012758-sacred-slouchy-45ca@gregkh>
In-Reply-To: <2026012758-sacred-slouchy-45ca@gregkh>
Reply-To: micro6947@gmail.com
From: Xingjing Deng <micro6947@gmail.com>
Date: Wed, 28 Jan 2026 10:29:31 +0800
X-Gm-Features: AZwV_QhYBrCrfZR_nULpn7Nxu--kk-dx2_AX7m36P0tiMnJ_cLqdnNHjxHvj35c
Message-ID: <CAK+ZN9pBSY1bCbMQMoOj0qNQKvEwO_j=zxLnDcA_4O9AyL+uHA@mail.gmail.com>
Subject: Re: [PATCH v5] misc: fastrpc: check qcom_scm_assign_mem() return in rpmsg_probe
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Bjorn Andersson <andersson@kernel.org>, srini@kernel.org, amahesh@qti.qualcomm.com, 
	arnd@arndb.de, dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xingjing Deng <xjdeng@buaa.edu.cn>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211910-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[micro6947@gmail.com];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[micro6947@gmail.com,stable@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7B1749C4A0
X-Rspamd-Action: no action

I understand the current situation. I need to record which static
analysis tool I used to identify this issue and clarify that no actual
testing was performed. However, I have a question: my static analysis
tool is not open-source, so how should I document this?

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2026=E5=B9=B41=E6=9C=8827=E6=
=97=A5=E5=91=A8=E4=BA=8C 15:10=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Jan 27, 2026 at 10:18:38AM +0800, Xingjing Deng wrote:
> > I identified this issue through static program analysis. All other
> > callers of this function validate its return value, so I believe a
> > validation check should also be added here.
>
> Please don't top-post :(
>
> Anyway, you MUST properly document the tools used to find issues like
> this in your changelog text, as our rules require.  Please do so.
>
> thanks,
>
> greg k-h

