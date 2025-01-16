Return-Path: <stable+bounces-109286-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F4CA13D9F
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 16:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25D20188B78C
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 15:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C94C22B8BD;
	Thu, 16 Jan 2025 15:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kg3LO/7E"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6A478F2B;
	Thu, 16 Jan 2025 15:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737041399; cv=none; b=AMnlciaUE/fI6ceRSRU5yGFr9fihlt2Q4mA0PL2jfUZ7J+v0VB7HlWcdtCooibJ1YH34TSeeNgLyD938epydhmtML849k/+2rSITjAO/lM/MnPMwqpf/VtjSef6ojNX2AeQqz8ot0T9nOz8PC4gowd7TQhIF/y84FVLxLTw7rUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737041399; c=relaxed/simple;
	bh=2frU9X7dbWLUl8WO2hD3vcwXOw47sVSnR2+r8CWLSKA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SjXBHC4MS9kOF1wi6lFhRgm53bmU4AUpJZRITh9JiuDE3uZtR6h/A8ZNM8agPaavazqhGByY1wOh7MApBlTQkzNVtmlZ7e1PWfphGm9KGohLCWxrtTWmJXok+lBtwHUAFcVMJPYG67WpOwPLZreA/JSe+yfHo+ya1Zduu87JHK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kg3LO/7E; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-385de59c1a0so647223f8f.2;
        Thu, 16 Jan 2025 07:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737041395; x=1737646195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8tw313LemcnV4eOs9J849ueqzSp6vM+lhTqL56doHZU=;
        b=kg3LO/7E2LceMkqHd/4cCQYz5qtQ1AnkrwXGW7RAV4Zpx39ufgGm4VxAd3GfLdLQlT
         W4EussN3nCYS1J/ngvo8ky3JO8WaSJYskAbebKwKzX2yKaajTAZPASxbB+WYdyRyl3Ur
         G8wAula5+bd45JHyQrjjNavTZRJWOe1pTP4a52liCryjARHLUd1jQSChgY/pz7lMAzyN
         UCEGJaUa31YF29szJZyfE6oLknlxK8yaX4mcE3/5QHr0P4f+x07Ydxbprtkb7dv88h+m
         Hce+4vuMGO8s5AoVajR/nHUD9+MXjc7bIcXNjljfiv+M3NkL4ef5AiKKpOBIbjMeZ0+R
         sBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737041395; x=1737646195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8tw313LemcnV4eOs9J849ueqzSp6vM+lhTqL56doHZU=;
        b=BvHXgrHQ0oyrUXtf46BPryu/6/dc4CZlJPrbqdRX28WAeHJcZ13bsg2u33nt/LXsg0
         h2W38TLG2lAl6ilBYLoMNwZUgj1jC7Q52N9sxpjavCMIInVEwi7sVJlWSOkUVQTHuAjT
         Qn/A3O8LEr1Q97ujsv0NfM9Dn8Bj8U9e1UdI6/JMrms3w6lv8zam5xVLNJbp8O7JbYAB
         4/uUx6l6YNn4kKoTgLnsh63IbxsjpeZj6SYT96kBYkNqKPJTj74L8yHnmsKYSAyUE0Sa
         UpmVbuiAmHnt1ptagcefYe7iqiAD3vJc1NCuj4iT/SANIbT/rhtDiQw9hkV6gAMRRFR8
         YPhg==
X-Forwarded-Encrypted: i=1; AJvYcCVZzPTwNJVdDhkZm0/j4CUWDLAL9dX0zP2MYwVMqw6oPhsr4DrT0xw5U/iLECKyHQ3JyTSTbUaiMUZ7c4o=@vger.kernel.org, AJvYcCWd/9mqbNLHHK1s+8y1W6591KmgvqBp4lZEI9cgY366TyL5Xhmy3G1F/VYC6uUonP2Irsy7ceqp@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb1x8sOvJ2JZVlECSPX5TCK8tWIFMeEoaXwfXQeuCuislWPdNt
	0Tx0GnC5vdTQ+DxyCkDCFZ+wey1H+IfpBDDECtX3zy0rSQQTJXUW
