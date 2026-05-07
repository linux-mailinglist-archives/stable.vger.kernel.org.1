Return-Path: <stable+bounces-244576-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHK8BOmi/Gn2SAAAu9opvQ
	(envelope-from <stable+bounces-244576-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 16:34:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 810BE4EA43B
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 16:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCFC330707F5
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 14:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E8D3F7898;
	Thu,  7 May 2026 14:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZAYt23c"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE973ED5D9
	for <stable@vger.kernel.org>; Thu,  7 May 2026 14:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778164123; cv=none; b=ixzl5Ief9xD3GAYJoP+inIFsuZZvpQIBFFut3C9Mw5E57zZ46rXQXw8oN+YLyty6w0eWWnIcZ/utgORQYK0S/DS6B2ZQLpp2r7mGYyl1GYDvOskcscQJ7WHC9pZf9rYxOcnmC106BC2/amLi92AFZDVmcEHT5PMhebM1A+rfra8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778164123; c=relaxed/simple;
	bh=PCbwbQNt4FGuy1Mx/UEcWlVmDbt9jGbh+cLIMf+sZ+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QiRsKFG9fC1piHy9gJayst/QA1qCazQ9YCSMegYqvnsGwVmRSlNfdSnBniY0YMkaDLPwtEDoCxOI146WpnCX+uBGRrddO5NbSUZeyn7snNbB2YpUMEi2pCL13vrQ19HfVi2hK7v76IX1N6ddlCeNyuuR+5q2s5zLt1LrW+4wBbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZAYt23c; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12c19d23b19so1683397c88.0
        for <stable@vger.kernel.org>; Thu, 07 May 2026 07:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778164122; x=1778768922; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m52C9FnSjkJyGIM2Iz6ci+a0fVJqmhLXSC8+wk7x+s0=;
        b=WZAYt23c09uQluW0pEeorWwjbt46T0T1/VnA/6zpoXOGRFwJYL7Kuaq8OueoNrhFwo
         J3M+67Kc53GZQyuj/ODocfIe8VbpdhE4i6swpU+f2o4oEeK8e4ltSXdpcw++2vdkvZI7
         nHBusH6AUXVgrRS53PE0XVBbXPmIVKXMGRVusCg1AhyCex+/kI1nYadhnUxZT3YDCSzj
         NAQ8SAZdUDWVgeq9TQWgjvXDxIRmonvroAIVrsECx6VbLai4Xnd68i7EHpsGLThlD3CG
         NK+i5htGe/By8YKIfc8cPUsBYXmjdlfpmIDJ0asA145ZS3kTVJJy+rBDb9RXi6Zeydv+
         iRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778164122; x=1778768922;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m52C9FnSjkJyGIM2Iz6ci+a0fVJqmhLXSC8+wk7x+s0=;
        b=Qe0yfNf34XJjcPdg/jzjckwMiCHTHPwcXE2fxbLuQNEp/l7Vj7/JvtqG21JgB4mrVL
         WU48L/zeyYnUfAFUuXA3gKdKo/vNdCeH3bTnzDNzMWsS1Vsyy7h9itBOvvvQLfkRN3SU
         OjDkKc4d4sOZS7JnsPmEPznB5S8MuYP09jT1i6C4B6Z+Wy0paFYWrCjcE/iDegYDSNRg
         3tH5LXL80oeQiBIe7CaepL3xow9O2xKW2Pr41XwKKUU2rv0EHn8QiAWvNaMKH+bKrnym
         Ap13kMzxyybQC4nQMqHuh4L68wOAUWRbrvuP/qXsT4JKMSyKV2oZbVXgHt/BrUxiCXHA
         tOnA==
X-Forwarded-Encrypted: i=1; AFNElJ/7qu4iGsKWH5TFKi0DLaVCxQ7FNxqclqmnMuJSNPOrgsMOXOIP1UWdtjpg0sY7PUXVNGvxcJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpS2TQ3vV3XYyPv9kbg89UxArE/aP0yDVO6Xyv/aaYh+zYo4jQ
	pbztQeKgnt5CRGhI5ua9jCe/jb5TckpEGSNnXXNXFyLRxYSUZC69EWEE
X-Gm-Gg: AeBDievo97R/QI1knucT4U0top/IYZYj6cOz+13bDmD2zd4uvlGlTBQ38ed8s6ZanP5
	h+WwXAWdXZk8ldwf9rp3cw38pwaYhKfaMmlwCTyrhR5lwzKueMLHBkcup9/r21fetyzJdJDUl1R
	Fr0Qg+1iHwCcXF9qyguMxw8+l6xCA1PDJSrlHNlZLWh1FzIiCdTDtA8DLNqcsug1s70QWp1l3Dj
	S9fXro1MeUAVREFACvJzRhBBx+YaH+II8Mcuvsp7xVTr4loU3RVpSbVD4/asCdB/Hb+5LYQ/TiW
	RsYFaJdOSXSMcp5UTRcZD+OYyx/Meg6NJ1eoFhrF4iYeInxH37oR+gX5cBHPoHFB1ygHfUFvShN
	EyXqN2BFHFM1T0Qd3+hzVPAoZPbGGgyDQBeQoybVAwKSUBdBJdOlYR5tbwSyc1e9TPicz5CT+/Q
	mSiI0lJIwhPw4YgTO8kHQcMt5XgkRqAr9w7EOlscai7xj7KIexilzW2q4EUZHU3+adOgQ8wCxog
	vF5cEsdJ2yC
X-Received: by 2002:a05:7022:6899:b0:132:5e72:43d3 with SMTP id a92af1059eb24-1325e724784mr399692c88.29.1778164121302;
        Thu, 07 May 2026 07:28:41 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-87.user3p.v-tal.net.br. [177.4.161.87])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f570384e46sm8829554eec.26.2026.05.07.07.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 07:28:40 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Thu, 07 May 2026 11:28:30 -0300
