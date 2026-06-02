Return-Path: <stable+bounces-259874-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zUYvIOcfH2qJhAAAu9opvQ
	(envelope-from <stable+bounces-259874-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 20:24:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 108F96310C6
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 20:24:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=aeuyUaAg;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-259874-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-259874-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C401303E483
	for <lists+stable@lfdr.de>; Tue,  2 Jun 2026 18:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD010396590;
	Tue,  2 Jun 2026 18:21:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B39D394464;
	Tue,  2 Jun 2026 18:21:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780424513; cv=none; b=YKxRDswq9D6cwDnzmyjBJKuWBg9Dm7/KCh9KbceAZVSQnKk2Ywfm2IR3BxA2zpKTuLpspsBZPjE1Ivi2y3CvnTAS6IQDUcdS7lVcES1UHdn4W4xWy/hAU1+ZkismAEf5Gi1VZKMyAhkV1wo/u/IKYyIL06P5zM6Y7eHXJSH4k0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780424513; c=relaxed/simple;
	bh=D+ASplD+t+sDcgxS+LWHidn3r25ksuNt0qqbPQX93JE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PcCZo76ctSUBGJMSD8JHfP//cEmFCpK1l9uywhcy3ot22dVMiQ81wXQPNxXQZy7ecAuC3BQf2fm4AalfoGzyrgCAV/Ws89mBIlvo0yUhruAdHRe9iiLTT1Phv+4UJgtFW4cO6BRMjzovbbnxjJ3boIG1nHLffO7Oo654P/JWkg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aeuyUaAg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A5161F00893;
	Tue,  2 Jun 2026 18:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780424510;
	bh=D+ASplD+t+sDcgxS+LWHidn3r25ksuNt0qqbPQX93JE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aeuyUaAg/PoZaqXTIB7fPalvSJwr+J13VOMCPUIiIqkwCrjvFWyp2WbqV7lAs9C3b
	 6w78S7NtOweHREtWbUas+x5WOfhCCo43KzGR3sdjtKQnvLrp6avh6l/tb9lkMhPR4n
	 UPUvQZ5DyRp+iuSAsGpY2IueLds5+oP4YDlX+WWSSkaDzpHtcFlEIodPfiuqEVCER7
	 x6KR322kjvFo2Z1ucMDgSRrQz/3TrfGp3razttkCi9AZrxdy8Cetx/pPmobYsyJk0e
	 VrfGUZi2Ep2IoHPgjh4ENhRblM2kfZPLNle0rgJTIkwY3snoGIhC+5xf+MYluGt6MS
	 6R/iproGAULPw==
From: Sasha Levin <sashal@kernel.org>
To: Ben Hutchings <ben@decadent.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueria <victor@mojatatu.com>
Cc: Sasha Levin <sashal@kernel.org>,
	patches@lists.linux.dev,
	Manas <ghandatmanas@gmail.com>,
	Rakshit Awasthi <rakshitawasthi17@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 5.10 211/589] net/sched: sch_red: Replace direct dequeue call with peek and qdisc_dequeue_peeked
Date: Tue,  2 Jun 2026 14:21:27 -0400
Message-ID: <20260602180900.sch-sfb-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <7e870e1219db98c9e19777eedfa3b0eb41f41235.camel@decadent.org.uk>
References: <20260530160224.570625122@linuxfoundation.org> <20260530160230.510336558@linuxfoundation.org> <7e870e1219db98c9e19777eedfa3b0eb41f41235.camel@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux.dev,gmail.com,google.com];
	TAGGED_FROM(0.00)[bounces-259874-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ben@decadent.org.uk,m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:jhs@mojatatu.com,m:victor@mojatatu.com,m:sashal@kernel.org,m:patches@lists.linux.dev,m:ghandatmanas@gmail.com,m:rakshitawasthi17@gmail.com,m:edumazet@google.com,m:kuba@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 108F96310C6

On Mon, Jun 01, 2026 at 01:34:44PM +0200, Ben Hutchings wrote:
> The same fix is needed for sch_sfb: 1b9bc71153b0 "net/sched: sch_sfb:
> Replace direct dequeue call with peek and qdisc_dequeue_peeked".

Now queued from mainline (1b9bc71153b0) for all active trees: 7.0.y,
6.18.y, 6.12.y, 6.6.y, 6.1.y, 5.15.y and 5.10.y.

Thanks for the catch.

--
Thanks,
Sasha

