Return-Path: <stable+bounces-253578-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJBzNW8hD2rPGAYAu9opvQ
	(envelope-from <stable+bounces-253578-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 17:14:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D265A817E
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 17:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 59259312368E
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 14:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361A93D5C07;
	Thu, 21 May 2026 14:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XS05NErn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Keqlwctj"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DDA3126C2
	for <stable@vger.kernel.org>; Thu, 21 May 2026 14:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373555; cv=none; b=ZRik6JRp13FLZK3QBJAMqEKm82bxYLSbU/jvLg6ndhRRiytPeay0FA7+8LLPvoW6a2rC6K8tg1KCxbWBOHhmx23L5xWs+IlUmxvmYmNazivDTSB6ZtGDYHLv+R8mOzCUmqvmMvpAguwo4aFyQ7kXIE5W1icuOo7r14hOdbmbQfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373555; c=relaxed/simple;
	bh=8lzAaweTOBR1/gQqUUXs/sDM6QW7IkiaEhZOIhrtp7o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iCkpSp9ZYrnoCbrZuH0nH2t6G8QNwE5RbVCVEP/+oscdHJloIXRwJW+ec/EM82kRU2OziWAlFntB1FCkaqUAIYqaYkRQbel/2BnmPDcqA5Q4yvzuXTIUaxr7TI0mjxnrFcIIvbg+tl/TJSsMz6ULt/a1XfoBOvgAY51962KnglI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XS05NErn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Keqlwctj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L99usv3343625
	for <stable@vger.kernel.org>; Thu, 21 May 2026 14:25:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=CuUmaIvHZSC3Udvwfr39CU
	bTusybXSEyTfz9LwKF+7M=; b=XS05NErnoS9Bz+GKHyvdrqsRDr4JqrrReHn5jG
	UoZsNZpucJUxC9RNYAngrr/Eu+0PLccxuvcsGh7C50Oh4WkhrxypFiaT/NAwHSSA
	jHCstMWG1akShvpAnJrnX0cv+LcudAeShauY7Ljow++CgHwRVtzBA7OJEFvTrLRD
	oRHg3tVG8PfaTJCBkkMZbeMi2z5ItfWVkManrk4vwDN5nzgukDxNrTmGhEsUuZB+
	hxOepYfQSzcf+uzDksbIX7cuH5P6pLP4v5/SXIvGmtAN+Z5Umf9hTP4Vl7Blvn2B
	/jT8nGAeKmM81T6pC8b3UIJ1pBgPilyO16UzP0UPrJw5B31g==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9wahsrm3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 21 May 2026 14:25:53 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-6312aa1d7adso4876468137.0
        for <stable@vger.kernel.org>; Thu, 21 May 2026 07:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779373553; x=1779978353; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CuUmaIvHZSC3Udvwfr39CUbTusybXSEyTfz9LwKF+7M=;
        b=KeqlwctjsyWCTYniePitRrrScbTdcgau/LCuHzaQFvxN63NZ+MAMdqYNd9CkkTPQur
         gyL3vAr5rJk4/wc69PVqLYHo5dpnKz3T3VXtMVMrrUx45rzzxf9crPXP0eMrOMTutxpW
         5HC9/5Zn+gAwSX+4mKF3zFUe7+SApumxj76iox6hUke/+I098t7DXZjT7f98Nh9+HtSB
         P4mpXqYXezM6yNYMUWCGawLWqnEtnhARt6SIA3om0yDnOmz4p8gP8P1XqzpXSGL6LX+S
         prqmIpJkerl0VTURUAB7SJxpcr+KmxHZjfWHARdEEC363pu8cOr9xWD/DcdpJZ4kLEy0
         nv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779373553; x=1779978353;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CuUmaIvHZSC3Udvwfr39CUbTusybXSEyTfz9LwKF+7M=;
        b=RX6DSdfp1K4komnbPtOzxIHuuNQZUobmSPIV+c3lApwgKpmP8e2aHM8wugcuLLWsuY
         zagNzYDqBN0jOnKrzyxrNJU7F63UG7BCW6NbyKBgHe+zV5ywQlitQKboc37n/ovu1ZKM
         1DLpcxaifzNcGvldvAmFTOLRWJq9zLQe23HjaGBwePTnUbENmvf1bmxti0/Mzqu3Gnte
         vt6Oy03gtg8VAA1ncZ5euSUmMiQZBhuc5w29dtS6rm/S1l9OlWdoHqz/cmUDsku881Cd
         9E1HBQxapWOxg82W5PNIGDYX5fqdObE8luprcOR1p/tsr8cSmARUqZG8JiCwjMSqkBDe
         XXKQ==
X-Forwarded-Encrypted: i=1; AFNElJ/E+iB0zoFKTpV4Uct4/wJl3oKV8IF9Sojn3aNP98pE+SuvF1bAKVR0ffMiuTNcEZTwTndOnPc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv9n/wDWvLF6WDCegjJwWLpllCwzi7BKpQYuaWR7Hz/ZxhKgc/
	az918AMoD8CDdSt7tp8jdfH8sn7ATO9Gi4TeW+we1wE9o/9A7dHojlz6yDtDkB5tgf1f+of4aez
	tGtF5iY8hyvhp0VdYMRhsPF6THNCHHe1Da8kgzb/fnata95ncbc0xMypu6nU=
X-Gm-Gg: Acq92OFFzcfu1WxXYwSCF0/XV62F1kcutsMYwWQXNy/Y+LN6XA75HVIZH0uJCVNCudu
	6DVXPb2tu22Oa/Mc4ZofhGzBL0yESxj06wCvSR2Gs64Ic/BmnoSJQynPuCoeaIHQiTgnoqQKp71
	yBCUsL6u3lC3sdkAeQiyjl1W2Tg27PoJSdNn7ch81vuuQbqbvO4XFP6zYJM30dePjTbHTyNIJ/j
	cYVhTQo1CAWA2owRc4I27PsJwTbfgSVWdMnk8f2Ne1hmzFL6YRv0PtQ4zfoUfP1MVGiF+BJ8a7v
	0Raq1rInDg7j2eVGIpq/ahlE1m/ZKi7MBSi4fFnqZtAVWKgiWaJ/uHxvKdlMghsO2qtL5OKGw83
	ED9tqKcGFkxRv6hkOZ1U8zjBNW9i3RYv3hWxduyh8ihzO96yTubY=
X-Received: by 2002:a05:6102:3fa6:b0:66b:a0d7:abc4 with SMTP id ada2fe7eead31-6737b27fe6amr1936403137.0.1779373552520;
        Thu, 21 May 2026 07:25:52 -0700 (PDT)
X-Received: by 2002:a05:6102:3fa6:b0:66b:a0d7:abc4 with SMTP id ada2fe7eead31-6737b27fe6amr1936333137.0.1779373552008;
        Thu, 21 May 2026 07:25:52 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bb10:ae82:b7c3:d15a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4903c9abbadsm30441925e9.8.2026.05.21.07.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 07:25:51 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v4 00/10] nvmem: rework nvmem core and allow unbinding with
 active consumers
