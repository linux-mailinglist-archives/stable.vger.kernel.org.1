Return-Path: <stable+bounces-237849-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLegASUv3mnxogkAu9opvQ
	(envelope-from <stable+bounces-237849-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 14:12:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC75A3F9DBD
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 14:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 035F63092658
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 12:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5E53E51F8;
	Tue, 14 Apr 2026 12:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u05Sk4qB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBE71FC8
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 12:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776168511; cv=none; b=P+mP/rq8CcFbhCf19C4LIeQvvMPEyNmdOOINFbh+FUl2pHKlfTGqxwXSmzBX8D4A1ATbqm56652WBoY4sz/7GGCIzb7o9Ywui2TcV9TFYEzkeBFefCosDXySrqsq5UaT2LYXUnt608eSgRyf/raZkx0Y5eLGypj9T/jQ4kXTs0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776168511; c=relaxed/simple;
	bh=aVVSplgAhHlpyN1juasgkCoCXwiCqmpIPdIgPmJp5eU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SuD4D5XAhodpiL74HHnf0NJ1OLK/fP8OgjK0+OVsryWEpT8WLfT4+E0kzNnHoaS7nMyOaqiON9e7h6UAkBgijh7B1NYTpuDx7amGYPHkHi30Dhb9sGlU0eCvBAjpOvQ4CE9r9BNvG5rjDi0m9PKdRj9OjjZJtlQjoPaRVd+heAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u05Sk4qB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67EB8C19425;
	Tue, 14 Apr 2026 12:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776168511;
	bh=aVVSplgAhHlpyN1juasgkCoCXwiCqmpIPdIgPmJp5eU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u05Sk4qB3q4LlbU/wQDqddYmcDYNJhRsFuGsxlzCQd4+dioOjTXRRWztpXanUDPev
	 puqerDuSQzp64UB0fPqvbAL8HBdITKo6ZKP9Yt/xSYZx+902YRThWDY1ZvqJ5nDeX1
	 46SUxjeVcGrTSkQphPb4KsEd3FhoY5/VYhMuu7ndpdg/6pwXN5Xn4qNuRPCfDJSqNK
	 8G/ojssHvaGwNMIaAatF3Y8+zsC5pxizbHz9NfbNPX8sqv7EOCu6KLxuwOyzXqZHm2
	 1LHSbb/2eXUuP8NdBIgukCKoCm+DGJ/0bMtfuaYLQ9i6lXpxpQ7ZM+TEZrDiniYTW5
	 n2Ott1P/e0dmw==
From: Sasha Levin <sashal@kernel.org>
To: Li Xiasong <lixiasong1@huawei.com>
Cc: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	matttbe@kernel.org,
	kuba@kernel.org
Subject: Re: [PATCH 6.6 14/50] mptcp: fix soft lockup in mptcp_recvmsg()
Date: Tue, 14 Apr 2026 08:08:29 -0400
Message-ID: <20260414160000.mptcp-drop-6.6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <52ea906c-0953-4d2c-98ee-b873ecc6a075@huawei.com>
References: <20260413155724.497323914@linuxfoundation.org> <20260413155725.042518976@linuxfoundation.org> <52ea906c-0953-4d2c-98ee-b873ecc6a075@huawei.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-237849-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BC75A3F9DBD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 14 Apr 2026 09:30:06 +0800, Li Xiasong wrote:
> Please drop this patch from 6.6.y - the fix targets mptcp_recvmsg()
> soft lockup, but the receive queue handling differs between mainline
> and 6.6.

Dropped from the 6.6 and 6.12 queues, thanks.

