Return-Path: <stable+bounces-272386-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gjkIHZ6/TGqEpAEAu9opvQ
	(envelope-from <stable+bounces-272386-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 10:58:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F39DE719706
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 10:58:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=c0t3Q+Yj;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272386-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-272386-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91E52305D6F9
	for <lists+stable@lfdr.de>; Tue,  7 Jul 2026 08:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B08033D4E2;
	Tue,  7 Jul 2026 08:50:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB03613D53C
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 08:50:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783414208; cv=none; b=M8GMwZ+OD/90PoNG1nD5opSp9v9ulEG6TZkQ0mq4/+dMtf5qqFOgkfq9A7uFSTc8YzoCiuKDCkUylkMwuo2iYuero/ItQwD+dzQU45s/yXyDbUzUUKIOi9qELN0LPAnqsISSHzUZ5tO7Bt5Zaz29O4X1Q82R0vojNpIpxZmAZKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783414208; c=relaxed/simple;
	bh=CO8oEXD8tkIbbZxe4z/VTaoK/QQdg+cetjFfOW+4wXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mwgBr6N9JbPM7dhhin8N/QUPO4Z8MjrQnw2g5Io4P3xtcRtUP6xUE20s9gT3bOUJl7hbNGuJ0/XHd6X8JKnjaGaMMGzNXQSzuJjveff3xBMPIJAg2DwJL9Nrnto1/dnMA5/d6hOB6Cip6OQFhY1mr5CSZ2eYEG4OQwAEN54u4Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0t3Q+Yj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F051F00A3A;
	Tue,  7 Jul 2026 08:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783414207;
	bh=W7rlmgxvpU5nTSWPk+s9LZYDcS442514AECvbyJRSe4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c0t3Q+YjzVg9LMkLPmTjcttl4hjwuKFQHpGDzXSENRV6f8xc8sFk5LWnNKDxyrv3N
	 5CP6tX+4tahDTx0Tft6bGc/f8MRG31KXwBj3dQgIEbC5BQ+x9zix1/6l4HtR7Uf2a/
	 CMPN4GsT6vnMTayT3VDae+Etyo3faYxQzQVtfnJufkKNoGAaE3kkt95Tcd8GyeTQ58
	 SMJ8LHUTpjAFzoCRwndD1ejfMUEDCuZvia8BgDiECQ7jRMa2xpc94yhFJb1rmsJdPD
	 SN0pjgwPA+wCGgp4vxa7+fjYp8mQcOVnTJspQNJuo84xwW3re0S78+fkYh9OEEkHYz
	 9mPizRxycQRKw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	Baoquan He <baoquan.he@linux.dev>,
	chenyichong <chenyichong@uniontech.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>
Subject: Re: [PATCH 6.12.y] mm/vmalloc: take vmap_purge_lock in shrinker
Date: Tue,  7 Jul 2026 04:50:02 -0400
Message-ID: <20260707044731.agent5-0002@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <10194326.ag9G3TJQzC@diego>
References: <20260508191051.1831166-1-sashal@kernel.org> <10194326.ag9G3TJQzC@diego>
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
	TAGGED_FROM(0.00)[bounces-272386-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linux.dev,uniontech.com,linux-foundation.org,sntech.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:urezki@gmail.com,m:baoquan.he@linux.dev,m:chenyichong@uniontech.com,m:akpm@linux-foundation.org,m:heiko@sntech.de,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F39DE719706

> it seems this fell through the cracks?
> 
> Because I don't see an applied message and couldn't find it in a 6.12
> release up to now as well.
> 
> Would be nice to have in 6.12 though :-)

It did indeed, sorry about that. Queued for 6.12, thanks for the ping.

-- 
Thanks,
Sasha

