Return-Path: <stable+bounces-238868-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFpkIs805mmOtQEAu9opvQ
	(envelope-from <stable+bounces-238868-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:14:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1926842CCAF
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1749E31F758E
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 13:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0CF3AA1BB;
	Mon, 20 Apr 2026 13:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0Hwmycs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310CF3AA1B6
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 13:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691282; cv=none; b=V8c/EcP4XPxDLZIXB0lgB34I3oUhdPlzyqEwO+hPJAVCuXfKYJkPSpRdowRolwmbKO44of53PER7phfaWCp9ZSi4pm/vu+DCIWgSAn3MgrO6IwC9PLN2DliwvY/Kncq6bsLwQGwuEmLAlxkFp/ZfUnz4BmYnYt4/YRAcVYGxrKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691282; c=relaxed/simple;
	bh=fHiAqfG6BLI6sL2Pft1JhS0A8dnJa9d+5OvZKcRFlmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HqeOsPAPmXe39qIxiV9vUaAP81YSpUpc9xDoiO2kr2LAI6Akib6kk01f0ZzB8EC5tDh3UXl0ygCQy+SLPykm3a2dM7+7ATMGkJ1cxAAjUmEE4EPp9TIp9YCuyn2+vSDD0Xic4WM+LEQ61ahX/HQ2zbM6RilSOrFWmNgS/fhDDfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0Hwmycs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A38C19425;
	Mon, 20 Apr 2026 13:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691282;
	bh=fHiAqfG6BLI6sL2Pft1JhS0A8dnJa9d+5OvZKcRFlmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e0HwmycsjbRiU8EuD4BWKxFK11kr8AFRy2g7hkrwtCL9i176yWvfZmWutwFS0JrB7
	 Jn6kcDXDJUQqf1R/pA0uRY0RqRh3OTdkkxeAx5/Ee6xpTKomVnJvRGhjLZBS+AdSDp
	 DWAw+1mWBT+USliMfEPMlZOo/ZHdZdZQ04wK8SOYH9WLNpbgoQ+Y4PCfyxkNc3Hd0l
	 bZ60tRfQQ79QZvBOXdSl6w0XJq2ZLFK81OXa3rtwt8OTGTQdd30PpTPCPi+h8Xensz
	 QJpO4e4NyG8PHN23EgxAkF4AKUbpm/8nM7A7mr0YhgwJfnH4QxDRRHvKxKvqJ/9i+N
	 E7GouStDi2Wiw==
From: Sasha Levin <sashal@kernel.org>
To: Wenshan Lan <jetlan9@163.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	alsa-devel@alsa-project.org,
	Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 6.1.y] ALSA: usb-audio: fix race condition to UAF in snd_usbmidi_free
Date: Mon, 20 Apr 2026 09:21:02 -0400
Message-ID: <20260420-stable-reply-alsa-usb-audio-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417084516.464-1-jetlan9@163.com>
References: <20260417084516.464-1-jetlan9@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238868-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[163.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1926842CCAF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026, Wenshan Lan wrote:
> Backport of 9f2c0ac1423d ("ALSA: usb-audio: fix race condition to UAF
> in snd_usbmidi_free") to 6.1.y.

Queued for 6.1, thanks.

--
Thanks,
Sasha

