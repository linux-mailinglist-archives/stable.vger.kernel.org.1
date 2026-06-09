Return-Path: <stable+bounces-262144-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BtABBAZkJ2olvwIAu9opvQ
	(envelope-from <stable+bounces-262144-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 02:53:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8164365B73E
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 02:53:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="MhBY/1gU";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262144-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-262144-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2A3033036030
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 00:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310B0283FDD;
	Tue,  9 Jun 2026 00:52:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B50324DD17;
	Tue,  9 Jun 2026 00:52:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780966333; cv=none; b=LVJyZPdQyDX07CdIXE3BP83SJKKfFlOasZjZBOp1suaRCeCyLVRwmaSpMKxE22QWwMBWyIHoWdHQcRJoJWUcyrUC1ZiPYP/84Coir6NoUjdCB1E73FctKHC521yaN7HvP9XQL+MP9pKKEDvc1SQBXbNBgUFbrmijWIAQr1gYtQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780966333; c=relaxed/simple;
	bh=B3Z0yRdDI4TKVLCjQtC9b3Lr5dAT/V4xp1751/shaAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dYZd2pz9BXycl0a0/ex/GngMpNgiCWl+R6qZLbm+4lpzE99GqEkcgywpkQj1sZt479H5CVp1sMKcwwJ9Ps4xApQ2FanSvu8+r/TpYj0/fMu72OAcfm0ONnAuL8euvKSk+sFbWkt17IhKSMzcnaOER/pFWbQe9ggCJVf8aI+kqY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhBY/1gU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A78E1F00893;
	Tue,  9 Jun 2026 00:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780966332;
	bh=B3Z0yRdDI4TKVLCjQtC9b3Lr5dAT/V4xp1751/shaAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MhBY/1gUADKSrb3i1kWM+R8/ma9lABVRWx0j8olVnB/sX0Vez+R5vjzncBctS0Fcl
	 LzwpPsTKOtiNy2pDL65rkVJ9YxTJFjX3pvyj7zfC8BCFVW4s8cZjsZe4oDig2Xo2Wa
	 TMKjbhgB8jo59l8eDS0j35ooTEvFv2GHn7Ju6ILLqPMY3o+IjD+ZWIOQlNXHmQq8Ti
	 rI9eIbO+KiWbtzwkJNnbcoQp7VHXmxG1qmCOPXzELs7x1Kw2X9FzNmYaTSbaDcVjGc
	 WS9JELy9SA21JrEFhyCID+wxgj1Gg4G7T9M1zm1gIGnYmQlkhJR82nZpqxqt2G5sVd
	 rvt1h9H+nD6Pw==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	Pauli Virtanen <pav@iki.fi>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Alva Lan <alvalan9@foxmail.com>
Subject: Re: [PATCH 6.6.y] Bluetooth: hci_conn: fix potential UAF in set_cig_params_sync
Date: Mon,  8 Jun 2026 20:51:51 -0400
Message-ID: <20260608-stable-reply-0005@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <tencent_42D87A0C871AE6AF019BF6AB46F003577205@qq.com>
References: <tencent_42D87A0C871AE6AF019BF6AB46F003577205@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,iki.fi,intel.com,foxmail.com];
	TAGGED_FROM(0.00)[bounces-262144-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:sashal@kernel.org,m:linux-kernel@vger.kernel.org,m:pav@iki.fi,m:luiz.von.dentz@intel.com,m:alvalan9@foxmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8164365B73E

> [PATCH 6.6.y] Bluetooth: hci_conn: fix potential UAF in set_cig_params_sync

Queued for 6.6, thanks.

--
Thanks,
Sasha

