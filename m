Return-Path: <stable+bounces-176758-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D199AB3D3F3
	for <lists+stable@lfdr.de>; Sun, 31 Aug 2025 16:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4EE43B4D33
	for <lists+stable@lfdr.de>; Sun, 31 Aug 2025 14:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD252236E9;
	Sun, 31 Aug 2025 14:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisle.com header.i=@aisle.com header.b="nyE345xQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CBF19755B
	for <stable@vger.kernel.org>; Sun, 31 Aug 2025 14:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756652188; cv=none; b=nCMq1x6tJrBPYJ+sIoA4BLtAqzHcBxt3guDYoIs9ueBnGO+WrHofLQpebgbps6QIEXyJS/Q7/wH3lSmK4C52roPJfAGHtvqcHuv4ELzfhKXtpWWNo+HgUt6VhqmgtBmg53+bPm18XT5e+y4FoYtUxbjj+oUDuL6WFcP5Mx5W3xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756652188; c=relaxed/simple;
	bh=EtfLYB6Ix1bHJE3YAm2Ocn1PZIurA8/YM1AS4zYQv1M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mLgGAhnjoHwbIvi8QHwG57J+BxIzD4WSCf+ajpYI2PPE/t2czoWZr0VHaSYcDM4vL4Vz2QkdH3JDiqpgdVs38i79lexccUh/9UNgJ7+fSqyVEjLrALKeSc+8Wm/YpK41kd6rM7OAt5ogFut6owHKRYweBo42V88eGPZSild0miE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisle.com; spf=pass smtp.mailfrom=aisle.com; dkim=pass (2048-bit key) header.d=aisle.com header.i=@aisle.com header.b=nyE345xQ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisle.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45b7e69570bso15260255e9.0
        for <stable@vger.kernel.org>; Sun, 31 Aug 2025 07:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aisle.com; s=google; t=1756652185; x=1757256985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M9KRu8Ru4f/F2B2xaN1VxeRY/x4K4WntI346qys4v6I=;
        b=nyE345xQLfwxPHvLxyJ3uhaokRhb893FhFR76s+U7p4mLAY4I5OWSvpK5zDJ6/EVfP
         tzQ6MCgHE9KLZZvrI47zmcKPW3yjyHkUrOKVLcUCWERAvgB3ExiQ/ub1m/Ih+YsGFG87
         HHYo7xbLycthPDd4z5aY667Nmp8vQi1TEmja88ZyHBFmmKhE65p7fayurx6kR0t+XLzD
         FlRsjTrVZmu/nr4dDRHCdaORvFMaeWOsAkzo6t0CF669L3iAfzZ87itVXyHo5Pdv7sMV
         j5qLgiB5JXTUWH4JsxHcaRo/tE2u86Pb1fnxU/ppbMjvcSOebkFpvp17S9B1kfoTmVH6
         KSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756652185; x=1757256985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M9KRu8Ru4f/F2B2xaN1VxeRY/x4K4WntI346qys4v6I=;
        b=nCg8w9b+FCg+B4ESGDvI3S05saENBcPvrYOZF7N3qBSYQ9Mgvu+/uMhBNrbeiIbW3V
         7/z3aRyFx8hP+CjY30IhDJ4Pg4/m3jIdcxRRb6TjwsBE96lpnd69tmB14ZH26wvwO1lf
         QuE6FVOpYY+O9B2ifYwE9mtSVGqK4S4oqhB7IFHj4UJOS48vn8RmaMl3TY6VCxFfydO+
         2OuDA3+pfQiP4v5NNi618NS1y1IvPbINej0Sr98jR+Nnjc2aKtoyz0jcqrqSsZI8L7si
         3I9chr4Fj5VD/9cwIj7eF0iwKxvj5hk5h4E1gGOqPdA/PWpFldSbag5PPyJlM7C+l2jn
         hGnw==
