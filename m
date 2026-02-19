Return-Path: <stable+bounces-217401-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABBOOGfPlmkZoQIAu9opvQ
	(envelope-from <stable+bounces-217401-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 09:52:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5276015D1E8
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 09:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AAABF300D0C5
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 08:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A01335098;
	Thu, 19 Feb 2026 08:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q6wJF5X0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NMytQyae"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A85C1DF25F
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 08:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771491170; cv=none; b=btJWWqQVbg2BNUH7S0Hnqz3aVNHg5DUdibvAi8eNZmj/OP7xDPG9gkVybi3hdUY4Z3KMRHqqAwEA0I4qq9lE4IoCChaZUEwwfZbHfQNd1ziXgmpSlTlBbuxBfaIfIrNxRj77qfuBcERhGjmhg+bMAe/Dt/wsPDbY127niY0zE4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771491170; c=relaxed/simple;
	bh=09gU6eYkuiNszHVCfyUAUArctBsD8+KpisRbnCS/ePs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iB8JR+mJCjukG7cHeQACOPvdFFaqd4duExQOqQwzIoNRMBEg4tUTn3wAyeocAJWTDxUdVkdbzxfXOxIg7hMcPNwJIhgAbJMJyKOzc4SfD/t2Kk5+UQ09ffbHJCkRoD2uRiCGkSHNsAdiG+YuCPrEe432KM62CEWNaR9B2TtO3x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q6wJF5X0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NMytQyae; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61J4Di2x4025101
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 08:52:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=/VJQk/scXTP44mikF6XflK
	jjFdIUKAbgXlXqn6UgLBI=; b=Q6wJF5X0qNmVatB87u44QNkD1WEeRqXjDFoZ90
	J7BZiaAA+15fvvrTId7+ZXVZ1q0QA+Ge77a2LawnJGX0d7n+khZucJlkLQnETkT3
	PW0emm4A3zQF0ioqrkYCiE74LPAs5CMjr/jfcgt+3EZM1GpsaVYlKCIs5wCT15Xr
	eblYvzKcDZ8EkeFRwpST8Teln1hKKbyqOEvbeM4NzrUXtl6+7o0A14jBwGk5cXaU
	9tFfkB2iWi3+EnKHL/dxMN89ze/oXAx74wI7ZcRUBEnVEW71Xn/JosRUM/oMPBis
	BqtrfDGq5O7Cvmnft0lif/I+kyU5W1TziaSN6rm2OxI6eEOQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cd78c3tme-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 08:52:48 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cb52a9c0eeso960595885a.2
        for <stable@vger.kernel.org>; Thu, 19 Feb 2026 00:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771491167; x=1772095967; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/VJQk/scXTP44mikF6XflKjjFdIUKAbgXlXqn6UgLBI=;
        b=NMytQyaelWmfaid2oY3qaq+GMRAizpbTZP6Ug8qASsnryF/hr940nA5aUjTmc4BNia
         0Y5u0cwrUvhy1hRpRoC8948OJjkiwLrEjNEIbvGH9O6y+SrR9y0bW21px7BOPnZenRmc
         +JQYzUoNXBcaSzsQRjdK7nMsplG/LrUZYSxc+kp5UYFi2LGfUjD5G8ii77Ifo2iTraPi
         lNolDm2pDafFPK8kjks5MwSE/CzsEhqa3bGR3Q6IzjBEpmf3xiLBDLDg71aihSjOdJNY
         UQMwJoWd4yT0wip8XtWeZgCuAsCJwI/4o5Tfg7bjaJiuhJn/+AVj9ydsL1X/jBxvTq37
         SeKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771491167; x=1772095967;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/VJQk/scXTP44mikF6XflKjjFdIUKAbgXlXqn6UgLBI=;
        b=q1oE8vYOifi5VUIOL4Hzn7aUlhuFhd2YqFVPeFn1Ra33nnfAc2R3O/ESSJE1VK68gY
         Y+VjvPGqVbu+vIjmgUSCoKpU9xnTOumQlQR6yMFK3y8KhbFjXMl8VUA9ZamuVop6GZVJ
         96OPKeRjV66hr/2eybadnNevEwmONK/9OuAPfC9oydS9EL1r9oFYvQuqoI8IZXQerwB8
         btqZaLngQ0nuiTmxUEFe9O4kKsaQ4NCz3PotBpETaXhDM0s4lSTJyzWZ7JJU1qxZ645Y
         /nEiz+Q1GtYi9V2J7HgATNV0aywfRKbPxfZ8HKn4+uuiGEcQ262RnSJJ4atcZyy8jpdX
         DZ6Q==
X-Forwarded-Encrypted: i=1; AJvYcCV7IHo2Le8yRnjVf8FaH2lfRV3k/3VmHZpPAOIQZKO476joEzMJ1+L0O+Zpt+sTmBGhZUj/eH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzORfSXie94UdTfArCrmTOBW0pSy7Lvq9cdekvJA7Eq8ODQTAhV
	LXOmQUSKvyNkfArB9LvrIQ4zowIUCOlE66LLHcp4T14nN+5fijSqszzvBMacwYkNI25EsLQFSoJ
	un7mTolsrxIRR1pTF5zGHXf0TgnrKAv3lQWAoDUl+WM0i9VYIAfj6KmInKps=
X-Gm-Gg: AZuq6aIZRzmYBR5yQW7UU14PZApG5Kenx3x4JXz53icqXnkF2bv3hlV7lOddeEkknRW
	j9cIYwebi0LT8xXXs2OaRM33U9PaCA/Zp/OHw7HoA1ZUrZuH7n3j2rAePtE2YWSjz5fN8P0WqsN
	B3X2CAr+AMPOhOvPhXL3mehtFQrQTVZKX8cshI2tl/j2RjQZtdOuW4KQV7iRXKU9S/BBkx7m856
	aVahOGwNmoa3mIeCuVNk3wPD6oaBrq324vqeXJ/OAydP5N6ECTcf+J9ymO6LxtMPB2nEMYSa9DS
	bXp5+MaDmcpbAdeiH1WfO5xt55qWo8bUeJLTlrTQPWfZQZ13BBHloBGp9+OWn8GeQJiaI0HD9aK
	O/EAToKfjq9n9mD25bVK4U6MSyTY4+MD4mpV9YBHgv3xXwrjjh+Zj
X-Received: by 2002:a05:620a:28cb:b0:89f:7109:185f with SMTP id af79cd13be357-8cb4bf97d9cmr2049958085a.31.1771491167404;
        Thu, 19 Feb 2026 00:52:47 -0800 (PST)
X-Received: by 2002:a05:620a:28cb:b0:89f:7109:185f with SMTP id af79cd13be357-8cb4bf97d9cmr2049956985a.31.1771491167011;
        Thu, 19 Feb 2026 00:52:47 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:acca:9ed8:5af5:752a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ac82f7sm52117586f8f.28.2026.02.19.00.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 00:52:46 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 19 Feb 2026 09:52:37 +0100
Subject: [PATCH] gpiolib: normalize the return value of gc->set() on behalf
 of buggy drivers
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260219-gpiolib-set-normalize-v1-1-f0d53a009db4@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAFTPlmkC/x3MQQqDMBBG4avIrDuQiSDWq5Qu0vprB2IiSRFRc
 neDy2/x3kkZSZFpaE5K2DRrDBXyaOj7c2EG61hN1tjOWHnyvGr0+uGMP4eYFuf1AIvpDSxGJ9J
 SbdeESff7+3qXcgGAm4fdZwAAAA==
X-Change-ID: 20260219-gpiolib-set-normalize-1080e2eda113
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1562;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=09gU6eYkuiNszHVCfyUAUArctBsD8+KpisRbnCS/ePs=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpls9YCrYq+MBw551UH2DxaXRDZuvIz+Gg7XpOB
 f+QIr4zgyWJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaZbPWAAKCRAFnS7L/zaE
 w8YYD/0f5lH0fGRHlj2gijMOC7ykBATjU72sWmTFhsD41QqUN7LOqabeln+3ImOGAL7yNlKhtet
 YtOQioU3/bMgYFj+fjhzbzzgRk9f5N4T5Kb+E6/tlNwkczLELZArtxrHojZuszr94Ho1dqhS97u
 hbdT5B50NnST+S5vErrE13BfCavx/U/cx6jb3zhFr2Qd2e5uuPdm0bfsm9OpBqxuC236YwdSs0G
 Q6xXglhiU+FHK+A0nZjd8yAK92F9En1qbng270gyrtjyqK96Pn0fjwSwnBqEJlgajWH/lpZLRbM
 OL/MTRiU74zWtbBLLZ/aZFr7aQ4TsMTj16PkV9JvGkuj7JvDyhXV76PLoBy2VYIPWGXqf3CwYq0
 jpqNm37o0qOuN+s6eCO8dPkpUvgclZ0cUtmAdPflWYxTa9DKrz4Zgb4/0HA8w+s2MEKIsE7Js0K
 JJX9TAshJjVIzNhXDorsl9Xq49KcfSSwKFB/ykZsVMDWzNGEz2rKW8t8i1ypFyuhS9GP4QTbbrN
 jVvQDgbtjZP75Bx6yFGBN+EPJ75obXdjI7A9HFTpqBlfF73gnpDPs4srlho+P1/JpJbpFoXD5lz
 sG6xfw5pohCsLaEFEkF11fClIDp2jKX0MQcluhipC03UNs7riO4twW9GZYKC5KtHYGKTdjzi8gu
 K/Tpqbmrvr3uAJA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: Je0-6Z2TWptw5koon-AzrWic3HHxF_SC
X-Proofpoint-ORIG-GUID: Je0-6Z2TWptw5koon-AzrWic3HHxF_SC
X-Authority-Analysis: v=2.4 cv=P5k3RyAu c=1 sm=1 tr=0 ts=6996cf60 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=67SJ3es6nUsVzo6b:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=Km6uTPIqCEU1mvpJHkcA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDA4MCBTYWx0ZWRfX3dnFko3kUFti
 WEQQ3ikj3yc2gq8mdDdCxjY8XMYfjgrChVbqrqsbtkzTE9T/X9whRirbfkT3RJ/V+V+nZm7V3PT
 ejuARTtio3IB52ehqOoEVmz18rcN+EkRdF6iEirM+nVU385DjMQ2NMg52lZFaz4NNQSiSyApEwN
 YQWtErzrBCFSoX+46LdIgLEgw7jRTglWqIji+NqOONDaQyJ7QrTJub9EDdjAb4STmuQKl9Vt9yW
 iuG4Dl1uAj1+Hz72D4fgNQ0O6ZZn01SW/BmLRLSA2QlAzsbILgtoiG5TItnNwkgSIT7RY4tLTXD
 YLhpsaQ+iXYF1GMDGJF8nUOrUiB2Pup/3BDGGBvlXxAEEN/332Tw/jGXJTltLkBUv3QxrCYG1MN
 wblubDArZFonxo6F0BA5TZYa6+1NdNuFyd7KtanuqkMfpM+bz1l9Kln7i+3Awu/0jin1PGnqC9F
 SKWIO/9UBA9szSaQUTA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_02,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 spamscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602190080
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-217401-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5276015D1E8
X-Rspamd-Action: no action

Commit 86ef402d805d ("gpiolib: sanitize the return value of
gpio_chip::get()") started checking the return value of the .set()
callback in struct gpio_chip. Now - almost a year later - it turns out
that there are quite a few drivers in tree that can break with this
change. Partially revert it: normalize the return value in GPIO core but
also emit a warning.

Cc: stable@vger.kernel.org
Fixes: 86ef402d805d ("gpiolib: sanitize the return value of gpio_chip::get()")
Reported-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Closes: https://lore.kernel.org/all/aZSkqGTqMp_57qC7@google.com/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/gpio/gpiolib.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index c52200eaaaff82b12f22dd1ee8459bdd8ec10d81..9f7a1a1ebd8365fe933c989caf9e8c544fd9ba0f 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2914,8 +2914,12 @@ static int gpiochip_set(struct gpio_chip *gc, unsigned int offset, int value)
 		return -EOPNOTSUPP;
 
 	ret = gc->set(gc, offset, value);
-	if (ret > 0)
-		ret = -EBADE;
+	if (ret > 0) {
+		gpiochip_warn(gc,
+			"invalid return value from gc->set(): %d, consider fixing the driver\n",
+			ret);
+		ret = !!ret;
+	}
 
 	return ret;
 }

---
base-commit: 50f68cc7be0a2cbf54d8f6aaf17df32fb01acc3f
change-id: 20260219-gpiolib-set-normalize-1080e2eda113

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>


