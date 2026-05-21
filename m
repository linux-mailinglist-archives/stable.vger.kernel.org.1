Return-Path: <stable+bounces-253590-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNAnLdQfD2pSGAYAu9opvQ
	(envelope-from <stable+bounces-253590-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 17:08:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C2E5A7EF0
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 17:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 295993292C00
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 14:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFD333F588;
	Thu, 21 May 2026 14:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHdyXCvv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EE133ADA9;
	Thu, 21 May 2026 14:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779375159; cv=none; b=SUMjTrhUr4VvgndpSqf/Zgq8I2FjGSHPK6wAMl/cMqA49hb1x1Vl7WD8BMGNKUmcWLqPzk4YWbQAU5DNHeEc8w7pNuyzOONn0wEmU7UjYo697Rr946RTUzf0O0jxTtpdrw0Hrv/oZdAV/+024r5So1CcbbPCJV/dOt6IchSYRCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779375159; c=relaxed/simple;
	bh=midTYK8CfgG45v/3aUnt8+jaEyfMdWSwJzzXCxSHHu8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mbPTaKk0YVCeU+8Q74a12MYBgbDft83lcIuVU8zKlTCe5kONrCzTrI9IjAS6U6O59grcqyayiiGlnWuzrE0tuWqQVNWDVzZgauBw5Unmcets/pcZKWptyz7KC+X2QuP+9sC8kmiHbmBT0yHGeeVMKxbqxRckt7PsGLjiipex3aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHdyXCvv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B201F000E9;
	Thu, 21 May 2026 14:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779375157;
	bh=fQIdzDmjLfSq3/uBdYOeA08Duu31vAR3BAP2lscTdXQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=iHdyXCvvxWVLGG8EYbcVRnGJ3Tya/b7caQf8YMCI9Fsbn7P8vwoU3pGUy9yn/xnUH
	 Rgdj3nHSo7x2T231MhWK+2jQiIbT9GaNPFDNeLkA8FgwUNIqat128laeh0Kqz53hh9
	 pnSqhOf8TFPHvGG5oa35o6g6PudBAEzkTGKRCrO/dkGZ5KI6+FPB68oZV5IVkPPxBn
	 lJQvb/BsvwKu9zRKaYpwacFQa0c4DclSEmBd+IY/BQn6kPrKdl7d2Tgkm+WVgGAx5l
	 QvBF/gKy5oKpow15lz/K6BFlE7tG/IG+pPKHIaEuoQFlgRYQv2fxCa2WQ2hirHeVZ+
	 FV66Oc8uHK5fA==
From: Benjamin Tissoires <bentiss@kernel.org>
To: jikos@kernel.org, hlleng <a909204013@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260512015737.8919-1-a909204013@gmail.com>
References: <20260512015737.8919-1-a909204013@gmail.com>
Subject: Re: [PATCH] HID: quirks: Add ALWAYS_POLL quirk for SIGMACHIP USB
 mouse
Message-Id: <177937515667.1110574.14478192130328665115.b4-ty@b4>
Date: Thu, 21 May 2026 16:52:36 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-253590-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bentiss@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 62C2E5A7EF0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 12 May 2026 09:57:37 +0800, hlleng wrote:
> The SIGMACHIP USB mouse with VID/PID 1c4f:0034 can disconnect and
> re-enumerate repeatedly after it has been enumerated if its interrupt
> endpoint is not continuously polled.
> 
> This was observed with the device reporting itself as "SIGMACHIP Usb
> Mouse". Keeping the input event device open avoids the disconnects.
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-7.1/upstream-fixes), thanks!

[1/1] HID: quirks: Add ALWAYS_POLL quirk for SIGMACHIP USB mouse
      https://git.kernel.org/hid/hid/c/07466fc91c55

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>


