Return-Path: <stable+bounces-242110-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDnCHZ5a82lfzwEAu9opvQ
	(envelope-from <stable+bounces-242110-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 15:35:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8FC4A386E
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 15:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 347203009B1A
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 13:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F754266B3;
	Thu, 30 Apr 2026 13:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRPygyba"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2EC3BA25C;
	Thu, 30 Apr 2026 13:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777556115; cv=none; b=Adr94sCTt2xmZ7KilTJteidEkfHAWv3TFteI98wflT5BS1Cx08ThC+eloq7baUblO8irZT4a9XK1wE02YP9JXOkyjqvoHN6u2mozt4uQQDb31hE9/bwZK+AGLD78scj4AQIB1TGA263Qtyy7xuXek8dlG3p1v2/FBm0JvaCMFkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777556115; c=relaxed/simple;
	bh=2EQxsIUqtXGo3JVpBUdlMzZL+gQi0+EkN8r9+hEvm/s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=d72LfDS10xqAXxj54A5GzygwddTjnSxL8gHtueJ5B5ryvtBDoZeji+SVB0+thok0RL941iaUkOtAwzwLwkBTAo8qi+5Z2TtaSfmn7DhBHsuZKrUPHKbFCkiLNtRd7AYftUyDC3DaEI5ceZom5zh8YLP2ycQ+GVKcsOxGfLCM4Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRPygyba; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D49AC2BCB3;
	Thu, 30 Apr 2026 13:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777556115;
	bh=2EQxsIUqtXGo3JVpBUdlMzZL+gQi0+EkN8r9+hEvm/s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MRPygyba4u+C+/DVn2ifvMHMM+Hr7XLKMg5B7N4RhDaIinR3PstEO8SyQNvKSdWaK
	 WtweTqZElnYq7RzJqMVcz2YDf5fAvkPx6qq/cmY/8eZeb8Vndq860AnLQA/pmSogKD
	 lIYHgIEsU9hPchFQz6j1UIE4aRAdGjimf7g4eb6Tu7K8G0RMIJo/Y6TPuBcQ160WZB
	 KFDmIJX0Ldjb3UuGWd+8CnU8P3CE8FPVguXpUJmoVgBvo4nrnd/LLKgIM5AlZIQJhQ
	 RA1vA1mLo9QbRKJH48Ydm+6Zzb66+7xi0AgDiWhCtm7XnUipLUkKkgjI87/HyLLT5h
	 XzwbSx200Xigw==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <dujemihanovic32@gmail.com>
Cc: Karel Balej <balejk@matfyz.cz>, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, phone-devel@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 stable@vger.kernel.org
In-Reply-To: <20260328-ktd2801-pm-fix-v1-1-007cb103faeb@dujemihanovic.xyz>
References: <20260328-ktd2801-pm-fix-v1-1-007cb103faeb@dujemihanovic.xyz>
Subject: Re: (subset) [PATCH] backlight: ktd2801: enable
 BL_CORE_SUSPENDRESUME
Message-Id: <177755611273.2593921.12572770318849795486.b4-ty@b4>
Date: Thu, 30 Apr 2026 14:35:12 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c
X-Rspamd-Queue-Id: 1E8FC4A386E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,gmx.de];
	TAGGED_FROM(0.00)[bounces-242110-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lee@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RBL_SEM_IPV6_FAIL(0.00)[2600:3c04:e001:36c::12fc:5321:query timed out];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Sat, 28 Mar 2026 21:42:16 +0100, Duje Mihanović wrote:
> Boards using this backlight chip do not power the backlight off on
> suspend. Enable BL_CORE_SUSPENDRESUME so the chip gets powered off by
> the backlight core on suspend.
> 
> Tested on samsung,coreprimevelte.
> 
> 
> [...]

Applied, thanks!

[1/1] backlight: ktd2801: enable BL_CORE_SUSPENDRESUME
      commit: f37f5a2ac9d3737617c08f0dc7270b42e9cad907

--
Lee Jones [李琼斯]


