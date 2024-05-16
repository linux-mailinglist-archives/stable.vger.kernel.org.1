Return-Path: <stable+bounces-45347-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4B98C7ECD
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 01:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E78C1F21B00
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 23:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7B3347C2;
	Thu, 16 May 2024 23:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjuXfima"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769D9364A1;
	Thu, 16 May 2024 23:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715900524; cv=none; b=G/Y98i0sYkro4sILzTnPx+Xa3H9VEIOFvL8MOjzb5HfabdEjrsO5uKA3vmw+dZHdawZo0BlkghzuQi/yChY/EceSYGUDRchzkdf8d7CSwKoe/l2k2iy0ty9P+TzUHexgtYPWZickCIWXXFCQqDrzGhTTXgpFCGXQ+hSs8Ayipfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715900524; c=relaxed/simple;
	bh=iEuDQdH18upda+wcw58ayJ3SNueoJjCjm3zRmYHrEZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VbUaGGfhr8zqCtwm0gV0yFQKRAktWp/97WZFYI2k/vmgbDJ0MqtUQeKZny3vSqv8WoYGfk7Qf0ZPRleUISVVGMUSL+3IvXSuxAY7sl1sdQz+9ZEKhMIuLq0rT716CN+PZlZLJZDMlkDYZ8qr1Bhc9dZcfqwm9QWpluZzuvrtHbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NjuXfima; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-43d2277d7e1so194071cf.1;
        Thu, 16 May 2024 16:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715900522; x=1716505322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4myetJaZyDCq7mB0edGrYeiKEVaIlqQXwpm6yOhHEkQ=;
        b=NjuXfimaaflvgl4qL4/e+qAx9aL7+8xG+Halwq4fDCMcUsG0w9mWCQfcR6imoJGw4O
         BEN5G/ZsbZ1QNi+HLKlacyhKfjr0xdEvddVNEPIhnXer46qqEKfd8y3bqzpCu94dnwad
         TT55G7K38jxyW/OcjEpeu7PlgyoJoA74AiP0OLaVFaEGdfZNCxGU2C/B7sRa2pUwLah/
         rZfjU+BB650Zvpw9zM24G/l1oe6100cDTCfk1VU2I5ck/sTBo9eWLWH7nNdBhm+ew/B0
         FEM9VvI7f3Sszgras74cZ2aqhYicbviHCEMd5OpEDXymRgnMBv1dyHge6dfwTPtgMkRw
         pr/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715900522; x=1716505322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4myetJaZyDCq7mB0edGrYeiKEVaIlqQXwpm6yOhHEkQ=;
        b=BrZvmQmpa8y+T1ye7QNjHganI9LqQ4p8zoo0XPi+tx4OfBgT9YRfUms1VEUgUazmkl
         /GHnvNanfjO82t5/Svw8xXkicdzfcjDd6qGpI8vRGuVYT+BhQNzckBiRoV+7jbRWq462
         Tn23K2gPR+TY6apuqBNV1lKrzoXXcKvJuyO+zU4ttfHwQf0G1XXZlTdwYFQ3Y10hcTbJ
         XhQYm2uMy1TRHfvgJ6j2R+lj4nDCoVmKLPEhu8jZTLX+W6PzLHU1I+UQ781oQp11zdBb
         O1E3i1yc8ubInTxfjYieMc45BioghAkbWY2YaIB1SBoAtzZ7NfIQPSm8Ca/SR3CEKchb
         bsSA==
X-Forwarded-Encrypted: i=1; AJvYcCUKjehDj53KGJV/NqtcxTGMiz9T+AdF7ITKDvBnFMDmK5RC+1sZTAIC6VVOt7aMlA89EaWbOPwR9AFpHNNAyN0Rm/+2GaDAFIp8RqKGGjv0HzcAVGZ8koSdbRKri8HeR7QLo95M
X-Gm-Message-State: AOJu0YzNpItBd5e9Zpcwasl3sn1J8QXu3ByXvltDkns3QZa0wX4hmRmq
	MuyA/KOaf5pj1VoCkurjtm+RZYIcfW9Az7PW+soAJ6VUzSuayP5QlEVQZQ==
X-Google-Smtp-Source: AGHT+IGfHKpYcb2fguv0tllO6HWmy7Kb/XPHzyF66R0iHQK5hZerYOAgXMaNL5ADhAbib+kAbZD/NQ==
X-Received: by 2002:a05:622a:1a8c:b0:43a:e730:3a23 with SMTP id d75a77b69052e-43dfdaa7e73mr185811911cf.3.1715900522116;
        Thu, 16 May 2024 16:02:02 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e251233c6sm47154851cf.84.2024.05.16.16.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 16:02:01 -0700 (PDT)
From: Doug Berger <opendmb@gmail.com>
To: stable@vger.kernel.org
Cc: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	bcm-kernel-feedback-list@broadcom.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH stable 5.4 0/3] net: bcmgenet: protect contended accesses
Date: Thu, 16 May 2024 16:01:48 -0700
Message-Id: <20240516230151.1031190-1-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some registers may be modified by parallel execution contexts and
require protections to prevent corruption.

A review of the driver revealed the need for these additional
protections.

Doug Berger (3):
  net: bcmgenet: synchronize EXT_RGMII_OOB_CTRL access
  net: bcmgenet: synchronize use of bcmgenet_set_rx_mode()
  net: bcmgenet: synchronize UMAC_CMD access

 drivers/net/ethernet/broadcom/genet/bcmgenet.c     | 14 +++++++++++++-
 drivers/net/ethernet/broadcom/genet/bcmgenet.h     |  2 ++
 drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c |  6 ++++++
 drivers/net/ethernet/broadcom/genet/bcmmii.c       |  4 ++++
 4 files changed, 25 insertions(+), 1 deletion(-)

-- 
These commits are dependent on the previously submitted:
[PATCH stable 5.4 0/2] net: bcmgenet: revisit MAC reset

2.34.1


