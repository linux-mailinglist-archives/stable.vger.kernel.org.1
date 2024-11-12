Return-Path: <stable+bounces-92824-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8A39C600C
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 19:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 809231F21CEA
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 18:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F5121730C;
	Tue, 12 Nov 2024 18:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="XiZTzKH4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EB3215C77
	for <stable@vger.kernel.org>; Tue, 12 Nov 2024 18:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731435249; cv=none; b=M6iGdUIrdYrwqsORi150J1NC8aSgX/pmndOKHsYAVNxb0AyZfJayFHdi+3WUxRSn2z//b6O5/ohCcMLyHEn4rkItYvzRA9CTfpeCuVdzk8LrwIr7bVrjY0mCRtGAm/72a2zBbjvHO+OHwqj/x7ivj663/8wFXxRgMjnpj6AnkT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731435249; c=relaxed/simple;
	bh=m4IUo/6+jT3GJMI/KjjBd5O43l+Kv6mXo2TjJbd0l2I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YAsYfSG36HByEnW5JsSsrk0DM/65L5RkpLNW6JImN8IJ0jF5tRj+Se1qzWisX31kZW8IwAG/Azs3oDpQUXnCRfJ0KSBSC67bi44idlI+du9co/tVe1ekVdfwmFMuJO/vN608wQs09nmTjERiASRY3JnsA+UqrJNwfEBHKVbwLGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=XiZTzKH4; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20cb47387ceso62382895ad.1
        for <stable@vger.kernel.org>; Tue, 12 Nov 2024 10:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731435247; x=1732040047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=teWV7RlCNBWe+PzZ4k+NAZdNBT+7H7hRE9gJ+PBKThU=;
        b=XiZTzKH405YZ3xOur+O6cWsTdExJIzWK6PNkkYEvbHMZ7Njo2Gy5INpID5NpsuB9DT
         AKBk+Ns/9wqir/RuTI1kv54puPz5um13iaa/ON1kaGQMZtVm2UyyVRON+/b3l7ebOoJM
         SHCtQnTxLtGmT9Pf/8QhMCx9pf7HpyGG2v+gQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731435247; x=1732040047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=teWV7RlCNBWe+PzZ4k+NAZdNBT+7H7hRE9gJ+PBKThU=;
        b=Q5eZuVk+Hnqrs1H2n7HwHx0iIbtEkRhEFvcN6RWxn86cV4zvQlQg+pOOsU+5m201tv
         Pn780uk5uz2ue9Ua/bqJXntgnjltdSX0GXRYamEPY1jYXTw9PhNpmUdUJAgs/N11ulwF
         eKjuHSuyAXeJS+qoEWL+YizEozWaN6EFmBPhgiSm9lvCvkv8i8hFNwM7lCOx2iqzR9ra
         mG+DfnPynbIXw63cinxyg8BbkAHx+JDDBgyOem6aq/BTNTIVPbHDfuMwGYn3umEto1SU
         ZRZ//f/EEL1MCRS+Xs4i3xLGK5xeC2S0IxYzCIsprmw8+nOcDmwGgF/Hdpc85C/z2X3B
         nsng==
X-Forwarded-Encrypted: i=1; AJvYcCWLGRTteWMSRkKBhXGAGrX8PVxNwE6YTRvoR7MQ6bPSG+qlZh7kAJoijFtuI9zPeUOUMGymMTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEhWbfQFE50eiq2xSatz4+PqjmfnEAK43xVH1XpegmrEfPDc4Y
	jvF4ZjIkUqrY16wQMrGtsmThzYDniajh+C2JNKCgbcufrnyKC2XdvkhehvwzgM4=
X-Google-Smtp-Source: AGHT+IFkvYy2Fn69Yhbz4h/Ou4o/m5wZnP9kf467luoR95X+WqKPdUDcTvzw49a7ncHxUXTtG/h5LQ==
X-Received: by 2002:a17:902:d4c5:b0:20e:552c:5408 with SMTP id d9443c01a7336-211835cc3ffmr243543955ad.51.1731435247521;
        Tue, 12 Nov 2024 10:14:07 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e6a388sm96639035ad.245.2024.11.12.10.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 10:14:07 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	kuba@kernel.org,
	mkarsten@uwaterloo.ca,
	Joe Damato <jdamato@fastly.com>,
	stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net 1/2] netdev-genl: Hold rcu_read_lock in napi_get
Date: Tue, 12 Nov 2024 18:13:58 +0000
Message-Id: <20241112181401.9689-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241112181401.9689-1-jdamato@fastly.com>
References: <20241112181401.9689-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hold rcu_read_lock in netdev_nl_napi_get_doit, which calls napi_by_id
and is required to be called under rcu_read_lock.

Cc: stable@vger.kernel.org
Fixes: 27f91aaf49b3 ("netdev-genl: Add netlink framework functions for napi")
Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 net/core/netdev-genl.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 765ce7c9d73b..934c63a93524 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -216,6 +216,23 @@ netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
 	return -EMSGSIZE;
 }
 
+/* must be called under rcu_read_lock(), because napi_by_id requires it */
+static struct napi_struct *__do_napi_by_id(unsigned int napi_id,
+					   struct genl_info *info, int *err)
+{
+	struct napi_struct *napi;
+
+	napi = napi_by_id(napi_id);
+	if (napi) {
+		*err = 0;
+	} else {
+		NL_SET_BAD_ATTR(info->extack, info->attrs[NETDEV_A_NAPI_ID]);
+		*err = -ENOENT;
+	}
+
+	return napi;
+}
+
 int netdev_nl_napi_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct napi_struct *napi;
@@ -233,15 +250,13 @@ int netdev_nl_napi_get_doit(struct sk_buff *skb, struct genl_info *info)
 		return -ENOMEM;
 
 	rtnl_lock();
+	rcu_read_lock();
 
-	napi = napi_by_id(napi_id);
-	if (napi) {
+	napi = __do_napi_by_id(napi_id, info, &err);
+	if (!err)
 		err = netdev_nl_napi_fill_one(rsp, napi, info);
-	} else {
-		NL_SET_BAD_ATTR(info->extack, info->attrs[NETDEV_A_NAPI_ID]);
-		err = -ENOENT;
-	}
 
+	rcu_read_unlock();
 	rtnl_unlock();
 
 	if (err)
-- 
2.25.1


