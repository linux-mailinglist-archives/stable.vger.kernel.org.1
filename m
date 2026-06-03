Return-Path: <stable+bounces-260118-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2cgXNJBPIGo10wAAu9opvQ
	(envelope-from <stable+bounces-260118-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 18:00:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A09D639801
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 18:00:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="PEjn/KXj";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260118-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-260118-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 509B2313B478
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 15:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C7C3C768A;
	Wed,  3 Jun 2026 15:14:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC673D5234
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 15:14:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499684; cv=none; b=RjhXGzv7w/Z2FhBNaVJ8t/+MEyBPwHAOpdDipqSwo6AELoqr7w/0Ka5Lc6I7wwgVwjruGzLgDMs3yxbxj6ZFRJgPG0SEjqojtdSOb17RuuAIATf6otmfyMvlxB7yZP/kIXERTRqWbnndbXVjBcckzJL1XVswNGzcS7rTdiVZO4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499684; c=relaxed/simple;
	bh=Ezkm9ZFBBVj0vhjm1nG9S2DHF83wuqcJfconYjhLc7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WHFjjsRVUtCEWVNTogoqHrENXBKPrNqTDJZvcWpl1ZvshsLBqP3WdpxWjZ3Al9g1kHCReMlURShYve3J/ZxGOvetPQp5ubG6vaJPPFUkXIoIKWju0X0KvRGZmKKHhI4Friq5s/h5qKJlW3YeKL6Baol1gUU46eKyIt+tANPcFMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEjn/KXj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD39A1F00899;
	Wed,  3 Jun 2026 15:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499683;
	bh=WYJwWG4x16zLRsI59FJuAW/F/qyAzcv4cTVACN48lso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PEjn/KXjO1f+O7hI7oFzoX4jRaWvLpqBvq4nA+YUcQMSnKHxLCN61HpdzNwUZpgjf
	 O/Q7uBL7oOc+BBPCs0/M/QWAyzvh3AvgVWC/r4wwSHfgYml7dY92UXIKzZMo1e98BB
	 XsAnaRSOhaLlc7PdVZ7OhYJc0YpjNxWnPxnxljp9ywUIxhs4S5EgtOCvTiQ4v00i4k
	 uSsdJG5z8RyuYVbzhklecqKcRFcGM6Ci0/3fglbuJB3XWSFjj0v9A1dNAXvC9ZtMOe
	 vYiII931DyB2oq3L7kVwa8Y9C52zZIwv6XCLxsbXLb+LxGt/zpy1GAGPcTLgFq8+Wn
	 QhfcVb9wt3U0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org,
	Ido Schimmel <idosch@nvidia.com>,
	syzbot+9fdcc9f05a98a540b816@syzkaller.appspotmail.com
Subject: Re: [PATCH 6.12.y] batman-adv: bla: avoid NULL-ptr deref for claim via dropped interface
Date: Wed,  3 Jun 2026 11:14:08 -0400
Message-ID: <20260603111500.item018@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529181125.415543-1-sven@narfation.org>
References: <20260529181125.415543-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-260118-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:sven@narfation.org,m:stable@kernel.org,m:idosch@nvidia.com,m:syzbot+9fdcc9f05a98a540b816@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,9fdcc9f05a98a540b816];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2A09D639801

Queued for 6.6.y, 6.12.y, 6.1.y, 5.15.y, and 5.10.y, thanks.

-- 
Thanks,
Sasha

