Return-Path: <stable+bounces-206248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A462D01473
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 07:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4D9E30695FE
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 06:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D5633C50F;
	Thu,  8 Jan 2026 06:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BJFYyH23"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f228.google.com (mail-yw1-f228.google.com [209.85.128.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6F233D4E9
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 06:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767854612; cv=none; b=tWHOAjiOuWqyvZ/lE1gDn00lVIwlVhACr/OGIpOijEGx13wbfjNCNdDKDCBxxu9kterYbjZXrKylFwr/LQaDszTpo4xF2s9FLrJtW7wvBs31ePdKZpEiQtmQKggw9G/l/bQG296gAPf+h3vLxlyNWpJ0rMjTcujbtU+2+LC3NeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767854612; c=relaxed/simple;
	bh=LEZrTdpa9KGGKDcyEtrC6XpwXPdO9NdBvgi1GHEilzA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HL4MYZl+4YwVcS9oq86XevhJFalPv5yC79g7d4ykOHu7zmBTq9Yqxe3J7WC2H1+4ohjmO5Lfqp/RBjp6W8spy8jdnyjCXb1mEO9PzjLllJ1iQYQk+NXkjZ1TpleYTPwCwiu3Jkwy2ir/VJ8gdorrU2oDFeHagIxYOrGQ7m3Rvi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BJFYyH23; arc=none smtp.client-ip=209.85.128.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f228.google.com with SMTP id 00721157ae682-78e7ba9fc29so32840647b3.2
        for <stable@vger.kernel.org>; Wed, 07 Jan 2026 22:43:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767854602; x=1768459402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZuPSNWn+b82ZHyLskpPT7wonBtOCk8mr0NLWFqNBPY8=;
        b=lzw1BwnQFCOz964SJJApMPqhDhFbymxb7G5EGuEXfBWFg3UOag1ev4SlsOZ6WY1vLL
         /XZHc7T8tqVM5ud5/K3CwSoWnwtSwEfkaYF1yrAadJvQ34sfPM2WSroWe4QUWns9mY1t
         niMAiDhc9E8845vBVirGKLxLnBkjTiuEidr54c+rO1RMa0zjk2kl0hs1ExP5d3p8HC0+
         diBufQrbIu/n4nYQPqVmUo1SOv9ghtuJu1hvXfk4qhHk98TMosYOUTzHH/N/N9/9dAH0
         +JpN6WRTpEzx3tsJxfk6bkA2CkTsVenxjPrrQYYOtsfXdhuaL7lahz0t7YtjNs+yqmx7
         lXSA==
X-Gm-Message-State: AOJu0YxJq7k/VfAQBEesS2YKk+hOyGT3cO0TPVGcwyUq+szJAW0cp31F
	cTwhHr7nJjFoc7CZpZUGBpfGHWO9+Wv30PnxaIuBNcx71I506lH3Paj9SftMjqMnjOaWl5/56m3
	v47n636aDX9Ea2AQ8Ot7UMUy2jnog0k3tOsXXkwclpYNHnBTsf2qw6nrp6HwcV6NzISng4diAOM
	idY3P4zxSF6NEhv46lSTIerhjS9SLkWgaSZ7W13HjvlhXagH7S3cY0JdbwOFAqmVdYyAPradZM+
	UjY5d0uaPhB8Sw=
X-Gm-Gg: AY/fxX7OVYKVKw13DXO2LAhYJK1GcqD5LfkMQvYr9uuQpQpqX1qRxBngKWrVMpISun2
	xn+/Z1mcUrD7uuznLLdZxZTdU7+p+RZgnpD6UDIlW4eR0rl0NaSV6hwWTddZG7J7jyfn3xlLylM
	jp9VbxzzqPIsyL2IamUDt5gOcEl5iegvx0WHbIhbVJAcMRlgYuRlIIUZGYZ0NT4jGrRikJEfqWw
	0OOO1eEOnYeqvgXclY9n1P10LeCyxgtC24IlGwJ0EXA/Nb/raSKluE75V6BWW09Vb3/A4VFa9xP
	/CjuDUOsCjwfamPC4zJHfiDJL2VQl9KKQQpvvjp4MKQHNN03TOO9qJL/JXboH8U8vUhr/vr1Ei9
	Z8rgzvEbaz1TGjIPBJaBQsXbhpaDGzQqUIYxWL8LnWDISkyNmf4KEl91uJdCcHxO/BDVUY5Yn6i
	XNx3uIlC1kLtz3cKgvLiVbWSdBi6tQ+QjY4c4FPTPCx6auzQ==
X-Google-Smtp-Source: AGHT+IF/dV8VS1No1r+QK7iZPZ6GyRkthiSwkVQMKoHiN8UEagdAXIq0mBEM09v0CxsiuuQxwVGYWFFBkGFH
X-Received: by 2002:a05:690c:3608:b0:78f:afb1:8ca8 with SMTP id 00721157ae682-790b55d312cmr48595227b3.16.1767854601537;
        Wed, 07 Jan 2026 22:43:21 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-1.dlp.protect.broadcom.com. [144.49.247.1])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-790aa703534sm5389277b3.29.2026.01.07.22.43.21
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Jan 2026 22:43:21 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2b1766192e6so1952459eec.1
        for <stable@vger.kernel.org>; Wed, 07 Jan 2026 22:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767854600; x=1768459400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZuPSNWn+b82ZHyLskpPT7wonBtOCk8mr0NLWFqNBPY8=;
        b=BJFYyH23L3rmEw/uPAB9akE38fdhK48K3zT33K1irTKDuYmHNSROBBMWvjVLH2qd+j
         CNbnhwbqHloRBFSwRcvTuqnXd1esJ0JAPZ6S8GsGEmP4js8WVX5z6Dc+xERgEDDQ1y3M
         57K1AYD1aYWKYC+EzhfvW87cUszHQV4Fa6mck=
X-Received: by 2002:a05:7022:2217:b0:11d:f44d:34db with SMTP id a92af1059eb24-121f8b8dc49mr4004002c88.35.1767854600072;
        Wed, 07 Jan 2026 22:43:20 -0800 (PST)
X-Received: by 2002:a05:7022:2217:b0:11d:f44d:34db with SMTP id a92af1059eb24-121f8b8dc49mr4003977c88.35.1767854599427;
        Wed, 07 Jan 2026 22:43:19 -0800 (PST)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f243421esm13193731c88.2.2026.01.07.22.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 22:43:19 -0800 (PST)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: lduncan@suse.com,
	cleech@redhat.com,
	michael.christie@oracle.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	open-iscsi@googlegroups.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH 0/2 v5.10] Fix CVE-2023-52975
Date: Wed,  7 Jan 2026 22:22:20 -0800
Message-Id: <20260108062222.670715-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Fix CVE-2023-52975 by backporting the required upstream commit
6f1d64b13097. This commit depends on a1f3486b3b09, so both patches
have been backported to the v5.10 kernel.

Mike Christie (2):
  scsi: iscsi: Move pool freeing
  scsi: iscsi_tcp: Fix UAF during logout when accessing the shost
    ipaddress

 drivers/scsi/iscsi_tcp.c | 11 +++++++++--
 drivers/scsi/libiscsi.c  | 39 +++++++++++++++++++++++++++++++--------
 include/scsi/libiscsi.h  |  2 ++
 3 files changed, 42 insertions(+), 10 deletions(-)

-- 
2.43.7


