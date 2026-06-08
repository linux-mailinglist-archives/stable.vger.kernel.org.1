Return-Path: <stable+bounces-261938-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4SMiJzMOJmpXRwIAu9opvQ
	(envelope-from <stable+bounces-261938-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 02:34:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E70B652046
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 02:34:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dDfAzxkZ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261938-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261938-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A3873006B37
	for <lists+stable@lfdr.de>; Mon,  8 Jun 2026 00:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025A02E0413;
	Mon,  8 Jun 2026 00:34:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C482DF13F;
	Mon,  8 Jun 2026 00:34:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780878894; cv=none; b=XisjqLKZZxf0LAZuNe5HeruwjbrTHOSlydRPaU3iW4mnMtCeuzqSBR/OPJ8cEEtxTRalHv2r6LD3kIO21hysYZE2ur0wWBf8aCJgp2KTUw/a5CvK1DTsanlJC3eZL1BSgJGLBjnYyps3E/7b0JtBc07s8D78Lra/BxIN7WP/DZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780878894; c=relaxed/simple;
	bh=d6vr0fH/fb0SBkvZcPtfT+7cFDnnzJD8EEwsJf+6QUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J7gqwS0MxP9QbYUlzJYNU5aQoyUtUA9OIHTix41yLwweTw4AZ4gsE4eGXVZPyJMZ4qLv6YTq8Jw/tQb09cppm3VE3tilzXsDtr2mMEu038v9HE/K5Zeg1+NWfRv4PUKmCx65LP/jwFZV+jkHJeVB3WFAou1+1x9apqJ/eK6kYZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDfAzxkZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D912B1F0089A;
	Mon,  8 Jun 2026 00:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780878893;
	bh=d6vr0fH/fb0SBkvZcPtfT+7cFDnnzJD8EEwsJf+6QUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dDfAzxkZey4oW3XVrQ5bpBLD+VoAXF8Jfd3A7IuZgffWKjZImkZnMP/XzyM59DWu8
	 mbXkdzlslbOH8hBPj+blkqusfVzGPf/yyzXZ5TU2VeioxMg+bID1RlR5WiM9bIAYs8
	 NL7nF826NePm50qiuvK/MUIT34Chjsw/QekgQsW5XY9h4lxmdPo+t94jphaxINqF7s
	 uoJVCzbf30KLrCNemW1KcyhfPUf/LAoNfz2m4EqHFWvevxoXQIn1hkiLsluCRluI5f
	 cikPabQ4lVgb7yLnhdysIoSlHBBnHHm1YNlRto5domWGPQL17sGl1F4gkWCHThdvC6
	 mTfCHgdoo9d/Q==
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	patches@lists.linux.dev,
	Alessandro Schino <7991aleschino@gmail.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 7.0 016/332] esp: fix page frag reference leak on skb_to_sgvec failure
Date: Sun,  7 Jun 2026 20:34:47 -0400
Message-ID: <20260607202000.rc-0003-esp@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <dd36757c-62b3-476e-bc9f-09231c495ebc@kernel.org>
References: <20260607095728.031258202@linuxfoundation.org> <20260607095728.644422375@linuxfoundation.org> <dd36757c-62b3-476e-bc9f-09231c495ebc@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux.dev,gmail.com,secunet.com];
	TAGGED_FROM(0.00)[bounces-261938-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:sashal@kernel.org,m:patches@lists.linux.dev,m:7991aleschino@gmail.com,m:steffen.klassert@secunet.com,m:jirislaby@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2E70B652046

> This was reverted by 6851161feb01cea41358c9ec304bd2f981fc8505.

Dropped from the 7.0 queue, thanks.

--
Thanks,
Sasha

