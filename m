Return-Path: <stable+bounces-180455-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D378B8222C
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 00:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83B43189B3C6
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 22:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D7828B4F0;
	Wed, 17 Sep 2025 22:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WX78lBrd"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0A9283FE0
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 22:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758147434; cv=none; b=ER7UOms6WCqbNC68nq2YSsYryYyUbtfv+SIYfmzcNYcztkl796m9fLmisg2dsxnRcyX3nHuX94XRJdSGZTMR4pzk7z5EOrjsled+aO1XgGcgAIFbeyb9E6w0Fs5hXEzCjunLLnSCDvfbFKwAhfvryxaxfKHH8SA5aMQUpXPjrwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758147434; c=relaxed/simple;
	bh=aHZeu5qDnPqojAmGTfonqzkuPFF1kZQN7aEp3tfwUXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rhQLvFTB3DSx52KDl+eKQ5sItMbBPKgxVsZvK7BLsOzuVw7PbVTIJ9T4qSfissvMCQgW4eoT0bMMlNUTz4bk5JyMnxlXlwRcXggTaC7T+zi+JHsByM63RAOdbmkMizNF3ydzmGSNXPnKws4rLq+kfc3vpHN4UoMmpAQDRFEvZsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WX78lBrd; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-828690f9128so46360585a.1
        for <stable@vger.kernel.org>; Wed, 17 Sep 2025 15:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758147431; x=1758752231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xa3yo25BGb5QXTm6h6LVtVVr0Qv0U1W6abN8HywD/+4=;
        b=WX78lBrdAb28fbI9vB93lIWM5AAIKIKELt4zU9vd+UpmhYCY2Q8olHyAXXW+QF1zse
         BEUFrIj+2jGuZWgsoTQxYzyyvH0SANJorGRZzhNptjhKmTQ4LZMaSojb361Njy2w/MOt
         +ASAWC1RUKWPxN5F+NO9v9JkFm0tih6IwBVeznrsucGTTNggZvbzG5hOj1z7I7q+lsaI
         IXnN1n6Q2ulpd+w4BIGQtVm1UQIaf5EHzMBa01XQzXOM4Bu14QDcXAYKfmU1IUD1w7OP
         RpKpXXF6TITN4Bnhu6btvYHpStD66yveMv+4gLRwA7SOY/dZcm8+o4W8Sl5h+qAD/D83
         L2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758147431; x=1758752231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xa3yo25BGb5QXTm6h6LVtVVr0Qv0U1W6abN8HywD/+4=;
        b=ICn2PmMR2uSNkFRa84ZZNyEHZ+qcSO73h4DxQWfoHoYjgFvRCsRn/SmsYcq286+bqL
         aBAHzKNYtbDQ8XFBNt5aOwrNf8AvLZMw1eilM8s+EBMvmVcLIr4iFok48nI0neIpyE2m
         kksc7VsbB/PCXcMaoCHhNMbC/LY/uyqG5G7crRjeQAUIVyX82U3gaXIhA45G9udvAI97
         Ut1EgcIsuRAL6WDjuhqDfvjaGAeB34jW0WX/IZo4Q++ZYCsNVg0mzNMDRvnM9fi6qtoC
         B6SMzQliwGzIstIV1Trxh+EuGg0wiD8fsimlsVQ65kNu+a5LFE5RWxaifJ66JYm6G3yP
         1RXw==
X-Forwarded-Encrypted: i=1; AJvYcCXa/HozN6guxOqbRBckGQabxWq7ZbxcGCC7t9lHgetM1firHSJiAgw8fpXk8StE1GW89E4626I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBBPigHeSZYk6/dtSJWI59pLXvuiIhe3SA1MRCktRTJaZk8aJz
	eINnNu5z9P3EQ23nb+WI81uplY1+t4z4q4GoWdFQYrwMPOjkTNmhOwuo
