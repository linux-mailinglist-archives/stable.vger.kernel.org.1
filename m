Return-Path: <stable+bounces-217682-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULmVH8SFm2mj1AMAu9opvQ
	(envelope-from <stable+bounces-217682-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 23:40:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3F11709E4
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 23:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3ACA30252A6
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 22:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AFB35CBA6;
	Sun, 22 Feb 2026 22:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="bpXAbppB"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFEA1A2545;
	Sun, 22 Feb 2026 22:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771799975; cv=none; b=oDlkN8iAW+9rishu+W6fk+rZFfbE8aekRWbwukLPtfikvYV02zayEhnsOLBDvosGYY1axmfctUM/XvhZ25kxz5ds0OXv5ZFSbV9WT0x5kg82x7PgDiM9O127jl2dM1si+bqE7U+drzd7ac7GHhiK7Hu5jhy15qf4q+fsTu9Yhtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771799975; c=relaxed/simple;
	bh=WcUUM6kV0TXh4zq2YJUOE2Tn4YPX1xytEvH1pxZttzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c54lUdk78eWxdrIFymGdoEwTlIS2Qd66XXBJhf/EZ6THXfC9z2NoXAmMJ5JH6cg1pF7XM2SWYZGMRnw9o3KExPxPgbvldxDr3z7YZjDOZyLVZ8YehcK0qMJjytqqg+SSUla/gcsDRkdEi8+NCo6nATN1X69d/hkx52HDzhC5guQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=bpXAbppB; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=xCbFUq1gz5ivzs3NGEktR0CddjRjW7flgd1V8byi/98=; b=bpXAbppBRntuOXTB91zOXoUrzU
	FcBQNixaiLIAJ+hynP0b2tfS0bPDIZ0RhEVtui818OlSsTXA0Tb2QIWpSbMlyOh85Is+GSTRJ7BI3
	rQu6Tco63lQMXAav3HivByrywzSxx0BsyRUMhc8ai64yxr9KlqBYWTguc0NvZphhUF/6YAPaldUZH
	I+XfISQyU8LrnuBHNp/023T1Iwp2dHQ690ek76WlFgvVNSpR7BlB73Emedc9sLEOmFZqMb0miTCyd
	iM5UyVbMjJOsuZt/6+LPbYz3ucb6Tn/YlRDKOZCFXaBinzHlCjDhb9cYsvf9bhxGLyGnpHGTQt8RD
	dBTxt1wg==;
From: Heiko Stuebner <heiko@sntech.de>
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jan Palus <jpalus@fastmail.com>,
	Peter Robinson <pbrobinson@gmail.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	stable@vger.kernel.org
Subject: Re: [PATCH] Revert "arm64: dts: rockchip: Further describe the WiFi for the Pinebook Pro"
Date: Sun, 22 Feb 2026 23:39:04 +0100
Message-ID: <177179992296.1861430.12010317621406351425.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20260210120142.698512-1-heiko@sntech.de>
References: <20260210120142.698512-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sntech.de,quarantine];
	R_DKIM_ALLOW(-0.20)[sntech.de:s=gloria202408];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,fastmail.com,gmail.com,leemhuis.info];
	TAGGED_FROM(0.00)[bounces-217682-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[sntech.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heiko@sntech.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sntech.de:mid,sntech.de:dkim,sntech.de:email]
X-Rspamd-Queue-Id: ED3F11709E4
X-Rspamd-Action: no action


On Tue, 10 Feb 2026 13:01:42 +0100, Heiko Stuebner wrote:
> This reverts commit 6d54d935062e2d4a7d3f779ceb9eeff108d0535d.
> 
> It seems there are different variants of the Wifi chipset in use on the
> Pinebook Pro. And according to the reported regression - see Closes
> below, the reverted change causes issues with one Wifi chipset.
> 
> The original commit message indicates a "further description" only and
> does not indicate this would fix an actual problem, so a revert should
> not cause further problems.
> 
> [...]

Applied, thanks!

[1/1] Revert "arm64: dts: rockchip: Further describe the WiFi for the Pinebook Pro"
      commit: 29d1f56c4f3001b7f547123e0a307c009ac717f8

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

