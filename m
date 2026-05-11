Return-Path: <stable+bounces-245233-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHLQBvbmAWqemAEAu9opvQ
	(envelope-from <stable+bounces-245233-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 16:25:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A7307510174
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 16:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EFA82308F9BE
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 14:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7443FE640;
	Mon, 11 May 2026 14:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOA0gSFy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2B23FE373;
	Mon, 11 May 2026 14:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778509322; cv=none; b=SXJCaucTsyzVGUpP3AgjwOmVfsA7r1KGx2lJJoey26exhQ8Sy3H1RRsjQY9x5BAw2q2tOS67H9wzfEkVqJJXxEkRQnyuczYeGwy2z5DHEUxiBfQiREfzi7zna4j3yw9MobjLA12PXY53UC0vZB0/QSKfmoBq2doI5kXvSLvkZPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778509322; c=relaxed/simple;
	bh=E9njmTU9DIGTDZaxvKE6PTA5z96uHZzRHerGCKTjNdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q3DIHTmvKsUJNMXUQOdlAUv5fuVYPgAO4TaBfDmuxYAbuBi9sKR9La2BZUQk2Jwt8WRdRCMGQqEvycC9CVdbxR/o+TLNYAky+lduho+54xelAghAmXDxZT5zn+/KJ5lLqJ1qsHZ9uP5LUCzsERTENCzc4q/p4qgmJusIg1oWHS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOA0gSFy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 733D5C2BCF7;
	Mon, 11 May 2026 14:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778509322;
	bh=E9njmTU9DIGTDZaxvKE6PTA5z96uHZzRHerGCKTjNdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hOA0gSFy1OD6cQQXiLFeLY8OevLAzd0Lg9no+lRYaSs9sjaByz9qr6yoe7jaii0G5
	 Uh2Cpb53Cg9+/yBib1ZIeenzl5FAu/iQQTbWU/OeeTJ9uEgecT1kygjdEK2a/8pYmn
	 I7e3+eZRgR/MSZ+KGk1AuKgChx7/V1Cp63FI2vxqKOnXvuSSXedRJJ1geyVjXvrWmW
	 rP82vxqC07ajKDJHghFMKSn05+sUnwH3nobxe2vQkVOecGqlxJTXUgEDfvUkzLSslH
	 cYZX4gqIFCUCcLHsep0QRoKDPiryLrs91Fc9aRv8IKyx8LL2EGH4eMjIGCjzKWPb4G
	 Is3FnUiY1fNvA==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Wenshan Lan <jetlan9@163.com>
Subject: Re: [PATCH 6.12.y] Bluetooth: L2CAP: Fix deadlock in l2cap_conn_del()
Date: Mon, 11 May 2026 10:21:52 -0400
Message-ID: <20260511141441.stable-reply-0003@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260511074411.49809-1-jetlan9@163.com>
References: <20260511074411.49809-1-jetlan9@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A7307510174
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,intel.com,163.com];
	TAGGED_FROM(0.00)[bounces-245233-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 03:44:11PM +0800, Wenshan Lan wrote:
> From: Hyunwoo Kim <imv4bel@gmail.com>
>
> [ Upstream commit 00fdebbbc557a2fc21321ff2eaa22fd70c078608 ]
>
> l2cap_conn_del() calls cancel_delayed_work_sync() for both info_timer
> and id_addr_timer while holding conn->lock.

Queued for 6.12, thanks.

--
Sasha

