Return-Path: <stable+bounces-6433-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F3380EA46
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 12:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8BEBB20B32
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 11:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AEC5D481;
	Tue, 12 Dec 2023 11:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="gxcsFfRD"
X-Original-To: stable@vger.kernel.org
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E028FED
	for <stable@vger.kernel.org>; Tue, 12 Dec 2023 03:22:47 -0800 (PST)
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id 8BE8711D04A2;
	Tue, 12 Dec 2023 14:17:21 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 8BE8711D04A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1702379841; bh=x2Jm0xUedAtS0RUe8qmWwG38faX4FDQ1yRUOKkXwBI0=;
	h=From:To:CC:Subject:Date:From;
	b=gxcsFfRDr17YUaZXFg0rWjatkX9tAvNJ2Gul2BbjiUQr0McXov/6OwDxqjxr/7AdF
	 IfKdmNOfweNTRcpNzjHAwABK5CvsvZ0z0EJHxnmkVelD1hn8PG6aOGcAJSUGWZuWEd
	 f+G9UNnFfQZ7MSPaZBevzgEDWDSLMGagjq0hT8vs=
Received: from msk-exch-01.infotecs-nt (msk-exch-01.infotecs-nt [10.0.7.191])
	by mx0.infotecs-nt (Postfix) with ESMTP id 875673029CDE;
	Tue, 12 Dec 2023 14:17:21 +0300 (MSK)
From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: Daniel Starke <daniel.starke@siemens.com>, Jiri Slaby
	<jirislaby@kernel.org>, Russ Gorby <russ.gorby@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: [PATCH 5.10 0/3] tty: n_gsm: fix tty registration before control
 channel open
Thread-Topic: [PATCH 5.10 0/3] tty: n_gsm: fix tty registration before control
 channel open
Thread-Index: AQHaLOzG4q0VQXlQGEK0PfABOy9uPw==
Date: Tue, 12 Dec 2023 11:17:21 +0000
Message-ID: <20231212111431.4064760-1-Ilia.Gavrilov@infotecs.ru>
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
X-KLMS-AntiPhishing: Clean, bases: 2023/12/12 08:32:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2023/12/12 02:27:00 #22664189
X-KLMS-AntiVirus-Status: Clean, skipped

Syzkaller reports memory leak issue at gsmld_attach_gsm() in
5.10 stable releases. The reproducer injects the memory allocation
errors to tty_register_device(); as a result, tty_kref_get() isn't called
after this error, which leads to tty_struct leak.
The issue has been fixed by the following patches that can be cleanly
applied to the 5.10 branch.

Found by InfoTeCS on behalf of Linux Verification Center
(linuxtesting.org) with Syzkaller

