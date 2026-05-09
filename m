Return-Path: <stable+bounces-244886-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLoTEzSX/ml5tAAAu9opvQ
	(envelope-from <stable+bounces-244886-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 04:08:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A654FD8BD
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 04:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0573A3008D43
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 02:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C252C028F;
	Sat,  9 May 2026 02:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMjPmNH+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B6D27874F;
	Sat,  9 May 2026 02:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778292527; cv=none; b=MaKqcIXkFgpCb+s8NvuytSzEvEcCKsdadDcyCk2KHJxyfO1K1viqIdaMjUVw4ZG3iSIdwwuJuvZFv7xFcq9mtgJ/KCrkd7xF7W7E95KxgVgVzdP4gafSCKwThCUd4QyyJwza7JcU4jLlWuGzRozBlxaayeCHMwwKUfB8XwuTHrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778292527; c=relaxed/simple;
	bh=KG9aytZQNyLOuti2Qvw+0nxc891otfs+o8ENIUpCR+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GAQbQECIaIohA+LiL/z1avGMV6Gp9hkaxaBcJ7Y63ZOkb1g4uFKtz4d2aI/3b5HLcQuLzDzEjsBt4ZxMmKSriLviI/HAy1/hTo643Rkx05lC7arJYV/92X76ldIj7kNqxkZZBZdhp7oScmrL3CLYo0LbClkI1W+/0bXkXS3Ksq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMjPmNH+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE15AC2BCF5;
	Sat,  9 May 2026 02:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778292526;
	bh=KG9aytZQNyLOuti2Qvw+0nxc891otfs+o8ENIUpCR+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HMjPmNH+tttbb1g24KHnI/TmgELHwJdsKYdY0OaEgR+NtQW1eZ5OL8hvCzSVQrdbk
	 dntQOXe9IsqfdXH4ImNVkZV8C/oMBhllJPnzvQCC1NWPT7tOvKUmpYX8AbnRSfX9WX
	 YSdGTQUTG+b4Q+KlFQIMW+D2Mf6l/1xVuGQ8rrw/rm+qwwI+DH/hmZUE71225aYm+s
	 XuNXf1JRe3n7+p2gd+E2kwcboA5ZFQWMyeN7WEl7Fy+tE9bVacCaxDv5i8F61GLOlY
	 Y0BVY7WtDR1MBQkCBW16JO3QgEDUhzem3/VG2yEH23mw00ibftXeQXRoXhFcMmOOZI
	 rN13o3cpLwf6A==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Wenshan Lan <jetlan9@163.com>
Subject: Re: [PATCH 6.6.y] dmaengine: idxd: Fix leaking event log memory
Date: Fri,  8 May 2026 22:08:39 -0400
Message-ID: <20260509015927.agent5-0003@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507040415.565-1-jetlan9@163.com>
References: <20260507040415.565-1-jetlan9@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 16A654FD8BD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,intel.com,163.com];
	TAGGED_FROM(0.00)[bounces-244886-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 12:04:15PM +0800, Wenshan Lan wrote:
> From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>
> [ Upstream commit ee66bc29578391c9b48523dc9119af67bd5c7c0f ]
>
> -	gencfg.bits = ioread32(idxd->reg_base + IDXD_GENCFG_OFFSET);
> -	if (!gencfg.evl_en)
> -		return;
> -
>  	mutex_lock(&evl->lock);

This drops the only thing that protects no-evl-capable hardware
(idxd->evl == NULL) from dereferencing evl in idxd_device_evl_free().
On 6.6, idxd_init_evl() returns 0 without allocating evl when
hw.gen_cap.evl_support == 0, and idxd_device_evl_free() is still
reachable in that path, so taking ee66bc29 alone will introduce a
NULL deref on hardware without event-log support.

The required prerequisite is upstream commit 52d2edea0d63c
("dmaengine: idxd: Fix crash when the event log is disabled"), which
adds the "if (!evl) return;" guard at the top of idxd_device_evl_free().
It landed as patch 2 of the same v3 series and is missing from 6.6.y.

Could you resend as a 2-patch series with 52d2edea0d63c as the
prerequisite? Then I'm happy to queue both for 6.6.y.

--
Thanks,
Sasha