X-Forwarded-Encrypted: i=1; AJvYcCW7fiB4/TJGjXx4PipgiT7VvmTC7pDWzUqU/ltIwaVMJou9zxsfXv5F842v63s1HCd8JJQivwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOAFViVnGyjqVaiAmEXeGI6sWHY9dGZb2iXn9s/Zq+GyD4iQcH
	7U+uxNmQqH4LaGbUwS0QFFkSzGR7x0FDhmynKeQyK9DckD8DQJoVx77PTPGOC8oDQMc=
X-Gm-Gg: ASbGncsYci49yeDNYBIYKmPmnR960MDco4aOu9a4YHagGUXPuRKcXPqWxasjBiL2bLJ
	aLFLyMIXnUG8uU+vT2nMV4cT8BmCIBIGYt76r7Dl/ilQaKx1AGGgetH7khOCSGBn1EGYa6zl8L4
	B77VCq2aM2Uj2FChnyK1IDW+gXp5I86dP5eEt/roaH277hcaADdPtg8HuQcvxfgRvvBTDj29WYI
	jhNVnLigAmXxjBYEMjzlPxz5sD7kB1vl+eH8AMB3+MN9L8EJbwUeu+g7eJq1ueEXMySadVtT3Ie
	TaFdhpRvlgg7DvCx+8Se2ss1MgWMqppBl81WtXfyduNm41E+cOXdFlTNDS2KOBCmbNHFqjNcuPk
	UenyJ5S7prC/IlDZxuyl7PCtLC/7saPUZ4cvguwseh8w1+yQznYA2xvHuO8Q8stIoj9uFVgGvBy
	uiyYeMerf8jW8nNPf7cg==
X-Google-Smtp-Source: AGHT+IFECZm94cv0ABA94deFhM69SwEYykQaQ3t0S0Jj1eMYv2dW7N7j1CEH45wVfmQ9gpzQYScDYQ==
X-Received: by 2002:a05:600c:4715:b0:45b:43cc:e558 with SMTP id 5b1f17b1804b1-45b8558ad00mr38526875e9.35.1756652185412;
        Sun, 31 Aug 2025 07:56:25 -0700 (PDT)
Received: from localhost ([193.138.7.149])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3cf33fbb3ccsm11425183f8f.51.2025.08.31.07.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 07:56:24 -0700 (PDT)
From: Stanislav Fort <stanislav.fort@aisle.com>
X-Google-Original-From: Stanislav Fort <disclosure@aisle.com>
To: netdev@vger.kernel.org
Cc: Marek Lindner <marek.lindner@mailbox.org>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Sven Eckelmann <sven@narfation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org (moderated list:BATMAN ADVANCED),
	linux-kernel@vger.kernel.org (open list),
	disclosure@aisle.com,
	stable@vger.kernel.org
Subject: [PATCH net v2] batman-adv: fix OOB read/write in network-coding decode
Date: Sun, 31 Aug 2025 16:56:23 +0200
Message-Id: <20250831145623.63778-1-disclosure@aisle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

batadv_nc_skb_decode_packet() trusts coded_len and checks only against
skb->len. XOR starts at sizeof(struct batadv_unicast_packet), reducing
payload headroom, and the source skb length is not verified, allowing an
out-of-bounds read and a small out-of-bounds write.

Validate that coded_len fits within the payload area of both destination
and source sk_buffs before XORing.

Fixes: 2df5278b0267 ("batman-adv: network coding - receive coded packets and decode them")
Cc: stable@vger.kernel.org
Reported-by: Stanislav Fort <disclosure@aisle.com>
Signed-off-by: Stanislav Fort <disclosure@aisle.com>
---
 net/batman-adv/network-coding.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index 9f56308779cc..af97d077369f 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -1687,7 +1687,12 @@ batadv_nc_skb_decode_packet(struct batadv_priv *bat_priv, struct sk_buff *skb,
 
 	coding_len = ntohs(coded_packet_tmp.coded_len);
 
-	if (coding_len > skb->len)
+	/* ensure dst buffer is large enough (payload only) */
+	if (coding_len + h_size > skb->len)
+		return NULL;
+
+	/* ensure src buffer is large enough (payload only) */
+	if (coding_len + h_size > nc_packet->skb->len)
 		return NULL;
 
 	/* Here the magic is reversed:
-- 
2.39.3 (Apple Git-146)


