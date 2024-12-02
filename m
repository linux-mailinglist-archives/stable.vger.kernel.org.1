Return-Path: <stable+bounces-96119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 499FC9E0876
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 17:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D1EA16A3D5
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 15:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B94A1304BA;
	Mon,  2 Dec 2024 15:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="TErU9FmP"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2207757EA
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 15:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733155086; cv=none; b=VMVYnsfwVM+bBUk5ERLZ1U4wN816oTrzmfDjKi4xcSuDW+l6uGc84SvYPVKYhijGd3g7lavHKvb8aQQdWKLFtoqNKkM7sGfW5SBUyRM9y/5aXz9pOnsYEAAb3mtjAsEcRvZK+k8u19/oGBE8o4xAxo3VUUluPJnlVLonc+qSjg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733155086; c=relaxed/simple;
	bh=AsmS0O0LobS4HF34MnQU1zcw4SRgmr4teuSJuhQf67w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J8fIYXOV+s45yehyzHYStcZf8b37Xr3GadATqlY8E0TufQ08oBbPT5H6xrKDOWOKgVdsO3tCNazDZ9dgupiNXTgdwQnnHlDI6cYyWVDNyMZUxEPMZUykEsCtFd0l7ho0IJqymGvw0FnZoL3n4NyWqwV85QfOgIpRMUUGFGEPIHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=TErU9FmP; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 71367A07FF;
	Mon,  2 Dec 2024 16:58:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=YOuKY9km4OF/f7YVbyq/
	ULvcl4sIlXanZsvH0J4LkgQ=; b=TErU9FmPrbalC1B7IUBrXhMM2KwLnGQiJEKu
	aqX9DVTFyEJq0saJmT9+zmXlLK1y/I4vJIMEVbqT/4Goz3wyPhtICMvX3QD6itB6
	JxgOmXfQqjJJJP3VjW2MLGCCVIcE9tAwDT1xdwOOQKNcB2F9lWArTpmGsknmFLe5
	HEgH8feImbNMaCTf+UpaWcqRc9/02avydA4C9LcS0tSUIEv1IenbBxoWnYKpp+52
	zFP+LdllA17JrLzkcRebfAN5P4ESdPB+/OXci3uq9+xy5hpAnXeIdB9M+1wtoXu3
	tkO6ArFufh0x4Vr50Y07qnz/w9ep737FSxuiCmVq7G68uo5761T4KWUJESxqIGra
	RcAMSmvLrZ7u0yuddlks0GSSErOw882zE0/6uhAWPwRQDJ/k85IBnphjZBkFA9aT
	aSFO4wI5vFedqHHL7x2OUXkvvkOV/2r07sz37XmcxsvSd7EFMiPtVHH8KbAoL2au
	l4EiKpnJRBH6X4SuiR7Jhf1LzRd/GSyEjSnXSwuzRHJ6fO6bhNDQ/GsK6GyfGNmT
	zOb8EpmW70VVhO+gH6OAF6enVtSourbdfNqgfPoZicAnqdlVblXytIXhrcTYDoN4
	0opquN373P7Ho4jGRzqsz87fN4KXf+t0mZL7qGcqM0F4cpThSVsynxFMKubNFFEF
	mURhLNQ=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <stable@vger.kernel.org>
CC: Francesco Dolcini <francesco.dolcini@toradex.com>, Sasha Levin
	<sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Conor
 Dooley" <conor.dooley@microchip.com>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.12 v3 1/3] dt-bindings: net: fec: add pps channel property
Date: Mon, 2 Dec 2024 16:57:58 +0100
Message-ID: <20241202155800.3564611-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202155800.3564611-1-csokas.bence@prolan.hu>
References: <20241202155800.3564611-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1733155081;VERSION=7982;MC=607621074;ID=157283;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855637261

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Add fsl,pps-channel property to select where to connect the PPS signal.
This depends on the internal SoC routing and on the board, for example
on the i.MX8 SoC it can be connected to an external pin (using channel 1)
or to internal eDMA as DMA request (channel 0).

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

(cherry picked from commit 1aa772be0444a2bd06957f6d31865e80e6ae4244)
---
 Documentation/devicetree/bindings/net/fsl,fec.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/fsl,fec.yaml b/Documentation/devicetree/bindings/net/fsl,fec.yaml
index 5536c06139ca..24e863fdbdab 100644
--- a/Documentation/devicetree/bindings/net/fsl,fec.yaml
+++ b/Documentation/devicetree/bindings/net/fsl,fec.yaml
@@ -183,6 +183,13 @@ properties:
     description:
       Register bits of stop mode control, the format is <&gpr req_gpr req_bit>.
 
+  fsl,pps-channel:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0
+    description:
+      Specifies to which timer instance the PPS signal is routed.
+    enum: [0, 1, 2, 3]
+
   mdio:
     $ref: mdio.yaml#
     unevaluatedProperties: false
-- 
2.34.1