Subject: [PATCH] ALSA: virtio: Validate control metadata from the device
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260507-alsa-virtio-validate-kctl-info-v1-1-7404fb12ec37@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNQQ7CIBBA0as0s3aSiqULr2JcDDDVUQKGocSk6
 d1FXb7N/xsoF2GF87BB4SYqOXUcDwP4O6Ubo4RuMKOZx8lMSFEJm5QqGRtFCVQZn75GlLRkNM7
 xydlgw2yhR16FF3n/Bpfr37q6B/v6rcK+fwDp1AvdggAAAA==
X-Change-ID: 20260424-alsa-virtio-validate-kctl-info-2bbe3b5d5d65
To: Takashi Iwai <tiwai@suse.com>, 
 Anton Yakovlev <anton.yakovlev@opensynergy.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>, 
 Jaroslav Kysela <perex@perex.cz>
Cc: virtualization@lists.linux.dev, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3816;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=PCbwbQNt4FGuy1Mx/UEcWlVmDbt9jGbh+cLIMf+sZ+o=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDJl/Fk7cXbMuuOnqBrbkK5Ix27yez6pyilfSjmraorb7I
 N/70/t8O0pZGMS4GGTFFFlWJy2y3NP14Gp93AoPmDmsTCBDGLg4BWAiS7oYGc6kRSboX3+SH/6F
 oS2pb88fnj+h641Oul1etjx0/azE2MeMDEun6J4L0D14TXz53ZuvshrnLWZaalcjymqbkbdmRnp
 wGgsA
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83
X-Rspamd-Queue-Id: 810BE4EA43B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-244576-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassiogabrielcontato@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

virtio-snd control handling trusts the device-provided control type and
value count returned by the device.

That metadata is then used directly to index g_v2a_type_map[] in
virtsnd_kctl_info(), and to size loops and memcpy() operations in
virtsnd_kctl_get() and virtsnd_kctl_put() against fixed-size
virtio_snd_ctl_value and snd_ctl_elem_value arrays.

A buggy or malicious device can therefore trigger out-of-bounds access by
advertising an invalid control type or an oversized value count.

Validate control type and count once in virtsnd_kctl_parse_cfg(), before
querying enumerated items or exposing the control to ALSA.

Fixes: d6568e3de42d ("ALSA: virtio: add support for audio controls")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
 sound/virtio/virtio_kctl.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/sound/virtio/virtio_kctl.c b/sound/virtio/virtio_kctl.c
