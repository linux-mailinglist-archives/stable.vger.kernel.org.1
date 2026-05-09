Return-Path: <stable+bounces-244943-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFIlIbkt/2mT3AAAu9opvQ
	(envelope-from <stable+bounces-244943-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 14:51:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 599F74FFACF
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 14:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3C283062C15
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 12:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E7C389107;
	Sat,  9 May 2026 12:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ssG55/eL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D1A388E6C
	for <stable@vger.kernel.org>; Sat,  9 May 2026 12:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778330851; cv=none; b=F00HRjFBMtLxSX9s/BdZMcWKHt/crO9RLg7TpOcy8JES+UyodLlFruS+kcxPmx6EK/85+xELA3W1ofCiqYhjoGVXR8eqAcRkQrlCEjuDWTsIfEBT/H5dOZA33CQKSWkOpRVxpvNtm5rLbyhOS2ksToxjyuKKnOvD/R0pEnxryp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778330851; c=relaxed/simple;
	bh=/3pVXZ/55O0bDFsm03HVCNa/nBqH4VsN/7/2BtAVYNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IwCyrZ5lzHKG2XAxvjG3qsea0CRL69+lr5oZqDBkG/JvYHtpwyFIrfEiMDKcj2XZZ0wPxquUrUkLkeSBeZe0BNju859y+/MTJWdFDBosx+LTfD6Jg8Uteq9ymmm9hv5f7Ug/g/NXAmbbzCYLp4g+gLeHqrlpZxElj2y5NRCaItE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ssG55/eL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47525C2BCB4;
	Sat,  9 May 2026 12:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778330849;
	bh=/3pVXZ/55O0bDFsm03HVCNa/nBqH4VsN/7/2BtAVYNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ssG55/eLFRRo3JGkRPEL02JLVukAFKBRagJl/CAfQLzRw2RxV/aENUoC1Phg6AgFk
	 s7+kzmI5gXUzR+0tbHpJ8evpVDFk9py3ICIWfLx1JsEpy+k6RTQYYAhd8uiPTKfqOC
	 hthIckSOkIQ29KRJtuYsytjrbQnnLZLBiufRurda7VW3kJlhb04TT1v1m7gt72EcTG
	 4wfFVmvh0VoAdOsJGSxS7Z0UM/lImu+E/y/pxhJAsK62N8Yr6kgAI7kDBjb6vWSGpa
	 jO7dizIJr352wkuflYGFAJlPaclUsCWrlv+v4lvWXJDr2BDMUTPO8N+iQLZsoER0RH
	 YWzd9CgYQUx6Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Dong Chenchen <dongchenchen2@huawei.com>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.1.y] net: Fix icmp host relookup triggering ip_rt_bug
Date: Sat,  9 May 2026 08:46:52 -0400
Message-ID: <20260509122858.4896aa4dd204.re-net-icmp-relookup-6.1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506012057.285743-1-jiayuan.chen@linux.dev>
References: <20260506012057.285743-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 599F74FFACF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244943-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

> [PATCH 6.1.y] net: Fix icmp host relookup triggering ip_rt_bug

Queued for 6.1.y, thanks.

--
Sasha

