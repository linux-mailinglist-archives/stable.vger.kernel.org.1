Return-Path: <stable+bounces-262530-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OSTfCvSLKWqzZAMAu9opvQ
	(envelope-from <stable+bounces-262530-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 18:08:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6714D66B2E6
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 18:08:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=NkN1jwhK;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262530-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262530-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DDB03477170
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 15:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F967428470;
	Wed, 10 Jun 2026 15:47:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A023DBD7A;
	Wed, 10 Jun 2026 15:47:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106441; cv=none; b=d6r+J0MaqBXH5zQwQ0rsXfbE1yRYTbxuIgMWzBRV1/VDt0kNnH3KAJzhrEgJPGxa3t03eDgr9BKRV64MBLDqCR1PnHtN7k8ju3dSY1DgJsHJMcLJepn04XtCc8tZcCPpxiiqY7DuYcacPoBlV4TKpkpjHtj3vT/S8HAZykf+0QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106441; c=relaxed/simple;
	bh=lPagUjN5wyxfSqvytAIAj0NOyzMlBLE4JYZ+/pTWm9I=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hisV+iyvT9KQCee4gAGpNxTBgPHzfyr9iGuHjLi/oee85C2LbRzZ6LO3Dg4S2Ydq2dj4j7Q/QQpNzdbxfmjqtFs1XgGeaLVTjgSfP+i1cgB0TMHVMFKkRktFPVGHTrdMBWfqXVdSE/YzkV2V4v1G+Fw2tyTiGjQO/+Tla9P5fGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NkN1jwhK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 279001F00893;
	Wed, 10 Jun 2026 15:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781106439;
	bh=94laT4DhQ8CjN3VZcNNgN9Mk+ciT8XIRfv1gtFlc3dM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=NkN1jwhKxYf98CSixPxGg2LooDQ8/+4u0EwPF+e/AQkrVQW5NrV46OxWaFYSRUWtM
	 FXS/bQ5gBwcuss3sgrttEEmW9qpP1uL/q54ZANJLLhNHGQUyv7B3ugoW/dnj1ECPDZ
	 8iRgLehshnzRsIfx9lSQa4vgmCybVPHdE2qYo1KYJWop2asNf6HgGWLsJ6pbFx4EKF
	 yQqFR/LatQtkq0XOcTPacQfuF0QWTDQ3Wt6WQIj/b1N87UzGN/vhvr4mX2vYZleNb9
	 ysrWy9keqAIIK736OAefay19W5YBW06fmk8dInxITK4NKCzSEzFb6yDAv6zyXdTyGi
	 q0f8QUzaGTxnA==
Date: Wed, 10 Jun 2026 17:47:15 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Jinmo Yang <jinmo44.yang@gmail.com>
cc: linux-input@vger.kernel.org, benjamin.tissoires@redhat.com, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
    Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>
Subject: Re: [PATCH 0/4] HID: wacom: add report length validation in irq
 handlers
In-Reply-To: <20260517135215.2220117-1-jinmo44.yang@gmail.com>
Message-ID: <9o1psn77-q665-0rp6-pnnq-9179802p2nsp@xreary.bet>
References: <20260517135215.2220117-1-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jinmo44.yang@gmail.com,m:linux-input@vger.kernel.org,m:benjamin.tissoires@redhat.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:ping.cheng@wacom.com,m:jason.gerecke@wacom.com,m:jinmo44yang@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jikos@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-262530-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jikos@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,xreary.bet:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6714D66B2E6

On Sun, 17 May 2026, Jinmo Yang wrote:

> Several wacom IRQ handler sub-functions access fixed offsets in the raw
> HID report buffer without validating the buffer length. wacom_wac_irq()
> receives the length from wacom_raw_event() but does not validate it
> before dispatching to the sub-functions, which do not receive the length
> parameter.
> 
> A malicious USB device can declare a small HID report in its descriptor
> and send a matching short report that passes the HID core size check
> (csize >= rsize), but the driver assumes a full-size hardware report
> layout, leading to slab-out-of-bounds reads.
> 
> Note: this is not mitigated by the recent HID core bounds checking
> series which validates actual_size >= declared_size. An attacker
> controls both the descriptor (declared size) and the sent data (actual
> size), so the core check passes. Driver-level validation against the
> expected hardware report layout is still necessary.
> 
> Tested with KASAN on Linux 7.1-rc3 (slab-out-of-bounds confirmed) and
> verified kernel panic on a production device via uhid.
> 
> Jinmo Yang (4):
>   HID: wacom: validate report length for PL and PTU handlers
>   HID: wacom: validate report length for DTU handler
>   HID: wacom: validate report length for DTUS handler
>   HID: wacom: validate report length for 24HDT and 27QHDT handlers
> 
>  drivers/hid/wacom_wac.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

CCing Ping and Jason for their review. Thanks in advance,

-- 
Jiri Kosina
SUSE Labs