index ffb903d56297..45f7b6a5b308 100644
--- a/sound/virtio/virtio_kctl.c
+++ b/sound/virtio/virtio_kctl.c
@@ -18,6 +18,21 @@ static const snd_ctl_elem_type_t g_v2a_type_map[] = {
 	[VIRTIO_SND_CTL_TYPE_IEC958] = SNDRV_CTL_ELEM_TYPE_IEC958
 };
 
+/* Map for converting VirtIO types to maximum value counts. */
+static const unsigned int g_v2a_count_map[] = {
+	[VIRTIO_SND_CTL_TYPE_BOOLEAN] =
+		ARRAY_SIZE(((struct virtio_snd_ctl_value *)0)->value.integer),
+	[VIRTIO_SND_CTL_TYPE_INTEGER] =
+		ARRAY_SIZE(((struct virtio_snd_ctl_value *)0)->value.integer),
+	[VIRTIO_SND_CTL_TYPE_INTEGER64] =
+		ARRAY_SIZE(((struct virtio_snd_ctl_value *)0)->value.integer64),
+	[VIRTIO_SND_CTL_TYPE_ENUMERATED] =
+		ARRAY_SIZE(((struct virtio_snd_ctl_value *)0)->value.enumerated),
+	[VIRTIO_SND_CTL_TYPE_BYTES] =
+		ARRAY_SIZE(((struct virtio_snd_ctl_value *)0)->value.bytes),
+	[VIRTIO_SND_CTL_TYPE_IEC958] = 1
+};
+
 /* Map for converting VirtIO access rights to ALSA access rights. */
 static const unsigned int g_v2a_access_map[] = {
 	[VIRTIO_SND_CTL_ACCESS_READ] = SNDRV_CTL_ELEM_ACCESS_READ,
@@ -36,6 +51,37 @@ static const unsigned int g_v2a_mask_map[] = {
 	[VIRTIO_SND_CTL_EVT_MASK_TLV] = SNDRV_CTL_EVENT_MASK_TLV
 };
 
+static int virtsnd_kctl_validate_info(struct virtio_snd *snd, u32 cid,
+				      struct virtio_snd_ctl_info *kinfo)
+{
+	struct virtio_device *vdev = snd->vdev;
+	unsigned int type = le32_to_cpu(kinfo->type);
+	unsigned int count = le32_to_cpu(kinfo->count);
+
+	if (type >= ARRAY_SIZE(g_v2a_type_map)) {
+		dev_err(&vdev->dev, "control #%u: unknown type %u\n",
+			cid, type);
+		return -EINVAL;
+	}
+
+	if (count > g_v2a_count_map[type] ||
+	    (type == VIRTIO_SND_CTL_TYPE_IEC958 && count != 1)) {
+		dev_err(&vdev->dev, "control #%u: invalid count %u for type %u\n",
+			cid, count, type);
+		return -EINVAL;
+	}
+
+	if (type == VIRTIO_SND_CTL_TYPE_ENUMERATED &&
+	    !le32_to_cpu(kinfo->value.enumerated.items)) {
+		dev_err(&vdev->dev,
+			"control #%u: no items for enumerated control\n",
+			cid);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /**
  * virtsnd_kctl_info() - Returns information about the control.
  * @kcontrol: ALSA control element.
@@ -385,6 +431,10 @@ int virtsnd_kctl_parse_cfg(struct virtio_snd *snd)
 		struct virtio_snd_ctl_info *kinfo = &snd->kctl_infos[i];
 		unsigned int type = le32_to_cpu(kinfo->type);
 
+		rc = virtsnd_kctl_validate_info(snd, i, kinfo);
+		if (rc)
+			return rc;
+
 		if (type == VIRTIO_SND_CTL_TYPE_ENUMERATED) {
 			rc = virtsnd_kctl_get_enum_items(snd, i);
 			if (rc)

---
base-commit: 5bddc5123566e6431fff826fe76a8e378ae9db78
change-id: 20260424-alsa-virtio-validate-kctl-info-2bbe3b5d5d65

Best regards,
--  
Cássio Gabriel <cassiogabrielcontato@gmail.com>


