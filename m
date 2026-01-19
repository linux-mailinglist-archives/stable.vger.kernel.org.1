Return-Path: <stable+bounces-210289-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B08CBD3A312
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 10:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E37C305FFF3
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 09:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85D2355808;
	Mon, 19 Jan 2026 09:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MqgkSDpR"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6970035505D
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 09:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768814977; cv=none; b=NzH0adDw1Zm46uVKo4OiNjbOzJr8BY/dIYaDdhYKOZ2+JKl1Ns+ItPlCMAySQNpyPB44VCb22o1BwMfg35fT4nchRoEioI/mDjn9LtPv2jq/qt0d95b0Qi1wHieTD4sxPDyoRO8m9J0wMooVNIEHdsNtuN5gis4e0clfdswtL4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768814977; c=relaxed/simple;
	bh=hEuFfiVAIzcj3M75mKqycaVCpNxANYHyfkOL6P6Enrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W2lbLvDLYz4vBulj5FYY1lR0CTtdA8aUluMxbUCYInGae6lqA0zYblkisN/oOBpRZEK3UJtBBHqS882BESojCwTpWCCxvJN0uzEAF8oq4IX00lxQO4nFhRDL/L/mSB+dwIFEmz1pRTYR4B8fEKgfQYZF+MUQhZqi9Gh3fguDvBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MqgkSDpR; arc=none smtp.client-ip=209.85.215.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-c5ee7aeac24so50856a12.3
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 01:29:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768814976; x=1769419776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w50P3TMsI17A7OyOfUkdCQ9JI+NWMHZi/Bip0DiUgH0=;
        b=hFBOBOgNCpwLs6QRLJLUoKfra/P/HM3Wt76l4rjw8oXvLnpYvVuH0odzrOyyWnj5tf
         4PUcZenl/bpt2p9NKgh4MKruZSqSSlDEZLa4isc3tjCNv2YEj2iQ1qHTGqQjttOOHALC
         GqVm0P6a1etWNTCcgUz3s7ZD01Yi5Qm7EaXSrlMhQdhHnuGSxvC4Wt2oJiwP58wgy0lY
         zg79aLjiLFWg7fDi3nNzBhDhNetqki+eHgbTOxe0sNCK6r748fcWWSrRHWSLt0KResP2
         tywDtiP00gxW234ToqL0k5YOX3x+SiBG+oLDDhL3sq4yJ5R3pLS4KMvfPZvRZxSo/dKU
         hl6g==
X-Gm-Message-State: AOJu0YwD+dAmkWIQZdCM53TsgNPOPaasu+5h7idndM5HuWebsScA0J+V
	t4SluC1neyXFQd48FQMbIFRbgX5rrhXUDLh7cvtUJrfCNESoM8upr6QZuzsgjoSB1X8c3rZaSaj
	i3ypG4LOIJ3zvueAJcpsqIe9UcSFjNba9e7PT/i4hBA9mlEcaEY/Ni5E9sYzK94j8mLlF6o9qIp
	5+dvQn9L1wnlRm8/+9HvAo7XTuy5boONoZFbrn8djneh2nEyyTJrCS5Lpc8iVNWzQ231gAWt6aP
	ZU7Wk+WXsWMVWhN6XHhfusUpB4c
X-Gm-Gg: AZuq6aIr3JRYPuG7HMyrx3uS5qvtOFKJ4Vs7+qN1uyWf5IuBcq5nvXFJ5gy00usF/sy
	C0hmeRmMWJcmXZG+mpgRWs/tnfN1FXKwwuyJI/Ih+uIMmWz/fS2IlcCbvmWJyBxGYg4YtUAEXCt
	EVX3mymQawsp7OxhckOCh3WO6S2zthWoUe8e/X/sPZPUKXhwFUjhvk0aeYX4VtsxZY8ln2szwRf
	5PF20HKSbaQ2NE4ymPoX/4ihl7IFyIzFKhPo+eSSmanXe1GxTqd8Yplv+rDBhfY3dpWpLrUQfGu
	mNZfppeSAKTvEFtTGO1R9sIApj3lw7EPC6uBwkvCN7OpuuYQUP57fteZ40NKgY2NoX+HHLKKomn
	h51JfwXkVqcE0wnHKMVhTH/P3QYKToyZ3TmRFVBUGaD1chYaLql+HltZ3t0Tdbr16JmYicPDUTK
	aoLGrcKVz+XO86IA0Xzf1bqVtmgu3Y4SOCVQ/qYafz84nse0tZ5RrI/0Nzhoc=
