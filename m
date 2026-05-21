Return-Path: <stable+bounces-253605-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAqWM3ZAD2qcIQYAu9opvQ
	(envelope-from <stable+bounces-253605-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 19:27:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D63005AA370
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 19:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 507B232FA05D
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38F0369D6E;
	Thu, 21 May 2026 15:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5ZnQc/k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BEE3672A8;
	Thu, 21 May 2026 15:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779377412; cv=none; b=qmad2KL1HATTx36dISEBqDcqCk+BwpkOjzqT2vzUHQkhMTc12mAH5w2569hM0qu040PAa/l4RGPbHTedkolDxu5NrCFKO3mLEYJ0ORtf+L5+jANl45AWOJmBDBgrLYm1H5O3c2juRr2mc2qPZfQG6dQUtSk9wpuFMY6FE/FUFO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779377412; c=relaxed/simple;
	bh=nP6uPdGzAyIs1HTgZD5Uv5gqKFMJLVKGf/yYhgqs71s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jFnpKeLbyCWo4oz/7viY0FRQq6iqgByqewgYK16z0+4Njlr9W6VyHIXnmkhsUtyZXbnpBPpcaTbScQ1RJWz6G0MKN/pPVbkXjXARTh/U3N98gLXYpVnCb3nX7f764EE5NZg+xlbZsu+/0z7Aqwpk3MXwiSKgV4yNHTDM7N4KZQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5ZnQc/k; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805E41F00A3F;
	Thu, 21 May 2026 15:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779377411;
	bh=FYXxI9wJhlDvN3eBIGaisS2WI6+d0wM5e1BI9Uz9fTg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=H5ZnQc/kYf4l/v2at+B9Tp9vQ7sRr20h2Syk+9krpRIw2+joRUSahzKGVTKgmMgnm
	 IcorOz6C7L7ovbMh6IHrPvi13eRdQQnfAJNpg6rXdUySxNjpD5TQH+G9fd1c8JSSq4
	 Ou4X3D1jWIHKYBa/7Aj8U3ttPbBgfA59R0+hIceXq9coFlKL8nzfjh6NRZXsjTiewA
	 Vfv6eXtmiCRnJELVuYpIy0jpZBSzCB+urLRHBW4e9jkPso4TrbAVcH+QLoRPAxcOcn
	 UlHEgZXcDu0bZc5bL/BVkiWnib245uO5ljtMCqPeFBG2foTuBqQ5FOQY2l4FPPqMNu
	 qjc41fRuqq4VA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93ACB3930E02;
	Thu, 21 May 2026 15:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: HIDP: fix missing length checks in
 hidp_input_report()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177937742113.384060.11759025481013709702.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 15:30:21 +0000
References: <20260520225643.35683-1-meatuni001@gmail.com>
In-Reply-To: <20260520225643.35683-1-meatuni001@gmail.com>
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 marcel@holtmann.org, luiz.dentz@gmail.com, johan.hedberg@gmail.com,
 stable@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,holtmann.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-253605-lists,stable=lfdr.de,bluetooth];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D63005AA370
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 20 May 2026 18:56:43 -0400 you wrote:
> hidp_input_report() reads keyboard and mouse payload data from an skb
> without first verifying that skb->len contains enough data.
> 
> hidp_recv_intr_frame() pulls the 1-byte HIDP header before dispatching
> to hidp_input_report(). If a paired device sends a truncated packet,
> the handler reads beyond the valid skb data, resulting in an
> out-of-bounds read of skb data. The OOB bytes may be interpreted as
> phantom key presses or spurious mouse movement.
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: HIDP: fix missing length checks in hidp_input_report()
    https://git.kernel.org/bluetooth/bluetooth-next/c/6522ecbcd122

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



