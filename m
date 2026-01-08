Return-Path: <stable+bounces-206305-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90878D03C3E
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 16:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 59F203000586
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 15:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062B83C1966;
	Thu,  8 Jan 2026 10:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b+NxPlX0"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25F548E8FF
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 10:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767868046; cv=none; b=gw9HxUmhSMrpf1h7KKfqLv95zck+iH4BeViLaRr2U1dAAgDKQa++nDROKt1XMIWI0P3cLl8NLLes0HHIsuZsRIKYgsyXY90Zhc9ZanF6sgJZpE8xXJ0LW8Hgk6cC6fI4jrxnwYlHWpw/XagKg3fwcIJrbLCOoSxU8n+sg4njtpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767868046; c=relaxed/simple;
	bh=gLupk7pkyhMRyVZ4jAeXCwK9ZKuelYKRs+8X67Kj6XU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Kj09P95kusb1vl4k7CBO3Bze0vhGTKoSzFJMyuXx3DMSc2dijQKgt++G78G3KrkVey7WzKv+OSCuj5OtY8g6h9jLInUfnbP2WJYJWOUbWlvrrczhXoauYfpAZ6aQS7BoADETrQA6wkIXMbiH9m0UKUOqaojjsy236FA6x46jw60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b+NxPlX0; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8b22ab98226so488470385a.2
        for <stable@vger.kernel.org>; Thu, 08 Jan 2026 02:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767868042; x=1768472842; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6ekxs297qQPFSvF26tF3NNktqGOevw+/kYcudT3GgYk=;
        b=b+NxPlX0nez344nBxeIMK9AQip5kAF9k1CVkI14daAtivMUEqFQb8ZLu/gMqbNfvGi
         mFUBUuqmgkcsDGHAHe3d4NeYi6hF8MK7tGmbouuP7lheQShghmwbWSYmdrXrls9JbwW8
         vkwIHVO+WC4KhfhV02F3t73hggAKVmbbrk28rJBN2Yx8xCDYUn/QCZe5eAv1KAO27Jcp
         TPBABlvCQruCzK9rBiX3kfNLaaQ8dd0vHjX/J49vVy9F54sLQElNi143Vkj3kIUSNn2z
         K9zZuidT149MyjZNadgUjk9KdVYYKJV+fitAQ0WAFN1Wvj/Cen7lu68X3qsPc0w1FeRf
         50ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767868042; x=1768472842;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6ekxs297qQPFSvF26tF3NNktqGOevw+/kYcudT3GgYk=;
        b=DiARhqgb2Z3sEUEfSzoCZwEPuyZW8ydJePN/feq+dtvcHu5+xaKMi9A7RDGkSx1tWx
         KuD5rV8wtp7lePG83FwKC2Wh82vd2GYh7Y3XwNqxfyD9U8wPerOZvOaw0+d60hAinyJm
         66h1KeU264kEQ7m8bwhNZMcXK+6AmFxt29REMgcrgL0BO89REUDAavqEQOca6GOkaXAE
         /u6bWxa9N+plc3oYlC+PkOXbLd1Asgwo7ccOyv+kPQsVLhGjYODRij8Yrp9hrV3Lw9S0
         lhrdo5Rc4a70oAioKKfMPMHrxd2AUzoM+3yucsouu3fhN1yp/S9FQX+b0MqyTkb9/w6w
         KJkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPJDkMHmRGWhlx3FEL5RjMMHNPAoSsF4eKjZNRbL+ZnTWhAG04V6hQFYgvTzDHpx9E2aSyGsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEpEwUpqKKDF2FjGsc/hEeMr5ykixCzLgGda3idIELTny4IX04
	bkV7TuQHy1w47uRxwykZv60pz3bIQuSJu8zbjPTUuN725e0D/TvIEKoQUMuwLkncIAwV5TofA39
	M96GxFi+B6Fk38g==
X-Google-Smtp-Source: AGHT+IEkRfWC/XeNlNnBAN+U28DwGlu/TP1KYx3zvViGsFM2019wehNzF7LuZKIttyiMh+1R4x5jip1jwcuKcA==
X-Received: from qkau19-n1.prod.google.com ([2002:a05:620a:a1d3:10b0:8b9:f221:4cbd])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:46ac:b0:8b2:6443:8401 with SMTP id af79cd13be357-8c38941924emr683726885a.76.1767867575563;
 Thu, 08 Jan 2026 02:19:35 -0800 (PST)
Date: Thu,  8 Jan 2026 10:19:27 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20260108101927.857582-1-edumazet@google.com>
Subject: [PATCH net] wifi: avoid kernel-infoleak from struct iw_point
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	syzbot+bfc7323743ca6dbcc3d3@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

struct iw_point has a 32bit hole on 64bit arches.

struct iw_point {
  void __user   *pointer;       /* Pointer to the data  (in user space) */
  __u16         length;         /* number of fields or size in bytes */
  __u16         flags;          /* Optional params */
};

Make sure to zero the structure to avoid dislosing 32bits of kernel data
to user space.

Fixes: 87de87d5e47f ("wext: Dispatch and handle compat ioctls entirely in net/wireless/wext.c")
Reported-by: syzbot+bfc7323743ca6dbcc3d3@syzkaller.appspotmail.com
https://lore.kernel.org/netdev/695f83f3.050a0220.1c677c.0392.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: stable@vger.kernel.org
---
 net/wireless/wext-core.c | 4 ++++
 net/wireless/wext-priv.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/net/wireless/wext-core.c b/net/wireless/wext-core.c
index c32a7c6903d53686bc5b51652a7c0574e7085659..7b8e94214b07224ffda4852d9e8a471a5fb18637 100644
--- a/net/wireless/wext-core.c
+++ b/net/wireless/wext-core.c
@@ -1101,6 +1101,10 @@ static int compat_standard_call(struct net_device	*dev,
 		return ioctl_standard_call(dev, iwr, cmd, info, handler);
 
 	iwp_compat = (struct compat_iw_point *) &iwr->u.data;
+
+	/* struct iw_point has a 32bit hole on 64bit arches. */
+	memset(&iwp, 0, sizeof(iwp));
+
 	iwp.pointer = compat_ptr(iwp_compat->pointer);
 	iwp.length = iwp_compat->length;
 	iwp.flags = iwp_compat->flags;
diff --git a/net/wireless/wext-priv.c b/net/wireless/wext-priv.c
index 674d426a9d24f9aab7657d1e8ecf342e3be87438..37d1147019c2baba3e3792bb98f098294cba00ec 100644
--- a/net/wireless/wext-priv.c
+++ b/net/wireless/wext-priv.c
@@ -228,6 +228,10 @@ int compat_private_call(struct net_device *dev, struct iwreq *iwr,
 		struct iw_point iwp;
 
 		iwp_compat = (struct compat_iw_point *) &iwr->u.data;
+
+		/* struct iw_point has a 32bit hole on 64bit arches. */
+		memset(&iwp, 0, sizeof(iwp));
+
 		iwp.pointer = compat_ptr(iwp_compat->pointer);
 		iwp.length = iwp_compat->length;
 		iwp.flags = iwp_compat->flags;
-- 
2.52.0.351.gbe84eed79e-goog


