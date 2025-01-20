Return-Path: <stable+bounces-109541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C238DA16E1E
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 15:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0988B167B57
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 14:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0304E1E32A2;
	Mon, 20 Jan 2025 14:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DDTPnIkW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M+hRZsH4"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3964C1E1C36;
	Mon, 20 Jan 2025 14:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737382193; cv=none; b=KkeREmZ6ocaWw1tSf3qehM0YJpH5RNSPMPV6hK+519QtyfYUAKVwoHeczgxV2FuD6iH6jJ/+UADfcLkbpWNcgDBZwXZ7dxXS+BOnGLI/99ZjJt/559myWColEBYGY7RMvflhkPMv3qhI/ArhpMMLmMC6HfZ7zeFVgtNo51bMDWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737382193; c=relaxed/simple;
	bh=4TowvkvRbiAVPOGCLQc0sKWKWqyCjGB3/SgIaCCaVWE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kBJWEu/3dTraXOW++gBW7eGeV+Am4n4eg9eXTYdHwI+MNfDJqPjg0g5H426Z1IxJ/cwlLcvtM4Q7QHnTGJrByEfJuqCki8gJlYiBpHOU23QrNZyQN2GQmQCF+8NULcRV/oe1JDG5YZvBpcC+CTZyFfhBl+sZ98AQeAo1+I6cRi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DDTPnIkW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M+hRZsH4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737382190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kX2meOgTl/wMtGRVI7UGFPvrYs0QkRT7wU2WjRlK8hA=;
	b=DDTPnIkWMhYNr2Ba3OsgbWc25un2TjPhsnWLmGtAOPOQK50yEZi57Ov0phDLJd9xMTrKMv
	FIBK4/sSH6JVXiyqLi1SvFttJDYMnrBtn9ill7kO+jit5jE6AqLY+/8m5uLSvzbfW6bk/l
	0yZXFHwgsg+woQoeWg7V75oYOz7e2vYI4ULkYE8iMWqtD037tUwSOLwcVJjBhTFYuET6bw
	4W9sVkBjY7TvCgybTstlVzYHGjUZR9ACiXc12uuF7g+Pf+yt3k6gj6f/xguTUJ5qJx3/pr
	n9P4IaJ67AOglnpQf4TU2YtN3x+Gaqfe3xESreUReeOd7VQwtC3BSlAR8q9iuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737382190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kX2meOgTl/wMtGRVI7UGFPvrYs0QkRT7wU2WjRlK8hA=;
	b=M+hRZsH4asI5/f3+/HwBO5Jpm2m5OcXjQDFnMQHypqZ7g5WoPQBLgmmKef91KvWdlZdYFL
	boBLMRp2KtV4IABg==
Subject: [PATCH 0/2] of: address: Fix empty resource handling in
 __of_address_resource_bounds()
Date: Mon, 20 Jan 2025 15:09:39 +0100
Message-Id: <20250120-of-address-overflow-v1-0-dd68dbf47bce@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACNZjmcC/x3MQQqEMAxA0atI1gZqtY56FXFRbKqBwUoCKoh3t
 7h8i/9vUBImhaG4Qehg5bRlVGUB8+q3hZBDNlhjnamswRTRhyCkiukgif90ond982vr1nadg1z
 uQpGv7zpOz/MCkS68U2UAAAA=
X-Change-ID: 20250120-of-address-overflow-a59476362885
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>
Cc: Basharath Hussain Khaja <basharath@couthit.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 stable@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737382189; l=760;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=4TowvkvRbiAVPOGCLQc0sKWKWqyCjGB3/SgIaCCaVWE=;
 b=tNYeKxTbCBOyzeaWF8WRjLD71N1SQBKO5vDfA9ODvrUDfQxlOu0oEwTIauxRLm7dv6WuYZzQL
 pcGSCi5C9L5DljKKVbLRt+TZbL3vFjKcq9u6/QnrVTi8JJxopGg17Qo
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Also add a kunit testcase to make sure the function works correctly now
and doesn't regress in the future.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Thomas Weißschuh (2):
      of: address: Fix empty resource handling in __of_address_resource_bounds()
      of: address: Add kunit test for __of_address_resource_bounds()

 drivers/of/address.c    |  17 +++----
 drivers/of/of_private.h |   4 ++
 drivers/of/of_test.c    | 120 +++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 132 insertions(+), 9 deletions(-)
---
base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
change-id: 20250120-of-address-overflow-a59476362885

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


