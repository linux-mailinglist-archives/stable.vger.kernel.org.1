Return-Path: <stable+bounces-243036-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NF3LOOk+GnQxQIAu9opvQ
	(envelope-from <stable+bounces-243036-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 15:53:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B144BE154
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 15:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8154330164B4
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 13:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33803DA7D7;
	Mon,  4 May 2026 13:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MZIc41sZ"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1313DE425
	for <stable@vger.kernel.org>; Mon,  4 May 2026 13:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777902770; cv=none; b=t4pRgJrsIE+4VrqSTGsKxR9fzsi9GVdVskF8MIgagmDPvRMPjTsjIA6HFvVD7a8O/CiEUtaa6MWA8Fi1S/RTuNq7kjkz4YcwknEf13TQIH/kFVbTCDUhfGUGr7A3oScnjF9kiQZpEuViZfjVFoSF+F6MviKHSTwqLb3gyAjxni4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777902770; c=relaxed/simple;
	bh=EnKBfyuObT8bqP9o5rdUDsYVc9jpV+QkAnEpaBnIASA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Dzbd0Dfo19lvm1bYwEH1QCd8fdagUpDvpNm2BfgFadcxcz0+0OkM0M78mbYJvSTELHPkIKr/shLxrHnSc5QCKVODvgIyOCA+8/2+vfonoDk9Z9fEU9rNKpL3i0706vPPy/a5+Q6bnFFtxfc51hS4euoUOiSe4Nu+auGCyn5bQN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MZIc41sZ; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 9063DC5D72E;
	Mon,  4 May 2026 13:53:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2F6135FD5F;
	Mon,  4 May 2026 13:52:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2EA3211AD20F1;
	Mon,  4 May 2026 15:52:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777902758; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=PMEhp+w9Nspq/lfo78XgrxWdY0LVag6tZoHKrUtgTdk=;
	b=MZIc41sZtRjrn7OAEgYMGmWUtTfF9aNBGixF0VDB/D9RGBwHknRA2NnPgZinjYdi7hpvU/
	O0+NzjYE8WD5P7uJu1qtpVVk3oZ65aLtsVQnfqG6ulrgx5CPV7oA3W3QkD2cPlTTf8U6/k
	SoG4OqCuFhFJ8vxMNoXWI8FhuKqEhe8uA+GGBodv5JGDEgdLDdPKYXtjM3jkEuIvtmXuqf
	GXkyZCfW8QRHXKZhBwipatBz0Npmwbf/f6BYM6c7QkgbtBsHrkEztP3MIgRQyVHggwGweW
	5+1Hi97C6V6tgXn2eqmt/yAcKVVUTYBW1MJqLO8wCA5uBGiJXSKPoqeKnVb7JA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Lee Jones <lee@kernel.org>, Valery Borovsky <vebohr@gmail.com>
Cc: Ben Dooks <ben@fluff.org.uk>, Vincent Sanders <vince@arm.linux.org.uk>, 
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260504124841.443496-1-vebohr@gmail.com>
References: <6b4a9f5ae8a316b6f07f72f2fe3f0b8fc5f18dff.1777889235.git.vebohr@gmail.com>
 <20260504124841.443496-1-vebohr@gmail.com>
Subject: Re: [PATCH v2] mfd: sm501: fix reference leak on failed device
 registration
Message-Id: <177790275684.156214.6563585281874262911.b4-ty@bootlin.com>
Date: Mon, 04 May 2026 15:52:36 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 09B144BE154
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243036-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miquel.raynal@bootlin.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:mid]

On Mon, 04 May 2026 15:48:41 +0300, Valery Borovsky wrote:
> When platform_device_register() fails in sm501_register_device(), the
> platform device allocated by sm501_create_subdev() has its struct device
> initialized by device_initialize() inside platform_device_register(). The
> error path logs the error but returns without dropping the device reference,
> leaking the memory allocated by sm501_create_subdev():
> 
>   sm501_register_device()
>     -> platform_device_register(pdev)
>        -> device_initialize(&pdev->dev)   /* kref = 1 */
>        -> platform_device_add(pdev)       /* fails */
>     <- dev_err() called, kref still 1, sm501_device_release never called
> 
> [...]

Applied to mtd/next, thanks!

[1/1] mfd: sm501: fix reference leak on failed device registration
      commit: faa9bba3fe2f37e7dcb26d4501d890fbfd7df160

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


