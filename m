Return-Path: <stable+bounces-267310-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mJQMCnnANGrLgAYAu9opvQ
	(envelope-from <stable+bounces-267310-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 06:07:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB726A3BCC
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 06:07:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HrTle4TE;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267310-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267310-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DA60B300B537
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 04:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACAA328635;
	Fri, 19 Jun 2026 04:07:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DA42EBBA4
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 04:07:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781842037; cv=none; b=lVaVEDJNb0168hVRTpjl2ty6+xDqRO6mzTxjbp6glzfvqyXgdATVbjuPVZCL1YaIrQsLgCA39yk3IvbLS5E/+XtGTHqFCQBDxbWZFuecaGTgKIjoOPyICpbW1U99ivNtVF5Q5dbOsAclAV6lButJLzAIFwdnaAQu0fDvx79Gtys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781842037; c=relaxed/simple;
	bh=y5i1A0j5Ue5xq91rL+zG5hkU4sCdKTD7SWwOtmjrH1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I5v+OB/eoSGT3z5WsL8iTaUCwb4FmHlQYjo1137He4wsHEX0TEg4CwLYgqzscARnvaWZyfUpdqLj0Gg8E8b4FhHi3xffzWWQKKdQldj/zvd1VDDQnjMQNpzxOQdCjc87xxaeBQMzB4ygCzd6EqRHe+z7JW8iGkBZ5mdklDiSfhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrTle4TE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6DF61F000E9;
	Fri, 19 Jun 2026 04:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781842036;
	bh=Kjc/rVxETMyiW1n5ScbNtYhHcaIzh2K10UHjHeaY/Ug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HrTle4TENtXN8qVI8BYrngkChuj5ZAj8054D04e/fMyH+HD/ZLK6jkQRqxvPcF5cp
	 uLIAtGlPHQKjeYTLOrmW6AnJE3SJsh+I7K/fJvs7lH1RKSgDLkKeBquiQJ5Zpg4pVK
	 QCmaFI+2YAbVatN/MEoba3l47nnsaWWsZMxLuyJQ2644PcD90nDNjVCRUOeLwitEYn
	 cTdES8NR7rPBMs2Exl7aMDFZPrntHfFuhC919a5O2HU5h3zbt4V6yVQN0YreZLFPUu
	 yUK4JHulJ99HOTX7SxHcFfA86+3t2DKjG1RTNnK8wOtMPPGlwRLDeM//j7qEjTwI37
	 5zG2EUotLjfCw==
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
Subject: Re: [PATCH 5.15.y 0/4] net/sched: fix pedit partial COW leading to page cache corruption
Date: Fri, 19 Jun 2026 00:06:59 -0400
Message-ID: <20260618-reply-item013-pedit-515@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618035504.1536870-1-guanwentao@uniontech.com>
References: <20260618035504.1536870-1-guanwentao@uniontech.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,redhat.com,mojatatu.com,kernel.org,oss.qualcomm.com];
	TAGGED_FROM(0.00)[bounces-267310-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sashal@kernel.org,m:gregkh@linuxfoundation.org,m:guanwentao@uniontech.com,m:stable@vger.kernel.org,m:2045gemini@gmail.com,m:dcaratti@redhat.com,m:jhs@mojatatu.com,m:keenanat2000@gmail.com,m:kuba@kernel.org,m:rajat.gupta@oss.qualcomm.com,m:rollkingzzc@gmail.com,m:toke@redhat.com,m:victor@mojatatu.com,m:yimingqian591@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BAB726A3BCC

>  [PATCH 5.15.y 0/4] net/sched: fix pedit partial COW leading to page
>  cache corruption

Queued the series for 5.15, thanks.

--
Thanks,
Sasha

