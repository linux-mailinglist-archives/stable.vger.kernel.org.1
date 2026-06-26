Return-Path: <stable+bounces-269264-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lmX4Gd29PmoiLAkAu9opvQ
	(envelope-from <stable+bounces-269264-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 19:58:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 252BE6CF8AE
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 19:58:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BucADCAB;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269264-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-269264-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFB683118C61
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 17:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9983A759C;
	Fri, 26 Jun 2026 17:55:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D453A83AC
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 17:55:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496504; cv=none; b=m3n2i0u6HFphiUROkHEiOWtg+rJRWiXeNxkjPKICmJLVQ34guOc2obEg28f4vPWJ4yb6VkLu1yytE1E2MHNYBewB4GMrbRe+suFF3tPj6dHB1aT1v04wWlObU/dBU5E4wfIc1YKhcTYUh2Io3dZYqhOR5KN+m5gEyC/zis1ukDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496504; c=relaxed/simple;
	bh=rzv89d7x0CS/lgx+sOybxv2ybeQTLerIGI9OP9tctMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DWkQkO1ZiEO1lieAobesyQjfB5K1muPsjdM8Il0hmadTpDK52E3gtZSmBVpcr9PRySwp4uw4Zhl3zOyffK5kNM9gAI4UObltSEU1qXdKcHMFiQDr4ru34DaAyJOh1uiSVsrca1e8wKVu331e2z5J59paStklcDydOMPgXqaxGQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BucADCAB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ACF21F00ACF;
	Fri, 26 Jun 2026 17:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782496502;
	bh=qIDhNn27LtiZ78FO/Hnj+1740GHIkWRZOms0c1Rzsx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BucADCABOCDh2uX0z3LDDOSiwSZVqi3vQh8ftDfm9LVNImPw5aSoLIOWQ5sfu3jbE
	 jdP345fJFQ5phqNuU47plYQJQXYXGrqi5k404nK5Pp3RIOCAovTojSHGOhP1tjRzKl
	 KpjT9G4xwd1gNQxlf+iWQ4uLIZk2Pless73vVEETOWhF4JyBU6rcy5z0KK3tiPKoau
	 hB7iTRNmbpvDM4cBnlqylWoTvApp3hIX1ttowd3OjPsoWZHQGTQurb7rC2Lf/F9+Y+
	 O7BiDNps9fytB+6ET0ywxPo7gFR0SRWQa9rJlsCkjaYShkfDTryxnN/aiZpD5hiNQl
	 YfjXRipy9KCgw==
From: Sasha Levin <sashal@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Petr Machata <petrm@nvidia.com>,
	stable@vger.kernel.org,
	Wojtek Wasko <wwasko@nvidia.com>,
	Mahesh Bandewar <maheshb@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Yong Wang <yongwang@nvidia.com>
Subject: Re: [PATCH 6.6.y] Revert "ptp: add testptp mask test"
Date: Fri, 26 Jun 2026 13:54:29 -0400
Message-ID: <stable-reply-item013-ptp-revert-66-20260626@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <3651ff8e1f7ef3a6e8f40592a1759e494d7b3a6d.1782385355.git.petrm@nvidia.com>
References: <3651ff8e1f7ef3a6e8f40592a1759e494d7b3a6d.1782385355.git.petrm@nvidia.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269264-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,google.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:petrm@nvidia.com,m:stable@vger.kernel.org,m:wwasko@nvidia.com,m:maheshb@google.com,m:shuah@kernel.org,m:richardcochran@gmail.com,m:yongwang@nvidia.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 252BE6CF8AE

> [PATCH 6.6.y] Revert "ptp: add testptp mask test"

Queued for 6.6, thanks.

-- 
Thanks,
Sasha

