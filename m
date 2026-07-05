Return-Path: <stable+bounces-272054-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MeI5HZFhSmpiCAEAu9opvQ
	(envelope-from <stable+bounces-272054-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Jul 2026 15:52:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F4770A2A8
	for <lists+stable@lfdr.de>; Sun, 05 Jul 2026 15:52:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=EY7McWhE;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272054-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-272054-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98E8D300F538
	for <lists+stable@lfdr.de>; Sun,  5 Jul 2026 13:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE39D37FF49;
	Sun,  5 Jul 2026 13:52:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62550380FD7;
	Sun,  5 Jul 2026 13:52:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783259524; cv=none; b=Sm1hBhFLW35hryPuzwGD+hyYeguYiqYjVPbPN7JjsDMtaXkMmm5yUHCsN15WpQ3S0uOc4dFHSG+fJfcUEgSUL/lh5GUg5yVTXiZYHbb6UZbQNT6cIhej3fb7KK0Fe65NHV/iCjIRkIsCoURFJDZztOUlQ7anFP0SaPB95m8LMYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783259524; c=relaxed/simple;
	bh=e7qsdR6RLX28wY6F8j6XHLck42eNjftjSVndAG1rxmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NYP4QzO27yw6Ib5cHV0ebnVUTe0OGQMj6xvf1te8a7k4JtAdO7csw96S82SC/wMHZhrOHKXfr4QX4xUo1ukwbBHKZ8UCZIDKDyY6S+HDZBPFYryENzMhk2oFEXBi+1mtkk+HVuforTVX+cQhez8JeznojizB/LWS/Q+HVhKqtVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EY7McWhE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A5E1F000E9;
	Sun,  5 Jul 2026 13:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783259521;
	bh=ccbtHIIbFEYwquLQXpwo/HS5VUnsG2JeIqciVKxFvSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EY7McWhEoKR2PLVQjueptAkt5YPKfVPWBO7dVIo46tbwxRXXfJuDPjDRGjUjZtrrj
	 659DJ5YydIgdwIxqSdMwdcx30qLSKnytAweO4ERQJAE65FC1mgZK3y3vRy7xQOYKIT
	 oGakJQaDXRbhYwAlqME5K+yJJXj2ohwES3r3v/+xuvPEzs4Jm/JOfEJzq6aHjfWlDF
	 bj81JDpX8JuDXxnuPP0ZN4J+wG8JGqkeK2w51nIaCpaTW4bMDt5pa+l5DGvPBXN9Wf
	 51yiqnZPv6+HoL9LSL/EuYhWhPk6FiHBT0JsSxmZ3NfgrOEkrhBvn3PC+lCBM4z8BH
	 gzdGp3bk1nWxQ==
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	patches@lists.linux.dev,
	Pedro Tammela <pctammela@mojatatu.com>,
	Simon Horman <simon.horman@corigine.com>,
	"David S. Miller" <davem@davemloft.net>,
	Wentao Guan <guanwentao@uniontech.com>,
	Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH 5.10 01/96] net/sched: act_pedit: use NLA_POLICY for parsing ex keys
Date: Sun,  5 Jul 2026 09:51:56 -0400
Message-ID: <2026070416-stable-reply-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <418ca29bbbb1190853136331c572470dca803800.camel@decadent.org.uk>
References: <418ca29bbbb1190853136331c572470dca803800.camel@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272054-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:sashal@kernel.org,m:patches@lists.linux.dev,m:pctammela@mojatatu.com,m:simon.horman@corigine.com,m:davem@davemloft.net,m:guanwentao@uniontech.com,m:ben@decadent.org.uk,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 27F4770A2A8

On Thu, 2026-07-03 at 22:16 +0200, Ben Hutchings wrote:
> No objection, but this should also be applied to 5.15 and 6.1.

Queued for 5.15 and 6.1, thanks.

-- 
Thanks,
Sasha

