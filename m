Return-Path: <stable+bounces-225476-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QD+BNkLMtmlyIwEAu9opvQ
	(envelope-from <stable+bounces-225476-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 16:12:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A91C29126A
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 16:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0FBC43012CC3
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 15:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564DF369219;
	Sun, 15 Mar 2026 15:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuC6Tv/Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AD5366541;
	Sun, 15 Mar 2026 15:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773587520; cv=none; b=g2tm3x7wprqc+x/Lyavz0PUQ3vyXyUfofk2AOxgDX4tZmsdnvwHU2hbOZphQCmatERNxbn2c7gfHpN7V+Hmz0KlfShwnVq3FaK7FyzDVd6Wkdo5RVrdLIrFzsTzaZoB2u9PX873lf9wwaYc5QexJwUQ/+irymh4eZtq1YKGzwN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773587520; c=relaxed/simple;
	bh=6jQp4ea3K3hRb3fhb0FEeSzMJUsm3BVSJ/Pao5wNtNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qf8lGGX6+LBOHja4palxvfdqSmAmhCOJ1ReT9muQ+nOJF/ct/hiBIAES+rozB61//7nPWosaoYxJUw9YaWoJTPFEnAkugfoZ0RIperxFAXQdxKCnF286+Ui6hEA7USC8pHW7ACFGe6h4wNZz6DPMJwxJHqV7RCOeoItMe9QkYGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuC6Tv/Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54BC0C4CEF7;
	Sun, 15 Mar 2026 15:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773587519;
	bh=6jQp4ea3K3hRb3fhb0FEeSzMJUsm3BVSJ/Pao5wNtNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TuC6Tv/YRav5hWMQVY1n8ds6PVQRaEXmkqV5HnkMb8QUdDkq8pmhJCsS1yCSlufRT
	 eIpjCx/DsXjz+/a+3iO4DTVBbCj7zLlfS6zFzTYlicEiggh0w+615rb7lN2IaIPGl/
	 J2C2UqI2urx+SSaflRQI8y+g7nPPEu3cbi516dR3e+afM7vuRZfRzK5AwP7O5LqdfK
	 RjbaITlZ6qeFaboki++hc9GIYW1fCOImjAc3u7y5oBTdqH7XL8VGvEMb80f/I8eIkV
	 zR9UlU2386mCiJEfdxA1auuauhuGuQ4iI1qAnEQChOglz6dY/6IXwBm01ksLjmYaQm
	 1Tsaq+ByWMYLg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1w1n8H-00000002AWr-0hpc;
	Sun, 15 Mar 2026 15:11:57 +0000
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Marc Zyngier <maz@kernel.org>
Cc: Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Oliver Upton <oupton@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Discard PC update state on vcpu reset
Date: Sun, 15 Mar 2026 15:11:53 +0000
Message-ID: <177358750718.974845.17608338527108220660.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260312140850.822968-1-maz@kernel.org>
References: <20260312140850.822968-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, maz@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com, oupton@kernel.org, yuzenghui@huawei.com, stable@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225476-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maz@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5A91C29126A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 12 Mar 2026 14:08:50 +0000, Marc Zyngier wrote:
> Our vcpu reset suffers from a particularly interesting flaw, as it
> does not correctly deal with state that will have an effect on the
> execution flow out of reset.
> 
> Take the following completely random example, never seen in the wild
> and that never resulted in a couple of sleepless nights: /s
> 
> [...]

Applied to fixes, thanks!

[1/1] KVM: arm64: Discard PC update state on vcpu reset
      commit: 1744a6ef48b9a48f017e3e1a0d05de0a6978396e

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.



