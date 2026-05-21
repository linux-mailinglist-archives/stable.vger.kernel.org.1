Return-Path: <stable+bounces-253416-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IP1sOTxWDmry9wUAu9opvQ
	(envelope-from <stable+bounces-253416-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 02:47:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9653559D64E
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 02:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 854003028ED9
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 00:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF5B24BBFD;
	Thu, 21 May 2026 00:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmBkn7+6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1851EE01A;
	Thu, 21 May 2026 00:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779324130; cv=none; b=IlUpjEZu0jd0LoropH28b5hJO0wMEewTLMDEHUJViQy58x40Uh29iKsKtxgYdPSkjY7x8mjwBhHZHqhsL1sQW2WgXH78WNlSTJmkgZvNRaEbBAN5Y8Hv4u+/iHY5SDWE2jdgRrqpU02FknUJNKR9Fwx0cIQy7tIAnmKzVbEuQGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779324130; c=relaxed/simple;
	bh=gE2xu90fi77DNXjCGh+yn+KWReZ7OnfCt+9yTRURpRk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GvZyjF8ErT97+1PhXce1d47FjpAYGcMWZoMk2d+I6W3QFkC1yJf1blYi0/hZGXyVGkV1jq73cLuOCdaY0ldBYW0te9BRsk7EUY9m06Ow4ZXGvfB2bC458hGfBocPP8DBeYLyBVtSbpMdW8OBy9AOx4jn32h8oEy6VJtZqnkNfdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmBkn7+6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98DB1F000E9;
	Thu, 21 May 2026 00:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779324129;
	bh=gE2xu90fi77DNXjCGh+yn+KWReZ7OnfCt+9yTRURpRk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QmBkn7+61GhGmw2KAVBy8s2DUtwB5RjOdZaq3seCTfWxUTSye7DdCg8ugFvciRRXE
	 tQOmvOfknd+6q5n42PENujyZtIFkZDmb2gDezQizIMRmzr7qP7LM6yu32e2r6A7Pu4
	 XLBuPxWgj2UB5NugiXjsXevon+xwkTQRXnCgu3HxByi312TKQtJxgxkjBcqDOHkXRg
	 yfaNAK5w6zyKoJmHdV13dMSn5Fl5FjsbvEF8qLJCYd20il7fOxFx+aVm3DMb9vVseP
	 L6HXd/Jy3rN7hYAJ6z8BcCoKBNS6jfrVNQyLEc5H/61oPW4eTSb1JBRZYsVXTtxZgG
	 SNGz+NWA2E+eg==
Date: Wed, 20 May 2026 17:42:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz
 <luiz.dentz@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v3] Bluetooth: L2CAP: reject BR/EDR signaling packets
 over MTUsig
Message-ID: <20260520174207.5f8f26c0@kernel.org>
In-Reply-To: <CAJJ9bXy1xQsfRd_DBiFjTj6GjkDDVFU3w_5xjXvZmp8CXnkz5g@mail.gmail.com>
References: <20260521001327.3729880-1-michael.bommarito@gmail.com>
	<20260520172609.3034337f@kernel.org>
	<CAJJ9bXy1xQsfRd_DBiFjTj6GjkDDVFU3w_5xjXvZmp8CXnkz5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[holtmann.org,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-253416-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9653559D64E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 20 May 2026 20:32:28 -0400 Michael Bommarito wrote:
> On Wed, May 20, 2026 at 8:26=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> > Please (tell your bot to) use the get_maintainer script. =20
>=20
> It (and I) did, but I think this is because net/bluetooth/ matches net/, =
right?

Looks like we're missing an X, sorry.

