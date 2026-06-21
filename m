Return-Path: <stable+bounces-267537-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oaZ3APHfN2osVAcAu9opvQ
	(envelope-from <stable+bounces-267537-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 14:58:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A516AAC9B
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 14:58:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ej4GDNKp;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267537-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267537-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0EC623014759
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 12:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A506D3659FB;
	Sun, 21 Jun 2026 12:58:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EA3235BE2;
	Sun, 21 Jun 2026 12:58:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782046681; cv=none; b=pnC48n/nv+DpvjfhEUTVGUtog5cubsPQDMK/cMjswMQxKKjSpslBpg/3c/st7yQpZjbYdfz33n4RCUQuTnfCbXbWgLFwKCikB1R8b6yAxXm/uhBaPlgVh/0KFVRj4/8vRhOcEEDnFVPDw2kSUTX2uzaJg8HOoTn/0lzU68BB6Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782046681; c=relaxed/simple;
	bh=dwyyFF+yPpoJif6/OWI2GLmuQ0czkd3E3lwUANbsdlU=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=qBCRjQgNpnYtiY00oKK1V58HvlA2rtJfNBRgzp8D5brxEjK3f3rQnV+cyQ3Pudfo1bvjKCAQ1bRw7i87VaWlvwQSHYs2qS0PoBJ/vtzF9/HqE7U+pfvSTME89KjE4UJJM5YQ1BJf9kr1ypogKsy15SyK/S0NaQhDA0aLY2GXv+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ej4GDNKp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201171F000E9;
	Sun, 21 Jun 2026 12:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782046680;
	bh=dwyyFF+yPpoJif6/OWI2GLmuQ0czkd3E3lwUANbsdlU=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To;
	b=ej4GDNKp63e4A8UkddmF6kyff7rAp64pM6UmytdApC9Z2U8CNc8xpnXLbGVRgaq6O
	 z5VxJDYF3OJ+YtwKWSZjESGuCTKgCawhuCUi63t8WvgJta4H/ouC1WoJI2Nw3cXQ0o
	 2V6H5INF+O3H2STyL7aUVK1/0NVGv3du7lkPSRrv+hb2i7idUkEhwaScyskTQCT1+F
	 KC7+3TjE1aLVF8G/n1bLLW8hbjeaySn4/MwuenoOo58WNYQVSwuhll7muW+aBYDUS2
	 OiEhsWBaiYbOcAOZvJU4UM8Sfzh+zdgGaVMJgya2WANSu9cYK5Jjej2+DGVuCR2WW0
	 ZCxodLUPOamHg==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 21 Jun 2026 14:57:56 +0200
Message-Id: <DJEQTPJAR8DW.18CJ2FC7YZPA3@kernel.org>
To: "Dawei Feng" <dawei.feng@seu.edu.cn>, "Timur Tabi" <ttabi@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2] nouveau/firmware: fix memory leak on BL load failure
Cc: <lyude@redhat.com>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <simona@ffwll.ch>, <dri-devel@lists.freedesktop.org>,
 <nouveau@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <jianhao.xu@seu.edu.cn>, <stable@vger.kernel.org>, "Zilin Guan"
 <zilin@seu.edu.cn>
References: <20260610025037.4115412-1-dawei.feng@seu.edu.cn>
In-Reply-To: <20260610025037.4115412-1-dawei.feng@seu.edu.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dawei.feng@seu.edu.cn,m:ttabi@nvidia.com,m:lyude@redhat.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:simona@ffwll.ch,m:dri-devel@lists.freedesktop.org,m:nouveau@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:stable@vger.kernel.org,m:zilin@seu.edu.cn,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dakr@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-267537-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,seu.edu.cn:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 62A516AAC9B

(Cc: Timur)

On Wed Jun 10, 2026 at 4:50 AM CEST, Dawei Feng wrote:
> If loading the HS bootloader blob fails, nvkm_falcon_fw_ctor_hs() returns
> immediately. This skips the common cleanup path and leaks the firmware
> state allocated by nvkm_falcon_fw_ctor() and nvkm_falcon_fw_sign().
>
> Fix this by routing the load failure to the 'done' label so
> nvkm_falcon_fw_dtor() can properly clean up the partially initialized
> state. Keep the original image firmware in 'blob' until the common
> cleanup path, and use a separate 'blob_bl' pointer for the bootloader
> firmware so it can be released immediately after the bootloader data has
> been copied.
>
> The bug was first flagged by an experimental analysis tool we are
> developing for kernel memory-management bugs while analyzing
> v6.13-rc1. The tool is still under development and is not yet publicly
> available. Manual inspection confirms that the bug is still present in
> v7.1-rc6.
>
> An x86_64 allyesconfig build showed no new warnings. As we do not have a
> supported NVIDIA GPU with the required firmware to test this path, no
> runtime testing was able to be performed.
>
> Fixes: 2541626cfb79 ("drm/nouveau/acr: use common falcon HS FW code for A=
CR FWs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>

Is Zilin a co-author of the patch?

> Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
> ---
> Changes in v2:
> - Use a separate bootloader firmware pointer instead of reusing 'blob'.
> - Keep the original image firmware release in the common cleanup path.

@Timur: Any further comments following up v1?

