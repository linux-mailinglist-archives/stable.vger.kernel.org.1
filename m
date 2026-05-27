Return-Path: <stable+bounces-254670-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJRYO+JKF2r0/wcAu9opvQ
	(envelope-from <stable+bounces-254670-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 21:49:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7825E9A9D
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 21:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AD0C8306622C
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 19:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144073B2FC9;
	Wed, 27 May 2026 19:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E14uc6sW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86A33B19B6;
	Wed, 27 May 2026 19:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911366; cv=none; b=MzVyFHtaG+6oecRSRErstyWmLpgcSI3I/iiwI5hgMlFN0auHtbqU+ymI/J4i2Bt3Nw9Q6arAi/hOhU27FC2Ncy70Kk0Vjiiwgpt6q8SqRWTxdc1qaQa4UUjKr+OB07EmkulluMq1hI7A1slqDZo8R/ZWd8JGdsORuhH30/T6E8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911366; c=relaxed/simple;
	bh=zJzBoAZe+fT84kRsVVdwqvSWYK0yx/lSPSYr/myG5VU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWeUoJqX87JycXBNDZ4jU4mgGiHPwoTNlD2rQId0YiBcmLTOow+K78y6o6Rx5HD+oiekYvsk2c6eLQp0zzyG8fAOXFIksJfgBM6NJewYK+1srMP3bB0LAZxlLY5kIpDh7kjx7iw6zfN50grdwK1PmJhnJN3LVE6mrzGfr9ysqnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E14uc6sW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8CA1F000E9;
	Wed, 27 May 2026 19:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779911365;
	bh=zJzBoAZe+fT84kRsVVdwqvSWYK0yx/lSPSYr/myG5VU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E14uc6sWIe02TfcSGrZ/Pd5AZdhGzIZA6BPOlkSty00TommdSw3zL1xJwri8Nmroe
	 P7HBKoZ+XiV/ZviLDp+EcypN4abAlJYpMUp1kM1KNqFscEDF+evrNQlGU0KTxl4gNu
	 C992MBuTTqBOAYfc0NzQmYFTW+eA11bmDUwKLp7G0LRPE97xLMrNhW4Fxl6IEu5fgH
	 HTqX8YhRHBpYWpr3ODjUzzxjtC/Ne9RgEXk9vHjywX1Lizn2fehcte4NGDB53M+Lku
	 /5Grtb4f4CoX/2+YBvmOk5D38CgjxCOg7DFNMZb+Uh6kDNab19qWrRkwafiWHXMogb
	 eIDWz0t3NwNyw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	jianbol@nvidia.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	netdev@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>,
	Gyokhan Kochmarla <gyokhan@amazon.de>
Subject: Re: [PATCH 6.12] net/mlx5e: Trigger neighbor resolution for unresolved destinations
Date: Wed, 27 May 2026 15:49:02 -0400
Message-ID: <20260527-agent5-item010-mlx5e-neigh@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526192120.77386-1-gyokhan@amazon.de>
References: <20260526192120.77386-1-gyokhan@amazon.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254670-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AC7825E9A9D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> commit 9ab89bde13e5251e1d0507e1cc426edcdfe19142 upstream.

Queued for 6.12.y, thanks.

--
Thanks,
Sasha