X-Gm-Gg: ASbGncvJlQqAh1O2jG+aVsuiPAvMPYmkRTMoLcL4kufztnuFbd136tcJHdsn31AmS1h
	AlzUfW2Erm5NnLyg4PXZ6iR5HreKVHOt3SL5fFmVr/K2WDiD350zdBhk1HiSsbjE69gWvz7fD8p
	Op7kfckxkBN7Uack7QeK9OeUWIgWzn95PLIAPo2IKJPtHx+bJQxA3ZtTd51Wjz3h7zSH5KwcG6I
	J3TCIRpEhi3cLNnZ205LyZD+oJydPGD8+O1VsY2TwB/koLXocoiGQDy0uc4P1UfKIgOoP7EMav1
	W/nyZjK7YZ7NVr7tMi5ClMEgDxzUvlsgr6XHtcnDHFQfIB5wlgHeiAvTA/+2LqXISgv5Uxok/RY
	t/AWPM5JFNNroMPjpe7+Rw3MiuBnYjKL6c18g25uGNNNK
X-Google-Smtp-Source: AGHT+IEwjb2Kp+GIUj/WLhLhGcnGWLjcvQLBWFXHEqHZP6464w/fkAwzWfg97roIGqJsXaSfLy8k+g==
X-Received: by 2002:a05:620a:284b:b0:80a:99d2:be72 with SMTP id af79cd13be357-8310d075307mr409682585a.21.1758147431399;
        Wed, 17 Sep 2025 15:17:11 -0700 (PDT)
Received: from jl.umd.edu ([129.2.89.30])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-836305769ecsm53149185a.42.2025.09.17.15.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 15:17:10 -0700 (PDT)
From: julian-lagattuta <julian.lagattuta@gmail.com>
To: julian.lagattuta@gmail.com
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>,
	stable@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 03/39] Bluetooth: L2CAP: Fix L2CAP MTU negotiation
Date: Wed, 17 Sep 2025 18:16:06 -0400
Message-ID: <20250917221641.30226-4-julian.lagattuta@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250917221641.30226-2-julian.lagattuta@gmail.com>
References: <20250917221641.30226-2-julian.lagattuta@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Frédéric Danis <frederic.danis@collabora.com>

