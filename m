Return-Path: <stable+bounces-253478-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8J6vB7nIDmoACQYAu9opvQ
	(envelope-from <stable+bounces-253478-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 10:56:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B005A199E
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 10:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B7B9313E070
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 08:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397A93ABDA2;
	Thu, 21 May 2026 08:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SdjF4a++";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P2SyLYAz"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C143AB5DC
	for <stable@vger.kernel.org>; Thu, 21 May 2026 08:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779352649; cv=none; b=W7xf5cDgU1l15rt2R2BfLQ0DHUYRPLhJbzS3pU3ez/2JcbSEOHertVrsZpReZ9/+xrJAcO00p2rHH4mv9MJBufvteWOCMfI2CyW5UbCAuMWAEvTHWQoFlkWmzjjmnydLvI8mOgJEahw2amt1ZDxI6YtEOH8Jqrt7IQyAKW1mzeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779352649; c=relaxed/simple;
	bh=d5jcui5x9J+nHSVyJps5DuSu5oenM0O/Al9uUGEdnso=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=orawFSbCVvzs7jiKZq5OTcLcbSUytfJkRhFWcIRXyd58wOZt0K7C15Rq4aXmq+dqN3PMBLYC4qZYW0I7dm7vEWfiufM8ManvLO7mGDAjWuCeWyzrMKV87rKmVVgkm+0CuWCgu5NuI0B0NL4DPU7gJAthON/PrbVJ1GOMcbBURdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SdjF4a++; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P2SyLYAz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L4cv0B3084995
	for <stable@vger.kernel.org>; Thu, 21 May 2026 08:37:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4jemJMg1mPxTimQgHduXv2Tk1YXpvQTVBHPayB9K7NY=; b=SdjF4a++R9b8Imh4
	M50gCFCW0es8kE+PRhzsu2IUk1csQfkF4V/6z7xG3YVTpjNfX/FdQgJw91FtGDmp
	k9o+F9H/tC9kwoUMlnjCMAzagYOfOb9z4PpX90oOtPpjcMhtCJ9oN4Zi67xTunYr
	RiCN3SuaU53vG7krEpjKUJicnQdvkOsKxwNxHDbUGDL3G5h0Tu5B+4wjQwKDL+gO
	Kg3xPNU14w4iBOj8Va9vS1r1drJyibztFx7S8CVulTr9f+zLqNV6/DB/o/UCj6IG
	dWnVFr2hOHZp3MU38CH3ubZG3lkrooNxrIQn3SErxclSxBUFc3foFsk/iuC9/aeO
	3iX1kA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9c7f4eyw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 21 May 2026 08:37:23 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-913fcc4c164so1401337985a.1
        for <stable@vger.kernel.org>; Thu, 21 May 2026 01:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779352642; x=1779957442; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4jemJMg1mPxTimQgHduXv2Tk1YXpvQTVBHPayB9K7NY=;
        b=P2SyLYAzVU852/o9UF09NQ5SCvJs3Mn8gcxOFpP+KDWc60SSa1mj/fpG7Pk5F5p4pf
         IU5RwPSjdWTVRH9mfSPO+P0LCYtjzrE5Ve8aiVP0lwSNoHEQiavIF0vAcBdf9MGr7zRv
         w6uQfY/l27lS6NVccIOYFnqNq8sSqpYpaTFrWQ7/Us5JruYYgDF1NToKWZZcoofscFFC
         bD3ZSKXVPpDgiobkPZuUk+SVBIRW7YMoaHAD8zl/5Yx5iS1yv0chYpqCr6HbwsUr70Jc
         cQWQad4Zb/PBsqMyzArh00v/oapQldJLObsbM4Ka4RYl9yL21e8uMLDWQqHXBTTuARc5
         Ardw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779352642; x=1779957442;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4jemJMg1mPxTimQgHduXv2Tk1YXpvQTVBHPayB9K7NY=;
        b=Rb+Ajqld/ghgscvo7I8s/Bf1vYf+mQOXmn5MU2rucldOYFnKVAZ+MloBVJclQwUNb5
         yb6RiM30lQI1YarCyfQf/j6BLW3KzbNF4HqmhiAv2Un9YlurA052eUV8J887A4t/n3mF
         JzuC8H3x/Po9hehOdq+KZrk1xxRhyfcSxSfA2cY5xOhhZ5BcxSVIIkc5yrTOK2cHkmhP
         l16T3XdyhlFOQu0LCSy/oR6XTmeV4+zfk3cY3d+lhSaaPtfC/cgHC64AlC7i8eyPQX8X
         6MrxC9Q9wcMmfiTfvHJfQa89JLHEttEw1G7m6hCW5ZDJsbjhBTDistP3k8MjL/3H32Y4
         dWfg==
X-Forwarded-Encrypted: i=1; AFNElJ90WxULzIcbW5z8PwgHljAC664B/n/wvesHtQQ3pXIGw9clLScBXHahpoqXA5iO400qvNlXjMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcOVtuuw22ligHlsXaflN8wQeRrWnGU3FqWZJVW1LK8yoAoGcB
	5x2XvBE618lh7P7SAytCDWxxxpDHR7W1v2s24WDdezpx9pdPXa11YM4L8VqAPyKrcQ5LnJPFoOm
	44InAeKc0SrI8eVqGkRzierJoj6RIAW4uZuy10z+W6kMJnuxxW92Lp4rYQuo=
X-Gm-Gg: Acq92OEjlFfL0o8fMLL+XWjxgRpKroMpwHs4iJvDxHmBltlPVsrHPFWmO/uTdmUF5gd
	vwyDD1xdPGu+2R9DyuwCOhb1V4cm4lyg/nRW+ktjx+VnKtAEIjwae726DKdNxYT3TRTUP17W/71
	XimooFwszG5vuygPbUEtipo8arrU8uqUaVcxBsG5FDlGVMLlID9etPR0WnWmwGdGk9YUGPjvya1
	PiWkNTjXHW8vUjBlcAZvSsWnUHaLgsndUU3C6fhHP1F3Y6iE5WYB6wvqaNgmqnXlOVu8nl+qHYs
	KPsRl9TuE2qpNEmeZlA3GbU830WRQI3I/4Qpswbc8fIb+Dy7D4nCn7JabaR4SX2WkD8AP73GRST
	6d0QldeUQE1lM5a31Ci/MSx2hEnZWwKrXWN4IgKKKfocCatFMi14=
X-Received: by 2002:a05:622a:2590:b0:516:51da:ae52 with SMTP id d75a77b69052e-516c555a195mr23280011cf.33.1779352642405;
        Thu, 21 May 2026 01:37:22 -0700 (PDT)
X-Received: by 2002:a05:622a:2590:b0:516:51da:ae52 with SMTP id d75a77b69052e-516c555a195mr23279411cf.33.1779352641766;
        Thu, 21 May 2026 01:37:21 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bb10:ae82:b7c3:d15a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4903caede9fsm10502405e9.14.2026.05.21.01.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:37:21 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 21 May 2026 10:36:28 +0200
Subject: [PATCH 05/23] powerpc/powermac: fix OF node refcount
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-pdev-fwnode-ref-v1-5-88c324a1b8d2@oss.qualcomm.com>
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
In-Reply-To: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
To: Lee Jones <lee@kernel.org>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Thierry Reding <thierry.reding@avionic-design.de>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Matthew Brost <matthew.brost@intel.com>,
        =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Peter Chen <peter.chen@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hansg@kernel.org>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: brgl@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        driver-core@lists.linux.dev, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
        iommu@lists.linux.dev, linux-pm@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org,
        linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1407;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=d5jcui5x9J+nHSVyJps5DuSu5oenM0O/Al9uUGEdnso=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqDsQiYCDxIrOzFNRB+zSgbriyAtuSvWozaQ6JP
 bdrg27xjuCJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCag7EIgAKCRAFnS7L/zaE
 w7SsD/9c6wDjuVBS5Sm/VFhqZkK+tS0GvHXg+zY0D2yyFaXX4voIhl4oa6+psFsIHJX3kjbj8gk
 2NaBcZj5v5qpmW4jExZj22fpTdHOKFtVnDCK+8UF2T7u2gqPrZwH7Y8YQBBFHmQGJLOoPuLHZSJ
 Ic6H+lisu1XnF+Db/iCRftzqK+Yj256ww6xHyvHM0eYPDKNcHh5k24Vw+F5NmEuz8DDwWPy314p
 sKpJutaZQ4VvhNThPdbll7B5GU2V9eLiV6uG3hDBVj0rKkZETI0tpdV1i2MNBoLEEmjm9lLgtxS
 H/iU9SJJDHlslkgKRK4iIa6Givk4naromKliy+6A89h5XzhSVPELLtqZVPirswCcj38GXkDDNhx
 XdQFVaJ/Sz0+LeyiysiFYFgpV0q2SxNzEgM9dj/cin64KeXZn6O/32f8gdOxs4tbIcgBGZtHonO
 wlf4CnKF8bhdmRMTSssJYsH2zxYaYoK13u9LnsjPAmWUH6rRYorVVYEj5qcJh4TgHv2isVLkrU0
 DrfnkK2UlqMZmTEfCWPTz4USoMsl8R3ve3p5uaTZjKaxhuvE8U0Ok+U7ZGIMSMm1Y20I+yP+qFo
 WCb4cP/9+Eh3SybOcfnPyGnHxIFTEkX+zZNkZvRTcLA1Ik/aJdRAh+FEsokxVsD6vhm8fvFsvIk
 p1kCeIIqXvMimtQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=c/ibhx9l c=1 sm=1 tr=0 ts=6a0ec443 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=lFaTzyIiLygvDfm8gxsA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: IyN6bm1FNi2qy9rqKh8nEDqMUMiIOZcr
X-Proofpoint-ORIG-GUID: IyN6bm1FNi2qy9rqKh8nEDqMUMiIOZcr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4MyBTYWx0ZWRfX49QJkITEXsJE
 vS0ZN5JFFV62DXIHjjqC/2SAsqykuVDnKfhk4p526p/9fyyu+N5OjSAc9dpeos9bLhgi27Bl6pL
 EJoZf/qv1z9o7BXoer6C01yhAuuhTrMceiR2ZWqEpdTzlsrKwDYTROOP3sUt5M5jAxgpENVPm7p
 DrKbylduulvgeoRUKOmRrBbSbitj9v44cJCQ+JEnyUQbhKvIJ6FTzuXXA5wwGpTkejmqDywnS2c
 YlNtLhs/ec05J3OMume2O7m50oi2BoUGeClW4cEVgUnhyI9rrerAilX8XrfyanUUIYgmtD1bXEz
 QVXx7r7JFfBXZU/uIAYWH5b8POw7dAwzDgBRhqvvfEoQqHPiobrHGiR7zdw6IHucubBjabT5J1/
 TwSRLDNoM+t5FqTC6iGHvOLVvqQ/A9ab3corZQh+2q0RHPsmUIUSwB4ONzRyzhl6B31WwFLkg1e
 Q/BedWPY/J7xhYHRkqg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210083
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,opensource.wolfsonmicro.com,avionic-design.de,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,linuxfoundation.org,linux.ibm.com,ellerman.id.au,linux.intel.com,8bytes.org,arm.com,broadcom.com,nxp.com,pengutronix.de,intel.com,ffwll.ch,crapouillou.net,ti.com,kernel.crashing.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253478-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[67];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 85B005A199E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Platform devices created with platform_device_alloc() call
platform_device_release() when the last reference to the device's
kobject is dropped. This function calls of_node_put() unconditionally.
This works fine for devices created with platform_device_register_full()
but users of the split approach (platform_device_alloc() +
platform_device_add()) must bump the reference of the of_node they
assign manually. Add the missing call to of_node_get().

Cc: stable@vger.kernel.org
Fixes: 81e5d8646ff6 ("i2c/powermac: Register i2c devices from device-tree")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 arch/powerpc/platforms/powermac/low_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/platforms/powermac/low_i2c.c
index da72a30ab8657e6dc7e6f3437af612155783d8f9..973f58771d9636605ed5d3e91b45008543b584d3 100644
--- a/arch/powerpc/platforms/powermac/low_i2c.c
+++ b/arch/powerpc/platforms/powermac/low_i2c.c
@@ -1471,7 +1471,7 @@ static int __init pmac_i2c_create_platform_devices(void)
 		if (bus->platform_dev == NULL)
 			return -ENOMEM;
 		bus->platform_dev->dev.platform_data = bus;
-		bus->platform_dev->dev.of_node = bus->busnode;
+		bus->platform_dev->dev.of_node = of_node_get(bus->busnode);
 		platform_device_add(bus->platform_dev);
 	}
 

-- 
2.47.3


