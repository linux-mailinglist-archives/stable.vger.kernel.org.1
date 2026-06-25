Return-Path: <stable+bounces-268336-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UvI/Mm0GPWrevwgAu9opvQ
	(envelope-from <stable+bounces-268336-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 12:43:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 957CE6C4C22
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 12:43:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="h/y4bhVU";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268336-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268336-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9159D309C4C7
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 10:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D933D566F;
	Thu, 25 Jun 2026 10:42:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E81B32B105
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 10:42:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782384136; cv=none; b=hgkQsz4bc2iWdVqzf7tH8XVkDPSX9Njdmetd1n8Vwwd+QnUc5RU29fMdhVMZsCdl07/k0m2/9tc/HvkDs03EZ+r2VgXFWpgNj4QJIki9EHTScRxzZV3y1aRn2ztXDgsJhlEyAxnSQcQd5Ze1pX1OesAizJun0nzXYGMpbu7DrqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782384136; c=relaxed/simple;
	bh=HeWsHnUuP/mR/NVQGuV840EwwXStyGoCTkZxDW9u4R0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cmEUuGDf8xU8OwzZuttEPpafUtEhtus1xPFewxy6gadzJTjgOANOIn+oCKduzbMCds0n3/DPkYdhVUrxIPqiLaJNtZbaUBRGIvC4PcjrTED6xvwY/9CTkt4lhj9+RCquBmcq7cypg91H4HK1mK7NIxWviNspQHUVXAd/VeGymTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/y4bhVU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873FE1F00A3D;
	Thu, 25 Jun 2026 10:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782384135;
	bh=HeWsHnUuP/mR/NVQGuV840EwwXStyGoCTkZxDW9u4R0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h/y4bhVUDEHtMPgFFdPIeXstpZxdT30vVTDGqi1Dm4Gvv5vwY5Fkm9zP5xR1Xp4gE
	 w8QRnin0uue6HiX2QZo2K+mA/MghJh9Dv3VAF3eXUZXXlqO7pZtyuWHte61LjeIXp+
	 IpclJwCq8ztNtZoJEOfBWlG71A/qfgxaHqh2IJiOvuIhRC0syEUhsNExKcCtZBXLZk
	 V435hWJ0kaTwSbCuw6pzOeZCJ2QDm0eLC6igKmfX4pCInyNVzzyVjROBIvozxgdwTm
	 6TyJFqEeIj+wxAHcsAz+5rKISktcz1SZIonaI3lBtS9pcRKjqik5ywkzfhiUbMViyL
	 16dGCNpdLhE2A==
From: Sasha Levin <sashal@kernel.org>
To: guanwentao@uniontech.com
Cc: Sasha Levin <sashal@kernel.org>,
	2045gemini@gmail.com,
	dcaratti@redhat.com,
	gregkh@linuxfoundation.org,
	jhs@mojatatu.com,
	keenanat2000@gmail.com,
	kuba@kernel.org,
	rajat.gupta@oss.qualcomm.com,
	rollkingzzc@gmail.com,
	stable@vger.kernel.org,
	toke@redhat.com,
	victor@mojatatu.com,
	yimingqian591@gmail.com,
	Pedro Tammela <pctammela@mojatatu.com>,
	Simon Horman <simon.horman@corigine.com>,
	"David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 5.10.y v2 0/9] net/sched: fix pedit partial COW leading to page cache corruption
Date: Thu, 25 Jun 2026 06:41:55 -0400
Message-ID: <20260625054005.0011.act-pedit-510@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623100141.2383966-1-guanwentao@uniontech.com>
References: <20260623100141.2383966-1-guanwentao@uniontech.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268336-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:guanwentao@uniontech.com,m:sashal@kernel.org,m:2045gemini@gmail.com,m:dcaratti@redhat.com,m:gregkh@linuxfoundation.org,m:jhs@mojatatu.com,m:keenanat2000@gmail.com,m:kuba@kernel.org,m:rajat.gupta@oss.qualcomm.com,m:rollkingzzc@gmail.com,m:stable@vger.kernel.org,m:toke@redhat.com,m:victor@mojatatu.com,m:yimingqian591@gmail.com,m:pctammela@mojatatu.com,m:simon.horman@corigine.com,m:davem@davemloft.net,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,redhat.com,linuxfoundation.org,mojatatu.com,oss.qualcomm.com,vger.kernel.org,corigine.com,davemloft.net];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 957CE6C4C22

> Please add net/sched: act_pedit: fix action bind logic (upstream
> e9e42292ea76) as a 10th patch to the 5.10.y pedit series - it also
> fixes the tcfp_keys_ex memleak on the if (bind) early-return path.

It doesn't apply cleanly. Could you send a backport please?

--
Thanks,
Sasha

