Return-Path: <stable+bounces-241329-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eC5CCNlk72mHAwEAu9opvQ
	(envelope-from <stable+bounces-241329-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 15:30:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C93864736BA
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 15:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B78AA30488D5
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 13:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34543CE482;
	Mon, 27 Apr 2026 13:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2gYhX1C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951403CAE92;
	Mon, 27 Apr 2026 13:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777296383; cv=none; b=Lem0rG9spOHXoHWL1pZa7DTiAhujR/JDFcy5JY7xn+LP4YDLy/dpckMAcQXzWwIjVREHPX/nU4ON0V+cv1fmzhml0y2TUPpkZKIUDJ5nkPgXZrsvlLGVIH7UYSV1BYmywP+JUN3d3PxZ2OmaRafyIfW6IDP4EnSruapVbxI2QHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777296383; c=relaxed/simple;
	bh=8jobtfdUiyeFErqAGFvHM8dAx+nn/UW0iXInDIFpj8Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AQiBTIiFZ3+4RPXjpbQlW8UT7QUaKQ3JzEYpPbRnRo13SBVCculrOhe+92R00oBvRBaJoUx4Z6K5o+sMAaZ/HMgYQya5BalrMNpxCYo+iF0gHT/Z+zqT1bbh2HlP9PU52AxQcRNs3afVAqHvP910sQEXIZH5eptEw7luX/QXHwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2gYhX1C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC716C19425;
	Mon, 27 Apr 2026 13:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777296383;
	bh=8jobtfdUiyeFErqAGFvHM8dAx+nn/UW0iXInDIFpj8Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=F2gYhX1CNDDNCpjNk3N7lX4Oe1ldDc0+ML4RlczEBHDA518735Odi0w/fHzPI6Uoy
	 jTMlAM2i3liQXpcLJ7p/OMICx4FGYtBPBaGKovF0kU+F1Hcvd1MDoqGT/gU9q3jNxq
	 ONUYLq0Sc0LLqkakXXaoTPgzkusIyAO2T6pujAxNkI83GcNzD/8CheUCt9LKVCCJLU
	 YuEddEZnGJKzLuHT/nptyvjIW8AQvTQ7kTtWPdnxIsz1rRkPxvESasNqxyBvJc5/LK
	 ca8vJXfWN68+5+q5vKIe00rjjpCgVBDM9kNE4YoluosbxdzQ70pMZXn2/ScsUKWqo8
	 OxLCyZlSWfJeQ==
From: Carlos Maiolino <cem@kernel.org>
To: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Wilfred Mallawa <wilfred.opensource@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Hans Holmberg <hans.holmberg@wdc.com>, 
 "Darrick J . Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Wilfred Mallawa <wilfred.mallawa@wdc.com>, stable@vger.kernel.org, 
 Carlos Maiolino <cmaiolino@redhat.com>
In-Reply-To: <20260414234513.1457961-2-wilfred.opensource@gmail.com>
References: <20260414234513.1457961-2-wilfred.opensource@gmail.com>
Subject: Re: [PATCH v2] xfs: fix memory leak on error in
 xfs_alloc_zone_info()
Message-Id: <177729638055.100803.10209353936035687972.b4-ty@kernel.org>
Date: Mon, 27 Apr 2026 15:26:20 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: C93864736BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241329-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cem@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Wed, 15 Apr 2026 09:45:14 +1000, Wilfred Mallawa wrote:
> Currently, the 0th index of the zi_used_bucket_bitmap array is not freed
> on error due to the pre-decrement then evaluate semantic of the while
> loop used in xfs_alloc_zone_info(). Fix it by allowing for the i == 0
> case to be covered.
> 
> 

Applied to for-next, thanks!

[1/1] xfs: fix memory leak on error in xfs_alloc_zone_info()
      commit: 592975da8c3ca87b043077e6eafa37665eae7936

Best regards,
-- 
Carlos Maiolino <cem@kernel.org>


