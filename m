Return-Path: <stable+bounces-116439-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E68A3650A
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 18:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B9D316F100
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 17:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C203267AEF;
	Fri, 14 Feb 2025 17:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T3d5CeLC"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824B22686BB
	for <stable@vger.kernel.org>; Fri, 14 Feb 2025 17:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739555676; cv=none; b=e7HlYAeTDOnsw+2CS/+X4yfQhh7z6sdSdFmm3y+dTI3n9vZ+jor5keAyMHxJacY6CZiBtL0GgS7S5cOFOlxu0wR0al8Kir9HtvhWCLl6YdKUDsvxvZnvkZ+ZUqOIAahI+crxwEhQcJzAzq5AjxTBoUU84NEO/Wyjfzv2olpY9qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739555676; c=relaxed/simple;
	bh=0NIzgQok6PSWFbh/u3YursTnwlUVbXWMBKiaSFVSTnA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=k7z18ZXenN4tBqhy59F02ie30mlvMT2FLb1AfVnoGvqpM+cDHTLV++UdLxcNukeT/hllqzOX/wUEBVnwCB2dYN820TE0CRmJd/xZNmi25NsyZIZRthVPh0L9wIvTiv4WZZWYBH3eeVruOXJP5Vb16hdXsJPW0B4SX1jTHx1Qsho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T3d5CeLC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739555672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0ekSdNmJwX/IXB8StftdQm+2gjPPsti3V/eZBzC8c5U=;
	b=T3d5CeLCdrB7pzl4/vYVU+650DL+/B0m9jcHDqWRXdj7yzAABWYQtI6/QWv3fAoGOGSK1J
	tHpzrnQ39nvtmQrw6nhokfK5hzJfuQsB0mH9VKLqU5WtoRNY0vsH7lJxDSAzjAlXBeOrp+
	Z+0cnr/Fsb4qhJOWZZYD7rOrbzvbkik=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-YJxawGMyOoCUt-sfdAgKNg-1; Fri, 14 Feb 2025 12:54:30 -0500
X-MC-Unique: YJxawGMyOoCUt-sfdAgKNg-1
X-Mimecast-MFC-AGG-ID: YJxawGMyOoCUt-sfdAgKNg_1739555670
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4395b5d6f8fso12917435e9.0
        for <stable@vger.kernel.org>; Fri, 14 Feb 2025 09:54:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739555669; x=1740160469;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ekSdNmJwX/IXB8StftdQm+2gjPPsti3V/eZBzC8c5U=;
        b=HccKsttEj01bPcMjrDMQwnhfvvpTUE9DR//8l8iuYBdfpoRtm25VD+t0fD4rCOWUcd
         Sr5SGjQNfhap6RM2WiEsZM/gCVb5l4sWmvBfsSid87ZeBsmGbiIn5d+XZdwU+eg1L7b0
         VzUpcYJl0TVdPMUFAD4jogczd9Q/A+44eqq5wWW0rqR6l71okgca/VI9XUw+Et/Czxd0
         tk5p7xuyfKA8LNtnYADUXrAZs6nWXWNI4AgjQAv7Uep5cPl7x1dZvq6ObZSdLRxOVPYe
         z7d7bBjZQrAobuCWBJqKlceT30qOA6Tg6hOc3AD6y7wSmq5Bcgs7l77FWhgTLRSLJaME
         dlXw==
X-Forwarded-Encrypted: i=1; AJvYcCW4gs8tmH0QGhHx/6c2hgStqgaYr11ryu2VgiW4eITr3wUggbkLZ5O3Ok1fPz9DkLWCdO6+kzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpC0GMU3dZwpYXtrVDJK1Pl1emD+Rrsc48k2sbwUmhBxZJGdck
	gydJBQ99bGtHfhjf8482rrsx1AYITeAVOq+0eGcOqS5wWG7NzKE6obXYWL0is+LBJsyeKRxKvKD
	KuEN4Dh1yK5eBy9eXc3HZQKgyNVBzFM9MC0GvHaLLcf8PdyrdwlhcuA==
