Return-Path: <stable+bounces-96028-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B329E02EF
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 14:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 968E5168C6C
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 13:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4A51FF61E;
	Mon,  2 Dec 2024 13:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="omxHxdZb"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556C61FECCE
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 13:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733145038; cv=none; b=iHBvK4xCNRp1VXon0A5GJrPkRiUNMXxVPivv6I5tOQ6BulhMmKfMXOxCoWQ1REVycT5WTxgpJWKMvxLuXAePJQIfNtkvW2fFd992Lx1qTFolQT/TqA0cpiWtCbTwmkatb/xphZbYF6S4sm9HdVoUNeQs5Rs5Tn3kXOqxXiFKc10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733145038; c=relaxed/simple;
	bh=lbIWNYMvSjyfLtOw1mvuOqw21VstXoAYqxbOHR064L0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SUJNx4rBIy0+1OY1P8JyaLC8Co2HPXQnsLC6jzSi6Ackt/GcdbXzxEjJIBYcKd5WfKyuHCOC65rwCOptcC8vF5UfB7rC04S/4mjV4kg3CA02baD4ZOvUrZOe7OoSgc4VxV9QV1IryH9m7lmQnFLvJEKMxDMZx7vyzF1i1m+SgiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=omxHxdZb; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 6AA5FA05BF;
	Mon,  2 Dec 2024 14:10:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=Q6wYDtIQjR5+T/DQDg0D6iro4kbT0EVZiPNUQPiaEF8=; b=
	omxHxdZbEGGFiHU+mldNgYGutxWZUB/3JPUYL+0iJ9xy8/yfCrMRc+ehSKfYbspo
	892oyLJStxlDONlaqhkN2DcluP6QB7ntPOhh/i2WiYE966gy0vF+ClmypqghfxzZ
	v8qs2O3etdk/w4aec1E2PXUsc94bzdW9+rTj+6tuxP/JbclFJ/gxpt85arW7nEsH
	UfTXZIXkq1eycf8lmOF3HIQ8FrVw8G20yTaw0vDntU0CklXyY97kT9Gh/kQaOeVM
	qrNhqkBnSpUfOPYZ7VoMXYvgp5Z1Y+e7dkH8k4Vn+ytAYOAsg4IQa2BL6UmVcPEg
	oBSjFzW7iEno6cW/lmeQffdK0/1aB3g355hyMgLuchyhhZ1+gpdMzDdjQcuGFmgS
	zZRecBDZY9z18LxEeyDF0jgr1LQwynT8P9w1Ru2jtzme/RQ8CSARulHtUQHfkdF+
	h05QCQ9Lq1h6YKcCvqdNpCDlg+q+6vK6Ai9Hj95J/rI2sDc0qfd5dbLZ4jC4h1A3
	xInhFGkAmyr04D3+NiIiHIJBTcPWOlFxlKgnkrwGwVIj60DAXdnhXb8NeAFvq58r
	Rl2FTBkmZrhRcFPRsSjIA5eZSO4mP8GADptOvQDaf3uAfYAwEIkzN3WKDsoao49I
	+ZR8p8tR8X6HQmRpchJ5ASPYJFF5taUANU1WgFl+LgA=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <stable@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Sasha
 Levin" <sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH 6.11 v2 0/3] Fix PPS channel routing
Date: Mon, 2 Dec 2024 14:10:22 +0100
Message-ID: <20241202131025.3465318-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1733145034;VERSION=7982;MC=1009784274;ID=156985;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855637261

On certain i.MX8 series parts [1], the PPS channel 0
is routed internally to eDMA, and the external PPS
pin is available on channel 1. In addition, on
certain boards, the PPS may be wired on the PCB to
an EVENTOUTn pin other than 0. On these systems
it is necessary that the PPS channel be able
to be configured from the Device Tree.

[1] https://lore.kernel.org/all/ZrPYOWA3FESx197L@lizhi-Precision-Tower-5810/

Francesco Dolcini (3):
  dt-bindings: net: fec: add pps channel property
  net: fec: refactor PPS channel configuration
  net: fec: make PPS channel configurable

 Documentation/devicetree/bindings/net/fsl,fec.yaml |  7 +++++++
 drivers/net/ethernet/freescale/fec_ptp.c           | 11 ++++++-----
 2 files changed, 13 insertions(+), 5 deletions(-)

-- 
2.34.1



