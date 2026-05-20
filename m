Return-Path: <stable+bounces-250509-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIhsJqHzDWry4wUAu9opvQ
	(envelope-from <stable+bounces-250509-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:47:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E486D5948EB
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F42E339DE3A
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689BC3368B6;
	Wed, 20 May 2026 16:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BjF2A/jP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9C0285061;
	Wed, 20 May 2026 16:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295596; cv=none; b=Ar5WTHNWscAvZHGJDWYsx52NvJAsEukZOz05C02CZWHV1SgAV1AmqXWF5O/3BH3dvW1yQTfJ1ME9BQJHkApW84hzr5qKwZsMGFbnhyMQD8zNWqLFaXrFAI18eVl8iDFNTkRSRajq7H3keqcGbvWTLqEHSre1AIc5KEvN4MbHc1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295596; c=relaxed/simple;
	bh=5KSmfXjSwSaZ6KeGFPkxjoZVomCjdKHMC6TIgSu5rO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=atEYIQAJoGooIhOYPowzXX8g3qIUsYUnuGGIFWBm49jgpTENBzvXiA0tXS4csQvdE0v5lOSaFzgoR5r/GVb/1YNxtYRLSwJAjfEESm8Mb2yqm5jnWn8YYshMV2nYLCEMKd4cbm4q+D4CgDc6kjKL73MVkYPp2f23lNyZ/MgZviQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BjF2A/jP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945E01F000E9;
	Wed, 20 May 2026 16:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295595;
	bh=fjteCvJiSnCsX2nkgJpyvlOo6ZhQI5xMEuFNXOiMJmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BjF2A/jPNdnu8ohfzY8pjBu0R62TJs+MQh+XEDqn3oHYJRKplFG8A4SreiE12Cb4U
	 W02ogYImxN/VV31quqqnP67aTKoHv1Aqhg6gnPE1DMyODvocNW8N1iQQXNVGz0QRij
	 toa4UbmPQBumIahzdpASl5pknPyiRAH7+X3GhLg8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Conor Dooley <conor@kernel.org>,
	Yixun Lan <dlan@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0472/1146] riscv: dts: spacemit: pcie: fix missing power regulator
Date: Wed, 20 May 2026 18:12:02 +0200
Message-ID: <20260520162158.874486591@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-250509-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ca400000:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,0.0.0.0:email,devicetree.org:url]
X-Rspamd-Queue-Id: E486D5948EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yixun Lan <dlan@kernel.org>

[ Upstream commit 8a9071299dec817a544c0fb48f7302396fafdc4b ]

The PCIe port require 3.3v power regulator for device to work properly, So
explicitly add it to fix the DT warning:

arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dtb: pcie@ca400000 (spacemit,k1-pcie): pcie@0: 'vpcie3v3-supply' is a required property
        from schema $id: http://devicetree.org/schemas/pci/spacemit,k1-pcie-host.yaml

Fixes: 0be016a4b5d1 ("riscv: dts: spacemit: PCIe and PHY-related updates")
Reported-by: Conor Dooley <conor@kernel.org>
Link: https://lore.kernel.org/r/20260226-k1-pcie-fix-pwr-v1-1-94b493cd27e5@kernel.org
Signed-off-by: Yixun Lan <dlan@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
index 5971605754b35..51f6c6a774b0d 100644
--- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -305,6 +305,7 @@ &pcie1_phy {
 
 &pcie1_port {
 	phys = <&pcie1_phy>;
+	vpcie3v3-supply = <&pcie_vcc_3v3>;
 };
 
 &pcie1 {
@@ -320,6 +321,7 @@ &pcie2_phy {
 
 &pcie2_port {
 	phys = <&pcie2_phy>;
+	vpcie3v3-supply = <&pcie_vcc_3v3>;
 };
 
 &pcie2 {
-- 
2.53.0




