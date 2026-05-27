Return-Path: <stable+bounces-254674-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cE7EBGtMF2pUAQgAu9opvQ
	(envelope-from <stable+bounces-254674-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 21:56:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EC65E9CAF
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 21:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD08B30DBC28
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 19:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612013B19A6;
	Wed, 27 May 2026 19:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jsZOUKHi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8503B19D5
	for <stable@vger.kernel.org>; Wed, 27 May 2026 19:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911373; cv=none; b=YiozEbPAQNkutTX/pv4Oozv0lhjc/fK52H7NAgP+AMuZOG+3MY6b9suYUYPwK4S0D1GSfESM5nVZ6X8BVpx7M25SOCPnvyxa927dvEVkFyQ1XMAiY03iO3LIEUQdsm3xjfaVz8dZfsU1wRy95AT82D6EmaGzxMd9D9k3/YvuxPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911373; c=relaxed/simple;
	bh=IyUXOtPTdnILWDQ0KsasBy0n/Mbz1RcN48awrgwnmE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZYauuZpFqy20RNKqeZBpM63G/DDBQx9nsbQxrExDkHCA7aFYt5DPasczDyeoQRuWx4DDM8W7IrZ+A69CLSC7Dj/YHw/VNaYjZWTfvvGJ/SyYID2tzlPN1XkZdwllLd60VTM6iR1OO9ng4G/7WrUKh0sjtGoL/Kn6l32FhUzY3Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jsZOUKHi; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862E71F00A3F;
	Wed, 27 May 2026 19:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779911371;
	bh=IyUXOtPTdnILWDQ0KsasBy0n/Mbz1RcN48awrgwnmE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jsZOUKHi3pBiMJCvGjRBoIkiuDPq7dfJCJvcWDGbDiMG53jN31HKGWUyEoN4NpRCk
	 hVW1NBv6KieMX+G8mvTub7OI/UHTaSJq4uqHsRg9SEbHkr5bS3fbS4HBodEKd6C7t+
	 wVySl9kb9kyoPJAWssR1Qt6lc20inB+VR2crZ+68UJcCaNoz2BRAhPixT6LFgsuJy0
	 B6PMQm3+W3PJv8XAZ1uKpmw2WVcndnZzYTY96UAYkVhI/CGlddXCP60tTrBBo0FUeo
	 I17fZWbTbheFD5NOGfClQB2TQK5VhL+YJp6U+K3i33xf5aakGJzFMKf4X5StIGdHwN
	 SOjCVnJKNY+QQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	pulehui@huawei.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alexghiti@rivosinc.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	bjorn@rivosinc.com,
	linux-riscv@lists.infradead.org,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	Gyokhan Kochmarla <gyokhan@amazon.de>
Subject: Re: [PATCH 6.12] riscv: fgraph: Fix stack layout to match __arch_ftrace_regs argument of ftrace_return_to_handler
Date: Wed, 27 May 2026 15:49:06 -0400
Message-ID: <20260527-agent5-item014-riscv-stack@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526192517.82022-1-gyokhan@amazon.de>
References: <20260526192517.82022-1-gyokhan@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254674-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 85EC65E9CAF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> commit 67a5ba8f742f247bc83e46dd2313c142b1383276 upstream.

Queued for 6.12.y together with the HAVE_FUNCTION_GRAPH_TRACER /
HAVE_DYNAMIC_FTRACE_WITH_ARGS prerequisite (e8eb8e1bdae9), thanks.

--
Thanks,
Sasha

