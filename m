Return-Path: <stable+bounces-37956-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E5789F0D3
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 13:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20B62B23596
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 11:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC9D15CD70;
	Wed, 10 Apr 2024 11:28:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5797015CD57
	for <stable@vger.kernel.org>; Wed, 10 Apr 2024 11:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712748494; cv=none; b=CntNTqgirYVoe5m54fXFUscTzG8oi6rdASKsoIuY5PPceLPS4249I6IGtZMDoGBUJ29dELoLjFfWgMTeUulntv8wd+u9ShBp4YrlMHAeQgEdq8nx+LnCF7kVeIBc8rPk2FsmFnIU8NfL16HJ9qvUZuC6MUOOG0E3PDoBUGhrVa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712748494; c=relaxed/simple;
	bh=2nfpQFL3xl2xbkSMUNM+p1GIsL70O/XA1ROwhKlhUc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G/KuZFTd2RfYHoTgz8v08PYQol3opt/6uPk3AxCpqjy5VMib4YH9wvZBfArTXkMvUiDfV4d6otMCsuMOyItjEfWX1rufdzan9wDu8fBg4nlkNGQyalP6oLagSa4y2ji3VwHkXoJwOh2YawLOely3vPRGOu7509yx3stuYMkrMhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 1298C2F20236; Wed, 10 Apr 2024 11:28:05 +0000 (UTC)
X-Spam-Level: 
Received: from shell.ipa.basealt.ru (unknown [176.12.98.74])
	by air.basealt.ru (Postfix) with ESMTPSA id 615572F20242;
	Wed, 10 Apr 2024 11:28:03 +0000 (UTC)
From: Alexander Ofitserov <oficerovas@altlinux.org>
To: oficerovas@altlinux.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: David Howells <dhowells@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	lvc-project@linuxtesting.org,
	dutyrok@altlinux.org,
	kovalev@altlinux.org,
	stable@vger.kernel.org
Subject: [PATCH 0/4 5.10] rxrpc: Fix KASAN: slab-out-of-bounds Read in kernel_bind
Date: Wed, 10 Apr 2024 14:27:42 +0300
Message-ID: <20240410112747.2952012-1-oficerovas@altlinux.org>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This bug was found with syzkaller on Linux kernel v5.10.
This patch series fixes the bug.

Signed-off-by: Alexander Ofitserov <oficerovas@altlinux.org>
Cc: stable@vger.kernel.org

Xin Long (1):
  rxrpc: use udp tunnel APIs instead of open code in rxrpc_open_socket

David Howells (2):
  rxrpc: Fix missing dependency on NET_UDP_TUNNEL
  rxrpc: Enable IPv6 checksums on transport socket

Vadim Fedorenko (1):
  rxrpc: Fix dependency on IPv6 in udp tunnel config

 net/rxrpc/Kconfig        |  1 +
 net/rxrpc/local_object.c | 77 +++++++++++++++-------------------------
 2 files changed, 30 insertions(+), 48 deletions(-)

-- 
2.42.1


