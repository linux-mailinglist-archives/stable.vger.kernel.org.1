Return-Path: <stable+bounces-211296-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LPKEY9tcmlpkwAAu9opvQ
	(envelope-from <stable+bounces-211296-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 19:33:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C19EA6C7FC
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 19:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4449300DF6F
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 18:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE262F5A10;
	Thu, 22 Jan 2026 18:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="j8ymQqVV"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7BF261B8F;
	Thu, 22 Jan 2026 18:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769106788; cv=none; b=h201AI457mJD0D3siFX2kkz9psjprFntOcZ5VXNbwKzSW7vQB5sNmjdG3GUnEKZca6GN5ynw05AwhRKpeWn/Lx814t9FI1DRjjqrWfKD5YwCnlaXSSjD1ljVm86WfFS0lTcO3xPLYm6C6wqasfeSFZCUG06qqwdvzF6+KHXBAzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769106788; c=relaxed/simple;
	bh=/90XOeP3NcPOPlYmskqmV9qhr4lByA9+2h3yFGpO/MA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A0Une1U/lvJFbgxeQJUPB40AfSKx1lKZmm9p6nIHlev4KZOdR591Y5MtifBrBrhLhOM1UtQJUU8Jz/BGr2o7UdgWWxrs9qU8Uu2MK4cjeLpvvm4FTI9eCDLjvvzmHGPgff+9sUkE9eOeAEXMhSugpvA+knHMhUbyMwQ+H3JlUTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=j8ymQqVV; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=nNcAXA78Lmf4S4GSMOlD97M4xfkehQtEkWEYKY3GGRU=; b=j8ymQqVVDP34hMaNDAd6lsm2gA
	hUkLdSsKEo08LQ7zwkhttJ1uQ1iCfORq3BIFl76ch9eVplwUCTEgGUfte1vxkQO6xtTLlYCsn/r6b
	yUSE0djpElYDsij7vJBq/8ULeC2Knf8cftaOv6HNLvlcRxYrXci+8ZoXvK4lTEB2A06mc6EwggcUm
	2C+zdsBr6U+9WtBGfBOGWWtNU2uEh2vP067j0umnicDmUnUCRuD9InXy+2/uMzm+iGW1wDP7Hy9z6
	C6Y1dQq53pdtcb+SoiNzNE0lasVPeftkQJtaPHMcBKXYJP8Av9KlIKUxFrUDlgS7lN5zgthei3n5Z
	t/yKgPXw==;
Received: from [192.76.154.238] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vizU1-003rA9-Ny; Thu, 22 Jan 2026 19:32:42 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Alexey Charkov <alchark@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] arm64: dts: rockchip: Explicitly request UFS reset pin on RK3576
Date: Thu, 22 Jan 2026 19:32:37 +0100
Message-ID: <176910675436.726233.5945062783721941669.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20260121-ufs-rst-v3-1-35839bcb4ca7@gmail.com>
References: <20260121-ufs-rst-v3-1-35839bcb4ca7@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sntech.de,none];
	R_DKIM_ALLOW(-0.20)[sntech.de:s=gloria202408];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211296-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,oracle.com,rock-chips.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heiko@sntech.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[sntech.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sntech.de:email,sntech.de:dkim,sntech.de:mid]
X-Rspamd-Queue-Id: C19EA6C7FC
X-Rspamd-Action: no action


On Wed, 21 Jan 2026 11:42:13 +0400, Alexey Charkov wrote:
> Rockchip RK3576 UFS controller uses a dedicated pin to reset the connected
> UFS device, which can operate either in a hardware controlled mode or as a
> GPIO pin.
> 
> Power-on default is GPIO mode, but the boot ROM reconfigures it to a
> hardware controlled mode if it uses UFS to load the next boot stage.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Explicitly request UFS reset pin on RK3576
      commit: 79a3286e61829fc43abdd6e3beb31b24930c7af6

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

