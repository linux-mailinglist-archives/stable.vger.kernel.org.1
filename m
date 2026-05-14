Return-Path: <stable+bounces-247211-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKAWHHzdBWokcgIAu9opvQ
	(envelope-from <stable+bounces-247211-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 16:34:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2D55432FA
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 16:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 21E79302FAC4
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 14:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943B63FA5DD;
	Thu, 14 May 2026 14:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQ26yPYj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566773E1CEB;
	Thu, 14 May 2026 14:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778768590; cv=none; b=BRXLDeVN7lkTQdk0juVo1C35nctMo08d9Jx19N+3+Ri4Tkp81O4ThEDphvL3gspSKHwBnet2B8jQeu8teq+YDFa4ovheHWshaiW1WWwf+xeG/4CsN2M0KMW0szAq8jj3dYcN8JNs+YCRPPDqb5E1eWsyX2ySnXKzD/qD13O0yZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778768590; c=relaxed/simple;
	bh=rzTJYXpvDBf9HEZuU4QMthbII4DkGinZBLZlBEqhnMA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=M643tvHGk+kKB6wohFBFcpMYoFvNIXI3Q47bSG53qPWVhDSZ3Ge8ZTjE4ZYqhoi3boUndxwSn0P0EBkPbjT6x1UjUIz/w96HVsqkbo8hJlqzOMlqAZMawkEOOgVzqlY7Vm8zIbLLx623HnFxWSE4fPFm6QKAB0kw7x3EzrK5OqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQ26yPYj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 278F1C2BCC7;
	Thu, 14 May 2026 14:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778768590;
	bh=rzTJYXpvDBf9HEZuU4QMthbII4DkGinZBLZlBEqhnMA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ZQ26yPYj6KCmThtalI/xn6XyEEjr8rFAwX/ZYFLY+5k+SlktgvicOjyOwGasvbIBW
	 ayWjqgpfXlMgh2Lzo3MzNvxp1CjCGTtAOHM/Hj1pkS3TdASFIKNwfTOZzu4RwwCxXN
	 /10hVdV5jOB59o4rtoEkftK/Zq2/u/GUJTZJi0y6/cvClBtqksF/M7ldqOumynYvIq
	 FVXmUoQvEEUNmqq8sMt0pILoUvHwgq/wtxOKbe6O93vz7/mE8w72yaKvcx2/+GWTad
	 rIPGDWwspnqftqRuoQ3E22VViFtR/HgPv9yO5vxNkVTMwunY54B0BlL+PyST2ZsjjO
	 MoVh8qvIOogIg==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Benson Leung <bleung@chromium.org>, 
 Andrei Kuchynski <akuchynski@chromium.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Guenter Roeck <groeck@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Logan Gunthorpe <logang@deltatee.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260427131721.1165078-1-akuchynski@chromium.org>
References: <20260427131721.1165078-1-akuchynski@chromium.org>
Subject: Re: (subset) [PATCH] mfd: cros_ec: Delay dev_set_drvdata() until
 probe success
Message-Id: <177876858789.2780693.17487530492427297246.b4-ty@b4>
Date: Thu, 14 May 2026 15:23:07 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c
X-Rspamd-Queue-Id: 6C2D55432FA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247211-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lee@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, 27 Apr 2026 13:17:21 +0000, Andrei Kuchynski wrote:
> If ec_device_probe() fails, cros_ec_class_release releases memory for the
> cros_ec_dev structure. However, because the drvdata was already set,
> sub-drivers like cros_ec_typec can still retrieve the stale pointer via the
> platform device. This leads to a use-after-free when cros_ec_typec attempts
> to access &typec->ec->ec->dev on a device that has already been released.
> Move dev_set_drvdata() to ensure that the pointer is only made available
> once all initialization steps have succeeded.
> 
> [...]

Applied, thanks!

[1/1] mfd: cros_ec: Delay dev_set_drvdata() until probe success
      commit: 3c3a92cf6f3305505c6a98569f784ecdae8a909a

--
Lee Jones [李琼斯]


