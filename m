Return-Path: <stable+bounces-211263-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHauAghmcmmrjwAAu9opvQ
	(envelope-from <stable+bounces-211263-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 19:01:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A97CB6BDF0
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 19:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9611C3146CFE
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 17:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CEB3793AE;
	Thu, 22 Jan 2026 17:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eh+9t+jy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fxAh6VRn"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4942C11C6
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 17:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769101254; cv=none; b=tmQdeaqY5TAJ8gAhN9qBHc0CFumfaRmfQfAixfk7wttBWCmmPSm77cPZ+i1iqxCaGaUj+KbbfUeQo5OQbm4Cwig8MrSjtQLn40UfsKF6cS/dslXl9GN+iYRAeB6Qutr5R4j7Dhm/b1ShiEdW6uWYXe7/7PUisswkC+9n+f7cgn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769101254; c=relaxed/simple;
	bh=SYQnDRy3gXye1n8xw6IAVS14uNbovqYrq5pQMsKusI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yq/EWl2bloaoX3x7mB+5XE6PT8cLEfk2aqaUM+Lpje/MrLEIYruIXXw6SrRFjR4eZ156UbHwxaKHNYHjz0hKjtNIHMIZgsoDlsPMqcl4fAJpmPpFxMXsrewg+tZ1jUc98oWMTLZJrWfwLH4Pe9iVoNCVzBb+6MBP8SG12vYJlFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eh+9t+jy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fxAh6VRn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60MG4oD82582598
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 17:00:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=2N6/IDHinoRDWXKmcT4CHhXv5X0fnjd64DC
	/fRTaml0=; b=eh+9t+jyoIXr+ztOK1/m8ShMiJZ2Ye62mt5D5BDMoYIjCdWn6RW
	t39bPS5tF+AlTr6YBRcbNRQudKMBA24Qix5gh1sJmPrOz8Q9RDDUiOUEfSHNc5Dk
	tlkjb6pKkvOsAV6v57rqm//ByBMSLiDatdKPIUf4N9okVVoP6RKvg2ZQihSgrTm9
	ewOe6TdswbZFNp1bFpjLSc7zg+9vFdisAC1huU+BYiEgSOYLXW1HDB+eL3VnQSKn
	VCmRWN1K8wN7bxUWcypBTDMoDa/Tk23U6Jood5g4mGwVNAe5Dv3CcYXNQKialxzS
	K7h9zlb9aTS7umYQpzuau9iPDfHXlyck0RA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4buq3g892w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 17:00:39 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8ba026720eeso362595785a.1
        for <stable@vger.kernel.org>; Thu, 22 Jan 2026 09:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769101239; x=1769706039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2N6/IDHinoRDWXKmcT4CHhXv5X0fnjd64DC/fRTaml0=;
        b=fxAh6VRnfySKY6jszSJGDi4MkXh1kCFrEIqhABFtAVHTuDDoswWXSCFiBvU8UHkwX5
         o69P4x3D/oV89bxyQcYPTQRIZqm2hz9mnm/Y0v9xYXMzXfQIyj/FYBdncxsirMTqTdsp
         22YmUOWgYF3af9o+49BuvUvQS3Pc9ySAIK68ZeYGLIlNhFXIej0/gJgL003vPqee8Eh9
         sH9XVDQNpj3Ahr7UkukklcQ8bvke3sLazfyjTWQ11n0Br0QOS3uTPphHI6vZRacgylgB
         IL7BPTAX4h2rTGGQJ09CuBfZ7WqKVppNr86frKp0DKWGszaVz80i0t8GjbRaf1TDQTL9
         0scg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769101239; x=1769706039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2N6/IDHinoRDWXKmcT4CHhXv5X0fnjd64DC/fRTaml0=;
        b=TANyfbp6FKoDFKuMh7ECpeoIX7QvHG1bFjpLGzDZP2EtsD4TtG4TP0XlDEAx6AdUBD
         9eInIvjbJVpFDqcgWJ8/ARo+c1y/jArw1LcQNn3VhJNHW0idOk33VbzfI/4oomSH1M8R
         yWA+PHwJdcTNxkeqDB/ykiW9pm+OdZwjKa47uk9Ai78mzr2C6STQxOyy95w2fBfHwQfu
         0XUjkHM69V3o7yh5IAY2dQwAUNLmdjhFgfhX1U9yP7b4fgllWWnk3BtLKCIUACbSRYGC
         iOmm36UqzJh0JrcGxcK1Y8cVP4jfEmtymNL2kbeZrmoYppQWNWa7CdA+xPZMVTAWUpf8
         HRIA==
X-Forwarded-Encrypted: i=1; AJvYcCWz5zcIvFkPbleFRyQc341k6PHUWZFjmQUkwD97sPV+pb1cqrO8L5wHEv3nIM/KOJrihOreTUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmaqxcUEF/lImmgZqUVsq2uGr6eF9wC/o12elBu7RIMsuT+oSU
	vcA92UyoBVTAjtaKtSqktoPeOvY5d+4ef1Pug2I3RyalLopWn2zpNUtstcFFymNQywMis8hxkWU
	c+CpJf1pMu4oOD8S3DSi0csLTTxWs+EHWmDDh8s6vpwqoNfj2bpWQuBSoIMk=
X-Gm-Gg: AZuq6aJ/il0jAuU3shhEco5WJWmznng4GEwVlV0o6B11sOzQex1QBiEOqRBiP1YxTSJ
	9jWifu1+5N/TET9fVk4Tk7lJ4Hi3H6MB0TnitXKp7jw99sSJHUnoyvwmtrA2zU61Ayyi2nNdFlz
	3T41yOy5aCSzIXP2K5TCaNYOD+i9+xsViwhMkJiuHBQ4j6h5MnLvNCqIH5ExJ2WwIixAmQXVMkP
	khKFpEAFbCMZzU8Sm+JSuqT419EqUSYy4cdfSmBiWsujC8PF14XFNFgFSxJjlSwc4EiDJXGcavN
	QGmY1akMAzzvqWA4vqHvuIFcABC2egOLGZOdpK9KSEN2DS55nV5Xw0f7HDwut9twsfVWrHxJKsu
	+7Fi98UnUdgr/s5cGtGGii7nMaQ==
X-Received: by 2002:a05:620a:454d:b0:8b2:6b9e:5396 with SMTP id af79cd13be357-8c6e2e4c8abmr8930685a.83.1769101238552;
        Thu, 22 Jan 2026 09:00:38 -0800 (PST)
X-Received: by 2002:a05:620a:454d:b0:8b2:6b9e:5396 with SMTP id af79cd13be357-8c6e2e4c8abmr8916285a.83.1769101237537;
        Thu, 22 Jan 2026 09:00:37 -0800 (PST)
Received: from quoll ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d26a91fsm578165e9.2.2026.01.22.09.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 09:00:36 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        stable@vger.kernel.org
Subject: [PATCH] serial: Fix not set tty->port race condition
Date: Thu, 22 Jan 2026 18:00:32 +0100
Message-ID: <20260122170031.433724-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3536; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=SYQnDRy3gXye1n8xw6IAVS14uNbovqYrq5pQMsKusI4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpclev9cxxgZkXsMxsURilU3jXG5Z15qh8tFH8r
 BurBi4FwJeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaXJXrwAKCRDBN2bmhouD
 15YVEACPEgsrQyYmGt5uibl1LL0ijwt7jnSAoHiI64wWhYYwcYSLWR8wROlbnqnTx9GXX0/rJw6
 ATM9QQ2xIMwO1y5r38utI/+TwE8VDP+me3XbOUBoc2JEmOxtfXYLpEGM5q8smw7wz+jHNPkR+fa
 Vis5yZRwvcHvNcYMCFIl2ENlfGpVKxg7hKSQb4x2sZmtNCNnMnmQk2KAB3zlrNsB0y1znrYjmL9
 YKVxtZ60eoQhbR2IMvg5RqnNX5u+bcVUMaqpeGqDmUAiLvN8oRA87CIzTbiS9npcq/5UyIiX1cd
 GXgbSgCuyCkr22p9Bn045Sk8VUW+PzyHMHKHynHqzkJziDC5NRZot3fJ7jpSeOAzyZ0fhqi+taI
 hrClK7cHMtuNM5hm/+sKTgx2ABAqvgPhL2fLwhDBApII4FSwghzxjC/523tBTbyivzwFHUXru2w
 sHCy96cCBZfA8POcMHxn4RATatunEo6AsGK7Ur5HwSdee+1OoQVf8EBL6GXQenpztWMUj7lcfP1
 aoKIUPPdJdijFJmEDvhVeYokq+Eqp7+B3aueKM/q94xsutLkZyb/wkVvLxA2BSQnceX9JIK2BZW
 JYv69gkXFzrqMswNsLOdZY8LpaKhLvvZsab9WqnY4Bp3iGIXRDmhKA9yLUE/4smw7ww7W0fmknb CgRu0hjNCxAnfGA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=I9Johdgg c=1 sm=1 tr=0 ts=697257b7 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=10lJyrFIdA-fwsh8KigA:9
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDEyOCBTYWx0ZWRfX1194gxIehEEE
 /X1dP+2l31rbJLqwbBG7lIRd/OLfqezzj9dTsfOyQx/cSgp/pXVuAgV5tcQ4pAZ011fpl7sQu32
 aZd52Ix0xb28B9nHiM0FvLUAdIxK3KHENhCgumpMMg/YMgoxI5ZDxQEYd1MJUOOw4U5LvjPhJ7Z
 7v2YqKnLx76oBO50HVcbYCql2t9vRjwFyYJW6zxaRL9Vjss5JVuc2TOR2LkSNNB2muIVEbEem7A
 vPxaal7WLMfBMizv/wzS+ULZu/vmEgAtTSy3u+FkPhcDR955LLqhsJWSx1QWrkufXUspTvVquoS
 HJPbuiNTXeuuUAPWJ8IyQaXn/CMxHBPPLkGnb4yoRHrIBTSDq5o0BmXH9RYlHq0QZtfhX3W5cIu
 iDVfs1OwZn/te+PqGPGnws2i3sIOLTbS3Yivnqc/5jsy8FcyIMMGSICS/APq+dF1PqbZNhLAp03
 4uwvATIEfu8e5YmgBwg==
X-Proofpoint-GUID: lw7Og5U9n5rtxT7PBOjbP_q5jF13HKUD
X-Proofpoint-ORIG-GUID: lw7Og5U9n5rtxT7PBOjbP_q5jF13HKUD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_03,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601220128
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211263-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A97CB6BDF0
X-Rspamd-Action: no action

Revert commit bfc467db60b7 ("serial: remove redundant
tty_port_link_device()") because the tty_port_link_device() is not
redundant: the tty->port has to be confured before we call
uart_configure_port(), otherwise user-space can open console without TTY
linked to the driver.

This tty_port_link_device() was added explicitly to avoid this exact
issue in commit fb2b90014d78 ("tty: link tty and port before configuring
it as console"), so offending commit basically reverted the fix saying
it is redundant without addressing the actual race condition presented
there.

Reproducible always as tty->port warning on Qualcomm SoC with most of
devices disabled, so with very fast boot, and one serial device being
the console:

  printk: legacy console [ttyMSM0] enabled
  printk: legacy console [ttyMSM0] enabled
  printk: legacy bootconsole [qcom_geni0] disabled
  printk: legacy bootconsole [qcom_geni0] disabled
  ------------[ cut here ]------------
  tty_init_dev: ttyMSM driver does not set tty->port. This would crash the kernel. Fix the driver!
  WARNING: drivers/tty/tty_io.c:1414 at tty_init_dev.part.0+0x228/0x25c, CPU#2: systemd/1
  Modules linked in: socinfo tcsrcc_eliza gcc_eliza sm3_ce fuse ipv6
  CPU: 2 UID: 0 PID: 1 Comm: systemd Tainted: G S                  6.19.0-rc4-next-20260108-00024-g2202f4d30aa8 #73 PREEMPT
  Tainted: [S]=CPU_OUT_OF_SPEC
  Hardware name: Qualcomm Technologies, Inc. Eliza (DT)
  ...
  tty_init_dev.part.0 (drivers/tty/tty_io.c:1414 (discriminator 11)) (P)
  tty_open (arch/arm64/include/asm/atomic_ll_sc.h:95 (discriminator 3) drivers/tty/tty_io.c:2073 (discriminator 3) drivers/tty/tty_io.c:2120 (discriminator 3))
  chrdev_open (fs/char_dev.c:411)
  do_dentry_open (fs/open.c:962)
  vfs_open (fs/open.c:1094)
  do_open (fs/namei.c:4634)
  path_openat (fs/namei.c:4793)
  do_filp_open (fs/namei.c:4820)
  do_sys_openat2 (fs/open.c:1391 (discriminator 3))
  ...
  Starting Network Name Resolution...

Apparently the flow with this small Yocto-based ramdisk user-space is:

driver (qcom_geni_serial.c):                  user-space:
============================                  ===========
qcom_geni_serial_probe()
 uart_add_one_port()
  serial_core_register_port()
   serial_core_add_one_port()
    uart_configure_port()
     register_console()
    |
    |                                         open console
    |                                         ...
    |                                         tty_init_dev()
    |                                         driver->ports[idx] is NULL
    |
    tty_port_register_device_attr_serdev()
     tty_port_link_device() <- set driver->ports[idx]

Fixes: bfc467db60b7 ("serial: remove redundant tty_port_link_device()")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/tty/serial/serial_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 0534b2eb1682..116f33f0643f 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3077,6 +3077,7 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
 	if (uport->cons && uport->dev)
 		of_console_check(uport->dev->of_node, uport->cons->name, uport->line);
 
+	tty_port_link_device(port, drv->tty_driver, uport->line);
 	uart_configure_port(drv, state, uport);
 
 	port->console = uart_console(uport);
-- 
2.51.0


