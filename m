Return-Path: <stable+bounces-235562-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPJNFEB62GkFdwgAu9opvQ
	(envelope-from <stable+bounces-235562-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 06:19:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B16753D2061
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 06:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 261283015840
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 04:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2656D325704;
	Fri, 10 Apr 2026 04:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKdtQT4t"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74DE2D97BA
	for <stable@vger.kernel.org>; Fri, 10 Apr 2026 04:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775794745; cv=none; b=NaprooFjQGHRcUxCqYBejyhdqg8WUYqPeYeDFjcplaxTGJSKH2IF/tEEm1k08/nV5kIAa4PRlaevdJpUmqRjIpR5iHjt1hJa5smlN0OpV67+hEhfgagk52x1nB/L8sdy8dJKbphnwaMiO1CgXjuQoExeRNlS5iHFDvdDGW5cwxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775794745; c=relaxed/simple;
	bh=NEUcm4XzPfP/HJy8rIOWDFJWp7Ebx68TFO0vLONSQsw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XD2xOdthLGb+Y2DQWUis7SUsqQW+EZSvbI82ix+SyZYtSFxAa9Tw+sk72pEH9Q8Yq1CF+DwHuDYfYiUqt0bE63KEmMHPCFr+RawoUOQo4Y81fVeJpqe+g3++d1GyWTw2uUK4BauH2Fs1jEeT5N40M1r3dRMrQQctqnqVCfMQWYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKdtQT4t; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8a151012558so19179216d6.3
        for <stable@vger.kernel.org>; Thu, 09 Apr 2026 21:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775794743; x=1776399543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ArSw/Jy6VI8sSzLBGSoBorIgScihUu+vrKWP2sPCXow=;
        b=nKdtQT4tjffo4RTnMAfp7y9y4WGKPge6DfPHVcres02jEvUBWEFM4wMJ5biaja4ew4
         rDvStteyZfsR2AYlFXKgwnYlFyiXTxRyrwJJeCWaSosDpvlXIhjFa5DhnbEJswdS3IdJ
         4ql69eWYUuse6CP23QW9SjfIQN2Ba/WsZ/cYQdFV75dn2Cc77RBNPcGlbVG8qcU9zIFF
         uKYu8u93ZfEjQma2gcW31hLYVC0crU2sk1yLkAmnv7FFRSgZbCvjqYfsuAVLCUAggj7w
         Fdjl/aOgogh0eaMAGDoPwaWPBqvU8QICNa8SrqJzsksJje0jifV2uSPLRWX+52q6U8YB
         ZAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775794743; x=1776399543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ArSw/Jy6VI8sSzLBGSoBorIgScihUu+vrKWP2sPCXow=;
        b=G7FR+JaKYyEgh7+AzodndJ99Ux3SylLYocaObbZbNQZTvyA4QLYf33fEfSoiud86ZR
         ggkbASNBQexg5y9Ljq6HmLgYS9Q/0kY4qu67k4e73sQ9jOnNs+L9we7BCEdXX+FOew5A
         /5X6m+WtpxSRzO6y0TGo0PycP/F4f/OrmkqYSTq3Ew+guBov8US5kdnJFpx+ah2iTnsc
         EeB3PRsVGlvAZv2ZxHAosRxX9h43EgCAUJbak06kguw1bIGqXbK86Oe9M4iPudhGt8ZE
         Lt20H1nx5XzaeRsLTKUaoiAn1vQE/Mdc4Y+bMhmmbIk4sig/DyJkpUJbgLk34S9hKrpd
         7o+A==
X-Gm-Message-State: AOJu0YwZeKzwuz0K5ACLIAomUol2/gLHPfWAA7B/a9ZUkJDrHzAaOrh0
	oQ/FqT6NPU2753BsBTHIxrqpvRn+0VO8D7XWceNyu/2IR+tE9rgwYNVN
X-Gm-Gg: AeBDievhqVvk/gdu0LXZejK8aJyQig9uq98zCze7IprNB6cEL1EM0NXcFyTLJF+yFb1
	cbS6Gm9zl/zdSNFTz2wKIpo2l009AI0Uhq79E+d/FoHwTTXuvFJpGZCYGKOocpywwsM04syKH3f
	9Xu2lgqRpRhtw/XSpO7OdVSqDzONSagu0HzPWRbD2aniZJvriIANNv2tqNgTITE2L9p9wbXyfwZ
	CNlZD22dLkOiJ0YuxRMTTOeVghZb/6CTfrb1iK8VBdnOPNPVAmBkqt9DXJvbsi/r1i1I6cjlNNz
	bsGoeaZltR7oX7yTJYTMjyHeIr/s40OSDViCNmd5VH1bUZ+cNAiqRv6AfhAAl9KGkDZQDC+2V/q
	t6y/x2FGt5B2VPtqISg9irGvvoWKu6E7+AH5he44E26Q31qKzYXhFRXFMAuwps/oBx8k++dBH2a
	vBXR4oM3qVy9RzGU3oL4QPjppqlz0xp39rn/tAfCcYCdZ0WDPkEJgNLSPQebGDVOZXUNWa/Fqud
	OLutN9cepX7yqN9Fv7sAA4sqJ4m
X-Received: by 2002:a05:6214:54c4:b0:89f:123c:4d9c with SMTP id 6a1803df08f44-8ac861ad302mr23047736d6.18.1775794743411;
        Thu, 09 Apr 2026 21:19:03 -0700 (PDT)
Received: from TDC4045031631.e0cglfehwr0e5gttmepj3hi3hf.ux.internal.cloudapp.net ([20.63.37.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac84a104ddsm12905896d6.14.2026.04.09.21.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 21:19:03 -0700 (PDT)
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org,
	Lyude Paul <lyude@redhat.com>,
	Dave Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Ashutosh Desai <ashutoshdesai993@gmail.com>
Subject: [PATCH] drm/dp/mst: fix buffer overflows in sideband chunk accumulation
Date: Fri, 10 Apr 2026 04:19:01 +0000
Message-Id: <20260410041901.2438960-1-ashutoshdesai993@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,gmail.com,ffwll.ch];
	TAGGED_FROM(0.00)[bounces-235562-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ashutoshdesai993@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B16753D2061
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

drm_dp_sideband_append_payload() has three related bugs when processing
device-provided sideband reply data:

1. Zero-length curchunk_len underflow: msg_len is a 6-bit field taken
   directly from the DP sideband header. If a device sends msg_len=0,
   curchunk_len is set to zero. The condition (curchunk_idx >= curchunk_len)
   is immediately true, and curchunk_len-1 wraps to 255 (u8 underflow).
   drm_dp_msg_data_crc4() reads 255 bytes from chunk[48], then memcpy()
   writes 255 bytes into msg[], both far out of bounds.

2. chunk[48] overflow: curchunk_len can reach 63 (6-bit field). chunk[] is
   only 48 bytes. Multi-iteration payload assembly appends 16-byte blocks
   until curchunk_idx reaches curchunk_len, writing up to 15 bytes past
   the end of chunk[] into msg[].

3. msg[256] overflow: each chunk contributes (curchunk_len-1) bytes to
   msg[]. No check ensures curlen + (curchunk_len-1) stays within msg[256],
   so the memcpy can spill into adjacent struct fields.

All three are reachable from any DP MST device that can forge sideband
reply messages on a physical connection.

Cc: stable@vger.kernel.org
Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
---
 drivers/gpu/drm/display/drm_dp_mst_topology.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index f2a7dbc5e..5261a4a54 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -789,6 +789,12 @@ static bool drm_dp_sideband_append_payload(struct drm_dp_sideband_msg_rx *msg,
 {
 	u8 crc4;
 
+	/* curchunk_len must be >= 1 (min 1 CRC byte) and fit in chunk[] */
+	if (!msg->curchunk_len ||
+	    msg->curchunk_len > ARRAY_SIZE(msg->chunk) ||
+	    msg->curchunk_idx + replybuflen > ARRAY_SIZE(msg->chunk))
+		return false;
+
 	memcpy(&msg->chunk[msg->curchunk_idx], replybuf, replybuflen);
 	msg->curchunk_idx += replybuflen;
 
@@ -799,6 +805,9 @@ static bool drm_dp_sideband_append_payload(struct drm_dp_sideband_msg_rx *msg,
 			print_hex_dump(KERN_DEBUG, "wrong crc",
 				       DUMP_PREFIX_NONE, 16, 1,
 				       msg->chunk,  msg->curchunk_len, false);
+		/* Guard against accumulated msg[] overflow */
+		if (msg->curlen + msg->curchunk_len - 1 > ARRAY_SIZE(msg->msg))
+			return false;
 		/* copy chunk into bigger msg */
 		memcpy(&msg->msg[msg->curlen], msg->chunk, msg->curchunk_len - 1);
 		msg->curlen += msg->curchunk_len - 1;
-- 
2.34.1


