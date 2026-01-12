Return-Path: <stable+bounces-208045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC83D10BFF
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 07:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EB8F30AB2E5
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 06:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6D631985D;
	Mon, 12 Jan 2026 06:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TCIbV5o+"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEA23195FD
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 06:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768200541; cv=none; b=JLGPOOhHNg4pF4pNQKpPl9ST0CR5ToV1waUHEXj339C3F3MYovIi4UE6lyze6eCp2hzQoxQRBR6N9M4OjetCECKPyT9gQxC0ZALlIIu/iwCyPiNwsC51hPYvHbOKCmZzh8v42xljlU+YqDREZilvyVjyxRPQdnWIWHa4mnXLdFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768200541; c=relaxed/simple;
	bh=PORkVXvg63BpdFWitYBmyQs8mKiAi/bQ6d/kl3dALsU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aGeB+JwfIKCHVP4jAkiAMRDvVjBE5hQdtQhACF+Nte16UZJOBlm89fD2JRGz+52WO7mVMGcR3TOOlq1dLEgLyY9Zu4Cqbvk7LGiyZVc3N0zxezArDKOvrP8qK2Ky/z6K6UiZ+rJtNQDSEvqA6NLvy2vm6BpFjS2iADARkJqS6RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TCIbV5o+; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-88a2ce041b2so7175326d6.0
        for <stable@vger.kernel.org>; Sun, 11 Jan 2026 22:48:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768200539; x=1768805339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u5BtvNEFgqWL2yj8vB56uvRZyhnBjlOJonajbEim00g=;
        b=WOaapZP+GLsOAFqmp0mWkNeIiEeVQc+llgWeaI+bIO12lh6pFOauzVokfOk11cRqlA
         JsucQUzHKmkb96bOzrJdb/FHKiP8bzsAGtAAyG+IHD30qk+ULv+zuGcvkx5xdG4IBOxS
         WFvPoVtfLLtYJydBlhBjlWvAJUSPev+KHCrR5Du/BMWJoZg+wSI/WFEmKLh98U9kERD1
         AgB64dk1g2Agj7OO3xnz1tAfemeNNCVS3vy5dlZKjwwteDiYdezNQPW7ObrpW90fNgSh
         thEfo/VtzDdDM6EwRK1MRnUNnkmoB+6bD63xZHCQfjXJ7bDXXqL2WqrJ+ngwBUbOJa7I
         /5zw==
X-Gm-Message-State: AOJu0YwIfpMFeNg6NyK09up4Vkgl5cnt589ug5PxLw6xDvHreLgaao8K
	b49KpxXunXNMBmAnvWaQYCgoftj17+3njZncwqtLrDwaevHlTmCu1hps8vXr1Um4vn0/VwtHzRD
	BcPPvRGzDc74rM2iaJ88wok8eZyRJaYT51LJmuuyJPcx7lCT+iGNa+q0qUyjqI9OJK9Tmy4Ae1M
	OTs7Qhf3bRlchlUNGGgXbpNI4cd7LVUF+pzIt/eAPuAJUoqnYmgz8DlrrYSCQYJky5rrWQJ055e
	4TLglQiuczuKJQd5TpZr2EB3fuVJzY=
X-Gm-Gg: AY/fxX7ktgYTrOU2THRoCpJOvQ3jq6p97lieoyNXC1Ums6wcljKeizCIha/RTI0mWuk
	ulTub2+6u8VIkmSqI8irtW0p7+uqPuQwOQMF9rn76yi+RVE7kD29bP1FtqBb/sPjK/pbdSiW6s4
	Fo/q1ECpOhJBRjw45P8LSPQLNMJGTE4Zn3AI2C3C70BwX8oLz2LIjouw1lIj9F9oq701lSnOneJ
	GFJzgmdh8oqWffa4tNUjB+cQebkYWSbDheC8PeWetoJe30lGSg3hDaHXtGUMGXB7ddY2rOLAPaB
	bS82yCRk699cbrJm6EBOBADze0SWiJOViIgdIE9agwRw0wBE9+5gz3+kgxFk5kKBBQpQ9SzOZSO
	7xCb73yJC0rSYqz19SzWoK0cZ2YAuFMyVA0BQOU4sUUja47x8ydZdpiOazhAbfjr5C4d5kEZidi
	ar10doHFnCauDXsQElrYry80bjgxIr4RGKtFN1BV2pLL8oQ5+vCZ4NzHVEGgo=
X-Google-Smtp-Source: AGHT+IGcmjM/W1q9Zk2dEACku70tgeM+t6kn/IIBYA7varg83PC3njilkxMDAPmLA0cPiDgCpMUtfTnV92Zh
X-Received: by 2002:a05:6214:cce:b0:880:4954:6af5 with SMTP id 6a1803df08f44-890842fe77bmr206737576d6.7.1768200538704;
        Sun, 11 Jan 2026 22:48:58 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-890770a55bcsm21220496d6.10.2026.01.11.22.48.58
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Jan 2026 22:48:58 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4f1aba09639so16684381cf.0
        for <stable@vger.kernel.org>; Sun, 11 Jan 2026 22:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768200537; x=1768805337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u5BtvNEFgqWL2yj8vB56uvRZyhnBjlOJonajbEim00g=;
        b=TCIbV5o+ui8Szxs3PaHx240JMR8a6FA4i4yPwhh3UnxJsbVpiRelieF125D9PW+zqL
         OlhUsMv2SloUdfVuXD4ycE3rFGrjkIGLIQ0rL12+dH/Z6puFPEegSiw3bLvI8oy9k7Lb
         fy63YGyzk/gjyRzM4mzRH7zgsYsFp9Em+Cq00=
X-Received: by 2002:ac8:57d5:0:b0:4fc:989e:f776 with SMTP id d75a77b69052e-4ffb4861697mr202473901cf.4.1768200537640;
        Sun, 11 Jan 2026 22:48:57 -0800 (PST)
X-Received: by 2002:ac8:57d5:0:b0:4fc:989e:f776 with SMTP id d75a77b69052e-4ffb4861697mr202473711cf.4.1768200537162;
        Sun, 11 Jan 2026 22:48:57 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770e472csm131125426d6.23.2026.01.11.22.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 22:48:56 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v6.6.y 0/2] Backport fixes for CVE-2025-40149
Date: Mon, 12 Jan 2026 06:45:52 +0000
Message-ID: <20260112064554.2969656-1-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Following commit is a pre-requisite for the commit c65f27b9c
- 1dbf1d590 (net: Add locking to protect skb->dev access in ip_output)

Kuniyuki Iwashima (1):
  tls: Use __sk_dst_get() and dst_dev_rcu() in get_netdev_for_sock().

Sharath Chandra Vurukala (1):
  net: Add locking to protect skb->dev access in ip_output

 include/net/dst.h    | 12 ++++++++++++
 net/ipv4/ip_output.c | 17 ++++++++++++-----
 net/tls/tls_device.c | 17 ++++++++++-------
 3 files changed, 34 insertions(+), 12 deletions(-)

-- 
2.43.7


