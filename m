Return-Path: <stable+bounces-267314-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7/zPM3vANGrMgAYAu9opvQ
	(envelope-from <stable+bounces-267314-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 06:07:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7914F6A3BD1
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 06:07:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QaIRoLDD;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267314-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-267314-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ECCDD30251ED
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 04:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830D9330B01;
	Fri, 19 Jun 2026 04:07:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649E732E68D
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 04:07:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781842042; cv=none; b=JjFCRGidWNxB88WEG20CK8O7Emri1VEVghcARr1Cg7II9smZkLQ5AVe8A2uW8JBN3J0S2PtniVdQnhzouZfXcQe9bDgOymf7vjEC5YERl7T/eX6NuEBty/9NHZ2vdkTob6uKBXYgPl6ZmbTikUgQfHBe/L76jPPnmQrIz92SCLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781842042; c=relaxed/simple;
	bh=7vfF2jCBGmuBUGARGBRcO3i2VMzK2sSB6ZEnrp9eAls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=enmOqya+4IgNKhtj+GtjdDghTAoDAW29swpbG2dMXDm5zvgKhFwtZRoKgbv/IyOiiLFxiN1XTbS94CU3Ttks7hyxzeeDT9bjSSXKASjpKryyX03ZSoXfsh13Y1m/WtvBPBSthD+klMpnC7+Y5Imol5eo7mxxibOSrYj2/nPfJM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QaIRoLDD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4663D1F00A3A;
	Fri, 19 Jun 2026 04:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781842041;
	bh=zcgGE5aV7/LAhe5NlFW17EdmOafMmlwOkUR0YYn0Mmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QaIRoLDDPav0jzSe0hQWvCljuGWA160FldZQGaNbMN1Hc2b985mDCIHSGt//UMt61
	 Uig1Vm9NLes+9zUi25o7csRvBjFi+apXjrPQUoWSn73AaGRPZYUd3i6GFo4Ud5DRoH
	 6AlXc/0qQmxaLc0wqPhRPnmSAKtwYUDqrlZ68LBL3fVWJbFx0wRYA2CDyCZSCY44wr
	 Vkbr2Rq067sAFE5m1v+pd1OQQx9fRPZBq2A59WA3axCUjLVo1E4HgDJDnmFvV7W2ey
	 rbNM80yHXxtFj0XhmG0z9i+X9EY2+qQ5Ll3/gpI7FQqkra2+PvCcGl5ANgaRllrthI
	 3p4FHmCvDtUFg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Paul Chaignon <paul.chaignon@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH stable 6.1 1/1] selftests/bpf: move SYS() macro into the test_progs.h
Date: Fri, 19 Jun 2026 00:07:03 -0400
Message-ID: <20260618-reply-item026-bpf-sys@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618014033.83033-1-shung-hsi.yu@suse.com>
References: <20260618014033.83033-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-267314-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,suse.com,gmail.com,linux.dev];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:shung-hsi.yu@suse.com,m:paul.chaignon@gmail.com,m:martin.lau@linux.dev,m:liuhangbin@gmail.com,m:martin.lau@kernel.org,m:paulchaignon@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7914F6A3BD1

>  [PATCH stable 6.1 1/1] selftests/bpf: move SYS() macro into the
>  test_progs.h

Queued for 6.1, thanks.

--
Thanks,
Sasha

