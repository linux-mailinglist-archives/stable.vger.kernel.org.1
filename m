Return-Path: <stable+bounces-260195-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gYmlHtaSIGr85AAAu9opvQ
	(envelope-from <stable+bounces-260195-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 22:47:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CC32363B348
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 22:47:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260195-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-260195-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=collabora.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EB6AB3026471
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 20:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A937E402B86;
	Wed,  3 Jun 2026 20:47:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA6539DBFD;
	Wed,  3 Jun 2026 20:47:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780519623; cv=none; b=Yoao5KJMLaOek2mp+EF7Js6qpvk9GDY/rdjiUaG/5rWlzbOMHZmd34SEoniNS++nvbR0MCw+zjSh+VmQrIPY9OCdlqRdUgtELVYi/AneJYBFuEWGCfTEoFlWTczkiS2boSfEJK/+6k3ahgdDkebv+qPmYR5JCyefF5iUjLirfek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780519623; c=relaxed/simple;
	bh=3ldfLlzV7SiXkElP3s/RDvLIp+kEC+gqbQUC+4m+ucY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PCL+h9x/qUxKwBV57aPB7d8PyV6bVNh1sUMtVS9ibqiiScCYDzFG+oBMhkAUuAC+2f/KUZzKjXUiQOVnojYQjozvChINQhtnBwFm6f5HavlaUMbSMnt8X+bxzyfVbmXILwG4UQWb4cpxTWURCsncccxGD7auY52Ypt3UFhYozc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48FDB1F00898;
	Wed,  3 Jun 2026 20:47:02 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id DF561183854; Wed, 03 Jun 2026 22:46:59 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: sre@kernel.org, philipp@uvos.xyz, Ma Ke <make24@iscas.ac.cn>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 akpm@linux-foundation.org, stable@vger.kernel.org
In-Reply-To: <20260424011013.879639-1-make24@iscas.ac.cn>
References: <20260424011013.879639-1-make24@iscas.ac.cn>
Subject: Re: [PATCH] power: supply: cpcap-battery: Fix missing
 nvmem_device_put() causing reference leak
Message-Id: <178051961989.2666348.3637459049042630916.b4-ty@collabora.com>
Date: Wed, 03 Jun 2026 22:46:59 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[collabora.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260195-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[sebastian.reichel@collabora.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sre@kernel.org,m:philipp@uvos.xyz,m:make24@iscas.ac.cn,m:linux-pm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:akpm@linux-foundation.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebastian.reichel@collabora.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,collabora.com:mid,collabora.com:from_mime,collabora.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CC32363B348


On Fri, 24 Apr 2026 09:10:13 +0800, Ma Ke wrote:
> In cpcap_battery_detect_battery_type(), the reference to an nvmem
> device obtained via nvmem_device_find() is not released with
> nvmem_device_put() on the success or read-failure paths, causing a
> permanent reference leak. The driver’s retry logic on subsequent
> battery property reads can compound this leak, preventing the nvmem
> device from ever being freed.
> 
> [...]

Applied, thanks!

[1/1] power: supply: cpcap-battery: Fix missing nvmem_device_put() causing reference leak
      commit: a2c14ff63e0e02e3c832385e523e9cc81301171c

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


