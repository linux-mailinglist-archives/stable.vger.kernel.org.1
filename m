Return-Path: <stable+bounces-227339-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIxgFUAlvGkxtgIAu9opvQ
	(envelope-from <stable+bounces-227339-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 17:33:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E97FA2CEE38
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 17:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56D37317D2EA
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 16:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3CC3E9594;
	Thu, 19 Mar 2026 16:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hef07Mus"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639A538A729;
	Thu, 19 Mar 2026 16:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773937286; cv=none; b=czq7a6bvVRkgB1r7Y1ytCZt/uFI+TdIq66CFBROKst+4Ecq2Z9EfjsOtkRGR80DSJbwdjOUggnpI64S43bfdTwFmyl9TuShVvbZIiN8Q+DYpK+kzz4OnXo28Hii4dBws2IJV69wYr/hIzNbYcqqskSsMpHPo34kS7M6m5SxMecY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773937286; c=relaxed/simple;
	bh=SWuryUrLCruxqK7KPSnDrrfXYe0rzOzozifRFqJ4zdE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oGO3IhgP3wMjBZVk4E7OYbzbmFaX/TlzpyMcInsWOcmpViGr2dqfxkV+h8r9nhhCejQcCqdHFPBvvnZZ4ARQTfOu4kHneuFd/aVO7BrjkhYXti0nW0M1N33YVhuj67j6UYTkk5TWGPXEsi4L8BGagsxE6XD8UR8uXDaOysdDyGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hef07Mus; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D019C19424;
	Thu, 19 Mar 2026 16:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773937286;
	bh=SWuryUrLCruxqK7KPSnDrrfXYe0rzOzozifRFqJ4zdE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hef07MusVcnp2t8J564ll1u+wYC0m2OUObIg5bVNiRf0DMkXUITgxK/oFxN6BCiA1
	 KgL3T6+GrWN7m+5EdnN330/a/SUiUC0toYsQTDELmz8a+x+BFVVyOZ1wEU1L2Nx02y
	 OC89WGOTkdpT56I6GVHGalJrrrG9RzVPNuPEwWUCI5mE0LaTCAXMA3wFg3CFUg4qpI
	 nsYY82XrC4O+8O/nIzZmXsLQF85C7HkdNDSDrE1EyX5fSW2JiQsbQGz3ReUvx4AZt7
	 1XGKMnUIz98LHRjJQ2oe3WxafNmRsX9xEjxbl9ig7li33yzfu1aNhwdiM1DJnnbN8j
	 MUDhGgNciC/Rg==
From: Lee Jones <lee@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
 Tobias Schrammm <t.schramm@manjaro.org>, Sebastian Reichel <sre@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, driver-core@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, chrome-platform@lists.linux.dev, 
 stable@vger.kernel.org
In-Reply-To: <20260305-workqueue-devm-v2-0-66a38741c652@oss.qualcomm.com>
References: <20260305-workqueue-devm-v2-0-66a38741c652@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v2 00/10] workqueue / drivers: Add
 device-managed allocate workqueue
Message-Id: <177393728021.2870619.1816530869958472742.b4-ty@kernel.org>
Date: Thu, 19 Mar 2026 16:21:20 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-52d38
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227339-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,lwn.net,gmail.com,manjaro.org,linux.intel.com,linaro.org,collabora.com,chromium.org,oss.qualcomm.com];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,lists.linux.dev,vger.kernel.org,collabora.com,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lee@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E97FA2CEE38
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 05 Mar 2026 22:45:39 +0100, Krzysztof Kozlowski wrote:
> Merging / Dependency
> ====================
> All further patches depend on the first one, thus this probably should
> go via one tree, e.g. power supply.  The first patch might be needed for
> other trees as well, e.g. if more drivers are discovered, so the best if
> it is on dedicated branch in case it has to be shared.
> 
> [...]

Applied, thanks!

[07/10] mfd: ezx-pcap: Drop memory allocation error message
        commit: 33e0316783a205625b7c55a78041ddc0d5dce7c7
[08/10] mfd: ezx-pcap: Return directly instead of empty gotos
        commit: 444e11d9d9e56c994da8a253cdf7f33ac2eeb15b
[09/10] mfd: ezx-pcap: Avoid rescheduling after destroying workqueue
        commit: 356ee03f6ae7d04f90d8e2104660193c4f3a071c

--
Lee Jones [李琼斯]


