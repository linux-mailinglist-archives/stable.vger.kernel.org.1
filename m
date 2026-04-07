Return-Path: <stable+bounces-233691-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHytC6I31WmP2wcAu9opvQ
	(envelope-from <stable+bounces-233691-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 18:58:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A753B221D
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 18:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB0EB300C580
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 16:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FD83CFF69;
	Tue,  7 Apr 2026 16:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Ls3nL4yy"
X-Original-To: stable@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88423AB269;
	Tue,  7 Apr 2026 16:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775581068; cv=none; b=ZwDOWL7EvCJD6K+2GZ6K5yhT0Ldi/5tPnPRuEB1Sg+KO/Cf/INb4j3wYoqCo+FLlvpKPkA4D7mZDW1IeIb5+PRpmB59U7/m4Ld/8JWtIKhz83B3rYD0HuxiD+SJg3IogyTFaw+6T6NMs6nWfVGXqTRaVj8nR6+IN7m6fgMRqAbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775581068; c=relaxed/simple;
	bh=sJ5G5YsT63UOR7NcEKlBVWmXyVQYPvuzuZuNY8ANmrQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c/QJvoTI8S8ERtsaQ6fFQ+FJLtJC0J8l5U6UbWs54rNZ5rdwOIBE4zgEg8PQGkK3NWiHyXRlWsidI0nYmvx70qYD4KgEGD0p83AV/8TwpFX79uAapPXjVWB7XbW5ZEx+AfNbyG8lZV6q31s1IsIqIt4w11RAvkiwjDnQtDa7FGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Ls3nL4yy; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=sJ5G5YsT63UOR7NcEKlBVWmXyVQYPvuzuZuNY8ANmrQ=;
	t=1775581067; x=1776790667; b=Ls3nL4yydkHJ34SNefQfPcfQOHgyQ8CVvTuYWP7OrDj6Lzm
	qyq5CDy7vIJv767+vQHQWdxqbcznek7YOMGodJWbnyo4+xtw0ul73O2jeA0PTj/5ZFuYMtZiKWP6Q
	kV5ZQH37iyDwyqWedK+vPrMIidjDHCRcB0eQ7IXGDu3Za3CczfVmTBNuvFkDsZDAnVuNxu3ttRBoq
	R+5maEM200UKR6NuQugTALhzX5xZrOtzPtEE20f9SKRmmAt20U0S9s4krjtis6Gr8UWe/DOMlb6CE
	b44kv+DWZbbsF98rycrA+SgucNJSC2eee36lUxZtpn5gLlauSUcNduRvRB05oCtA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wA9kE-0000000D6j6-34ml;
	Tue, 07 Apr 2026 18:57:42 +0200
Message-ID: <1e15d25c23b444eae1dcfc01432e7ec1e19e25a0.camel@sipsolutions.net>
Subject: Re: [PATCH] um: drivers: use libc strrchr() in cow_user.o
From: Johannes Berg <johannes@sipsolutions.net>
To: Michael Bommarito <michael.bommarito@gmail.com>, Richard Weinberger
	 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Tue, 07 Apr 2026 18:57:41 +0200
In-Reply-To: <20260407164435.726012-2-michael.bommarito@gmail.com> (sfid-20260407_184531_208780_F1065C70)
References: <20260407164435.726012-1-michael.bommarito@gmail.com>
	 <20260407164435.726012-2-michael.bommarito@gmail.com>
	 (sfid-20260407_184531_208780_F1065C70)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233691-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,nod.at,cambridgegreys.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Queue-Id: A5A753B221D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-04-07 at 12:44 -0400, Michael Bommarito wrote:
> That framing is kept
> here: the global strrchr remap is still needed for kernel-side
> objects, but cow_user.o is host-side and should use libc strrchr
> directly.

Not sure. glibc has an unfortunate tendency to use a huge amount of
stack space for just about anything (though I admit that's unlikely for
strrchr) - we should probably just explicitly call kernel_strrchr() in
the file instead.

johannes

