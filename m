Return-Path: <stable+bounces-273551-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bJQyB/piVGqolQMAu9opvQ
	(envelope-from <stable+bounces-273551-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 06:00:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1ED7470C3
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 06:00:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=MaahYQex;
	dmarc=pass (policy=none) header.from=ibm.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273551-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273551-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E29633011BC5
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 04:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CA31DF26E;
	Mon, 13 Jul 2026 04:00:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E25233937
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 04:00:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783915231; cv=none; b=Exr3Yi5Xoo2Y8sWRZ/UpA0bN/OaNIY2wFVQdLPfXC3EBMUu3hESbCmGKc4m0ToSMAfWMLrwG7LxEhYw09Akf/TwfyX1Vq/0fh5fGesXt5dI47IToQDRolEPkSY252XPFBZAqO4KGPAe8n32Ee9ErQDJHIiBPj6gWcJB8XnqyEmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783915231; c=relaxed/simple;
	bh=jfmyXq/xdOSYlzbwqm++BXMv/l5HuzXdEbA9n/YRNnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mxw+IyqNqyBL6pqxvenQr5GhhhtHCnkMRSn4KR8BI5zKeXumgD+vE8OWxuU/Y3n8pSvS0b4QTn0qM53zKvDmcSNv15Jl3kjgZDaDn9jCQBtH4Sm/uPxNItQjAG7DWOH9AXl4eaBekbDDw0hi9kchAF/UJJ1c8v06kKIwQMjlems=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MaahYQex; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D3CerA1285034;
	Mon, 13 Jul 2026 04:00:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=TcvkY5jQJWy2eqfpBuatDJifMVq1igm6aF/4dCdVp
	Es=; b=MaahYQexuTghk+jm5Uz7FIag0nM4D7vFMBtIyqiSZaWxqG6Yt8f7Y/sCp
	vB3hYo03bfPGKWG9p9IrxrPGASaQYY8o8VmseeF3AJOeSeR1lvlvo21+zEYhViAH
	ccZ00nfOTg/37CFBQXb6S6eXvjFeaXwsngygT/PEAGkAmI44vNLCLxLwzhiolCgw
	7rLeJoY6dn+Mazy5CETC5g/Yu7Dv7cg1aM86auntiqSRAFZjpwnbIO5iszLViLVO
	RPkK9gR4GzJ6BmvGyKUywoXmyGA4zFF5KlPFZTBJSb1RYjCDGngLGVKxLC8tLk6b
	ccChk81IxYtjB28ISESfMEZFmYGzw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fber86gmj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 04:00:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66D3ns8h032189;
	Mon, 13 Jul 2026 04:00:05 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uxummx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 04:00:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66D401IK44892656
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 04:00:01 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A2402004B;
	Mon, 13 Jul 2026 04:00:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F296E20040;
	Mon, 13 Jul 2026 03:59:57 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.bl1-in.ibm.com (unknown [9.123.14.142])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 03:59:57 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        ritesh.list@gmail.com
Cc: npiggin@gmail.com, chleroy@kernel.org, shivangu@linux.ibm.com,
        hbathini@linux.ibm.com, mahesh@linux.ibm.com, adityag@linux.ibm.com,
        venkat88@linux.ibm.com, stable@vger.kernel.org,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: [PATCH v2 0/3] powerpc/crash: protect kdump from active watchdogs
Date: Mon, 13 Jul 2026 09:29:51 +0530
Message-ID: <20260713035954.1559605-1-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDAzNCBTYWx0ZWRfXwEeaK+HBr3fT
 R/jXEmFaR/nrr/cvix9zA8/Oobo40TLdg+165clZLe4KoqC2Q9TTeXv4eKvDtavsKjxCbyUv++w
 A69lX6X5mtfLCO0rxc3ZlYOandNsJ9NpfCxjfhGAYRQ+2dFDbSr41RaZiHAHMy18HXtMwEDDlls
 FJFuWQmpD2Tckg2+11iqE2jaaSYbK7ygW977+IK0g3z+r2N2Ys3CHHBR5Gv70/MBDV8G9kp5JZ0
 p/QeyQL1nD9UCoxYxMGyVLz9Rmk4ZyzWjUA2V9+oAeQkv1TStuqFwWbB1HqeOjSkukx4bncYDCy
 7XJ+FFT73/geaDnkjzsWHCXVpiCLEvqqPlRn4RlKotivIG9Cz3zr8TSiGjZnsxdzFkyij7daE4O
 1G9f/nFYwd+U3lXQxzMrI/Qstqi5RyYguSLl2emtyTM72dhnhsAxXMi7Q4friDlferycBpM2lOv
 QB6AGZqRtTQQnQznvzQ==
X-Proofpoint-ORIG-GUID: HtxwFtt75lm-fJeRFP11dfwJSDN7oMiO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDAzNCBTYWx0ZWRfXzyUOwROZQDqK
 69lbJR33v/2uvUiwYfRo27VojjBCooLANROkGAWwoUfTm9eCWoxuifOe+tgzSBdHeYkh5elMoP4
 Fe0q6KqNQm+6nvKOVV83N29yoBPdfZk=
X-Authority-Analysis: v=2.4 cv=TpzWQjXh c=1 sm=1 tr=0 ts=6a5462c6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=Gk6Qg7I2AAAA:20 a=iox4zFpeAAAA:8 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=akTv58P-d981-2rlXkgA:9 a=O8hF6Hzn-FEA:10
 a=WzC6qhA0u3u7Ye7llzcV:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: UvoKfOaP_kROOzZAEsPq8YPjXuEqrb9Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130034
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273551-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[lists.ozlabs.org,linux.ibm.com,ellerman.id.au,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sourabhjain@linux.ibm.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linuxppc-dev@lists.ozlabs.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:ritesh.list@gmail.com,m:npiggin@gmail.com,m:chleroy@kernel.org,m:shivangu@linux.ibm.com,m:hbathini@linux.ibm.com,m:mahesh@linux.ibm.com,m:adityag@linux.ibm.com,m:venkat88@linux.ibm.com,m:stable@vger.kernel.org,m:sourabhjain@linux.ibm.com,m:riteshlist@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,linux.ibm.com,vger.kernel.org];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sourabhjain@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,linux.ibm.com:from_mime,suse.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8A1ED7470C3

On pseries LPAR systems in a high-availability environment using the
SBD[1][2] service, I observed that the system abruptly rebooted before
dump capture could complete.

Further investigation showed that SBD had configured a watchdog with
a 30-second timeout. Since the kernel crashes directly into the
kdump kernel without shutting down userspace services, the watchdog
remained active during dump capture. Once the watchdog timeout
expired, PHYP reset the LPAR, causing dump capture to fail.

The issue was reproducible only when the watchdog was active. Dump
capture completed successfully after disabling the watchdog,
stopping the SBD service, or increasing the watchdog timeout value.

This patch fixes the issue by stopping all active watchdogs on the
crash shutdown path before booting the kdump kernel.

Driver that export the hardware watchdog device is:
drivers/watchdog/pseries-wdt.c

[1] https://github.com/clusterlabs/sbd/blob/main/man/sbd.8.pod.in
[2] https://documentation.suse.com/sle-ha/15-SP4/html/SLE-HA-all/cha-ha-storage-protect.html

Changelog:
==========

v2:
 - Move H_WATCHDOG definitions to a common header for shared use
   across pseries code. 1/3
 - Added a new patch to handle pseries watchdog device registration
   failure. 2/3
 - Stop active watchdogs in crash hanlder. 3/3 Ritesh
 - Add suggested-by tag 1/3 & 3/3

v1:
https://lore.kernel.org/all/20260603070217.483696-1-sourabhjain@linux.ibm.com/


This issue can be reproduce using below program:
------------------------------------------------

#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <signal.h>
#include <errno.h>
#include <sys/ioctl.h>
#include <linux/watchdog.h>

#define WATCHDOG_DEV    "/dev/watchdog"
#define TIMEOUT         10
#define PET_INTERVAL    1

static int wdt_fd = -1;

static void watchdog_close(int disarm)
{
    int flags;

    if (wdt_fd < 0)
        return;

    if (disarm) {
        flags = WDIOS_DISABLECARD;
        if (ioctl(wdt_fd, WDIOC_SETOPTIONS, &flags) < 0)
            printf("WDIOS_DISABLECARD failed: %m (nowayout may be set)\n");
        else
            printf("Watchdog disabled via WDIOS_DISABLECARD\n");

        if (write(wdt_fd, "V", 1) < 0)
            printf("Magic 'V' write failed: %m\n");
        else
            printf("Magic 'V' written\n");
    } else {
        printf("Closing WITHOUT disarming - watchdog keeps running!\n");
    }

    close(wdt_fd);
    wdt_fd = -1;
    printf("Watchdog fd closed\n");
}

static void safe_exit(int sig)
{
    printf("\nSignal %d received - disarming watchdog...\n", sig);
    watchdog_close(1);
    exit(0);
}

static int watchdog_init(void)
{
    int flags, timeout = TIMEOUT;
    struct watchdog_info ident;

    printf("Opening %s...\n", WATCHDOG_DEV);
    wdt_fd = open(WATCHDOG_DEV, O_WRONLY);
    if (wdt_fd < 0) {
        printf("Failed to open %s: %m\n", WATCHDOG_DEV);
        return -1;
    }
    printf("Watchdog opened and ARMED\n");

    flags = WDIOS_ENABLECARD;
    if (ioctl(wdt_fd, WDIOC_SETOPTIONS, &flags) < 0)
        /* ENOTTY = driver always enabled, that's fine */
        printf("WDIOS_ENABLECARD: %m (ok if ENOTTY)\n");
    else
        printf("Watchdog enabled via WDIOS_ENABLECARD\n");

    if (ioctl(wdt_fd, WDIOC_SETTIMEOUT, &timeout) < 0)
        printf("WDIOC_SETTIMEOUT failed: %m\n");
    else
        printf("Timeout set to %d seconds\n", timeout);

    /* verify what the driver actually set */
    if (ioctl(wdt_fd, WDIOC_GETTIMEOUT, &timeout) == 0)
        printf("Actual timeout  : %d seconds\n", timeout);

    if (ioctl(wdt_fd, WDIOC_GETSUPPORT, &ident) == 0)
        printf("Identity        : %s\n", ident.identity);

    return 0;
}

static void watchdog_tickle(void)
{
    int timeleft = 0;

    if (ioctl(wdt_fd, WDIOC_KEEPALIVE, 0) < 0) {
        printf("WDIOC_KEEPALIVE failed: %m - falling back to write\n");
        write(wdt_fd, "1", 1);
    }

    if (ioctl(wdt_fd, WDIOC_GETTIMELEFT, &timeleft) == 0)
        printf("Petted watchdog. Timeleft: %d sec\n", timeleft);
    else
        printf("Petted watchdog.\n");
}

int main(void)
{
    signal(SIGINT,  safe_exit);
    signal(SIGTERM, safe_exit);

    if (watchdog_init() < 0)
        return 1;

    printf("\nPetting every %d seconds. Ctrl+C to safely stop.\n\n",
           PET_INTERVAL);

    while (1) {
        watchdog_tickle();
        sleep(PET_INTERVAL);
    }

    return 0;
}

Steps to reproduce the issue:
-----------------------------
1. Load kdump kernel
2. Insert pseries-wdt driver
3. Compile the above proram and run the binary
4. Crash the kernel (echo c > /proc/sysrq-trigger)

Sourabh Jain (3):
  powerpc/pseries: Move H_WATCHDOG definitions to a common header
  powerpc/pseries: Handle and log pseries-wdt registration failures
  powerpc/crash: stop watchdogs before booting kdump kernel

 arch/powerpc/include/asm/papr-watchdog.h | 60 ++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/setup.c   | 32 ++++++++++++-
 drivers/watchdog/pseries-wdt.c           | 53 +--------------------
 3 files changed, 91 insertions(+), 54 deletions(-)
 create mode 100644 arch/powerpc/include/asm/papr-watchdog.h

-- 
2.52.0


