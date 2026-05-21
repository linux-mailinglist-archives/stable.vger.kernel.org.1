Return-Path: <stable+bounces-253576-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iC7lIo0gD2pSGAYAu9opvQ
	(envelope-from <stable+bounces-253576-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 17:11:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9615A8029
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 17:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B3DC43094B32
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 14:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3947A3DB301;
	Thu, 21 May 2026 14:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kRFjpJA5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Fv17U/tO"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682E73D75C5
	for <stable@vger.kernel.org>; Thu, 21 May 2026 14:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373329; cv=none; b=MGbQHGUzqHK6fo3ZjW2v67f4ziiP8ul3C5gZZkYThRUOmLwPIGMY12uW6AeosivlRWoiECHcl+UE1cMVQpJ6j5d5PAqpBo+8Wlwj523t6jxnmuwzOoHsd+AB/j/kPHeG4B0iAYBv4awQmCnlH7RlqdfquDvohq6oX1RLmenKNbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373329; c=relaxed/simple;
	bh=1rat9CVwl4Niea8fgGERMdP4TdfM0tYDE6ELOJ13qUk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fslL0nY7CsEuX+RxPB23GVCSyZV+dbarSVd+N7R8Cy3uhtvFlehdn/RGVKBCvoa4cmMJF4n4qRWOpE9H06s/mSgMqa37N2Ogm/bw73iPfZExsDeSxaEBWJablVQsCWEiil2Tv5gMTj8+R6UufkliZno0NhZI1UvFJiOpa5Hl/x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kRFjpJA5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Fv17U/tO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L99o4t3118973
	for <stable@vger.kernel.org>; Thu, 21 May 2026 14:22:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=tjQZHonofPoPkduzjXR9qz
	XB3BrD17EPQfqK72P+4m8=; b=kRFjpJA5a6oyulsn8g2fmcZsdMJhEKJcP6hjv9
	DzKSSKwnQ7/GCiUyLbMOp5pnATbPKk+iRtkT7Dpee49B9HvheWLGRSNSDora7zzy
	/vnkqN5CGqw+X11pAMotMBe4izG5L/Nd3fRw2qL2JXWCWw1I7hgjpMx9xUkT1m0f
	Buzt45Br+tZOlFcfPp+cRYw4fgx2nDH6CdcO2BlYLTrpW4Revjt90Jx99ztw1R3l
	tvFrM4sXhh0t2ChNCqH6XFI7av/1+HgU0eeYL8Bx4gpP3lQigIvdQIX5L0X73LM/
	wK6IoI0yPCBR3Z+R6QFDlbSDe4Yl+fEeO1Zy2nL/ZzTOuUnw==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9r962vfx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 21 May 2026 14:22:07 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-47018d3424fso11964828b6e.2
        for <stable@vger.kernel.org>; Thu, 21 May 2026 07:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779373327; x=1779978127; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tjQZHonofPoPkduzjXR9qzXB3BrD17EPQfqK72P+4m8=;
        b=Fv17U/tOpLvR58NoUjLGGJmrIiH29fthXKQL0Ufnfq+wuayW+Wxgc9p6VBi5vKNFkg
         mMWSufx4yxPjjhF4LCJre74pnND15K18v4n4+usSI5UybLUk3iexTEg56elfEGYkB/Tt
         2/GEhnzbz53qsEKsBzyIKoksGjd/fn1oeICy/Op+xG8E68jyC4gm7skPQcZHdSstnNJr
         DsbK4v96h0VNGSEzfHhsatMRE4vVR60hkhJ5qDl0F6/kPUrUP9HKhQLeuQAuzgCSJcST
         JkqR1sePw476qWlpYqfAyKsMd1MSYlkj2w2Y7n3/9Mli+9MdFwMvPO1FJ2Keo67TPIm6
         BiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779373327; x=1779978127;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjQZHonofPoPkduzjXR9qzXB3BrD17EPQfqK72P+4m8=;
        b=YHG8n8tNCyvBIibBXWwkU/M3a+CW3Q4EAxt3TC3FGCL7nQUM3KwEMu8LSDqdSj1YRs
         ZizgFvE6tM0s7vdokVfnQZNKS16SGa7qxKNREk5GrCYw2ZCM6LEGWVJcvunHYlPCTS2M
         s7SlLb3bbP12Iyi8cUlDi3G9WLGQkKkd5BnRvn0nfmCgGVj2Mxu6gUu8L5YNd8KrLvgX
         wfK2u5eTULhSFPaMwMLnd/HiqKWI+PjGIAc2KXhQ1mAnAQVu+/c/nnd6eONKZpY0omuM
         iOxqWs5lk0RS84ASJ6R3hEDwbMy3ycmwClD7v4UPDmM4v3sxUV0v7TAhT5eXaaPRmXc1
         pp5Q==
X-Forwarded-Encrypted: i=1; AFNElJ8q+R5DfZ3lQSqAWkT8IGHuC0bzq5QoewAdorb4dv9oVC43Yg4Ib5rz1cWv634C3EI+ox6WUEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOXTnHQartBRdJJJYuOkoY4uA/gOe3gMzWJWNjUn4+q8/2RRXY
	a7hkBkbEKCI4PNBoX5PVRvct76A/Cuj/+tqNJZgbpyBgApGE1EgOz7hbW+M8UvEc+3ewr5CTxkE
	0B0LY8nin881dlyWFg9Z7t65eZRANoJki3h97tdLFH6u5IP914uDz/40J1yE=
X-Gm-Gg: Acq92OGByk3TNAfuxJTSwJYPI1IilF1V3OHyVAgtlG/k/f8p9RMXlemtB5FPb8oX9BO
	AsNQKCyYjjww7QIgsiTCzoMQ+YCHCAvEim/+BueYW/MOEUwac6BIvbRAII+hJQx1J86abbTnmfp
	pX8V2aK1VEOzZgW/i/ImWoU7OOK0kkwm1OPgIRMlE6m8rqX1IXZm4iUmoCeiQfQbWUVUwG91ZqX
	CBblM07ksjNW0UWw8N//GuAtcIT5Bx+rILi/+hEnJKOr6rePmGo4FtZBMBWbKq+sJRm3BPqoZ4S
	PJeDoq22bEX32i18thed9+rHY/39QAZOPXrU0yeV64FtFJN7R0LTg7bFqPrVBhY0jNhKUFZkKF3
	0V6Dh/cYbrDlN/kaIiHoMpwy3Kogaig7rVya/yKcgmtRim1Id738=
X-Received: by 2002:a05:6809:1d3:10b0:485:403d:9b92 with SMTP id 5614622812f47-485403da2ebmr483401b6e.22.1779373326643;
        Thu, 21 May 2026 07:22:06 -0700 (PDT)
X-Received: by 2002:a05:6809:1d3:10b0:485:403d:9b92 with SMTP id 5614622812f47-485403da2ebmr483328b6e.22.1779373325408;
        Thu, 21 May 2026 07:22:05 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bb10:ae82:b7c3:d15a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49033d3515asm77835655e9.1.2026.05.21.07.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 07:22:04 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 21 May 2026 16:21:55 +0200
Subject: [PATCH v2] gpio: shared: undo the vote of the proxy on GPIO free
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-gpio-shared-free-vote-v2-1-7d948edfdbde@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAIVD2oC/4WNQQ6CMBBFr0Jm7RBooVFX3sOwqDCFSYRCBxsN4
 e5WLuDmJ+8n//0NhAKTwDXbIFBkYT8lUKcM2sFOPSF3iUEVyhS1KrCf2aMMNlCHLhBh9CuhM0p
 rbR+Vcw7Sdg7k+H14703igWX14XPcxPLX/jPGEks0bV1djKnPmtTNi+TLyz5bP455Cmj2ff8Cn
 jRbRMEAAAA=
X-Change-ID: 20260520-gpio-shared-free-vote-f62333ab4fff
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Marek Vasut <marex@nabladev.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2177;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=1rat9CVwl4Niea8fgGERMdP4TdfM0tYDE6ELOJ13qUk=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqDxUHV5v8hUac6HLEvYQXkTatbtsuwpfb6fJo1
 uspQdUZ3t+JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCag8VBwAKCRAFnS7L/zaE
 w0yUD/9mgwuMNoqcp3xQCZrP9Fi6lKeKgbt5otASRC027wvX9/q+X++d5sXfE31iFsPSAuJGovw
 akDqVNx/qIfAkMM+wdBj4LfRLN8byup7bE9p7fNn1086l0uxuJ63OavrcWwml3I0hpak5EUbkAL
 Fl3Uy7g1TkUXtIMN06ptREQUggyo5aUujh55xPqA2fY9cVjsAy989LhAoLMlChJohNkbjh9iKez
 D7wHhPaN0xXd4d4Atbs2WherT6kDIKwKH57ToifliQ1QqFlYCC9+8/fn0qgna4IyPfeCtzv5z81
 588rdK2efYGDfHmIi47jQvL0Y7WUPSD3dAx7zBCdmo0tERhcnpv7BDFgTTVAEMCY8mkrvceUEfY
 GOMzhA0g3CgkNJzDkJjV2Otni0zd/2QQeu7BhbVs5wQ61wy9O/aMXNy8Grf0vH8OKKxFIgJ5Mi8
 ApK+tdGUw3JMhUmx7iLqIWchUtb9wcvBsRu+x2sh0vXRp4zn1Sd1tp7e9cMW9rYfKbPeKhHh9r3
 ErGpGTo5YMcwZs4cW3uymzWivccd6K212W1JjyUMemzV0vb9T0oYMzkDBhisDPNQyFjvVl8/Atk
 33Rc7Tfi69elwRmG/gNf2uolAgXrZ+Byfyr0FyhWXKMQ4TpkCOm4FwadIyjLT2U1Dn9o0seZjqM
 JEcFgj6UlUJ5wRw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: 8mRBT7GIScFSxhfcMWm9MDiaqTLaYOgN
X-Proofpoint-GUID: 8mRBT7GIScFSxhfcMWm9MDiaqTLaYOgN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE0NCBTYWx0ZWRfX2go613ypYUo+
 4+mrc1eGkdmXmBYi9ND6Ah8r+NrkJcR+5Kqpq2hsARfrdhu3WikA4kh8Q4CTCrscLmI/vLIZzmv
 s6qcREv0SeiMS9/x7v6MnBu52A+CQPERAXUXFOBN3SxmCkkaZyFF23opks3kVPQgL7khocMxBI/
 Q1PGeIKBZRFQHYVdOdw+VupfTOOogMdMeHMU5/wLlOtH1Oxy8ednzuUUbFmKhRdLnbgi6KWjZzT
 YbYiSomYhznpdO7pW1JaA8X2Mu80tDC8iA8oOD7bSSHvGzMHAx6lM109gtk7wYnLsfJP7R0sWW6
 GPMdQ7SA3NQgeet/4T+fGZxEvLHRvKDmi5Xj0Zj20nxL7/p3ob3tsoeAognTQlj7usT14UA2mZM
 WqZM/RwpPi49tPO1yDI0nxM/75Y4LMj0eFzN9SJgrH9XyXy95a4lw+wdMZTUk93qaqiD7VeE28a
 fZULSrkp6guF4AhjfqQ==
X-Authority-Analysis: v=2.4 cv=GqFyPE1C c=1 sm=1 tr=0 ts=6a0f150f cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=c92rfblmAAAA:8
 a=EUspDBNiAAAA:8 a=bC-a23v3AAAA:8 a=VwQbUJbxAAAA:8 a=C00im2qEfLC3rBLg9RsA:9
 a=QEXdDO2ut3YA:10 a=efpaJB4zofY2dbm2aIRb:22 a=GvGzcOZaWPEFPQC_NcjD:22
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210144
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sashiko.dev:url,msgid.link:url];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253576-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2E9615A8029
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When the user of a shared GPIO managed by gpio-shared-proxy calls
gpiod_put() to release it, we never undo the potential "vote" for
driving the shared line "high". In the free() callback, check if this
proxy voted for "high" and - if so - decrease the number of votes and
potentially revert the value to low if this is the last user.

