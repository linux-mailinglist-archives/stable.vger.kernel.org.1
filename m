Return-Path: <stable+bounces-105027-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCF19F555F
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 19:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A9C1177483
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 17:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8DD1F866E;
	Tue, 17 Dec 2024 17:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="UMHrdzFK"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCA41448DC
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 17:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734457859; cv=none; b=f+jMbiAJrJuhEvB1RaJeI32MjDoicVSkyqp8hKJpYtUKOj6G7Xdp0JQjlNtFAi6z7f06UV2NXJUnmkHOQlcI1RqKl9eaZkOM0SnzlQsHZdtjirGe7O3akYwmabup43oqS8t5ChZ1nC3qsvr81qTan3t9Sh/I1nFEJziofcp3Et4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734457859; c=relaxed/simple;
	bh=ZbTca4qmgjv6v8KEm0tZssR7NwYqxicWoORsbTyi21Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fK1//cM69YxzMJn8mgVzR7/zhE6O9vbY86rP7V7ZIfrv+HQV1fe4fXDxTfphBQazMrzO6m5AGrq/95Tm1IkYKI8g+ojF08rpjVvnrkbMGy3pJxD6EA9fxCxf2hxvSKH55N6RruRNsYZGqbnMe+8ZiHW4xJTbwWgCAsWLYP/7RVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=UMHrdzFK; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id ED630A0B3F;
	Tue, 17 Dec 2024 18:50:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=B06kwaOx0MsEFm8ahid16jSB8JAffKyEDHtzZQQCqww=; b=
	UMHrdzFKUe61B94BNLEy9++oL6F982gBwt3bKbOyHhi+LXuuxdfWdVaDodUhNtMy
	9MBvADAswzxK52o6fiu7e2fcRLksCfBdN3qnw68NkUUG2LQJg56tQQUp+MDHNxIX
	a6G2qiJhHIGSaZs+FzcDn65zeh2D758nntTQ8qLe+/yGcI+bq8SFqKGAK/4n2vmx
	P9ub2YggKEVmJI7nKks2YzUd4uodkO+HL/9lFC6v2vtIjgRAg2iq9Ye4eXYrt8M5
	NTNvppl1JtFgGXXXniTyYRySIkDpZF2uclmi2vOd1mJlloaTPys2MkQ52hJENI9e
	EFkPfcpWUqh4xDSz+JPurYcXd8VFMSbRsgwtWXje2hS/vSH+i8T+/0hvNyyTSAcc
	MhGjIxRbF5AgKtr3FVHHPxcDpEDHDO5MhkUvk7sNEtHv3gwJ2NGf2MHw1U5EVmZF
	he2YTmPMzqEEoyteAhHEYyxdrKRUW0q9ICfcJF4Vcur+TQ5KcuYuBEe0Nra0nNNj
	176wg/q2SM4bcPPyAtniKw29F6CkRL/LyHs2hLbQ511i8RuyvBHiEetg3DY6BjMH
	zTdVehSbcLWfMeIx6xf2+Hhio/XhLLDIzfPJk2WiZnVb9MdFCvGgPl3CFkLKGUt4
	DlPN0ycViKQH7m0IdfXYf+SBmDfR5+Z/VDee/vWWTXs=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <stable@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Sasha
 Levin" <sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH 6.6 0/3] Fix PPS channel routing
Date: Tue, 17 Dec 2024 18:50:39 +0100
Message-ID: <20241217175042.284122-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1734457847;VERSION=7982;MC=1486679705;ID=67964;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD948556D766B

On certain i.MX8 series parts [1], the PPS channel 0
is routed internally to eDMA, and the external PPS
pin is available on channel 1. In addition, on
certain boards, the PPS may be wired on the PCB to
an EVENTOUTn pin other than 0. On these systems
it is necessary that the PPS channel be able
to be configured from the Device Tree.

[1] https://lore.kernel.org/all/ZrPYOWA3FESx197L@lizhi-Precision-Tower-5810/

Now that these patches are applied to 6.12.y,
it is time to include it in the upcoming 6.6.67.
This series is picked onto 6.6.66.

Francesco Dolcini (3):
  dt-bindings: net: fec: add pps channel property
  net: fec: refactor PPS channel configuration
  net: fec: make PPS channel configurable

 Documentation/devicetree/bindings/net/fsl,fec.yaml |  7 +++++++
 drivers/net/ethernet/freescale/fec_ptp.c           | 11 ++++++-----
 2 files changed, 13 insertions(+), 5 deletions(-)

-- 
2.34.1



