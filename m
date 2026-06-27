Return-Path: <stable+bounces-269400-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Anf+Ngz8P2r6awkAu9opvQ
	(envelope-from <stable+bounces-269400-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 18:36:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA806D24AD
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 18:36:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=PKs4MGZ3;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269400-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-269400-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BC593033D02
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 16:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886B631F997;
	Sat, 27 Jun 2026 16:35:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B91331E822
	for <stable@vger.kernel.org>; Sat, 27 Jun 2026 16:35:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782578140; cv=none; b=pDLeU0/yF1lAn6vq40+iOD69IF/TAQb9pT1uKuZh3XSBak+cv8tswkAyOCPB8/WTxVXXGxa/SwOsCU4CEOFNW5nnKqfFFwZMK0xb9T7/hLQE6ewiDtfuJhNMyzoRTI0KXV9we28OWRq5br0r3qvbfjb3oqw/de3KPKEqVLhXTEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782578140; c=relaxed/simple;
	bh=btxo/cGk1zMJFdLqI5drnBrxbMTaE6XQELwJhTyXIfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FXd8awWmxnfxgVGhcvhYqWEPQ1FmnI6jPZgBoBF4nYQ8CfbA51iuxUfCqUQ5CkW0qZlGySk38BjOutazQn950G5BhdbMvhH2adGtl+KL4eCWn7j6XAKIqaKaYrKqW4iCbfX9hKQlpu0Qpc3s4/Dvrpw7VELe2sIZO8phTYIwsmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKs4MGZ3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E8291F00A3D;
	Sat, 27 Jun 2026 16:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782578139;
	bh=XdJL3R9yejRmvEHn7tZkWYwE204+inrvCodtwhhdgco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PKs4MGZ3jTawKvVRRuLhJVz9W0ZSviET+RSZrZB2PfUUSDj2t+RV97atMr2vnqksj
	 8Eb9OjTRMavmS+kUHcouHK2HE612R0gUK628nRx7rGS53Gh4u/t+/b/ih2Slc/6nXB
	 qlDaMoF36iRKVlbilDe21uPQ5S0Ur7vuRzfa7KiGGHeVQ4TKgdMaV6SQFtefrRwRYh
	 yiY8H6Q8nf4oZhCjISwEPis5ejjAC1dur4Wi36UIzD1jXy041DEoyssdUuONvu5bCv
	 HJGNNtojTDLXTyv2f1laxLuK72Wgl99CzSDnH6Zv91yxPeBwzYaJhVbQk1Y7bGpTnX
	 WecKULuNzi+1w==
From: Sasha Levin <sashal@kernel.org>
To: Wentao Guan <guanwentao@uniontech.com>
Cc: Sasha Levin <sashal@kernel.org>,
	2045gemini@gmail.com,
	davem@davemloft.net,
	dcaratti@redhat.com,
	gregkh@linuxfoundation.org,
	jhs@mojatatu.com,
	keenanat2000@gmail.com,
	kuba@kernel.org,
	pctammela@mojatatu.com,
	rajat.gupta@oss.qualcomm.com,
	rollkingzzc@gmail.com,
	simon.horman@corigine.com,
	stable@vger.kernel.org,
	toke@redhat.com,
	victor@mojatatu.com,
	yimingqian591@gmail.com
Subject: Re: [PATCH 5.10.y v3 00/10] net/sched: fix pedit partial COW leading to page cache corruption
Date: Sat, 27 Jun 2026 12:35:26 -0400
Message-ID: <stable-reply-item010-pedit-510-20260627162226@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626180735.297017-1-guanwentao@uniontech.com>
References: <20260626180735.297017-1-guanwentao@uniontech.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269400-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:guanwentao@uniontech.com,m:sashal@kernel.org,m:2045gemini@gmail.com,m:davem@davemloft.net,m:dcaratti@redhat.com,m:gregkh@linuxfoundation.org,m:jhs@mojatatu.com,m:keenanat2000@gmail.com,m:kuba@kernel.org,m:pctammela@mojatatu.com,m:rajat.gupta@oss.qualcomm.com,m:rollkingzzc@gmail.com,m:simon.horman@corigine.com,m:stable@vger.kernel.org,m:toke@redhat.com,m:victor@mojatatu.com,m:yimingqian591@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,davemloft.net,redhat.com,linuxfoundation.org,mojatatu.com,oss.qualcomm.com,corigine.com,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,uniontech.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5BA806D24AD

On Sat, 27 Jun 2026 02:07 +0800, Wentao Guan <guanwentao@uniontech.com> wrote:
> [PATCH 5.10.y v3 00/10] net/sched: fix pedit partial COW leading to page cache corruption

Applied the 10/10 patch on top of the already-queued series for 5.10.

-- 
Thanks,
Sasha

