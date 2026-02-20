Return-Path: <stable+bounces-217578-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FAVHMRlmGmJHgMAu9opvQ
	(envelope-from <stable+bounces-217578-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 14:46:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C0495168040
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 14:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE8F230ECE8B
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 13:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3216348865;
	Fri, 20 Feb 2026 13:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bgRastPA"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08351347FD3
	for <stable@vger.kernel.org>; Fri, 20 Feb 2026 13:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771595007; cv=none; b=LM5x+7jE0c7nw0BcwVpqayhNvr1ElCTB4ntEeDlbD5Gch1r+JpDkdNrPvZJTMrNyLjv1sMxgQNNoqStHcJc99s2bOnDopuyhb64973thjleWzxywrYjzuiGY6GtppeV0RAeknaEJKTfZT8E2hMGGwml0euMxpscG4+Vpr8wrKF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771595007; c=relaxed/simple;
	bh=8PHKNDDYkpPLT2AcX1kZ8sOQUJ7L+sYJLMMawkbhe3k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i4+hTIMM52tQyb3qSPHNrNfyO1EscKwbkWpk1ebPquqbsIdZ/Gi4N3iWKbxJCtekOAGMF1NEPr24BxKJsk79m/tNWtwsqZe2gpV8LL9Q/QkCHW95D1ZYDEQAnQvKsz7dJ5R6CZ/FI54TYNtOK0yzB2OvO9pTtaA68jqD1a3yEkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bgRastPA; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5A6E14E4088C
	for <stable@vger.kernel.org>; Fri, 20 Feb 2026 13:43:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1F0115FA8F;
	Fri, 20 Feb 2026 13:43:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BE11C10368CAB;
	Fri, 20 Feb 2026 14:43:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771595003; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=8PHKNDDYkpPLT2AcX1kZ8sOQUJ7L+sYJLMMawkbhe3k=;
	b=bgRastPAxZ3zRJDC/G92pIGVWfng7ovHiOr0NlFmtw1inUQ3L4Z3Oj2MYVmSvsnpOnzk6Y
	NFsST5k0/zABkvnpjjkojTRh34xF8N0aHHWvVLE9YFsZglKOULCSf/qS/2sHDEm4ZAyHc/
	y0OrDfjqkjHeE877fFnhwjbMTFgJnbg253kwUahTjooZVRRn8RMjU9KbWBkZzlbRD9sS9A
	SFVoMqNyEWxuk5FdKfFkwPUwLjwaCKHyb2GNIz3R0+SjzIH4NaxO741jnsa8q1jt6nh/OP
	vf3WfBOaQFZWVmXiJlQ0B9X7fIxpv46r657vSgk8HhmW/E/TfCcF2mvxt1SKtw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  linux-usb@vger.kernel.org,  linux-kernel@vger.kernel.org,
  stable@vger.kernel.org
Subject: Re: [PATCH] usb: core: don't power off roothub PHYs if
 phy_set_mode() fails
In-Reply-To: <20260218-usb-phy-poweroff-fix-v1-1-66e6831e860e@gmail.com>
	(Gabor Juhos's message of "Wed, 18 Feb 2026 21:21:07 +0100")
References: <20260218-usb-phy-poweroff-fix-v1-1-66e6831e860e@gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Fri, 20 Feb 2026 14:43:22 +0100
Message-ID: <87bjhjsf7p.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217578-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miquel.raynal@bootlin.com,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[bootlin.com:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:mid,bootlin.com:dkim,bootlin.com:email]
X-Rspamd-Queue-Id: C0495168040
X-Rspamd-Action: no action

On 18/02/2026 at 21:21:07 +01, Gabor Juhos <j4g8y7@gmail.com> wrote:

> Remove the error path from the usb_phy_roothub_set_mode() function.
> The code is clearly wrong, because phy_set_mode() calls can't be
> balanced with phy_power_off() calls.
>
> Additionally, the usb_phy_roothub_set_mode() function is called only
> from usb_add_hcd() before it powers on the PHYs, so powering off those
> makes no sense anyway.
>
> Presumably, the code is copy-pasted from the phy_power_on() function
> without adjusting the error handling.
>
> Cc: stable@vger.kernel.org # v5.1+
> Fixes: b97a31348379 ("usb: core: comply to PHY framework")
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

