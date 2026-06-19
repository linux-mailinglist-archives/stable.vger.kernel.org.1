Return-Path: <stable+bounces-267309-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2KfZM/bANGoAgQYAu9opvQ
	(envelope-from <stable+bounces-267309-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 06:09:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 911696A3BF8
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 06:09:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kwqe3B3O;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267309-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267309-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F21B3049FCB
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 04:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FBA3242A9;
	Fri, 19 Jun 2026 04:07:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2CE2EBBA4
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 04:07:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781842035; cv=none; b=sj8n05ON10bOZ4Ozp4/Q9C4i/+4uunNk+6uAkONJyluDI59WPgrx95PgaAzvLk7yT/ANFm6MDd+EuDVsLKzTEAYF4KWDGyCDv4u0IsCb+lXPtEErfZmCZCPpKDgkA41ZFH1x/JjiOzu1ZY1U+X8tREXbZ9cajYP2cwC8TrxTozI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781842035; c=relaxed/simple;
	bh=+sjR5OqZVH0xdWDw9CFDndstLbqGyVjxUp1bbfpv38A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K4BJbZo8wI9dPXJWhoNiFKp7erinrtHEIxXxR2bivBUcYnO4p8mTLdo/SdLIyZEIpv9Tu2ulV+DDZpAKeqZZuh8QFJ/x4buyYldHmFRXVu/mn5dqLiHeZofaguhMSAe7I8I/56aOsmopQOlcZNIfHHK7aQ2Cp1eD6vsG+nFygkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwqe3B3O; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BEEB1F00A3F;
	Fri, 19 Jun 2026 04:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781842034;
	bh=plrfpGS/hevj5aqwH504MZc3OKAQHQ/utB+P6u18JHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kwqe3B3ObhbYHYgyOiCLBqQJ9H1I+IMDiM1Rdi/1WgAh1tTGk0iq9BJB0Hc/bcvky
	 COsSdwAclaPgBGm4FepuZTcmDe6TPTL/GXBoFfaiEW4C0FIchcqejy6tSRwWCTSsv2
	 mr30Mtwpb/sEgO0ouh4LlMjPGx28Fqu77cZNMZJziR4Mp/YIRIjtZLLKi+Woxa7pbQ
	 oyD30IX/pO8sOlHJrDD+FtvQ0/YDi/x5SIzyakf4mAz7lhu8HYv23o7Ow224woDqF6
	 xHHeDTUcESHjpWwkrEa9bU1MAfuwPdpOogCzeG2DSPB8vAENddhaCfL+a6oMNYi6aE
	 8vtjxeC787nPA==
From: Sasha Levin <sashal@kernel.org>
To: sashal@kernel.org,
	gregkh@linuxfoundation.org,
	guanwentao@uniontech.com
Cc: stable@vger.kernel.org,
	2045gemini@gmail.com,
	dcaratti@redhat.com,
	jhs@mojatatu.com,
	keenanat2000@gmail.com,
	kuba@kernel.org,
	rajat.gupta@oss.qualcomm.com,
	rollkingzzc@gmail.com,
	toke@redhat.com,
	victor@mojatatu.com,
	yimingqian591@gmail.com
Subject: Re: [PATCH 5.10.y v2 0/9] net/sched: fix pedit partial COW leading to page cache corruption
Date: Fri, 19 Jun 2026 00:06:58 -0400
Message-ID: <20260618-reply-item010-pedit-510@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618075342.1599593-1-guanwentao@uniontech.com>
References: <20260618075342.1599593-1-guanwentao@uniontech.com>
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
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,redhat.com,mojatatu.com,kernel.org,oss.qualcomm.com];
	TAGGED_FROM(0.00)[bounces-267309-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sashal@kernel.org,m:gregkh@linuxfoundation.org,m:guanwentao@uniontech.com,m:stable@vger.kernel.org,m:2045gemini@gmail.com,m:dcaratti@redhat.com,m:jhs@mojatatu.com,m:keenanat2000@gmail.com,m:kuba@kernel.org,m:rajat.gupta@oss.qualcomm.com,m:rollkingzzc@gmail.com,m:toke@redhat.com,m:victor@mojatatu.com,m:yimingqian591@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 911696A3BF8

>  [PATCH 5.10.y v2 0/9] net/sched: fix pedit partial COW leading to
>  page cache corruption (CVE-2026-46331)

Queued the v2 series for 5.10, thanks.

--
Thanks,
Sasha

