Return-Path: <stable+bounces-19419-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8AB85063B
	for <lists+stable@lfdr.de>; Sat, 10 Feb 2024 21:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BA46B232A1
	for <lists+stable@lfdr.de>; Sat, 10 Feb 2024 20:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80565F84E;
	Sat, 10 Feb 2024 20:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LCHCdwfp"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA8F364BA
	for <stable@vger.kernel.org>; Sat, 10 Feb 2024 20:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707596112; cv=none; b=a7NyFt0tipHz1ITrtlUrah0ee8CHfySeTH3YzfR+axqRKzo3psGKEam/5dh1cmARzl3mKGgDHrLk8oCCS642MQnmr7pjKQtdIkeXx+Iifdd3W76jZl0cELe5vgBP4vOSBMb0ZS7TYWZgSkQdj9xPmdGKFbjwlHoYuFuvyqgtZqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707596112; c=relaxed/simple;
	bh=m/NXUc1VZ8Smj80YlAE3HAq4Zy6w/PpfniMxJeIy1FM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JfurD94aQHmkF+Cfi15oPcpxQQIjA0LCom3tVewyZP7wntX+MSWEbrKfo7yae8T3fouUJ6atHCQ1Rmzv8lKOTsPEVnNQHcA3JBeIvTQtSHqJJXUXK4QlAuLRZVWy8GxwKq5Wua+FQ9lhV3t0Q1/RVqF7aDYv5+Ju1YxFc0+mx08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LCHCdwfp; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-1d8da50bffaso10749285ad.2
        for <stable@vger.kernel.org>; Sat, 10 Feb 2024 12:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1707596108; x=1708200908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xbbr2A+bDrMBn7NKapXWZGiR9sSHrgSHnUCaZm45/X4=;
        b=LCHCdwfp9ZY1ISvGmPESXmRUGxZqehKoxE0bynJ0zx0J6FQ7yl+bxXmGK6dL0eJuL6
         z0XhPY7OIzaOGa4MTBkEKAOyxAUdaxwUGN51IfSX9h8iDvsKqX/h3DovGUdgcFuKDHjc
         DgbGlD3hnPLL/Gm8hZmTnElJ19GPcehpU8gP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707596108; x=1708200908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xbbr2A+bDrMBn7NKapXWZGiR9sSHrgSHnUCaZm45/X4=;
        b=JorFn5CUEbZi4Wt7rSwRmqLf7hTeE5/DBeiY6d+u+h+ZS/JPicWxMAA/5pOEq5s9Cz
         ErJuD/s9r4S7kGL8OkmoqLhuW7co3cLWutiZjLlNZ6ZrXqZynfbD1BSsdt2hOGj9OkKn
         9/jCsSIYQy72ZTvRYTHQippX3hqnPBWPUz8giczFECKYLXqRXu3+vcQrFxl8QG4PMDTK
         WyHoe84NuBhzZb4WmOPoCV/83lRdd2vVr/j31rLdW9+AMQ7qcxoBtYGl/pIkhB78DYHj
         rClsFbUd1k5sGuKQP58i1H9eordR7hMr9VjjOXKKkxQzjj8J3cCgamIfYG4bNUDTXOF4
         zy6g==
X-Gm-Message-State: AOJu0Yxktk4EgQ1Q6w/mTo1lhEOFzhYKxF3FAngi4Z5qnVAAOx1NFV6y
	x/t7+z3mPaCX4sUD9DaGimW+C7DDU1XWslPW7wOLZNk18bzWHt7jdrjVnTUpJ+HHkZ0M9FbBEfj
	YyuqlvWkBUki6aqiYgORNGQSDUfI9r+5/nPFwmefHCn7qeIKNf6oN3u10UFVBy4P608pnOw23oX
	/DPquaUHpOOpkzrnLbpUUbOQaooOsFKeu0Nnv+TlgkPN3RfEdAvuDyrtZXZw==
X-Google-Smtp-Source: AGHT+IFStWWdW6cr6XNqVfToFDgphunjsemCEP1FxPcZxO8olLnrP5VdlDybSerUhyF7EbYCFlBYLA==
X-Received: by 2002:a17:903:40c1:b0:1d9:5d56:9f1f with SMTP id t1-20020a17090340c100b001d95d569f1fmr3026214pld.24.1707596107986;
        Sat, 10 Feb 2024 12:15:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWCvz89UP5AFzvh/icQrtQ9oZJszK2AY4/H3IQYHat8X1LEiAHX1CArvoCplJcTDGIJjKgPmNK6zi1lj4dyDaBo2BZqhUs4W/t39CWOUScFT9no/2qdUXbnUHkuCi8bLFTiXNR0
Received: from bguruswamy-virtual-machine.eng.vmware.com ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id kd5-20020a17090313c500b001d944e8f0fdsm3424767plb.32.2024.02.10.12.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 12:15:07 -0800 (PST)
From: Guruswamy Basavaiah <guruswamy.basavaiah@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: ajay.kaher@broadcom.com,
	tapas.kundu@broadcom.com
Subject: [PATCH 5.10.y 0/3] Backport Fixes to 5.10.y
Date: Sun, 11 Feb 2024 01:44:45 +0530
Message-Id: <20240210201445.3089482-4-guruswamy.basavaiah@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240210201445.3089482-1-guruswamy.basavaiah@broadcom.com>
References: <20240210201445.3089482-1-guruswamy.basavaiah@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here are the three backported patches aimed at addressing a potential
crash and an actual crash.

Patch 1 Fix potential OOB access in receive_encrypted_standard() if
server returned a large shdr->NextCommand in cifs.

Patch 2 fix validate offsets and lengths before dereferencing create
contexts in smb2_parse_contexts().

Patch 3 fix issue in patch 2.

The original patches were authored by Paulo Alcantara <pc@manguebit.com>.
Original Patches:
1. eec04ea11969 ("smb: client: fix OOB in receive_encrypted_standard()")
2. af1689a9b770 ("smb: client: fix potential OOBs in smb2_parse_contexts()")
3. 76025cc2285d ("smb: client: fix parsing of SMB3.1.1 POSIX create context")

Please review and consider applying these patches.

https://lore.kernel.org/all/2023121834-semisoft-snarl-49ad@gregkh/

fs/cifs/smb2ops.c   |  4 +++-
fs/cifs/smb2pdu.c   | 93 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------
fs/cifs/smb2proto.h | 12 +++++++-----
3 files changed, 66 insertions(+), 43 deletions(-)

