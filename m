Return-Path: <stable+bounces-76787-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3B197D194
	for <lists+stable@lfdr.de>; Fri, 20 Sep 2024 09:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC533B214F2
	for <lists+stable@lfdr.de>; Fri, 20 Sep 2024 07:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0C4433D0;
	Fri, 20 Sep 2024 07:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="XK88w7n6"
X-Original-To: stable@vger.kernel.org
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9905547A66;
	Fri, 20 Sep 2024 07:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.244.183.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726816451; cv=none; b=sAoKN82IirsTZw4fiGsmsPnywiMOlHFk8k58dqRC0BIOOi+t4B/1CixJqv+WJ1IciBnYFZPJOB3ivtuk98pyY4q92KegBC1S8/0g2wAZF/vmOty10OMI/bEEa/6V1IheUnm2e9jeexsnRvcky33FogVSYlMvGGwnaxlXpS1rZMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726816451; c=relaxed/simple;
	bh=ahsQEgvUFzHx/r3SskeSCNx2DsaTJIzSgTEMtTRlSss=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Fq13REWqXdzjaEa3yTehscSrlZiDvXueIRb9g7g+objh3ZVOM+JU5lstQd52drV+LSnzm0CT5kXgziOp2DkvF3/oP+caiwsRLHz2nNG145canvxqD5ZtOq4AxLvpZapywuv4EviqvD0hc/hTX+McgroWNS06OFYK1VRqIFfkwRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru; spf=pass smtp.mailfrom=infotecs.ru; dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b=XK88w7n6; arc=none smtp.client-ip=91.244.183.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infotecs.ru
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id D64C2108C18E;
	Fri, 20 Sep 2024 10:08:10 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru D64C2108C18E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1726816091; bh=zq6hYggsf6HTtcFx4TomRG0hdUuOq3ziF/D6M0lP86w=;
	h=From:To:CC:Subject:Date:From;
	b=XK88w7n6R5927aS7ufMOWlMGi9fEQ+mnKRna3aR4pMcsCfhaUc+hEonK4iNNa02uu
	 LgI7ZKy3DUKDKS84xMQf4iI3BiFpit+z5rWCvZDsQXtW1UgIDK1IBAr7rKWhCBUARJ
	 ALaMZ2zlcqYl2jAS9CW41CC6LovIBo1l+9gz6z3k=
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
	by mx0.infotecs-nt (Postfix) with ESMTP id D3B3230CCD2A;
	Fri, 20 Sep 2024 10:08:10 +0300 (MSK)
From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: Jiri Slaby <jirislaby@kernel.org>, Nicolas Pitre <nico@fluxnic.net>,
	"Sasha Levin" <sashal@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: [PATCH 5.10/5.15 0/1] tty: add the option to have a tty reject a new
 ldisc
Thread-Topic: [PATCH 5.10/5.15 0/1] tty: add the option to have a tty reject a
 new ldisc
Thread-Index: AQHbCyvZeX4bDTLfeUWnZs5Mx+Ubqw==
Date: Fri, 20 Sep 2024 07:08:10 +0000
Message-ID: <20240920070809.1145963-1-Ilia.Gavrilov@infotecs.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-exclaimer-md-config: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KLMS-Rule-ID: 5
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Status: not scanned, disabled by settings
X-KLMS-AntiSpam-Interceptor-Info: not scanned
X-KLMS-AntiPhishing: Clean, bases: 2024/09/20 05:26:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2024/09/20 04:11:00 #26640789
X-KLMS-AntiVirus-Status: Clean, skipped

Syzkaller reports a sleeping function called from invalid context
in do_con_write() in the 5.10 and 5.15 stable releases.

The issue has been fixed by the following upstream patch that was
adapted to 5.10 and 5.15. All of the changes made to the patch in order
to adapt it are described at the end of the commit message.

This patch has already been backported to the following stable branches:
v6.9 - https://lore.kernel.org/all/20240625085551.368621044@linuxfoundation=
.org/
v6.6 - https://lore.kernel.org/all/20240625085539.398852153@linuxfoundation=
.org/
v6.1 - https://lore.kernel.org/all/20240625085527.625846117@linuxfoundation=
.org/

Found by InfoTeCS on behalf of Linux Verification Center
(linuxtesting.org) with Syzkaller.

Linus Torvalds (1):
  tty: add the option to have a tty reject a new ldisc

 drivers/tty/tty_ldisc.c    |  6 ++++++
 drivers/tty/vt/vt.c        | 10 ++++++++++
 include/linux/tty_driver.h |  8 ++++++++
 3 files changed, 24 insertions(+)

--=20
2.39.2

