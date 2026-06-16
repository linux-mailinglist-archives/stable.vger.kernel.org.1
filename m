Return-Path: <stable+bounces-263522-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OAy/B9i7MGoKWwUAu9opvQ
	(envelope-from <stable+bounces-263522-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 04:58:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DD09F68B959
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 04:58:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HIieo5IO;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263522-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-263522-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF160302F4EF
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 02:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B74637C91E;
	Tue, 16 Jun 2026 02:57:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5533AA1A1
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 02:57:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781578676; cv=none; b=d5fK4lStnvQtwqzEEyAcM+dQzxAknPmt9Da3JGITXQIBu4L9xByQmFjUyVs2Tq8ZOqc12o4tHovmU5ki6ZiTsQAOO6YYM8YBWUiMVtJHp/E4gXec3nt8iYDIZB46ZtLiGknMQ2m60IA1tKKt37TdsV3EXGtgJxLdmcychf9FbtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781578676; c=relaxed/simple;
	bh=/wWdg1Dafmd+Z1nUL/kWOfWvtap5yY4WzBV71mj5gNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KqMQvaMtuMo4utt31iN4ln0dAsIojheUEvyoI/YmxuVuE3lxiFWHwyiTYpkB6ikJNFhpfCm23ix1F+190d27XFq8az9hnQpqnW/ByYjD93qlN3kKRIbFplDWY8qwJgXrVwStM+RvO8nFoL0+wxr+R/cec3oeuEBWidpKerGm5eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIieo5IO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 983A61F000E9;
	Tue, 16 Jun 2026 02:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781578675;
	bh=/wWdg1Dafmd+Z1nUL/kWOfWvtap5yY4WzBV71mj5gNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HIieo5IO2xQcDZED7tFIJO14CqB/hSkjHn4dk/lEznsWYRgxUKzHcPVmYCTfTu6jN
	 M+K+h8WO2UTTa0W3gyfyaWp/Dva+0IXyPsdQJjibQS4iU3TOS+G7jqGj4bWM4Gz6EC
	 M+Jsy0kMRv3giZrmIlsH38FkxFwDK1IHF8vDEhWv5gm9X3YVEYZSlONH3jBYGfIAAL
	 wLO9FCKv9LS28bJnbm+0pzMF0Zly36hm0anSlQwgjYFkwjYRQ/I/VekujW/MHQo4Tb
	 yP3QPEaPZ+AqkuwMGsFGiDyXbuk4TuEw3qEyfH1Hsj1WDYpfOS3EaxVWhZz8wJ4gVO
	 xEt5fKRCo2Pxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>,
	Matt Fleming <mfleming@cloudflare.com>,
	Matt Fleming <matt@readmodwrite.com>
Subject: Re: [PATCH 6.18.y] sched_ext: Don't warn on NULL cgrp_moving_from in scx_cgroup_move_task()
Date: Mon, 15 Jun 2026 22:57:46 -0400
Message-ID: <20260616130130.1000004-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260615124703.2238517-1-matt@readmodwrite.com>
References: <20260615124703.2238517-1-matt@readmodwrite.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263522-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:tj@kernel.org,m:arighi@nvidia.com,m:mfleming@cloudflare.com,m:matt@readmodwrite.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DD09F68B959

On Mon, Jun 15, 2026 at 01:47:03PM +0100, Matt Fleming wrote:
> [PATCH 6.18.y] sched_ext: Don't warn on NULL cgrp_moving_from in scx_cgroup_move_task()

Queued for 6.18.y, thanks.

--
Thanks,
Sasha