X-Gm-Gg: ASbGncsrfLPvQiD/G59p5XMxN0vti/1EXTxfaTBHpJhuw2nXsTF9Hr67YPV+87UM69v
	4jot1gtqQOqioqbVjE6L3nWWeCaQ8Z07OU6LcBnwanS2EuBT4o7E+WEv5SfEqGzQ5SivjFZWUQE
	poONu5gMHKYSlpfjGZBjvem02FEZGb0QonPKysZNJPU+86uZPIA7igtgvj91+ViR08KUuXLXIOM
	y9+/2uhx05aiV8IZwXTKfOrV62/3ipLPIbhprpj+lwy5SDy127/ogFg6EZVBqfVzU/ArtKgfeV4
	Tbzsnk08DJuy6sRIsHGlTBJvoOHAWwM8+vo=
X-Received: by 2002:a05:6000:1849:b0:38a:418e:21c7 with SMTP id ffacd0b85a97d-38f2451a543mr12169388f8f.53.1739555669463;
        Fri, 14 Feb 2025 09:54:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWJ5MbJYk1tAw3cOOLF2lopAEwd/qevfozxEraY3ZZN8zkYeR2VSsTOPaXmlAlK2crOr+NPg==
X-Received: by 2002:a05:6000:1849:b0:38a:418e:21c7 with SMTP id ffacd0b85a97d-38f2451a543mr12169362f8f.53.1739555669134;
        Fri, 14 Feb 2025 09:54:29 -0800 (PST)
Received: from lleonard-thinkpadp16vgen1.rmtit.csb ([176.206.32.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43961884e88sm49418365e9.26.2025.02.14.09.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 09:54:28 -0800 (PST)
From: Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH 0/2] vsock: fix use-after free and null-ptr-deref
Date: Fri, 14 Feb 2025 18:53:54 +0100
Message-Id: <20250214-linux-rolling-stable-v1-0-d39dc6251d2f@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADKDr2cC/x2MQQqAIBAAvxJ7bkGtKPpKdKh2qwXR0Aoh+nvSb
 eYw80DkIByhLx4IfEsU77LosoBln9zGKJQdjDKNMrpGK+5KGLzNsGE8p9kyUlutambqdEOQ0yP
 wKunfDuP7foYwpW1mAAAA
X-Change-ID: 20250214-linux-rolling-stable-d73f0bed815d
To: Stefano Garzarella <sgarzare@redhat.com>, Michal Luczaj <mhal@rbox.co>, 
 stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, 
 syzbot+9d55b199192a4be7d02c@syzkaller.appspotmail.com, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.2

Hi all,

This series contains two patches that are already available upstream:

- The first commit fixes a use-after-free[1], but introduced a 
null-ptr-deref[2].
- The second commit fixes it. [3]

I suggested waiting for both of them to be merged upstream and then 
applying them togheter to stable[4].

It should be applied to:
- 6.13.y
- 6.12.y
- 6.6.y

I will send another series for
- 6.1.y
- 5.15.y
- 5.10.y

because of conflicts.

[1]https://lore.kernel.org/all/20250128-vsock-transport-vs-autobind-v3-0-1cf57065b770@rbox.co/
[2]https://lore.kernel.org/all/67a09300.050a0220.d7c5a.008b.GAE@google.com/
[3]https://lore.kernel.org/all/20250210-vsock-linger-nullderef-v3-0-ef6244d02b54@rbox.co/
[4]https://lore.kernel.org/all/2025020644-unwitting-scary-3c0d@gregkh/

Thanks,
Luigi

---
Michal Luczaj (2):
      vsock: Keep the binding until socket destruction
      vsock: Orphan socket after transport release

 net/vmw_vsock/af_vsock.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)
---
base-commit: a1856aaa2ca74c88751f7d255dfa0c8c50fcc1ca
change-id: 20250214-linux-rolling-stable-d73f0bed815d

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>


