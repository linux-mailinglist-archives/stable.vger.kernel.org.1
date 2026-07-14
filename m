Return-Path: <stable+bounces-274594-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PPtaNRDFVmoMBAEAu9opvQ
	(envelope-from <stable+bounces-274594-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 01:24:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 563B3759666
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 01:24:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=KHRqBIpy;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274594-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-274594-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE21D3134130
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 23:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA8543F8AB;
	Tue, 14 Jul 2026 23:22:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF4D432E65;
	Tue, 14 Jul 2026 23:22:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784071341; cv=none; b=CxlZ3uWAjAJRQGenpEsx95B7+uApuAX22dfjrPKyKumQNv7MGPsHbQdEwbk/ORnWSVCgFTw3KwpPP7OpHb2Ui+zHFgh7XSppxbZaJ4YKQrRJf19u0AU0HRSWUvCSwcaMZcuDyqNPte6+CkzvsBSq7NhFCGIJ+O5DBDTR14DEqbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784071341; c=relaxed/simple;
	bh=+dQJHwcpPhcQ39+zN0yn2WjwZnnTaOfmxyTXqx8SwUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Om+20CqTPch7h2SPoo00ulBRooeDB7RM275mcNeePXirAxkWFPUK1xMUAuxA6G66KjV8hueamvkkhCt11wWuDWl/pod71qZkwsUNpMVN/+7oic1pJrsy8o+bjF7V9b9EyaSBGNT6VsCR4Ofps+SDZJTvhjTw7h31lOD7jjiHS2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KHRqBIpy; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EJCVRq2113614;
	Tue, 14 Jul 2026 23:22:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qSxpN/yHz7NAbOad3
	2x3gCAAoTw5b1MeWiMwtVjtpTM=; b=KHRqBIpyUAOIhBiRvSXH2HmjudFhE19FA
	Fxwjdu3TdJWot9wDUZySyQ3kXJ60e90maAG2NolCRwdx7AyejG0UNvDS9X17nWpQ
	M+SaLjXxj8ferIIV4MGUOozi4WYtaNha3vsdpeQzNxrHIRrJwBiY4rJ4yJ5GgHz5
	Kz0EaOHT6DUe9EkcMq+An/cPcQu4Jq8vd9v7OI1VfDAySJBLeB4kyjYgqUjL/BXG
	EEfYDvsLlHN5PfuPafum3eQD10zwJ0EgPWWzZQbrDYmg5/jeSOXzjMym9W8FBcNd
	isR1O+qqaaw6lrELEryR01wkmrpslahLvu2b6ezhVcaD1JBYSVHQw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbexwr556-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 23:22:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ENJevW000363;
	Tue, 14 Jul 2026 23:22:16 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nhd3nr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 23:22:16 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66ENMClE52035952
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 23:22:12 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A293A20040;
	Tue, 14 Jul 2026 23:22:12 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7675D20043;
	Tue, 14 Jul 2026 23:22:12 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 14 Jul 2026 23:22:12 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 3BDC61626B7; Wed, 15 Jul 2026 01:22:12 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>, stable@vger.kernel.org,
        Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v1 5/6] s390/vfio_ccw: ensure index for read/write regions are within range
Date: Wed, 15 Jul 2026 01:22:07 +0200
Message-ID: <20260714232208.1683788-6-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714232208.1683788-1-farman@linux.ibm.com>
References: <20260714232208.1683788-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2KxYvocmsUQiSVpWZibSJYXIgp5dNyOc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDI0MCBTYWx0ZWRfXzwe7zvYYLdgY
 YXBLd31mK7iJi9VqjwSQtz8BNwZCCRi+A7mSFNr5IDZ+DSS773CRwJo3URyTWgSvB6wGIwTw6fc
 KWM/63eu9gKhxina63N0rn10Rxw/2FBvkxIzA3dABtIyUQ/iy50VWyG3M0R3mXUk40i4ybGaszv
 6odwvVKL4y7+ZlI5tlFeTFMQh2puTkABwJzuUpCuWXEiIJv3oayLNV7yozG3ft/VMut0q6s+IgO
 Jt9SWn4g5PdOf4ObmVJNmNWchrOuST66toyWvHpXqOy0amjBtBUloQeogQwTGV8AMqKgVuTc/T7
 2Kaz/ukjoUamD47TqZhmJbmOkC7s8Nsyk4FZYJUJm5GScLaY/477JIPfE9HC36jVE+4kUx7jm+l
 PiHxlkrnSx2hbIG0b0LXH43sR+TwwyI6QJIROYyoCkCc/fi+WxsT1Xg5crDwCGfcA6QtNVbdDQw
 2qpgy71lHj+++vGRaLw==
X-Authority-Analysis: v=2.4 cv=XJoAjwhE c=1 sm=1 tr=0 ts=6a56c4a9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=0bsjUvYyXMjrvzAobP8A:9
X-Proofpoint-ORIG-GUID: 2KxYvocmsUQiSVpWZibSJYXIgp5dNyOc
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDI0MCBTYWx0ZWRfX4aux7ccCGEFK
 wMYMNzGcqqX0EKuV0dPd9hurOXRdL78tC93jjIdHksXsVXCM/Liy/TM6bTyi+8faqMFQDz7Ixwr
 HXBpoE40VeEQqUiJh3Fg5SodwDM84NE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_05,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1011 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140240
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274594-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-s390@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mjrosato@linux.ibm.com,m:pasic@linux.ibm.com,m:borntraeger@linux.ibm.com,m:farman@linux.ibm.com,m:stable@vger.kernel.org,m:cohuck@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[farman@linux.ibm.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[farman@linux.ibm.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.ibm.com:from_mime,linux.ibm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 563B3759666

The introduction of the capability chain rightly clamped the
region indexes to the range of the capabilities itself, but
neglected to do so for the existing read/write regions which
should also be enforced.

Fixes: db8e5d17ac03 ("vfio-ccw: add capabilities chain")
Cc: stable@vger.kernel.org
Cc: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_ops.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_=
ops.c
index afe9448c165e..63cf5850bd50 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -245,6 +245,8 @@ static ssize_t vfio_ccw_mdev_read(struct vfio_device =
*vdev,
 	if (index >=3D VFIO_CCW_NUM_REGIONS + private->num_regions)
 		return -EINVAL;
=20
+	index =3D array_index_nospec(index, VFIO_CCW_NUM_REGIONS + private->num=
_regions);
+
 	switch (index) {
 	case VFIO_CCW_CONFIG_REGION_INDEX:
 		return vfio_ccw_mdev_read_io_region(private, buf, count, ppos);
@@ -297,6 +299,8 @@ static ssize_t vfio_ccw_mdev_write(struct vfio_device=
 *vdev,
 	if (index >=3D VFIO_CCW_NUM_REGIONS + private->num_regions)
 		return -EINVAL;
=20
+	index =3D array_index_nospec(index, VFIO_CCW_NUM_REGIONS + private->num=
_regions);
+
 	switch (index) {
 	case VFIO_CCW_CONFIG_REGION_INDEX:
 		return vfio_ccw_mdev_write_io_region(private, buf, count, ppos);
--=20
2.53.0


