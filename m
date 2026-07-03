Return-Path: <stable+bounces-271619-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RfyyH341R2oYUQAAu9opvQ
	(envelope-from <stable+bounces-271619-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 06:07:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E16A56FE4C3
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 06:07:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=NN8S6rnH;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271619-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-271619-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75DB43047E57
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 04:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AB63195FA;
	Fri,  3 Jul 2026 04:07:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFE430DECC;
	Fri,  3 Jul 2026 04:07:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783051638; cv=none; b=N9S4Eusq5YgODhu11kq4MMN0rKbHxFARylfZ92ie/cl0DaauLwqxTQ1nMXTrbIsTb2GiOjqGNbNgKwdw77iDC7v6PUbB+xs5mtpm1shIoMU3n8bVKkVvCHTg714bb+h1XAQOQ9R2Ib0KEADCycacW/mP+le2wVxK2X+HRYwHWU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783051638; c=relaxed/simple;
	bh=Kxik0PGP15X1QTMvuQHMbi9WbmUSQt+JurQoH3ADVS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bs5ot9d/pFqtkApA2vwyIRC+q/9KaBz1kywVI4xgk6z6WrPjUnYjuKIGSxb+m5Nli2kwVf44XABL1nbVDWylX25hRWoJv2EUHVqh4zfvoZF4uKdqlDBOegwNY1J5thnfumHTUywsS7qRw+AlkCAO922NFBGoeKBf7ez/rP+oJ40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NN8S6rnH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953CF1F00A3F;
	Fri,  3 Jul 2026 04:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783051630;
	bh=V/IDuOkOULpxERfKYNtIRcT8Y6B+PBtsCGeyRszDJiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NN8S6rnHQfskr2AlUKu//359uBhPBK/70zx27rEM2JidQPnd5G4Nq1SOgiF1bOUcZ
	 F9RJobWoJzgFj/wHAhPOYgWINrkWmSSq2RBMPL28LXx9fb0M3bRP+snQHcUlnAO//s
	 E3vkSs3UYyDfGm70XyBtMRa7n2FvmP6DvzIoaK9nW8QOexe7KcLBS2SrNwMqdtTVzT
	 /M+hUxr9ElP+OxbLLg9jIQ9FwI18/FS5a1yV7ZKGZWO12ZYgQiQTjJYjKAbyEv5iDi
	 hU5nYJSWLeoh4Q2RnMt8wZtoBmoOINJ0Qg1uP1Y/kI/GcOf/h1G5XuRqYl5TX6gihT
	 MqKb//Ui78YTA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	gregkh@linuxfoundation.org,
	skumar47@syr.edu,
	kumar.shivam43666@gmail.com,
	kbusch@kernel.org,
	dust.li@linux.alibaba.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Philo Lu <lulie@linux.alibaba.com>
Subject: Re: [PATCH 5.15.y] nvmet-tcp: fix race between ICReq handling and queue teardown
Date: Fri,  3 Jul 2026 00:06:58 -0400
Message-ID: <stable-reply-nvmet-tcp-515y-20260702192533@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702123757.99897-1-lulie@linux.alibaba.com>
References: <20260702123757.99897-1-lulie@linux.alibaba.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271619-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:hch@lst.de,m:sagi@grimberg.me,m:kch@nvidia.com,m:gregkh@linuxfoundation.org,m:skumar47@syr.edu,m:kumar.shivam43666@gmail.com,m:kbusch@kernel.org,m:dust.li@linux.alibaba.com,m:linux-nvme@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:lulie@linux.alibaba.com,m:kumarshivam43666@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,lst.de,grimberg.me,nvidia.com,linuxfoundation.org,syr.edu,gmail.com,linux.alibaba.com,lists.infradead.org,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E16A56FE4C3

On Thu, Jul 02, 2026 at 08:37:57PM +0800, Philo Lu wrote:
> From: Chaitanya Kulkarni <kch@nvidia.com>
>
> commit 5293a8882c549fab4a878bc76b0b6c951f980a61 upstream.
>
> nvmet_tcp_handle_icreq() updates queue->state after sending an
> Initialization Connection Response (ICResp), but it does so without
> serializing against target-side queue teardown.

Queued up for 5.15.y, thanks!

-- 
Thanks,
Sasha

