Return-Path: <stable+bounces-267489-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qVkkNw+ANmpIAgcAu9opvQ
	(envelope-from <stable+bounces-267489-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 20 Jun 2026 13:57:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB556A8D6C
	for <lists+stable@lfdr.de>; Sat, 20 Jun 2026 13:57:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UaQFxOJj;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267489-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-267489-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 969103043EFE
	for <lists+stable@lfdr.de>; Sat, 20 Jun 2026 11:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7895C3955DD;
	Sat, 20 Jun 2026 11:55:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60857395266;
	Sat, 20 Jun 2026 11:55:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781956515; cv=none; b=Mn1eGw8kKrQd7rngR7z3o7AA7mcvNawgsT/E5CjI1lj3uVXJRxY4P3paiae14wdt7UdK5fomE1Gx9Oql4jp3uGwEjqZXI493M8IOaPSXlhKR9IsPE2St3Wgc/ululd/iP7a94+toCucs8XGDREq9gH3mhkYa1aJMTJavUfLFVxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781956515; c=relaxed/simple;
	bh=Z68yr+yHdFH8xYzQsReYj+tz4kBPzytXSKIWssUGops=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a58eXVUgeElidW/uuzF3/Ek7NM7cMA9ja6qxKXXUUzsOblZWRY1ZbVjtK4kTQcvNEKTIebsiM98JmlA5whEFrh/a3N+Z7F/VnNJQlpnG2saLLOcPhE8Ih0BkifZhYU1YM2ab/pvCSTp2dG+q0kOJhhz6n/+aBQHjCs6eIfIt3xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaQFxOJj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84AF21F00A3D;
	Sat, 20 Jun 2026 11:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781956514;
	bh=8Bce3y5FB0VyOVjBzhNstRLdXCR/QSbHX4wZv9NNX8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UaQFxOJjIRkY7n6drn9/3xxxGDQvpBObWnA7zjxYSd+LKSQILvPM+ER+z+g3Fv59f
	 zOs7HCB8FAjWYAB2CmLSEM8GlfunK90nsb3cXwJQo1/NUkRlq0hfAtSHzD4DAE7Q3L
	 pz/DQCpPj+TDBrn50Q/93cTtHwIi5Kv1s8aZICdkCTBvLbNUXliU0byjUq950m8r3l
	 Mtga5q2O48PfjOxywJ/df2N5e9NxmSz6w8K6WKac99dUIpRsCpLUnXbBOSje7oY5AD
	 Q4Vy8I2UFHhfV39tpQ0N//s4T0s5KiVr0xXt7pcIsqJCKqXE+RjYBZqR/7tULGzD7i
	 w+RLn9INYp/9w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Alexander Martyniuk <alexevgmart@gmail.com>,
	Eric Van Hensbergen <ericvh@gmail.com>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Tomas Bortoli <tomasbortoli@gmail.com>,
	v9fs-developer@lists.sourceforge.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev,
	lvc-project@linuxtesting.org,
	Hangyu Hua <hbh25y@gmail.com>
Subject: Re: [PATCH 5.10] net: 9p: fix refcount leak in p9_read_work() error handling
Date: Sat, 20 Jun 2026 07:54:59 -0400
Message-ID: <20260619.0011.reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618151940.76321-1-alexevgmart@gmail.com>
References: <20260618151940.76321-1-alexevgmart@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267489-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:alexevgmart@gmail.com,m:ericvh@gmail.com,m:lucho@ionkov.net,m:asmadeus@codewreck.org,m:davem@davemloft.net,m:kuba@kernel.org,m:tomasbortoli@gmail.com,m:v9fs-developer@lists.sourceforge.net,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ericvh@kernel.org,m:linux_oss@crudebyte.com,m:v9fs@lists.linux.dev,m:lvc-project@linuxtesting.org,m:hbh25y@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,ionkov.net,codewreck.org,davemloft.net,lists.sourceforge.net,vger.kernel.org,crudebyte.com,lists.linux.dev,linuxtesting.org];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8DB556A8D6C

> [PATCH 5.10] net: 9p: fix refcount leak in p9_read_work() error handling

Queued for 5.10, thanks.

-- 
Thanks,
Sasha

