Return-Path: <stable+bounces-212475-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOsbMLIzeml+4gEAu9opvQ
	(envelope-from <stable+bounces-212475-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:05:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 518BDA508F
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBCDA30A35F8
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBA32DF155;
	Wed, 28 Jan 2026 15:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="15JTAM9I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F2C1D6AA;
	Wed, 28 Jan 2026 15:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615644; cv=none; b=MpiME9qJY2jtVDCC4M+Fes0kjPfzR6v4TLNArGryw09EKBqgCBDMgKFc4JGI12GWFnsAexjqJdjc5knFkqKWgWMpUeIuj34LK77WHjcBZsmjOTPCbRPzmfrCJ+ECmOkvEWgap7jSFgiTZvWcL19RKDb+M63EiF6ugVuVeZNqdlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615644; c=relaxed/simple;
	bh=owshqcYQPU1z+wM3uxkJVKPbsFNNFErLCBYtNOpLEZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NpgGBJ5lTTmQePZSSmgCFEUR2KRgrSE0kqoKmmb6Yo5zww+9L24X1A7z1M51RpEzaHvIO5cgLKPFo/g9qxAFaw3RiGRMtgXiJ5mwhr+GtDA34eseOa+R3ajrPvdZMaGyBd/vGClA/nL2lqhkrHnOcMbn1G5ePrXSdW7TJVfQlBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=15JTAM9I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A347FC4CEF1;
	Wed, 28 Jan 2026 15:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615644;
	bh=owshqcYQPU1z+wM3uxkJVKPbsFNNFErLCBYtNOpLEZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=15JTAM9Iz+FyLD5cjh9/vJh8S8WC+YuqKHDduXMvYafr4R32DqtjSGyEWEMA8I9WD
	 xnXHr8Z8VuY3oW/pdaaSJ+KNa+89WhlzMY8CnG1zEAMgBu0ItUxAcSO0/8pFOE2y9t
	 qMDAEAqW5ojEI5zf94cLa+QUqEMhRyY8QbYAUbH4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Geraldo Nascimento <geraldogabriel@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 6.18 063/227] arm64: dts: rockchip: remove dangerous max-link-speed from helios64
Date: Wed, 28 Jan 2026 16:21:48 +0100
Message-ID: <20260128145346.609529485@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
References: <20260128145344.331957407@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,rock-chips.com,manjaro.org,gmail.com,sntech.de];
	TAGGED_FROM(0.00)[bounces-212475-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sntech.de:email,manjaro.org:email,rock-chips.com:email]
X-Rspamd-Queue-Id: 518BDA508F
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geraldo Nascimento <geraldogabriel@gmail.com>

commit 0368e4afcf20f377c81fa77b1c7d0dee4a625a44 upstream.

Shawn Lin from Rockchip strongly discourages attempts to use their
RK3399 PCIe core at 5.0 GT/s speed, citing concerns about catastrophic
failures that may happen. Even if the odds are low, drop from last user
of this non-default property for the RK3399 platform, helios64 board
dts.

Fixes: 755fff528b1b ("arm64: dts: rockchip: add variables for pcie completion to helios64")
Link: https://lore.kernel.org/all/e8524bf8-a90c-423f-8a58-9ef05a3db1dd@rock-chips.com/
Cc: stable@vger.kernel.org
Reported-by: Shawn Lin <shawn.lin@rock-chips.com>
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
Acked-by: Shawn Lin <shawn.lin@rock-chips.com>
Link: https://patch.msgid.link/43bb639c120f599106fca2deee6c6599b2692c5c.1763415706.git.geraldogabriel@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts |    1 -
 1 file changed, 1 deletion(-)

--- a/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
@@ -424,7 +424,6 @@
 
 &pcie0 {
 	ep-gpios = <&gpio2 RK_PD4 GPIO_ACTIVE_HIGH>;
-	max-link-speed = <2>;
 	num-lanes = <2>;
 	pinctrl-names = "default";
 	status = "okay";



