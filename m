Return-Path: <stable+bounces-188874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA358BF9DD5
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 05:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5CE8188CFAA
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 03:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789B72D1F40;
	Wed, 22 Oct 2025 03:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dhj491uD"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DEB19DFA2
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 03:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761104634; cv=none; b=rsbnIK9DvZpzyoMNkdvLwjm1A9XyMsVEHSXZCjfbYj5EGbJPS0czfk3t7qO2GuDCdmxjNP9haxtrd5ZBnE7pp4CfvLSq/K+YEx8DNT0/WDysqxiATV2ZSuhttJJbrYCPngfV9g8r8umdQTXjGMtlEYzj/qf/sz0j29P8d9CIseU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761104634; c=relaxed/simple;
	bh=dg6Xeh8W9jYy+DaZHQ+BRa/bMuMWs5I/8dF5W8zJ63o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RNgxOt7ocnwNZc/vlY2eenfVO2Z0K7An6xLnG4hN0FyBA8n3EjjBMXzrBf7KUt/GTDHBi+gfUCT0pmPQj/ukzrMtXHJSgXi6N25cTCXNLBJrfLCHUggu1by8S5SdK6BfBho/EwoqxDSIi5IiPg/V/1zCBP8tz/js8NNBSMg0Bxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dhj491uD; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b3e7cc84b82so1225234966b.0
        for <stable@vger.kernel.org>; Tue, 21 Oct 2025 20:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761104631; x=1761709431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vTRF+HmDl+bAL0OAwMRSISeP2Yi5Xj/P9MCjPmh9ndU=;
        b=Dhj491uDf6GgM98QDG4rMrgqFm6Y58n8M6FCBBSlbDeNKpHfWParpleNOIW63VzvJU
         OoQbFPtQRX1HkjZFuLqUjICVnSAuGdRG0ltM+9eO4K1c9C4frsmiRF7u1dhx9CpID9AH
         PRhsQQOuGxQeexv3lbX9lkJS0BCLokA3/542To6uNd/Vww6dXvxe5t843vjvU5ezjxY0
         OZptqPdPp22XHpCigZDNaKCekDu54tRgd2SAGr0F0feHl3jT5sZWrUzZg/+oyblcJWdS
         CvR2ELCxwntRh2NEn0qIzuB8D8pAqSTV204DdPIXvMmvTYVl5K2anL6YCw4+tyEdRCl4
         wu1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761104631; x=1761709431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vTRF+HmDl+bAL0OAwMRSISeP2Yi5Xj/P9MCjPmh9ndU=;
        b=W2IZqUQ8v2dggdCDC/Mu+PS5XdztT4EK6qXdluw1FBe6hLOkbJMBidb/VtegSFG8gW
         qsZCqm9EbKdZJCHi0wtlq8/coOBKjv4O49uHQ6+WmzoLDaKHC4/TZTTaI2EYg4I4Qamk
         kaTDv4CQR8DPGnE8RJrObhs2slF7lE1i6hx+zJ7Ocyx0k5ch63ZP2ZDlIRRoaP3BgmfZ
         FCMKDH/8UqYnqmZlN1RRjbnknKftzdvGj9KVv33WnA9CnH1YmrzUwNUThah1HCVtbPcN
         YaKMVtrDm35pWCwRlTpDDEWq3RwUIAqI3MvLwLLPmu3kRiZnUiZK09Znj1UltzVohmar
         CprA==
X-Forwarded-Encrypted: i=1; AJvYcCVZDngI2DMKCThnmFj7AN2GD76V+S1wHTQ5K+0MTWjQkNKWUuj5HuABKGpJNFDmTo2is15PAr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZqsEC4QGua1HPzDuuHOPfIBB5S/3VefOSdQp8wk++J40kAacj
	0JXTFNa4EfsPqzjdImPKxKmkvlRxurM6j6eMgL2L2uzQcOX5QSjUc7Fv
