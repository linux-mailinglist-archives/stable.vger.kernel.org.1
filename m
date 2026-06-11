Return-Path: <stable+bounces-262596-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l9JsMyEGKmq7hQMAu9opvQ
	(envelope-from <stable+bounces-262596-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 02:49:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 921FA66D8F2
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 02:49:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="b+/A4ZE5";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262596-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262596-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC1D4322982D
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 00:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315B021A95D;
	Thu, 11 Jun 2026 00:45:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E541519B4;
	Thu, 11 Jun 2026 00:45:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781138746; cv=none; b=cGal/bj4vR29Hbs2dmeydTgbhH0MaQUcuCcNdpCIZpqHCaFg0LthVULbUHUqWXgD++XD+CgMEKpnjncadknYq2ITDvqt8QQtYSZErcK21ltrEux57TVNTQBYPGTXFUvbccyKLR3ByhafCGyou/Wml97i1FvClH/pkf5CGdk4w2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781138746; c=relaxed/simple;
	bh=lTAxjqD2ptN6Nytpf7j8GNCCjkya1kMoimCQC87flzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R/E+M26Vr04U35a2SyZzho8rHvtWUScHZV3Y1diRc/kf+EN+pIXoe/ovINmaQ5M3w+ywwD3Z0yjcK4/Z5BgDN+u/jeVBsD+Aui2MbpnJflU3zeC2DEHsDAd2+sTB/oCOhbGOygnZ7rCX/s4rkvmLzh9eet7zzVJ+0A+mT98f10E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+/A4ZE5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A851F0089A;
	Thu, 11 Jun 2026 00:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781138745;
	bh=lTAxjqD2ptN6Nytpf7j8GNCCjkya1kMoimCQC87flzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b+/A4ZE56l6Pfm7lGyz4H6+jKBFDShNu22o7NhZqMicwC4iFgSQ/a6vmf00nQLty9
	 rPrSNk4FqbPzSsE38L3RHqA+MwgmEBzCPoZ54Oz6ULFeQDBHYo5oInUBAQHU1Pp+jD
	 SdCqakzWEaPuy7QRIw5tpovn4oORxvXDf/wbq53wL9MDenyw3satNCEALLTAmVcGxe
	 xLExiUEsadcLBEjdQXDZdB7k1nA5Z4jydP/T3gN/VDhMABxpa0oNVB7Ch/XLQuXk0q
	 yJknVGOPFgjepPa4GXt0M4XL1O68bxHPSXyTYRhubEt9d6Sv6LWW4A2bhsf+WfGYB7
	 VO1vyD1ZGDaHg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Dhruva Gole <d-gole@ti.com>,
	Apurva Nandan <a-nandan@ti.com>,
	Robert Garcia <rob_garcia@163.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.12.y] spi: cadence-quadspi: fix unclocked access on unbind
Date: Wed, 10 Jun 2026 20:45:26 -0400
Message-ID: <20260610-stable-reply-0013@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260610020809.2695490-1-rob_garcia@163.com>
References: <20260610020809.2695490-1-rob_garcia@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262596-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,ti.com,163.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:johan@kernel.org,m:sashal@kernel.org,m:broonie@kernel.org,m:d-gole@ti.com,m:a-nandan@ti.com,m:rob_garcia@163.com,m:linux-spi@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 921FA66D8F2

On Tue, Jun 10, 2026 at 10:08:09AM +0800, Robert Garcia wrote:
> [PATCH 6.12.y] spi: cadence-quadspi: fix unclocked access on unbind

I can't take this into 6.12 on its own. We don't backport a fix to an
older tree while it's missing from a newer one, and 233db2cb14db isn't
in 6.18.y yet.

If you can send a 6.18.y backport as well (adapted to the older
cqspi_remove() there), I'll queue both together; the 6.12 patch itself
looks fine.

--
Thanks,
Sasha

