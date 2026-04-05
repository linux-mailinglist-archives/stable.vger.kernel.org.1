Return-Path: <stable+bounces-233326-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id DRd0A+co0mmpTwcAu9opvQ
	(envelope-from <stable+bounces-233326-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 11:18:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3673D39DF6C
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 11:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DB62B3002F6B
	for <lists+stable@lfdr.de>; Sun,  5 Apr 2026 09:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1569C34AB0B;
	Sun,  5 Apr 2026 09:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxJY4Oev"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD42633263A
	for <stable@vger.kernel.org>; Sun,  5 Apr 2026 09:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775380703; cv=none; b=F9r3VK8zKG7klrVcY8/FZFlRrpeh6NuCXzRGu6DQNJme/WPEQyCM2MSOuFTMdnKKQz3jO6WSUE461MJ80F/qt1nSsLE/4/653shD4hyGaLtaLxteLUjvu2jBobMiRYR6bep2rkF9ijWvrqtkJ/cIiseSHwcrIagvZHLeKHZocho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775380703; c=relaxed/simple;
	bh=L88MOg+6k6B/he2Xs9BhfEfi/VaWOt3ouiuYyCXo/QY=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=LFNwqOKGQuDamxccFblMRWS1cvbTVFkezc1ynYLoOWMmfjX97i9p9gB2DGlQ+2eFixDaT5P+c10Kqo8RcbZT5ZDq7OjA1zQlklHsoLCtSxeaeQUopMhX11L1ZdNEqGNFszFwYLLpBuXz/bmbbpn/EON04TFnckQyeDbgYWQIfvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxJY4Oev; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E77C116C6;
	Sun,  5 Apr 2026 09:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775380703;
	bh=L88MOg+6k6B/he2Xs9BhfEfi/VaWOt3ouiuYyCXo/QY=;
	h=Date:From:To:Cc:Subject:From;
	b=hxJY4Oevj6W4YDKc+uzvLoQU+a9ADGKcxJJEEoRZbTob4Rhkm+38sXx+9bdOB3wXb
	 mHYOF1NbW+XfufSRMpR7fxWrm1NbQmhyUFsi1YlihWkihNPSp6s9ZB13H45tP2SSYI
	 CoIlUOdnYh5ex3xcVLFX5fxsNzW59Jcv3HbzSM3C4fJKIzdzkrJhQ2JE6VpEAU8mXb
	 bG+6c9sxfTlpihFR6Ho+lbFX44BKLe+Y5m6NyWwQ423zSt6l4263shq4P8cKawXtQP
	 bziFtMXIkefDn1Rh+P8TLduJH2Y5oOYchWSrps9UpJzDqMpJ7RtMg61fnrn+/jDdI5
	 AbNoE11aqGhbA==
Date: Sun, 5 Apr 2026 11:18:18 +0200
From: Matthieu Baerts <matttbe@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Message-ID: <ae558319-0e42-4efa-a071-158ab3fbb1b2@kernel.org>
Subject: stable-queue: missing files
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <ae558319-0e42-4efa-a071-158ab3fbb1b2@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233326-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3673D39DF6C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Sasha,

Thank you for having queued a bunch of new patches recently, but
your last commit only modified the "series" files without adding any
new files, see:

=C2=A0 https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.=
git/commit/?id=3Da56bded6cb98e350b628c2cd1a2e82937871132f

Do you mind adding these new files, please?

(Reported by the MPTCP CI validating stable patches.)

Happy Easter!

Cheers,
Matt

