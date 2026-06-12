Return-Path: <stable+bounces-262931-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kkoXM5YaLGrrLQQAu9opvQ
	(envelope-from <stable+bounces-262931-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 16:41:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D3067A476
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 16:41:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=l0u9J25A;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262931-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262931-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 243B130FEEC0
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 14:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58F2382F3A;
	Fri, 12 Jun 2026 14:41:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8BC35E1C3
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 14:41:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781275284; cv=none; b=EhDM/nySk+7qo3hiNc7EvFSiLorGqL+jS8Vm4WrYTv/TlFi1BkX4t0Ri9h4xL3DQmmjqE2RXiIRmOcMsmvaav+zMODbFA6jhss5sL8I79vGf7qpoo7GNtsLAdMvJsX9PYFk+zAsrpsr1d/tpRpWGZg5SbN0yHg9htYFvhiBOJ3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781275284; c=relaxed/simple;
	bh=tOihwrG2GW8dEz+XPM8wmcselRnF6BHlVgFIImbB9KA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oXms84yXZBfqn+0OlHUS1Bl0ct65IchvauFvzHRIblFPrr3P3XODB/XFhDVVo1AeJaC51rGTsBYMUKAmEiQrK3UO/Qn0tSDOpBV6RDfBIN48J6baswvPoPyHN+jRruBlbpAlq1lDA0zsVYn0RkGr7CxxWPWlV0RZpP3EYkRTaAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0u9J25A; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A775F1F000E9;
	Fri, 12 Jun 2026 14:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781275283;
	bh=tOihwrG2GW8dEz+XPM8wmcselRnF6BHlVgFIImbB9KA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l0u9J25AOGdhkafzxCGYv1nJx3UccgP8KpvY6Bfk38HDg+5LosKAxmqN2+c6Gb508
	 f6XVtiC0a2lIWOMmzOoVSdhIAKtmn7YKBAi7VliGwWMPyj9dUcIgApFJoKyaCi473U
	 H2rPVBAdthDs+oZRyiCs/9GeSX5MEj+f7tQJR8e6bsZJK0WxAPu+0Zg+6PFiO4OR2L
	 riIG+Q733vEDra/m3RdnMBcXhFuWSu4A/fY9aHi3Jn9mccBIqFmZjObgFkBezbyNj/
	 DafMX/t/lwbd0GdtdFZCMTJUkFLcu/txqEFvuYIVXrcP85jB8QNAov8VR7qEfunwHg
	 J1jWeAMC4xcig==
From: Sasha Levin <sashal@kernel.org>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Minh Nguyen <minhnguyen.080505@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Ben Hutchings <ben@decadent.org.uk>
Subject: Re: Please apply 98d0912e9f84 ("net: skbuff: fix missing zerocopy reference in pskb_carve helpers") down to 6.1.y
Date: Fri, 12 Jun 2026 10:41:16 -0400
Message-ID: <20260612-stable-reply-pskb-carve-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <airicdmj6A7ZRGxs@eldamar.lan>
References: <airicdmj6A7ZRGxs@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262931-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,linuxfoundation.org,gmail.com,google.com,redhat.com,decadent.org.uk];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:carnil@debian.org,m:sashal@kernel.org,m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:minhnguyen.080505@gmail.com,m:willemb@google.com,m:pabeni@redhat.com,m:ben@decadent.org.uk,m:minhnguyen080505@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 50D3067A476

On Thu, Jun 11, 2026 at 06:29:37PM +0200, Salvatore Bonaccorso wrote:
> Here is the backport for the 6.6.y series as well.
>
> As mentioned in the other mail, I could not have looked explicitly for
> the 5.15.y and 5.10.y. In particular for the later I think more work
> is required.

Thanks, queued for 6.6.y and 6.1.y.

--
Thanks,
Sasha