Date: Thu, 21 May 2026 16:25:33 +0200
Message-Id: <20260521-nvmem-unbind-v4-0-7fa136759491@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN0VD2oC/3XM3wqCMBTH8VeJXTfZzpl/1lXvEV1sOnOQs1yOQ
 nz3phCS1M2B74HfZyTe9NZ4ctiNpDfBetu5GGK/I2Wj3MVQW8UmwCBjnAvqQmtaOjhtXUWzHHU
 KdVkIxUic3HpT2+fCnc6xG+sfXf9a9MDn7wfKvqHAKaO51oJxpblUxbHzPrkP6lp2bZvEQ2Yvw
 GoA4MaAaLCqRlQSsSrVHwNXQ4DcGBgNUJkUtUxRpvqHMU3TG67uhes3AQAA
X-Change-ID: 20260114-nvmem-unbind-673b52fc84a0
To: Srinivas Kandagatla <srini@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>, Johan Hovold <johan@kernel.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4097;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=8lzAaweTOBR1/gQqUUXs/sDM6QW7IkiaEhZOIhrtp7o=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqDxXjfYjL4fZsgGfnZdQs0plThAVVOzed33P5y
 4heS69kULqJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCag8V4wAKCRAFnS7L/zaE
 w8WpEACc1XeQ7qA6gmARMTAjOR6UylCwo0elFRlfYd07AeId3po7O3kQh1ZfJALQuudPb0eadHx
 dEb7k0hNma6JmFDCC6sWZBY8Y3S9HcvjdYhqm0F81X0XTH31SQ5MTDXMS3g9oNqyC69JS0LvVjN
 MyRO6rX6Rpqd8rjRN0179IS1GqlpxJ5fZZ9eMO0yntBe8QzlP4jmQq9x4QI0CeOCQZueCxZ54AB
 PXnRv7i1/rQGoifmX2nqNJYqH+lTyT0EP3Kv1M1esKwOKd3Nxh7j7pwVLby+sLVPFQrGcKmJeEH
 d4G1ZiUADKQKaeDjsHpoxizCbLQpPaCMGUJVAZbooGYZw+cs/Jq/zr2brsjRwZ74tOBSZbGDJNZ
 k3FVY1mQG2/8geI0qOiOjoIiz5D8/BSYMAcmjAkQFYd8XsxPp0UNBl0CruyLAoyhBhgEBGwcY8H
 nj/UC5v340CSV/8e2AXbrDwBG20CDAtBZZbHZaJBOxPuNbmF+xU2dED7LnPMevMp3IdAS7GFsLn
 vsk8laNg07zG+5skAmF0GdOzkPFb80yOdk/8JP3qOY7Qw3QS/gm2e2HoYpjcHnp2EdC0G2R697K
 pNkAlPd/dR6Kp06CWYSdqJXqQMDVAtNfU83DdwwJN+AyfLb9QRkvs39xbLaBdKM47krUgqReg9T
 +jKJUVOq04C9F9w==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE0NCBTYWx0ZWRfX8jrnpaZm0423
 Ew0fzgsxXqSfvRo7q/xFyieaFpQJKbK2NMux2GXddrOXosDOrvIFtaIPPuf3V8EypihCXr81/XB
 X4tcvwKopfWzcHMQWWs0pyoHH0kHfniqyxlUepYl1bzgzRXoQ0FhHMbp56BlrLr018tYOpWpdW/
 +4TKkrDxMNL0NzgoApm2XM1QXQN8saVLFue9urJdpe2ZaN/DJno1Q115hd0l3yecffEbe7q9v7D
 6wJl1VPRVhNoj+ULXQgx1t3VC0Hob9Qv7wbusGkBvz2dWADaocNYSpKsZMdkD9Yd2R3fVrPi7tq
 x8pwz/V4HEW2WstyMZI3Tv0wdV6YgC3lgV1ZIYxfCoUAoX/MUhjEO+SkxUUVxEm7yqIyqyBq/pU
 qgssPLn+0QcAKj04Zq7deN9sKkDUrSh8XZM/yekrUf2zRRHwPhWJ+jFfSG339pgqKtzFZnEiVX4
 R8Ul0x+cQ5h+z0IZY1w==
