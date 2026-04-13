Return-Path: <stable+bounces-236275-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JXqGIUX3WnNZwkAu9opvQ
	(envelope-from <stable+bounces-236275-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:19:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A61083EE9D6
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E4F65303FCE9
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C432F547F;
	Mon, 13 Apr 2026 16:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jvthxEXP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE852BDC2F;
	Mon, 13 Apr 2026 16:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096493; cv=none; b=VOnzA0D/eP7J+nlUWzUZBEwThnio1tjBWw7i7ElaPaEIjw37Zef1x4U+IcV/m9apobxcdWCCIsv2M3QYknX+pjlHll7dIuQ5tuMXgiY85zlODFmJkiZtuVisvNqAoV/eFNKnl8vt+4ci3cDSOiGILO7CjyIl7KRp4IBiWWfsxQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096493; c=relaxed/simple;
	bh=2g9zzKiU8cxKuea3E8KqtReZT1VEMHBwcUe+O74lhtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iZeqVtxAqydwWqff3zNl/e9rWM910VM0DjaBhBmIyeyGO2D6VSYhSdfD6cMSy4ZVi7UZTlCIIEgqGubt6PsrV0UUaCSpvrNly1TlYs8oeo7e6vgCluXcRyTasAL/N+sUB6BF2QNIDAa0i3Qi7Xc2i8pYpCOE1FsKs53FMHr0awQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jvthxEXP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0FD5C2BCAF;
	Mon, 13 Apr 2026 16:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776096493;
	bh=2g9zzKiU8cxKuea3E8KqtReZT1VEMHBwcUe+O74lhtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jvthxEXPt+nIeelcx12qf469XqO77y+HK8S6nTiUkSUAPgIRq8HIQ42/3jLh418vX
	 4vG0wkeiegirwQmbStYZylMIxFBBHOcnZLZM+ym3muuXqsSZrkMhNT5qKGgjl9WsbZ
	 fYrQGFirX1MuJ5361RTVa6u1/Sw46vu27MuR1Z0c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 6.18 32/83] arm64: dts: imx8mq-librem5: Bump BUCK1 suspend voltage up to 0.85V
Date: Mon, 13 Apr 2026 18:00:00 +0200
Message-ID: <20260413155732.221669224@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155731.019638460@linuxfoundation.org>
References: <20260413155731.019638460@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236275-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[puri.sm:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,nxp.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A61083EE9D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>

commit 511f76bf1dce5acf8907b65a7d1bc8f7e7c0d637 upstream.

The minimal voltage of VDD_SOC sourced from BUCK1 is 0.81V, which
is the currently set value. However, BD71837 only guarantees accuracy
of ±0.01V, and this still doesn't factor other reasons for actual
voltage to slightly drop in, resulting in the possibility of running
out of the operational range.

Bump the voltage up to 0.85V, which should give enough headroom.

Cc: stable@vger.kernel.org
Fixes: 8f0216b006e5 ("arm64: dts: Add a device tree for the Librem 5 phone")
Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -846,7 +846,7 @@
 				regulator-ramp-delay = <1250>;
 				rohm,dvs-run-voltage = <900000>;
 				rohm,dvs-idle-voltage = <850000>;
-				rohm,dvs-suspend-voltage = <810000>;
+				rohm,dvs-suspend-voltage = <850000>;
 				regulator-always-on;
 			};
 



