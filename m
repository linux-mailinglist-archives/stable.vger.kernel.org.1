Return-Path: <stable+bounces-224748-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIWNMJzAsWkwFAAAu9opvQ
	(envelope-from <stable+bounces-224748-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 20:21:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F07269374
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 20:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29C6630672ED
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 19:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390A32F5A05;
	Wed, 11 Mar 2026 19:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bm3ScU91";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FOU+cQr2"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F322F3C19
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 19:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773256591; cv=none; b=Ya9+xgFTb2CneRAJAlf2f8BjYd2UyLnaKxCCImSEg3OxtlP8Vx9HZqmjaT4aB+d7y4hho6bvifdn7x10C6W45QkmDmgWG4itkub/JvHKHCocm+z2BYSfv7Bil1TG6rQOrRqGUFU+x1t1UZH9WegHw5dXQ/5XCboJBCjkq9g0YNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773256591; c=relaxed/simple;
	bh=0Qnr7VxidfvU+xsDleNOZhfJsVXxieNl3yqIIH0Y+3o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BxaKTgeD6vBSr31mVwTCjYF4w5NyUJZNZd7TXFoOnjhQkH9mtOKodgW1FN+H3EwLC4BlfYSv05HTvR04e8dpyNpnqtT6lT+IAYGOmq/Wsur4HX2+bSjFLYnsvn5duRkf4x7MLp0fvOxD4DnUDPkY3L9r3NnCgfE9ST9OXHoOiWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bm3ScU91; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FOU+cQr2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BFooMN3601207
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 19:16:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=M6F2sM+eNOI6ryH461JlMbp6jSOf87pDbVN
	oVk+OREo=; b=Bm3ScU91/1gbgUtg12dKKtbeLcwP1WzLf0fRvYobQ0tC+dxzV1D
	jixSoZTKlD1QdTfs0T4W3noLyFrRFX6t4rJUMDnfkhrhoWHPErAfgCAuMNFbWMCy
	R4L+2SE2RtA0I4EVoAqhQrL8OYz/lzE49gOBWPVU65tf0NwV5sw68dswOrogesbp
	K+u3exXivYalvIhh833iyxuKG9LgtqTzen0ltSyOqORH9etjF5HYeEIpDVhReBhw
	+fMFdFuON1HDs47xngINu09G793baXoGWmF99ZfS3ObgLxL73Oiz96lqn+Tfhcb0
	hrrBzlqxH4pbszJ3emsLYIpwrPxLPO/q9VA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cubd4rqv9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 19:16:28 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cd80bea54dso95929485a.3
        for <stable@vger.kernel.org>; Wed, 11 Mar 2026 12:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773256588; x=1773861388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M6F2sM+eNOI6ryH461JlMbp6jSOf87pDbVNoVk+OREo=;
        b=FOU+cQr2APXfXaGSt+v6YZZuW7wIrgo/EVkWK8AUOvRKHmwRJUm5cwqAaswy5RimoI
         BFnN1YhStu6g0EZplVYwUMZkVeJO8MuEk7lyZZ1V85fuBHmOg07K58Kr1IEH1Dhx6vj4
         6uzQbJnprS4jrusmXNWA5DhNny6fKQnyb3kUrVwA4U3R5Wro0AGHJCrK0mVdJZLioON8
         I7SFcvym9w4PMboM6hKK5WjBSZZjFHB55tCKOZGH1LbSsr5fJFuNhY0Yv4U+1vvJgaAg
         KI1KXtftOSKnWfFqku9RM+8tXEU5QYNqzoQ+LStdmxPD+wDoTwFxzTfGwKD4bt1cSFXH
         KLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773256588; x=1773861388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6F2sM+eNOI6ryH461JlMbp6jSOf87pDbVNoVk+OREo=;
        b=wXE1BxaQwLmL4ShxZARh06rKVFP8/Xf6ZnrXbWHm7yYrldYNyZtv1SdiuczUElm8NC
         GOMaG2faDX7VXhHmCzmamrvjL0s4LV4/dCBNq1Zfvs3B0mPzblEKqj4veupFDDGc+JVJ
         KJUccJns0Z8EqYZSwDjxWU65Hz3refB9+HhtTMb7AwyGB27z9NifW1o8VCh3cMsEtof8
         kradJ9L0G19wp5LJRDll6WfF55HBtCWD+qmD+WaV+4pYj43/AAKo+eI+ysDSkwTTFYm7
         1tBBmS552ZudVmPeuYjS9cwUsa/KzfdI+ohPUBsK/yQfNyLeWpd46tN5sVnDIIt+N6sk
         3DMg==
X-Forwarded-Encrypted: i=1; AJvYcCV0Qulb+xa2yWa3BdLNsbUpjJjg1bPM+z4YSyGLUvL06rgaDVetn2bv3XIb7CQYtveukF3wK54=@vger.kernel.org
X-Gm-Message-State: AOJu0YygcPmKKLJt3GXZQxjY83e0J5YJLHmm2AD+cmD+h6NXFEaYBiwy
	H3AeHnZNXhYpHvaQQigBFB1spVEZogcJFXD163qhD6H4xEm+EWYsa1lALr/HWQqGwbyYMbynNP6
	v765mRxKYVcHKMuZtKpTRVfVeHLor41sDPWcM0JdfDVM6TAW5lVggv46Kodk=
X-Gm-Gg: ATEYQzwRgkxwS8NG44HmdLNfvW+RBjuBanH9g/2KO3v8OIqZBuLDxQlxYCqTAwnpCDf
	41ZMREMpLHPT/PGqJd7sr8OCJCPTZdFbvJZNm7c0rYF7UPJiFNOjCgM3zVpEhsRjMsOYPwft7ld
	oOYzAsRu3lE7id9ll1EBBRf8dDaOmntB08McckjzFqzbiBBuzSD+0fZrXmwb1vbqVR3nliIH0An
	IbLt7LE/wgA+1jM4TQDWUdnNmmcRi7d8IUED3MGxho78CNtNX9+bXU6tNTpN/qcZYsU0vUShhGo
	Bf3qfG543sFBfSS00A6lmnEWW98xXCNT3GroqtEYTA/IBSjz9bZMxXIo3Smmg3Jk3uyK+YAjNlM
	IX6JGc9L21BbQ6NHw8yEmYIFnHchw/8WSt74U
X-Received: by 2002:a05:620a:46ab:b0:8cd:97a7:a343 with SMTP id af79cd13be357-8cda1a29234mr498552885a.36.1773256587995;
        Wed, 11 Mar 2026 12:16:27 -0700 (PDT)
X-Received: by 2002:a05:620a:46ab:b0:8cd:97a7:a343 with SMTP id af79cd13be357-8cda1a29234mr498548885a.36.1773256587514;
        Wed, 11 Mar 2026 12:16:27 -0700 (PDT)
Received: from quoll ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe2273d9sm1475806f8f.34.2026.03.11.12.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 12:16:26 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        stable@vger.kernel.org
Subject: [PATCH] drm/msm/hdmi: Fix wrong CTRL1 register used in writing info frames
Date: Wed, 11 Mar 2026 20:16:21 +0100
Message-ID: <20260311191620.245394-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1818; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=0Qnr7VxidfvU+xsDleNOZhfJsVXxieNl3yqIIH0Y+3o=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpsb+EltUEMM5EjdIEq/s76SBmQyTVDzV2KeOFC
 RL/nWWEX0GJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCabG/hAAKCRDBN2bmhouD
 1/YxD/wOPr0o16gKuvZcH1lDYB5OKlGeVB6cFFqVE0WRcXlUXwBj1qbsymgbYZllOE8iIAnx+xc
 l+XGmhJIL3Ytxv9JujjEucIdn2I0Y1U/GI9/dBXNonw/AqRMYOjb6l60LqNme2qDQS9N9AYEPaB
 63o7mVsB0hLaTvRdXMa+yzfRQcyakznFByatyE6IKSwxGgW/NiM+bF+z5YmxoxLW7KtgS9gvyib
 ZxG61HkdyDqj4+mN4qNWU7JMVtrcMI8XZPriotu+YJor1W0d6EH8VRbo+pndWpXfrvHQ0eVRO3i
 E+CjV6H/MjwwTwHYKd9ErpFuExModykTudNq93r/ymIgJFsHyCF1ariJ6BO3SH9e683E0ooxw2O
 1/QOnPZQMKOo5ZEJ6o5k6uTGjJni3lK+hIPNA0milUC5znVlboHUWgVY2ML04TWG2BworNw5398
 n3P6N3tmTdr5LJQoxo8dcXkG4nYUz5gNC8tvaGj/bFa/HcHYYlcuY58qQQAqCgviTHEIl9v9a/p
 DDD5Ug7wrg7bYaAv7QSDKoIf2B/NGRDWjJoSZD79tci6kfjO8gtgBXqGQ3eLlpspgMkyvx1F/8Q
 BMT1/xjh3EcM+d4982bUiGZH4UNxzE3k4wOVsa3fidiOalcuzqfZIsDYbcau13HbhQUY1zS8tHj 0fKIP+gfkmkiMaQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: F_suHKO7plBezq9ef6ZnZs72PsSd4nAT
X-Proofpoint-GUID: F_suHKO7plBezq9ef6ZnZs72PsSd4nAT
X-Authority-Analysis: v=2.4 cv=QLBlhwLL c=1 sm=1 tr=0 ts=69b1bf8c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=ksbDLleXNvo7xJVorFEA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDE2MyBTYWx0ZWRfX7RSca9ofAKmU
 3r6lX51ArQCmZQ3t1h4Jjcb3v7yNX7hGBeBowdn5g49zNDTLXV5auTn7P3KSmd6rQ8FTzjgpxrc
 xk2gukc+q24uPpOj+3Ss4JkdtjWTZ7qYBgeV8e0t+dDRBpD0RZTDbFYYOHXAQj/mKth7LEnyQuY
 Oi0ASisMoISAzzUBEo9VW3bsY347nUdiE4kf5Cie/ce33P9PKgUA3cIDmzGzv3wUpZn2Sw9J2Pa
 ByRtp/xo5nGxpnSQUydmDMVrwkXVdKH3TKRyQ4eww0aiOFgb/494hpHxFQ4j/Qc/W2dg8XITjF3
 7hE1RcB4m8G5iB3LI0/BbanqJzuyuPlkceS57E/T1excVcr/7XBo8VxhCb9nkNDMuusC7VriEjW
 S0BPuEGbsxNfq3/7O1Rl8+uxs0KaqI5rk/hhqvNJSBvNt/VE9reDsPJLQ1wdIdzwm49wBDraSSN
 1MvNiQU++hTV6YywtlQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110163
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-224748-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,linux.dev,gmail.com,poorly.run,somainline.org,ffwll.ch,vger.kernel.org,lists.freedesktop.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 22F07269374
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 384d2b03d0a1 ("drm/msm/hdmi: make use of the drm_connector_hdmi
framework") changed the unconditional register writes in few places to
updates: read, apply mask, write.  The new code reads
REG_HDMI_INFOFRAME_CTRL1 register, applies fields/mask for
HDMI_INFOFRAME_CTRL0 register and finally writes to
HDMI_INFOFRAME_CTRL0.  This difference between CTRL1 and CTRL0 looks
unintended and may result in wrong data being written to HDMI bridge
registers.

Cc: <stable@vger.kernel.org>
Fixes: 384d2b03d0a1 ("drm/msm/hdmi: make use of the drm_connector_hdmi framework")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
index 3c407e275ce5..a9eb6489c520 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
@@ -153,7 +153,7 @@ static int msm_hdmi_bridge_write_avi_infoframe(struct drm_bridge *bridge,
 	for (i = 0; i < ARRAY_SIZE(buf); i++)
 		hdmi_write(hdmi, REG_HDMI_AVI_INFO(i), buf[i]);
 
-	val = hdmi_read(hdmi, REG_HDMI_INFOFRAME_CTRL1);
+	val = hdmi_read(hdmi, REG_HDMI_INFOFRAME_CTRL0);
 	val |= HDMI_INFOFRAME_CTRL0_AVI_SEND |
 		HDMI_INFOFRAME_CTRL0_AVI_CONT;
 	hdmi_write(hdmi, REG_HDMI_INFOFRAME_CTRL0, val);
@@ -193,7 +193,7 @@ static int msm_hdmi_bridge_write_audio_infoframe(struct drm_bridge *bridge,
 		   buffer[9] << 16 |
 		   buffer[10] << 24);
 
-	val = hdmi_read(hdmi, REG_HDMI_INFOFRAME_CTRL1);
+	val = hdmi_read(hdmi, REG_HDMI_INFOFRAME_CTRL0);
 	val |= HDMI_INFOFRAME_CTRL0_AUDIO_INFO_SEND |
 		HDMI_INFOFRAME_CTRL0_AUDIO_INFO_CONT |
 		HDMI_INFOFRAME_CTRL0_AUDIO_INFO_SOURCE |
-- 
2.51.0