X-Proofpoint-ORIG-GUID: 33lybDPnSbw1uk6Ga7H5BYfsVWJUa0Iq
X-Proofpoint-GUID: 33lybDPnSbw1uk6Ga7H5BYfsVWJUa0Iq
X-Authority-Analysis: v=2.4 cv=H8LrBeYi c=1 sm=1 tr=0 ts=6a0f15f1 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=L2BAdSLxVfnVBQOZ-uAA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210144
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,msgid.link:url];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253578-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 74D265A817E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sashiko pointed out some issues so this iteration fixes them. I'm also
Cc'ing Loic who seems to have encountered the issue of unbinding with
active consumers when working on the block nvmem provider.

Nvmem is one of the subsystems vulnerable to object life-time issues.
The memory nvmem core dereferences is owned by nvmem providers which can
be unbound at any time and even though nvmem devices themselves are
reference-counted, there's no synchronization with the provider modules.

This typically is not a problem because thanks to fw_devlink, consumers
get synchronously unbound before providers but it's enough to pass
fw_devlink=off over the command line, unbind the nvmem controller with
consumers still holding references to it and try to read/write in order
to see fireworks in the kernel log.

User-space can trigger it too if a device (for instance: i2c eeprom on a
cp2112 USB expander) is unplugged halfway through a long read.

