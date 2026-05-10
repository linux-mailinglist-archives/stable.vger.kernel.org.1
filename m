Return-Path: <stable+bounces-245012-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eExOGj15AGpZJQEAu9opvQ
	(envelope-from <stable+bounces-245012-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 14:25:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB5F503E1A
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 14:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12A0A30293D0
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 12:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496F23815CB;
	Sun, 10 May 2026 12:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AD0b9e+e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF9E372B50;
	Sun, 10 May 2026 12:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778415834; cv=none; b=kezu1hHFANwCfJr/Cyd5RhwkXhpm96GpsAR88NcLuzMn5HiOFM5J+Ytu51K9QF/ct/L2Bk1CYcjfk42c+bemvAYDaCnJjWh8dN2WdbsoDLV6nr4M+sWGGDikBJCgJjHBl/2JrIW6Yn+NK0BxYFes6Jr/PCxKVXvcPB/FAQLtgcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778415834; c=relaxed/simple;
	bh=TC873zStqJ259MiwNikRrru9L89mhebxpZ8MWRYnZmM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=d0BYj7uP839Eh3Dv3TruYkS+YNkoDVYB3rhaNgDR6dAlRkwJe6+MOiKTiWZVXAy+v0UPBcGZQwbXog4wx54iUGsBn9xDnEaQxe0wFtLhA0IyfQIMkhnsdA3JUUBPL9aTaZNsWwSnI239qSLWz9XNOCJgLCiG9fOLBDH7iSZ9X4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AD0b9e+e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD44C2BCF7;
	Sun, 10 May 2026 12:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778415833;
	bh=TC873zStqJ259MiwNikRrru9L89mhebxpZ8MWRYnZmM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=AD0b9e+ezrryuNWZ8BZEaU0+rFHiKV5efAYKwxEINwCllXX7j2Fv9630NzBqPHRD0
	 UaDnpvaG4g8DuuO0A5YWgdFWl7E0YwH91ujb1+3YGGEcz4aqGaqmnjxz5cSM14/mb3
	 0UqhiYJxb8Q8DojeQueJupwWhq64tCHK/Txgh1lnA2k6PguhvDW+5nX9TlAmtVZmK4
	 myJceoTdZAiZpIIFR906BUQhqQ8qseQlxUGZs6QUXSOZ9NtGvcPbXlNakbgAqX1BZO
	 YEbx7zcLhAqC95s5fzmqKUOybvOnKcApvB2olYBFwcwKa3T+csPiOng5phrWmGUIos
	 gxDw2DwSFWZ/g==
From: Vinod Koul <vkoul@kernel.org>
To: =?utf-8?q?=C5=81ukasz_Lebiedzi=C5=84ski?= <kernel@lvkasz.us>
Cc: neil.armstrong@linaro.org, krzk@kernel.org, alim.akhtar@samsung.com, 
 andre.draszik@linaro.org, pritam.sutar@samsung.com, kauschluss@disroot.org, 
 johan@kernel.org, ivo.ivanov.ivanov1@gmail.com, 
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260406135627.234835-1-kernel@lvkasz.us>
References: <20260406135627.234835-1-kernel@lvkasz.us>
Subject: Re: [PATCH v2] phy: exynos5-usbdrd: fix USB 2.0 HS PHY tuning
 values for Exynos7870
Message-Id: <177841582887.420676.2529810300062190966.b4-ty@kernel.org>
Date: Sun, 10 May 2026 17:53:48 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0
X-Rspamd-Queue-Id: BBB5F503E1A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245012-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,kernel.org,samsung.com,disroot.org,gmail.com,lists.infradead.org,vger.kernel.org,oss.qualcomm.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action


On Mon, 06 Apr 2026 15:56:27 +0200, Łukasz Lebiedziński wrote:
> The existing PHYPARAM0 tuning values for Exynos7870 are incorrect,
> causing the USB 2.0 PHY to fail high-speed negotiation and fall back
> to full-speed (12Mbps) operation.
> 
> Fix TXVREFTUNE (transmitter voltage reference) from 14 to 3,
> TXRESTUNE (transmitter impedance) from 3 to 2, and SQRXTUNE
> (squelch threshold) from 6 to 5. Also explicitly set
> TXPREEMPPULSETUNE to 0, which was previously missing from the
> tuning table despite being included in the register mask.
> 
> [...]

Applied, thanks!

[1/1] phy: exynos5-usbdrd: fix USB 2.0 HS PHY tuning values for Exynos7870
      commit: 5a759b120e31aa3ed914d98b51eb1755235250f2

Best regards,
-- 
~Vinod