OBEX download from iPhone is currently slow due to small packet size
used to transfer data which doesn't follow the MTU negotiated during
L2CAP connection, i.e. 672 bytes instead of 32767:

  < ACL Data TX: Handle 11 flags 0x00 dlen 12
      L2CAP: Connection Request (0x02) ident 18 len 4
        PSM: 4103 (0x1007)
        Source CID: 72
  > ACL Data RX: Handle 11 flags 0x02 dlen 16
      L2CAP: Connection Response (0x03) ident 18 len 8
        Destination CID: 14608
        Source CID: 72
        Result: Connection successful (0x0000)
        Status: No further information available (0x0000)
  < ACL Data TX: Handle 11 flags 0x00 dlen 27
      L2CAP: Configure Request (0x04) ident 20 len 19
        Destination CID: 14608
        Flags: 0x0000
        Option: Maximum Transmission Unit (0x01) [mandatory]
          MTU: 32767
        Option: Retransmission and Flow Control (0x04) [mandatory]
          Mode: Enhanced Retransmission (0x03)
          TX window size: 63
          Max transmit: 3
          Retransmission timeout: 2000
          Monitor timeout: 12000
          Maximum PDU size: 1009
  > ACL Data RX: Handle 11 flags 0x02 dlen 26
      L2CAP: Configure Request (0x04) ident 72 len 18
        Destination CID: 72
        Flags: 0x0000
        Option: Retransmission and Flow Control (0x04) [mandatory]
          Mode: Enhanced Retransmission (0x03)
          TX window size: 32
          Max transmit: 255
          Retransmission timeout: 0
          Monitor timeout: 0
          Maximum PDU size: 65527
        Option: Frame Check Sequence (0x05) [mandatory]
          FCS: 16-bit FCS (0x01)
  < ACL Data TX: Handle 11 flags 0x00 dlen 29
      L2CAP: Configure Response (0x05) ident 72 len 21
        Source CID: 14608
        Flags: 0x0000
        Result: Success (0x0000)
        Option: Maximum Transmission Unit (0x01) [mandatory]
          MTU: 672
        Option: Retransmission and Flow Control (0x04) [mandatory]
          Mode: Enhanced Retransmission (0x03)
          TX window size: 32
          Max transmit: 255
          Retransmission timeout: 2000
          Monitor timeout: 12000
          Maximum PDU size: 1009
  > ACL Data RX: Handle 11 flags 0x02 dlen 32
      L2CAP: Configure Response (0x05) ident 20 len 24
        Source CID: 72
        Flags: 0x0000
        Result: Success (0x0000)
        Option: Maximum Transmission Unit (0x01) [mandatory]
          MTU: 32767
        Option: Retransmission and Flow Control (0x04) [mandatory]
          Mode: Enhanced Retransmission (0x03)
          TX window size: 63
          Max transmit: 3
          Retransmission timeout: 2000
          Monitor timeout: 12000
          Maximum PDU size: 1009
        Option: Frame Check Sequence (0x05) [mandatory]
          FCS: 16-bit FCS (0x01)
  ...
  > ACL Data RX: Handle 11 flags 0x02 dlen 680
      Channel: 72 len 676 ctrl 0x0202 [PSM 4103 mode Enhanced Retransmission (0x03)] {chan 8}
      I-frame: Unsegmented TxSeq 1 ReqSeq 2
  < ACL Data TX: Handle 11 flags 0x00 dlen 13
      Channel: 14608 len 9 ctrl 0x0204 [PSM 4103 mode Enhanced Retransmission (0x03)] {chan 8}
      I-frame: Unsegmented TxSeq 2 ReqSeq 2
  > ACL Data RX: Handle 11 flags 0x02 dlen 680
      Channel: 72 len 676 ctrl 0x0304 [PSM 4103 mode Enhanced Retransmission (0x03)] {chan 8}
      I-frame: Unsegmented TxSeq 2 ReqSeq 3

The MTUs are negotiated for each direction. In this traces 32767 for
iPhone->localhost and no MTU for localhost->iPhone, which based on
'4.4 L2CAP_CONFIGURATION_REQ' (Core specification v5.4, Vol. 3, Part
A):

  The only parameters that should be included in the
  L2CAP_CONFIGURATION_REQ packet are those that require different
  values than the default or previously agreed values.
  ...
  Any missing configuration parameters are assumed to have their
  most recently explicitly or implicitly accepted values.

and '5.1 Maximum transmission unit (MTU)':

  If the remote device sends a positive L2CAP_CONFIGURATION_RSP
  packet it should include the actual MTU to be used on this channel
  for traffic flowing into the local device.
  ...
  The default value is 672 octets.

is set by BlueZ to 672 bytes.

It seems that the iPhone used the lowest negotiated value to transfer
data to the localhost instead of the negotiated one for the incoming
direction.

