Return-Path: <stable+bounces-211357-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNsnKWsic2mUsgAAu9opvQ
	(envelope-from <stable+bounces-211357-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 08:25:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B5D71B05
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 08:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D0B5303F7F0
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 07:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD45B344DB7;
	Fri, 23 Jan 2026 07:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LXrly4eT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CyJrJDDo"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AB833C1B9
	for <stable@vger.kernel.org>; Fri, 23 Jan 2026 07:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769152912; cv=none; b=f9v/3tIOpt9T3ivA77e2a6wBptN+itrM/9D9VQtGjOE4NasrNURbItGrBE9inl61KQ2+LkPHRz5m4A8F2eBsZG0yXOE4tiJHOEJ3zdWjq3ohvfXC7QP8qkmzyNt8itjbzwVUfCs0saFxMBVmpHjN9AdRktJPkbRpmp5j/Dnj0C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769152912; c=relaxed/simple;
	bh=+YJ7gIAYZZenwOGWdGrBji5tN7fwFoTBvFFIGDWsMZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JlWJ/YMZm+BiqVtHxH8wK3JFkcWlHXCOc/RjYp/rsV7bYsi0faM6e8kTfiaQrhIHZ0wPNPo6DQmOtEHUeC0evlJc6ZyPBc3mVU+sWG/vfeyIQumlIHpNAcQfKRvZoGH3LriAwwxvGLEqUAyeEWeFUZ2XCciFOVN3A3Vnbj4N30k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LXrly4eT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CyJrJDDo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60N6pT1R2908962
	for <stable@vger.kernel.org>; Fri, 23 Jan 2026 07:21:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=flTk6wqQyF34ooUmuS7K20Gpb4L5r6xp4Ov
	D5/jMi4E=; b=LXrly4eTkDjs0lNo6q1pARdngqoa3YDAZ6SlPRb7YOovJgM3Kz0
	eh7vJmZyZ4cOvqVbXFrxCs89mMF4wpxKZCIjCIusu0JwPLJN0IyUzevm2GZ58K9H
	iI78iWSQZXYfDoKZ5q+MmcdFwUDTS4iGbMp4MAV2WB4MmPa8DpxhiumQteC0/S3O
	kCBmw36P7wqOZ5XsvBFwsWDNbii2NzOOkqiCk7l+SzInul39EVORFMfmMXPgXZgD
	sYQzT6Trvd2bshAqcbMhjuUz5LzyaAHvE2Bn1aGqwwzceDiHrTme1sgU/84INR4E
	yG4enaBxkhDg/h4p8RYamUj+1Orp7vx8+Aw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4buvs1sk18-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 23 Jan 2026 07:21:48 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c6b4058909so428822885a.3
        for <stable@vger.kernel.org>; Thu, 22 Jan 2026 23:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769152908; x=1769757708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=flTk6wqQyF34ooUmuS7K20Gpb4L5r6xp4OvD5/jMi4E=;
        b=CyJrJDDowksCnPSPqHqa98bkTBAhJCeJym9w/cyHSR59miwAdimYahqazZpAbn3gGA
         RoXxNu50GlggDwKc4bX1mMZSX5WfEb8Jb3JEiCn7ZkFyFKgnPrRJqliAC7g38WssiOlK
         DU9blrU1jTeao5+Lh3TDfpoLdLWMpyDFw0qmPCPaQXrXJ8MK2AkJuKMJ4wPMm7uHGZ+d
         eYj3r9zMcIXwLtI/L9yBGoHCUrWQtw1IPxFD0yISLon9guipc5bizCMI8B4JKCdNjSQj
         bgNCm1ddc5zJpDtriFa3ABpVI6HKH7Ug/qXPxm9O4nQE8gs5SZ1yQKlkKbF0JkRueEC4
         xfpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769152908; x=1769757708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flTk6wqQyF34ooUmuS7K20Gpb4L5r6xp4OvD5/jMi4E=;
        b=BYS7zmKzT09cr75Quzf439APFf607Fi2KiBnWz0Ie36T6i0FqLF3Z6cU92Ybg9zJVL
         ZUKZDMzNKV5gBnEJxBdkwLQyIWaHYOP+nSzEnvByc4wJ6c0RS/PGR+ZL3Ofzv3wd0uGU
         ztAm4blc8etgpcKAvhNIBAzaShvW1O+4+0hR839JoW8oH7lO54O+fAYenKav1Nh0oloP
         mNKB+wmTla0bOf7y/uTmgePZFO9rwnVsLagEoitwq9xQpbP5rweTYzUaVReRjiztoXYe
         Dfo8EzvxBqNdY30a7uU8fearCS4S4ayODdSb9TiMelttx+EVXcD0fhvaTJyDkmm1IS3y
         JlRg==
X-Forwarded-Encrypted: i=1; AJvYcCW2UEfXYM3H/t7kf0a4jVOhzeP+85zE/gWarGycJejggXoFpOeUQ6B3peTyEtg7d++Wnga0MI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwDU7g5A/hjsIhSF1u2Z/0W0azKLFnTqb/dEC87LGk1iE93F2F
	3Yk13oIH2jDFVO86eOaYzZZxEEhAvhSHgLct2aqfVOHZtZi8X/PXKHfSgEXYG8FvtWugLS2Km88
	p0ZUwlfN4c12enMAKu99xhRZuSjOhViW0hSu9NtOfA+qZPNV2ekiATZcmhEs=
X-Gm-Gg: AZuq6aIJWXEUnmhS9Hw1JM3satIFBZNrPN5njn/mK2gmPQjVEQLsnA2wUvyDuT2HDHX
	xbIv02gZMQEZ+Fi64be58QNVq8wN0HA+A5ei2aMN+PZgHnS8fRSsAAjJ2SOXPcwcVdY22tAOvz6
	gI0pHI8+f9HX5zfPLHQ7SKPqjGy9t9/O3htxMt7+N75ZbE5MToceUCzae9neGDjaUFEs9wNniYF
	upUFO5xa5QT62DnzpAH2A/FbfFPr396IYOYBx+JEbU3SuXs0A6aDC4apHt0fZyuqy4gihUlUw+r
	NduHZbVUWZ6lG7FagiRaO1N93ufbkoTEugxIizAT1qfbLDZGKJ5fvHlmo49WeWJ+QMyN19a/z6V
	Vg0xSWQpTSnKnSN7xSAYMYmVYmg==
X-Received: by 2002:a05:620a:4147:b0:828:aff4:3c03 with SMTP id af79cd13be357-8c6e91f8a46mr29500485a.61.1769152908158;
        Thu, 22 Jan 2026 23:21:48 -0800 (PST)
X-Received: by 2002:a05:620a:4147:b0:828:aff4:3c03 with SMTP id af79cd13be357-8c6e91f8a46mr29498885a.61.1769152907672;
        Thu, 22 Jan 2026 23:21:47 -0800 (PST)
Received: from quoll ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804703b5b4sm120384785e9.5.2026.01.22.23.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 23:21:47 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        stable@vger.kernel.org
Subject: [PATCH v2] serial: Fix not set tty->port race condition
Date: Fri, 23 Jan 2026 08:21:40 +0100
Message-ID: <20260123072139.53293-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3787; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=+YJ7gIAYZZenwOGWdGrBji5tN7fwFoTBvFFIGDWsMZQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpcyGDzqKaNzZTDZaj1Ed9XLMSG1jUgz/w2LRid
 zogTwwWWpOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaXMhgwAKCRDBN2bmhouD
 1/BUD/4uY+quqaswx1lFMTXy7POTIXBH401LMS5W/3KaYPPYcE3DnLCdUbyZVfwJ//rR0tE/O1B
 1prRUa8H22KChGvaTMDlhv+Bmie5k/zlkeL5Kf71TqftgKXLFS5Ee9wc5LqpqG3VgWFJ1m42Zr3
 6zgM8WjcF5+0vYM+kdikSA229DD0t5ny443qxTFTUBomeVGLrpTmKdSiN+tapUA518jNcu6rWcy
 ckvol92w7q5WK/7IjHfP5tbc+/vAUYJ8QmXYr2ceEwPiD2lVeyWoptJMf+oPEx2hn69w//OhDXs
 e3BfBhnlpWc7sW+iBg6sGxQlpQAI5462DJltwEm2JgrdmkDthG/AElDqAL43WjS5TDOY75J3Mfa
 DVjxpBj7BL2whhSB5hu9/wzSWPmC1GxeAGg5qStLHtgRGQkLFV9T3Sdhsv87ZlZBuOS3vva20LG
 hWj+60dWP7KNaEHIbRJ9UF75n+zWGsdMaBpOGlSfoTyt4LxdYowijYutFm05yg1u/QVS9FuR0qu
 hTlfe0N+G2FbazxcStyjfPq15jplbvkjRD2bOLgpoanejWMBl+tM1E4ONoxF+d1H2MpZSDl2qV0
 iLmmDeFhlT31czEhU0pVD829OYOYiaQ6voU8ZAR8B908tj9RwMdfj3qxL9dBGgLigiKjUlLPJST FxhxeSxRCiwuBbQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 1jWmlJOxanqpnSVdxv7_jOD0RV6LCfBg
X-Proofpoint-ORIG-GUID: 1jWmlJOxanqpnSVdxv7_jOD0RV6LCfBg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDA1NSBTYWx0ZWRfX8mIaZlIBIp7K
 +2qbcxDb20+CkPDKhU/hp3OxLOgUKjh+NvDF7PygCu8YWsMdxNUXb6TSzTtzbwTGwznRC3z7/8v
 /VyeHd8BWI7+8ZwzV6xe8sLbZrSDDWHxmc9V+x2dNKk8YY2QsyfB+kOPC5uoedoXewBDJsHGukQ
 vJNYjvFecwFiv7fgdwKmf/od1jmlsIzI7ql2KpQApK2zj++ovWk8MTkLk4aTi7Ms+3nyy9dFK2u
 KTsAgFxTkBvNz4AupCJdjXNdjbp8W4g9RM8TYUK3QLvzBNvKZvppCY2o5O1ZH1VvJCansHS7tGD
 1iomPR2TUS381XnJfyJ4EA6OzQff6rGe4851kuSl3dyvNUJwp79OaeOWaX6sZV82ig6Mf3IyK7B
 CnNlvAyyr0hOr1EH/26XgDKAK7jUHPmxdQIOTgRGCgxqv15+SzCpEORI0l4cGAzciAwuRAbyD3x
 TKHCwDkiaFuSCKvlJAQ==
X-Authority-Analysis: v=2.4 cv=faSgCkQF c=1 sm=1 tr=0 ts=6973218c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=10lJyrFIdA-fwsh8KigA:9
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_06,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601230055
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211357-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 13B5D71B05
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
    |                                          ...
    |                                          tty_init_dev()
    |                                           driver->ports[idx] is NULL
    |
    tty_port_register_device_attr_serdev()
     tty_port_link_device() <- set driver->ports[idx]

Fixes: bfc467db60b7 ("serial: remove redundant tty_port_link_device()")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Changes in v2:
1. Add comment to the code.
---
 drivers/tty/serial/serial_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 9930023e924c..2805cad10511 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3074,6 +3074,12 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
 	if (uport->cons && uport->dev)
 		of_console_check(uport->dev->of_node, uport->cons->name, uport->line);
 
+	/*
+	 * TTY port has to be linked with the driver before register_console()
+	 * in uart_configure_port(), because user-space could open the console
+	 * immediately after.
+	 */
+	tty_port_link_device(port, drv->tty_driver, uport->line);
 	uart_configure_port(drv, state, uport);
 
 	port->console = uart_console(uport);
-- 
2.51.0


