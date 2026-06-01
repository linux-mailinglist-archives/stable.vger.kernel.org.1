Return-Path: <stable+bounces-259409-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GtqMVnqHGpWUAkAu9opvQ
	(envelope-from <stable+bounces-259409-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 04:11:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AC5618BFE
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 04:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA9D33006531
	for <lists+stable@lfdr.de>; Mon,  1 Jun 2026 02:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022D21E5207;
	Mon,  1 Jun 2026 02:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UO+XxBhQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4291D5160;
	Mon,  1 Jun 2026 02:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780279894; cv=none; b=CJsURy1WZChgbWi6d+e2FZU2CxRbKK1IA2axdjhXScLnF37vEBveQX0xdY4LhJk1zQrN6ImqzioPRGVZ2teKMvFUk2TR17hrhTaLpJVVcOrSC8Y+hnGN1DnVA0Zgv5XxIf6Wkjs+lNNn7FOqscy45ivm4HGoYo68dWnXDymHZH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780279894; c=relaxed/simple;
	bh=Z0X8ECxyJvOkM5nccMTpeR65nfHis5uykHGw0CXbfow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jDEmiSDkHH0pK4ga7ZROE6cRWyC9uuU7i0GWXYRQOBWg8Bx/M+G9RM9NsTIH3/NZb10r+N9+o9m6I4AQUHpwz/aeLktekp1f91BG2xNupry65lv96hnLFQqdxg4loBy6/opyC9B0QLn35EEXb69K/cTrHfxJk0FgkZmltYAbrwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UO+XxBhQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF87D1F00893;
	Mon,  1 Jun 2026 02:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780279893;
	bh=Z0X8ECxyJvOkM5nccMTpeR65nfHis5uykHGw0CXbfow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UO+XxBhQVHJKP0VUMeQX1zGtsd5O/DQQVcZMvJSkHgUutcUQC69TGTRgn1Ns3d/87
	 iwH4jJZkZ+EZPimSB2Se/JVhn7Jyvz9rIq2YqhsfvBjuSktvWjf5dY051l5t/pjJTD
	 Ph9hLIIEVek5wGhN80IQrbQ5jYtlzNXt9DnXSeFUZdbXcr9P328bWyOWud/csNIsC8
	 2uSSKgLZDidbvLJCBlQ89FRxYD+HB0bfp1xtj8eornVlCLKikgDoLJGZCHZUzcOn2X
	 7LuS5q+trXjDqP5Rfez5akRN3xiO54DOe9EFKdQCT45NKZ/ijTN4kYjIn1so5hUdyP
	 DtzBT2+a7ye7A==
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	patches@lists.linux.dev,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Florian Westphal <fw@strlen.de>,
	Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH 5.10 027/589] xfrm: Wait for RCU readers during policy netns exit
Date: Sun, 31 May 2026 22:11:18 -0400
Message-ID: <20260601015021.rc-xfrm-netns-exit@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <56652caf63e8db874a3ebd761ec134c003d4986c.camel@decadent.org.uk>
References: <20260530160224.570625122@linuxfoundation.org> <20260530160225.295450347@linuxfoundation.org> <56652caf63e8db874a3ebd761ec134c003d4986c.camel@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259409-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 75AC5618BFE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 2026-05-30 at 21:45 +0200, Ben Hutchings wrote:
> This is broken - it needs commit 3e5241731847 "xfrm: move policy_bydst
> RCU sync from per-netns .exit to .pre_exit" as a further fix.
>
> I haven't checked whether that applies cleanly or needs backporting
> work.

I've dropped this from the 5.10, 5.15 and 6.1 queues; I'll (try to) re-queue it
together with the backported follow-up. Thanks for the catch.

--
Thanks,
Sasha