Cc: stable@vger.kernel.org
Fixes: e992d54c6f97 ("gpio: shared-proxy: implement the shared GPIO proxy driver")
Closes: https://sashiko.dev/#/patchset/20260513-gpio-shared-dynamic-voting-v1-1-8e1c49961b7d%40oss.qualcomm.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Sashiko commented on this pre-existing issue under my patch changing the
voting heuristic.
---
Changes in v2:
- When releasing the shared GPIO, restore the value to the "default" low
  using the existing interface to keep track of the votes correctly
- Link to v1: https://patch.msgid.link/20260520-gpio-shared-free-vote-v1-1-6c54966583e2@oss.qualcomm.com
---
 drivers/gpio/gpio-shared-proxy.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpio/gpio-shared-proxy.c b/drivers/gpio/gpio-shared-proxy.c
index 29d7d2e4dfc02c34fb3f2abc343ee30b61579b66..c43a117de016af03282961ec843ffa8cea00ec5a 100644
--- a/drivers/gpio/gpio-shared-proxy.c
+++ b/drivers/gpio/gpio-shared-proxy.c
@@ -103,9 +103,17 @@ static void gpio_shared_proxy_free(struct gpio_chip *gc, unsigned int offset)
 {
 	struct gpio_shared_proxy_data *proxy = gpiochip_get_data(gc);
 	struct gpio_shared_desc *shared_desc = proxy->shared_desc;
+	int ret;
 
 	guard(gpio_shared_desc_lock)(shared_desc);
 
+	if (proxy->voted_high) {
+		ret = gpio_shared_proxy_set_unlocked(proxy, gpiod_set_value_cansleep, 0);
+		if (ret)
+			dev_err(proxy->dev,
+				"Failed to unset the shared GPIO value on release: %d\n", ret);
+	}
+
 	proxy->shared_desc->usecnt--;
 
 	dev_dbg(proxy->dev, "Shared GPIO freed, number of users: %u\n",

---
base-commit: 687da68900cd1a46549f7d9430c7d40346cb86a0
change-id: 20260520-gpio-shared-free-vote-f62333ab4fff

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>