This series proposes to use SRCU to protect nvmem against accessing
invalid memory after unbinding with active consumers and also reworks
several places in nvmem core.

The first patch is a fix that should land in v7.1, the rest is v7.2
material.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Changes in v4:
- Restore the removed checks for the existence of reg_write/reg_read
  ops in sysfs callbacks as the attributes may be created with only a
  single operation available
- Fix potential use-after-free when decrementing the references to nvmem
  device
- Rename some local variables to better indicate their function
- Initialize the cell list before calling device_initialize() as we
  iterate over it in release path unconditionally
- Restore the nvmem != NULL check in nvmem_unregister() as sashiko
  pointed out there are users who rely on this API contract
- Don't use rcu_dereference() with SRCU as it may trigger a
  false-positive lockdep alert
- Synchronize the removal of nvmem->ops in error path in
  nvmem_register() as it's possible for it to be made available to the
  system before a subsequent failure later in the function
- Link to v3: https://patch.msgid.link/20260429-nvmem-unbind-v3-0-2a694f95395b@oss.qualcomm.com

Changes in v3:
- Add Fixes tag to patch 1
- Don't check the presence of read/write callbacks in sysfs attributes
  as these are not visible without them
- Rework mutex guards and drop unneeded helper variables
- Fix mutex guard conversion: it accidentally converted nvmem_lookup_mutex
  locks to nvmem_mutex
- Extend patch 5 to also rename __nvmem_device_get() to
  nvmem_device_match()
- Call nvmem_sysfs_remove_compat() on unregister, not release
- Split patch 7 into two: one removing the redundant kref and second
  adding SRCU
- Link to v2: https://patch.msgid.link/20260223-nvmem-unbind-v2-0-0df33a933dca@oss.qualcomm.com

Changes in v2:
- add missing SRCU struct cleanup
- improve the teardown path on error in nvmem_register()
- Link to v1: https://lore.kernel.org/r/20260116-nvmem-unbind-v1-0-7bb401ab19a8@oss.qualcomm.com

---
Bartosz Golaszewski (10):
      nvmem: core: fix use-after-free bugs in error paths
      nvmem: remove unused field from struct nvmem_device
      nvmem: return -EOPNOTSUPP to in-kernel users on missing callbacks
      nvmem: check the return value of gpiod_set_value_cansleep()
      nvmem: simplify locking with guard()
      nvmem: remove unneeded __nvmem_device_put()
      nvmem: split out the reg_read/write() callbacks out of struct nvmem_device
      nvmem: simplify nvmem_sysfs_remove_compat()
      nvmem: remove duplicated reference counting
      nvmem: protect nvmem_device::ops with SRCU

 drivers/nvmem/core.c      | 319 ++++++++++++++++++++++++----------------------
 drivers/nvmem/internals.h |  13 +-
 2 files changed, 178 insertions(+), 154 deletions(-)
---
base-commit: 7d9ebe5c8b1bd9f6ae73b47929761cd9a6287407
change-id: 20260114-nvmem-unbind-673b52fc84a0

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>