X-Gm-Gg: ASbGncsMsYPbblgOslTXWDs0fyhO0Exsn9o/PfkgkgrZCLPFapVXPn6x6nsyPqxBEdi
	QNm6a4wW8Liq5f+neJ9mlkK6Br6FRy3YGsPQkx2Zbmr1pFJP5iUvbHcGC7BHP1YscMJBPQyfSh0
	xyZ8zIf52Y48TY+67vr6m/F6lfrBrO3R8ZswaX2ARP6XeGcY6hSQ0R97fBUk99Z9Bz3OdSffSPG
	eoJo5z41O5WZZd37ltN08TjEuS8Unp2jxBcwuL3JUBINMZRToXeQe6RggBKDsrF2EvUOjo=
X-Google-Smtp-Source: AGHT+IEef8S7Jx5rYUCpDubnXGjnbOP3kPqHoI2nCeuf4dEPI9YGEFPuF5pDKiffY/hcSYgjAqouxA==
X-Received: by 2002:a5d:64cc:0:b0:385:e8ce:7483 with SMTP id ffacd0b85a97d-38a872faf34mr23870496f8f.4.1737041395360;
        Thu, 16 Jan 2025 07:29:55 -0800 (PST)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43890409758sm2800065e9.2.2025.01.16.07.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 07:29:55 -0800 (PST)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
	by home.paul.comp (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 50GFTpkn008705;
	Thu, 16 Jan 2025 18:29:52 +0300
Received: (from paul@localhost)
	by home.paul.comp (8.15.2/8.15.2/Submit) id 50GFTnrZ008702;
	Thu, 16 Jan 2025 18:29:49 +0300
From: Paul Fertser <fercerpav@gmail.com>
To: Potin Lai <potin.lai.pt@gmail.com>, Cosmo Chou <chou.cosmo@gmail.com>,
        Eddie James <eajames@linux.ibm.com>,
        Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ivan Mikhaylov <fr0st61te@gmail.com>,
        Paul Fertser <fercerpav@gmail.com>, stable@vger.kernel.org
Subject: [PATCH] net/ncsi: wait for the last response to Deselect Package before configuring channel
Date: Thu, 16 Jan 2025 18:29:00 +0300
Message-Id: <20250116152900.8656-1-fercerpav@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CAGfYmwVH1A+imBF5TLenLaSM0Zf0C5wgfgocYix9Ye_7siR_xQ@mail.gmail.com>
References: <CAGfYmwVH1A+imBF5TLenLaSM0Zf0C5wgfgocYix9Ye_7siR_xQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NCSI state machine as it's currently implemented assumes that
transition to the next logical state is performed either explicitly by
calling `schedule_work(&ndp->work)` to re-queue itself or implicitly
after processing the predefined (ndp->pending_req_num) number of
replies. Thus to avoid the configuration FSM from advancing prematurely
and getting out of sync with the process it's essential to not skip
waiting for a reply.

This patch makes the code wait for reception of the Deselect Package
response for the last package probed before proceeding to channel
configuration.

Thanks go to Potin Lai and Cosmo Chou for the initial investigation and
testing.

Fixes: 8e13f70be05e ("net/ncsi: Probe single packages to avoid conflict")
Cc: stable@vger.kernel.org
Signed-off-by: Paul Fertser <fercerpav@gmail.com>
---
 net/ncsi/ncsi-manage.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 5cf55bde366d..bf8e27b84a66 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -1373,6 +1373,12 @@ static void ncsi_probe_channel(struct ncsi_dev_priv *ndp)
 		nd->state = ncsi_dev_state_probe_package;
 		break;
 	case ncsi_dev_state_probe_package:
+		if (ndp->package_probe_id >= 8) {
+			/* Last package probed, finishing */
+			ndp->flags |= NCSI_DEV_PROBED;
+			break;
+		}
+
 		ndp->pending_req_num = 1;
 
 		nca.type = NCSI_PKT_CMD_SP;
@@ -1489,13 +1495,8 @@ static void ncsi_probe_channel(struct ncsi_dev_priv *ndp)
 		if (ret)
 			goto error;
 
-		/* Probe next package */
+		/* Probe next package after receiving response */
 		ndp->package_probe_id++;
-		if (ndp->package_probe_id >= 8) {
-			/* Probe finished */
-			ndp->flags |= NCSI_DEV_PROBED;
-			break;
-		}
 		nd->state = ncsi_dev_state_probe_package;
 		ndp->active_package = NULL;
 		break;
-- 
2.34.1


