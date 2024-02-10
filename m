Return-Path: <stable+bounces-19415-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E83850637
	for <lists+stable@lfdr.de>; Sat, 10 Feb 2024 21:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D0851F243EE
	for <lists+stable@lfdr.de>; Sat, 10 Feb 2024 20:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC83E5F852;
	Sat, 10 Feb 2024 20:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="B7RoXATt"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B220364BA
	for <stable@vger.kernel.org>; Sat, 10 Feb 2024 20:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707595988; cv=none; b=pe+qg9HScrsCCmXyJGib0ehDTgeu21N7j30fN9P7zd45G9y/mL1Pno9Zz8jvD3maED11L5B4yZJIiKX+YKPn5oEO0L/+WgsgsIkJ9G9BV6oib27BTkbVkEKvQFMyWYvVadu9zHio9/otdv3Wdx9DUUUGB+Qksw/ES58AaHMyQhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707595988; c=relaxed/simple;
	bh=m/NXUc1VZ8Smj80YlAE3HAq4Zy6w/PpfniMxJeIy1FM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DTLrRH85Eiz4zOxhFO6NDUx25FwJrre/maZc5C64hCw0YX7SPB+2D3WJs0lSMWe4JIC0LHymZuhS5s7zC7O1vjMQ9FIeD1plZj27Rr1k4lqCoBY/z6+ZykP6EyBhBHeO5goWUi9s11HP71zP9rU/yhviVcIme2viz4sKqL4IpTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=B7RoXATt; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so1659832a12.1
        for <stable@vger.kernel.org>; Sat, 10 Feb 2024 12:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1707595986; x=1708200786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xbbr2A+bDrMBn7NKapXWZGiR9sSHrgSHnUCaZm45/X4=;
        b=B7RoXATtaJb93KWPDJQLf8+gk0XxHRNJXv4/l9dG7DrJJY3LKhIORJimJ7z880cGy2
         kMcbQY9bRArWnCObjw8L0o9+JVjdHi1AhBHFSSDfkQYakMATDy3uW1Q2TmKq8CMcvYRN
         hfzOFUuD4WOV4p1DRGxZd6OwBvG5ewChutbGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707595986; x=1708200786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xbbr2A+bDrMBn7NKapXWZGiR9sSHrgSHnUCaZm45/X4=;
        b=F+3TPQXFdr+nuFfPQoaNxdStEPPzoy3diFe4OGACCF/G86+5ZV/d8Ns2vtH3bu44bU
         qGorl6Q9QgdWr8vObwHE3UC1MP7Vb14k5GfGdJFVquADE/Z9hVIcYMXe89Qo9PvW/Gt4
         Kp4lxfIAAq94geKaYexeLiSkS6R5kTzf+eTn1OPiRYWxzcKKuqEQll++Z4hfcuyLwb6q
         aSTJPC2SXqQYRt2iNQkq70pQC1W2bzbo5jnP05EUguoKXlOgRrYe0xNkBavYOK8MrvRY
         wKfebWy2y895Jr73mk/co1HZxHpNX2IiK6yot0laKciSs09vRgzT/5uqplMWhjTqle9M
         Nwzg==
X-Gm-Message-State: AOJu0Yyu2W2c22raaz4Q9o9rscS5sd0m3B3KkTXrZy7SKZaREm0P6aYo
	Q51dIElIIYzI9+0Bw84sUHUe6cY//jwS/UIhJpqXzLJYwydGZt4i1/CKb63aoHRhabsd6YFG85o
	BvGNrfUJDavW+2iWlBso+WnPIr/MdRvF7b+OQGMinnUN4A+nIBwFBRnj17CKD/ZbzvPKe3l79mO
	8C9EoUn2YmeJdbyMOs2WVBEM0kSU00IcODP2/Se60nWZYZ6jgFCDpMYV1bEA==
X-Google-Smtp-Source: AGHT+IHgnBh645pcjNup7Cz2TW8jGUp3Qwc+xDovIUoTIn8bxvrGbcJes/kak0Qb/N7Hj8obn0BOXg==
X-Received: by 2002:a17:902:7847:b0:1d8:8aba:4b07 with SMTP id e7-20020a170902784700b001d88aba4b07mr2947820pln.60.1707595985553;
        Sat, 10 Feb 2024 12:13:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWJ3BEniJ/UIywYuURcmSJzbY+us01/lhdzvVtgxj8GhiEEm8Xwu4Oi7Uw+BiptWaRGnx2kSqyStNLR6syZ7pYOEHXS3wKg9keKJpFgwpO9+U9bkjjZWHZuaqKnvSLCeD6yL1DR
Received: from bguruswamy-virtual-machine.eng.vmware.com ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id f6-20020a170902684600b001d8da07e447sm3503527pln.9.2024.02.10.12.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 12:13:04 -0800 (PST)
From: Guruswamy Basavaiah <guruswamy.basavaiah@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: ajay.kaher@broadcom.com,
	tapas.kundu@broadcom.com
Subject: [PATCH 5.15.y 0/3] Backport Fixes to 5.15.y
Date: Sun, 11 Feb 2024 01:42:37 +0530
Message-Id: <20240210201237.3089385-4-guruswamy.basavaiah@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240210201237.3089385-1-guruswamy.basavaiah@broadcom.com>
References: <20240210201237.3089385-1-guruswamy.basavaiah@broadcom.com>
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


