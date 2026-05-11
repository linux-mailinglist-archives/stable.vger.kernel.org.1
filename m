Return-Path: <stable+bounces-245234-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iP4DNA/nAWqemAEAu9opvQ
	(envelope-from <stable+bounces-245234-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 16:26:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E1E51018B
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 16:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17A4B3095D3A
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 14:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DCD3FE66D;
	Mon, 11 May 2026 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="POzJJkgv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF993FE65F
	for <stable@vger.kernel.org>; Mon, 11 May 2026 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778509323; cv=none; b=M/deJt/Kaz/7JtbtoZkDGmPzpLxBskT2WEU4iPg144IovTA7zazCFM2KgKivXG2R75ojLoMp9nQuZlrsdt8ZolGKXWRZifbvwSuMRnwovaamVtUuZclEsExmraUPhFtTZaN/tiMd6xm/qs0Y7SVWH4C1uUzs5tRTuUa87xZzK20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778509323; c=relaxed/simple;
	bh=vDYM9TJw2SL4NUudffta7kMxKBW8fLtS5XbiKYoN1iI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J8K551U/y4UQbNrdF/093iPkNnW2wHcoJKSvc4zOZUog6Ossup7uvDT1TaIdLoZHi7gBKDYiA2oolS0/w0M09jZ7uh1eg6gJ3+3utpEMSYn+u3KEF60eBLTT/comz4VoriQ5BR/5jaTEEylGQclTCrjUJRN4/ZFYwW82hNzpjXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=POzJJkgv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E3FCC2BCB0;
	Mon, 11 May 2026 14:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778509323;
	bh=vDYM9TJw2SL4NUudffta7kMxKBW8fLtS5XbiKYoN1iI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=POzJJkgv3zrYWSyXs7zbKoKJ7efyDBh+4IdY+j4QwhqtD8o+Axto+n+UxntNqrmoc
	 5pZoI9Y7wSfGnOYTysrRvytFYl5ERgmStKePbhkf9megMqBeqGJhpgX13zqE1Yeyhj
	 EOhRSE4aybb28RN48j/ep8kHP5eUovf78rPVZVqvVoBsq8Af/2JSAZt7h1nh9Ol692
	 tfX831yJYPVatCJTdbjoZNMJ7R4dVQxoInA+RmuzaDrOusPL55yVhoIYwDdHZZVIbp
	 EBLctOhv3kMJuPUgMtMQn2NYx8ZTWQttzoHs9K0flHnfF980SmXsulpVO9PQhDoVuO
	 Qw2nSuhqllDXg==
From: Sasha Levin <sashal@kernel.org>
To: zilin@seu.edu.cn,
	pmenzel@molgen.mpg.de,
	aleksandr.loktionov@intel.com,
	sx.rinitha@intel.com,
	anthony.l.nguyen@intel.com,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Rajani Kantha <681739313@139.com>
Subject: Re: [PATCH 6.1.y] ice: Fix memory leak in ice_set_ringparam()
Date: Mon, 11 May 2026 10:21:53 -0400
Message-ID: <20260511141441.stable-reply-0004@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260511092213.3267-1-681739313@139.com>
References: <20260511092213.3267-1-681739313@139.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 60E1E51018B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,139.com];
	TAGGED_FROM(0.00)[bounces-245234-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,seu.edu.cn:email]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 05:22:13PM +0800, Rajani Kantha wrote:
> From: Zilin Guan <zilin@seu.edu.cn>
>
> [ Upstream commit fe868b499d16f55bbeea89992edb98043c9de416 ]
>
> In ice_set_ringparam, tx_rings and xdp_rings are allocated before
> rx_rings. If the allocation of rx_rings fails, the code jumps to
> the done label leaking both tx_rings and xdp_rings.

Queued for 6.1, thanks.

--
Sasha

