Return-Path: <stable+bounces-270132-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QPRYNZfuRGra3QoAu9opvQ
	(envelope-from <stable+bounces-270132-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 12:40:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 694FE6EC47D
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 12:40:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=PWAfQ9gf;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270132-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270132-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9B0EE301AC34
	for <lists+stable@lfdr.de>; Wed,  1 Jul 2026 10:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71ED241931D;
	Wed,  1 Jul 2026 10:40:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EABA39021A
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 10:40:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782902415; cv=none; b=MKQyK3qriz4BYg3msGQG7VeEY4Vf7NS7kdE4tnIzsnGySql0jCa7LLx7ShrpK8XK4Cqovnuo1EZsLmN3/vCEKQY9cIt5ATr8pIhmLXCN8pPoO9CFZBCf25cjGz3auoQM7Fn8Le1wMbVFGMdAYtxNppRhiPx9HxFQY3zWm1R2dqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782902415; c=relaxed/simple;
	bh=8tljfG2MYEam8t8AtYWWq514QumbdCKZEA9GJU7iOJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B7W8OS8rsLQIEjgDl2Ix8+znhF0Vk03EZjIjaogxHJsFmH8XiSzB+GK/HBBaYnIhUDDeNxKsp9HcemT7GRxmtqN4H/HzzmuWZtEbd7M4zUNIVODdxKR2AJgeDdRWgXTg3NVoCKlwvprjH3GOMg7AUARseKbUuS2NvXzZKwKu5Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWAfQ9gf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14FDD1F00ACA
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 10:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782902414;
	bh=8tljfG2MYEam8t8AtYWWq514QumbdCKZEA9GJU7iOJE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PWAfQ9gfRc2tIqooSGsK+54jXObfq0TUgWaeCNe6oo2MTu5F4UT301EaBVa+LgIRB
	 Yef6HdM70fr5hwqh7cK5YgPHXxVgoUv+yala1AP7S24GLfikZm+Eqxs69Vw88E9fQN
	 a8ZZcM2PQfA2me6daLGBVQ4yeF++2E0D8gCyunDtlNag1XgXSpdM/nAJntVxDyZNDl
	 rmNZG4XJrcVsWW4oD5dC5q1KHiAvyentz5B19PTcd4AUadfmJD3HqqmzFY4GeNqG1y
	 v0xMiJW10bptq33PXzPFUUz/2Xqaml/9bmdEuZsMdfUjo75tE+yZHdWcCeHdrg2Fio
	 QRIWM6T0H8PIA==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-39957d210f4so4841881fa.0
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 03:40:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rqo9fFtQL+n8ZWS6WwD3jfckvwsctGptHxtJt6yOATw3TJ+REwI8oVC8xPi+rsRmF8cxGL2mno=@vger.kernel.org
X-Gm-Message-State: AOJu0YwttZhT9LjVb+O7PfbwZIqPyt+HzifNs/Z+sshLVaFjddWTD/g4
	rP4l97bVrygUsQ3SzRUHx0ZB4PB6aprTCRTvcOKvL2Gznr1Im8vEeaw05F17YGwsxQxkuAn1P7Y
	l2OPC1QyEmrDBYAAAYotFZ3n3oWP/TVU=
X-Received: by 2002:ac2:51c7:0:b0:5ae:c62b:fc45 with SMTP id
 2adb3069b0e04-5aec678e657mr216415e87.9.1782902412908; Wed, 01 Jul 2026
 03:40:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701-arm32-cfi-bug-v2-1-9bf922593e00@kernel.org>
In-Reply-To: <20260701-arm32-cfi-bug-v2-1-9bf922593e00@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 1 Jul 2026 12:40:00 +0200
X-Gmail-Original-Message-ID: <CAD++jL=G1-2A-h7oXxq3eUhKLLpNQq8D3Sgh9nYK_0Q107wf7w@mail.gmail.com>
X-Gm-Features: AVVi8CfLaDi0Can4D2LJnFOq4Oq48vw-nrn8jVWNhab5RVBKiDNrfMZHd8GfN5E
Message-ID: <CAD++jL=G1-2A-h7oXxq3eUhKLLpNQq8D3Sgh9nYK_0Q107wf7w@mail.gmail.com>
Subject: Re: [PATCH v2] RFC: ARM: breakpoint: CFI breakpoints only on demand
To: Russell King <linux@armlinux.org.uk>, Nathan Chancellor <nathan@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, slipher <slipher@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,protonmail.com];
	TAGGED_FROM(0.00)[bounces-270132-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux@armlinux.org.uk,m:nathan@kernel.org,m:samitolvanen@google.com,m:kees@kernel.org,m:rmk+kernel@armlinux.org.uk,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:slipher@protonmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[linusw@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 694FE6EC47D

On Wed, Jul 1, 2026 at 9:11=E2=80=AFAM Linus Walleij <linusw@kernel.org> wr=
ote:

> This removes the stub hw_breakpoint_cfi_handler() from ARM, making
> it not steal breakpoint type 0x03 (ARM_ENTRY_CFI_BREAKPOINT) unless
> CFI is actively used in the kernel.

Was meaning to send a non-RFC of this band-aid patch, but missed to
strip off "RFC", mea culpa.

Yours,
Linus Walleij

