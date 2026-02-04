Return-Path: <stable+bounces-213705-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMXpFeJhg2nAmAMAu9opvQ
	(envelope-from <stable+bounces-213705-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:12:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6385FE81BA
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A56BB30228C6
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0018329AB1D;
	Wed,  4 Feb 2026 15:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eY5QASmw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69E128853E;
	Wed,  4 Feb 2026 15:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217230; cv=none; b=WDpXknQPDbbscsAbB+/CZ752YURNBGlzN4w0NcbUSE+W+FODxYlExQF8mgKMZWVFhXy8PO5n/iYqISrR9Uq+skznYSmfr6fjOsKg9R5suYobRICX1T+jYOKAj9BILNuY7OBPmiSKOf5CvIlZEhFwALzkByB6F1LTK/AWqxOgUYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217230; c=relaxed/simple;
	bh=rcXmHJA9u19eNgMXqf90H2uEvWAYxJKmerMYempm2tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TYXqEaWayRaswnh7oUE4ItVKb2J52zRBidwCYpJGI46VP7TYfslydtk8I1892gashSkputvNe0yWW4XpZ77IZ9cmGOitmNT8EyivVajGTJ67MCdkvMBYp45e4yJMibpMhRZj8jlsWgfvNLzuep+4g6iuemaAwPigDRAJ6QM853E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eY5QASmw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A68DC4CEF7;
	Wed,  4 Feb 2026 15:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770217230;
	bh=rcXmHJA9u19eNgMXqf90H2uEvWAYxJKmerMYempm2tg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eY5QASmwza0qFuhU4Pg5kyTL7GJyXeXpHMBEqyxJdfNTuJQ1xIggKtSN/oqbGNTIf
	 d8enzRJHBlVcpXbjj8Us2UfWPA3DMgCNHR3fIxOQcsji2/Rb6HnkQlYTKIHMTYCm4f
	 kKABMIcW4GzTHxxvI8AIT8jguGfeJJgmOyWNazLQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dragan Simic <dsimic@manjaro.org>,
	Geraldo Nascimento <geraldogabriel@gmail.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 161/206] arm64: dts: rockchip: remove redundant max-link-speed from nanopi-r4s
Date: Wed,  4 Feb 2026 15:39:52 +0100
Message-ID: <20260204143904.003207923@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143858.193781818@linuxfoundation.org>
References: <20260204143858.193781818@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,manjaro.org,gmail.com,rock-chips.com,sntech.de,kernel.org];
	TAGGED_FROM(0.00)[bounces-213705-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,sntech.de:email]
X-Rspamd-Queue-Id: 6385FE81BA
X-Rspamd-Action: no action

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geraldo Nascimento <geraldogabriel@gmail.com>

[ Upstream commit ce652c98a7bfa0b7c675ef5cd85c44c186db96af ]

This is already the default in rk3399-base.dtsi, remove redundant
declaration from rk3399-nanopi-r4s.dtsi.

Fixes: db792e9adbf8 ("rockchip: rk3399: Add support for FriendlyARM NanoPi R4S")
Cc: stable@vger.kernel.org
Reported-by: Dragan Simic <dsimic@manjaro.org>
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
Acked-by: Shawn Lin <shawn.lin@rock-chips.com>
Link: https://patch.msgid.link/6694456a735844177c897581f785cc00c064c7d1.1763415706.git.geraldogabriel@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
[ adapted file path from rk3399-nanopi-r4s.dtsi to rk3399-nanopi-r4s.dts ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts |    1 -
 1 file changed, 1 deletion(-)

--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
@@ -73,7 +73,6 @@
 };
 
 &pcie0 {
-	max-link-speed = <1>;
 	num-lanes = <1>;
 	vpcie3v3-supply = <&vcc3v3_sys>;
 };



