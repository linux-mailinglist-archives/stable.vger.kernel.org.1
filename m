Return-Path: <stable+bounces-60438-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 634AD933CEE
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 14:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FA1E1C216B4
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 12:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D3317FAA4;
	Wed, 17 Jul 2024 12:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TnQU7PO+"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D1417F378;
	Wed, 17 Jul 2024 12:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721219281; cv=none; b=Ep+w9VQocu3IDUrMV/lXgkI9GKNxV2UfZM1XT4LVVHj3gP0aUOfj6sR8WtYxwRH0esVPEhW/RgP36NPppp4xdSDifdDvMLLzq9p6brZcaHjp13HHCivsxSOl0WUTucfzwqsKz2jJq4R5F7uBtI/IivgVj30DIKhbq4Ei4+d4gnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721219281; c=relaxed/simple;
	bh=8pdXIkxSbxEEaa0dOomW4yGjo/Lwu7C2h4OWoG18TK0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=pim8UBusAsLFEe1AtysF4SIBrhDYOOguze2lQp2EeDZUpom+LRymqkbKMGsj+NDXcQ5PENqgIn/6fROHdmHE9W/KbuRCj1g1oloTpTmzapFXRhpz6vQF7Al8s5F2AFiEIqFROHuyLr9rBVdcDhCk6L3ahKClhgvwnhQ/8oMfd8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TnQU7PO+; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HCPvMC001221;
	Wed, 17 Jul 2024 12:27:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id; s=corp-2023-11-20; bh=7e8rCC
	q6Pvp/2JOR9RDufes1ne0efzU0ciVK4xUxmGw=; b=TnQU7PO+eVKarRXz7IvJnF
	eyeDZcbIrVgbQagOKT5BYGZYzxYPqWhOlbGBq8jo8TVqpxCUEht3aLCgLr4QzIzm
	Tx9iutcj8GeYlmWHesgKKZmv+b7y4/04vkyT/IIJE76C4AuhSIw6cX4CYFfm+Uxi
	GREKFLQ7EBglci7OBQeZzz1koCmeBftZOHAABVKXVGpNwjQiwCKse03iJayCWqqc
	Z8sZMdoD/3SVYxXB0jWz9K85ynaaw+0qtj4NAAhP1JVMYe/dui63WV2vsRF3zPOe
	LAHKGLMSfDuszCOF4Zul8rSE4fKfR1IaIBdszBK3hQLuAd28toUUi9AKaKuIqtfA
	==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40edxpr04v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 12:27:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46HCHgHJ006831;
	Wed, 17 Jul 2024 12:27:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40dwexgdyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 12:27:45 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46HCRjXZ040778;
	Wed, 17 Jul 2024 12:27:45 GMT
Received: from gkennedy-linux.us.oracle.com (gkennedy-linux.us.oracle.com [10.152.170.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 40dwexgdyd-1;
	Wed, 17 Jul 2024 12:27:45 +0000
From: George Kennedy <george.kennedy@oracle.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, tony@atomide.com,
        andriy.shevchenko@linux.intel.com, l.sanfilippo@kunbus.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Cc: george.kennedy@oracle.com, stable@vger.kernel.org,
        harshit.m.mogalapalli@oracle.com
Subject: [PATCH] serial: core: check uartclk for zero to avoid divide by zero
Date: Wed, 17 Jul 2024 07:24:38 -0500
Message-Id: <1721219078-3209-1-git-send-email-george.kennedy@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_08,2024-07-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407170095
X-Proofpoint-GUID: 8_O0akFqp8QVPViJ8t8DIDwoE3iiXNnl
X-Proofpoint-ORIG-GUID: 8_O0akFqp8QVPViJ8t8DIDwoE3iiXNnl
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Calling ioctl TIOCSSERIAL with an invalid baud_base can
result in uartclk being zero, which will result in a
divide by zero error in uart_get_divisor(). The check for
uartclk being zero in uart_set_info() needs to be done
before other settings are made as subsequent calls to
ioctl TIOCSSERIAL for the same port would be impacted if
the uartclk check was done where uartclk gets set.

Oops: divide error: 0000  PREEMPT SMP KASAN PTI
RIP: 0010:uart_get_divisor (drivers/tty/serial/serial_core.c:580)
Call Trace:
 <TASK>
serial8250_get_divisor (drivers/tty/serial/8250/8250_port.c:2576
    drivers/tty/serial/8250/8250_port.c:2589)
serial8250_do_set_termios (drivers/tty/serial/8250/8250_port.c:502
    drivers/tty/serial/8250/8250_port.c:2741)
serial8250_set_termios (drivers/tty/serial/8250/8250_port.c:2862)
uart_change_line_settings (./include/linux/spinlock.h:376
    ./include/linux/serial_core.h:608 drivers/tty/serial/serial_core.c:222)
uart_port_startup (drivers/tty/serial/serial_core.c:342)
uart_startup (drivers/tty/serial/serial_core.c:368)
uart_set_info (drivers/tty/serial/serial_core.c:1034)
uart_set_info_user (drivers/tty/serial/serial_core.c:1059)
tty_set_serial (drivers/tty/tty_io.c:2637)
tty_ioctl (drivers/tty/tty_io.c:2647 drivers/tty/tty_io.c:2791)
__x64_sys_ioctl (fs/ioctl.c:52 fs/ioctl.c:907
    fs/ioctl.c:893 fs/ioctl.c:893)
do_syscall_64 (arch/x86/entry/common.c:52
    (discriminator 1) arch/x86/entry/common.c:83 (discriminator 1))
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)

Reported-by: syzkaller <syzkaller@googlegroups.com>
Cc: stable@vger.kernel.org
Signed-off-by: George Kennedy <george.kennedy@oracle.com>
---
 serial_struct baud_base=0x30000000 will cause the crash.

 drivers/tty/serial/serial_core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 2a8006e3d687..9967444eae10 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -881,6 +881,14 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 	new_flags = (__force upf_t)new_info->flags;
 	old_custom_divisor = uport->custom_divisor;
 
+	if (!(uport->flags & UPF_FIXED_PORT)) {
+		unsigned int uartclk = new_info->baud_base * 16;
+		/* check needs to be done here before other settings made */
+		if (uartclk == 0) {
+			retval = -EINVAL;
+			goto exit;
+		}
+	}
 	if (!capable(CAP_SYS_ADMIN)) {
 		retval = -EPERM;
 		if (change_irq || change_port ||
-- 
2.39.3


