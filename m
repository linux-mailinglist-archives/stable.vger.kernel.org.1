Return-Path: <stable+bounces-267544-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HbDWD47rN2qTVgcAu9opvQ
	(envelope-from <stable+bounces-267544-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 15:47:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDA86AAF5A
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 15:47:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ch0+rBHI;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267544-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-267544-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 617803001F9A
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 13:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7F51A9FAB;
	Sun, 21 Jun 2026 13:47:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB2062809;
	Sun, 21 Jun 2026 13:47:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782049672; cv=none; b=VnzTayFjV2NqzYmjEu2Y/SDU8iw/TuXJskeRWatoVp8dcGSp3jNWKcHkbBaK75iAYYsNvBsE3nrdAVEu3txQcSDEVXsm++iSLs+/nXu6NIrZY1Cr+u+tPXbw4tyWO3nEI8XizSDOdnZNuB76yUFxXnZpLDZc3IOyOE+wBsB0SYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782049672; c=relaxed/simple;
	bh=jTt+q7O5j3RA/6wGusIo+lg7UvlNzef6PG0kLb1kuuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aI63rvlGgNKZJAhq4Y29Ll5PCKjSWZFRmBzu9pY8K8EJCKeThb/U+3s2tMJUNTwfakfH6/6L89T5MCHMmrZe2gjhAO3VquSkOUwNeykhiI/DHmHN3QtNeHQHoe8cRc6NV6G1CH7LV3B1Ak963oG98efn+GxFbkYL2chMNu54tcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ch0+rBHI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A277B1F000E9;
	Sun, 21 Jun 2026 13:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782049671;
	bh=Cwqlpih/3DV5Qn5DW47DcDxSY1IksWixUGqM+qr3+Z8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ch0+rBHIetmXZJNAAfB5TZwrN3cxxw26iKks+93AsfZk6KFrHgkCM/qMXPMFUtUR9
	 CMSmMYVjxfiex/66bHOEAVvJdUHEem7LcMI7gEc/c44LS70pfXqpB9Oddv84MIvxW7
	 0zlsC6l0mFEt9MkRSUDOshaJjUvd06SoCccBWFTMJb7WMvgyI95569mlHXnI24MXK2
	 cSgWhHlj+5k12U8/C5G48hdWUp5yfHxSoHt8EGim7w4nwHTLQfHErtAJMlAGqQPebg
	 pPiyU7iHLGAxL+/MAPr8RhoMMMuytvD0eckc+D/sNabLOdwDfQTmPsI2Bsf9+iAFiV
	 IIluiS7rZc1oA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 6.12 125/307] batman-adv: tt: prevent TVLV entry number overflow
Date: Sun, 21 Jun 2026 09:47:39 -0400
Message-ID: <20260621133722.0001.sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <8696716.T7Z3S40VBb@sven-desktop>
References: <20260607095727.647295505@linuxfoundation.org> <20260607095732.348045111@linuxfoundation.org> <8696716.T7Z3S40VBb@sven-desktop>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:patches@lists.linux.dev,m:stable@kernel.org,m:sven@narfation.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-267544-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1FDA86AAF5A

On Fri, Jun 19, 2026 at 06:54:33PM +0200, Sven Eckelmann wrote:
> No real objection for 6.12. But it was missed in
>
> * 6.6: ...
> * 6.1: ...
>   - applied when using the correct order - no actual change in the patch
> * 5.15:
>   - it depends on the also missed patch (with context conflicts): ...
> * 5.10:
>   - it depends on the also missed patch (with context conflicts): ...

Thanks Sven. Queued the missed backports for all four trees:

  - 6.6 and 6.1: applied the single main fix directly.
  - 5.15 and 5.10: applied the prerequisite 1e9fab756f83 ("batman-adv:
    tt: reject oversized local TVLV buffers") first, then the main fix,
    per the ordering you pointed to.

All four built cleanly.

-- 
Thanks,
Sasha