X-Received: by 2002:a17:903:3846:b0:29e:3822:5763 with SMTP id d9443c01a7336-2a71781faf9mr86185165ad.9.1768814975727;
        Mon, 19 Jan 2026 01:29:35 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a7193ac200sm14445355ad.57.2026.01.19.01.29.35
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jan 2026 01:29:35 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-890587202c0so7156986d6.3
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 01:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768814974; x=1769419774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w50P3TMsI17A7OyOfUkdCQ9JI+NWMHZi/Bip0DiUgH0=;
        b=MqgkSDpR1raz4ko12KVPeIM+rVaCKGlXxZVfUanpl9acIJ+N0B5vqMG7ZxDlu13rql
         0wHxTMCJ0CSnhVx8W8rTw5qIaktBV/5PQlDCHMmKxgJ21h0P7e839r31VtYxEHYv+PwZ
         PhvzMer4Ph72bo0BzVPNTaQDgz7b11aljDMCo=
X-Received: by 2002:a05:6214:3307:b0:87d:ad10:215b with SMTP id 6a1803df08f44-8942dbed48dmr128843046d6.1.1768814973977;
        Mon, 19 Jan 2026 01:29:33 -0800 (PST)
X-Received: by 2002:a05:6214:3307:b0:87d:ad10:215b with SMTP id 6a1803df08f44-8942dbed48dmr128842706d6.1.1768814973490;
        Mon, 19 Jan 2026 01:29:33 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6ad6f3sm76917516d6.36.2026.01.19.01.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 01:29:32 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: j.vosburgh@gmail.com,
	vfalico@gmail.com,
	andy@greyhouse.net,
	davem@davemloft.net,
	kuba@kernel.org,
	kuznet@ms2.inr.ac.ru,
	yoshfuji@linux-ipv6.org,
	borisp@nvidia.com,
	aviadye@nvidia.com,
	john.fastabend@gmail.com,
	daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	kafai@fb.com,
	songliubraving@fb.com,
	yhs@fb.com,
	kpsingh@kernel.org,
	carlos.soto@broadcom.com,
	simon.horman@corigine.com,
	luca.czesla@mail.schwarzv,
	felix.huettner@mail.schwarz,
	ilyal@mellanox.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Tariq Toukan <tariqt@nvidia.com>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v2 v5.10.y 2/5] net/bonding: Take IP hash logic into a helper
Date: Mon, 19 Jan 2026 09:25:59 +0000
Message-ID: <20260119092602.1414468-3-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260119092602.1414468-1-keerthana.kalyanasundaram@broadcom.com>
References: <20260119092602.1414468-1-keerthana.kalyanasundaram@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Tariq Toukan <tariqt@nvidia.com>

[ Upstream commit 5b99854540e35c2c6a226bcdb4bafbae1bccad5a ]

Hash logic on L3 will be used in a downstream patch for one more use
case.
Take it to a function for a better code reuse.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 drivers/net/bonding/bond_main.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 08bc930afc4c..b4b2e6a7fdd4 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3678,6 +3678,16 @@ static bool bond_flow_dissect(struct bonding *bond, struct sk_buff *skb,
 	return true;
 }
 
+static u32 bond_ip_hash(u32 hash, struct flow_keys *flow)
+{
+	hash ^= (__force u32)flow_get_u32_dst(flow) ^
+		(__force u32)flow_get_u32_src(flow);
+	hash ^= (hash >> 16);
+	hash ^= (hash >> 8);
+	/* discard lowest hash bit to deal with the common even ports pattern */
+	return hash >> 1;
+}
+
 /**
  * bond_xmit_hash - generate a hash value based on the xmit policy
  * @bond: bonding device
@@ -3708,12 +3718,8 @@ u32 bond_xmit_hash(struct bonding *bond, struct sk_buff *skb)
 		else
 			memcpy(&hash, &flow.ports.ports, sizeof(hash));
 	}
-	hash ^= (__force u32)flow_get_u32_dst(&flow) ^
-		(__force u32)flow_get_u32_src(&flow);
-	hash ^= (hash >> 16);
-	hash ^= (hash >> 8);
 
-	return hash >> 1;
+	return bond_ip_hash(hash, &flow);
 }
 
 /*-------------------------- Device entry points ----------------------------*/
-- 
2.43.7