X-Gm-Gg: ASbGncvftHCmtleM+wtiygiBHXGMTkxtWT3e6OM+0sTTJvgK7Wqh4YeZXPkbJ3iXxdq
	KSfKiQLOj/rTHpHc0PhSzkeR3KIUAO2D6FuSUZWHzc1isoqG9bhfYOR/s5Y74ZU/BS9lcFPx0r2
	ZkrFTy3H7wskKkLPyQGWGVyaC/J8wfisTOOFaz6PiXB3FeUnI+yNpDCRfK+nBgoKs3aDUAGgzWr
	TE8wFg+ApMlONW72QhQkwE//iIp36piGFfgZJiHMOLWN8g+7uGA7jm49CWH9B+BBC6OVivtVly5
	ERTNYUU/3bAr0/x767rHyBQLg/0/VnqlWAWJB2+SacdU5rucBEUXqt6vNmueQukROf55JZUVnuE
	J1WuMYJ6R85Fva8kNTmlznNtmXshP1sK5QsZTWC9WjpKefJZiwvGgG1T5mU9kqF5i65hs6eeFGe
	acbQ==
X-Google-Smtp-Source: AGHT+IHPO7PWYa0DB82l3UyTHZGWH0MJm65SKGjGbpwKQ7i46gAfvnK/b0OSSMfiAZu596bNELN8nw==
X-Received: by 2002:a17:906:c103:b0:b3c:de0e:7091 with SMTP id a640c23a62f3a-b6472d5bb42mr2004845666b.8.1761104630850;
        Tue, 21 Oct 2025 20:43:50 -0700 (PDT)
Received: from archie.me ([103.124.138.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e8395c52sm1220593966b.30.2025.10.21.20.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 20:43:50 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 719D24236CE1; Wed, 22 Oct 2025 10:43:45 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Workflows <workflows@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Documentation: process: Also mention Sasha Levin as stable tree maintainer
Date: Wed, 22 Oct 2025 10:43:35 +0700
Message-ID: <20251022034336.22839-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1461; i=bagasdotme@gmail.com; h=from:subject; bh=dg6Xeh8W9jYy+DaZHQ+BRa/bMuMWs5I/8dF5W8zJ63o=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBk/gpqT5OacOPDC+KawRsOrkmu8Rx9v9XgcMJ0/bc1H9 ozpt+fv7yhlYRDjYpAVU2SZlMjXdHqXkciF9rWOMHNYmUCGMHBxCsBEWmYyMjyrXFyeoJDyazqj mLijOOeZ7xGZXoeiWr2TF1z4zvzmzAGG/8UupnIcE9laTvRv4g5s25PjYPPET+orvyjP2468Cvf zTAA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sasha has also maintaining stable branch in conjunction with Greg
since cb5d21946d2a2f ("MAINTAINERS: Add Sasha as a stable branch
maintainer"). Mention him in 2.Process.rst.

Cc: stable@vger.kernel.org
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/process/2.Process.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/process/2.Process.rst b/Documentation/process/2.Process.rst
index 8e63d171767db8..7bd41838a5464f 100644
--- a/Documentation/process/2.Process.rst
+++ b/Documentation/process/2.Process.rst
@@ -99,8 +99,10 @@ go out with a handful of known regressions, though, hopefully, none of them
 are serious.
 
 Once a stable release is made, its ongoing maintenance is passed off to the
-"stable team," currently Greg Kroah-Hartman. The stable team will release
-occasional updates to the stable release using the 9.x.y numbering scheme.
+"stable team," currently consists of Greg Kroah-Hartman and Sasha Levin. The
+stable team will release occasional updates to the stable release using the
+9.x.y numbering scheme.
+
 To be considered for an update release, a patch must (1) fix a significant
 bug, and (2) already be merged into the mainline for the next development
 kernel. Kernels will typically receive stable updates for a little more

base-commit: 0aa760051f4eb3d3bcd812125557bd09629a71e8
-- 
An old man doll... just what I always wanted! - Clara


