Return-Path: <stable+bounces-214494-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GG0wIhG7hGnG4wMAu9opvQ
	(envelope-from <stable+bounces-214494-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 16:45:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3D6F4B8C
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 16:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44429300DDCC
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 15:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9EE423A90;
	Thu,  5 Feb 2026 15:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhqNppQX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7235E3ACA79;
	Thu,  5 Feb 2026 15:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770306317; cv=none; b=OaA0QMRGTQkKe7Kz9Ihfn/fmOkx5Qq9yoflIZ46UXq7ixiHokCS/cUKNvUJ/p5eID+s1u4Af9/vV0oKDcsygulFo6JVzvOKLtjc5xVpPzoiv0AS3pqH77kGOfjgAj/uH80vGGFx1oKytr0ItdXiOmJwpMBJnOmlveA+WJCLPuhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770306317; c=relaxed/simple;
	bh=uobxKLkuOBwbIbLzb95tMe/LEUsUFlMKgIPYxgjyKqI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dZFYC/YsvanzD+ipmDTIt86lCpCsTuID4CjogE33MIeiUawPSmvY54X9HsQLEWIqMgF3lr89N2ZfPzUuo13XyqzyllLnEFRSzuy7KER6+obLIzZrMYfYJyK8mMc7lbWgdauPviLgMIe9QETHrbKbL9Ui19TRXjMJOsFL+G7EeKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhqNppQX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2C1C4CEF7;
	Thu,  5 Feb 2026 15:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770306317;
	bh=uobxKLkuOBwbIbLzb95tMe/LEUsUFlMKgIPYxgjyKqI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jhqNppQXR+VqnQdPergHzWaTiushtgo/NJtJmt0gVmqZ2XX0RKIxeB3RyzX8A+mZV
	 UOvaQOkV4uQ5KlfQ8yZBcTio9GPW9xdKJa0H98YDsCachgFrf30lMG8RvNMcwupZxx
	 SOSi5IFUixSioWe3+bLVubZdoZ7mtu5tjaZTkAvH8O7Tt+0yp/kNVkfOxp78YkMi9H
	 Tf2o8qfDnu/zXbK1GSG66+AwhaaPTcjIgXhmTBv4KMfnqh4mdLgMNZzrrfPNpSnsqe
	 xbAzN2tCg4tGz380UIzKL5YQLNgaJs6TLPlkOq3BZZt3YkOHExQN/s/aXXARriDeA4
	 lBmNQpefZAiQg==
From: Lee Jones <lee@kernel.org>
To: linux-kernel@vger.kernel.org, Marek Vasut <marex@nabladev.com>
Cc: stable@vger.kernel.org, Lee Jones <lee@kernel.org>, 
 Pascal PAILLET-LME <p.paillet@st.com>, Paul Cercueil <paul@crapouillou.net>, 
 Sean Nyekjaer <sean@geanix.com>, kernel@dh-electronics.com
In-Reply-To: <20260122111423.62591-1-marex@nabladev.com>
References: <20260122111423.62591-1-marex@nabladev.com>
Subject: Re: (subset) [PATCH v3] mfd: stpmic1: Attempt system shutdown
 twice in case PMIC is confused
Message-Id: <177030631510.1671534.13234805087946567100.b4-ty@kernel.org>
Date: Thu, 05 Feb 2026 15:45:15 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-52d38
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214494-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lee@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DF3D6F4B8C
X-Rspamd-Action: no action

On Thu, 22 Jan 2026 12:13:21 +0100, Marek Vasut wrote:
> Attempt to shut down again, in case the first attempt failed.
> The STPMIC1 might get confused and the first regmap_update_bits()
> returns with -ETIMEDOUT / -110 . If that or similar transient
> failure occurs, try to shut down again. If the second attempt
> fails, there is some bigger problem, report it to user.
> 
> 
> [...]

Applied, thanks!

[1/1] mfd: stpmic1: Attempt system shutdown twice in case PMIC is confused
      commit: ff05fecc5007a1680e2e828e708586ae5ffb30a5

--
Lee Jones [李琼斯]