This could be fixed by using the MTU negotiated for the other
direction, if exists, in the L2CAP_CONFIGURATION_RSP.
This allows to use segmented packets as in the following traces:

  < ACL Data TX: Handle 11 flags 0x00 dlen 12
        L2CAP: Connection Request (0x02) ident 22 len 4
          PSM: 4103 (0x1007)
          Source CID: 72
  < ACL Data TX: Handle 11 flags 0x00 dlen 27
        L2CAP: Configure Request (0x04) ident 24 len 19
          Destination CID: 2832
          Flags: 0x0000
          Option: Maximum Transmission Unit (0x01) [mandatory]
            MTU: 32767
          Option: Retransmission and Flow Control (0x04) [mandatory]
            Mode: Enhanced Retransmission (0x03)
            TX window size: 63
            Max transmit: 3
            Retransmission timeout: 2000
            Monitor timeout: 12000
            Maximum PDU size: 1009
  > ACL Data RX: Handle 11 flags 0x02 dlen 26
        L2CAP: Configure Request (0x04) ident 15 len 18
          Destination CID: 72
          Flags: 0x0000
          Option: Retransmission and Flow Control (0x04) [mandatory]
            Mode: Enhanced Retransmission (0x03)
            TX window size: 32
            Max transmit: 255
            Retransmission timeout: 0
            Monitor timeout: 0
            Maximum PDU size: 65527
          Option: Frame Check Sequence (0x05) [mandatory]
            FCS: 16-bit FCS (0x01)
  < ACL Data TX: Handle 11 flags 0x00 dlen 29
        L2CAP: Configure Response (0x05) ident 15 len 21
          Source CID: 2832
          Flags: 0x0000
          Result: Success (0x0000)
          Option: Maximum Transmission Unit (0x01) [mandatory]
            MTU: 32767
          Option: Retransmission and Flow Control (0x04) [mandatory]
            Mode: Enhanced Retransmission (0x03)
            TX window size: 32
            Max transmit: 255
            Retransmission timeout: 2000
            Monitor timeout: 12000
            Maximum PDU size: 1009
  > ACL Data RX: Handle 11 flags 0x02 dlen 32
        L2CAP: Configure Response (0x05) ident 24 len 24
          Source CID: 72
          Flags: 0x0000
          Result: Success (0x0000)
          Option: Maximum Transmission Unit (0x01) [mandatory]
            MTU: 32767
          Option: Retransmission and Flow Control (0x04) [mandatory]
            Mode: Enhanced Retransmission (0x03)
            TX window size: 63
            Max transmit: 3
            Retransmission timeout: 2000
            Monitor timeout: 12000
            Maximum PDU size: 1009
          Option: Frame Check Sequence (0x05) [mandatory]
            FCS: 16-bit FCS (0x01)
  ...
  > ACL Data RX: Handle 11 flags 0x02 dlen 1009
        Channel: 72 len 1005 ctrl 0x4202 [PSM 4103 mode Enhanced Retransmission (0x03)] {chan 8}
        I-frame: Start (len 21884) TxSeq 1 ReqSeq 2
  > ACL Data RX: Handle 11 flags 0x02 dlen 1009
        Channel: 72 len 1005 ctrl 0xc204 [PSM 4103 mode Enhanced Retransmission (0x03)] {chan 8}
        I-frame: Continuation TxSeq 2 ReqSeq 2

This has been tested with kernel 5.4 and BlueZ 5.77.

Cc: stable@vger.kernel.org
Signed-off-by: Frédéric Danis <frederic.danis@collabora.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index a5bde5db58ef..40daa38276f3 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3415,7 +3415,7 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
 	struct l2cap_conf_rfc rfc = { .mode = L2CAP_MODE_BASIC };
 	struct l2cap_conf_efs efs;
 	u8 remote_efs = 0;
-	u16 mtu = L2CAP_DEFAULT_MTU;
+	u16 mtu = 0;
 	u16 result = L2CAP_CONF_SUCCESS;
 	u16 size;
 
@@ -3520,6 +3520,13 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
 		/* Configure output options and let the other side know
 		 * which ones we don't like. */
 
+		/* If MTU is not provided in configure request, use the most recently
+		 * explicitly or implicitly accepted value for the other direction,
+		 * or the default value.
+		 */
+		if (mtu == 0)
+			mtu = chan->imtu ? chan->imtu : L2CAP_DEFAULT_MTU;
+
 		if (mtu < L2CAP_DEFAULT_MIN_MTU)
 			result = L2CAP_CONF_UNACCEPT;
 		else {
-- 
2.45.2


