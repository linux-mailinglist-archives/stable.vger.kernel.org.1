Return-Path: <stable+bounces-244960-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0I8XKTVG/2mo4AAAu9opvQ
	(envelope-from <stable+bounces-244960-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 16:35:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF2950014F
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 16:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DA58302BA66
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 14:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E557C3939D2;
	Sat,  9 May 2026 14:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZ7KsADo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C62DDC5;
	Sat,  9 May 2026 14:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778337128; cv=none; b=ELGbakhxQSeU8VDDvv9MwA98IkCUfTUs+x/Y+spuNSHpG3/kDmm82CjXIQcih7Gf4EwP3Q2ZxHE1xhGug59g3iRnKvr7p1GniuLP/dGRfc3ACmrOoNgVbDNPiw+uiX0RYycC8qfrs2e/UcVEDxEiP2Eff1EYFs9kq356zF/sRAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778337128; c=relaxed/simple;
	bh=Bvv7Mj/djx8EnBa1orX3uFOqB6n3OEW+iGtbclW/Tpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SKlTDNgj36spvlgkArrC4huZf1DtUA+e39vYJJswq0nzDXmnWsEdW4Pza4n6ylRSDr/R6+PbgpZQKzvtVN+zKm8oCfbWy8bsSuFsgj2t4W5ggYXaJ6RtHqnUQ1r/tDnmExoeI9FyXNz7/bvTuXOib3XZ6kBYIWteLh8vVWIqtbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZ7KsADo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B3FAC2BCC7;
	Sat,  9 May 2026 14:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778337128;
	bh=Bvv7Mj/djx8EnBa1orX3uFOqB6n3OEW+iGtbclW/Tpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KZ7KsADobhmLK3hRVgjkhSfRZIwEHcT4VK8naBPIeg7JY2G8hIXhp0UrRBoXPMP3a
	 GE8oNGyunxh0KNnOLEb+DjuT+PrcW39oaXlyQYObZpDXlalj35jn4NbqQXFWqAzqRU
	 qV1BMJLbq9w9H3jQSuA7CHzHLkrklyy3anjZy9ES+Uzi5TyozbHGbu4vNrOfyshusl
	 RRwH44kguptTijWIwKYPSA2+De+8tFIFcaHEgh2qE60zEF5fvmGsNEK1DXxifbPoFw
	 IACIBIqW0QnxmASLzqR84i3lrnB4lDN0JQjC1o874TXVtA55BqRF8AW6uY8JhTFiqs
	 eCWzjeYBDbg2A==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	vinicius.gomes@intel.com,
	dave.jiang@intel.com,
	vkoul@kernel.org,
	jetlan9@163.com
Subject: Re: [PATCH 6.6.y v2 0/2] dmaengine: idxd: fix event log crash and memory leak on FLR
Date: Sat,  9 May 2026 10:32:01 -0400
Message-ID: <20260509143000.stable-reply-0002@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260509074822.2587-1-jetlan9@163.com>
References: <20260509074822.2587-1-jetlan9@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6BF2950014F
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
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,intel.com,163.com];
	TAGGED_FROM(0.00)[bounces-244960-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

> Changes since v1:
>   - Added prerequisite patch backporting 52d2edea0d63 ("dmaengine:
>     idxd: Fix crash when the event log is disabled") so that the
>     ee66bc295783 fix doesn't regress hardware without event-log
>     support.
>   - Documented the partial backport of 52d2edea0d63 (the
>     idxd_device_config_restore() hunk is dropped because that helper
>     does not exist on 6.6).

Both patches queued for 6.6.y, thanks for the quick v2 turnaround.

--
Thanks,
Sasha

